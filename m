From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: cc770: Fix use after free in cc770_tx_interrupt()
Date: Mon, 19 Mar 2018 11:14:31 +0100
Message-ID: <20180319101431.11032-2-mkl@pengutronix.de>
References: <20180319101431.11032-1-mkl@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180319101431.11032-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Andri Yngvason <andri.yngvason@marel.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Andri Yngvason <andri.yngvason@marel.com>

This fixes use after free introduced by the last cc770 patch.

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
Fixes: 746201235b3f ("can: cc770: Fix queue stall & dropped RTR reply")
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/cc770/cc770.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index 2743d82d4424..6da69af103e6 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -706,13 +706,12 @@ static void cc770_tx_interrupt(struct net_device *dev, unsigned int o)
 		return;
 	}
 
-	can_put_echo_skb(priv->tx_skb, dev, 0);
-	can_get_echo_skb(dev, 0);
-
 	cf = (struct can_frame *)priv->tx_skb->data;
 	stats->tx_bytes += cf->can_dlc;
 	stats->tx_packets++;
 
+	can_put_echo_skb(priv->tx_skb, dev, 0);
+	can_get_echo_skb(dev, 0);
 	priv->tx_skb = NULL;
 
 	netif_wake_queue(dev);
-- 
2.16.2
