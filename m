From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 10/11] can: flexcan: add support for rx-fifo based software FIFO implementation
Date: Thu, 10 Dec 2015 13:33:56 +0100
Message-ID: <1449750837-11376-11-git-send-email-mkl@pengutronix.de>
References: <1449750837-11376-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48273 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753449AbbLJMdq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Dec 2015 07:33:46 -0500
In-Reply-To: <1449750837-11376-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, bhupesh.sharma@freescale.com, Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 184 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 157 insertions(+), 27 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 1b3a784607c9..1482d10917a5 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -3,7 +3,8 @@
  *
  * Copyright (c) 2005-2006 Varma Electronics Oy
  * Copyright (c) 2009 Sascha Hauer, Pengutronix
- * Copyright (c) 2010 Marc Kleine-Budde, Pengutronix
+ * Copyright (c) 2010-2015 Marc Kleine-Budde, Pengutronix
+ * Copyright (c) 2014 David Jander, Protonic Holland
  *
  * Based on code originally by Andrey Volkov <avolkov@varma-el.com>
  *
@@ -59,6 +60,7 @@
 #define FLEXCAN_MCR_IRMQ		BIT(16)
 #define FLEXCAN_MCR_LPRIO_EN		BIT(13)
 #define FLEXCAN_MCR_AEN			BIT(12)
+/* MCR_MAXMB: maximum used MBs is MAXMB + 1 */
 #define FLEXCAN_MCR_MAXMB(x)		((x) & 0x7f)
 #define FLEXCAN_MCR_IDAM_A		(0x0 << 8)
 #define FLEXCAN_MCR_IDAM_B		(0x1 << 8)
@@ -146,12 +148,19 @@
 /* Errata ERR005829 step7: Reserve first valid MB */
 #define FLEXCAN_TX_MB_RESERVED_HW_FIFO	8
 #define FLEXCAN_TX_MB_HW_FIFO		9
+#define FLEXCAN_TX_MB_RESERVED_SW_FIFO	0
+#define FLEXCAN_TX_MB_SW_FIFO		1
+#define FLEXCAN_RX_MB_LOW_FIRST		(FLEXCAN_TX_MB_SW_FIFO + 1)
+#define FLEXCAN_RX_MB_HIGH_FIRST	32
+#define FLEXCAN_RX_MB_HIGH_LAST		63
 #define FLEXCAN_IFLAG_MB(x)		BIT(x)
 #define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW	BIT(7)
 #define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
 #define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
 
 /* FLEXCAN message buffers */
+#define FLEXCAN_MB_CODE_MASK		(0xf << 24)
+#define FLEXCAN_MB_CODE_RX_BUSY_BIT	(0x1 << 24)
 #define FLEXCAN_MB_CODE_RX_INACTIVE	(0x0 << 24)
 #define FLEXCAN_MB_CODE_RX_EMPTY	(0x4 << 24)
 #define FLEXCAN_MB_CODE_RX_FULL		(0x2 << 24)
@@ -189,6 +198,7 @@
 #define FLEXCAN_QUIRK_DISABLE_RXFG	BIT(2) /* Disable RX FIFO Global mask */
 #define FLEXCAN_QUIRK_ENABLE_EACEN_RRS	BIT(3) /* Enable EACEN and RRS bit in ctrl2 */
 #define FLEXCAN_QUIRK_DISABLE_MECR	BIT(4) /* Disble Memory error detection */
+#define FLEXCAN_QUIRK_USE_SW_FIFO	BIT(5) /* Use SW-FIFO */
 
 /* Structure of the message buffer */
 struct flexcan_mb {
@@ -653,6 +663,49 @@ static unsigned int flexcan_poll_state(struct can_rx_fifo *fifo)
 	return 1;
 }
 
