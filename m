From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: Questions about janz-ican3 and CAN_RAW_RECV_OWN_MSGS
Date: Wed, 4 Jul 2012 12:07:34 -0700
Message-ID: <20120704190733.GC4422@ovro.caltech.edu>
References: <20120703232328.GD6616@ovro.caltech.edu>
 <4FF40A6E.1040709@grandegger.com>
 <20120704120736.GB417@vandijck-laurijssen.be>
 <4FF46E12.8060102@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:42743 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763Ab2GDTHi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Jul 2012 15:07:38 -0400
Content-Disposition: inline
In-Reply-To: <4FF46E12.8060102@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Kurt Van Dijck <kurt.van.dijck@eia.be>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Wed, Jul 04, 2012 at 06:23:46PM +0200, Oliver Hartkopp wrote:
> On 04.07.2012 14:07, Kurt Van Dijck wrote:
> 
> > On Wed, Jul 04, 2012 at 11:18:38AM +0200, Wolfgang Grandegger wrote:
> >> Hi Ira,
> >>
> >> On 07/04/2012 01:23 AM, Ira W. Snyder wrote:
> >>> Hello everyone,
> >>>
> >>> I'm finally implementing SocketCAN support in our internal codebase, and
> >>> have run across some issues. We previously used a character driver provided
> >>> by the vendor.
> >>>
> >>> I myself implemented the driver for the Janz ICAN3 card. It has been in
> >>> mainline Linux since 2.6.35.
> >>>
> >>> The hardware is an SJA1000 chip plus a microcontroller and some RAM. All
> >>> messages go through the microcontroller firmware.
> >>>
> >>> This firmware has the following features:
> >>> - it does have hardware-supported local loopback
> >>> - it does NOT have any sort of "tx-complete" notification or interrupt
> >>> - it does NOT have any indication that a frame went through the
> >>>   hardware-supported local loopback
> >>>
> >>> To work around the lack of "tx-complete" interrupts, I used the hardware
> >>> local loopback feature. Every frame has hardware loopback set, which causes
> >>> the ican3_napi() routine to be called for each frame sent. This works fine,
> >>> except that sockets created with the default options (loopback on,
> >>> can_raw_recv_own_msgs off) do receive their own messages. This seems wrong.
> >>>
> >>> QUESTION 1:
> >>> The functions can_(get|put)_echo_skb() are not used at all. Is this wrong?
> >>
> >> Not necessarily. IIRC, the early versions of the Flexcan driver used the
> >> hardware loopback as well but switched to classical echo-skb handling
> >> because of the problem with recv-own-msgs.
> >>
> >>> QUESTION 2:
> >>> The socketcan test tst-rcv-own-msgs says:
> >>> Starting PF_CAN frame flow test.
> >>> checking socket default settings ... failure!
> >>>
> >>> If I understand the code correctly, this means that the sending socket
> >>> received an echo frame when it should not have received one.
> >>>
> >>> This matches what I expect the code to do.
> >>>
> >>> How can I fix this?
> >>>
> >>> OBSERVATION 1:
> >>> The following patch drops the relevant calls to netif_stop_queue() and
> >>> netif_wake_queue(), as well as the hardware-supported local loopback.
> >>>
> >>> The tst-rcv-own-msgs test passes.
> >>>
> >>> Is dropping these API calls a reasonable thing to do?
> > 
> > I'm not sure.
> >>
> >> Well, that controller will not allow to support all features and options
> >> and we need to make a choice:
> >>
> >>  recv-own-msgs support versus proper tx-done handling (correct timing)
> >>
> >> As the recv-own-msgs is not used frequently, it would not be really
> >> dramatic if the feature is not available.
> > 
> > My opinion:
> > 
> > 1) is the correct timing of tx-done more used than recv-own-msgs?
> >    I think such choices are really hard to make.
> >    Avoid choosing if possible.
> > 
> > 2) To avoid choosing, you could:
> >    a. use can_put_echo_skb()
> >    b. when an rx interrupt && the frame matches the next echo_skb,
> >       drop the rx frame and deliver echo_skb.
> >    I realise that b. needs some code in generic can_dev (something like
> >    can_peek_echo_skb()), and costs you some performance.
> > 
> 
> 
> Hello all,
> 
> i also thought about your case 'b' and it could be a good choice indeed.
> 
> First it is generally an unusual case that you receive a CAN-ID from the
> 'outside' that is sent from the local host. But of course we can not assume
> this 'good CAN network design rule' is to be implemented always ...
> 
> Anyway we currently have the flexcan and the ican3 hardware that generally
> supports a loopback on hardware level but looses the reference to the tx-skb
> and therefore to the sk pointer which is used to identify the originating
> socket for recv-own-msgs support.
> 
> If we receive a new CAN frame and there are any CAN frames stored in the
> echo_skb cache, we can compare the received frame with the cached frames.
> 
> If we find an identical CAN frame, we get the echo_skb and push it into the
> receive path. For that reason the flexcan and ican3 driver should only
> allocate a new rx skb when there's no matching echo_skb available.
> 
> What could happen, if we (unlikely) *really* receive an identical CAN frame
> content from the 'outside' we already have in the echo_skb cache?
> 
> Well the only thing that comes in mind is that we would mix these two
> *identical* frames in their order and therefore in their timestamp. Additional
> it can be assumed that the second 'identical' frame is following instantaneous.
> 
> To me this looks like a acceptable risk - especially as it is opposed to the
> 'good CAN network design rule' to have identical CAN-IDs.
> 
> @Ira: Do you want to propose a patch which adds the echo_skb cache check for
> received CAN frames for the ican3 driver?
> 
> Regards,
> Oliver

