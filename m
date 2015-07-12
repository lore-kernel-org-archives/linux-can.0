From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 12/12] can: pcan_usb: don't touch skb after netif_rx()
Date: Sun, 12 Jul 2015 21:54:13 +0200
Message-ID: <1436730853-6593-13-git-send-email-mkl@pengutronix.de>
References: <1436730853-6593-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55566 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbbGLTyW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 12 Jul 2015 15:54:22 -0400
In-Reply-To: <1436730853-6593-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Stephane Grosjean <s.grosjean@peak-system.com>

There is no guarantee that the skb is in the same state after calling
net_receive_skb() or netif_rx(). It might be freed or reused. Not really
harmful as its a read access, except you turn on the proper debugging options
which catch a use after free.

Cc: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c     | 7 +++----
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 72427f21edff..6b94007ae052 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -526,9 +526,9 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 		hwts->hwtstamp = timeval_to_ktime(tv);
 	}
 
-	netif_rx(skb);
 	mc->netdev->stats.rx_packets++;
 	mc->netdev->stats.rx_bytes += cf->can_dlc;
+	netif_rx(skb);
 
 	return 0;
 }
@@ -659,12 +659,11 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
 	hwts = skb_hwtstamps(skb);
 	hwts->hwtstamp = timeval_to_ktime(tv);
 
-	/* push the skb */
-	netif_rx(skb);
-
 	/* update statistics */
 	mc->netdev->stats.rx_packets++;
 	mc->netdev->stats.rx_bytes += cf->can_dlc;
+	/* push the skb */
+	netif_rx(skb);
 
 	return 0;
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index dec51717635e..7d61b3279798 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -553,9 +553,9 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
 	hwts = skb_hwtstamps(skb);
 	hwts->hwtstamp = timeval_to_ktime(tv);
 
-	netif_rx(skb);
 	netdev->stats.rx_packets++;
 	netdev->stats.rx_bytes += can_frame->can_dlc;
+	netif_rx(skb);
 
 	return 0;
 }
@@ -670,9 +670,9 @@ static int pcan_usb_pro_handle_error(struct pcan_usb_pro_interface *usb_if,
 	peak_usb_get_ts_tv(&usb_if->time_ref, le32_to_cpu(er->ts32), &tv);
 	hwts = skb_hwtstamps(skb);
 	hwts->hwtstamp = timeval_to_ktime(tv);
-	netif_rx(skb);
 	netdev->stats.rx_packets++;
 	netdev->stats.rx_bytes += can_frame->can_dlc;
+	netif_rx(skb);
 
 	return 0;
 }
-- 
2.1.4

