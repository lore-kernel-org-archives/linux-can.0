From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 11/16] can: flexcan: make use of rx-offload's irq_offload_fifo
Date: Wed, 18 Jan 2017 15:52:22 +0100
Message-ID: <20170118145227.24916-12-mkl@pengutronix.de>
References: <20170118145227.24916-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37627 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751826AbdARPaW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2017 10:30:22 -0500
In-Reply-To: <20170118145227.24916-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Mirza Krak <mirza.krak@hostmobility.com>, Holger Schurig <holgerschurig@gmail.com>, alexander.stein@systec-electronic.com, Marc Kleine-Budde <mkl@pengutronix.de>

This patch converts the flexcan driver to make use of the rx-offload
can_rx_offload_irq_offload_fifo() helper function. The idea is to read
the CAN frames already in the interrupt context, as the depth of the
flexcan HW FIFO is too shallow, resulting in too many missed frames.
During a normal NAPI poll the frames are the pushed into the upper
layers.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 164 +++++++++++++++-------------------------------
 1 file changed, 52 insertions(+), 112 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index d8aa807d9fa5..289bf844fd19 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -24,6 +24,7 @@
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
 #include <linux/can/led.h>
+#include <linux/can/rx-offload.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -246,13 +247,12 @@ struct flexcan_devtype_data {
 
 struct flexcan_priv {
 	struct can_priv can;
-	struct napi_struct napi;
+	struct can_rx_offload offload;
 
 	struct flexcan_regs __iomem *regs;
 	struct flexcan_mb __iomem *tx_mb;
 	struct flexcan_mb __iomem *tx_mb_reserved;
 	u8 tx_mb_idx;
-	u32 reg_esr;
 	u32 reg_ctrl_default;
 	u32 reg_imask1_default;
 
@@ -331,13 +331,6 @@ static inline int flexcan_transceiver_disable(const struct flexcan_priv *priv)
 	return regulator_disable(priv->reg_xceiver);
 }
 
-static inline int flexcan_has_and_handle_berr(const struct flexcan_priv *priv,
-					      u32 reg_esr)
-{
-	return (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) &&
-		(reg_esr & FLEXCAN_ESR_ERR_BUS);
-}
-
 static int flexcan_chip_enable(struct flexcan_priv *priv)
 {
 	struct flexcan_regs __iomem *regs = priv->regs;
@@ -513,7 +506,7 @@ static int flexcan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static int flexcan_poll_bus_err(struct net_device *dev, u32 reg_esr)
+static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct sk_buff *skb;
@@ -522,7 +515,7 @@ static int flexcan_poll_bus_err(struct net_device *dev, u32 reg_esr)
 
 	skb = alloc_can_err_skb(dev, &cf);
 	if (unlikely(!skb))
-		return 0;
+		return;
 
 	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
@@ -565,14 +558,10 @@ static int flexcan_poll_bus_err(struct net_device *dev, u32 reg_esr)
 	if (tx_errors)
 		dev->stats.tx_errors++;
 
-	dev->stats.rx_packets++;
-	dev->stats.rx_bytes += cf->can_dlc;
-	netif_receive_skb(skb);
-
-	return 1;
+	can_rx_offload_irq_queue_err_skb(&priv->offload, skb);
 }
 
-static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
+static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct sk_buff *skb;
@@ -598,33 +587,42 @@ static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
 
 	/* state hasn't changed */
 	if (likely(new_state == priv->can.state))
-		return 0;
+		return;
 
 	skb = alloc_can_err_skb(dev, &cf);
 	if (unlikely(!skb))
-		return 0;
+		return;
 
 	can_change_state(dev, cf, tx_state, rx_state);
 
 	if (unlikely(new_state == CAN_STATE_BUS_OFF))
 		can_bus_off(dev);
 
-	dev->stats.rx_packets++;
-	dev->stats.rx_bytes += cf->can_dlc;
-	netif_receive_skb(skb);
+	can_rx_offload_irq_queue_err_skb(&priv->offload, skb);
+}
 
-	return 1;
+static inline struct flexcan_priv *rx_offload_to_priv(struct can_rx_offload *offload)
+{
+	return container_of(offload, struct flexcan_priv, offload);
 }
 
