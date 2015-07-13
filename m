From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 04/12] can: grcan: don't touch skb after netif_rx()
Date: Mon, 13 Jul 2015 09:22:20 +0200
Message-ID: <1436772148-9805-5-git-send-email-mkl@pengutronix.de>
References: <1436772148-9805-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45073 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbbGMHWc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jul 2015 03:22:32 -0400
In-Reply-To: <1436772148-9805-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Andreas Larsson <andreas@gaisler.com>

There is no guarantee that the skb is in the same state after calling
net_receive_skb() or netif_rx(). It might be freed or reused. Not really
harmful as its a read access, except you turn on the proper debugging options
which catch a use after free.

Cc: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/grcan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index e3d7e22a4fa0..db9538d4b358 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1216,11 +1216,12 @@ static int grcan_receive(struct net_device *dev, int budget)
 				cf->data[i] = (u8)(slot[j] >> shift);
 			}
 		}
-		netif_receive_skb(skb);
 
 		/* Update statistics and read pointer */
 		stats->rx_packets++;
 		stats->rx_bytes += cf->can_dlc;
+		netif_receive_skb(skb);
+
 		rd = grcan_ring_add(rd, GRCAN_MSG_SIZE, dma->rx.size);
 	}
 
-- 
2.1.4

