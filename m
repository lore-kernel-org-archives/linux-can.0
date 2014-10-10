From: David Jander <david@protonic.nl>
Subject: [PATCH 15/15] can: flexcan: Re-enable RTR reception support for older flexcan IPs
Date: Fri, 10 Oct 2014 17:47:00 +0200
Message-ID: <1412956020-21489-16-git-send-email-david@protonic.nl>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:18412 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbaJJPrF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Oct 2014 11:47:05 -0400
In-Reply-To: <1412956020-21489-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>, David Jander <david@protonic.nl>

Flexcan IPs prior to V10 need to work in FIFO mode in order to be able
to receive RTR frames, so restore FIFO-mode for older IPs while still
using rx-fifo IRQ offloading.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/can/flexcan.c | 220 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 179 insertions(+), 41 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index b8d8058..9ac89b8 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -164,12 +164,19 @@
 
 /* FLEXCAN interrupt flag register (IFLAG) bits */
 /* Errata ERR005829 step7: Reserve first valid MB */
-#define FLEXCAN_TX_BUF_RESERVED		0
-#define FLEXCAN_TX_BUF_ID		1
-#define FLEXCAN_RX_AREA_START		(FLEXCAN_TX_BUF_ID + 1)
+#define FLEXCAN_V10_TX_BUF_RESERVED	0
+#define FLEXCAN_V10_TX_BUF_ID		1
+#define FLEXCAN_TX_BUF_ID		8
+#define FLEXCAN_RX_AREA_START		(FLEXCAN_V10_TX_BUF_ID + 1)
 #define FLEXCAN_IFLAG_BUF(x)		BIT(x)
 #define FLEXCAN_IFLAG1_DEFAULT 		(0xfffffffe)
 #define FLEXCAN_IFLAG2_DEFAULT 		(0xffffffff)
+#define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW	BIT(7)
+#define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
+#define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
+#define FLEXCAN_IFLAG_DEFAULT \
+	(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW | FLEXCAN_IFLAG_RX_FIFO_AVAILABLE | \
+	 FLEXCAN_IFLAG_BUF(FLEXCAN_TX_BUF_ID))
 
 /* FLEXCAN message buffers */
 #define FLEXCAN_MB_CODE_MASK		(0xf << 24)
@@ -286,6 +293,8 @@ struct flexcan_priv {
 	struct regulator *reg_xceiver;
 
 	struct can_rx_fifo fifo;
+
+	struct flexcan_mb __iomem *tx_mb;
 };
 
 static struct flexcan_devtype_data fsl_p1010_devtype_data = {
@@ -515,25 +524,27 @@ static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	if (cf->can_dlc > 0) {
 		u32 data = be32_to_cpup((__be32 *)&cf->data[0]);
-		flexcan_write(data, &regs->cantxfg[FLEXCAN_TX_BUF_ID].data[0]);
+		flexcan_write(data, &priv->tx_mb->data[0]);
 	}
 	if (cf->can_dlc > 3) {
 		u32 data = be32_to_cpup((__be32 *)&cf->data[4]);
-		flexcan_write(data, &regs->cantxfg[FLEXCAN_TX_BUF_ID].data[1]);
+		flexcan_write(data, &priv->tx_mb->data[1]);
 	}
 
 	can_put_echo_skb(skb, dev, 0);
 
-	flexcan_write(can_id, &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_id);
-	flexcan_write(ctrl, &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
+	flexcan_write(can_id, &priv->tx_mb->can_id);
+	flexcan_write(ctrl, &priv->tx_mb->can_ctrl);
 
-	/* Errata ERR005829 step8:
-	 * Write twice INACTIVE(0x8) code to first MB.
-	 */
-	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
-		      &regs->cantxfg[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
-	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
-		      &regs->cantxfg[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
+	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES) {
+		/* Errata ERR005829 step8:
+		 * Write twice INACTIVE(0x8) code to first MB.
+		 */
+		flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
+		      &regs->cantxfg[FLEXCAN_V10_TX_BUF_RESERVED].can_ctrl);
+		flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
+		      &regs->cantxfg[FLEXCAN_V10_TX_BUF_RESERVED].can_ctrl);
+	}
 
 	return NETDEV_TX_OK;
 }
