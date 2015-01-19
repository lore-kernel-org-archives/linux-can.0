From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH] can/peak_usb: upgrade core to new CANFD extension
Date: Mon, 19 Jan 2015 17:15:25 +0100
Message-ID: <1421684127-12764-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:59544 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbbASQXU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 Jan 2015 11:23:20 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>

Upgrade PEAK-System USB adapters core to the new data structures (names)
and callbacks added for the support of the CANFD extension.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 59 ++++++++++++++++++++++++----
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  9 ++++-
 2 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index c62f48a..be267af 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -165,6 +165,21 @@ void peak_usb_get_ts_tv(struct peak_time_ref *time_ref, u32 ts,
 }
 
 /*
+ * post received skb after having set any hw timestamp
+ */
+int peak_usb_netif_rx(struct sk_buff *skb,
+		      struct peak_time_ref *time_ref, u32 ts_low, u32 ts_high)
+{
+	struct skb_shared_hwtstamps *hwts = skb_hwtstamps(skb);
+	struct timeval tv;
+
+	peak_usb_get_ts_tv(time_ref, ts_low, &tv);
+	hwts->hwtstamp = timeval_to_ktime(tv);
+
+	return netif_rx(skb);
+}
+
+/*
  * callback for bulk Rx urb
  */
 static void peak_usb_read_bulk_callback(struct urb *urb)
@@ -253,7 +268,7 @@ static void peak_usb_write_bulk_callback(struct urb *urb)
 	case 0:
 		/* transmission complete */
 		netdev->stats.tx_packets++;
-		netdev->stats.tx_bytes += context->dlc;
+		netdev->stats.tx_bytes += context->data_len;
 
 		/* prevent tx timeout */
 		netdev->trans_start = jiffies;
@@ -289,7 +304,7 @@ static netdev_tx_t peak_usb_ndo_start_xmit(struct sk_buff *skb,
 	struct peak_usb_device *dev = netdev_priv(netdev);
 	struct peak_tx_urb_context *context = NULL;
 	struct net_device_stats *stats = &netdev->stats;
-	struct can_frame *cf = (struct can_frame *)skb->data;
+	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 	struct urb *urb;
 	u8 *obuf;
 	int i, err;
@@ -322,7 +337,9 @@ static netdev_tx_t peak_usb_ndo_start_xmit(struct sk_buff *skb,
 	}
 
 	context->echo_index = i;
-	context->dlc = cf->can_dlc;
+
+	/* Note: this works with CANFD frames too */
+	context->data_len = cfd->len;
 
 	usb_anchor_urb(urb, &dev->tx_submitted);
 
@@ -679,19 +696,43 @@ static int peak_usb_set_mode(struct net_device *netdev, enum can_mode mode)
 }
 
 /*
- * candev callback used to set device bitrate.
+ * candev callback used to set device nominal/arbitration bitrate.
  */
 static int peak_usb_set_bittiming(struct net_device *netdev)
 {
 	struct peak_usb_device *dev = netdev_priv(netdev);
-	struct can_bittiming *bt = &dev->can.bittiming;
+	struct peak_usb_adapter *pa = dev->adapter;
 
-	if (dev->adapter->dev_set_bittiming) {
-		int err = dev->adapter->dev_set_bittiming(dev, bt);
+	if (pa->dev_set_bittiming) {
+		struct can_bittiming *bt = &dev->can.bittiming;
+		int err = pa->dev_set_bittiming(dev, bt);
 
 		if (err)
 			netdev_info(netdev, "couldn't set bitrate (err %d)\n",
-				err);
+				    err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * candev callback used to set device data bitrate.
+ */
+static int peak_usb_set_data_bittiming(struct net_device *netdev)
+{
+	struct peak_usb_device *dev = netdev_priv(netdev);
+	struct peak_usb_adapter *pa = dev->adapter;
+
+	if (pa->dev_set_data_bittiming) {
+		struct can_bittiming *bt = &dev->can.data_bittiming;
+		int err = pa->dev_set_data_bittiming(dev, bt);
+
+		if (err)
+			netdev_info(netdev,
+				    "couldn't set data bitrate (err %d)\n",
+				    err);
+
 		return err;
 	}
 
@@ -750,6 +791,8 @@ static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
 	dev->can.clock = peak_usb_adapter->clock;
 	dev->can.bittiming_const = &peak_usb_adapter->bittiming_const;
 	dev->can.do_set_bittiming = peak_usb_set_bittiming;
+	dev->can.data_bittiming_const = &peak_usb_adapter->data_bittiming_const;
+	dev->can.do_set_data_bittiming = peak_usb_set_data_bittiming;
 	dev->can.do_set_mode = peak_usb_set_mode;
 	dev->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES |
 				      CAN_CTRLMODE_LISTENONLY;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 073b47f..928012f 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -46,6 +46,7 @@ struct peak_usb_adapter {
 	u32 device_id;
 	struct can_clock clock;
 	const struct can_bittiming_const bittiming_const;
+	const struct can_bittiming_const data_bittiming_const;
 	unsigned int ctrl_count;
 
 	int (*intf_probe)(struct usb_interface *intf);
@@ -57,6 +58,8 @@ struct peak_usb_adapter {
 	int (*dev_close)(struct peak_usb_device *dev);
 	int (*dev_set_bittiming)(struct peak_usb_device *dev,
 					struct can_bittiming *bt);
+	int (*dev_set_data_bittiming)(struct peak_usb_device *dev,
+				      struct can_bittiming *bt);
 	int (*dev_set_bus)(struct peak_usb_device *dev, u8 onoff);
 	int (*dev_get_device_id)(struct peak_usb_device *dev, u32 *device_id);
 	int (*dev_decode_buf)(struct peak_usb_device *dev, struct urb *urb);
@@ -92,7 +95,7 @@ struct peak_time_ref {
 struct peak_tx_urb_context {
 	struct peak_usb_device *dev;
 	u32 echo_index;
-	u8 dlc;
+	u8 data_len;
 	struct urb *urb;
 };
 
@@ -139,7 +142,9 @@ void peak_usb_update_ts_now(struct peak_time_ref *time_ref, u32 ts_now);
 void peak_usb_set_ts_now(struct peak_time_ref *time_ref, u32 ts_now);
 void peak_usb_get_ts_tv(struct peak_time_ref *time_ref, u32 ts,
 			struct timeval *tv);
-
+int peak_usb_netif_rx(struct sk_buff *skb,
+		      struct peak_time_ref *time_ref, u32 ts_low, u32 ts_high);
 void peak_usb_async_complete(struct urb *urb);
 void peak_usb_restart_complete(struct peak_usb_device *dev);
+
 #endif
-- 
1.9.1

