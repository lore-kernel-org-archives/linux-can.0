From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 02/12] can: flexcan: cleanup coding style and fix typos
Date: Tue,  1 Sep 2015 11:29:05 +0200
Message-ID: <1441099755-8601-3-git-send-email-mkl@pengutronix.de>
References: <1441099755-8601-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46572 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755300AbbIAJ3T (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Sep 2015 05:29:19 -0400
In-Reply-To: <1441099755-8601-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

This patch fixes up the coding style to make checkpatch happier. Some typos are
also fixed.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 90 ++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 52 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index c83f0f03482b..e9e8f095461c 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -63,10 +63,10 @@
 #define FLEXCAN_MCR_LPRIO_EN		BIT(13)
 #define FLEXCAN_MCR_AEN			BIT(12)
 #define FLEXCAN_MCR_MAXMB(x)		((x) & 0x7f)
-#define FLEXCAN_MCR_IDAM_A		(0 << 8)
-#define FLEXCAN_MCR_IDAM_B		(1 << 8)
-#define FLEXCAN_MCR_IDAM_C		(2 << 8)
-#define FLEXCAN_MCR_IDAM_D		(3 << 8)
+#define FLEXCAN_MCR_IDAM_A		(0x0 << 8)
+#define FLEXCAN_MCR_IDAM_B		(0x1 << 8)
+#define FLEXCAN_MCR_IDAM_C		(0x2 << 8)
+#define FLEXCAN_MCR_IDAM_D		(0x3 << 8)
 
 /* FLEXCAN control register (CANCTRL) bits */
 #define FLEXCAN_CTRL_PRESDIV(x)		(((x) & 0xff) << 24)
@@ -161,7 +161,7 @@
 #define FLEXCAN_MB_CODE_RX_INACTIVE	(0x0 << 24)
 #define FLEXCAN_MB_CODE_RX_EMPTY	(0x4 << 24)
 #define FLEXCAN_MB_CODE_RX_FULL		(0x2 << 24)
-#define FLEXCAN_MB_CODE_RX_OVERRRUN	(0x6 << 24)
+#define FLEXCAN_MB_CODE_RX_OVERRUN	(0x6 << 24)
 #define FLEXCAN_MB_CODE_RX_RANSWER	(0xa << 24)
 
 #define FLEXCAN_MB_CODE_TX_INACTIVE	(0x8 << 24)
@@ -175,12 +175,9 @@
 #define FLEXCAN_MB_CNT_LENGTH(x)	(((x) & 0xf) << 16)
 #define FLEXCAN_MB_CNT_TIMESTAMP(x)	((x) & 0xffff)
 
-#define FLEXCAN_MB_CODE_MASK		(0xf0ffffff)
+#define FLEXCAN_TIMEOUT_US		(50)
 
-#define FLEXCAN_TIMEOUT_US             (50)
-
-/*
- * FLEXCAN hardware feature flags
+/* FLEXCAN hardware feature flags
  *
  * Below is some version info we got:
  *    SOC   Version   IP-Version  Glitch- [TR]WRN_INT Memory err RTR re-
@@ -236,7 +233,7 @@ struct flexcan_regs {
 	 * 0x0e0...0x0ff	6-7	8 entry ID table
 	 *				(mx25, mx28, mx35, mx53)
 	 * 0x0e0...0x2df	6-7..37	8..128 entry ID table
-	 *			  	size conf'ed via ctrl2::RFFN
+	 *				size conf'ed via ctrl2::RFFN
 	 *				(mx6, vf610)
 	 */
 	u32 _reserved4[408];
@@ -272,10 +269,13 @@ struct flexcan_priv {
 static struct flexcan_devtype_data fsl_p1010_devtype_data = {
 	.features = FLEXCAN_HAS_BROKEN_ERR_STATE,
 };
+
 static struct flexcan_devtype_data fsl_imx28_devtype_data;
+
 static struct flexcan_devtype_data fsl_imx6q_devtype_data = {
 	.features = FLEXCAN_HAS_V10_FEATURES,
 };
+
 static struct flexcan_devtype_data fsl_vf610_devtype_data = {
 	.features = FLEXCAN_HAS_V10_FEATURES | FLEXCAN_HAS_MECR_FEATURES,
 };
@@ -292,11 +292,10 @@ static const struct can_bittiming_const flexcan_bittiming_const = {
 	.brp_inc = 1,
 };
 
-/*
- * Abstract off the read/write for arm versus ppc. This
+/* Abstract off the read/write for arm versus ppc. This
  * assumes that PPC uses big-endian registers and everything
  * else uses little-endian registers, independent of CPU
- * endianess.
+ * endianness.
  */
 #if defined(CONFIG_PPC)
 static inline u32 flexcan_read(void __iomem *addr)
@@ -434,7 +433,6 @@ static int flexcan_chip_softreset(struct flexcan_priv *priv)
 	return 0;
 }
 
-
 static int __flexcan_get_berr_counter(const struct net_device *dev,
 				      struct can_berr_counter *bec)
 {
@@ -477,6 +475,7 @@ static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct flexcan_regs __iomem *regs = priv->base;
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	u32 can_id;
+	u32 data;
 	u32 ctrl = FLEXCAN_MB_CODE_TX_DATA | (cf->can_dlc << 16);
 
 	if (can_dropped_invalid_skb(dev, skb))
@@ -495,11 +494,11 @@ static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		ctrl |= FLEXCAN_MB_CNT_RTR;
 
 	if (cf->can_dlc > 0) {
-		u32 data = be32_to_cpup((__be32 *)&cf->data[0]);
+		data = be32_to_cpup((__be32 *)&cf->data[0]);
 		flexcan_write(data, &regs->cantxfg[FLEXCAN_TX_BUF_ID].data[0]);
 	}
 	if (cf->can_dlc > 3) {
-		u32 data = be32_to_cpup((__be32 *)&cf->data[4]);
+		data = be32_to_cpup((__be32 *)&cf->data[4]);
 		flexcan_write(data, &regs->cantxfg[FLEXCAN_TX_BUF_ID].data[1]);
 	}
 
@@ -597,14 +596,14 @@ static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
 	flt = reg_esr & FLEXCAN_ESR_FLT_CONF_MASK;
 	if (likely(flt == FLEXCAN_ESR_FLT_CONF_ACTIVE)) {
 		tx_state = unlikely(reg_esr & FLEXCAN_ESR_TX_WRN) ?
-			   CAN_STATE_ERROR_WARNING : CAN_STATE_ERROR_ACTIVE;
+			CAN_STATE_ERROR_WARNING : CAN_STATE_ERROR_ACTIVE;
 		rx_state = unlikely(reg_esr & FLEXCAN_ESR_RX_WRN) ?
-			   CAN_STATE_ERROR_WARNING : CAN_STATE_ERROR_ACTIVE;
+			CAN_STATE_ERROR_WARNING : CAN_STATE_ERROR_ACTIVE;
 		new_state = max(tx_state, rx_state);
 	} else {
 		__flexcan_get_berr_counter(dev, &bec);
 		new_state = flt == FLEXCAN_ESR_FLT_CONF_PASSIVE ?
-			    CAN_STATE_ERROR_PASSIVE : CAN_STATE_BUS_OFF;
+			CAN_STATE_ERROR_PASSIVE : CAN_STATE_BUS_OFF;
 		rx_state = bec.rxerr >= bec.txerr ? new_state : 0;
 		tx_state = bec.rxerr <= bec.txerr ? new_state : 0;
 	}
@@ -687,8 +686,7 @@ static int flexcan_poll(struct napi_struct *napi, int quota)
 	u32 reg_iflag1, reg_esr;
 	int work_done = 0;
 
-	/*
-	 * The error bits are cleared on read,
+	/* The error bits are cleared on read,
 	 * use saved value from irq handler.
 	 */
 	reg_esr = flexcan_read(&regs->esr) | priv->reg_esr;
@@ -728,12 +726,12 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 
 	reg_iflag1 = flexcan_read(&regs->iflag1);
 	reg_esr = flexcan_read(&regs->esr);
+
 	/* ACK all bus error and state change IRQ sources */
 	if (reg_esr & FLEXCAN_ESR_ALL_INT)
 		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
 
-	/*
-	 * schedule NAPI in case of:
+	/* schedule NAPI in case of:
 	 * - rx IRQ
 	 * - state change IRQ
 	 * - bus error IRQ and bus error reporting is activated
@@ -741,15 +739,14 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
 	    (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
 	    flexcan_has_and_handle_berr(priv, reg_esr)) {
-		/*
-		 * The error bits are cleared on read,
+		/* The error bits are cleared on read,
 		 * save them for later use.
 		 */
 		priv->reg_esr = reg_esr & FLEXCAN_ESR_ERR_BUS;
 		flexcan_write(FLEXCAN_IFLAG_DEFAULT &
-			~FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->imask1);
+			      ~FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->imask1);
 		flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
-		       &regs->ctrl);
+			      &regs->ctrl);
 		napi_schedule(&priv->napi);
 	}
 