@@ -814,7 +825,40 @@ static unsigned int flexcan_mailbox_move_to_buffer(struct can_rx_fifo *fifo,
 	return 1;
 }
 
-static irqreturn_t flexcan_irq(int irq, void *dev_id)
+static unsigned int flexcan_fifo_move_to_buffer(struct can_rx_fifo *fifo,
+		struct can_frame *cf, unsigned int n)
+{
+	struct flexcan_priv *priv = rx_fifo_to_priv(fifo);
+	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_mb __iomem *mb = &regs->cantxfg[0];
+	u32 reg_ctrl, reg_id, reg_iflag1;
+
+	reg_iflag1 = flexcan_read(&regs->iflag1);
+	if (!(reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE))
+		return 0;
+
+	reg_ctrl = flexcan_read(&mb->can_ctrl);
+	reg_id = flexcan_read(&mb->can_id);
+	if (reg_ctrl & FLEXCAN_MB_CNT_IDE)
+		cf->can_id = ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
+	else
+		cf->can_id = (reg_id >> 18) & CAN_SFF_MASK;
+
+	if (reg_ctrl & FLEXCAN_MB_CNT_RTR)
+		cf->can_id |= CAN_RTR_FLAG;
+	cf->can_dlc = get_can_dlc((reg_ctrl >> 16) & 0xf);
+
+	*(__be32 *)(cf->data + 0) = cpu_to_be32(flexcan_read(&mb->data[0]));
+	*(__be32 *)(cf->data + 4) = cpu_to_be32(flexcan_read(&mb->data[1]));
+
+	/* mark as read */
+	flexcan_write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
+	flexcan_read(&regs->timer);
+
+	return 1;
+}
+
+static irqreturn_t flexcan_v10_irq(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
 	struct net_device_stats *stats = &dev->stats;
@@ -842,11 +886,63 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	}
 
 	/* reception interrupt */
-	if ((reg_iflag1 & ~(1 << FLEXCAN_TX_BUF_ID)) || reg_iflag2) {
+	if ((reg_iflag1 & ~(1 << FLEXCAN_V10_TX_BUF_ID)) || reg_iflag2) {
 		can_rx_fifo_irq_offload(&priv->fifo);
 	}
 
 	/* transmission complete interrupt */
+	if (reg_iflag1 & (1 << FLEXCAN_V10_TX_BUF_ID)) {
+		stats->tx_bytes += can_get_echo_skb(dev, 0);
+		stats->tx_packets++;
+		can_led_event(dev, CAN_LED_EVENT_TX);
+		/* after sending a RTR frame mailbox is in RX mode */
+		flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
+			      &regs->cantxfg[FLEXCAN_V10_TX_BUF_ID].can_ctrl);
+		flexcan_write((1 << FLEXCAN_V10_TX_BUF_ID), &regs->iflag1);
+		netif_wake_queue(dev);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t flexcan_irq(int irq, void *dev_id)
+{
+	struct net_device *dev = dev_id;
+	struct net_device_stats *stats = &dev->stats;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->base;
+	u32 reg_iflag1, reg_esr;
+
+	reg_iflag1 = flexcan_read(&regs->iflag1);
+	reg_esr = flexcan_read(&regs->esr);
+	/* ACK all bus error and state change IRQ sources */
+	if (reg_esr & FLEXCAN_ESR_ALL_INT)
+		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
+
+	/* bus error IRQ and bus error reporting is activated */
+	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
+	    flexcan_has_and_handle_berr(priv, reg_esr)) {
+		/*
+		 * The error bits are cleared on read,
+		 * save them for later use and let napi poll get them.
+		 */
+		priv->reg_esr = reg_esr & FLEXCAN_ESR_ERR_BUS;
+		can_rx_fifo_irq_error(&priv->fifo);
+	}
+
+	/* reception interrupt */
+	if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) {
+		can_rx_fifo_irq_offload_simple(&priv->fifo);
+	}
+
+	/* FIFO overflow */
+	if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
+		flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->iflag1);
+		dev->stats.rx_over_errors++;
+		dev->stats.rx_errors++;
+	}
+
+	/* transmission complete interrupt */
 	if (reg_iflag1 & (1 << FLEXCAN_TX_BUF_ID)) {
 		stats->tx_bytes += can_get_echo_skb(dev, 0);
 		stats->tx_packets++;
@@ -938,11 +1034,18 @@ static int flexcan_chip_start(struct net_device *dev)
 	 *
 	 */
 	reg_mcr = flexcan_read(&regs->mcr);
-	reg_mcr &= ~(FLEXCAN_MCR_MAXMB(0xff) | FLEXCAN_MCR_FEN);
+	reg_mcr &= ~FLEXCAN_MCR_MAXMB(0xff);
+	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES) {
+		reg_mcr &= ~FLEXCAN_MCR_FEN;
+		reg_mcr |= FLEXCAN_MCR_BCC |
+			FLEXCAN_MCR_MAXMB(FLEXCAN_MCR_MAXMB_USED);
+	} else {
+		reg_mcr |= FLEXCAN_MCR_FEN |
+			FLEXCAN_MCR_MAXMB(FLEXCAN_TX_BUF_ID);
+	}
 	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT |
 		FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN |
