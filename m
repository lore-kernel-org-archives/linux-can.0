From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/6] can: peak/pcie_fd: fix echo_skb is occupied! bug
Date: Mon, 12 Mar 2018 11:04:08 +0100
Message-ID: <20180312100410.10404-5-mkl@pengutronix.de>
References: <20180312100410.10404-1-mkl@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180312100410.10404-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Stephane Grosjean <s.grosjean@peak-system.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Stephane Grosjean <s.grosjean@peak-system.com>

This patch makes atomic the handling of the linux-can echo_skb array and
the network tx queue. This prevents from the "BUG! echo_skb is occupied!"
message to be printed by the linux-can core, in SMP environments.

Reported-by: Diana Burgess <diana@peloton-tech.com>
Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/peak_canfd/peak_canfd.c       | 12 ++++++------
 drivers/net/can/peak_canfd/peak_pciefd_main.c |  8 ++++++--
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index 55513411a82e..6fa66231ed8e 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -262,7 +262,6 @@ static int pucan_handle_can_rx(struct peak_canfd_priv *priv,
 
 		spin_lock_irqsave(&priv->echo_lock, flags);
 		can_get_echo_skb(priv->ndev, msg->client);
-		spin_unlock_irqrestore(&priv->echo_lock, flags);
 
 		/* count bytes of the echo instead of skb */
 		stats->tx_bytes += cf_len;
@@ -271,6 +270,7 @@ static int pucan_handle_can_rx(struct peak_canfd_priv *priv,
 		/* restart tx queue (a slot is free) */
 		netif_wake_queue(priv->ndev);
 
+		spin_unlock_irqrestore(&priv->echo_lock, flags);
 		return 0;
 	}
 
@@ -726,11 +726,6 @@ static netdev_tx_t peak_canfd_start_xmit(struct sk_buff *skb,
 	 */
 	should_stop_tx_queue = !!(priv->can.echo_skb[priv->echo_idx]);
 
-	spin_unlock_irqrestore(&priv->echo_lock, flags);
-
-	/* write the skb on the interface */
-	priv->write_tx_msg(priv, msg);
-
 	/* stop network tx queue if not enough room to save one more msg too */
 	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
 		should_stop_tx_queue |= (room_left <
@@ -742,6 +737,11 @@ static netdev_tx_t peak_canfd_start_xmit(struct sk_buff *skb,
 	if (should_stop_tx_queue)
 		netif_stop_queue(ndev);
 
+	spin_unlock_irqrestore(&priv->echo_lock, flags);
+
+	/* write the skb on the interface */
+	priv->write_tx_msg(priv, msg);
+
 	return NETDEV_TX_OK;
 }
 
diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/net/can/peak_canfd/peak_pciefd_main.c
index 788c3464a3b0..3c51a884db87 100644
--- a/drivers/net/can/peak_canfd/peak_pciefd_main.c
+++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
@@ -349,8 +349,12 @@ static irqreturn_t pciefd_irq_handler(int irq, void *arg)
 		priv->tx_pages_free++;
 		spin_unlock_irqrestore(&priv->tx_lock, flags);
 
-		/* wake producer up */
-		netif_wake_queue(priv->ucan.ndev);
+		/* wake producer up (only if enough room in echo_skb array) */
+		spin_lock_irqsave(&priv->ucan.echo_lock, flags);
+		if (!priv->ucan.can.echo_skb[priv->ucan.echo_idx])
+			netif_wake_queue(priv->ucan.ndev);
+
+		spin_unlock_irqrestore(&priv->ucan.echo_lock, flags);
 	}
 
 	/* re-enable Rx DMA transfer for this CAN */
-- 
2.16.1
