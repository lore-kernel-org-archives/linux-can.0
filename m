From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 1/3] can: janz-ican3: fix support for
 CAN_RAW_RECV_OWN_MSGS
Date: Mon, 16 Jul 2012 09:00:46 -0700
Message-ID: <20120716160045.GB21769@ovro.caltech.edu>
References: <1342109732-4995-1-git-send-email-iws@ovro.caltech.edu>
 <1342109732-4995-2-git-send-email-iws@ovro.caltech.edu>
 <5003C2AD.5010009@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:34049 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab2GPQAu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Jul 2012 12:00:50 -0400
Content-Disposition: inline
In-Reply-To: <5003C2AD.5010009@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

On Mon, Jul 16, 2012 at 09:28:45AM +0200, Wolfgang Grandegger wrote:
> Hi Ira,
> 
> On 07/12/2012 06:15 PM, Ira W. Snyder wrote:
> > From: "Ira W. Snyder" <iws@ovro.caltech.edu>
> > 
> > The Janz VMOD-ICAN3 firmware does not support any sort of TX-done
> > notification or interrupt. The driver previously used the hardware
> > loopback to attempt to work around this deficiency, but this caused all
> > sockets to receive all messages, even if CAN_RAW_RECV_OWN_MSGS is off.
> > 
> > Using the new function ican3_cmp_echo_skb(), we can drop the loopback
> > messages and return the original skbs. This fixes the issues with
> > CAN_RAW_RECV_OWN_MSGS.
> > 
> > Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> 
> I'm fine with the device-specific handling of the special echo skb
> management. I have a few more comments to address... then you can add
> my: Acked-by: Wolfgang Grandegger <wg@grandegger.com>
> 
> 
> > ---
> > 
> > This is a simple merge of the code from the previously posted patch
> > series into the driver itself. This avoids changing the code for other
> > drivers which don't have the deficiencies of this hardware.
> > 
> >  drivers/net/can/janz-ican3.c |  169 +++++++++++++++++++++++++++++++++--------
> >  1 files changed, 136 insertions(+), 33 deletions(-)
> > 
> > diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
> > index 08c893c..0f48136 100644
> > --- a/drivers/net/can/janz-ican3.c
> > +++ b/drivers/net/can/janz-ican3.c
> > @@ -235,7 +235,6 @@ struct ican3_dev {
> >  
> >  	/* fast host interface */
> >  	unsigned int fastrx_start;
> > -	unsigned int fastrx_int;
> >  	unsigned int fastrx_num;
> >  	unsigned int fasttx_start;
> >  	unsigned int fasttx_num;
> > @@ -454,7 +453,6 @@ static void __devinit ican3_init_fast_host_interface(struct ican3_dev *mod)
> >  	/* save the start recv page */
> >  	mod->fastrx_start = mod->free_page;
> >  	mod->fastrx_num = 0;
> > -	mod->fastrx_int = 0;
> 
> Is this change related?
> 

No. It is unused code.

Do you want a separate patch to remove these two lines, separate from
the other patches?

> >  
> >  	/* build a single fast tohost queue descriptor */
> >  	memset(&desc, 0, sizeof(desc));
> > @@ -1091,6 +1089,107 @@ static void ican3_handle_message(struct ican3_dev *mod, struct ican3_msg *msg)
> >  }
> >  
> >  /*
> > + * The ican3 needs to store all echo skbs, and therefore cannot
> > + * use the generic infrastructure for this.
> > + */
> > +static void ican3_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
> > +			       unsigned int idx)
> > +{
> > +	struct can_priv *priv = netdev_priv(dev);
> > +
> > +	BUG_ON(idx >= priv->echo_skb_max);
> > +
> > +	if (!priv->echo_skb[idx]) {
> > +		struct sock *srcsk = skb->sk;
> > +
> > +		if (atomic_read(&skb->users) != 1) {
> > +			struct sk_buff *old_skb = skb;
> > +
> > +			skb = skb_clone(old_skb, GFP_ATOMIC);
> > +			kfree_skb(old_skb);
> > +			if (!skb)
> > +				return;
> > +		} else
> > +			skb_orphan(skb);
> > +
> > +		skb->sk = srcsk;
> > +
> > +		/* save this skb for tx interrupt echo handling */
> > +		priv->echo_skb[idx] = skb;
> > +	} else {
> > +		/* locking problem with netif_stop_queue() ?? */
> > +		netdev_err(dev, "%s: BUG! echo_skb is occupied!\n", __func__);
> > +		kfree_skb(skb);
> > +	}
> > +}
> > +
> > +static unsigned int ican3_get_echo_skb(struct net_device *dev, unsigned int idx)
> > +{
> > +	struct can_priv *priv = netdev_priv(dev);
> > +	struct sk_buff *skb = priv->echo_skb[idx];
> > +	struct can_frame *cf;
> > +	u8 dlc;
> > +
> > +	BUG_ON(idx >= priv->echo_skb_max);
> > +
> > +	if (!skb)
> > +		return 0;
> > +
> > +	priv->echo_skb[idx] = NULL;
> > +	cf = (struct can_frame *)skb->data;
> > +
> > +	/* check flag whether this packet has to be looped back */
> > +	if (!(dev->flags & IFF_ECHO) || skb->pkt_type != PACKET_LOOPBACK) {
> > +		kfree_skb(skb);
> > +		return 0;
> > +	}
> > +	/* make settings for echo to reduce code in irq context */
> 
> Is this comment still appropriate?
> 

I don't know. It is copied verbatim from drivers/net/can/dev.c's
can_put_echo_skb() function. You wrote that function. :)

