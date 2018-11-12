From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 20/20] can: flexcan: use can_rx_offload_queue_sorted() for flexcan_irq_bus_*()
Date: Mon, 12 Nov 2018 12:57:28 +0100
Message-ID: <20181112115728.18331-21-mkl@pengutronix.de>
References: <20181112115728.18331-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181112115728.18331-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

Currently, in case of bus error, driver will generate error message and put
in the tail of the message queue. To avoid confusions, this change should
place the bus related messages in proper order.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 5923bd0ec118..75ce11395ee8 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -561,9 +561,13 @@ static netdev_tx_t flexcan_start_xmit(struct sk_buff *skb, struct net_device *de
 static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
 	struct sk_buff *skb;
 	struct can_frame *cf;
 	bool rx_errors = false, tx_errors = false;
+	u32 timestamp;
+
+	timestamp = priv->read(&regs->timer) << 16;
 
 	skb = alloc_can_err_skb(dev, &cf);
 	if (unlikely(!skb))
@@ -610,17 +614,21 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 	if (tx_errors)
 		dev->stats.tx_errors++;
 
-	can_rx_offload_queue_tail(&priv->offload, skb);
+	can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
 }
 
 static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
+	struct flexcan_regs __iomem *regs = priv->regs;
 	struct sk_buff *skb;
 	struct can_frame *cf;
 	enum can_state new_state, rx_state, tx_state;
 	int flt;
 	struct can_berr_counter bec;
+	u32 timestamp;
+
+	timestamp = priv->read(&regs->timer) << 16;
 
 	flt = reg_esr & FLEXCAN_ESR_FLT_CONF_MASK;
 	if (likely(flt == FLEXCAN_ESR_FLT_CONF_ACTIVE)) {
@@ -650,7 +658,7 @@ static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
 	if (unlikely(new_state == CAN_STATE_BUS_OFF))
 		can_bus_off(dev);
 
-	can_rx_offload_queue_tail(&priv->offload, skb);
+	can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
 }
 
 static inline struct flexcan_priv *rx_offload_to_priv(struct can_rx_offload *offload)
-- 
2.19.1
