From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 06/12] can: ti_heccn: don't touch skb after netif_rx()
Date: Sun, 12 Jul 2015 21:54:07 +0200
Message-ID: <1436730853-6593-7-git-send-email-mkl@pengutronix.de>
References: <1436730853-6593-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60255 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbbGLTyT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 12 Jul 2015 15:54:19 -0400
In-Reply-To: <1436730853-6593-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Anant Gole <anantgole@ti.com>, Abhilash K V <abhilash.kv@ti.com>

There is no guarantee that the skb is in the same state after calling
net_receive_skb() or netif_rx(). It might be freed or reused. Not really
harmful as its a read access, except you turn on the proper debugging options
which catch a use after free.

Cc: Anant Gole <anantgole@ti.com>
Cc: Abhilash K V <abhilash.kv@ti.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ti_hecc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index e95a9e1a889f..cf345cbfe819 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -747,9 +747,9 @@ static int ti_hecc_error(struct net_device *ndev, int int_status,
 		}
 	}
 
-	netif_rx(skb);
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
+	netif_rx(skb);
 
 	return 0;
 }
-- 
2.1.4

