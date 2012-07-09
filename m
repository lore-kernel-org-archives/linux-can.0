From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 3/3] can: janz-ican3: fix support for
 CAN_RAW_RECV_OWN_MSGS
Date: Mon, 9 Jul 2012 14:16:38 -0700
Message-ID: <20120709211638.GB20561@ovro.caltech.edu>
References: <1341863790-5645-1-git-send-email-iws@ovro.caltech.edu>
 <1341863790-5645-4-git-send-email-iws@ovro.caltech.edu>
 <4FFB45B8.10400@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:53805 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab2GIVQm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jul 2012 17:16:42 -0400
Content-Disposition: inline
In-Reply-To: <4FFB45B8.10400@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

On Mon, Jul 09, 2012 at 10:57:28PM +0200, Oliver Hartkopp wrote:
> On 09.07.2012 21:56, Ira W. Snyder wrote:
> 
> > From: "Ira W. Snyder" <iws@ovro.caltech.edu>
> > 
> > The Janz VMOD-ICAN3 firmware does not support any sort of TX-done
> > notification or interrupt. The driver previously used the hardware
> > loopback to attempt to work around this deficiency, but this caused all
> > sockets to receive all messages, even if CAN_RAW_RECV_OWN_MSGS is off.
> > 
> > Using the new function can_cmp_echo_skb(), we can drop the loopback
> > messages and return the original skbs. This fixes the issues with
> > CAN_RAW_RECV_OWN_MSGS.
> > 
> > Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> > ---
> >  drivers/net/can/janz-ican3.c |   56 ++++++++++++++++++++++-------------------
> >  1 files changed, 30 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
> > index 08c893c..a49af40 100644
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
> >  
> >  	/* build a single fast tohost queue descriptor */
> >  	memset(&desc, 0, sizeof(desc));
> > @@ -1150,6 +1148,21 @@ static int ican3_recv_skb(struct ican3_dev *mod)
> >  	/* convert the ICAN3 frame into Linux CAN format */
> >  	ican3_to_can_frame(mod, &desc, cf);
> >  
> > +	/*
> > +	 * If this is an ECHO frame received from the hardware loopback
> > +	 * feature, use the skb saved in the ECHO stack instead. This allows
> > +	 * the Linux CAN core to support CAN_RAW_RECV_OWN_MSGS correctly.
> > +	 *
> > +	 * Also, the netdevice queue needs to be allowed to send packets again.
> > +	 */
> > +	if (can_cmp_echo_skb(skb, ndev, 0)) {
> > +		stats->rx_packets++;
> > +		stats->rx_bytes += can_get_echo_skb(ndev, 0);
> > +		kfree_skb(skb);
> > +		netif_wake_queue(ndev);
> > +		goto err_noalloc;
> > +	}
> > +
> >  	/* receive the skb, update statistics */
> >  	netif_receive_skb(skb);
> >  	stats->rx_packets++;
> > @@ -1177,7 +1190,6 @@ static int ican3_napi(struct napi_struct *napi, int budget)
> >  {
> >  	struct ican3_dev *mod = container_of(napi, struct ican3_dev, napi);
> >  	struct ican3_msg msg;
> > -	unsigned long flags;
> >  	int received = 0;
> >  	int ret;
> >  
> > @@ -1204,14 +1216,6 @@ static int ican3_napi(struct napi_struct *napi, int budget)
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
> > @@ -1422,12 +1426,14 @@ static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
> >  	void __iomem *desc_addr;
> >  	unsigned long flags;
> >  
> > +	if (can_dropped_invalid_skb(ndev, skb))
> > +		return NETDEV_TX_OK;
> > +
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
> > @@ -1442,6 +1448,16 @@ static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
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
> > +	can_put_echo_skb(skb, ndev, 0);
> > +
> > +	/*
> >  	 * the programming manual says that you must set the IVALID bit, then
> >  	 * interrupt, then set the valid bit. Quite weird, but it seems to be
> >  	 * required for this to work
> > @@ -1462,18 +1478,6 @@ static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
> >  	/* update statistics */
> >  	stats->tx_packets++;
> >  	stats->tx_bytes += cf->can_dlc;
> 
> 
> I think these statistic updates double the traffic as you do them in
> ican3_recv_skb() again.
> 

How exactly are the RX and TX packet counters supposed to work?

There are several cases to consider. For each case, should the rx, tx,
none, or both sets of counters updated?

1) When ican3_xmit() is called
2) When ican3_recv_skb() is called with an ECHO packet (sent from the
local host, and looped back by the hardware)
3) When ican3_recv_skb() is called with a packet from an external host
(sent from a different device on the CAN bus)

The current code does the following:
1) tx counters only
2) rx counters only (we *did* receive a packet from hardware, after all)
3) rx counters only

Do you want the following:
1) tx counters only
2) none
3) rx counters only

I can also come up with good reasons for the following:
1) none (the packet has only been queued, not sucessfully transmitted)
2) tx counters only (we *did* successfully transmit a packet)
3) rx counters only

Please clarify.

Thanks,
Ira

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
> >  
> >  	spin_unlock_irqrestore(&mod->lock, flags);
> >  	return NETDEV_TX_OK;
> > @@ -1654,7 +1658,7 @@ static int __devinit ican3_probe(struct platform_device *pdev)
> >  	dev = &pdev->dev;
> >  
> >  	/* allocate the CAN device and private data */
> > -	ndev = alloc_candev(sizeof(*mod), 0);
> > +	ndev = alloc_candev(sizeof(*mod), 1);
> >  	if (!ndev) {
> >  		dev_err(dev, "unable to allocate CANdev\n");
> >  		ret = -ENOMEM;
> 
> 