-		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_SRX_DIS |
-		FLEXCAN_MCR_BCC | FLEXCAN_MCR_MAXMB(FLEXCAN_MCR_MAXMB_USED);
+		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_SRX_DIS;
 	netdev_dbg(dev, "%s: writing mcr=0x%08x", __func__, reg_mcr);
 	flexcan_write(reg_mcr, &regs->mcr);
 
@@ -986,19 +1089,31 @@ static int flexcan_chip_start(struct net_device *dev)
 	}
 
 	/* Prepare RX mailboxes */
-	for (i = FLEXCAN_RX_AREA_START; i < ARRAY_SIZE(regs->cantxfg); i++) {
-		flexcan_write(FLEXCAN_MB_CODE_RX_EMPTY,
-		      &regs->cantxfg[i].can_ctrl);
-		flexcan_write(0, &regs->rximr[i]); /* Clear filter */
+	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES) {
+		/* Prepare RX mailboxes */
+		for (i = FLEXCAN_RX_AREA_START; i < ARRAY_SIZE(regs->cantxfg);
+		     i++) {
+			flexcan_write(FLEXCAN_MB_CODE_RX_EMPTY,
+			      &regs->cantxfg[i].can_ctrl);
+			flexcan_write(0, &regs->rximr[i]); /* Clear filter */
+		}
+	} else {
+		/* clear and invalidate all mailboxes first */
+		for (i = FLEXCAN_TX_BUF_ID; i < ARRAY_SIZE(regs->cantxfg);
+		     i++) {
+			flexcan_write(FLEXCAN_MB_CODE_RX_INACTIVE,
+				      &regs->cantxfg[i].can_ctrl);
+		}
 	}
 
 	/* Prepare TX mailbox */
-	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
-		&regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
+	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE, &priv->tx_mb->can_ctrl);
 
-	/* Errata ERR005829: mark first TX mailbox as INACTIVE */
-	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
-		      &regs->cantxfg[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
+	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES) {
+		/* Errata ERR005829: mark first TX mailbox as INACTIVE */
+		flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
+		      &regs->cantxfg[FLEXCAN_V10_TX_BUF_RESERVED].can_ctrl);
+	}
 
 	/* acceptance mask/acceptance code (accept everything) */
 	flexcan_write(0x0, &regs->rxgmask);
@@ -1036,11 +1151,17 @@ static int flexcan_chip_start(struct net_device *dev)
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
-	can_rx_fifo_reset(&priv->fifo);
+	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
+		can_rx_fifo_reset(&priv->fifo);
 
