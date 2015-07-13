From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 05/12] can: slcan: don't touch skb after netif_rx_ni()
Date: Mon, 13 Jul 2015 09:22:21 +0200
Message-ID: <1436772148-9805-6-git-send-email-mkl@pengutronix.de>
References: <1436772148-9805-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52269 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbbGMHWd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jul 2015 03:22:33 -0400
In-Reply-To: <1436772148-9805-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>

There is no guarantee that the skb is in the same state after calling
net_receive_skb() or netif_rx(). It might be freed or reused. Not really
harmful as its a read access, except you turn on the proper debugging options
which catch a use after free.

Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/slcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index a23a7af8eb9a..9a3f15cb7ef4 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -218,10 +218,10 @@ static void slc_bump(struct slcan *sl)
 
 	memcpy(skb_put(skb, sizeof(struct can_frame)),
 	       &cf, sizeof(struct can_frame));
-	netif_rx_ni(skb);
 
 	sl->dev->stats.rx_packets++;
 	sl->dev->stats.rx_bytes += cf.can_dlc;
+	netif_rx_ni(skb);
 }
 
 /* parse tty input stream */
-- 
2.1.4

