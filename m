From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 10/12] can: ems_usb: don't touch skb after netif_rx()
Date: Sun, 12 Jul 2015 21:54:11 +0200
Message-ID: <1436730853-6593-11-git-send-email-mkl@pengutronix.de>
References: <1436730853-6593-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35195 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbbGLTyV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 12 Jul 2015 15:54:21 -0400
In-Reply-To: <1436730853-6593-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>

There is no guarantee that the skb is in the same state after calling
net_receive_skb() or netif_rx(). It might be freed or reused. Not really
harmful as its a read access, except you turn on the proper debugging options
which catch a use after free.

Cc: Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/ems_usb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 866bac0ae7e9..2d390384ef3b 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -324,10 +324,9 @@ static void ems_usb_rx_can_msg(struct ems_usb *dev, struct ems_cpc_msg *msg)
 			cf->data[i] = msg->msg.can_msg.msg[i];
 	}
 
-	netif_rx(skb);
-
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
+	netif_rx(skb);
 }
 
 static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
@@ -400,10 +399,9 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 		stats->rx_errors++;
 	}
 
-	netif_rx(skb);
-
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
+	netif_rx(skb);
 }
 
 /*
-- 
2.1.4

