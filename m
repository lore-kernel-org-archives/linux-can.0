From: David Jander <david@protonic.nl>
Subject: [PATCH v5] can: flexcan: Re-write receive path to use MB queue instead of FIFO
Date: Mon, 29 Sep 2014 14:52:55 +0200
Message-ID: <1411995175-13540-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:4475 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbaI2MxB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Sep 2014 08:53:01 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, David Jander <david@protonic.nl>

The FlexCAN controller has a RX FIFO that is only 6 messages deep, and a
mailbox space capable of holding up to 63 messages.

This space was largely unused, limiting the permissible latency from interrupt
to NAPI to only 6 messages. This patch uses all available MBs for message
reception and frees the MBs in the IRQ handler to greatly decrease the
likelihood of receive overruns.

Signed-off-by: David Jander <david@protonic.nl>
---

Changed since v4:
 - Implemented RX copy-out as a ring buffer instead of a plain copy of the MB
   area.
 - Squashed in Marc's patch: make use of FLEXCAN_MB_CODE_
 - Moved CODE checking for OVERRUN from IRQ to NAPI call
 - Used a define (FLEXCAN_RX_AREA_START) to start for loops for RX MB looping.
 - Created and explained a define for FLEXCAN_MCR_MAXMB_USED

 drivers/net/can/flexcan.c | 324 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 243 insertions(+), 81 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 20f5c0e..62432dc 100644
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
@@ -147,17 +164,16 @@
 
 /* FLEXCAN interrupt flag register (IFLAG) bits */
 /* Errata ERR005829 step7: Reserve first valid MB */
-#define FLEXCAN_TX_BUF_RESERVED		8
-#define FLEXCAN_TX_BUF_ID		9
+#define FLEXCAN_TX_BUF_RESERVED		0
+#define FLEXCAN_TX_BUF_ID		1
+#define FLEXCAN_RX_AREA_START		(FLEXCAN_TX_BUF_ID + 1)
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
+#define FLEXCAN_MB_CODE_MASK		(0xf << 24)
+#define FLEXCAN_MB_CODE_RX_BUSY_BIT	(0x1 << 24)
 #define FLEXCAN_MB_CODE_RX_INACTIVE	(0x0 << 24)
 #define FLEXCAN_MB_CODE_RX_EMPTY	(0x4 << 24)
 #define FLEXCAN_MB_CODE_RX_FULL		(0x2 << 24)
@@ -175,8 +191,6 @@
 #define FLEXCAN_MB_CNT_LENGTH(x)	(((x) & 0xf) << 16)
 #define FLEXCAN_MB_CNT_TIMESTAMP(x)	((x) & 0xffff)
 
