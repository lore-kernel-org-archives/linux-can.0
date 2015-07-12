From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 08/12] can: sja1000: don't touch skb after netif_rx()
Date: Sun, 12 Jul 2015 21:54:09 +0200
Message-ID: <1436730853-6593-9-git-send-email-mkl@pengutronix.de>
References: <1436730853-6593-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:32984 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbbGLTyU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 12 Jul 2015 15:54:20 -0400
In-Reply-To: <1436730853-6593-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>

There is no guarantee that the skb is in the same state after calling
net_receive_skb() or netif_rx(). It might be freed or reused. Not really
harmful as its a read access, except you turn on the proper debugging options
which catch a use after free.

Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 32bd7f451aa4..7b92e911a616 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -377,10 +377,9 @@ static void sja1000_rx(struct net_device *dev)
 	/* release receive buffer */
 	sja1000_write_cmdreg(priv, CMD_RRB);
 
-	netif_rx(skb);
-
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
+	netif_rx(skb);
 
 	can_led_event(dev, CAN_LED_EVENT_RX);
 }
@@ -484,10 +483,9 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 			can_bus_off(dev);
 	}
 
-	netif_rx(skb);
-
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
+	netif_rx(skb);
 
 	return 0;
 }
-- 
2.1.4

