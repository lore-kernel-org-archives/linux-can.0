From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 11/12] can: flexcan: add support for timestamp based rx-offload
Date: Mon,  4 Jul 2016 20:32:16 +0200
Message-ID: <1467657137-18891-12-git-send-email-mkl@pengutronix.de>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42009 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752844AbcGDSmy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 4 Jul 2016 14:42:54 -0400
In-Reply-To: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

The flexcan IP core has 64 mailboxes. For now they are configured for
RX as a hardware FIFO. This FIFO has a fixed depth of 6 CAN frames. In
some high load scenarios it turns out thas this buffer is too small.

In order to have a buffer larger than the 6 frames FIFO, this patch adds
support for timestamp based offloading via the generic rx-offload
infrastructure.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 153 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 126 insertions(+), 27 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index c94a65dbb1c2..9867a5c9c9d4 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -3,7 +3,8 @@
  *
  * Copyright (c) 2005-2006 Varma Electronics Oy
  * Copyright (c) 2009 Sascha Hauer, Pengutronix
- * Copyright (c) 2010 Marc Kleine-Budde, Pengutronix
+ * Copyright (c) 2010-2016 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
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
@@ -146,12 +148,18 @@
 /* Errata ERR005829 step7: Reserve first valid MB */
 #define FLEXCAN_TX_MB_RESERVED_OFF_FIFO	8
 #define FLEXCAN_TX_MB_OFF_FIFO		9
+#define FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP	0
+#define FLEXCAN_TX_MB_OFF_TIMESTAMP		1
+#define FLEXCAN_RX_MB_OFF_TIMESTAMP_FIRST	(FLEXCAN_TX_MB_OFF_TIMESTAMP + 1)
+#define FLEXCAN_RX_MB_OFF_TIMESTAMP_LAST	63
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
@@ -189,6 +197,7 @@
 #define FLEXCAN_QUIRK_DISABLE_RXFG	BIT(2) /* Disable RX FIFO Global mask */
 #define FLEXCAN_QUIRK_ENABLE_EACEN_RRS	BIT(3) /* Enable EACEN and RRS bit in ctrl2 */
 #define FLEXCAN_QUIRK_DISABLE_MECR	BIT(4) /* Disble Memory error detection */
+#define FLEXCAN_QUIRK_USE_OFF_TIMESTAMP	BIT(5) /* Use timestamp based offloading */
 
 /* Structure of the message buffer */
 struct flexcan_mb {
@@ -265,6 +274,7 @@ struct flexcan_priv {
 	u32 poll_esr;			/* used in flexcan_poll_bus_err */
 	u32 reg_ctrl_default;
 	u32 reg_imask1_default;
+	u32 reg_imask2_default;
 
 	struct clk *clk_ipg;
 	struct clk *clk_per;
@@ -660,11 +670,32 @@ static unsigned int flexcan_mailbox_read(struct can_rx_offload *offload,
 	struct flexcan_mb __iomem *mb = &regs->mb[n];
 	u32 reg_ctrl, reg_id, reg_iflag1;
 
-	reg_iflag1 = flexcan_read(&regs->iflag1);
-	if (!(reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE))
-		return 0;
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
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
+			offload->dev->stats.rx_over_errors++;
+			offload->dev->stats.rx_errors++;
+		}
+	} else {
+		reg_iflag1 = flexcan_read(&regs->iflag1);
+		if (!(reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE))
+			return 0;
+
+		reg_ctrl = flexcan_read(&mb->can_ctrl);
+	}
 
-	reg_ctrl = flexcan_read(&mb->can_ctrl);
 	/* increase timstamp to full 32 bit */
 	*timestamp = reg_ctrl << 16;
 
@@ -682,8 +713,16 @@ static unsigned int flexcan_mailbox_read(struct can_rx_offload *offload,
 	*(__be32 *)(cf->data + 4) = cpu_to_be32(flexcan_read(&mb->data[1]));
 
 	/* mark as read */
-	flexcan_write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
-	flexcan_read(&regs->timer);
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
+		/* Clear IRQ */
+		if (n < 32)
+			flexcan_write(BIT(n), &regs->iflag1);
+		else
+			flexcan_write(BIT(n - 32), &regs->iflag2);
+	} else {
+		flexcan_write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
+		flexcan_read(&regs->timer);
+	}
 
 	return 1;
 }
@@ -696,6 +735,18 @@ static void flexcan_poll_error_interrupts_enable(struct can_rx_offload *offload)
 	flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
 }
 
+static inline u64 flexcan_read_reg_iflag_rx(struct flexcan_priv *priv)
+{
+	struct flexcan_regs __iomem *regs = priv->regs;
+	u32 iflag1, iflag2;
+
+	iflag2 = flexcan_read(&regs->iflag2) & priv->reg_imask2_default;
+	iflag1 = flexcan_read(&regs->iflag1) & priv->reg_imask1_default &
+		~FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
+
+	return (u64)iflag2 << 32 | iflag1;
+}
+
 static irqreturn_t flexcan_irq(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
@@ -724,14 +775,26 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	}
 
 	/* reception interrupt */
