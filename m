From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 07/12] can: flexcan: give member of flexcan_priv holding mailboxes a sensible name
Date: Tue,  1 Sep 2015 11:29:10 +0200
Message-ID: <1441099755-8601-8-git-send-email-mkl@pengutronix.de>
References: <1441099755-8601-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43326 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755351AbbIAJ3T (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Sep 2015 05:29:19 -0400
In-Reply-To: <1441099755-8601-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

This patch gives the member of flexcan_priv holding mailboxes a sensible name,
by renaming from "cantxfg" to "mb":

    struct flexcan_priv::cantxfg -> struct flexcan_priv::mb

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 72831c52ff53..28b6283aacf2 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -221,7 +221,7 @@ struct flexcan_regs {
 	u32 rxfgmask;		/* 0x48 */
 	u32 rxfir;		/* 0x4c */
 	u32 _reserved3[12];	/* 0x50 */
-	struct flexcan_mb cantxfg[64];	/* 0x80 */
+	struct flexcan_mb mb[64];	/* 0x80 */
 	/* FIFO-mode:
 	 *			MB
 	 * 0x080...0x08f	0	RX message buffer
@@ -491,25 +491,25 @@ static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	if (cf->can_dlc > 0) {
 		data = be32_to_cpup((__be32 *)&cf->data[0]);
-		flexcan_write(data, &regs->cantxfg[FLEXCAN_TX_BUF_ID].data[0]);
+		flexcan_write(data, &regs->mb[FLEXCAN_TX_BUF_ID].data[0]);
 	}
 	if (cf->can_dlc > 3) {
 		data = be32_to_cpup((__be32 *)&cf->data[4]);
-		flexcan_write(data, &regs->cantxfg[FLEXCAN_TX_BUF_ID].data[1]);
+		flexcan_write(data, &regs->mb[FLEXCAN_TX_BUF_ID].data[1]);
 	}
 
 	can_put_echo_skb(skb, dev, 0);
 
-	flexcan_write(can_id, &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_id);
-	flexcan_write(ctrl, &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
+	flexcan_write(can_id, &regs->mb[FLEXCAN_TX_BUF_ID].can_id);
+	flexcan_write(ctrl, &regs->mb[FLEXCAN_TX_BUF_ID].can_ctrl);
 
 	/* Errata ERR005829 step8:
 	 * Write twice INACTIVE(0x8) code to first MB.
 	 */
 	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
-		      &regs->cantxfg[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
+		      &regs->mb[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
 	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
-		      &regs->cantxfg[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
+		      &regs->mb[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
 
 	return NETDEV_TX_OK;
 }
@@ -629,7 +629,7 @@ static void flexcan_read_fifo(const struct net_device *dev,
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
-	struct flexcan_mb __iomem *mb = &regs->cantxfg[0];
+	struct flexcan_mb __iomem *mb = &regs->mb[0];
 	u32 reg_ctrl, reg_id;
 
 	reg_ctrl = flexcan_read(&mb->can_ctrl);
@@ -761,7 +761,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 
 		/* after sending a RTR frame MB is in RX mode */
 		flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
-			      &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
+			      &regs->mb[FLEXCAN_TX_BUF_ID].can_ctrl);
 		flexcan_write((1 << FLEXCAN_TX_BUF_ID), &regs->iflag1);
 		netif_wake_queue(dev);
 	}
@@ -882,18 +882,18 @@ static int flexcan_chip_start(struct net_device *dev)
 	flexcan_write(reg_ctrl, &regs->ctrl);
 
 	/* clear and invalidate all mailboxes first */
-	for (i = FLEXCAN_TX_BUF_ID; i < ARRAY_SIZE(regs->cantxfg); i++) {
+	for (i = FLEXCAN_TX_BUF_ID; i < ARRAY_SIZE(regs->mb); i++) {
 		flexcan_write(FLEXCAN_MB_CODE_RX_INACTIVE,
-			      &regs->cantxfg[i].can_ctrl);
+			      &regs->mb[i].can_ctrl);
 	}
 
 	/* Errata ERR005829: mark first TX mailbox as INACTIVE */
 	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
-		      &regs->cantxfg[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
+		      &regs->mb[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
 
 	/* mark TX mailbox as INACTIVE */
 	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
-		      &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
+		      &regs->mb[FLEXCAN_TX_BUF_ID].can_ctrl);
 
 	/* acceptance mask/acceptance code (accept everything) */
 	flexcan_write(0x0, &regs->rxgmask);
-- 
2.5.0

