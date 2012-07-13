From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: [PATCH v2 3/3] can: janz-ican3: add support for one shot mode
Date: Fri, 13 Jul 2012 16:07:11 -0700
Message-ID: <1342220831-11039-1-git-send-email-iws@ovro.caltech.edu>
References: <20120713230521.GD4538@ovro.caltech.edu>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:51477 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab2GMXHN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Jul 2012 19:07:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by ovro.ovro.caltech.edu (Postfix) with ESMTP id 6F9E2222FA
	for <linux-can@vger.kernel.org>; Fri, 13 Jul 2012 16:07:12 -0700 (PDT)
In-Reply-To: <20120713230521.GD4538@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>

From: "Ira W. Snyder" <iws@ovro.caltech.edu>

The Janz VMOD-ICAN3 hardware has support for one shot packet
transmission. This means that a packet will be attempted to be sent
once, with no automatic retries.

The SocketCAN core supports this mode using CAN_CTRLMODE_ONE_SHOT.

Every time a packet transmission failure happens, one packet needs to be
dropped from the front of the ECHO queue. This hardware lacks support
for TX-error interrupts, and so bus error indications are used as a
workaround. Every time a TX bus error is received, we know a packet
failed to transmit. If bus error reporting is off, do not forward the
bus error packets to userspace.

The rx_bytes and tx_bytes counters were audited to make sure they only
reflect actual data bytes received from the bus. They do not include
error packets.

The rx_errors and tx_errors counters were audited to make sure they are
correct in all situations. Previously, the rx_errors counts were
sometimes too high.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---

This patch should superceed the previous patch posted with this title.

 drivers/net/can/janz-ican3.c |   56 +++++++++++++++++++++++------------------
 1 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 5fff829..fccfc3a 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -116,6 +116,7 @@
 #define ICAN3_BUSERR_QUOTA_MAX	255
 
 /* Janz ICAN3 CAN Frame Conversion */
+#define ICAN3_SNGL	0x02
 #define ICAN3_ECHO	0x10
 #define ICAN3_EFF_RTR	0x40
 #define ICAN3_SFF_RTR	0x10
@@ -848,6 +849,10 @@ static void can_frame_to_ican3(struct ican3_dev *mod,
 	desc->data[0] |= cf->can_dlc;
 	desc->data[1] |= ICAN3_ECHO;
 
+	/* support single transmission (no retries) mode */
+	if (mod->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+		desc->data[1] |= ICAN3_SNGL;
+
 	if (cf->can_id & CAN_RTR_FLAG)
 		desc->data[0] |= ICAN3_EFF_RTR;
 
@@ -911,7 +916,6 @@ static void ican3_handle_msglost(struct ican3_dev *mod, struct ican3_msg *msg)
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 		stats->rx_errors++;
-		stats->rx_bytes += cf->can_dlc;
 		netif_rx(skb);
 	}
 }
@@ -928,7 +932,7 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
 	struct net_device *dev = mod->ndev;
 	struct net_device_stats *stats = &dev->stats;
 	enum can_state state = mod->can.state;
-	u8 status, isrc, rxerr, txerr;
+	u8 isrc, ecc, status, rxerr, txerr;
 	struct can_frame *cf;
 	struct sk_buff *skb;
 
@@ -949,6 +953,7 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
 		return -ENOMEM;
 
 	isrc = msg->data[0];
+	ecc = msg->data[2];
 	status = msg->data[3];
 	rxerr = msg->data[4];
 	txerr = msg->data[5];
@@ -959,7 +964,6 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 		stats->rx_over_errors++;
-		stats->rx_errors++;
 	}
 
 	/* error warning + passive interrupt */
@@ -981,11 +985,28 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
 
 	/* bus error interrupt */
 	if (isrc == CEVTIND_BEI) {
-		u8 ecc = msg->data[2];
-
 		dev_dbg(mod->dev, "bus error interrupt\n");
+
+		/*
+		 * This hardware lacks any support other than bus error
+		 * messages to determine if the packet transmission failed.
+		 *
+		 * This is a TX error, so we free an echo skb from the front
+		 * of the queue.
+		 */
+		if ((ecc & ECC_DIR) == 0) {
+			cf->data[2] |= CAN_ERR_PROT_TX;
+			kfree_skb(skb_dequeue(&mod->echoq));
+			stats->tx_errors++;
+		}
+
+		/* bus error reporting is off, drop the error skb */
+		if (!(mod->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)) {
+			kfree_skb(skb);
+			return 0;
+		}
+
 		mod->can.can_stats.bus_error++;
-		stats->rx_errors++;
 		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
 		switch (ecc & ECC_MASK) {
@@ -1004,9 +1025,6 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
 			break;
 		}
 
-		if ((ecc & ECC_DIR) == 0)
-			cf->data[2] |= CAN_ERR_PROT_TX;
-
 		cf->data[6] = txerr;
 		cf->data[7] = rxerr;
 	}
@@ -1031,8 +1049,8 @@ static int ican3_handle_cevtind(struct ican3_dev *mod, struct ican3_msg *msg)
 	}
 
 	mod->can.state = state;
-	stats->rx_errors++;
-	stats->rx_bytes += cf->can_dlc;
+	if (!(cf->data[2] & CAN_ERR_PROT_TX))
+		stats->rx_errors++;
 	netif_rx(skb);
 	return 0;
 }
@@ -1467,19 +1485,6 @@ static int ican3_open(struct net_device *ndev)
 		return ret;
 	}
 
-	/* set the bus error generation state appropriately */
-	if (mod->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
-		quota = ICAN3_BUSERR_QUOTA_MAX;
-	else
-		quota = 0;
-
-	ret = ican3_set_buserror(mod, quota);
-	if (ret) {
-		dev_err(mod->dev, "unable to set bus-error\n");
-		close_candev(ndev);
-		return ret;
-	}
-
 	/* bring the bus online */
 	ret = ican3_set_bus_state(mod, true);
 	if (ret) {
@@ -1791,7 +1796,8 @@ static int __devinit ican3_probe(struct platform_device *pdev)
 	mod->can.do_set_mode = ican3_set_mode;
 	mod->can.do_get_berr_counter = ican3_get_berr_counter;
 	mod->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES
-				    | CAN_CTRLMODE_BERR_REPORTING;
+				    | CAN_CTRLMODE_BERR_REPORTING
+				    | CAN_CTRLMODE_ONE_SHOT;
 
 	/* find our IRQ number */
 	mod->irq = platform_get_irq(pdev, 0);
-- 
1.7.8.6

