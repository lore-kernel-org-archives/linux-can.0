From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/2] can: hi311x: Work around TX complete interrupt erratum
Date: Thu, 10 May 2018 18:47:49 +0200
Message-ID: <20180510164749.20481-3-mkl@pengutronix.de>
References: <20180510164749.20481-1-mkl@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180510164749.20481-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Lukas Wunner <lukas@wunner.de>, Mathias Duckeck <m.duckeck@kunbus.de>, Akshay Bhat <akshay.bhat@timesys.com>, Casey Fitzpatrick <casey.fitzpatrick@timesys.com>, stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

When sending packets as fast as possible using "cangen -g 0 -i -x", the
HI-3110 occasionally latches the interrupt pin high on completion of a
packet, but doesn't set the TXCPLT bit in the INTF register.  The INTF
register contains 0x00 as if no interrupt has occurred.  Even waiting
for a few milliseconds after the interrupt doesn't help.

Work around this apparent erratum by instead checking the TXMTY bit in
the STATF register ("TX FIFO empty").  We know that we've queued up a
packet for transmission if priv->tx_len is nonzero.  If the TX FIFO is
empty, transmission of that packet must have completed.

Note that this is congruent with our handling of received packets, which
likewise gleans from the STATF register whether a packet is waiting in
the RX FIFO, instead of looking at the INTF register.

Cc: Mathias Duckeck <m.duckeck@kunbus.de>
Cc: Akshay Bhat <akshay.bhat@timesys.com>
Cc: Casey Fitzpatrick <casey.fitzpatrick@timesys.com>
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Akshay Bhat <akshay.bhat@timesys.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/hi311x.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index c2cf254e4e95..53e320c92a8b 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -91,6 +91,7 @@
 #define HI3110_STAT_BUSOFF BIT(2)
 #define HI3110_STAT_ERRP BIT(3)
 #define HI3110_STAT_ERRW BIT(4)
+#define HI3110_STAT_TXMTY BIT(7)
 
 #define HI3110_BTR0_SJW_SHIFT 6
 #define HI3110_BTR0_BRP_SHIFT 0
@@ -737,10 +738,7 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 			}
 		}
 
-		if (intf == 0)
-			break;
-
-		if (intf & HI3110_INT_TXCPLT) {
+		if (priv->tx_len && statf & HI3110_STAT_TXMTY) {
 			net->stats.tx_packets++;
 			net->stats.tx_bytes += priv->tx_len - 1;
 			can_led_event(net, CAN_LED_EVENT_TX);
@@ -750,6 +748,9 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 			}
 			netif_wake_queue(net);
 		}
+
+		if (intf == 0)
+			break;
 	}
 	mutex_unlock(&priv->hi3110_lock);
 	return IRQ_HANDLED;
-- 
2.17.0
