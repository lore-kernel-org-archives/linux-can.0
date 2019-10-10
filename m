From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 19/29] can: flexcan: increase error counters if skb enqueueing via can_rx_offload_queue_sorted() fails
Date: Thu, 10 Oct 2019 14:17:40 +0200
Message-ID: <20191010121750.27237-20-mkl@pengutronix.de>
References: <20191010121750.27237-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191010121750.27237-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc: davem@davemloft.net, kernel@pengutronix.de, jhofstee@victronenergy.com, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

The call to can_rx_offload_queue_sorted() may fail and return an error
(in the current implementation due to resource shortage). The passed skb
is consumed.

This patch adds incrementing of the appropriate error counters to let
the device statistics reflect that there's a problem.

Reported-by: Martin Hundebøll <martin@geanix.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 1cd5179cb876..57f9a2f51085 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -677,6 +677,7 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 	struct can_frame *cf;
 	bool rx_errors = false, tx_errors = false;
 	u32 timestamp;
+	int err;
 
 	timestamp = priv->read(&regs->timer) << 16;
 
@@ -725,7 +726,9 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 	if (tx_errors)
 		dev->stats.tx_errors++;
 
-	can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
+	if (err)
+		dev->stats.rx_fifo_errors++;
 }
 
 static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
@@ -738,6 +741,7 @@ static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
 	int flt;
 	struct can_berr_counter bec;
 	u32 timestamp;
+	int err;
 
 	timestamp = priv->read(&regs->timer) << 16;
 
@@ -769,7 +773,9 @@ static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
 	if (unlikely(new_state == CAN_STATE_BUS_OFF))
 		can_bus_off(dev);
 
-	can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
+	if (err)
+		dev->stats.rx_fifo_errors++;
 }
 
 static inline struct flexcan_priv *rx_offload_to_priv(struct can_rx_offload *offload)
-- 
2.23.0