-	/* enable all MB interrupts */
-	flexcan_write(FLEXCAN_IFLAG1_DEFAULT, &regs->imask1);
-	flexcan_write(FLEXCAN_IFLAG2_DEFAULT, &regs->imask2);
+	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES) {
+		/* enable all MB interrupts */
+		flexcan_write(FLEXCAN_IFLAG1_DEFAULT, &regs->imask1);
+		flexcan_write(FLEXCAN_IFLAG2_DEFAULT, &regs->imask2);
+	} else {
+		/* enable FIFO interrupts */
+		flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
+	}
 
 	/* synchronize with the can bus */
 	err = flexcan_chip_unfreeze(priv);
@@ -1090,6 +1211,7 @@ static int flexcan_open(struct net_device *dev)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
 	int err;
+	irq_handler_t handler;
 
 	err = clk_prepare_enable(priv->clk_ipg);
 	if (err)
@@ -1103,7 +1225,12 @@ static int flexcan_open(struct net_device *dev)
 	if (err)
 		goto out_disable_per;
 
-	err = request_irq(dev->irq, flexcan_irq, IRQF_SHARED, dev->name, dev);
+	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
+		handler = flexcan_v10_irq;
+	else
+		handler = flexcan_irq;
+
+	err = request_irq(dev->irq, handler, IRQF_SHARED, dev->name, dev);
 	if (err)
 		goto out_close;
 
@@ -1260,6 +1387,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	const struct flexcan_devtype_data *devtype_data;
 	struct net_device *dev;
 	struct flexcan_priv *priv;
+	struct flexcan_regs __iomem *regs;
 	struct resource *mem;
 	struct clk *clk_ipg = NULL, *clk_per = NULL;
 	void __iomem *base;
@@ -1320,7 +1448,11 @@ static int flexcan_probe(struct platform_device *pdev)
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 		CAN_CTRLMODE_LISTENONLY	| CAN_CTRLMODE_3_SAMPLES |
 		CAN_CTRLMODE_BERR_REPORTING;
-	priv->base = base;
+	regs = priv->base = base;
+	if (devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
+		priv->tx_mb = &regs->cantxfg[FLEXCAN_V10_TX_BUF_ID];
+	else
+		priv->tx_mb = &regs->cantxfg[FLEXCAN_TX_BUF_ID];
 	priv->dev = dev;
 	priv->clk_ipg = clk_ipg;
 	priv->clk_per = clk_per;
@@ -1332,15 +1464,21 @@ static int flexcan_probe(struct platform_device *pdev)
 		priv->reg_xceiver = NULL;
 
 	/* Fill in RX-FIFO */
-	priv->fifo.low_first = FLEXCAN_RX_AREA_START;
-	priv->fifo.high_first = 32; /* FIXME: #define */
-	priv->fifo.high_last = 63; /* FIXME: #define */
-	priv->fifo.mailbox_enable_mask = flexcan_mailbox_enable_mask;
-	priv->fifo.mailbox_enable = flexcan_mailbox_enable;
-	priv->fifo.mailbox_move_to_buffer = flexcan_mailbox_move_to_buffer;
 	priv->fifo.poll_can_state = flexcan_poll_state;
 	priv->fifo.poll_bus_error = flexcan_poll_bus_err;
-	can_rx_fifo_add(dev, &priv->fifo);
+	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES) {
+		priv->fifo.low_first = FLEXCAN_RX_AREA_START;
+		priv->fifo.high_first = 32; /* FIXME: #define */
+		priv->fifo.high_last = 63; /* FIXME: #define */
+		priv->fifo.mailbox_enable_mask = flexcan_mailbox_enable_mask;
+		priv->fifo.mailbox_enable = flexcan_mailbox_enable;
+		priv->fifo.mailbox_move_to_buffer =
+			flexcan_mailbox_move_to_buffer;
+		can_rx_fifo_add(dev, &priv->fifo);
+	} else {
+		priv->fifo.mailbox_move_to_buffer = flexcan_fifo_move_to_buffer;
+		can_rx_fifo_add_simple(dev, &priv->fifo);
+	}
 
 	platform_set_drvdata(pdev, dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
-- 
1.9.1

