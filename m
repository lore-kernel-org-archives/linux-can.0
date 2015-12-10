From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 04/11] can: flexcan: make use of rx-fifo's irq_offload_simple
Date: Thu, 10 Dec 2015 13:33:50 +0100
Message-ID: <1449750837-11376-5-git-send-email-mkl@pengutronix.de>
References: <1449750837-11376-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47969 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753349AbbLJMdq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Dec 2015 07:33:46 -0500
In-Reply-To: <1449750837-11376-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, bhupesh.sharma@freescale.com, Marc Kleine-Budde <mkl@pengutronix.de>

This patch converts the flexcan driver to make use of the rx-fifo
can_rx_fifo_irq_offload_simple() helper function. The idea is to read the CAN
frames already in the interrupt context, as the depth of the flexcan HW FIFO is
too shallow, resulting in too many missed frames. During a normal NAPI poll the
frames are the pushed into the upper layers.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 134 +++++++++++++++++++---------------------------
 1 file changed, 56 insertions(+), 78 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 52065f2f92e0..bddd2ef904f0 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -24,6 +24,7 @@
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
 #include <linux/can/led.h>
+#include <linux/can/rx-fifo.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -246,13 +247,14 @@ struct flexcan_devtype_data {
 
 struct flexcan_priv {
 	struct can_priv can;
-	struct napi_struct napi;
+	struct can_rx_fifo fifo;
 
 	struct flexcan_regs __iomem *regs;
 	struct flexcan_mb __iomem *tx_mb;
 	struct flexcan_mb __iomem *tx_mb_reserved;
 	u8 tx_mb_idx;
 	u32 reg_esr;
+	u32 poll_esr;			/* used in flexcan_poll_bus_err */
 	u32 reg_ctrl_default;
 	u32 reg_imask1_default;
 
@@ -514,6 +516,11 @@ static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -562,16 +569,21 @@ static void do_bus_err(struct net_device *dev,
 		dev->stats.tx_errors++;
 }
 
-static int flexcan_poll_bus_err(struct net_device *dev, u32 reg_esr)
+static unsigned int flexcan_poll_bus_err(struct can_rx_fifo *fifo)
 {
+	struct flexcan_priv *priv = rx_fifo_to_priv(fifo);
+	struct net_device *dev = fifo->dev;
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
 
 	dev->stats.rx_packets++;
 	dev->stats.rx_bytes += cf->can_dlc;
@@ -580,14 +592,21 @@ static int flexcan_poll_bus_err(struct net_device *dev, u32 reg_esr)
 	return 1;
 }
 
-static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
+static unsigned int flexcan_poll_state(struct can_rx_fifo *fifo)
 {
-	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_priv *priv = rx_fifo_to_priv(fifo);
+	struct net_device *dev = fifo->dev;
+	struct flexcan_regs __iomem *regs = priv->regs;
 	struct sk_buff *skb;
 	struct can_frame *cf;
 	enum can_state new_state = 0, rx_state = 0, tx_state = 0;
 	int flt;
 	struct can_berr_counter bec;
+	u32 reg_esr;
+
+	/* esr bits are clear-on-read, so save them for flexcan_poll_bus_err() */
+	priv->poll_esr = priv->reg_esr | flexcan_read(&regs->esr);
+	reg_esr = priv->poll_esr;
 
 	flt = reg_esr & FLEXCAN_ESR_FLT_CONF_MASK;
 	if (likely(flt == FLEXCAN_ESR_FLT_CONF_ACTIVE)) {
@@ -624,13 +643,17 @@ static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
 	return 1;
 }
 
-static void flexcan_read_fifo(const struct net_device *dev,
-			      struct can_frame *cf)
+static unsigned int flexcan_mailbox_read(struct can_rx_fifo *fifo,
+					 struct can_frame *cf, unsigned int n)
 {
-	const struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_priv *priv = rx_fifo_to_priv(fifo);
 	struct flexcan_regs __iomem *regs = priv->regs;
-	struct flexcan_mb __iomem *mb = &regs->mb[0];
-	u32 reg_ctrl, reg_id;
+	struct flexcan_mb __iomem *mb = &regs->mb[n];
+	u32 reg_ctrl, reg_id, reg_iflag1;
+
+	reg_iflag1 = flexcan_read(&regs->iflag1);
+	if (!(reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE))
+		return 0;
 
 	reg_ctrl = flexcan_read(&mb->can_ctrl);
 	reg_id = flexcan_read(&mb->can_id);
@@ -649,67 +672,16 @@ static void flexcan_read_fifo(const struct net_device *dev,
 	/* mark as read */
 	flexcan_write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
 	flexcan_read(&regs->timer);
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
-
-	stats->rx_packets++;
-	stats->rx_bytes += cf->can_dlc;
-	netif_receive_skb(skb);
-
-	can_led_event(dev, CAN_LED_EVENT_RX);
 
 	return 1;
 }
 
-static int flexcan_poll(struct napi_struct *napi, int quota)
+static void flexcan_poll_error_interrupts_enable(struct can_rx_fifo *fifo)
 {
-	struct net_device *dev = napi->dev;
-	const struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_priv *priv = rx_fifo_to_priv(fifo);
 	struct flexcan_regs __iomem *regs = priv->regs;
-	u32 reg_iflag1, reg_esr;
-	int work_done = 0;
-
-	/* The error bits are cleared on read,
-	 * use saved value from irq handler.
-	 */
-	reg_esr = flexcan_read(&regs->esr) | priv->reg_esr;
 
-	/* handle state changes */
-	work_done += flexcan_poll_state(dev, reg_esr);
-
-	/* handle RX-FIFO */
-	reg_iflag1 = flexcan_read(&regs->iflag1);
-	while (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE &&
-	       work_done < quota) {
-		work_done += flexcan_read_frame(dev);
-		reg_iflag1 = flexcan_read(&regs->iflag1);
-	}
-
-	/* report bus errors */
-	if (flexcan_has_and_handle_berr(priv, reg_esr) && work_done < quota)
-		work_done += flexcan_poll_bus_err(dev, reg_esr);
-
-	if (work_done < quota) {
-		napi_complete(napi);
-		/* enable IRQs */
-		flexcan_write(priv->reg_imask1_default, &regs->imask1);
-		flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
-	}
-
-	return work_done;
+	flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
 }
 
 static irqreturn_t flexcan_irq(int irq, void *dev_id)
@@ -727,25 +699,22 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	if (reg_esr & FLEXCAN_ESR_ALL_INT)
 		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
 
-	/* schedule NAPI in case of:
-	 * - rx IRQ
-	 * - state change IRQ
-	 * - bus error IRQ and bus error reporting is activated
-	 */
-	if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
-	    (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
+	/* bus error IRQ and bus error reporting is activated */
+	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
 	    flexcan_has_and_handle_berr(priv, reg_esr)) {
 		/* The error bits are cleared on read,
 		 * save them for later use.
 		 */
 		priv->reg_esr = reg_esr & FLEXCAN_ESR_ERR_BUS;
-		flexcan_write(priv->reg_imask1_default &
-			      ~FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->imask1);
 		flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
 			      &regs->ctrl);
-		napi_schedule(&priv->napi);
+		can_rx_fifo_irq_error(&priv->fifo);
 	}
 
+	/* reception interrupt */
+	if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE)
+		can_rx_fifo_irq_offload_simple(&priv->fifo);
+
 	/* FIFO overflow */
 	if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
 		flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->iflag1);