I have no problem removing the comment, if you'd like.

> > +	skb->protocol = htons(ETH_P_CAN);
> > +	skb->pkt_type = PACKET_BROADCAST;
> > +	skb->ip_summed = CHECKSUM_UNNECESSARY;
> > +	skb->dev = dev;
> > +
> > +	dlc = cf->can_dlc;
> > +	netif_receive_skb(skb);
> > +
> > +	return dlc;
> > +}
> > +
> > +/*
> > + * Compare an skb with an existing echo skb
> > + *
> > + * This function will be used on devices which have a hardware loopback.
> > + * On these devices, this function can be used to compare a received skb
> > + * with the saved echo skbs so that the hardware echo skb can be dropped.
> > + *
> > + * Returns true if the skb's are identical, false otherwise.
> > + */
> > +static bool ican3_cmp_echo_skb(struct sk_buff *skb, struct net_device *dev,
> > +			       unsigned int idx)
> > +{
> > +	struct can_priv *priv = netdev_priv(dev);
> > +	struct can_frame *cf = (struct can_frame *)skb->data;
> > +
> > +	BUG_ON(idx >= priv->echo_skb_max);
> > +
> > +	if (priv->echo_skb[idx]) {
> > +		struct sk_buff *echo_skb = priv->echo_skb[idx];
> > +		struct can_frame *echo_cf = (struct can_frame *)echo_skb->data;
> > +
> > +		if (cf->can_id != echo_cf->can_id)
> > +			return false;
> > +
> > +		if (cf->can_dlc != echo_cf->can_dlc)
> > +			return false;
> > +
> > +		return memcmp(cf->data, echo_cf->data, cf->can_dlc) == 0;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +/*
> >   * Check that there is room in the TX ring to transmit another skb
> >   *
> >   * LOCKING: must hold mod->lock
> > @@ -1150,10 +1249,28 @@ static int ican3_recv_skb(struct ican3_dev *mod)
> >  	/* convert the ICAN3 frame into Linux CAN format */
> >  	ican3_to_can_frame(mod, &desc, cf);
> >  
> > -	/* receive the skb, update statistics */
> > -	netif_receive_skb(skb);
> > +	/*
> > +	 * If this is an ECHO frame received from the hardware loopback
> > +	 * feature, use the skb saved in the ECHO stack instead. This allows
> > +	 * the Linux CAN core to support CAN_RAW_RECV_OWN_MSGS correctly.
> > +	 *
> > +	 * Since this is a confirmation of a successfully transmitted packet
> > +	 * sent from this host, update the transmit statistics.
> > +	 *
> > +	 * Also, the netdevice queue needs to be allowed to send packets again.
> > +	 */
> > +	if (ican3_cmp_echo_skb(skb, ndev, 0)) {
> 
> I would prefer a more intuitive name, e.g. ican3_echo_skb_does_match().
> 

Ok.

> > +		stats->tx_packets++;
> > +		stats->tx_bytes += ican3_get_echo_skb(ndev, 0);
> > +		kfree_skb(skb);
> > +		netif_wake_queue(ndev);
> > +		goto err_noalloc;
> > +	}
> > +
> > +	/* update statistics, receive the skb */
> >  	stats->rx_packets++;
> >  	stats->rx_bytes += cf->can_dlc;
> > +	netif_receive_skb(skb);
> >  
> >  err_noalloc:
> >  	/* toggle the valid bit and return the descriptor to the ring */
> > @@ -1177,7 +1294,6 @@ static int ican3_napi(struct napi_struct *napi, int budget)
> >  {
> >  	struct ican3_dev *mod = container_of(napi, struct ican3_dev, napi);
> >  	struct ican3_msg msg;
> > -	unsigned long flags;
> >  	int received = 0;
> >  	int ret;
> >  
> > @@ -1204,14 +1320,6 @@ static int ican3_napi(struct napi_struct *napi, int budget)
> >  	if (received < budget)
> >  		napi_complete(napi);
> >  
> > -	spin_lock_irqsave(&mod->lock, flags);
> > -
> > -	/* Wake up the transmit queue if necessary */
> > -	if (netif_queue_stopped(mod->ndev) && ican3_txok(mod))
> > -		netif_wake_queue(mod->ndev);
> > -
> > -	spin_unlock_irqrestore(&mod->lock, flags);
> > -
> >  	/* re-enable interrupt generation */
> >  	iowrite8(1 << mod->num, &mod->ctrl->int_enable);
> >  	return received;
> > @@ -1416,18 +1524,19 @@ static int ican3_stop(struct net_device *ndev)
> >  static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
> >  {
> >  	struct ican3_dev *mod = netdev_priv(ndev);
> > -	struct net_device_stats *stats = &ndev->stats;
> >  	struct can_frame *cf = (struct can_frame *)skb->data;
> >  	struct ican3_fast_desc desc;
> >  	void __iomem *desc_addr;
> >  	unsigned long flags;
> >  
> > +	if (can_dropped_invalid_skb(ndev, skb))
> > +		return NETDEV_TX_OK;
> > +
> 
> Is this change related? At least you should add a comment in the commit
> message.
> 

No, it is not related. I'll break it into a separate patch.

In commit 3ccd4c6167d "can: Unify droping of invalid tx skbs and netdev
stats" this code was added to all other drivers.

It looks like the patch adding the janz-ican3 driver and the above
mentioned patch went in to mainline in the same merge cycle, and
therefore this change was never made in the janz-ican3 driver.

> >  	spin_lock_irqsave(&mod->lock, flags);
> >  
> >  	/* check that we can actually transmit */
> >  	if (!ican3_txok(mod)) {
> > -		dev_err(mod->dev, "no free descriptors, stopping queue\n");
> > -		netif_stop_queue(ndev);
> > +		dev_err(mod->dev, "BUG: no free descriptors\n");
> >  		spin_unlock_irqrestore(&mod->lock, flags);
> >  		return NETDEV_TX_BUSY;
> >  	}
> > @@ -1442,6 +1551,16 @@ static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
> >  	can_frame_to_ican3(mod, cf, &desc);
> >  
> >  	/*
> > +	 * This hardware doesn't have TX-done notifications, so we'll try and
> > +	 * emulate it the best we can using ECHO skbs. Add the skb to the ECHO
> > +	 * stack and stop transmitting packets. Upon packet reception, check
> > +	 * if the ECHO skb and received skb match, and use that to wake the
> > +	 * queue.
> > +	 */
> > +	netif_stop_queue(ndev);
> > +	ican3_put_echo_skb(skb, ndev, 0);
> > +
> > +	/*
> >  	 * the programming manual says that you must set the IVALID bit, then
> >  	 * interrupt, then set the valid bit. Quite weird, but it seems to be
> >  	 * required for this to work
> > @@ -1459,22 +1578,6 @@ static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
> >  	mod->fasttx_num = (desc.control & DESC_WRAP) ? 0
> >  						     : (mod->fasttx_num + 1);
> >  
> > -	/* update statistics */
> > -	stats->tx_packets++;
> > -	stats->tx_bytes += cf->can_dlc;
> > -	kfree_skb(skb);
> > -
> > -	/*
> > -	 * This hardware doesn't have TX-done notifications, so we'll try and
> > -	 * emulate it the best we can using ECHO skbs. Get the next TX
> > -	 * descriptor, and see if we have room to send. If not, stop the queue.
> > -	 * It will be woken when the ECHO skb for the current packet is recv'd.
> > -	 */
> > -
> > -	/* copy the control bits of the descriptor */
> > -	if (!ican3_txok(mod))
> > -		netif_stop_queue(ndev);
> > -
> >  	spin_unlock_irqrestore(&mod->lock, flags);
> >  	return NETDEV_TX_OK;
> >  }
> > @@ -1654,7 +1757,7 @@ static int __devinit ican3_probe(struct platform_device *pdev)
> >  	dev = &pdev->dev;
> >  
> >  	/* allocate the CAN device and private data */
> > -	ndev = alloc_candev(sizeof(*mod), 0);
> > +	ndev = alloc_candev(sizeof(*mod), 1);
> 
> What is that change good for?
> 

This change allocates one echo skb (in priv->echo_skb[]). It is useless
when the patch is merged into the next patch in the series, which uses
an skb queue instead.

It is probably easier to review the squashed patch, which is posted as a
reply to the next patch in the series.

> >  	if (!ndev) {
> >  		dev_err(dev, "unable to allocate CANdev\n");
> >  		ret = -ENOMEM;
> > 
> 
> Wolfgang.

Thanks for the review,
Ira