-	if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE)
-		can_rx_offload_irq_offload_fifo(&priv->offload);
-
-	/* FIFO overflow */
-	if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
-		flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->iflag1);
-		dev->stats.rx_over_errors++;
-		dev->stats.rx_errors++;
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
+		u64 reg_iflag;
+		int ret;
+
+		while ((reg_iflag = flexcan_read_reg_iflag_rx(priv))) {
+			ret = can_rx_offload_irq_offload_timestamp(&priv->offload,
+								   reg_iflag);
+			if (!ret)
+				break;
+		}
+	} else {
+		if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE)
+			can_rx_offload_irq_offload_fifo(&priv->offload);
+
+		/* FIFO overflow */
+		if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
+			flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->iflag1);
+			dev->stats.rx_over_errors++;
+			dev->stats.rx_errors++;
+		}
 	}
 
 	/* transmission complete interrupt */
@@ -826,10 +889,17 @@ static int flexcan_chip_start(struct net_device *dev)
 	 */
 	reg_mcr = flexcan_read(&regs->mcr);
 	reg_mcr &= ~FLEXCAN_MCR_MAXMB(0xff);
-	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_FEN | FLEXCAN_MCR_HALT |
-		FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN | FLEXCAN_MCR_SRX_DIS |
-		FLEXCAN_MCR_IRMQ | FLEXCAN_MCR_IDAM_C |
-		FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
+	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT | FLEXCAN_MCR_SUPV |
+		FLEXCAN_MCR_WRN_EN | FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_IRMQ |
+		FLEXCAN_MCR_IDAM_C;
+
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
+		reg_mcr &= ~FLEXCAN_MCR_FEN;
+		reg_mcr |= FLEXCAN_MCR_MAXMB(priv->offload.mb_last);
+	} else {
+		reg_mcr |= FLEXCAN_MCR_FEN |
+			FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
+	}
 	netdev_dbg(dev, "%s: writing mcr=0x%08x", __func__, reg_mcr);
 	flexcan_write(reg_mcr, &regs->mcr);
 
@@ -878,6 +948,12 @@ static int flexcan_chip_start(struct net_device *dev)
 			      &regs->mb[i].can_ctrl);
 	}
 
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
+		for (i = priv->offload.mb_first; i <= priv->offload.mb_last; i++)
+			flexcan_write(FLEXCAN_MB_CODE_RX_EMPTY,
+				      &regs->mb[i].can_ctrl);
+	}
+
 	/* Errata ERR005829: mark first TX mailbox as INACTIVE */
 	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
 		      &priv->tx_mb_reserved->can_ctrl);
@@ -936,6 +1012,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	disable_irq(dev->irq);
 	flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
 	flexcan_write(priv->reg_imask1_default, &regs->imask1);
+	flexcan_write(priv->reg_imask2_default, &regs->imask2);
 	enable_irq(dev->irq);
 
 	/* print chip status */
@@ -965,6 +1042,7 @@ static void flexcan_chip_stop(struct net_device *dev)
 	flexcan_chip_disable(priv);
 
 	/* Disable all interrupts */
+	flexcan_write(0, &regs->imask2);
 	flexcan_write(0, &regs->imask1);
 	flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
 		      &regs->ctrl);
@@ -1097,8 +1175,9 @@ static int register_flexcandev(struct net_device *dev)
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
@@ -1222,13 +1301,17 @@ static int flexcan_probe(struct platform_device *pdev)
 	priv->devtype_data = devtype_data;
 	priv->reg_xceiver = reg_xceiver;
 
-	priv->tx_mb_idx = FLEXCAN_TX_MB_OFF_FIFO;
-	priv->tx_mb_reserved = &regs->mb[FLEXCAN_TX_MB_RESERVED_OFF_FIFO];
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
+		priv->tx_mb_idx = FLEXCAN_TX_MB_OFF_TIMESTAMP;
+		priv->tx_mb_reserved = &regs->mb[FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP];
+	} else {
+		priv->tx_mb_idx = FLEXCAN_TX_MB_OFF_FIFO;
+		priv->tx_mb_reserved = &regs->mb[FLEXCAN_TX_MB_RESERVED_OFF_FIFO];
+	}
 	priv->tx_mb = &regs->mb[priv->tx_mb_idx];
 
-	priv->reg_imask1_default = FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
-		FLEXCAN_IFLAG_RX_FIFO_AVAILABLE |
-		FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
+	priv->reg_imask1_default = FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
+	priv->reg_imask2_default = 0;
 
 	priv->offload.poll_pre_read = flexcan_poll_state;
 	priv->offload.poll_post_read = flexcan_poll_bus_err;
@@ -1236,7 +1319,23 @@ static int flexcan_probe(struct platform_device *pdev)
 		flexcan_poll_error_interrupts_enable;
 	priv->offload.mailbox_read = flexcan_mailbox_read;
 
-	err = can_rx_offload_add_fifo(dev, &priv->offload, FLEXCAN_NAPI_WEIGHT);
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
+		u64 imask;
+
+		priv->offload.mb_first = FLEXCAN_RX_MB_OFF_TIMESTAMP_FIRST;
+		priv->offload.mb_last = FLEXCAN_RX_MB_OFF_TIMESTAMP_LAST;
+
+		imask = ~0LLU >> (64 + priv->offload.mb_first - priv->offload.mb_last - 1)
+			      << priv->offload.mb_first;
+		priv->reg_imask1_default |= imask;
+		priv->reg_imask2_default |= imask >> 32;
+
+		err = can_rx_offload_add_timestamp(dev, &priv->offload);
+	} else {
+		priv->reg_imask1_default |= FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
+			FLEXCAN_IFLAG_RX_FIFO_AVAILABLE;
+		err = can_rx_offload_add_fifo(dev, &priv->offload, FLEXCAN_NAPI_WEIGHT);
+	}
 	if (err)
 		goto failed_offload;
 
-- 
2.8.1

