From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 08/16] can: flexcan: flexcan_irq(): don't unconditionally return IRQ_HANDLED
Date: Wed, 18 Jan 2017 15:52:19 +0100
Message-ID: <20170118145227.24916-9-mkl@pengutronix.de>
References: <20170118145227.24916-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51901 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752959AbdARPDx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2017 10:03:53 -0500
In-Reply-To: <20170118145227.24916-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Mirza Krak <mirza.krak@hostmobility.com>, Holger Schurig <holgerschurig@gmail.com>, alexander.stein@systec-electronic.com, Marc Kleine-Budde <mkl@pengutronix.de>

This patch changes the flexcan_irq() function to only return
IRQ_HANDLED, if the interrupt really has been handled, otherwise
IRQ_NONE is returned.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 746be60173d7..e329e4355678 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -710,15 +710,12 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	struct net_device_stats *stats = &dev->stats;
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct flexcan_regs __iomem *regs = priv->regs;
+	irqreturn_t handled = IRQ_NONE;
 	u32 reg_iflag1, reg_esr;
 
 	reg_iflag1 = flexcan_read(&regs->iflag1);
 	reg_esr = flexcan_read(&regs->esr);
 
-	/* ACK all bus error and state change IRQ sources */
-	if (reg_esr & FLEXCAN_ESR_ALL_INT)
-		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
-
 	/* schedule NAPI in case of:
 	 * - rx IRQ
 	 * - state change IRQ
@@ -727,6 +724,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 	if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
 	    (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
 	    flexcan_has_and_handle_berr(priv, reg_esr)) {
+		handled = IRQ_HANDLED;
 		/* The error bits are cleared on read,
 		 * save them for later use.
 		 */
@@ -740,6 +738,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 
 	/* FIFO overflow */
 	if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
+		handled = IRQ_HANDLED;
 		flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW, &regs->iflag1);
 		dev->stats.rx_over_errors++;
 		dev->stats.rx_errors++;
@@ -747,6 +746,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 
 	/* transmission complete interrupt */
 	if (reg_iflag1 & (1 << FLEXCAN_TX_BUF_ID)) {
+		handled = IRQ_HANDLED;
 		stats->tx_bytes += can_get_echo_skb(dev, 0);
 		stats->tx_packets++;
 		can_led_event(dev, CAN_LED_EVENT_TX);
@@ -758,7 +758,13 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		netif_wake_queue(dev);
 	}
 
-	return IRQ_HANDLED;
+	/* ACK all bus error and state change IRQ sources */
+	if (reg_esr & FLEXCAN_ESR_ALL_INT) {
+		handled = IRQ_HANDLED;
+		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
+	}
+
+	return handled;
 }
 
 static void flexcan_set_bittiming(struct net_device *dev)
-- 
2.11.0

