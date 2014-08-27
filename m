From: David Jander <david@protonic.nl>
Subject: [PATCH 2/3] can: flexcan.c: Re-write receive path to use MB queue instead of FIFO
Date: Wed, 27 Aug 2014 11:58:06 +0200
Message-ID: <1409133487-23367-3-git-send-email-david@protonic.nl>
References: <1409133487-23367-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:17914 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933420AbaH0KTi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Aug 2014 06:19:38 -0400
In-Reply-To: <1409133487-23367-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, David Jander <david@protonic.nl>

The FlexCAN controller has a RX FIFO that is only 6 messages deep, and a
mailbox space capable of holding up to 63 messages.
This space was largely unused, limiting the permissible latency from
interrupt to NAPI to only 6 messages. This patch uses all available MBs
for message reception and frees the MBs in the IRQ handler to greatly
decrease the likelihood of receive overruns.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/can/flexcan.c | 303 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 226 insertions(+), 77 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index a9700f3..bf444ff 100644
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
@@ -40,8 +41,8 @@
 
 #define DRV_NAME			"flexcan"
 
-/* 8 for RX fifo and 2 error handling */
-#define FLEXCAN_NAPI_WEIGHT		(8 + 2)
+/* 64 MB's */
+#define FLEXCAN_NAPI_WEIGHT		(64)
 
 /* FLEXCAN module configuration register (CANMCR) bits */
 #define FLEXCAN_MCR_MDIS		BIT(31)
@@ -62,7 +63,7 @@
 #define FLEXCAN_MCR_BCC			BIT(16)
 #define FLEXCAN_MCR_LPRIO_EN		BIT(13)
 #define FLEXCAN_MCR_AEN			BIT(12)
-#define FLEXCAN_MCR_MAXMB(x)		((x) & 0x1f)
+#define FLEXCAN_MCR_MAXMB(x)		((x) & 0x7f)
 #define FLEXCAN_MCR_IDAM_A		(0 << 8)
 #define FLEXCAN_MCR_IDAM_B		(1 << 8)
 #define FLEXCAN_MCR_IDAM_C		(2 << 8)
@@ -92,6 +93,9 @@
 #define FLEXCAN_CTRL_ERR_ALL \
 	(FLEXCAN_CTRL_ERR_BUS | FLEXCAN_CTRL_ERR_STATE)
 
+/* FLEXCAN control register 2 (CTRL2) bits */
+#define FLEXCAN_CTRL2_EACEN		BIT(16)
+
 /* FLEXCAN error and status register (ESR) bits */
 #define FLEXCAN_ESR_TWRN_INT		BIT(17)
 #define FLEXCAN_ESR_RWRN_INT		BIT(16)
@@ -125,25 +129,22 @@
 	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
 
 /* FLEXCAN interrupt flag register (IFLAG) bits */
-#define FLEXCAN_TX_BUF_ID		8
+#define FLEXCAN_TX_BUF_ID		1
 #define FLEXCAN_IFLAG_BUF(x)		BIT(x)
-#define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW	BIT(7)
-#define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
-#define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
-#define FLEXCAN_IFLAG_DEFAULT \
-	(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW | FLEXCAN_IFLAG_RX_FIFO_AVAILABLE | \
-	 FLEXCAN_IFLAG_BUF(FLEXCAN_TX_BUF_ID))
+#define FLEXCAN_IFLAG1_DEFAULT 		(0xfffffffe)
+#define FLEXCAN_IFLAG2_DEFAULT 		(0xffffffff)
 
 /* FLEXCAN message buffers */
-#define FLEXCAN_MB_CNT_CODE(x)		(((x) & 0xf) << 24)
+#define FLEXCAN_MB_CODE_SHIFT		24
+#define FLEXCAN_MB_CODE_MASK		(0xf << FLEXCAN_MB_CODE_SHIFT)
+#define FLEXCAN_MB_CNT_CODE(x)		(((x) << FLEXCAN_MB_CODE_SHIFT) & \
+						FLEXCAN_MB_CODE_MASK)
 #define FLEXCAN_MB_CNT_SRR		BIT(22)
 #define FLEXCAN_MB_CNT_IDE		BIT(21)
 #define FLEXCAN_MB_CNT_RTR		BIT(20)
 #define FLEXCAN_MB_CNT_LENGTH(x)	(((x) & 0xf) << 16)
 #define FLEXCAN_MB_CNT_TIMESTAMP(x)	((x) & 0xffff)
 
