From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 18/20] can: flexcan: handle tx-complete CAN frames via rx-offload infrastructure
Date: Mon, 12 Nov 2018 12:57:26 +0100
Message-ID: <20181112115728.18331-19-mkl@pengutronix.de>
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

Current flexcan driver will put TX-ECHO in regular unsorted way, in
this case TX-ECHO can come after the response to the same TXed message.
In some cases, for example for J1939 stack, things will break.
This patch is using new rx-offload API to put the messages just in the
right place.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 68b46395c580..41a175f80c4b 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -787,8 +787,11 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 
 	/* transmission complete interrupt */
 	if (reg_iflag2 & FLEXCAN_IFLAG_MB(FLEXCAN_TX_MB)) {
+		u32 reg_ctrl = priv->read(&regs->mb[FLEXCAN_TX_MB].can_ctrl);
+
 		handled = IRQ_HANDLED;
-		stats->tx_bytes += can_get_echo_skb(dev, 0);
+		stats->tx_bytes += can_rx_offload_get_echo_skb(&priv->offload,
+							       0, reg_ctrl << 16);
 		stats->tx_packets++;
 		can_led_event(dev, CAN_LED_EVENT_TX);
 
-- 
2.19.1
