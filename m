From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 19/20] can: rx-offload: rename can_rx_offload_irq_queue_err_skb() to can_rx_offload_queue_tail()
Date: Mon, 12 Nov 2018 12:57:27 +0100
Message-ID: <20181112115728.18331-20-mkl@pengutronix.de>
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

This function has nothing todo with error.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c      | 4 ++--
 drivers/net/can/rx-offload.c   | 5 +++--
 include/linux/can/rx-offload.h | 3 ++-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 41a175f80c4b..5923bd0ec118 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -610,7 +610,7 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 	if (tx_errors)
 		dev->stats.tx_errors++;
 
-	can_rx_offload_irq_queue_err_skb(&priv->offload, skb);
+	can_rx_offload_queue_tail(&priv->offload, skb);
 }
 
 static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
@@ -650,7 +650,7 @@ static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
 	if (unlikely(new_state == CAN_STATE_BUS_OFF))
 		can_bus_off(dev);
 
-	can_rx_offload_irq_queue_err_skb(&priv->offload, skb);
+	can_rx_offload_queue_tail(&priv->offload, skb);
 }
 
 static inline struct flexcan_priv *rx_offload_to_priv(struct can_rx_offload *offload)
diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index c368686e2164..2ce4fa8698c7 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -257,7 +257,8 @@ unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
 }
 EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb);
 
-int can_rx_offload_irq_queue_err_skb(struct can_rx_offload *offload, struct sk_buff *skb)
+int can_rx_offload_queue_tail(struct can_rx_offload *offload,
+			      struct sk_buff *skb)
 {
 	if (skb_queue_len(&offload->skb_queue) >
 	    offload->skb_queue_len_max)
@@ -268,7 +269,7 @@ int can_rx_offload_irq_queue_err_skb(struct can_rx_offload *offload, struct sk_b
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(can_rx_offload_irq_queue_err_skb);
+EXPORT_SYMBOL_GPL(can_rx_offload_queue_tail);
 
 static int can_rx_offload_init_queue(struct net_device *dev, struct can_rx_offload *offload, unsigned int weight)
 {
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.h
index 01a7c9e5d8d8..8268811a697e 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -45,7 +45,8 @@ int can_rx_offload_queue_sorted(struct can_rx_offload *offload,
 				struct sk_buff *skb, u32 timestamp);
 unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
 					 unsigned int idx, u32 timestamp);
-int can_rx_offload_irq_queue_err_skb(struct can_rx_offload *offload, struct sk_buff *skb);
+int can_rx_offload_queue_tail(struct can_rx_offload *offload,
+			      struct sk_buff *skb);
 void can_rx_offload_reset(struct can_rx_offload *offload);
 void can_rx_offload_del(struct can_rx_offload *offload);
 void can_rx_offload_enable(struct can_rx_offload *offload);
-- 
2.19.1
