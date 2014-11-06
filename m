From: David Jander <david@protonic.nl>
Subject: [PATCH 13/14] can: flexcan: Add support for RX-FIFO
Date: Thu,  6 Nov 2014 09:34:12 +0100
Message-ID: <1415262853-22907-14-git-send-email-david@protonic.nl>
References: <1415262853-22907-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:26408 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbaKFIeI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Nov 2014 03:34:08 -0500
In-Reply-To: <1415262853-22907-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>, David Jander <david@protonic.nl>

Flexcan controllers have a hardware fifo, but that fifo is very small. On top
of that, it is read out from the NAPI-handler (soft IRQ). If we receive back-
to-back CAN frames at high baud-rate, the permissible latency from hard-IRQ to
NAPI is only 6 messages (the depth of the hardware FIFO).

Adding support for RX-FIFO (see can/dev.c) to this driver, improves both of
these aspects:

1. For V10 or newer flexcan IPs the whole 64 MB area is used as a virtual
   RX-FIFO.

2. RX-FIFO takes care of off-loading the flexcan controller directly from
   (hard-) interrupt into the RX-FIFO ring-buffer.

Unfortunately, flexcan IP cores older than V10 (V3.x) do not support receiving
RTR frames in a message-box. Therefor we cannot use the whole 64 MB area for
RX-FIFO in this case, but we still benefit a little from the faster
off-loading and NAPI handling from the RX-FIFO code.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/can/flexcan.c | 399 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 286 insertions(+), 113 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 20f5c0e..304b164 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2005-2006 Varma Electronics Oy
  * Copyright (c) 2009 Sascha Hauer, Pengutronix
  * Copyright (c) 2010 Marc Kleine-Budde, Pengutronix
+ * Copyright (c) 2014 David Jander, Protonic Holland
  *
  * Based on code originally by Andrey Volkov <avolkov@varma-el.com>
  *
@@ -24,6 +25,7 @@
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
 #include <linux/can/led.h>
+#include <linux/circ_buf.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/if_arp.h>
@@ -40,8 +42,8 @@
 
 #define DRV_NAME			"flexcan"
 
-/* 8 for RX fifo and 2 error handling */
-#define FLEXCAN_NAPI_WEIGHT		(8 + 2)
+/* 64 MB's */
+#define FLEXCAN_NAPI_WEIGHT		(64)
 
 /* FLEXCAN module configuration register (CANMCR) bits */
 #define FLEXCAN_MCR_MDIS		BIT(31)
@@ -63,6 +65,18 @@
 #define FLEXCAN_MCR_LPRIO_EN		BIT(13)
 #define FLEXCAN_MCR_AEN			BIT(12)
 #define FLEXCAN_MCR_MAXMB(x)		((x) & 0x7f)
+/*
+ * MCR_MAXMB:
+ * This field is 7 bits wide on V10 and newer flexcan cores, but the
+ * documentation of older versions states this field as being only 6 bits wide.
+ * This contradicts the fact that those cores still have 64 MB's, because with
+ * a 6-bit field the MAXMB value can never be higher than 63 (0x3f) which would
+ * implicate that the last MB could never be used. Since we cannot be sure
+ * whether just the documentation was wrong or older versions of the flexcan
+ * core can indeed not use the last MB, we chose the safest action and make
+ * this driver only use 63 MB's in every case for simplicity.
+ */
+#define FLEXCAN_MCR_MAXMB_USED		(0x3f)
 #define FLEXCAN_MCR_IDAM_A		(0 << 8)
 #define FLEXCAN_MCR_IDAM_B		(1 << 8)
 #define FLEXCAN_MCR_IDAM_C		(2 << 8)
@@ -113,6 +127,9 @@
 #define FLEXCAN_MECR_ECCDIS		BIT(8)
 #define FLEXCAN_MECR_NCEFAFRZ		BIT(7)
 
