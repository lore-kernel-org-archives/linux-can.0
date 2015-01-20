From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v6 4/7] can: peak_usb: upgrade core to new CANFD extension - struct canfd_frame
Date: Tue, 20 Jan 2015 15:15:26 +0100
Message-ID: <1421763329-21915-4-git-send-email-mkl@pengutronix.de>
References: <1421763329-21915-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53250 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbbATOPf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Jan 2015 09:15:35 -0500
In-Reply-To: <1421763329-21915-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

From: Stephane Grosjean <s.grosjean@peak-system.com>

Upgrade PEAK-System USB adapters core to the new data structures (names) and
callbacks added for the support of the CANFD extension.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 8 +++++---
 drivers/net/can/usb/peak_usb/pcan_usb_core.h | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 6061d8f3ff44..49004aac0492 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -253,7 +253,7 @@ static void peak_usb_write_bulk_callback(struct urb *urb)
 	case 0:
 		/* transmission complete */
 		netdev->stats.tx_packets++;
-		netdev->stats.tx_bytes += context->dlc;
+		netdev->stats.tx_bytes += context->data_len;
 
 		/* prevent tx timeout */
 		netdev->trans_start = jiffies;
@@ -289,7 +289,7 @@ static netdev_tx_t peak_usb_ndo_start_xmit(struct sk_buff *skb,
 	struct peak_usb_device *dev = netdev_priv(netdev);
 	struct peak_tx_urb_context *context = NULL;
 	struct net_device_stats *stats = &netdev->stats;
-	struct can_frame *cf = (struct can_frame *)skb->data;
+	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 	struct urb *urb;
 	u8 *obuf;
 	int i, err;
@@ -322,7 +322,9 @@ static netdev_tx_t peak_usb_ndo_start_xmit(struct sk_buff *skb,
 	}
 
 	context->echo_index = i;
-	context->dlc = cf->can_dlc;
+
+	/* Note: this works with CANFD frames too */
+	context->data_len = cfd->len;
 
 	usb_anchor_urb(urb, &dev->tx_submitted);
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index fdc5c0de58f6..34e24c6fd778 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -98,7 +98,7 @@ struct peak_time_ref {
 struct peak_tx_urb_context {
 	struct peak_usb_device *dev;
 	u32 echo_index;
-	u8 dlc;
+	u8 data_len;
 	struct urb *urb;
 };
 
-- 
2.1.4

