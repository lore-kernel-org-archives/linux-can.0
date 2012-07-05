From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: [PATCH 2/2] can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS
Date: Thu,  5 Jul 2012 13:58:28 -0700
Message-ID: <1341521908-11454-3-git-send-email-iws@ovro.caltech.edu>
References: <1341521908-11454-1-git-send-email-iws@ovro.caltech.edu>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:48735 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536Ab2GEU6c (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Jul 2012 16:58:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by ovro.ovro.caltech.edu (Postfix) with ESMTP id 5BBEF2229C
	for <linux-can@vger.kernel.org>; Thu,  5 Jul 2012 13:58:32 -0700 (PDT)
In-Reply-To: <1341521908-11454-1-git-send-email-iws@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

The Janz VMOD-ICAN3 firmware does not support any sort of TX-done
notification or interrupt. The driver previously used the hardware
loopback to attempt to work around this deficiency, but this caused all
sockets to receive all messages, even if CAN_RAW_RECV_OWN_MSGS is off.

Using the new function can_cmp_echo_skb(), we can drop the loopback
messages and return the original skbs. This fixes the issues with
CAN_RAW_RECV_OWN_MSGS, but leaves the driver vulnerable to a condition
where it will overwrite the echo skb stack.

NOT EVEN CLOSE TO Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---

WARNING: BROKEN CODE!

If a user uses non-loopback mode and sends packets very quickly, the driver
will stop accepting packets until the bus is re-started.

I've managed to trigger the BUG printk() in can_put_echo_skb(), since the
receive queue can fall behind the transmit queue, and I don't know how to
detect that situation.

In short, the patch "works", but I'm not happy with it. See my next posting
for a working patch that takes a different approach.

 drivers/net/can/janz-ican3.c |   37 ++++++++++++++++++++++++++++++-------
 1 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 08c893c..183c88c 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -235,10 +235,10 @@ struct ican3_dev {
 
 	/* fast host interface */
 	unsigned int fastrx_start;
-	unsigned int fastrx_int;
 	unsigned int fastrx_num;
 	unsigned int fasttx_start;
 	unsigned int fasttx_num;
+	unsigned int fasttx_echo;
 
 	/* first free DPM page */
 	unsigned int free_page;
@@ -454,7 +454,6 @@ static void __devinit ican3_init_fast_host_interface(struct ican3_dev *mod)
 	/* save the start recv page */
 	mod->fastrx_start = mod->free_page;
 	mod->fastrx_num = 0;
-	mod->fastrx_int = 0;
 
 	/* build a single fast tohost queue descriptor */
 	memset(&desc, 0, sizeof(desc));
@@ -491,6 +490,7 @@ static void __devinit ican3_init_fast_host_interface(struct ican3_dev *mod)
 	/* save the start xmit page */
 	mod->fasttx_start = mod->free_page;
 	mod->fasttx_num = 0;
+	mod->fasttx_echo = 0;
 
 	/* build a single fast fromhost queue descriptor */
 	memset(&desc, 0, sizeof(desc));
@@ -820,6 +820,9 @@ static void ican3_to_can_frame(struct ican3_dev *mod,
 		if (desc->data[0] & ICAN3_EFF_RTR)
 			cf->can_id |= CAN_RTR_FLAG;
 
+		if (desc->data[1] & ICAN3_ECHO)
+			dev_err(mod->dev, "echo frame\n");
+
 		if (desc->data[0] & ICAN3_EFF) {
 			cf->can_id |= CAN_EFF_FLAG;
 			cf->can_id |= desc->data[2] << 21; /* 28-21 */
@@ -837,7 +840,8 @@ static void ican3_to_can_frame(struct ican3_dev *mod,
 
 static void can_frame_to_ican3(struct ican3_dev *mod,
 			       struct can_frame *cf,
-			       struct ican3_fast_desc *desc)
+			       struct ican3_fast_desc *desc,
+			       bool echo)
 {
 	/* clear out any stale data in the descriptor */
 	memset(desc->data, 0, sizeof(desc->data));
@@ -845,7 +849,9 @@ static void can_frame_to_ican3(struct ican3_dev *mod,
 	/* we always use the extended format, with the ECHO flag set */
 	desc->command = ICAN3_CAN_TYPE_EFF;
 	desc->data[0] |= cf->can_dlc;
-	desc->data[1] |= ICAN3_ECHO;
+
+	if (echo)
+		desc->data[1] |= ICAN3_ECHO;
 
 	if (cf->can_id & CAN_RTR_FLAG)
 		desc->data[0] |= ICAN3_EFF_RTR;
@@ -1126,6 +1132,7 @@ static int ican3_recv_skb(struct ican3_dev *mod)
 	struct can_frame *cf;
 	struct sk_buff *skb;
 	unsigned long flags;
+	int i;
 
 	spin_lock_irqsave(&mod->lock, flags);
 
@@ -1150,6 +1157,16 @@ static int ican3_recv_skb(struct ican3_dev *mod)
 	/* convert the ICAN3 frame into Linux CAN format */
 	ican3_to_can_frame(mod, &desc, cf);
 
+	/* check if this is an ECHO frame */
+	for (i = 0; i < ICAN3_TX_BUFFERS; i++) {
+		if (can_cmp_echo_skb(skb, ndev, i)) {
+			stats->rx_packets++;
+			stats->rx_bytes += can_get_echo_skb(ndev, i);
+			kfree_skb(skb);
+			goto err_noalloc;
+		}
+	}
+
 	/* receive the skb, update statistics */
 	netif_receive_skb(skb);
 	stats->rx_packets++;
@@ -1422,6 +1439,9 @@ static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 	void __iomem *desc_addr;
 	unsigned long flags;
 
+	if (can_dropped_invalid_skb(ndev, skb))
+		return NETDEV_TX_OK;
+
 	spin_lock_irqsave(&mod->lock, flags);
 
 	/* check that we can actually transmit */
@@ -1439,7 +1459,11 @@ static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 	memcpy_fromio(&desc, desc_addr, 1);
 
 	/* convert the Linux CAN frame into ICAN3 format */
-	can_frame_to_ican3(mod, cf, &desc);
+	can_frame_to_ican3(mod, cf, &desc, skb->pkt_type == PACKET_LOOPBACK);
+
+	/* add to the ECHO stack */
+	can_put_echo_skb(skb, ndev, mod->fasttx_echo);
+	mod->fasttx_echo = (mod->fasttx_echo + 1) & (ICAN3_TX_BUFFERS - 1);
 
 	/*
 	 * the programming manual says that you must set the IVALID bit, then
@@ -1462,7 +1486,6 @@ static int ican3_xmit(struct sk_buff *skb, struct net_device *ndev)
 	/* update statistics */
 	stats->tx_packets++;
 	stats->tx_bytes += cf->can_dlc;
-	kfree_skb(skb);
 
 	/*
 	 * This hardware doesn't have TX-done notifications, so we'll try and
@@ -1654,7 +1677,7 @@ static int __devinit ican3_probe(struct platform_device *pdev)
 	dev = &pdev->dev;
 
 	/* allocate the CAN device and private data */
-	ndev = alloc_candev(sizeof(*mod), 0);
+	ndev = alloc_candev(sizeof(*mod), ICAN3_TX_BUFFERS);
 	if (!ndev) {
 		dev_err(dev, "unable to allocate CANdev\n");
 		ret = -ENOMEM;
-- 
1.7.3.4