@@ -765,7 +762,8 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		stats->tx_bytes += can_get_echo_skb(dev, 0);
 		stats->tx_packets++;
 		can_led_event(dev, CAN_LED_EVENT_TX);
-		/* after sending a RTR frame mailbox is in RX mode */
+
+		/* after sending a RTR frame MB is in RX mode */
 		flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
 			      &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
 		flexcan_write((1 << FLEXCAN_TX_BUF_ID), &regs->iflag1);
@@ -813,8 +811,7 @@ static void flexcan_set_bittiming(struct net_device *dev)
 		   flexcan_read(&regs->mcr), flexcan_read(&regs->ctrl));
 }
 
-/*
- * flexcan_chip_start
+/* flexcan_chip_start
  *
  * this functions is entered with clocks enabled
  *
@@ -838,8 +835,7 @@ static int flexcan_chip_start(struct net_device *dev)
 
 	flexcan_set_bittiming(dev);
 
-	/*
-	 * MCR
+	/* MCR
 	 *
 	 * enable freeze
 	 * enable fifo
@@ -848,7 +844,6 @@ static int flexcan_chip_start(struct net_device *dev)
 	 * enable warning int
 	 * choose format C
 	 * disable local echo
-	 *
 	 */
 	reg_mcr = flexcan_read(&regs->mcr);
 	reg_mcr &= ~FLEXCAN_MCR_MAXMB(0xff);
