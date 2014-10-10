From: David Jander <david@protonic.nl>
Subject: [PATCH 12/15] can: flexcan: Add support for RX-FIFO.
Date: Fri, 10 Oct 2014 17:46:57 +0200
Message-ID: <1412956020-21489-13-git-send-email-david@protonic.nl>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:18409 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbaJJPrE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Oct 2014 11:47:04 -0400
In-Reply-To: <1412956020-21489-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>, David Jander <david@protonic.nl>

This adds support for RX-FIFO simulating a FIFO from a linear array of message-
boxes. This breaks RTR reception on flexcan older than V10.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/can/flexcan.c | 333 +++++++++++++++-------------------------------
 1 file changed, 104 insertions(+), 229 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 8118f35..5e37ce4 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -273,10 +273,10 @@ struct flexcan_devtype_data {
 struct flexcan_priv {
 	struct can_priv can;
 	struct net_device *dev;
-	struct napi_struct napi;
 
 	void __iomem *base;
 	u32 reg_esr;
+	u32 poll_esr;
 	u32 reg_ctrl_default;
 
 	struct clk *clk_ipg;
@@ -284,10 +284,8 @@ struct flexcan_priv {
 	struct flexcan_platform_data *pdata;
 	const struct flexcan_devtype_data *devtype_data;
 	struct regulator *reg_xceiver;
-	struct flexcan_mb cantxfg_copy[FLEXCAN_NAPI_WEIGHT];
-	bool second_first;
-	unsigned int rx_head;
-	unsigned int rx_tail;
+
+	struct can_rx_fifo fifo;
 };
 
 static struct flexcan_devtype_data fsl_p1010_devtype_data = {
@@ -540,6 +538,11 @@ static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -588,16 +591,21 @@ static void do_bus_err(struct net_device *dev,
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
@@ -679,17 +687,22 @@ static void do_state(struct net_device *dev,
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
@@ -717,232 +730,88 @@ static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
 	return 1;
 }
 
-static int flexcan_read_frame(struct net_device *dev, int n)
+static void flexcan_mailbox_enable(struct can_rx_fifo *fifo, unsigned int n)
 {
-	struct net_device_stats *stats = &dev->stats;
-	struct flexcan_priv *priv = netdev_priv(dev);
-	struct flexcan_mb *mb = &priv->cantxfg_copy[n];
-	struct can_frame *cf;
-	struct sk_buff *skb;
-	u32 reg_ctrl, reg_id;
+	struct flexcan_priv *priv = rx_fifo_to_priv(fifo);
+	struct flexcan_regs __iomem *regs = priv->base;
+	struct flexcan_mb __iomem *mb;
+	u32 reg_ctrl;
 	u32 code;
 
-	reg_ctrl = ACCESS_ONCE(mb->can_ctrl);
+	mb = &regs->cantxfg[n];
+	reg_ctrl = flexcan_read(&mb->can_ctrl);
 	code = reg_ctrl & FLEXCAN_MB_CODE_MASK;
-
-	/* is this MB empty? */
-	if ((code != FLEXCAN_MB_CODE_RX_FULL) &&
-	    (code != FLEXCAN_MB_CODE_RX_OVERRRUN))
-		return 0;
-
-	if (code == FLEXCAN_MB_CODE_RX_OVERRRUN) {
-		/* This MB was overrun, we lost data */
-		priv->dev->stats.rx_over_errors++;
-		priv->dev->stats.rx_errors++;
-	}
-
-	skb = alloc_can_skb(dev, &cf);
-	if (unlikely(!skb)) {
-		stats->rx_dropped++;
-		return 0;
-	}
-
-	reg_id = mb->can_id;
-	if (reg_ctrl & FLEXCAN_MB_CNT_IDE)
-		cf->can_id = ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
-	else
-		cf->can_id = (reg_id >> 18) & CAN_SFF_MASK;
-
-	if (reg_ctrl & FLEXCAN_MB_CNT_RTR)
-		cf->can_id |= CAN_RTR_FLAG;
-	cf->can_dlc = get_can_dlc((reg_ctrl >> 16) & 0xf);
-
-	*(__be32 *)(cf->data + 0) = cpu_to_be32(mb->data[0]);
-	*(__be32 *)(cf->data + 4) = cpu_to_be32(mb->data[1]);
-
-	netif_receive_skb(skb);
-
-	stats->rx_packets++;
-	stats->rx_bytes += cf->can_dlc;
-
-	can_led_event(dev, CAN_LED_EVENT_RX);
-
-	return 1;
+	if (code == FLEXCAN_MB_CODE_RX_INACTIVE)
+		flexcan_write(FLEXCAN_MB_CODE_RX_EMPTY, &mb->can_ctrl);
+	flexcan_read(&regs->timer);
 }
 
-static int flexcan_poll(struct napi_struct *napi, int quota)
+static void flexcan_mailbox_enable_mask(struct can_rx_fifo *fifo, u64 mask)
 {
-	struct net_device *dev = napi->dev;
-	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_priv *priv = rx_fifo_to_priv(fifo);
 	struct flexcan_regs __iomem *regs = priv->base;
-	u32 reg_esr;
-	int work_done = 0;
-	int ret;
-	unsigned int head;
-	unsigned int tail;
+	struct flexcan_mb __iomem *mb;
+	u32 reg_ctrl;
+	u32 code;
+	unsigned int n;
 
-	/*
-	 * The error bits are cleared on read,
-	 * use saved value from irq handler.
-	 */
-	reg_esr = flexcan_read(&regs->esr) | priv->reg_esr;
-
-	/* handle state changes */
-	work_done += flexcan_poll_state(dev, reg_esr);
-
-	/* handle mailboxes */
-	head = smp_load_acquire(&priv->rx_head);
-	tail = priv->rx_tail;
-	while ((CIRC_CNT(head, tail, ARRAY_SIZE(priv->cantxfg_copy)) >= 1) &&
-			(work_done < quota)) {
-		ret = flexcan_read_frame(dev, tail);
-		work_done += ret;
-		tail = (tail + 1) & (ARRAY_SIZE(priv->cantxfg_copy) -1);
-		smp_store_release(&priv->rx_tail, tail);
+	for (n = FLEXCAN_RX_AREA_START; n < ARRAY_SIZE(regs->cantxfg); n ++) {
+		mb = &regs->cantxfg[n];
+		reg_ctrl = flexcan_read(&mb->can_ctrl);
+		code = reg_ctrl & FLEXCAN_MB_CODE_MASK;
+		if ((mask & BIT_ULL(n)) && (code == FLEXCAN_MB_CODE_RX_INACTIVE))
+			flexcan_write(FLEXCAN_MB_CODE_RX_EMPTY, &mb->can_ctrl);
 	}
-
-	/* report bus errors */
-	if (flexcan_has_and_handle_berr(priv, reg_esr) && work_done < quota)
-		work_done += flexcan_poll_bus_err(dev, reg_esr);
-
-	if (work_done < quota)
-		napi_complete(napi);
-
-	return work_done;
+	flexcan_read(&regs->timer);
 }
 
-static u32 flexcan_copy_one_rxmb(struct flexcan_priv *priv, int i)
+static unsigned int flexcan_mailbox_move_to_buffer(struct can_rx_fifo *fifo,
+		struct can_frame *cf, unsigned int n)
 {
+	struct flexcan_priv *priv = rx_fifo_to_priv(fifo);
 	struct flexcan_regs __iomem *regs = priv->base;
-	struct flexcan_mb __iomem *mb;
-	struct flexcan_mb *dst;
-	u32 reg_ctrl;
+	struct flexcan_mb *mb = &regs->cantxfg[n];
+	u32 reg_ctrl, reg_id;
 	u32 code;
-	unsigned int head;
-	unsigned int tail;
 
-	mb = &regs->cantxfg[i];
-	reg_ctrl = flexcan_read(&mb->can_ctrl);
-	code = reg_ctrl & FLEXCAN_MB_CODE_MASK;
-
-	while (code & FLEXCAN_MB_CODE_RX_BUSY_BIT) {
-		/* MB busy, shouldn't take long */
+	do {
 		reg_ctrl = flexcan_read(&mb->can_ctrl);
 		code = reg_ctrl & FLEXCAN_MB_CODE_MASK;
-	}
+	} while (code & FLEXCAN_MB_CODE_RX_BUSY_BIT);
 
-	/* No need to process if neither FULL nor OVERRRUN */
+	/* is this MB empty? */
 	if ((code != FLEXCAN_MB_CODE_RX_FULL) &&
 	    (code != FLEXCAN_MB_CODE_RX_OVERRRUN))
-		return code;
-
-	head = priv->rx_head;
-	tail = ACCESS_ONCE(priv->rx_tail);
-	if (CIRC_SPACE(head, tail, ARRAY_SIZE(priv->cantxfg_copy)) >= 1) {
-		/* Copy contents */
-		dst = &priv->cantxfg_copy[priv->rx_head];
-		dst->can_id = flexcan_read(&mb->can_id);
-		dst->data[0] = flexcan_read(&mb->data[0]);
-		dst->data[1] = flexcan_read(&mb->data[1]);
-		dst->can_ctrl = reg_ctrl;
-
-		smp_store_release(&priv->rx_head,
-			(head + 1) & (ARRAY_SIZE(priv->cantxfg_copy) - 1));
-	} else {
-		/* Buffer space overrun, we lost data */
+		return 0;
+
+	if (code == FLEXCAN_MB_CODE_RX_OVERRRUN) {
+		/* This MB was overrun, we lost data */
 		priv->dev->stats.rx_over_errors++;
 		priv->dev->stats.rx_errors++;
 	}
 
-	/* Clear the interrupt flag and lock MB */
-	if (i < 32)
-		flexcan_write(BIT(i), &regs->iflag1);
+	reg_id = flexcan_read(&mb->can_id);
+	if (reg_ctrl & FLEXCAN_MB_CNT_IDE)
+		cf->can_id = ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
 	else
-		flexcan_write(BIT(i - 32), &regs->iflag2);
-	flexcan_write(FLEXCAN_MB_CODE_RX_INACTIVE, &mb->can_ctrl);
-
-	return code;
-}
-
-static void flexcan_unlock_if_locked(struct flexcan_priv *priv, int i)
-{
-	struct flexcan_regs __iomem *regs = priv->base;
-	struct flexcan_mb __iomem *mb;
-	u32 reg_ctrl;
-	u32 code;
-
-	mb = &regs->cantxfg[i];
-	reg_ctrl = flexcan_read(&mb->can_ctrl);
-	code = reg_ctrl & FLEXCAN_MB_CODE_MASK;
-	if (code == FLEXCAN_MB_CODE_RX_INACTIVE)
-		flexcan_write(FLEXCAN_MB_CODE_RX_EMPTY, &mb->can_ctrl);
-}
-
-/*
- * flexcan_copy_rxmbs
- *
- * This function is called from interrupt and needs to make a safe copy
- * of the MB area to offload the chip immediately to avoid loosing
- * messages due to latency.
- * To avoid loosing messages due to race-conditions while reading the MB's,
- * we need to make use of the locking mechanism of FlexCAN. Unfortunately,
- * in this mode, automatic locking applies _only_ to MBs that are _not_ EMPTY.
- * This means we could identify a MB as EMPTY while it is about to get filled.
- * To avoid this situation from disturbing our queue ordering, we do the
- * following:
- * We split the MB area into two halves:
- * The lower 32 (-2 due to one TX-MB and errata ERR005829) and the upper 32.
- * We start with all MBs in EMPTY state and all filters disabled (don't care).
- * FlexCAN will start filling from the lowest MB. Once this function is called,
- * we copy and disable in an atomic operation all FULL MBs. The first EMPTY one
- * we encounter may be about to get filled so we stop there. Next time FlexCAN
- * will have filled more MBs. Once there are no EMPTY MBs in the lower half, we
- * EMPTY all FULL or locked MBs again.
- * Next time we have the following situation:
- * If there is a FULL MB in the upper half, it is because it was about to get
- * filled when we scanned last time, or got filled just before emptying the
- * lowest MB, so this will be the first MB we need to copy now. If there are
- * no EMPTY MBs in the lower half at this time, it means we cannot guarantee
- * ordering anymore. It also means latency exceeded 30 messages.
- */
-static void flexcan_copy_rxmbs(struct flexcan_priv *priv, u32 iflag1, u32 iflag2)
-{
-	struct flexcan_regs __iomem *regs = priv->base;
-	int i;
-	unsigned int code;
-
-	if (priv->second_first) {
-		/* Begin with second half */
-		for(i = 32; i < 64; i++) {
-			flexcan_copy_one_rxmb(priv, i);
-			flexcan_unlock_if_locked(priv, i);
-		}
-	}
-
-	/* Copy and disable FULL MBs */
-	for(i = FLEXCAN_RX_AREA_START; i < 64; i++) {
-		code = flexcan_copy_one_rxmb(priv, i);
-		if (code == FLEXCAN_MB_CODE_RX_EMPTY)
-			break;
-	}
+		cf->can_id = (reg_id >> 18) & CAN_SFF_MASK;
 
-	if ((i >= 32) && priv->second_first)
-		netdev_warn(priv->dev, "RX order cannot be guaranteed. count=%d\n", i);
+	if (reg_ctrl & FLEXCAN_MB_CNT_RTR)
+		cf->can_id |= CAN_RTR_FLAG;
+	cf->can_dlc = get_can_dlc((reg_ctrl >> 16) & 0xf);
 
-	priv->second_first = false;
+	*(__be32 *)(cf->data + 0) = cpu_to_be32(flexcan_read(&mb->data[0]));
+	*(__be32 *)(cf->data + 4) = cpu_to_be32(flexcan_read(&mb->data[1]));
 
-	/* No EMPTY MB in first half? */
-	if (i >= 32) {
-		/* Re-enable all disabled MBs */
-		for(i = FLEXCAN_RX_AREA_START; i < 64; i++)
-			flexcan_unlock_if_locked(priv, i);
+	/* Clear IRQ and lock MB */
+	if (n < 32)
+		flexcan_write(BIT(n), &regs->iflag1);
+	else
+		flexcan_write(BIT(n - 32), &regs->iflag2);
 
-		/* Next time we need to check the second half first */
-		priv->second_first = true;
-	}
+	flexcan_write(FLEXCAN_MB_CODE_RX_INACTIVE, &mb->can_ctrl);
 
-	/* Unlock the last locked MB if any */
-	flexcan_read(&regs->timer);
+	return 1;
 }
 
 static irqreturn_t flexcan_irq(int irq, void *dev_id)
@@ -961,22 +830,20 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	if (reg_esr & FLEXCAN_ESR_ALL_INT)
 		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
 
-	/*
-	 * schedule NAPI in case of:
-	 * - rx IRQ
-	 * - state change IRQ
-	 * - bus error IRQ and bus error reporting is activated
-	 */
-	if ((reg_iflag1 & ~(1 << FLEXCAN_TX_BUF_ID)) || reg_iflag2 ||
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
-		flexcan_copy_rxmbs(priv, reg_iflag1, reg_iflag2);
-		napi_schedule(&priv->napi);
+		can_rx_fifo_irq_error(&priv->fifo);
+	}
+
+	/* reception interrupt */
+	if ((reg_iflag1 & ~(1 << FLEXCAN_TX_BUF_ID)) || reg_iflag2) {
+		can_rx_fifo_irq_offload(&priv->fifo);
 	}
 
 	/* transmission complete interrupt */
@@ -1133,9 +1000,6 @@ static int flexcan_chip_start(struct net_device *dev)
 	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
 		      &regs->cantxfg[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
 
-	priv->second_first = false;
-	priv->rx_head = priv->rx_tail = 0;
-
 	/* acceptance mask/acceptance code (accept everything) */
 	flexcan_write(0x0, &regs->rxgmask);
 	flexcan_write(0x0, &regs->rx14mask);
@@ -1170,17 +1034,19 @@ static int flexcan_chip_start(struct net_device *dev)
 	if (err)
 		goto out_chip_disable;
 
-	/* synchronize with the can bus */
-	err = flexcan_chip_unfreeze(priv);
-	if (err)
-		goto out_transceiver_disable;
-
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
+	can_rx_fifo_reset(&priv->fifo);
+
 	/* enable all MB interrupts */
 	flexcan_write(FLEXCAN_IFLAG1_DEFAULT, &regs->imask1);
 	flexcan_write(FLEXCAN_IFLAG2_DEFAULT, &regs->imask2);
 
+	/* synchronize with the can bus */
+	err = flexcan_chip_unfreeze(priv);
+	if (err)
+		goto out_transceiver_disable;
+
 	/* print chip status */
 	netdev_dbg(dev, "%s: reading mcr=0x%08x ctrl=0x%08x\n", __func__,
 		   flexcan_read(&regs->mcr), flexcan_read(&regs->ctrl));
@@ -1248,7 +1114,7 @@ static int flexcan_open(struct net_device *dev)
 
 	can_led_event(dev, CAN_LED_EVENT_OPEN);
 
-	napi_enable(&priv->napi);
+	can_rx_fifo_napi_enable(&priv->fifo);
 	netif_start_queue(dev);
 
 	return 0;
@@ -1270,7 +1136,7 @@ static int flexcan_close(struct net_device *dev)
 	struct flexcan_priv *priv = netdev_priv(dev);
 
 	netif_stop_queue(dev);
-	napi_disable(&priv->napi);
+	can_rx_fifo_napi_disable(&priv->fifo);
 	flexcan_chip_stop(dev);
 
 	free_irq(dev->irq, dev);
@@ -1465,7 +1331,16 @@ static int flexcan_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->reg_xceiver))
 		priv->reg_xceiver = NULL;
 
-	netif_napi_add(dev, &priv->napi, flexcan_poll, FLEXCAN_NAPI_WEIGHT);
+	/* Fill in RX-FIFO */
+	priv->fifo.low_first = FLEXCAN_RX_AREA_START;
+	priv->fifo.high_first = 32; /* FIXME: #define */
+	priv->fifo.high_last = 63; /* FIXME: #define */
+	priv->fifo.mailbox_enable_mask = flexcan_mailbox_enable_mask;
+	priv->fifo.mailbox_enable = flexcan_mailbox_enable;
+	priv->fifo.mailbox_move_to_buffer = flexcan_mailbox_move_to_buffer;
+	priv->fifo.poll_can_state = flexcan_poll_state;
+	priv->fifo.poll_bus_error = flexcan_poll_bus_err;
+	can_rx_fifo_add(dev, &priv->fifo);
 
 	platform_set_drvdata(pdev, dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
@@ -1494,7 +1369,7 @@ static int flexcan_remove(struct platform_device *pdev)
 	struct flexcan_priv *priv = netdev_priv(dev);
 
 	unregister_flexcandev(dev);
-	netif_napi_del(&priv->napi);
+	can_rx_fifo_del(&priv->fifo);
 	free_candev(dev);
 
 	return 0;
-- 
1.9.1