-#define FLEXCAN_MB_CODE_MASK		(0xf0ffffff)
-
 #define FLEXCAN_TIMEOUT_US             (50)
 
 /*
@@ -239,7 +253,9 @@ struct flexcan_regs {
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
@@ -268,6 +284,10 @@ struct flexcan_priv {
 	struct flexcan_platform_data *pdata;
 	const struct flexcan_devtype_data *devtype_data;
 	struct regulator *reg_xceiver;
+	struct flexcan_mb cantxfg_copy[FLEXCAN_NAPI_WEIGHT];
+	bool second_first;
+	unsigned int rx_head;
+	unsigned int rx_tail;
 };
 
 static struct flexcan_devtype_data fsl_p1010_devtype_data = {
@@ -697,16 +717,38 @@ static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
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
+	reg_ctrl = ACCESS_ONCE(mb->can_ctrl);
+	smp_rmb(); /* reg_ctrl is written last in IRQ */
+	code = reg_ctrl & FLEXCAN_MB_CODE_MASK;
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
@@ -716,27 +758,9 @@ static void flexcan_read_fifo(const struct net_device *dev,
 		cf->can_id |= CAN_RTR_FLAG;
 	cf->can_dlc = get_can_dlc((reg_ctrl >> 16) & 0xf);
 
-	*(__be32 *)(cf->data + 0) = cpu_to_be32(flexcan_read(&mb->data[0]));
-	*(__be32 *)(cf->data + 4) = cpu_to_be32(flexcan_read(&mb->data[1]));
+	*(__be32 *)(cf->data + 0) = cpu_to_be32(mb->data[0]);
+	*(__be32 *)(cf->data + 4) = cpu_to_be32(mb->data[1]);
 
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
-
-	skb = alloc_can_skb(dev, &cf);
-	if (unlikely(!skb)) {
-		stats->rx_dropped++;
-		return 0;
-	}
-
-	flexcan_read_fifo(dev, cf);
 	netif_receive_skb(skb);
 
 	stats->rx_packets++;
@@ -750,10 +774,13 @@ static int flexcan_read_frame(struct net_device *dev)
 static int flexcan_poll(struct napi_struct *napi, int quota)
 {
 	struct net_device *dev = napi->dev;
-	const struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->base;
-	u32 reg_iflag1, reg_esr;
+	u32 reg_esr;
 	int work_done = 0;
+	int ret;
+	unsigned int head;
+	unsigned int tail;
 
 	/*
 	 * The error bits are cleared on read,
@@ -764,38 +791,174 @@ static int flexcan_poll(struct napi_struct *napi, int quota)
 	/* handle state changes */
 	work_done += flexcan_poll_state(dev, reg_esr);
 
-	/* handle RX-FIFO */
-	reg_iflag1 = flexcan_read(&regs->iflag1);
-	while (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE &&
-	       work_done < quota) {
-		work_done += flexcan_read_frame(dev);
-		reg_iflag1 = flexcan_read(&regs->iflag1);
+	/* handle mailboxes */
+	head = smp_load_acquire(&priv->rx_head);
+	tail = priv->rx_tail;
+	while ((CIRC_CNT(head, tail, ARRAY_SIZE(priv->cantxfg_copy)) >= 1) &&
+			(work_done < quota)) {
+		ret = flexcan_read_frame(dev, tail);
+		work_done += ret;
+		tail = (tail + 1) & (ARRAY_SIZE(priv->cantxfg_copy) -1);
+		smp_store_release(&priv->rx_tail, tail);
 	}
 
 	/* report bus errors */
 	if (flexcan_has_and_handle_berr(priv, reg_esr) && work_done < quota)
 		work_done += flexcan_poll_bus_err(dev, reg_esr);
 
-	if (work_done < quota) {
+	if (work_done < quota)
 		napi_complete(napi);
-		/* enable IRQs */
-		flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
-		flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
-	}
 
 	return work_done;
 }
 
+static u32 flexcan_copy_one_rxmb(struct flexcan_priv *priv, int i)
+{
+	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_mb __iomem *mb;
+	struct flexcan_mb *dst;
+	u32 reg_ctrl;
+	u32 code;
+	unsigned int head;
+	unsigned int tail;
+
+	mb = &regs->cantxfg[i];
+	reg_ctrl = flexcan_read(&mb->can_ctrl);
+	code = reg_ctrl & FLEXCAN_MB_CODE_MASK;
+
+	while (code & FLEXCAN_MB_CODE_RX_BUSY_BIT) {
+		/* MB busy, shouldn't take long */
+		reg_ctrl = flexcan_read(&mb->can_ctrl);
+		code = reg_ctrl & FLEXCAN_MB_CODE_MASK;
+	}
+
+	/* No need to process if neither FULL nor OVERRRUN */
+	if ((code != FLEXCAN_MB_CODE_RX_FULL) &&
+	    (code != FLEXCAN_MB_CODE_RX_OVERRRUN))
+		return code;
+
+	head = priv->rx_head;
+	tail = ACCESS_ONCE(priv->rx_tail);
+	if (CIRC_SPACE(head, tail, ARRAY_SIZE(priv->cantxfg_copy)) >= 1) {
+		/* Copy contents */
+		dst = &priv->cantxfg_copy[priv->rx_head];
+		dst->can_id = flexcan_read(&mb->can_id);
+		dst->data[0] = flexcan_read(&mb->data[0]);
+		dst->data[1] = flexcan_read(&mb->data[1]);
+		smp_wmb(); /* Write reg_ctrl last */
+		dst->can_ctrl = reg_ctrl;
+
+		smp_store_release(&priv->rx_head,
+			(head + 1) & (ARRAY_SIZE(priv->cantxfg_copy) - 1));
+	} else {
+		/* Buffer space overrun, we lost data */
+		priv->dev->stats.rx_over_errors++;
+		priv->dev->stats.rx_errors++;
+	}
+
+	/* Clear the interrupt flag and lock MB */
+	if (i < 32)
+		flexcan_write(BIT(i), &regs->iflag1);
+	else
+		flexcan_write(BIT(i - 32), &regs->iflag2);
+	flexcan_write(FLEXCAN_MB_CODE_RX_INACTIVE, &mb->can_ctrl);
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
+	code = reg_ctrl & FLEXCAN_MB_CODE_MASK;
+	if (code == FLEXCAN_MB_CODE_RX_INACTIVE)
+		flexcan_write(FLEXCAN_MB_CODE_RX_EMPTY, &mb->can_ctrl);
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
+	unsigned int code;
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
+	for(i = FLEXCAN_RX_AREA_START; i < 64; i++) {
+		code = flexcan_copy_one_rxmb(priv, i);
+		if (code == FLEXCAN_MB_CODE_RX_EMPTY)
+			break;
+	}
+
+	if ((i >= 32) && priv->second_first)
+		netdev_warn(priv->dev, "RX order cannot be guaranteed. count=%d\n", i);
+
+	priv->second_first = false;
+
+	/* No EMPTY MB in first half? */
+	if (i >= 32) {
+		/* Re-enable all disabled MBs */
+		for(i = FLEXCAN_RX_AREA_START; i < 64; i++)
+			flexcan_unlock_if_locked(priv, i);
+
+		/* Next time we need to check the second half first */
+		priv->second_first = true;
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
@@ -806,7 +969,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	 * - state change IRQ
 	 * - bus error IRQ and bus error reporting is activated
 	 */
-	if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
+	if ((reg_iflag1 & ~(1 << FLEXCAN_TX_BUF_ID)) || reg_iflag2 ||
 	    (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
 	    flexcan_has_and_handle_berr(priv, reg_esr)) {
 		/*
@@ -814,20 +977,10 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
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
@@ -920,11 +1073,11 @@ static int flexcan_chip_start(struct net_device *dev)
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
+		FLEXCAN_MCR_BCC | FLEXCAN_MCR_MAXMB(FLEXCAN_MCR_MAXMB_USED);
 	netdev_dbg(dev, "%s: writing mcr=0x%08x", __func__, reg_mcr);
 	flexcan_write(reg_mcr, &regs->mcr);
 
@@ -960,28 +1113,36 @@ static int flexcan_chip_start(struct net_device *dev)
 	netdev_dbg(dev, "%s: writing ctrl=0x%08x", __func__, reg_ctrl);
 	flexcan_write(reg_ctrl, &regs->ctrl);
 
-	/* clear and invalidate all mailboxes first */
-	for (i = FLEXCAN_TX_BUF_ID; i < ARRAY_SIZE(regs->cantxfg); i++) {
-		flexcan_write(FLEXCAN_MB_CODE_RX_INACTIVE,
-			      &regs->cantxfg[i].can_ctrl);
+	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES) {
+		/* CTRL2: Enable EACEN */
+		reg_ctrl2 = flexcan_read(&regs->ctrl2);
+		reg_ctrl2 |= FLEXCAN_CTRL2_EACEN;
+		flexcan_write(reg_ctrl2, &regs->ctrl2);
 	}
 
+	/* Prepare RX mailboxes */
+	for (i = FLEXCAN_RX_AREA_START; i < ARRAY_SIZE(regs->cantxfg); i++) {
+		flexcan_write(FLEXCAN_MB_CODE_RX_EMPTY,
+		      &regs->cantxfg[i].can_ctrl);
+		flexcan_write(0, &regs->rximr[i]); /* Clear filter */
+	}
+
+	/* Prepare TX mailbox */
+	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
+		&regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
+
 	/* Errata ERR005829: mark first TX mailbox as INACTIVE */
 	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
 		      &regs->cantxfg[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
 
-	/* mark TX mailbox as INACTIVE */
-	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
-		      &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
+	priv->second_first = false;
+	priv->rx_head = priv->rx_tail = 0;
 
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
@@ -1018,8 +1179,9 @@ static int flexcan_chip_start(struct net_device *dev)
 
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