+static void do_mailbox_enable(struct flexcan_mb __iomem *mb)
+{
+	u32 reg_ctrl;
+	u32 code;
+
+	do {
+		reg_ctrl = flexcan_read(&mb->can_ctrl);
+	} while (reg_ctrl & FLEXCAN_MB_CODE_RX_BUSY_BIT);
+
+	code = reg_ctrl & FLEXCAN_MB_CODE_MASK;
+	if (code == FLEXCAN_MB_CODE_RX_INACTIVE) {
+		flexcan_write(FLEXCAN_MB_CODE_RX_EMPTY, &mb->can_ctrl);
+	}
+}
+
+static void flexcan_mailbox_enable(struct can_rx_fifo *fifo, unsigned int n)
+{
+	struct flexcan_priv *priv = rx_fifo_to_priv(fifo);
+	struct flexcan_regs __iomem *regs = priv->regs;
+
+	do_mailbox_enable(&regs->mb[n]);
+
+	/* unlock mailbox */
+	flexcan_read(&regs->timer);
+}
+
+static void flexcan_mailbox_enable_mask(struct can_rx_fifo *fifo, u64 mask)
+{
+	struct flexcan_priv *priv = rx_fifo_to_priv(fifo);
+	struct flexcan_regs __iomem *regs = priv->regs;
+	unsigned int i;
+
+	for (i = priv->fifo.low_first; i <= priv->fifo.high_last; i++) {
+		if (!(mask & BIT_ULL(i)))
+			continue;
+
+		do_mailbox_enable(&regs->mb[i]);
+	}
+
+	/* unlock mailbox */
+	flexcan_read(&regs->timer);
+}
+
 static unsigned int flexcan_mailbox_read(struct can_rx_fifo *fifo,
 					 struct can_frame *cf, unsigned int n)
 {
@@ -661,11 +714,32 @@ static unsigned int flexcan_mailbox_read(struct can_rx_fifo *fifo,
 	struct flexcan_mb __iomem *mb = &regs->mb[n];
 	u32 reg_ctrl, reg_id, reg_iflag1;
 
-	reg_iflag1 = flexcan_read(&regs->iflag1);
-	if (!(reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE))
-		return 0;
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_SW_FIFO) {
+		u32 code;
+
+		do {
+			reg_ctrl = flexcan_read(&mb->can_ctrl);
+		} while (reg_ctrl & FLEXCAN_MB_CODE_RX_BUSY_BIT);
+
+		/* is this MB empty? */
+		code = reg_ctrl & FLEXCAN_MB_CODE_MASK;
+		if ((code != FLEXCAN_MB_CODE_RX_FULL) &&
+		    (code != FLEXCAN_MB_CODE_RX_OVERRUN))
+			return 0;
+
+		if (code == FLEXCAN_MB_CODE_RX_OVERRUN) {
+			/* This MB was overrun, we lost data */
+			fifo->dev->stats.rx_over_errors++;
+			fifo->dev->stats.rx_errors++;
+		}
+	} else {
+		reg_iflag1 = flexcan_read(&regs->iflag1);
+		if (!(reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE))
+			return 0;
+
+		reg_ctrl = flexcan_read(&mb->can_ctrl);
+	}
 
-	reg_ctrl = flexcan_read(&mb->can_ctrl);
 	reg_id = flexcan_read(&mb->can_id);
 	if (reg_ctrl & FLEXCAN_MB_CNT_IDE)
 		cf->can_id = ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
@@ -680,8 +754,18 @@ static unsigned int flexcan_mailbox_read(struct can_rx_fifo *fifo,
 	*(__be32 *)(cf->data + 4) = cpu_to_be32(flexcan_read(&mb->data[1]));
 
 	/* mark as read */
-	flexcan_write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
-	flexcan_read(&regs->timer);
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_SW_FIFO) {
+		/* Clear IRQ and lock MB */
+		if (n < 32)
+			flexcan_write(BIT(n), &regs->iflag1);
+		else
+			flexcan_write(BIT(n - 32), &regs->iflag2);
+
+		flexcan_write(FLEXCAN_MB_CODE_RX_INACTIVE, &mb->can_ctrl);
+	} else {
+		flexcan_write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
+		flexcan_read(&regs->timer);
+	}
 
 	return 1;
 }
@@ -722,14 +806,24 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	}
 
 	/* reception interrupt */
-	if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE)
-		can_rx_fifo_irq_offload_simple(&priv->fifo);
-
-	/* FIFO overflow */
-	if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
-		flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->iflag1);
-		dev->stats.rx_over_errors++;
-		dev->stats.rx_errors++;
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_SW_FIFO) {
+		u32 reg_iflag2;
+
+		reg_iflag2 = flexcan_read(&regs->iflag2);
+		if (reg_iflag1 & (priv->reg_imask1_default &
+				  ~FLEXCAN_IFLAG_MB(priv->tx_mb_idx)) ||
+		    reg_iflag2 & priv->reg_imask2_default)
+			can_rx_fifo_irq_offload(&priv->fifo);
+	} else {
+		if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE)
+			can_rx_fifo_irq_offload_simple(&priv->fifo);
+
+		/* FIFO overflow */
+		if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
+			flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->iflag1);
+			dev->stats.rx_over_errors++;
+			dev->stats.rx_errors++;
+		}
 	}
 
 	/* transmission complete interrupt */
@@ -824,10 +918,17 @@ static int flexcan_chip_start(struct net_device *dev)
 	 */
 	reg_mcr = flexcan_read(&regs->mcr);
 	reg_mcr &= ~FLEXCAN_MCR_MAXMB(0xff);
