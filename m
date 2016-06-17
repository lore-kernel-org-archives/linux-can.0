From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 1/2] can: gs_usb: codingstyle: introduce use of BIT() + fix indention
Date: Fri, 17 Jun 2016 12:03:26 +0200
Message-ID: <1466157807-12727-2-git-send-email-mkl@pengutronix.de>
References: <1466157807-12727-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42453 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933404AbcFQKDa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2016 06:03:30 -0400
In-Reply-To: <1466157807-12727-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc: Maximilian Schneider <max@schneidersoft.net>, Hubert Denkmair <hubert@denkmair.de>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Maximilian Schneider <max@schneidersoft.net>

This patch converts "1 << n" by BIT(n) and fixes the indention. No
functional change.

Signed-off-by: Hubert Denkmair <hubert@denkmair.de>
Signed-off-by: Maximilian Schneider <max@schneidersoft.net>
[mkl: split codingstyle changes into separate patch]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 1556d4286235..6186a9436bb8 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -77,10 +77,10 @@ struct gs_device_config {
 } __packed;
 
 #define GS_CAN_MODE_NORMAL               0
-#define GS_CAN_MODE_LISTEN_ONLY          (1<<0)
-#define GS_CAN_MODE_LOOP_BACK            (1<<1)
-#define GS_CAN_MODE_TRIPLE_SAMPLE        (1<<2)
-#define GS_CAN_MODE_ONE_SHOT             (1<<3)
+#define GS_CAN_MODE_LISTEN_ONLY          BIT(0)
+#define GS_CAN_MODE_LOOP_BACK            BIT(1)
+#define GS_CAN_MODE_TRIPLE_SAMPLE        BIT(2)
+#define GS_CAN_MODE_ONE_SHOT             BIT(3)
 
 struct gs_device_mode {
 	u32 mode;
@@ -101,10 +101,10 @@ struct gs_device_bittiming {
 	u32 brp;
 } __packed;
 
-#define GS_CAN_FEATURE_LISTEN_ONLY      (1<<0)
-#define GS_CAN_FEATURE_LOOP_BACK        (1<<1)
-#define GS_CAN_FEATURE_TRIPLE_SAMPLE    (1<<2)
-#define GS_CAN_FEATURE_ONE_SHOT         (1<<3)
+#define GS_CAN_FEATURE_LISTEN_ONLY      BIT(0)
+#define GS_CAN_FEATURE_LOOP_BACK        BIT(1)
+#define GS_CAN_FEATURE_TRIPLE_SAMPLE    BIT(2)
+#define GS_CAN_FEATURE_ONE_SHOT         BIT(3)
 
 struct gs_device_bt_const {
 	u32 feature;
@@ -209,7 +209,8 @@ static void gs_free_tx_context(struct gs_tx_context *txc)
 
 /* Get a tx context by id.
  */
-static struct gs_tx_context *gs_get_tx_context(struct gs_can *dev, unsigned int id)
+static struct gs_tx_context *gs_get_tx_context(struct gs_can *dev,
+					       unsigned int id)
 {
 	unsigned long flags;
 
@@ -452,7 +453,8 @@ static void gs_usb_xmit_callback(struct urb *urb)
 		netif_wake_queue(netdev);
 }
 
-static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
+				     struct net_device *netdev)
 {
 	struct gs_can *dev = netdev_priv(netdev);
 	struct net_device_stats *stats = &dev->netdev->stats;
@@ -658,7 +660,8 @@ static int gs_can_open(struct net_device *netdev)
 	rc = usb_control_msg(interface_to_usbdev(dev->iface),
 			     usb_sndctrlpipe(interface_to_usbdev(dev->iface), 0),
 			     GS_USB_BREQ_MODE,
-			     USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+			     USB_DIR_OUT | USB_TYPE_VENDOR |
+			     USB_RECIP_INTERFACE,
 			     dev->channel,
 			     0,
 			     dm,
-- 
2.8.1

