From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 21/29] can: ti_hecc: ti_hecc_stop(): stop the CPK on down
Date: Thu, 10 Oct 2019 14:17:42 +0200
Message-ID: <20191010121750.27237-22-mkl@pengutronix.de>
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

When the interface goes down, the CPK should no longer take an active
part in the CAN-bus communication, like sending acks and error frames.
So enable configuration mode in ti_hecc_stop, so the CPK is no longer
active.

When a transceiver switch is present the acks and errors don't make it
to the bus, but disabling the CPK then does prevent oddities, like
ti_hecc_reset() failing, since the CPK can become bus-off and starts
counting the 11 bit recessive bits, which seems to block the reset. It
can also cause invalid interrupts and disrupt the CAN-bus, since
transmission can be stopped in the middle of a message, by disabling the
tranceiver while the CPK is sending.

Since the CPK is disabled after normal power on, it is typically only
seen when the interface is restarted.

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ti_hecc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 91188e6d4f78..eb8151154083 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -400,6 +400,9 @@ static void ti_hecc_stop(struct net_device *ndev)
 {
 	struct ti_hecc_priv *priv = netdev_priv(ndev);
 
+	/* Disable the CPK; stop sending, erroring and acking */
+	hecc_set_bit(priv, HECC_CANMC, HECC_CANMC_CCR);
+
 	/* Disable interrupts and disable mailboxes */
 	hecc_write(priv, HECC_CANGIM, 0);
 	hecc_write(priv, HECC_CANMIM, 0);
-- 
2.23.0