-	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_FEN | FLEXCAN_MCR_HALT |
-		FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN | FLEXCAN_MCR_SRX_DIS |
-		FLEXCAN_MCR_IRMQ | FLEXCAN_MCR_IDAM_C |
-		FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
+	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT | FLEXCAN_MCR_SUPV |
+		FLEXCAN_MCR_WRN_EN | FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_IRMQ |
+		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
+
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_SW_FIFO) {
+		reg_mcr &= ~FLEXCAN_MCR_FEN;
+		reg_mcr |= FLEXCAN_MCR_MAXMB(priv->fifo.high_last);
+	} else {
+		reg_mcr |= FLEXCAN_MCR_FEN |
+			FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
+	}
 	netdev_dbg(dev, "%s: writing mcr=0x%08x", __func__, reg_mcr);
 	flexcan_write(reg_mcr, &regs->mcr);
 
@@ -876,6 +977,12 @@ static int flexcan_chip_start(struct net_device *dev)
 			      &regs->mb[i].can_ctrl);
 	}
 
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_SW_FIFO) {
+		for (i = priv->fifo.low_first; i <= priv->fifo.high_last; i++)
+			flexcan_write(FLEXCAN_MB_CODE_RX_EMPTY,
+				      &regs->mb[i].can_ctrl);
+	}
+
 	/* Errata ERR005829: mark first TX mailbox as INACTIVE */
 	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
 		      &priv->tx_mb_reserved->can_ctrl);
@@ -1097,8 +1204,9 @@ static int register_flexcandev(struct net_device *dev)
 	flexcan_write(reg, &regs->mcr);
 
 	/* Currently we only support newer versions of this core
-	 * featuring a RX FIFO. Older cores found on some Coldfire
-	 * derivates are not yet supported.
+	 * featuring a RX hardware FIFO (although this driver doesn't
+	 * make use of it on some cores). Older cores, found on some
+	 * Coldfire derivates are not tested.
 	 */
 	reg = flexcan_read(&regs->mcr);
 	if (!(reg & FLEXCAN_MCR_FEN)) {
@@ -1220,13 +1328,16 @@ static int flexcan_probe(struct platform_device *pdev)
 	priv->devtype_data = devtype_data;
 	priv->reg_xceiver = reg_xceiver;
 
-	priv->tx_mb_idx = FLEXCAN_TX_MB_HW_FIFO;
-	priv->tx_mb_reserved = &regs->mb[FLEXCAN_TX_MB_RESERVED_HW_FIFO];
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_SW_FIFO) {
+		priv->tx_mb_idx = FLEXCAN_TX_MB_SW_FIFO;
+		priv->tx_mb_reserved = &regs->mb[FLEXCAN_TX_MB_RESERVED_SW_FIFO];
+	} else {
+		priv->tx_mb_idx = FLEXCAN_TX_MB_HW_FIFO;
+		priv->tx_mb_reserved = &regs->mb[FLEXCAN_TX_MB_RESERVED_HW_FIFO];
+	}
 	priv->tx_mb = &regs->mb[priv->tx_mb_idx];
 
-	priv->reg_imask1_default = FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
-		FLEXCAN_IFLAG_RX_FIFO_AVAILABLE |
-		FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
+	priv->reg_imask1_default = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
 	priv->reg_imask2_default = 0;
 
 	priv->fifo.poll_pre_read = flexcan_poll_state;
@@ -1235,7 +1346,26 @@ static int flexcan_probe(struct platform_device *pdev)
 		flexcan_poll_error_interrupts_enable;
 	priv->fifo.mailbox_read = flexcan_mailbox_read;
 
-	err = can_rx_fifo_add_simple(dev, &priv->fifo, FLEXCAN_NAPI_WEIGHT);
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_SW_FIFO) {
+		u64 imask;
+
+		priv->fifo.low_first = FLEXCAN_RX_MB_LOW_FIRST;
+		priv->fifo.high_first = FLEXCAN_RX_MB_HIGH_FIRST;
+		priv->fifo.high_last = FLEXCAN_RX_MB_HIGH_LAST;
+		priv->fifo.mailbox_enable_mask = flexcan_mailbox_enable_mask;
+		priv->fifo.mailbox_enable = flexcan_mailbox_enable;
+
+		imask = ~0LLU >> (64 + priv->fifo.low_first - priv->fifo.high_last - 1)
+			      << priv->fifo.low_first;
+		priv->reg_imask1_default |= imask;
+		priv->reg_imask2_default |= imask >> 32;
+
+		err = can_rx_fifo_add(dev, &priv->fifo);
+	} else {
+		priv->reg_imask1_default |= FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
+			FLEXCAN_IFLAG_RX_FIFO_AVAILABLE;
+		err = can_rx_fifo_add_simple(dev, &priv->fifo, FLEXCAN_NAPI_WEIGHT);
+	}
 	if (err)
 		goto failed_fifo;
 
-- 
2.6.2

