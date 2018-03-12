From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/6] can: peak/pcie_fd: remove useless code when interface starts
Date: Mon, 12 Mar 2018 11:04:09 +0100
Message-ID: <20180312100410.10404-6-mkl@pengutronix.de>
References: <20180312100410.10404-1-mkl@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180312100410.10404-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Stephane Grosjean <s.grosjean@peak-system.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Stephane Grosjean <s.grosjean@peak-system.com>

When an interface starts, the echo_skb array is empty and the network
queue should be started only. This patch replaces useless code and locks
when the internal RX_BARRIER message is received from the IP core, telling
the driver that tx may start.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/peak_canfd/peak_canfd.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index 6fa66231ed8e..ed8561d4a90f 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -333,7 +333,6 @@ static int pucan_handle_status(struct peak_canfd_priv *priv,
 
 	/* this STATUS is the CNF of the RX_BARRIER: Tx path can be setup */
 	if (pucan_status_is_rx_barrier(msg)) {
-		unsigned long flags;
 
 		if (priv->enable_tx_path) {
 			int err = priv->enable_tx_path(priv);
@@ -342,16 +341,8 @@ static int pucan_handle_status(struct peak_canfd_priv *priv,
 				return err;
 		}
 
-		/* restart network queue only if echo skb array is free */
-		spin_lock_irqsave(&priv->echo_lock, flags);
-
-		if (!priv->can.echo_skb[priv->echo_idx]) {
-			spin_unlock_irqrestore(&priv->echo_lock, flags);
-
-			netif_wake_queue(ndev);
-		} else {
-			spin_unlock_irqrestore(&priv->echo_lock, flags);
-		}
+		/* start network queue (echo_skb array is empty) */
+		netif_start_queue(ndev);
 
 		return 0;
 	}
-- 
2.16.1
