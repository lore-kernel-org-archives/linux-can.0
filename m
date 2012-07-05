From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: [PATCH ALTERNATE VERSION 1/1] can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS
Date: Thu,  5 Jul 2012 14:04:26 -0700
Message-ID: <1341522266-12079-1-git-send-email-iws@ovro.caltech.edu>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:48796 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab2GEVE1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Jul 2012 17:04:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by ovro.ovro.caltech.edu (Postfix) with ESMTP id 797622229B
	for <linux-can@vger.kernel.org>; Thu,  5 Jul 2012 14:04:27 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

The Janz VMOD-ICAN3 firmware does not support any sort of TX-done
notification or interrupt. The driver previously used the hardware
loopback to attempt to work around this deficiency, but this caused all
sockets to receive all messages, even if CAN_RAW_RECV_OWN_MSGS is off.

Dropping the hardware loopback support and letting the higher layers
handle re-queueing packets when the hardware has no more buffer space
fixes the issues.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---

This is an alternate version of the previously posted patch. By dropping
support for the hardware loopback and letting the SocketCAN core handle
everything, both the tst-rcv-own-msgs and cangen -x tests pass. The driver
never stops accepting packets, as it does in the previously posted version.

In addition, the performance is MUCH better with this patch than it is with
the previously posted version which uses can_cmp_echo_skb().

I would prefer that this patch is applied rather than the other one.

 drivers/net/can/janz-ican3.c |   26 ++------------------------
 1 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 08c893c..b03a70f 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -845,7 +845,6 @@ static void can_frame_to_ican3(struct ican3_dev *mod,
 	/* we always use the extended format, with the ECHO flag set */
 	desc->command = ICAN3_CAN_TYPE_EFF;
 	desc->data[0] |= cf->can_dlc;
-	desc->data[1] |= ICAN3_ECHO;
 
 	if (cf->can_id & CAN_RTR_FLAG)
 		desc->data[0] |= ICAN3_EFF_RTR;
@@ -1204,14 +1203,6 @@ static int ican3_napi(struct napi_struct *napi, int budget)
 	if (received < budget)
 		napi_complete(napi);
 
-	spin_lock_irqsave(&mod->lock, flags);
-
-	/* Wake up the transmit queue if necessary */
-	if (netif_queue_stopped(mod->ndev) && ican3_txok(mod))
-		netif_wake_queue(mod->ndev);
-
-	spin_unlock_irqrestore(&mod->lock, flags);
-
 	/* re-enable interrupt generation */
 	iowrite8(1 << mod->num, &mod->ctrl->int_enable);
 	return received;
@@ -1426,8 +1417,6 @@ static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 
 	/* check that we can actually transmit */
 	if (!ican3_txok(mod)) {
-		dev_err(mod->dev, "no free descriptors, stopping queue\n");
-		netif_stop_queue(ndev);
 		spin_unlock_irqrestore(&mod->lock, flags);
 		return NETDEV_TX_BUSY;
 	}
@@ -1459,23 +1448,13 @@ static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 	mod->fasttx_num = (desc.control & DESC_WRAP) ? 0
 						     : (mod->fasttx_num + 1);
 
+	spin_unlock_irqrestore(&mod->lock, flags);
+
 	/* update statistics */
 	stats->tx_packets++;
 	stats->tx_bytes += cf->can_dlc;
 	kfree_skb(skb);
 
-	/*
-	 * This hardware doesn't have TX-done notifications, so we'll try and
-	 * emulate it the best we can using ECHO skbs. Get the next TX
-	 * descriptor, and see if we have room to send. If not, stop the queue.
-	 * It will be woken when the ECHO skb for the current packet is recv'd.
-	 */
-
-	/* copy the control bits of the descriptor */
-	if (!ican3_txok(mod))
-		netif_stop_queue(ndev);
-
-	spin_unlock_irqrestore(&mod->lock, flags);
 	return NETDEV_TX_OK;
 }
 
@@ -1678,7 +1657,6 @@ static int __devinit ican3_probe(struct platform_device *pdev)
 	mod->free_page = DPM_FREE_START;
 
 	ndev->netdev_ops = &ican3_netdev_ops;
-	ndev->flags |= IFF_ECHO;
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 
 	mod->can.clock.freq = ICAN3_CAN_CLOCK;
-- 
1.7.3.4