@@ -1008,7 +977,7 @@ static int flexcan_open(struct net_device *dev)
 
 	can_led_event(dev, CAN_LED_EVENT_OPEN);
 
-	napi_enable(&priv->napi);
+	can_rx_fifo_enable(&priv->fifo);
 	netif_start_queue(dev);
 
 	return 0;
@@ -1030,7 +999,7 @@ static int flexcan_close(struct net_device *dev)
 	struct flexcan_priv *priv = netdev_priv(dev);
 
 	netif_stop_queue(dev);
-	napi_disable(&priv->napi);
+	can_rx_fifo_disable(&priv->fifo);
 	flexcan_chip_stop(dev);
 
 	free_irq(dev->irq, dev);
@@ -1235,7 +1204,15 @@ static int flexcan_probe(struct platform_device *pdev)
 		FLEXCAN_IFLAG_RX_FIFO_AVAILABLE |
 		FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
 
-	netif_napi_add(dev, &priv->napi, flexcan_poll, FLEXCAN_NAPI_WEIGHT);
+	priv->fifo.poll_pre_read = flexcan_poll_state;
+	priv->fifo.poll_post_read = flexcan_poll_bus_err;
+	priv->fifo.poll_error_interrupts_enable =
+		flexcan_poll_error_interrupts_enable;
+	priv->fifo.mailbox_read = flexcan_mailbox_read;
+
+	err = can_rx_fifo_add_simple(dev, &priv->fifo, FLEXCAN_NAPI_WEIGHT);
+	if (err)
+		goto failed_fifo;
 
 	platform_set_drvdata(pdev, dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
@@ -1253,6 +1230,7 @@ static int flexcan_probe(struct platform_device *pdev)
 
 	return 0;
 
+ failed_fifo:
  failed_register:
 	free_candev(dev);
 	return err;
@@ -1264,7 +1242,7 @@ static int flexcan_remove(struct platform_device *pdev)
 	struct flexcan_priv *priv = netdev_priv(dev);
 
 	unregister_flexcandev(dev);
-	netif_napi_del(&priv->napi);
+	can_rx_fifo_del(&priv->fifo);
 	free_candev(dev);
 
 	return 0;
-- 
2.6.2