Hello Oliver,

Is the following patch what you have in mind? I tested it on my board,
and it crashed after a few seconds, so there must be something wrong.
Any ideas?

I won't have access to the machine to do more testing until tomorrow.

Ira


diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index c5fe3a3..f112f77 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -348,6 +348,39 @@ unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx)
 EXPORT_SYMBOL_GPL(can_get_echo_skb);
 
 /*
+ * Compare an skb with an existing echo skb
+ *
+ * This function will be used on devices which have a hardware loopback.
+ * On these devices, this function can be used to compare a received skb
+ * with the saved echo skbs so that the hardware echo skb can be dropped.
+ *
+ * Returns true if the skb's are identical, false otherwise.
+ */
+bool can_cmp_echo_skb(struct sk_buff *skb, struct net_device *dev,
+		      unsigned int idx)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	struct can_frame *cf = (struct can_frame *)skb->data;
+
+	BUG_ON(idx >= priv->echo_skb_max);
+
+	if (priv->echo_skb[idx]) {
+		struct sk_buff *echo_skb = priv->echo_skb[idx];
+		struct can_frame *echo_cf = (struct can_frame *)echo_skb->data;
+		if (cf->can_id != echo_cf->can_id)
+			return false;
+
+		if (cf->can_dlc != echo_cf->can_dlc)
+			return false;
+
+		return memcmp(cf->data, echo_cf->data, cf->can_dlc) == 0;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(can_cmp_echo_skb);
+
+/*
   * Remove the skb from the stack and free it.
   *
   * The function is typically called when TX failed.
diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 08c893c..b5de314 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -235,10 +235,11 @@ struct ican3_dev {
 
 	/* fast host interface */
 	unsigned int fastrx_start;
-	unsigned int fastrx_int;
 	unsigned int fastrx_num;
+	unsigned int fastrx_echo;
 	unsigned int fasttx_start;
 	unsigned int fasttx_num;
+	unsigned int fasttx_echo;
 
 	/* first free DPM page */
 	unsigned int free_page;
@@ -454,7 +455,7 @@ static void __devinit ican3_init_fast_host_interface(struct ican3_dev *mod)
 	/* save the start recv page */
 	mod->fastrx_start = mod->free_page;
 	mod->fastrx_num = 0;
-	mod->fastrx_int = 0;
+	mod->fastrx_echo = 0;
 
 	/* build a single fast tohost queue descriptor */
 	memset(&desc, 0, sizeof(desc));
@@ -491,6 +492,7 @@ static void __devinit ican3_init_fast_host_interface(struct ican3_dev *mod)
 	/* save the start xmit page */
 	mod->fasttx_start = mod->free_page;
 	mod->fasttx_num = 0;
+	mod->fasttx_echo = 0;
 
 	/* build a single fast fromhost queue descriptor */
 	memset(&desc, 0, sizeof(desc));
@@ -1150,6 +1152,14 @@ static int ican3_recv_skb(struct ican3_dev *mod)
 	/* convert the ICAN3 frame into Linux CAN format */
 	ican3_to_can_frame(mod, &desc, cf);
 
+	/* check if this is an ECHO frame */
+	if (can_cmp_echo_skb(skb, ndev, mod->fastrx_echo)) {
+		can_get_echo_skb(ndev, mod->fastrx_echo);
+		mod->fastrx_echo = (mod->fastrx_echo + 1) & (ICAN3_TX_BUFFERS - 1);
+		kfree_skb(skb);
+		goto err_noalloc;
+	}
+
 	/* receive the skb, update statistics */
 	netif_receive_skb(skb);
 	stats->rx_packets++;
@@ -1422,6 +1432,9 @@ static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 	void __iomem *desc_addr;
 	unsigned long flags;
 
+	if (can_dropped_invalid_skb(ndev, skb))
+		return NETDEV_TX_OK;
+
 	spin_lock_irqsave(&mod->lock, flags);
 
 	/* check that we can actually transmit */
@@ -1432,6 +1445,10 @@ static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 		return NETDEV_TX_BUSY;
 	}
 
+	/* add to the ECHO stack */
+	can_put_echo_skb(skb, ndev, mod->fasttx_echo);
+	mod->fasttx_echo = (mod->fasttx_echo + 1) & ~(ICAN3_TX_BUFFERS - 1);
+
 	/* copy the control bits of the descriptor */
 	ican3_set_page(mod, mod->fasttx_start + (mod->fasttx_num / 16));
 	desc_addr = mod->dpm + ((mod->fasttx_num % 16) * sizeof(desc));
@@ -1654,7 +1671,7 @@ static int __devinit ican3_probe(struct platform_device *pdev)
 	dev = &pdev->dev;
 
 	/* allocate the CAN device and private data */
-	ndev = alloc_candev(sizeof(*mod), 0);
+	ndev = alloc_candev(sizeof(*mod), ICAN3_TX_BUFFERS);
 	if (!ndev) {
 		dev_err(dev, "unable to allocate CANdev\n");
 		ret = -ENOMEM;
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 5d2efe7..904a938 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -93,6 +93,8 @@ void can_bus_off(struct net_device *dev);
 void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		      unsigned int idx);
 unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx);
+bool can_cmp_echo_skb(struct sk_buff *skb, struct net_device *dev,
+		      unsigned int idx);
 void can_free_echo_skb(struct net_device *dev, unsigned int idx);
 
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf);
