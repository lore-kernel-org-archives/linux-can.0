From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 26/29] can: ti_hecc: add missing state changes
Date: Thu, 10 Oct 2019 14:17:47 +0200
Message-ID: <20191010121750.27237-27-mkl@pengutronix.de>
References: <20191010121750.27237-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191010121750.27237-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc: davem@davemloft.net, kernel@pengutronix.de, jhofstee@victronenergy.com, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Jeroen Hofstee <jhofstee@victronenergy.com>

While the ti_hecc has interrupts to report when the error counters increase
to a certain level and which change state it doesn't handle the case that
the error counters go down again, so the reported state can actually be
wrong. Since there is no interrupt for that, do update state based on the
error counters, when the state is not error active and goes down again.

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ti_hecc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index ffd90952cd97..ba0fbe771e36 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -698,6 +698,23 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *dev_id)
 			can_bus_off(ndev);
 			ti_hecc_change_state(ndev, rx_state, tx_state);
 		}
+	} else if (unlikely(priv->can.state != CAN_STATE_ERROR_ACTIVE)) {
+		enum can_state new_state, tx_state, rx_state;
+		u32 rec = hecc_read(priv, HECC_CANREC);
+		u32 tec = hecc_read(priv, HECC_CANTEC);
+
+		if (rec >= 128 || tec >= 128)
+			new_state = CAN_STATE_ERROR_PASSIVE;
+		else if (rec >= 96 || tec >= 96)
+			new_state = CAN_STATE_ERROR_WARNING;
+		else
+			new_state = CAN_STATE_ERROR_ACTIVE;
+
+		if (new_state < priv->can.state) {
+			rx_state = rec >= tec ? new_state : 0;
+			tx_state = rec <= tec ? new_state : 0;
+			ti_hecc_change_state(ndev, rx_state, tx_state);
+		}
 	}
 
 	if (int_status & HECC_CANGIF_GMIF) {
-- 
2.23.0