-static void flexcan_read_fifo(const struct net_device *dev,
-			      struct can_frame *cf)
+static unsigned int flexcan_mailbox_read(struct can_rx_offload *offload,
+					 struct can_frame *cf,
+					 u32 *timestamp, unsigned int n)
 {
-	const struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_priv *priv = rx_offload_to_priv(offload);
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
+	/* increase timstamp to full 32 bit */
+	*timestamp = reg_ctrl << 16;
+
 	reg_id = flexcan_read(&mb->can_id);
 	if (reg_ctrl & FLEXCAN_MB_CNT_IDE)
 		cf->can_id = ((reg_id >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
@@ -641,69 +639,10 @@ static void flexcan_read_fifo(const struct net_device *dev,
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
-{
-	struct net_device *dev = napi->dev;
-	const struct flexcan_priv *priv = netdev_priv(dev);
-	struct flexcan_regs __iomem *regs = priv->regs;
-	u32 reg_iflag1, reg_esr;
-	int work_done = 0;
-
-	/* The error bits are cleared on read,
-	 * use saved value from irq handler.
-	 */
-	reg_esr = flexcan_read(&regs->esr) | priv->reg_esr;
-
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
-}
-
 static irqreturn_t flexcan_irq(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
@@ -714,29 +653,14 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	u32 reg_iflag1, reg_esr;
 
 	reg_iflag1 = flexcan_read(&regs->iflag1);
-	reg_esr = flexcan_read(&regs->esr);
 
-	/* schedule NAPI in case of:
-	 * - rx IRQ
-	 * - state change IRQ
-	 * - bus error IRQ and bus error reporting is activated
-	 */
-	if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
-	    (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
-	    flexcan_has_and_handle_berr(priv, reg_esr)) {
+	/* reception interrupt */
+	if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) {
 		handled = IRQ_HANDLED;
-		/* The error bits are cleared on read,
-		 * save them for later use.
-		 */
-		priv->reg_esr = reg_esr & FLEXCAN_ESR_ERR_BUS;
-		flexcan_write(priv->reg_imask1_default &
-			      ~FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->imask1);
-		flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
-			      &regs->ctrl);
-		napi_schedule(&priv->napi);
+		can_rx_offload_irq_offload_fifo(&priv->offload);
 	}
 
-	/* FIFO overflow */
+	/* FIFO overflow interrupt */
 	if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
 		handled = IRQ_HANDLED;
 		flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->iflag1);
@@ -758,12 +682,23 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		netif_wake_queue(dev);
 	}
 
+	reg_esr = flexcan_read(&regs->esr);
+
 	/* ACK all bus error and state change IRQ sources */
 	if (reg_esr & FLEXCAN_ESR_ALL_INT) {
 		handled = IRQ_HANDLED;
 		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
 	}
 
+	/* state change interrupt */
+	if (reg_esr & FLEXCAN_ESR_ERR_STATE)
+		flexcan_irq_state(dev, reg_esr);
+
+	/* bus error IRQ - handle if bus error reporting is activated */
+	if ((reg_esr & FLEXCAN_ESR_ERR_BUS) &&
+	    (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
+		flexcan_irq_bus_err(dev, reg_esr);
+
 	return handled;
 }
 
@@ -1006,7 +941,7 @@ static int flexcan_open(struct net_device *dev)
 
 	can_led_event(dev, CAN_LED_EVENT_OPEN);
 
-	napi_enable(&priv->napi);
+	can_rx_offload_enable(&priv->offload);
 	netif_start_queue(dev);
 
 	return 0;
@@ -1028,7 +963,7 @@ static int flexcan_close(struct net_device *dev)
 	struct flexcan_priv *priv = netdev_priv(dev);
 
 	netif_stop_queue(dev);
-	napi_disable(&priv->napi);
+	can_rx_offload_disable(&priv->offload);
 	flexcan_chip_stop(dev);
 
 	free_irq(dev->irq, dev);
@@ -1206,6 +1141,9 @@ static int flexcan_probe(struct platform_device *pdev)
 	if (!dev)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, dev);
+	SET_NETDEV_DEV(dev, &pdev->dev);
+
 	dev->netdev_ops = &flexcan_netdev_ops;
 	dev->irq = irq;
 	dev->flags |= IFF_ECHO;
@@ -1232,10 +1170,11 @@ static int flexcan_probe(struct platform_device *pdev)
 		FLEXCAN_IFLAG_RX_FIFO_AVAILABLE |
 		FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
 
-	netif_napi_add(dev, &priv->napi, flexcan_poll, FLEXCAN_NAPI_WEIGHT);
+	priv->offload.mailbox_read = flexcan_mailbox_read;
 
-	platform_set_drvdata(pdev, dev);
-	SET_NETDEV_DEV(dev, &pdev->dev);
+	err = can_rx_offload_add_fifo(dev, &priv->offload, FLEXCAN_NAPI_WEIGHT);
+	if (err)
+		goto failed_offload;
 
 	err = register_flexcandev(dev);
 	if (err) {
@@ -1250,6 +1189,7 @@ static int flexcan_probe(struct platform_device *pdev)
 
 	return 0;
 
+ failed_offload:
  failed_register:
 	free_candev(dev);
 	return err;
@@ -1261,7 +1201,7 @@ static int flexcan_remove(struct platform_device *pdev)
 	struct flexcan_priv *priv = netdev_priv(dev);
 
 	unregister_flexcandev(dev);
-	netif_napi_del(&priv->napi);
+	can_rx_offload_del(&priv->offload);
 	free_candev(dev);
 
 	return 0;
-- 
2.11.0

