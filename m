From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 04/10] can: flexcan: make TX mailbox selectable during runtime
Date: Mon,  9 May 2016 12:52:28 +0200
Message-ID: <1462791154-13375-5-git-send-email-mkl@pengutronix.de>
References: <1462791154-13375-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47230 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751270AbcEIKwp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 May 2016 06:52:45 -0400
In-Reply-To: <1462791154-13375-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

This patch makes the TX mailbox selectable duing runtime. This is a preparation
patch to use of the hardware FIFO selectable via runtime. As the TX mailbox
number is different in HW FIFO and normal mode.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index b377e1069bf8..52065f2f92e0 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -143,9 +143,9 @@
 
 /* FLEXCAN interrupt flag register (IFLAG) bits */
 /* Errata ERR005829 step7: Reserve first valid MB */
-#define FLEXCAN_TX_BUF_RESERVED		8
-#define FLEXCAN_TX_BUF_ID		9
-#define FLEXCAN_IFLAG_BUF(x)		BIT(x)
+#define FLEXCAN_TX_MB_RESERVED_HW_FIFO	8
+#define FLEXCAN_TX_MB_HW_FIFO		9
+#define FLEXCAN_IFLAG_MB(x)		BIT(x)
 #define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW	BIT(7)
 #define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
 #define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
@@ -249,6 +249,9 @@ struct flexcan_priv {
 	struct napi_struct napi;
 
 	struct flexcan_regs __iomem *regs;
+	struct flexcan_mb __iomem *tx_mb;
+	struct flexcan_mb __iomem *tx_mb_reserved;
+	u8 tx_mb_idx;
 	u32 reg_esr;
 	u32 reg_ctrl_default;
 	u32 reg_imask1_default;
@@ -466,7 +469,6 @@ static int flexcan_get_berr_counter(const struct net_device *dev,
 static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	const struct flexcan_priv *priv = netdev_priv(dev);
-	struct flexcan_regs __iomem *regs = priv->regs;
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	u32 can_id;
 	u32 data;
@@ -489,25 +491,25 @@ static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	if (cf->can_dlc > 0) {
 		data = be32_to_cpup((__be32 *)&cf->data[0]);
-		flexcan_write(data, &regs->mb[FLEXCAN_TX_BUF_ID].data[0]);
+		flexcan_write(data, &priv->tx_mb->data[0]);
 	}
 	if (cf->can_dlc > 3) {
 		data = be32_to_cpup((__be32 *)&cf->data[4]);
-		flexcan_write(data, &regs->mb[FLEXCAN_TX_BUF_ID].data[1]);
+		flexcan_write(data, &priv->tx_mb->data[1]);
 	}
 
 	can_put_echo_skb(skb, dev, 0);
 
-	flexcan_write(can_id, &regs->mb[FLEXCAN_TX_BUF_ID].can_id);
-	flexcan_write(ctrl, &regs->mb[FLEXCAN_TX_BUF_ID].can_ctrl);
+	flexcan_write(can_id, &priv->tx_mb->can_id);
+	flexcan_write(ctrl, &priv->tx_mb->can_ctrl);
 
 	/* Errata ERR005829 step8:
 	 * Write twice INACTIVE(0x8) code to first MB.
 	 */
 	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
-		      &regs->mb[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
+		      &priv->tx_mb_reserved->can_ctrl);
 	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
-		      &regs->mb[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
+		      &priv->tx_mb_reserved->can_ctrl);
 
 	return NETDEV_TX_OK;
 }
@@ -752,15 +754,15 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	}
 
 	/* transmission complete interrupt */
-	if (reg_iflag1 & (1 << FLEXCAN_TX_BUF_ID)) {
+	if (reg_iflag1 & FLEXCAN_IFLAG_MB(priv->tx_mb_idx)) {
 		stats->tx_bytes += can_get_echo_skb(dev, 0);
 		stats->tx_packets++;
 		can_led_event(dev, CAN_LED_EVENT_TX);
 
 		/* after sending a RTR frame MB is in RX mode */
 		flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
-			      &regs->mb[FLEXCAN_TX_BUF_ID].can_ctrl);
-		flexcan_write((1 << FLEXCAN_TX_BUF_ID), &regs->iflag1);
+			      &priv->tx_mb->can_ctrl);
+		flexcan_write(FLEXCAN_IFLAG_MB(priv->tx_mb_idx), &regs->iflag1);
 		netif_wake_queue(dev);
 	}
 
@@ -844,7 +846,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	reg_mcr &= ~FLEXCAN_MCR_MAXMB(0xff);
 	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_FEN | FLEXCAN_MCR_HALT |
 		FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN | FLEXCAN_MCR_SRX_DIS |
-		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_MAXMB(FLEXCAN_TX_BUF_ID);
+		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
 	netdev_dbg(dev, "%s: writing mcr=0x%08x", __func__, reg_mcr);
 	flexcan_write(reg_mcr, &regs->mcr);
 
@@ -882,18 +884,18 @@ static int flexcan_chip_start(struct net_device *dev)
 	flexcan_write(reg_ctrl, &regs->ctrl);
 
 	/* clear and invalidate all mailboxes first */
-	for (i = FLEXCAN_TX_BUF_ID; i < ARRAY_SIZE(regs->mb); i++) {
+	for (i = priv->tx_mb_idx; i < ARRAY_SIZE(regs->mb); i++) {
 		flexcan_write(FLEXCAN_MB_CODE_RX_INACTIVE,
 			      &regs->mb[i].can_ctrl);
 	}
 
 	/* Errata ERR005829: mark first TX mailbox as INACTIVE */
 	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
-		      &regs->mb[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
+		      &priv->tx_mb_reserved->can_ctrl);
 
 	/* mark TX mailbox as INACTIVE */
 	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
-		      &regs->mb[FLEXCAN_TX_BUF_ID].can_ctrl);
+		      &priv->tx_mb->can_ctrl);
 
 	/* acceptance mask/acceptance code (accept everything) */
 	flexcan_write(0x0, &regs->rxgmask);
@@ -1225,9 +1227,13 @@ static int flexcan_probe(struct platform_device *pdev)
 	priv->devtype_data = devtype_data;
 	priv->reg_xceiver = reg_xceiver;
 
+	priv->tx_mb_idx = FLEXCAN_TX_MB_HW_FIFO;
+	priv->tx_mb_reserved = &regs->mb[FLEXCAN_TX_MB_RESERVED_HW_FIFO];
+	priv->tx_mb = &regs->mb[priv->tx_mb_idx];
+
 	priv->reg_imask1_default = FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
 		FLEXCAN_IFLAG_RX_FIFO_AVAILABLE |
-		FLEXCAN_IFLAG_BUF(FLEXCAN_TX_BUF_ID);
+		FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
 
 	netif_napi_add(dev, &priv->napi, flexcan_poll, FLEXCAN_NAPI_WEIGHT);
 
-- 
2.8.1