+/* FLEXCAN control register 2 (CTRL2) bits */
+#define FLEXCAN_CTRL2_EACEN		BIT(16)
+
 /* FLEXCAN error and status register (ESR) bits */
 #define FLEXCAN_ESR_TWRN_INT		BIT(17)
 #define FLEXCAN_ESR_RWRN_INT		BIT(16)
@@ -147,9 +164,13 @@
 
 /* FLEXCAN interrupt flag register (IFLAG) bits */
 /* Errata ERR005829 step7: Reserve first valid MB */
-#define FLEXCAN_TX_BUF_RESERVED		8
-#define FLEXCAN_TX_BUF_ID		9
+#define FLEXCAN_V10_TX_BUF_RESERVED	0
+#define FLEXCAN_V10_TX_BUF_ID		1
+#define FLEXCAN_TX_BUF_ID		8
+#define FLEXCAN_RX_AREA_START		(FLEXCAN_V10_TX_BUF_ID + 1)
 #define FLEXCAN_IFLAG_BUF(x)		BIT(x)
+#define FLEXCAN_IFLAG1_DEFAULT 		(0xfffffffe)
+#define FLEXCAN_IFLAG2_DEFAULT 		(0xffffffff)
 #define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW	BIT(7)
 #define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
 #define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
@@ -158,6 +179,8 @@
 	 FLEXCAN_IFLAG_BUF(FLEXCAN_TX_BUF_ID))
 
 /* FLEXCAN message buffers */
+#define FLEXCAN_MB_CODE_MASK		(0xf << 24)
+#define FLEXCAN_MB_CODE_RX_BUSY_BIT	(0x1 << 24)
 #define FLEXCAN_MB_CODE_RX_INACTIVE	(0x0 << 24)
 #define FLEXCAN_MB_CODE_RX_EMPTY	(0x4 << 24)
 #define FLEXCAN_MB_CODE_RX_FULL		(0x2 << 24)
@@ -175,8 +198,6 @@
 #define FLEXCAN_MB_CNT_LENGTH(x)	(((x) & 0xf) << 16)
 #define FLEXCAN_MB_CNT_TIMESTAMP(x)	((x) & 0xffff)
 
-#define FLEXCAN_MB_CODE_MASK		(0xf0ffffff)
-
 #define FLEXCAN_TIMEOUT_US             (50)
 
 /*
@@ -239,7 +260,9 @@ struct flexcan_regs {
 	 *			  	size conf'ed via ctrl2::RFFN
 	 *				(mx6, vf610)
 	 */
-	u32 _reserved4[408];
+	u32 _reserved4[256];	/* 0x480 */
+	u32 rximr[64];		/* 0x880 */
+	u32 _reserved5[88];	/* 0x980 */
 	u32 mecr;		/* 0xae0 */
 	u32 erriar;		/* 0xae4 */
 	u32 erridpr;		/* 0xae8 */
