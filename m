From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6/6] can: peak/pcie_fd: fix potential bug in restarting tx queue
Date: Fri,  8 Dec 2017 16:58:17 +0100
Message-ID: <20171208155817.9364-7-mkl@pengutronix.de>
References: <20171208155817.9364-1-mkl@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20171208155817.9364-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Stephane Grosjean <s.grosjean@peak-system.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Stephane Grosjean <s.grosjean@peak-system.com>

Don't rely on can_get_echo_skb() return value to wake the network tx
queue up: can_get_echo_skb() returns 0 if the echo array slot was not
occupied, but also when the DLC of the released echo frame was 0.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/peak_canfd/peak_canfd.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index 85268be0c913..55513411a82e 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -258,21 +258,18 @@ static int pucan_handle_can_rx(struct peak_canfd_priv *priv,
 	/* if this frame is an echo, */
 	if ((rx_msg_flags & PUCAN_MSG_LOOPED_BACK) &&
 	    !(rx_msg_flags & PUCAN_MSG_SELF_RECEIVE)) {
-		int n;
 		unsigned long flags;
 
 		spin_lock_irqsave(&priv->echo_lock, flags);
-		n = can_get_echo_skb(priv->ndev, msg->client);
+		can_get_echo_skb(priv->ndev, msg->client);
 		spin_unlock_irqrestore(&priv->echo_lock, flags);
 
 		/* count bytes of the echo instead of skb */
 		stats->tx_bytes += cf_len;
 		stats->tx_packets++;
 
-		if (n) {
-			/* restart tx queue only if a slot is free */
-			netif_wake_queue(priv->ndev);
-		}
+		/* restart tx queue (a slot is free) */
+		netif_wake_queue(priv->ndev);
 
 		return 0;
 	}
-- 
2.15.0
