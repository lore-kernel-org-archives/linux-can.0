From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 8/8] can: kvaser_usb: Don't dereference skb after a netif_rx()
Date: Thu, 15 Jan 2015 17:11:23 +0100
Message-ID: <1421338283-12417-9-git-send-email-mkl@pengutronix.de>
References: <1421338283-12417-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56659 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855AbbAOQLl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 15 Jan 2015 11:11:41 -0500
In-Reply-To: <1421338283-12417-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, "Ahmed S. Darwish" <ahmed.darwish@valeo.com>, Marc Kleine-Budde <mkl@pengutronix.de>

From: "Ahmed S. Darwish" <ahmed.darwish@valeo.com>

We should not touch the packet after a netif_rx: it might
get freed behind our back.

Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Ahmed S. Darwish <ahmed.darwish@valeo.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index cc7bfc0c0a71..c32cd61073bc 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -520,10 +520,10 @@ static void kvaser_usb_tx_acknowledge(const struct kvaser_usb *dev,
 		skb = alloc_can_err_skb(priv->netdev, &cf);
 		if (skb) {
 			cf->can_id |= CAN_ERR_RESTARTED;
-			netif_rx(skb);
 
 			stats->rx_packets++;
 			stats->rx_bytes += cf->can_dlc;
+			netif_rx(skb);
 		} else {
 			netdev_err(priv->netdev,
 				   "No memory left for err_skb\n");
@@ -770,10 +770,9 @@ static void kvaser_usb_rx_error(const struct kvaser_usb *dev,
 
 	priv->can.state = new_state;
 
-	netif_rx(skb);
-
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
+	netif_rx(skb);
 }
 
 static void kvaser_usb_rx_can_err(const struct kvaser_usb_net_priv *priv,
@@ -805,10 +804,9 @@ static void kvaser_usb_rx_can_err(const struct kvaser_usb_net_priv *priv,
 		stats->rx_over_errors++;
 		stats->rx_errors++;
 
-		netif_rx(skb);
-
 		stats->rx_packets++;
 		stats->rx_bytes += cf->can_dlc;
+		netif_rx(skb);
 	}
 }
 
@@ -887,10 +885,9 @@ static void kvaser_usb_rx_can_msg(const struct kvaser_usb *dev,
 			       cf->can_dlc);
 	}
 
-	netif_rx(skb);
-
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
+	netif_rx(skb);
 }
 
 static void kvaser_usb_start_chip_reply(const struct kvaser_usb *dev,
-- 
2.1.4

