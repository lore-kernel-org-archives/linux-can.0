From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: flexcan: make use of FLEXCAN_MB_CODE_
Date: Tue, 23 Sep 2014 15:25:39 +0200
Message-ID: <1411478739-17894-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37802 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbaIWNZn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 23 Sep 2014 09:25:43 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: david@protonic.nl
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hey David,

this is an incremental patch to get rid of open coded values for the mailbox
code. Please review and feel free to squash in your patch.

Use just updated linux-can-next/flexcan-next, it already your and this patch.

Marc

 drivers/net/can/flexcan.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index acfb7ab..7bd251b 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -158,6 +158,8 @@
 #define FLEXCAN_IFLAG2_DEFAULT 		(0xffffffff)
 
 /* FLEXCAN message buffers */
+#define FLEXCAN_MB_CODE_MASK		(0xf << 24)
+#define FLEXCAN_MB_CODE_RX_BUSY_BIT	(0x1 << 24)
 #define FLEXCAN_MB_CODE_RX_INACTIVE	(0x0 << 24)
 #define FLEXCAN_MB_CODE_RX_EMPTY	(0x4 << 24)
 #define FLEXCAN_MB_CODE_RX_FULL		(0x2 << 24)
@@ -711,10 +713,11 @@ static int flexcan_read_frame(struct net_device *dev, int n)
 	u32 code;
 
 	reg_ctrl = mb->can_ctrl;
-	code = (reg_ctrl & FLEXCAN_MB_CODE_MASK) >> FLEXCAN_MB_CODE_SHIFT;
+	code = reg_ctrl & FLEXCAN_MB_CODE_MASK;
 
 	/* is this MB empty? */
-	if ((code != 0x2) && (code != 0x6))
+	if ((code != FLEXCAN_MB_CODE_RX_FULL) &&
+	    (code != FLEXCAN_MB_CODE_RX_OVERRRUN))
 		return 0;
 
 	skb = alloc_can_skb(dev, &cf);
@@ -805,12 +808,12 @@ static u32 flexcan_copy_one_rxmb(struct flexcan_priv *priv, int i)
 	mb = &regs->cantxfg[i];
 	dst = &priv->cantxfg_copy[priv->rx_idx];
 	reg_ctrl = flexcan_read(&mb->can_ctrl);
-	code = (reg_ctrl & FLEXCAN_MB_CODE_MASK) >> FLEXCAN_MB_CODE_SHIFT;
+	code = reg_ctrl & FLEXCAN_MB_CODE_MASK;
 
-	while (code & 1) {
+	while (code & FLEXCAN_MB_CODE_RX_BUSY_BIT) {
 		/* MB busy, shouldn't take long */
 		reg_ctrl = flexcan_read(&mb->can_ctrl);
-		code = (reg_ctrl & FLEXCAN_MB_CODE_MASK) >> FLEXCAN_MB_CODE_SHIFT;
+		code = reg_ctrl & FLEXCAN_MB_CODE_MASK;
 	}
 
 	/* Copy contents */
@@ -820,14 +823,15 @@ static u32 flexcan_copy_one_rxmb(struct flexcan_priv *priv, int i)
 	dst->data[1] = flexcan_read(&mb->data[1]);
 
 	/* If it's FULL or OVERRUN, clear the interrupt flag and lock MB */
-	if ((code == 0x2) || (code == 0x6)) {
+	if ((code == FLEXCAN_MB_CODE_RX_FULL) ||
+	    (code == FLEXCAN_MB_CODE_RX_OVERRRUN)) {
 		if (i < 32)
 			flexcan_write(BIT(i), &regs->iflag1);
 		else
 			flexcan_write(BIT(i - 32), &regs->iflag2);
-		flexcan_write(FLEXCAN_MB_CNT_CODE(0x0), &mb->can_ctrl);
-		if ((code == 0x6) || (priv->rx_idx ==
-				(ARRAY_SIZE(priv->cantxfg_copy) - 1))) {
+		flexcan_write(FLEXCAN_MB_CODE_RX_INACTIVE, &mb->can_ctrl);
+		if ((code == FLEXCAN_MB_CODE_RX_OVERRRUN) ||
+		    (priv->rx_idx == (ARRAY_SIZE(priv->cantxfg_copy) - 1))) {
 			/* This MB was overrun, we lost data */
 			priv->dev->stats.rx_over_errors++;
 			priv->dev->stats.rx_errors++;
@@ -848,9 +852,9 @@ static void flexcan_unlock_if_locked(struct flexcan_priv *priv, int i)
 
 	mb = &regs->cantxfg[i];
 	reg_ctrl = flexcan_read(&mb->can_ctrl);
-	code = (reg_ctrl & FLEXCAN_MB_CODE_MASK) >> FLEXCAN_MB_CODE_SHIFT;
-	if (!code)
-		flexcan_write(FLEXCAN_MB_CNT_CODE(0x4), &mb->can_ctrl);
+	code = reg_ctrl & FLEXCAN_MB_CODE_MASK;
+	if (code == FLEXCAN_MB_CODE_RX_INACTIVE)
+		flexcan_write(FLEXCAN_MB_CODE_RX_EMPTY, &mb->can_ctrl);
 }
 
 /*
@@ -897,7 +901,7 @@ static void flexcan_copy_rxmbs(struct flexcan_priv *priv, u32 iflag1, u32 iflag2
 	for(i = 1; i < 64; i++) {
 		if (i == FLEXCAN_TX_BUF_ID)
 			continue;
-		if (flexcan_copy_one_rxmb(priv, i) == 0x4)
+		if (flexcan_copy_one_rxmb(priv, i) == FLEXCAN_MB_CODE_RX_EMPTY)
 			break;
 	}
 
@@ -1099,10 +1103,10 @@ static int flexcan_chip_start(struct net_device *dev)
 	/* Prepare mailboxes. Skip the first, use one for TX the rest for RX */
 	for (i = 1; i < ARRAY_SIZE(regs->cantxfg); i++) {
 		if (i == FLEXCAN_TX_BUF_ID)
-			flexcan_write(FLEXCAN_MB_CNT_CODE(0x8),
+			flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
 				&regs->cantxfg[i].can_ctrl);
 		else
-			flexcan_write(FLEXCAN_MB_CNT_CODE(0x4),
+			flexcan_write(FLEXCAN_MB_CODE_RX_EMPTY,
 			      &regs->cantxfg[i].can_ctrl);
 		flexcan_write(0, &regs->rximr[i]); /* Clear filter */
 	}
-- 
2.1.0

