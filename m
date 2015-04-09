From: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Subject: [PATCH 3/3] can: flexcan: Add support for non RX-FIFO mode and ERRATA ERR005829
Date: Thu, 9 Apr 2015 20:54:16 +0530
Message-ID: <1428593056-13701-3-git-send-email-bhupesh.sharma@freescale.com>
References: <1428593056-13701-1-git-send-email-bhupesh.sharma@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1bbn0104.outbound.protection.outlook.com ([157.56.111.104]:50592
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755268AbbDIPYl (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 9 Apr 2015 11:24:41 -0400
In-Reply-To: <1428593056-13701-1-git-send-email-bhupesh.sharma@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, mkl@pengutronix.de
Cc: arnd@arndb.de, bhupesh.linux@gmail.com, bhupesh.sharma@freescale.com, Sakar.Arora@freescale.com

This patch adds support for non RX-FIFO (legacy) mode and ERRATA
ERR005829 handling in flexcan driver.

Both these features are now selectable via Kconfig entries and hence can
be turned-on/off as per a SoC feature set availability.

ERRATA ERR005829 (A-008965) description:
---------------------------------------
FlexCAN RxFIFO feature is not supported

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Signed-off-by: Sakar Arora <Sakar.Arora@freescale.com>
---
 drivers/net/can/flexcan.c |  252 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 203 insertions(+), 49 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 3d91549..4bb7fc6 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -59,6 +59,7 @@
 #define FLEXCAN_MCR_WAK_SRC		BIT(19)
 #define FLEXCAN_MCR_DOZE		BIT(18)
 #define FLEXCAN_MCR_SRX_DIS		BIT(17)
+#define FLEXCAN_MCR_SRX_EN		~(BIT(17))
 #define FLEXCAN_MCR_BCC			BIT(16)
 #define FLEXCAN_MCR_LPRIO_EN		BIT(13)
 #define FLEXCAN_MCR_AEN			BIT(12)
@@ -146,16 +147,26 @@
 	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
 
 /* FLEXCAN interrupt flag register (IFLAG) bits */
+#ifdef CONFIG_CAN_FLEXCAN_ERRATA_ERR005829
 /* Errata ERR005829 step7: Reserve first valid MB */
 #define FLEXCAN_TX_BUF_RESERVED		8
 #define FLEXCAN_TX_BUF_ID		9
+#else
+#define FLEXCAN_TX_BUF_ID		8
+#endif
 #define FLEXCAN_IFLAG_BUF(x)		BIT(x)
 #define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW	BIT(7)
 #define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
 #define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
+#ifdef CONFIG_CAN_FLEXCAN_RX_FIFO_EN
 #define FLEXCAN_IFLAG_DEFAULT \
 	(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW | FLEXCAN_IFLAG_RX_FIFO_AVAILABLE | \
 	 FLEXCAN_IFLAG_BUF(FLEXCAN_TX_BUF_ID))
+#else
+#define FLEXCAN_IFLAG_DEFAULT \
+	(FLEXCAN_IFLAG_BUF(FLEXCAN_TX_BUF_ID))
+#define FLEXCAN_IFLAG_RXMASK	((1 << FLEXCAN_TX_BUF_ID) - 1)
+#endif
 
 /* FLEXCAN message buffers */
 #define FLEXCAN_MB_CNT_CODE(x)		(((x) & 0xf) << 24)
@@ -198,6 +209,7 @@
 #define FLEXCAN_HAS_V10_FEATURES	BIT(1) /* For core version >= 10 */
 #define FLEXCAN_HAS_BROKEN_ERR_STATE	BIT(2) /* [TR]WRN_INT not connected */
 #define FLEXCAN_HAS_MECR_FEATURES	BIT(3) /* Memory error detection */
+#define FLEXCAN_USES_RX_MB		BIT(4) /* Use msg-buf to rx frames */
 
 /* Structure of the message buffer */
 struct flexcan_mb {
@@ -277,7 +289,11 @@ static struct flexcan_devtype_data fsl_vf610_devtype_data = {
 };
 
 static struct flexcan_devtype_data fsl_ls1021a_devtype_data = {
-	.features = FLEXCAN_HAS_V10_FEATURES | FLEXCAN_HAS_MECR_FEATURES,
+	.features = FLEXCAN_HAS_V10_FEATURES | FLEXCAN_HAS_MECR_FEATURES
+#ifdef CONFIG_CAN_FLEXCAN_ERRATA_ERR008965
+	| FLEXCAN_USES_RX_MB
+#endif
+	,
 };
 
 static const struct can_bittiming_const flexcan_bittiming_const = {
@@ -414,6 +430,7 @@ static int flexcan_chip_unfreeze(struct flexcan_priv *priv)
 
 	reg = priv->read(&regs->mcr);
 	reg &= ~FLEXCAN_MCR_HALT;
+	reg &= ~FLEXCAN_MCR_FRZ;
 	priv->write(reg, &regs->mcr);
 
 	while (timeout-- && (priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
@@ -512,7 +529,7 @@ static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	priv->write(can_id, &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_id);
 	priv->write(ctrl, &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
-
+#ifdef CONFIG_CAN_FLEXCAN_ERRATA_ERR005829
 	/* Errata ERR005829 step8:
 	 * Write twice INACTIVE(0x8) code to first MB.
 	 */
@@ -520,6 +537,7 @@ static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		      &regs->cantxfg[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
 	priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
 		      &regs->cantxfg[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
+#endif
 
 	return NETDEV_TX_OK;
 }
@@ -663,7 +681,34 @@ static void flexcan_read_fifo(const struct net_device *dev,
 	priv->read(&regs->timer);
 }
 
-static int flexcan_read_frame(struct net_device *dev)
+static void flexcan_read_mailbox(const struct net_device *dev,
+				 struct can_frame *cf, u32 mailbox)
+{
+	const struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_mb __iomem *mb = &regs->cantxfg[mailbox];
+	u32 reg_ctrl, reg_id;
+
+	reg_ctrl = priv->read(&mb->can_ctrl);
+	reg_id = priv->read(&mb->can_id);
+	if (reg_ctrl & FLEXCAN_MB_CNT_IDE)
+		cf->can_id = ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
+	else
+		cf->can_id = (reg_id >> 18) & CAN_SFF_MASK;
+
+	if (reg_ctrl & FLEXCAN_MB_CNT_RTR)
+		cf->can_id |= CAN_RTR_FLAG;
+	cf->can_dlc = get_can_dlc((reg_ctrl >> 16) & 0xf);
+
+	*(__be32 *)(cf->data + 0) = cpu_to_be32(priv->read(&mb->data[0]));
+	*(__be32 *)(cf->data + 4) = cpu_to_be32(priv->read(&mb->data[1]));
+
+	/* mark as read */
+	priv->write(BIT(mailbox), &regs->iflag1);
+	priv->read(&regs->timer);
+}
+
+static int flexcan_read_frame_fifo_mode(struct net_device *dev)
 {
 	struct net_device_stats *stats = &dev->stats;
 	struct can_frame *cf;
@@ -676,6 +721,31 @@ static int flexcan_read_frame(struct net_device *dev)
 	}
 
 	flexcan_read_fifo(dev, cf);
+
+	netif_receive_skb(skb);
+
+	stats->rx_packets++;
+	stats->rx_bytes += cf->can_dlc;
+
+	can_led_event(dev, CAN_LED_EVENT_RX);
+
+	return 1;
+}
+
+static int flexcan_read_frame_legacy_mode(struct net_device *dev, u32 mailbox)
+{
+	struct net_device_stats *stats = &dev->stats;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+
+	skb = alloc_can_skb(dev, &cf);
+	if (unlikely(!skb)) {
+		stats->rx_dropped++;
+		return 0;
+	}
+
+	flexcan_read_mailbox(dev, cf, mailbox);
+
 	netif_receive_skb(skb);
 
 	stats->rx_packets++;
@@ -703,12 +773,29 @@ static int flexcan_poll(struct napi_struct *napi, int quota)
 	/* handle state changes */
 	work_done += flexcan_poll_state(dev, reg_esr);
 
-	/* handle RX-FIFO */
-	reg_iflag1 = priv->read(&regs->iflag1);
-	while (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE &&
-	       work_done < quota) {
-		work_done += flexcan_read_frame(dev);
+	if (!(priv->devtype_data->features & FLEXCAN_USES_RX_MB)) {
+		/* handle RX-FIFO */
 		reg_iflag1 = priv->read(&regs->iflag1);
+		while (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE &&
+		       work_done < quota) {
+			work_done += flexcan_read_frame_fifo_mode(dev);
+			reg_iflag1 = priv->read(&regs->iflag1);
+		}
+	} else {
+		unsigned long iflag1;
+		u32 mailbox;
+
+		/* handle RX-Buffers */
+		reg_iflag1 = priv->read(&regs->iflag1);
+		iflag1 = reg_iflag1 & FLEXCAN_IFLAG_RXMASK;
+		while ((reg_iflag1 & FLEXCAN_IFLAG_RXMASK) &&
+		       work_done < quota) {
+			mailbox = find_first_bit(&iflag1,
+						 (FLEXCAN_TX_BUF_ID - 1));
+			work_done += flexcan_read_frame_legacy_mode(dev,
+								    mailbox);
+			reg_iflag1 = priv->read(&regs->iflag1);
+		}
 	}
 
 	/* report bus errors */
@@ -718,7 +805,12 @@ static int flexcan_poll(struct napi_struct *napi, int quota)
 	if (work_done < quota) {
 		napi_complete(napi);
 		/* enable IRQs */
-		priv->write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
+		if (!(priv->devtype_data->features & FLEXCAN_USES_RX_MB))
+			priv->write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
+		else
+			priv->write(FLEXCAN_IFLAG_DEFAULT |
+				    FLEXCAN_IFLAG_RXMASK, &regs->imask1);
+
 		priv->write(priv->reg_ctrl_default, &regs->ctrl);
 	}
 
@@ -745,26 +837,43 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	 * - state change IRQ
 	 * - bus error IRQ and bus error reporting is activated
 	 */
-	if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
-	    (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
-	    flexcan_has_and_handle_berr(priv, reg_esr)) {
-		/*
-		 * The error bits are cleared on read,
-		 * save them for later use.
-		 */
-		priv->reg_esr = reg_esr & FLEXCAN_ESR_ERR_BUS;
-		priv->write(FLEXCAN_IFLAG_DEFAULT &
-			~FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->imask1);
-		priv->write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
-		       &regs->ctrl);
-		napi_schedule(&priv->napi);
-	}
+	if (!(priv->devtype_data->features & FLEXCAN_USES_RX_MB)) {
+		if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
+		    (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
+		    flexcan_has_and_handle_berr(priv, reg_esr)) {
+			/* The error bits are cleared on read,
+			 * save them for later use.
+			 */
+			priv->reg_esr = reg_esr & FLEXCAN_ESR_ERR_BUS;
+			priv->write(FLEXCAN_IFLAG_DEFAULT &
+				    ~FLEXCAN_IFLAG_RX_FIFO_AVAILABLE,
+				    &regs->imask1);
+			priv->write(priv->reg_ctrl_default &
+				    ~FLEXCAN_CTRL_ERR_ALL, &regs->ctrl);
+			napi_schedule(&priv->napi);
+		}
 
-	/* FIFO overflow */
-	if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
-		priv->write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->iflag1);
-		dev->stats.rx_over_errors++;
-		dev->stats.rx_errors++;
+		/* FIFO overflow */
+		if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
+			priv->write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW,
+				    &regs->iflag1);
+			dev->stats.rx_over_errors++;
+			dev->stats.rx_errors++;
+		}
+	} else {
+		if ((reg_iflag1 & FLEXCAN_IFLAG_RXMASK) ||
+		    (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
+		    flexcan_has_and_handle_berr(priv, reg_esr)) {
+			/* The error bits are cleared on read,
+			 * save them for later use.
+			 */
+			priv->reg_esr = reg_esr & FLEXCAN_ESR_ERR_BUS;
+			priv->write(priv->reg_ctrl_default &
+				    ~FLEXCAN_CTRL_ERR_ALL, &regs->ctrl);
+			priv->write(FLEXCAN_IFLAG_DEFAULT &
+				    ~FLEXCAN_IFLAG_RXMASK, &regs->imask1);
+			napi_schedule(&priv->napi);
+		}
 	}
 
 	/* transmission complete interrupt */
@@ -772,9 +881,12 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		stats->tx_bytes += can_get_echo_skb(dev, 0);
 		stats->tx_packets++;
 		can_led_event(dev, CAN_LED_EVENT_TX);
-		/* after sending a RTR frame mailbox is in RX mode */
-		priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
-			      &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
+
+		if (priv->devtype_data->features & FLEXCAN_USES_RX_MB)
+			/* after sending a RTR frame mailbox is in RX mode */
+			priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
+				    &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
+
 		priv->write((1 << FLEXCAN_TX_BUF_ID), &regs->iflag1);
 		netif_wake_queue(dev);
 	}
@@ -859,10 +971,19 @@ static int flexcan_chip_start(struct net_device *dev)
 	 */
 	reg_mcr = priv->read(&regs->mcr);
 	reg_mcr &= ~FLEXCAN_MCR_MAXMB(0xff);
-	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_FEN | FLEXCAN_MCR_HALT |
-		FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN |
-		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_SRX_DIS |
-		FLEXCAN_MCR_MAXMB(FLEXCAN_TX_BUF_ID);
+	if (!(priv->devtype_data->features & FLEXCAN_USES_RX_MB)) {
+		reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_FEN |
+			   FLEXCAN_MCR_HALT | FLEXCAN_MCR_SUPV |
+			   FLEXCAN_MCR_WRN_EN | FLEXCAN_MCR_IDAM_C |
+			   FLEXCAN_MCR_SRX_DIS |
+			   FLEXCAN_MCR_MAXMB(FLEXCAN_TX_BUF_ID);
+	} else {
+		reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT |
+			   FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN |
+			   FLEXCAN_MCR_IDAM_A |
+			   FLEXCAN_MCR_MAXMB(FLEXCAN_TX_BUF_ID);
+		reg_mcr &= FLEXCAN_MCR_SRX_EN;
+	}
 	netdev_dbg(dev, "%s: writing mcr=0x%08x", __func__, reg_mcr);
 	priv->write(reg_mcr, &regs->mcr);
 
@@ -899,26 +1020,45 @@ static int flexcan_chip_start(struct net_device *dev)
 	priv->write(reg_ctrl, &regs->ctrl);
 
 	/* clear and invalidate all mailboxes first */
-	for (i = FLEXCAN_TX_BUF_ID; i < ARRAY_SIZE(regs->cantxfg); i++) {
-		priv->write(FLEXCAN_MB_CODE_RX_INACTIVE,
-			      &regs->cantxfg[i].can_ctrl);
+	if (priv->devtype_data->features & FLEXCAN_USES_RX_MB) {
+		for (i = 0; i < ARRAY_SIZE(regs->cantxfg); i++) {
+			priv->write(0, &regs->cantxfg[i].can_ctrl);
+			priv->write(0, &regs->cantxfg[i].can_id);
+			priv->write(0, &regs->cantxfg[i].data[0]);
+			priv->write(0, &regs->cantxfg[i].data[1]);
+
+			/* put MB into rx queue */
+			priv->write(FLEXCAN_MB_CNT_CODE(0x4),
+				    &regs->cantxfg[i].can_ctrl);
+		}
+	} else {
+		for (i = FLEXCAN_TX_BUF_ID; i < ARRAY_SIZE(regs->cantxfg); i++)
+			priv->write(FLEXCAN_MB_CODE_RX_INACTIVE,
+				    &regs->cantxfg[i].can_ctrl);
 	}
 
+#ifdef CONFIG_CAN_FLEXCAN_ERRATA_ERR005829
 	/* Errata ERR005829: mark first TX mailbox as INACTIVE */
 	priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
 		      &regs->cantxfg[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
+#endif
 
-	/* mark TX mailbox as INACTIVE */
-	priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
-		      &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
+	if (!(priv->devtype_data->features & FLEXCAN_USES_RX_MB))
+		/* mark TX mailbox as INACTIVE */
+		priv->write(FLEXCAN_MB_CODE_TX_INACTIVE,
+			    &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
 
 	/* acceptance mask/acceptance code (accept everything) */
 	priv->write(0x0, &regs->rxgmask);
 	priv->write(0x0, &regs->rx14mask);
 	priv->write(0x0, &regs->rx15mask);
 
-	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
+	if (!(priv->devtype_data->features & FLEXCAN_USES_RX_MB)) {
+		if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
+			priv->write(0x0, &regs->rxfgmask);
+	} else {
 		priv->write(0x0, &regs->rxfgmask);
+	}
 
 	/*
 	 * On Vybrid, disable memory error detection interrupts
@@ -957,7 +1097,11 @@ static int flexcan_chip_start(struct net_device *dev)
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	/* enable FIFO interrupts */
-	priv->write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
+	if (!(priv->devtype_data->features & FLEXCAN_USES_RX_MB))
+		priv->write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
+	else
+		priv->write(FLEXCAN_IFLAG_DEFAULT | FLEXCAN_IFLAG_RXMASK,
+			    &regs->imask1);
 
 	/* print chip status */
 	netdev_dbg(dev, "%s: reading mcr=0x%08x ctrl=0x%08x\n", __func__,
@@ -1117,8 +1261,12 @@ static int register_flexcandev(struct net_device *dev)
 
 	/* set freeze, halt and activate FIFO, restrict register access */
 	reg = priv->read(&regs->mcr);
-	reg |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT |
-		FLEXCAN_MCR_FEN | FLEXCAN_MCR_SUPV;
+	if (!(priv->devtype_data->features & FLEXCAN_USES_RX_MB))
+		reg |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT |
+			FLEXCAN_MCR_FEN | FLEXCAN_MCR_SUPV;
+	else
+		reg |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT | FLEXCAN_MCR_SUPV;
+
 	priv->write(reg, &regs->mcr);
 
 	/*
@@ -1127,10 +1275,16 @@ static int register_flexcandev(struct net_device *dev)
 	 * derivates are not yet supported.
 	 */
 	reg = priv->read(&regs->mcr);
-	if (!(reg & FLEXCAN_MCR_FEN)) {
-		netdev_err(dev, "Could not enable RX FIFO, unsupported core\n");
-		err = -ENODEV;
-		goto out_chip_disable;
+
+	if (!(priv->devtype_data->features & FLEXCAN_USES_RX_MB)) {
+		if (!(reg & FLEXCAN_MCR_FEN)) {
+			netdev_err(dev, "Could not enable RX FIFO, unsupported core\n");
+			err = -ENODEV;
+			goto out_chip_disable;
+		}
+	} else {
+		if (!(reg & FLEXCAN_MCR_FEN))
+			netdev_info(dev, "Legacy mode (non-RX FIFO) enabled\n");
 	}
 
 	err = register_candev(dev);
-- 
1.7.9.5


