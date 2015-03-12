From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH v3 2/3] can: kvaser_usb: Utilize all possible tx URBs
Date: Thu, 12 Mar 2015 06:52:11 -0400
Message-ID: <20150312105211.GA21639@linux>
References: <20150226152011.GA6075@linux>
 <20150311173744.GA13095@linux>
 <20150311173902.GB13095@linux>
 <5500B958.2020101@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:37161 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbbCLKwP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Mar 2015 06:52:15 -0400
Content-Disposition: inline
In-Reply-To: <5500B958.2020101@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Olivier Sobrie <olivier@sobrie.be>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>, Linux-CAN <linux-can@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Mar 11, 2015 at 10:53:28PM +0100, Marc Kleine-Budde wrote:
> On 03/11/2015 06:39 PM, Ahmed S. Darwish wrote:
> > From: Ahmed S. Darwish <ahmed.darwish@valeo.com>
> > 
> > The driver currently limits the number of outstanding, not yet
> > ACKed, transfers to 16 URBs. Meanwhile, the Kvaser firmware
> > provides its actual max supported number of outstanding
> > transmissions in its reply to the CMD_GET_SOFTWARE_INFO message.
> > 
> > One example is the UsbCan-II HS/LS device which reports support
> > of up to 48 tx URBs instead of just 16, increasing the driver
> > throughput by two-fold and reducing the possibility of -ENOBUFs.
> > 
> > Dynamically set the max tx URBs value according to firmware
> > replies.
> > 
> > Signed-off-by: Ahmed S. Darwish <ahmed.darwish@valeo.com>
> > ---
> >  drivers/net/can/usb/kvaser_usb.c | 55 +++++++++++++++++++++++++++-------------
> >  1 file changed, 37 insertions(+), 18 deletions(-)
> > 
> > changelog-v3: No changes
> > 
> > diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
> > index e97a08c..30b4d47 100644
> > --- a/drivers/net/can/usb/kvaser_usb.c
> > +++ b/drivers/net/can/usb/kvaser_usb.c
> > @@ -25,7 +25,6 @@
> >  #include <linux/can/dev.h>
> >  #include <linux/can/error.h>
> >  
> > -#define MAX_TX_URBS			16
> >  #define MAX_RX_URBS			4
> >  #define START_TIMEOUT			1000 /* msecs */
> >  #define STOP_TIMEOUT			1000 /* msecs */
> > @@ -456,8 +455,13 @@ struct kvaser_usb {
> >  	struct usb_endpoint_descriptor *bulk_in, *bulk_out;
> >  	struct usb_anchor rx_submitted;
> >  
> > +	/* @max_tx_urbs: Firmware-reported maximum number of possible
> > +	 * outstanding transmissions on this specific Kvaser hardware. The
> > +	 * value is also used as a sentinel for marking free URB contexts.
> > +	 */
> >  	u32 fw_version;
> >  	unsigned int nchannels;
> > +	unsigned int max_tx_urbs;
> >  	enum kvaser_usb_family family;
> >  
> >  	bool rxinitdone;
> > @@ -470,7 +474,7 @@ struct kvaser_usb_net_priv {
> >  
> >  	spinlock_t tx_contexts_lock;
> >  	int active_tx_contexts;
> > -	struct kvaser_usb_tx_urb_context tx_contexts[MAX_TX_URBS];
> > +	struct kvaser_usb_tx_urb_context *tx_contexts;
> >  
> >  	struct usb_anchor tx_submitted;
> >  	struct completion start_comp, stop_comp;
> > @@ -657,9 +661,13 @@ static int kvaser_usb_get_software_info(struct kvaser_usb *dev)
> >  	switch (dev->family) {
> >  	case KVASER_LEAF:
> >  		dev->fw_version = le32_to_cpu(msg.u.leaf.softinfo.fw_version);
> > +		dev->max_tx_urbs =
> > +			le16_to_cpu(msg.u.leaf.softinfo.max_outstanding_tx);
> >  		break;
> >  	case KVASER_USBCAN:
> >  		dev->fw_version = le32_to_cpu(msg.u.usbcan.softinfo.fw_version);
> > +		dev->max_tx_urbs =
> > +			le16_to_cpu(msg.u.usbcan.softinfo.max_outstanding_tx);
> >  		break;
> >  	}
> >  
> > @@ -715,7 +723,7 @@ static void kvaser_usb_tx_acknowledge(const struct kvaser_usb *dev,
> >  
> >  	stats = &priv->netdev->stats;
> >  
> > -	context = &priv->tx_contexts[tid % MAX_TX_URBS];
> > +	context = &priv->tx_contexts[tid % dev->max_tx_urbs];
> >  
> >  	/* Sometimes the state change doesn't come after a bus-off event */
> >  	if (priv->can.restart_ms &&
> > @@ -744,7 +752,7 @@ static void kvaser_usb_tx_acknowledge(const struct kvaser_usb *dev,
> >  	spin_lock_irqsave(&priv->tx_contexts_lock, flags);
> >  
> >  	can_get_echo_skb(priv->netdev, context->echo_index);
> > -	context->echo_index = MAX_TX_URBS;
> > +	context->echo_index = dev->max_tx_urbs;
> >  	--priv->active_tx_contexts;
> >  	netif_wake_queue(priv->netdev);
> >  
> > @@ -1512,11 +1520,13 @@ error:
> >  
> >  static void kvaser_usb_reset_tx_urb_contexts(struct kvaser_usb_net_priv *priv)
> >  {
> > -	int i;
> > +	int i, max_tx_urbs;
> > +
> > +	max_tx_urbs = priv->dev->max_tx_urbs;
> >  
> >  	priv->active_tx_contexts = 0;
> > -	for (i = 0; i < MAX_TX_URBS; i++)
> > -		priv->tx_contexts[i].echo_index = MAX_TX_URBS;
> > +	for (i = 0; i < max_tx_urbs; i++)
> > +		priv->tx_contexts[i].echo_index = max_tx_urbs;
> >  }
> >  
> >  /* This method might sleep. Do not call it in the atomic context
> > @@ -1702,14 +1712,14 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
> >  		*msg_tx_can_flags |= MSG_FLAG_REMOTE_FRAME;
> >  
> >  	spin_lock_irqsave(&priv->tx_contexts_lock, flags);
> > -	for (i = 0; i < ARRAY_SIZE(priv->tx_contexts); i++) {
> > -		if (priv->tx_contexts[i].echo_index == MAX_TX_URBS) {
> > +	for (i = 0; i < dev->max_tx_urbs; i++) {
> > +		if (priv->tx_contexts[i].echo_index == dev->max_tx_urbs) {
> >  			context = &priv->tx_contexts[i];
> >  
> >  			context->echo_index = i;
> >  			can_put_echo_skb(skb, netdev, context->echo_index);
> >  			++priv->active_tx_contexts;
> > -			if (priv->active_tx_contexts >= MAX_TX_URBS)
> > +			if (priv->active_tx_contexts >= dev->max_tx_urbs)
> >  				netif_stop_queue(netdev);
> >  
> >  			break;
> > @@ -1743,7 +1753,7 @@ static netdev_tx_t kvaser_usb_start_xmit(struct sk_buff *skb,
> >  		spin_lock_irqsave(&priv->tx_contexts_lock, flags);
> >  
> >  		can_free_echo_skb(netdev, context->echo_index);
> > -		context->echo_index = MAX_TX_URBS;
> > +		context->echo_index = dev->max_tx_urbs;
> >  		--priv->active_tx_contexts;
> >  		netif_wake_queue(netdev);
> >  
> > @@ -1881,7 +1891,7 @@ static int kvaser_usb_init_one(struct usb_interface *intf,
> >  	if (err)
> >  		return err;
> >  
> > -	netdev = alloc_candev(sizeof(*priv), MAX_TX_URBS);
> > +	netdev = alloc_candev(sizeof(*priv), dev->max_tx_urbs);
> >  	if (!netdev) {
> >  		dev_err(&intf->dev, "Cannot alloc candev\n");
> >  		return -ENOMEM;
> > @@ -1889,6 +1899,13 @@ static int kvaser_usb_init_one(struct usb_interface *intf,
> >  
> >  	priv = netdev_priv(netdev);
> >  
> > +	priv->tx_contexts = kzalloc(dev->max_tx_urbs *
> > +				    sizeof(*priv->tx_contexts), GFP_KERNEL);
> > +	if (!priv->tx_contexts) {
> > +		free_candev(netdev);
> > +		return -ENOMEM;
> > +	}
> 
> I'm missing a free for the priv->tx_contexts. I see two options:
> 

Correct. Should not have missed that.

> 1) use devm_kzalloc(), or
> 2) move struct kvaser_usb_tx_urb_context tx_contexts[]; to the end of
>    struct kvaser_usb_net_priv, see [1] for an example.
> 
>    Without further testing, I think the correct alloc for that case
>    would be:
>        alloc_candev(sizeof(*priv + dev->max_tx_urbs *
>                sizeof(struct kvaser_usb_tx_urb_context))
> 

The first option looks better I guess. I'll have to check though
if the resource handling done by devm_kmalloc() will work even
if the probe() method fails with -ENODEV and the like...

> Marc
> 
> [1] http://stackoverflow.com/questions/2060974/dynamic-array-in-struct-c
> 

Thanks for the link. Didn't know that such a "hack" has gained
official status by C99 :-)

Regards,
Darwish
