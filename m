From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Questions about janz-ican3 and CAN_RAW_RECV_OWN_MSGS
Date: Tue, 3 Jul 2012 16:23:28 -0700
Message-ID: <20120703232328.GD6616@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:38894 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab2GCXcp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 Jul 2012 19:32:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by ovro.ovro.caltech.edu (Postfix) with ESMTP id D6A5E21FB5
	for <linux-can@vger.kernel.org>; Tue,  3 Jul 2012 16:23:30 -0700 (PDT)
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello everyone,

I'm finally implementing SocketCAN support in our internal codebase, and
have run across some issues. We previously used a character driver provided
by the vendor.

I myself implemented the driver for the Janz ICAN3 card. It has been in
mainline Linux since 2.6.35.

The hardware is an SJA1000 chip plus a microcontroller and some RAM. All
messages go through the microcontroller firmware.

This firmware has the following features:
- it does have hardware-supported local loopback
- it does NOT have any sort of "tx-complete" notification or interrupt
- it does NOT have any indication that a frame went through the
  hardware-supported local loopback

To work around the lack of "tx-complete" interrupts, I used the hardware
local loopback feature. Every frame has hardware loopback set, which causes
the ican3_napi() routine to be called for each frame sent. This works fine,
except that sockets created with the default options (loopback on,
can_raw_recv_own_msgs off) do receive their own messages. This seems wrong.

QUESTION 1:
The functions can_(get|put)_echo_skb() are not used at all. Is this wrong?

QUESTION 2:
The socketcan test tst-rcv-own-msgs says:
Starting PF_CAN frame flow test.
checking socket default settings ... failure!

If I understand the code correctly, this means that the sending socket
received an echo frame when it should not have received one.

This matches what I expect the code to do.

How can I fix this?

OBSERVATION 1:
The following patch drops the relevant calls to netif_stop_queue() and
netif_wake_queue(), as well as the hardware-supported local loopback.

The tst-rcv-own-msgs test passes.

Is dropping these API calls a reasonable thing to do?

Thanks,
Ira



diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 08c893c..b8bf972 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -845,7 +845,9 @@ static void can_frame_to_ican3(struct ican3_dev *mod,
 	/* we always use the extended format, with the ECHO flag set */
 	desc->command = ICAN3_CAN_TYPE_EFF;
 	desc->data[0] |= cf->can_dlc;
+#if 0
 	desc->data[1] |= ICAN3_ECHO;
+#endif
 
 	if (cf->can_id & CAN_RTR_FLAG)
 		desc->data[0] |= ICAN3_EFF_RTR;
@@ -1206,9 +1208,11 @@ static int ican3_napi(struct napi_struct *napi, int budget)
 
 	spin_lock_irqsave(&mod->lock, flags);
 
+#if 0
 	/* Wake up the transmit queue if necessary */
 	if (netif_queue_stopped(mod->ndev) && ican3_txok(mod))
 		netif_wake_queue(mod->ndev);
+#endif
 
 	spin_unlock_irqrestore(&mod->lock, flags);
 
@@ -1426,8 +1430,10 @@ static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 	/* check that we can actually transmit */
 	if (!ican3_txok(mod)) {
+#if 0
 		dev_err(mod->dev, "no free descriptors, stopping queue\n");
 		netif_stop_queue(ndev);
+#endif
 		spin_unlock_irqrestore(&mod->lock, flags);
 		return NETDEV_TX_BUSY;
 	}
@@ -1471,9 +1477,11 @@ static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 	 * It will be woken when the ECHO skb for the current packet is recv'd.
 	 */
 
+#if 0
 	/* copy the control bits of the descriptor */
 	if (!ican3_txok(mod))
 		netif_stop_queue(ndev);
+#endif
 
 	spin_unlock_irqrestore(&mod->lock, flags);
 	return NETDEV_TX_OK;
@@ -1678,7 +1686,9 @@ static int __devinit ican3_probe(struct platform_device *pdev)
 	mod->free_page = DPM_FREE_START;
 
 	ndev->netdev_ops = &ican3_netdev_ops;
+#if 0
 	ndev->flags |= IFF_ECHO;
+#endif
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 
 	mod->can.clock.freq = ICAN3_CAN_CLOCK;