@@ -257,10 +280,10 @@ struct flexcan_devtype_data {
 struct flexcan_priv {
 	struct can_priv can;
 	struct net_device *dev;
-	struct napi_struct napi;
 
 	void __iomem *base;
 	u32 reg_esr;
+	u32 poll_esr;
 	u32 reg_ctrl_default;
 
 	struct clk *clk_ipg;
@@ -268,6 +291,10 @@ struct flexcan_priv {
 	struct flexcan_platform_data *pdata;
 	const struct flexcan_devtype_data *devtype_data;
 	struct regulator *reg_xceiver;
+
+	struct can_rx_fifo fifo;
+
+	struct flexcan_mb __iomem *tx_mb;
 };
 
 static struct flexcan_devtype_data fsl_p1010_devtype_data = {
@@ -497,29 +524,36 @@ static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
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
 
+static inline struct flexcan_priv *rx_fifo_to_priv(struct can_rx_fifo *fifo)
+{
+	return container_of(fifo, struct flexcan_priv, fifo);
+}
+
 static void do_bus_err(struct net_device *dev,
 		       struct can_frame *cf, u32 reg_esr)
 {
@@ -568,16 +602,21 @@ static void do_bus_err(struct net_device *dev,
 		dev->stats.tx_errors++;
 }
 
-static int flexcan_poll_bus_err(struct net_device *dev, u32 reg_esr)
+static unsigned int flexcan_poll_bus_err(struct can_rx_fifo *fifo)
 {
+	struct flexcan_priv *priv = rx_fifo_to_priv(fifo);
+	struct net_device *dev = priv->dev;
 	struct sk_buff *skb;
 	struct can_frame *cf;
 
+	if (!flexcan_has_and_handle_berr(priv, priv->poll_esr))
+		return 0;
+
 	skb = alloc_can_err_skb(dev, &cf);
 	if (unlikely(!skb))
 		return 0;
 
-	do_bus_err(dev, cf, reg_esr);
+	do_bus_err(dev, cf, priv->poll_esr);
 	netif_receive_skb(skb);
 
 	dev->stats.rx_packets++;
@@ -659,17 +698,22 @@ static void do_state(struct net_device *dev,
 	}
 }
 
-static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
+static unsigned int flexcan_poll_state(struct can_rx_fifo *fifo)
 {
-	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_priv *priv = rx_fifo_to_priv(fifo);
+	struct net_device *dev = priv->dev;
+	struct flexcan_regs __iomem *regs = priv->base;
 	struct sk_buff *skb;
 	struct can_frame *cf;
 	enum can_state new_state;
 	int flt;
 
-	flt = reg_esr & FLEXCAN_ESR_FLT_CONF_MASK;
+	/* esr bits are clear-on-read, so save them for flexcan_poll_bus_err() */
+	priv->poll_esr = priv->reg_esr | flexcan_read(&regs->esr);
+
+	flt = priv->poll_esr & FLEXCAN_ESR_FLT_CONF_MASK;
 	if (likely(flt == FLEXCAN_ESR_FLT_CONF_ACTIVE)) {
-		if (likely(!(reg_esr & (FLEXCAN_ESR_TX_WRN |
+		if (likely(!(priv->poll_esr & (FLEXCAN_ESR_TX_WRN |
 					FLEXCAN_ESR_RX_WRN))))
 			new_state = CAN_STATE_ERROR_ACTIVE;
 		else
@@ -697,15 +741,66 @@ static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
 	return 1;
 }
 
-static void flexcan_read_fifo(const struct net_device *dev,
-			      struct can_frame *cf)
+static void flexcan_mailbox_enable(struct can_rx_fifo *fifo, unsigned int n)
 {
-	const struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_priv *priv = rx_fifo_to_priv(fifo);
 	struct flexcan_regs __iomem *regs = priv->base;
-	struct flexcan_mb __iomem *mb = &regs->cantxfg[0];
-	u32 reg_ctrl, reg_id;
+	struct flexcan_mb __iomem *mb;
+	u32 reg_ctrl;
+	u32 code;
 
+	mb = &regs->cantxfg[n];
 	reg_ctrl = flexcan_read(&mb->can_ctrl);
+	code = reg_ctrl & FLEXCAN_MB_CODE_MASK;
+	if (code == FLEXCAN_MB_CODE_RX_INACTIVE)
+		flexcan_write(FLEXCAN_MB_CODE_RX_EMPTY, &mb->can_ctrl);
+	flexcan_read(&regs->timer);
+}
+
+static void flexcan_mailbox_enable_mask(struct can_rx_fifo *fifo, u64 mask)
+{
+	struct flexcan_priv *priv = rx_fifo_to_priv(fifo);
+	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_mb __iomem *mb;
+	u32 reg_ctrl;
+	u32 code;
+	unsigned int n;
+
+	for (n = FLEXCAN_RX_AREA_START; n < ARRAY_SIZE(regs->cantxfg); n ++) {
+		mb = &regs->cantxfg[n];
+		reg_ctrl = flexcan_read(&mb->can_ctrl);
+		code = reg_ctrl & FLEXCAN_MB_CODE_MASK;
+		if ((mask & BIT_ULL(n)) && (code == FLEXCAN_MB_CODE_RX_INACTIVE))
+			flexcan_write(FLEXCAN_MB_CODE_RX_EMPTY, &mb->can_ctrl);
+	}
+	flexcan_read(&regs->timer);
+}
+
+static unsigned int flexcan_mailbox_move_to_buffer(struct can_rx_fifo *fifo,
+		struct can_frame *cf, unsigned int n)
+{
+	struct flexcan_priv *priv = rx_fifo_to_priv(fifo);
+	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_mb *mb = &regs->cantxfg[n];
+	u32 reg_ctrl, reg_id;
+	u32 code;
+
+	do {
+		reg_ctrl = flexcan_read(&mb->can_ctrl);
+		code = reg_ctrl & FLEXCAN_MB_CODE_MASK;
+	} while (code & FLEXCAN_MB_CODE_RX_BUSY_BIT);
+
+	/* is this MB empty? */
+	if ((code != FLEXCAN_MB_CODE_RX_FULL) &&
+	    (code != FLEXCAN_MB_CODE_RX_OVERRRUN))
+		return 0;
+
+	if (code == FLEXCAN_MB_CODE_RX_OVERRRUN) {
+		/* This MB was overrun, we lost data */
+		priv->dev->stats.rx_over_errors++;
+		priv->dev->stats.rx_errors++;
+	}
+
 	reg_id = flexcan_read(&mb->can_id);
 	if (reg_ctrl & FLEXCAN_MB_CNT_IDE)
 		cf->can_id = ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
@@ -719,71 +814,95 @@ static void flexcan_read_fifo(const struct net_device *dev,
 	*(__be32 *)(cf->data + 0) = cpu_to_be32(flexcan_read(&mb->data[0]));
 	*(__be32 *)(cf->data + 4) = cpu_to_be32(flexcan_read(&mb->data[1]));
 
-	/* mark as read */
-	flexcan_write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
-	flexcan_read(&regs->timer);
+	/* Clear IRQ and lock MB */
+	if (n < 32)
+		flexcan_write(BIT(n), &regs->iflag1);
+	else
+		flexcan_write(BIT(n - 32), &regs->iflag2);
+
+	flexcan_write(FLEXCAN_MB_CODE_RX_INACTIVE, &mb->can_ctrl);
+
+	return 1;
 }
 
-static int flexcan_read_frame(struct net_device *dev)
+static unsigned int flexcan_fifo_move_to_buffer(struct can_rx_fifo *fifo,
+		struct can_frame *cf, unsigned int n)
 {
-	struct net_device_stats *stats = &dev->stats;
-	struct can_frame *cf;
-	struct sk_buff *skb;
+	struct flexcan_priv *priv = rx_fifo_to_priv(fifo);
+	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_mb __iomem *mb = &regs->cantxfg[0];
+	u32 reg_ctrl, reg_id, reg_iflag1;
 
-	skb = alloc_can_skb(dev, &cf);
-	if (unlikely(!skb)) {
-		stats->rx_dropped++;
+	reg_iflag1 = flexcan_read(&regs->iflag1);
+	if (!(reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE))
 		return 0;
-	}
 
-	flexcan_read_fifo(dev, cf);
-	netif_receive_skb(skb);
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
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->can_dlc;
+	*(__be32 *)(cf->data + 0) = cpu_to_be32(flexcan_read(&mb->data[0]));
+	*(__be32 *)(cf->data + 4) = cpu_to_be32(flexcan_read(&mb->data[1]));
 
-	can_led_event(dev, CAN_LED_EVENT_RX);
+	/* mark as read */
+	flexcan_write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
+	flexcan_read(&regs->timer);
 
 	return 1;
 }
 
-static int flexcan_poll(struct napi_struct *napi, int quota)
+static irqreturn_t flexcan_v10_irq(int irq, void *dev_id)
 {
-	struct net_device *dev = napi->dev;
-	const struct flexcan_priv *priv = netdev_priv(dev);
+	struct net_device *dev = dev_id;
+	struct net_device_stats *stats = &dev->stats;
+	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->base;
-	u32 reg_iflag1, reg_esr;
-	int work_done = 0;
+	u32 reg_iflag1, reg_iflag2, reg_esr;
 
-	/*
-	 * The error bits are cleared on read,
-	 * use saved value from irq handler.
-	 */
-	reg_esr = flexcan_read(&regs->esr) | priv->reg_esr;
+	reg_iflag1 = flexcan_read(&regs->iflag1);
+	reg_iflag2 = flexcan_read(&regs->iflag2);
+	reg_esr = flexcan_read(&regs->esr);
 
-	/* handle state changes */
-	work_done += flexcan_poll_state(dev, reg_esr);
+	/* ACK all bus error and state change IRQ sources */
+	if (reg_esr & FLEXCAN_ESR_ALL_INT)
+		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
 
-	/* handle RX-FIFO */
-	reg_iflag1 = flexcan_read(&regs->iflag1);
-	while (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE &&
-	       work_done < quota) {
-		work_done += flexcan_read_frame(dev);
-		reg_iflag1 = flexcan_read(&regs->iflag1);
+	/* bus error IRQ and bus error reporting is activated */
+	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
+	    flexcan_has_and_handle_berr(priv, reg_esr)) {
+		/*
+		 * The error bits are cleared on read,
+		 * save them for later use and let napi poll get them.
+		 */
+		priv->reg_esr = reg_esr & FLEXCAN_ESR_ERR_BUS;
+		can_rx_fifo_irq_error(&priv->fifo);
 	}
 
-	/* report bus errors */
-	if (flexcan_has_and_handle_berr(priv, reg_esr) && work_done < quota)
-		work_done += flexcan_poll_bus_err(dev, reg_esr);
+	/* reception interrupt */
+	if ((reg_iflag1 & ~(1 << FLEXCAN_V10_TX_BUF_ID)) || reg_iflag2) {
+		can_rx_fifo_irq_offload(&priv->fifo);
+	}
 
-	if (work_done < quota) {
-		napi_complete(napi);
-		/* enable IRQs */
-		flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
-		flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
+	/* transmission complete interrupt */
+	if (reg_iflag1 & (1 << FLEXCAN_V10_TX_BUF_ID)) {
+		stats->tx_bytes += can_get_echo_skb(dev, 0);
+		stats->tx_packets++;
+		can_led_event(dev, CAN_LED_EVENT_TX);
+		/* after sending a RTR frame mailbox is in RX mode */
+		flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
+			      &regs->cantxfg[FLEXCAN_V10_TX_BUF_ID].can_ctrl);
+		flexcan_write((1 << FLEXCAN_V10_TX_BUF_ID), &regs->iflag1);
+		netif_wake_queue(dev);
 	}
 
-	return work_done;
+	return IRQ_HANDLED;
 }
 
 static irqreturn_t flexcan_irq(int irq, void *dev_id)
@@ -800,25 +919,20 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	if (reg_esr & FLEXCAN_ESR_ALL_INT)
 		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
 
-	/*
-	 * schedule NAPI in case of:
-	 * - rx IRQ
-	 * - state change IRQ
-	 * - bus error IRQ and bus error reporting is activated
-	 */
-	if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
-	    (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
+	/* bus error IRQ and bus error reporting is activated */
+	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
 	    flexcan_has_and_handle_berr(priv, reg_esr)) {
 		/*
 		 * The error bits are cleared on read,
-		 * save them for later use.
+		 * save them for later use and let napi poll get them.
 		 */
 		priv->reg_esr = reg_esr & FLEXCAN_ESR_ERR_BUS;
-		flexcan_write(FLEXCAN_IFLAG_DEFAULT &
-			~FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->imask1);
-		flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
-		       &regs->ctrl);
-		napi_schedule(&priv->napi);
+		can_rx_fifo_irq_error(&priv->fifo);
+	}
+
+	/* reception interrupt */
+	if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) {
+		can_rx_fifo_irq_offload(&priv->fifo);
 	}
 
 	/* FIFO overflow */
@@ -921,10 +1035,17 @@ static int flexcan_chip_start(struct net_device *dev)
 	 */
 	reg_mcr = flexcan_read(&regs->mcr);
 	reg_mcr &= ~FLEXCAN_MCR_MAXMB(0xff);
-	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_FEN | FLEXCAN_MCR_HALT |
+	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES) {
+		reg_mcr &= ~FLEXCAN_MCR_FEN;
+		reg_mcr |= FLEXCAN_MCR_BCC |
+			FLEXCAN_MCR_MAXMB(FLEXCAN_MCR_MAXMB_USED);
+	} else {
+		reg_mcr |= FLEXCAN_MCR_FEN |
+			FLEXCAN_MCR_MAXMB(FLEXCAN_TX_BUF_ID);
+	}
+	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT |
 		FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN |
-		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_SRX_DIS |
-		FLEXCAN_MCR_MAXMB(FLEXCAN_TX_BUF_ID);
+		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_SRX_DIS;
 	netdev_dbg(dev, "%s: writing mcr=0x%08x", __func__, reg_mcr);
 	flexcan_write(reg_mcr, &regs->mcr);
 
@@ -960,28 +1081,45 @@ static int flexcan_chip_start(struct net_device *dev)
 	netdev_dbg(dev, "%s: writing ctrl=0x%08x", __func__, reg_ctrl);
 	flexcan_write(reg_ctrl, &regs->ctrl);
 
-	/* clear and invalidate all mailboxes first */
-	for (i = FLEXCAN_TX_BUF_ID; i < ARRAY_SIZE(regs->cantxfg); i++) {
-		flexcan_write(FLEXCAN_MB_CODE_RX_INACTIVE,
+	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES) {
+		/* CTRL2: Enable EACEN */
+		reg_ctrl2 = flexcan_read(&regs->ctrl2);
+		reg_ctrl2 |= FLEXCAN_CTRL2_EACEN | FLEXCAN_CTRL2_RRS;
+		flexcan_write(reg_ctrl2, &regs->ctrl2);
+	}
+
+	/* Prepare RX mailboxes */
+	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES) {
+		/* Prepare RX mailboxes */
+		for (i = FLEXCAN_RX_AREA_START; i < ARRAY_SIZE(regs->cantxfg);
+		     i++) {
+			flexcan_write(FLEXCAN_MB_CODE_RX_EMPTY,
 			      &regs->cantxfg[i].can_ctrl);
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
 
-	/* Errata ERR005829: mark first TX mailbox as INACTIVE */
-	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
-		      &regs->cantxfg[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
+	/* Prepare TX mailbox */
+	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE, &priv->tx_mb->can_ctrl);
 
-	/* mark TX mailbox as INACTIVE */
-	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
-		      &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
+	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES) {
+		/* Errata ERR005829: mark first TX mailbox as INACTIVE */
+		flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
+		      &regs->cantxfg[FLEXCAN_V10_TX_BUF_RESERVED].can_ctrl);
+	}
 
 	/* acceptance mask/acceptance code (accept everything) */
 	flexcan_write(0x0, &regs->rxgmask);
 	flexcan_write(0x0, &regs->rx14mask);
 	flexcan_write(0x0, &regs->rx15mask);
 
-	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
-		flexcan_write(0x0, &regs->rxfgmask);
-
 	/*
 	 * On Vybrid, disable memory error detection interrupts
 	 * and freeze mode.
@@ -1011,16 +1149,25 @@ static int flexcan_chip_start(struct net_device *dev)
 	if (err)
 		goto out_chip_disable;
 
+	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+
+	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
+		can_rx_fifo_reset(&priv->fifo);
+
+	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES) {
+		/* enable all MB interrupts */
+		flexcan_write(FLEXCAN_IFLAG1_DEFAULT, &regs->imask1);
+		flexcan_write(FLEXCAN_IFLAG2_DEFAULT, &regs->imask2);
+	} else {
+		/* enable FIFO interrupts */
+		flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
+	}
+
 	/* synchronize with the can bus */
 	err = flexcan_chip_unfreeze(priv);
 	if (err)
 		goto out_transceiver_disable;
 
-	priv->can.state = CAN_STATE_ERROR_ACTIVE;
-
-	/* enable FIFO interrupts */
-	flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
-
 	/* print chip status */
 	netdev_dbg(dev, "%s: reading mcr=0x%08x ctrl=0x%08x\n", __func__,
 		   flexcan_read(&regs->mcr), flexcan_read(&regs->ctrl));
@@ -1064,6 +1211,7 @@ static int flexcan_open(struct net_device *dev)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
 	int err;
+	irq_handler_t handler;
 
 	err = clk_prepare_enable(priv->clk_ipg);
 	if (err)
@@ -1077,7 +1225,12 @@ static int flexcan_open(struct net_device *dev)
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
 
@@ -1088,7 +1241,7 @@ static int flexcan_open(struct net_device *dev)
 
 	can_led_event(dev, CAN_LED_EVENT_OPEN);
 
-	napi_enable(&priv->napi);
+	can_rx_fifo_napi_enable(&priv->fifo);
 	netif_start_queue(dev);
 
 	return 0;
@@ -1110,7 +1263,7 @@ static int flexcan_close(struct net_device *dev)
 	struct flexcan_priv *priv = netdev_priv(dev);
 
 	netif_stop_queue(dev);
-	napi_disable(&priv->napi);
+	can_rx_fifo_napi_disable(&priv->fifo);
 	flexcan_chip_stop(dev);
 
 	free_irq(dev->irq, dev);
@@ -1234,6 +1387,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	const struct flexcan_devtype_data *devtype_data;
 	struct net_device *dev;
 	struct flexcan_priv *priv;
+	struct flexcan_regs __iomem *regs;
 	struct resource *mem;
 	struct clk *clk_ipg = NULL, *clk_per = NULL;
 	void __iomem *base;
@@ -1294,7 +1448,11 @@ static int flexcan_probe(struct platform_device *pdev)
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
@@ -1305,7 +1463,22 @@ static int flexcan_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->reg_xceiver))
 		priv->reg_xceiver = NULL;
 
-	netif_napi_add(dev, &priv->napi, flexcan_poll, FLEXCAN_NAPI_WEIGHT);
+	/* Fill in RX-FIFO */
+	priv->fifo.poll_can_state = flexcan_poll_state;
+	priv->fifo.poll_bus_error = flexcan_poll_bus_err;
+	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES) {
+		priv->fifo.low_first = FLEXCAN_RX_AREA_START;
+		priv->fifo.high_first = 32; /* FIXME: #define */
+		priv->fifo.high_last = 63; /* FIXME: #define */
+		priv->fifo.mailbox_enable_mask = flexcan_mailbox_enable_mask;
+		priv->fifo.mailbox_enable = flexcan_mailbox_enable;
+		priv->fifo.mailbox_move_to_buffer =
+			flexcan_mailbox_move_to_buffer;
+	} else {
+		priv->fifo.simple_offload = true;
+		priv->fifo.mailbox_move_to_buffer = flexcan_fifo_move_to_buffer;
+	}
+	can_rx_fifo_add(dev, &priv->fifo);
 
 	platform_set_drvdata(pdev, dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
@@ -1334,7 +1507,7 @@ static int flexcan_remove(struct platform_device *pdev)
 	struct flexcan_priv *priv = netdev_priv(dev);
 
 	unregister_flexcandev(dev);
-	netif_napi_del(&priv->napi);
+	can_rx_fifo_del(&priv->fifo);
 	free_candev(dev);
 
 	return 0;
-- 
1.9.1