@@ -859,8 +854,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	netdev_dbg(dev, "%s: writing mcr=0x%08x", __func__, reg_mcr);
 	flexcan_write(reg_mcr, &regs->mcr);
 
-	/*
-	 * CTRL
+	/* CTRL
 	 *
 	 * disable timer sync feature
 	 *
@@ -875,8 +869,8 @@ static int flexcan_chip_start(struct net_device *dev)
 	reg_ctrl &= ~FLEXCAN_CTRL_TSYN;
 	reg_ctrl |= FLEXCAN_CTRL_BOFF_REC | FLEXCAN_CTRL_LBUF |
 		FLEXCAN_CTRL_ERR_STATE;
-	/*
-	 * enable the "error interrupt" (FLEXCAN_CTRL_ERR_MSK),
+
+	/* enable the "error interrupt" (FLEXCAN_CTRL_ERR_MSK),
 	 * on most Flexcan cores, too. Otherwise we don't get
 	 * any error warning or passive interrupts.
 	 */
@@ -913,16 +907,14 @@ static int flexcan_chip_start(struct net_device *dev)
 	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
 		flexcan_write(0x0, &regs->rxfgmask);
 
-	/*
-	 * On Vybrid, disable memory error detection interrupts
+	/* On Vybrid, disable memory error detection interrupts
 	 * and freeze mode.
 	 * This also works around errata e5295 which generates
 	 * false positive memory errors and put the device in
 	 * freeze mode.
 	 */
 	if (priv->devtype_data->features & FLEXCAN_HAS_MECR_FEATURES) {
-		/*
-		 * Follow the protocol as described in "Detection
+		/* Follow the protocol as described in "Detection
 		 * and Correction of Memory Errors" to write to
 		 * MECR register
 		 */
@@ -934,7 +926,7 @@ static int flexcan_chip_start(struct net_device *dev)
 		reg_mecr &= ~FLEXCAN_MECR_ECRWRDIS;
 		flexcan_write(reg_mecr, &regs->mecr);
 		reg_mecr &= ~(FLEXCAN_MECR_NCEFAFRZ | FLEXCAN_MECR_HANCEI_MSK |
-				FLEXCAN_MECR_FANCEI_MSK);
+			      FLEXCAN_MECR_FANCEI_MSK);
 		flexcan_write(reg_mecr, &regs->mecr);
 	}
 
@@ -965,11 +957,9 @@ static int flexcan_chip_start(struct net_device *dev)
 	return err;
 }
 
-/*
- * flexcan_chip_stop
+/* flexcan_chip_stop
  *
  * this functions is entered with clocks enabled
- *
  */
 static void flexcan_chip_stop(struct net_device *dev)
 {
@@ -987,8 +977,6 @@ static void flexcan_chip_stop(struct net_device *dev)
 
 	flexcan_transceiver_disable(priv);
 	priv->can.state = CAN_STATE_STOPPED;
-
-	return;
 }
 
 static int flexcan_open(struct net_device *dev)
@@ -1114,8 +1102,7 @@ static int register_flexcandev(struct net_device *dev)
 		FLEXCAN_MCR_FEN | FLEXCAN_MCR_SUPV;
 	flexcan_write(reg, &regs->mcr);
 
-	/*
-	 * Currently we only support newer versions of this core
+	/* Currently we only support newer versions of this core
 	 * featuring a RX FIFO. Older cores found on some Coldfire
 	 * derivates are not yet supported.
 	 */
@@ -1180,7 +1167,7 @@ static int flexcan_probe(struct platform_device *pdev)
 
 	if (pdev->dev.of_node)
 		of_property_read_u32(pdev->dev.of_node,
-						"clock-frequency", &clock_freq);
+				     "clock-frequency", &clock_freq);
 
 	if (!clock_freq) {
 		clk_ipg = devm_clk_get(&pdev->dev, "ipg");
@@ -1237,7 +1224,6 @@ static int flexcan_probe(struct platform_device *pdev)
 	priv->clk_per = clk_per;
 	priv->pdata = dev_get_platdata(&pdev->dev);
 	priv->devtype_data = devtype_data;
-
 	priv->reg_xceiver = reg_xceiver;
 
 	netif_napi_add(dev, &priv->napi, flexcan_poll, FLEXCAN_NAPI_WEIGHT);
-- 
2.5.0