-#define FLEXCAN_MB_CODE_MASK		(0xf0ffffff)
-
 #define FLEXCAN_TIMEOUT_US             (50)
 
 /*
@@ -185,15 +186,17 @@ struct flexcan_regs {
 	u32 imask1;		/* 0x28 */
 	u32 iflag2;		/* 0x2c */
 	u32 iflag1;		/* 0x30 */
-	u32 crl2;		/* 0x34 */
+	u32 ctrl2;		/* 0x34 */
 	u32 esr2;		/* 0x38 */
 	u32 imeur;		/* 0x3c */
 	u32 lrfr;		/* 0x40 */
 	u32 crcr;		/* 0x44 */
 	u32 rxfgmask;		/* 0x48 */
 	u32 rxfir;		/* 0x4c */
-	u32 _reserved3[12];
-	struct flexcan_mb cantxfg[64];
+	u32 _reserved3[12];	/* 0x50 */
+	struct flexcan_mb cantxfg[64]; /* 0x80 */
+	u32 _reserved4[256];	/* 0x480 */
+	u32 rximr[64];		/* 0x880 */
 };
 
 struct flexcan_devtype_data {
@@ -214,6 +217,9 @@ struct flexcan_priv {
 	struct flexcan_platform_data *pdata;
 	const struct flexcan_devtype_data *devtype_data;
 	struct regulator *reg_xceiver;
+	struct flexcan_mb cantxfg_copy[FLEXCAN_NAPI_WEIGHT];
+	int second_first;
+	u32 rx_idx;
 };
 
 static struct flexcan_devtype_data fsl_p1010_devtype_data = {
@@ -608,16 +614,30 @@ static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
 	return 1;
 }
 
-static void flexcan_read_fifo(const struct net_device *dev,
-			      struct can_frame *cf)
+static int flexcan_read_frame(struct net_device *dev, int n)
 {
-	const struct flexcan_priv *priv = netdev_priv(dev);
-	struct flexcan_regs __iomem *regs = priv->base;
-	struct flexcan_mb __iomem *mb = &regs->cantxfg[0];
+	struct net_device_stats *stats = &dev->stats;
+	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_mb *mb = &priv->cantxfg_copy[n];
+	struct can_frame *cf;
+	struct sk_buff *skb;
 	u32 reg_ctrl, reg_id;
+	u32 code;
 
-	reg_ctrl = flexcan_read(&mb->can_ctrl);
-	reg_id = flexcan_read(&mb->can_id);
+	reg_ctrl = mb->can_ctrl;
+	code = (reg_ctrl & FLEXCAN_MB_CODE_MASK) >> FLEXCAN_MB_CODE_SHIFT;
+
+	/* is this MB empty? */
+	if ((code != 0x2) && (code != 0x6))
+		return 0;
+
+	skb = alloc_can_skb(dev, &cf);
+	if (unlikely(!skb)) {
+		stats->rx_dropped++;
+		return 0;
+	}
+
+	reg_id = mb->can_id;
 	if (reg_ctrl & FLEXCAN_MB_CNT_IDE)
 		cf->can_id = ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
 	else
@@ -627,27 +647,9 @@ static void flexcan_read_fifo(const struct net_device *dev,
 		cf->can_id |= CAN_RTR_FLAG;
 	cf->can_dlc = get_can_dlc((reg_ctrl >> 16) & 0xf);
 
-	*(__be32 *)(cf->data + 0) = cpu_to_be32(flexcan_read(&mb->data[0]));
-	*(__be32 *)(cf->data + 4) = cpu_to_be32(flexcan_read(&mb->data[1]));
-
-	/* mark as read */
-	flexcan_write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
-	flexcan_read(&regs->timer);
-}
-
-static int flexcan_read_frame(struct net_device *dev)
-{
-	struct net_device_stats *stats = &dev->stats;
-	struct can_frame *cf;
-	struct sk_buff *skb;
+	*(__be32 *)(cf->data + 0) = cpu_to_be32(mb->data[0]);
+	*(__be32 *)(cf->data + 4) = cpu_to_be32(mb->data[1]);
 
-	skb = alloc_can_skb(dev, &cf);
-	if (unlikely(!skb)) {
-		stats->rx_dropped++;
-		return 0;
-	}
-
-	flexcan_read_fifo(dev, cf);
 	netif_receive_skb(skb);
 
 	stats->rx_packets++;
@@ -661,10 +663,16 @@ static int flexcan_read_frame(struct net_device *dev)
 static int flexcan_poll(struct napi_struct *napi, int quota)
 {
 	struct net_device *dev = napi->dev;
-	const struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->base;
-	u32 reg_iflag1, reg_esr;
+	u32 reg_esr;
 	int work_done = 0;
+	int n;
+	int ret;
+
+	/* disable RX IRQs */
+	flexcan_write((1 << FLEXCAN_TX_BUF_ID), &regs->imask1);
+	flexcan_write(0, &regs->imask2);
 
 	/*
 	 * The error bits are cleared on read,
@@ -675,12 +683,13 @@ static int flexcan_poll(struct napi_struct *napi, int quota)
 	/* handle state changes */
 	work_done += flexcan_poll_state(dev, reg_esr);
 
-	/* handle RX-FIFO */
-	reg_iflag1 = flexcan_read(&regs->iflag1);
-	while (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE &&
-	       work_done < quota) {
-		work_done += flexcan_read_frame(dev);
-		reg_iflag1 = flexcan_read(&regs->iflag1);
+	/* handle mailboxes */
+	for (n = 0; (n < ARRAY_SIZE(priv->cantxfg_copy)) &&
+			(work_done < quota); n++) {
+		ret = flexcan_read_frame(dev, n);
+		if (!ret)
+			break;
+		work_done += ret;
 	}
 
 	/* report bus errors */
@@ -689,24 +698,157 @@ static int flexcan_poll(struct napi_struct *napi, int quota)
 
 	if (work_done < quota) {
 		napi_complete(napi);
-		/* enable IRQs */
-		flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
-		flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
+		priv->rx_idx = 0;
+
+		/* enable RX IRQs */
+		flexcan_write(FLEXCAN_IFLAG1_DEFAULT, &regs->imask1);
+		flexcan_write(FLEXCAN_IFLAG2_DEFAULT, &regs->imask2);
 	}
 
 	return work_done;
 }
 
+static u32 flexcan_copy_one_rxmb(struct flexcan_priv *priv, int i)
+{
+	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_mb __iomem *mb;
+	struct flexcan_mb *dst;
+	u32 reg_ctrl;
+	u32 code;
+
+	mb = &regs->cantxfg[i];
+	dst = &priv->cantxfg_copy[priv->rx_idx];
+	reg_ctrl = flexcan_read(&mb->can_ctrl);
+	code = (reg_ctrl & FLEXCAN_MB_CODE_MASK) >> FLEXCAN_MB_CODE_SHIFT;
+
+	while (code & 1) {
+		/* MB busy, shouldn't take long */
+		reg_ctrl = flexcan_read(&mb->can_ctrl);
+		code = (reg_ctrl & FLEXCAN_MB_CODE_MASK) >> FLEXCAN_MB_CODE_SHIFT;
+	}
+
+	/* Copy contents */
+	dst->can_ctrl = reg_ctrl;
+	dst->can_id = flexcan_read(&mb->can_id);
+	dst->data[0] = flexcan_read(&mb->data[0]);
+	dst->data[1] = flexcan_read(&mb->data[1]);
+
+	/* If it's FULL or OVERRUN, clear the interrupt flag and lock MB */
+	if ((code == 0x2) || (code == 0x6)) {
+		if (i < 32)
+			flexcan_write(BIT(i), &regs->iflag1);
+		else
+			flexcan_write(BIT(i - 32), &regs->iflag2);
+		flexcan_write(FLEXCAN_MB_CNT_CODE(0x0), &mb->can_ctrl);
+		if ((code == 0x6) || (priv->rx_idx ==
+				(ARRAY_SIZE(priv->cantxfg_copy) - 1))) {
+			/* This MB was overrun, we lost data */
+			priv->dev->stats.rx_over_errors++;
+			priv->dev->stats.rx_errors++;
+		}
+		if (priv->rx_idx < (ARRAY_SIZE(priv->cantxfg_copy) - 1))
+			priv->rx_idx++;
+	}
+
+	return code;
+}
+
+static void flexcan_unlock_if_locked(struct flexcan_priv *priv, int i)
+{
+	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_mb __iomem *mb;
+	u32 reg_ctrl;
+	u32 code;
+
+	mb = &regs->cantxfg[i];
+	reg_ctrl = flexcan_read(&mb->can_ctrl);
+	code = (reg_ctrl & FLEXCAN_MB_CODE_MASK) >> FLEXCAN_MB_CODE_SHIFT;
+	if (!code)
+		flexcan_write(FLEXCAN_MB_CNT_CODE(0x4), &mb->can_ctrl);
+}
+
+/*
+ * flexcan_copy_rxmbs
+ *
+ * This function is called from interrupt and needs to make a safe copy
+ * of the MB area to offload the chip immediately to avoid loosing
+ * messages due to latency.
+ * To avoid loosing messages due to race-conditions while reading the MB's,
+ * we need to make use of the locking mechanism of FlexCAN. Unfortunately,
+ * in this mode, automatic locking applies _only_ to MBs that are _not_ EMPTY.
+ * This means we could identify a MB as EMPTY while it is about to get filled.
+ * To avoid this situation from disturbing our queue ordering, we do the
+ * following:
+ * We split the MB area into two halves:
+ * The lower 32 (-2 due to one TX-MB and errata ERR005829) and the upper 32.
+ * We start with all MBs in EMPTY state and all filters disabled (don't care).
+ * FlexCAN will start filling from the lowest MB. Once this function is called,
+ * we copy and disable in an atomic operation all FULL MBs. The first EMPTY one
+ * we encounter may be about to get filled so we stop there. Next time FlexCAN
+ * will have filled more MBs. Once there are no EMPTY MBs in the lower half, we
+ * EMPTY all FULL or locked MBs again.
+ * Next time we have the following situation:
+ * If there is a FULL MB in the upper half, it is because it was about to get
+ * filled when we scanned last time, or got filled just before emptying the
+ * lowest MB, so this will be the first MB we need to copy now. If there are
+ * no EMPTY MBs in the lower half at this time, it means we cannot guarantee
+ * ordering anymore. It also means latency exceeded 30 messages.
+ */
+static void flexcan_copy_rxmbs(struct flexcan_priv *priv, u32 iflag1, u32 iflag2)
+{
+	struct flexcan_regs __iomem *regs = priv->base;
+	int i;
+
+	if (priv->second_first) {
+		/* Begin with second half */
+		for(i = 32; i < 64; i++) {
+			flexcan_copy_one_rxmb(priv, i);
+			flexcan_unlock_if_locked(priv, i);
+		}
+	}
+
+	/* Copy and disable FULL MBs */
+	for(i = 1; i < 64; i++) {
+		if (i == FLEXCAN_TX_BUF_ID)
+			continue;
+		if (flexcan_copy_one_rxmb(priv, i) == 0x4)
+			break;
+	}
+
+	if ((i >= 32) && priv->second_first)
+		netdev_warn(priv->dev, "RX order cannot be guaranteed. count=%d\n", i);
+
+	priv->second_first = 0;
+
+	/* No EMPTY MB in first half? */
+	if (i >= 32) {
+		/* Re-enable all disabled MBs */
+		for(i = 1; i < 64; i++) {
+			if (i == FLEXCAN_TX_BUF_ID)
+				continue;
+			flexcan_unlock_if_locked(priv, i);
+		}
+
+		/* Next time we need to check the second half first */
+		priv->second_first = 1;
+	}
+
+	/* Unlock the last locked MB if any */
+	flexcan_read(&regs->timer);
+}
+
 static irqreturn_t flexcan_irq(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
 	struct net_device_stats *stats = &dev->stats;
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->base;
-	u32 reg_iflag1, reg_esr;
+	u32 reg_iflag1, reg_iflag2, reg_esr;
 
 	reg_iflag1 = flexcan_read(&regs->iflag1);
+	reg_iflag2 = flexcan_read(&regs->iflag2);
 	reg_esr = flexcan_read(&regs->esr);
+
 	/* ACK all bus error and state change IRQ sources */
 	if (reg_esr & FLEXCAN_ESR_ALL_INT)
 		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
@@ -717,7 +859,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	 * - state change IRQ
 	 * - bus error IRQ and bus error reporting is activated
 	 */
-	if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
+	if ((reg_iflag1 & ~(1 << FLEXCAN_TX_BUF_ID)) || reg_iflag2 ||
 	    (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
 	    flexcan_has_and_handle_berr(priv, reg_esr)) {
 		/*
@@ -725,20 +867,10 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		 * save them for later use.
 		 */
 		priv->reg_esr = reg_esr & FLEXCAN_ESR_ERR_BUS;
-		flexcan_write(FLEXCAN_IFLAG_DEFAULT &
-			~FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->imask1);
-		flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
-		       &regs->ctrl);
+		flexcan_copy_rxmbs(priv, reg_iflag1, reg_iflag2);
 		napi_schedule(&priv->napi);
 	}
 
-	/* FIFO overflow */
-	if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
-		flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->iflag1);
-		dev->stats.rx_over_errors++;
-		dev->stats.rx_errors++;
-	}
-
 	/* transmission complete interrupt */
 	if (reg_iflag1 & (1 << FLEXCAN_TX_BUF_ID)) {
 		stats->tx_bytes += can_get_echo_skb(dev, 0);
@@ -800,7 +932,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->base;
 	int err;
-	u32 reg_mcr, reg_ctrl;
+	u32 reg_mcr, reg_ctrl, reg_ctrl2;
 	int i;
 
 	/* enable module */
@@ -828,11 +960,11 @@ static int flexcan_chip_start(struct net_device *dev)
 	 *
 	 */
 	reg_mcr = flexcan_read(&regs->mcr);
-	reg_mcr &= ~FLEXCAN_MCR_MAXMB(0xff);
-	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_FEN | FLEXCAN_MCR_HALT |
+	reg_mcr &= ~(FLEXCAN_MCR_MAXMB(0xff) | FLEXCAN_MCR_FEN);
+	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT |
 		FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN |
 		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_SRX_DIS |
-		FLEXCAN_MCR_MAXMB(FLEXCAN_TX_BUF_ID);
+		FLEXCAN_MCR_BCC | FLEXCAN_MCR_MAXMB(0x40);
 	netdev_dbg(dev, "%s: writing mcr=0x%08x", __func__, reg_mcr);
 	flexcan_write(reg_mcr, &regs->mcr);
 
@@ -868,12 +1000,28 @@ static int flexcan_chip_start(struct net_device *dev)
 	netdev_dbg(dev, "%s: writing ctrl=0x%08x", __func__, reg_ctrl);
 	flexcan_write(reg_ctrl, &regs->ctrl);
 
-	/* Clear and invalidate all mailboxes first */
-	for (i = 0; i < 64; i++) {
-		flexcan_write(FLEXCAN_MB_CNT_CODE(0),
-		      &regs->cantxfg[i].can_ctrl);
+	/* CTRL2: Enable EACEN */
+	reg_ctrl2 = flexcan_read(&regs->ctrl2);
+	reg_ctrl2 |= FLEXCAN_CTRL2_EACEN;
+	flexcan_write(reg_ctrl2, &regs->ctrl2);
+
+	/* Prepare mailboxes. Skip the first, use one for TX the rest for RX */
+	for (i = 1; i < 64; i++) {
+		if (i == FLEXCAN_TX_BUF_ID)
+			flexcan_write(FLEXCAN_MB_CNT_CODE(0x8),
+				&regs->cantxfg[i].can_ctrl);
+		else
+			flexcan_write(FLEXCAN_MB_CNT_CODE(0x4),
+			      &regs->cantxfg[i].can_ctrl);
+		flexcan_write(0, &regs->rximr[i]); /* Clear filter */
 	}
 
+	/* Invalidate mailbox 0 according to errata ERR005829 */
+	flexcan_write(FLEXCAN_MB_CNT_CODE(0x0), &regs->cantxfg[0].can_ctrl);
+
+	priv->second_first = 0;
+	priv->rx_idx = 0;
+
 	/* acceptance mask/acceptance code (accept everything) */
 	flexcan_write(0x0, &regs->rxgmask);
 	flexcan_write(0x0, &regs->rx14mask);
@@ -893,8 +1041,9 @@ static int flexcan_chip_start(struct net_device *dev)
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
-	/* enable FIFO interrupts */
-	flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
+	/* enable all MB interrupts */
+	flexcan_write(FLEXCAN_IFLAG1_DEFAULT, &regs->imask1);
+	flexcan_write(FLEXCAN_IFLAG2_DEFAULT, &regs->imask2);
 
 	/* print chip status */
 	netdev_dbg(dev, "%s: reading mcr=0x%08x ctrl=0x%08x\n", __func__,
-- 
1.9.1

