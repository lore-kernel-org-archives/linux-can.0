From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 3/3] can/peak_usb: CAN-FD: driver's core modifications
Date: Thu, 27 Nov 2014 11:32:09 +0100
Message-ID: <1417084329-8997-4-git-send-email-s.grosjean@peak-system.com>
References: <1417084329-8997-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:16890 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbaK0Kex (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Nov 2014 05:34:53 -0500
In-Reply-To: <1417084329-8997-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>

This patch modifies the core of the PEAK-System CAN USB adapters driver to
include the support the new CAN-FD USB adapters.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/Kconfig                  | 14 ++++-
 drivers/net/can/usb/peak_usb/Makefile        |  2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 84 ++++++++++++++++++++++------
 drivers/net/can/usb/peak_usb/pcan_usb_core.h | 14 ++++-
 4 files changed, 90 insertions(+), 24 deletions(-)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index a77db919..6dbbc85 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -53,10 +53,18 @@ config CAN_KVASER_USB
 	  module will be called kvaser_usb.
 
 config CAN_PEAK_USB
-	tristate "PEAK PCAN-USB/USB Pro interfaces"
+	tristate "PEAK PCAN-USB/USB Pro interfaces for CAN 2.0b/CAN-FD"
 	---help---
-	  This driver supports the PCAN-USB and PCAN-USB Pro adapters
-	  from PEAK-System Technik (http://www.peak-system.com).
+	  This driver supports the PEAK-System Technik USB adapters that enable
+	  access to the CAN bus, with repect to the CAN 2.0b and/or CAN-FD
+	  standards, that is:
+
+	  PCAN-USB             single CAN 2.0b channel USB adapter
+	  PCAN-USB Pro         dual CAN 2.0b channels USB adapter
+	  PCAN-USB FD          single CAN-FD channel USB adapter
+	  PCAN-USB Pro FD      dual CAN-FD channels USB adapter
+
+	  (see also http://www.peak-system.com).
 
 config CAN_8DEV_USB
 	tristate "8 devices USB2CAN interface"
diff --git a/drivers/net/can/usb/peak_usb/Makefile b/drivers/net/can/usb/peak_usb/Makefile
index 1aefbc8..1839e9c 100644
--- a/drivers/net/can/usb/peak_usb/Makefile
+++ b/drivers/net/can/usb/peak_usb/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_CAN_PEAK_USB) += peak_usb.o
-peak_usb-y = pcan_usb_core.o pcan_usb.o pcan_usb_pro.o
+peak_usb-y = pcan_usb_core.o pcan_usb.o pcan_usb_pro.o pcan_usb_fd.o
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 644e6ab..2f034c1 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -37,6 +37,8 @@ MODULE_LICENSE("GPL v2");
 static struct usb_device_id peak_usb_table[] = {
 	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USB_PRODUCT_ID)},
 	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBPRO_PRODUCT_ID)},
+	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBPROFD_PRODUCT_ID)},
+	{USB_DEVICE(PCAN_USB_VENDOR_ID, PCAN_USBFD_PRODUCT_ID)},
 	{} /* Terminating entry */
 };
 
@@ -46,6 +48,8 @@ MODULE_DEVICE_TABLE(usb, peak_usb_table);
 static struct peak_usb_adapter *peak_usb_adapters_list[] = {
 	&pcan_usb,
 	&pcan_usb_pro,
+	&pcan_usb_pro_fd,
+	&pcan_usb_fd,
 	NULL,
 };
 
@@ -89,7 +93,7 @@ static void peak_usb_add_us(struct timeval *tv, u32 delta_us)
 }
 
 /*
- * sometimes, another now may be  more recent than current one...
+ * sometimes, another "now" may be more recent than current one...
  */
 void peak_usb_update_ts_now(struct peak_time_ref *time_ref, u32 ts_now)
 {
@@ -107,7 +111,7 @@ void peak_usb_update_ts_now(struct peak_time_ref *time_ref, u32 ts_now)
 }
 
 /*
- * register device timestamp as now
+ * register device timestamp as "now"
  */
 void peak_usb_set_ts_now(struct peak_time_ref *time_ref, u32 ts_now)
 {
@@ -165,6 +169,21 @@ void peak_usb_get_ts_tv(struct peak_time_ref *time_ref, u32 ts,
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
@@ -253,7 +272,7 @@ static void peak_usb_write_bulk_callback(struct urb *urb)
 	case 0:
 		/* transmission complete */
 		netdev->stats.tx_packets++;
-		netdev->stats.tx_bytes += context->dlc;
+		netdev->stats.tx_bytes += context->data_len;
 
 		/* prevent tx timeout */
 		netdev->trans_start = jiffies;
@@ -322,7 +341,9 @@ static netdev_tx_t peak_usb_ndo_start_xmit(struct sk_buff *skb,
 	}
 
 	context->echo_index = i;
-	context->dlc = cf->can_dlc;
+
+	/* Note: this works with CANFD frames too */
+	context->data_len = cf->can_dlc;
 
 	usb_anchor_urb(urb, &dev->tx_submitted);
 
@@ -679,19 +700,43 @@ static int peak_usb_set_mode(struct net_device *netdev, enum can_mode mode)
 }
 
 /*
- * candev callback used to set device bitrate.
+ * candev callback used to set device nominal bitrate.
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
 
@@ -735,7 +780,7 @@ static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
 	dev->cmd_buf = kmalloc(PCAN_USB_MAX_CMD_LEN, GFP_KERNEL);
 	if (!dev->cmd_buf) {
 		err = -ENOMEM;
-		goto lbl_set_intf_data;
+		goto lbl_free_candev;
 	}
 
 	dev->udev = usb_dev;
@@ -750,9 +795,10 @@ static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
 	dev->can.clock = peak_usb_adapter->clock;
 	dev->can.bittiming_const = &peak_usb_adapter->bittiming_const;
 	dev->can.do_set_bittiming = peak_usb_set_bittiming;
+	dev->can.data_bittiming_const = &peak_usb_adapter->data_bittiming_const;
+	dev->can.do_set_data_bittiming = peak_usb_set_data_bittiming;
 	dev->can.do_set_mode = peak_usb_set_mode;
-	dev->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES |
-				      CAN_CTRLMODE_LISTENONLY;
+	dev->can.ctrlmode_supported = peak_usb_adapter->ctrlmode_supported;
 
 	netdev->netdev_ops = &peak_usb_netdev_ops;
 
@@ -770,12 +816,11 @@ static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
 	usb_set_intfdata(intf, dev);
 
 	SET_NETDEV_DEV(netdev, &intf->dev);
-	netdev->dev_id = ctrl_idx;
 
 	err = register_candev(netdev);
 	if (err) {
 		dev_err(&intf->dev, "couldn't register CAN device: %d\n", err);
-		goto lbl_free_cmd_buf;
+		goto lbl_set_intf_data;
 	}
 
 	if (dev->prev_siblings)
@@ -788,14 +833,14 @@ static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
 	if (dev->adapter->dev_init) {
 		err = dev->adapter->dev_init(dev);
 		if (err)
-			goto lbl_free_cmd_buf;
+			goto lbl_unregister;
 	}
 
 	/* set bus off */
 	if (dev->adapter->dev_set_bus) {
 		err = dev->adapter->dev_set_bus(dev, 0);
 		if (err)
-			goto lbl_free_cmd_buf;
+			goto lbl_unregister;
 	}
 
 	/* get device number early */
@@ -807,11 +852,14 @@ static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
 
 	return 0;
 
-lbl_free_cmd_buf:
-	kfree(dev->cmd_buf);
+lbl_unregister:
+	unregister_netdev(netdev);
 
 lbl_set_intf_data:
 	usb_set_intfdata(intf, dev->prev_siblings);
+	kfree(dev->cmd_buf);
+
+lbl_free_candev:
 	free_candev(netdev);
 
 	return err;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 073b47f..13d44a5 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -25,6 +25,8 @@
 /* supported device ids. */
 #define PCAN_USB_PRODUCT_ID		0x000c
 #define PCAN_USBPRO_PRODUCT_ID		0x000d
+#define PCAN_USBPROFD_PRODUCT_ID	0x0011
+#define PCAN_USBFD_PRODUCT_ID		0x0012
 
 #define PCAN_USB_DRIVER_NAME		"peak_usb"
 
@@ -44,8 +46,10 @@ struct peak_usb_device;
 struct peak_usb_adapter {
 	char *name;
 	u32 device_id;
+	u32 ctrlmode_supported;
 	struct can_clock clock;
 	const struct can_bittiming_const bittiming_const;
+	const struct can_bittiming_const data_bittiming_const;
 	unsigned int ctrl_count;
 
 	int (*intf_probe)(struct usb_interface *intf);
@@ -57,6 +61,8 @@ struct peak_usb_adapter {
 	int (*dev_close)(struct peak_usb_device *dev);
 	int (*dev_set_bittiming)(struct peak_usb_device *dev,
 					struct can_bittiming *bt);
+	int (*dev_set_data_bittiming)(struct peak_usb_device *dev,
+				      struct can_bittiming *bt);
 	int (*dev_set_bus)(struct peak_usb_device *dev, u8 onoff);
 	int (*dev_get_device_id)(struct peak_usb_device *dev, u32 *device_id);
 	int (*dev_decode_buf)(struct peak_usb_device *dev, struct urb *urb);
@@ -80,6 +86,8 @@ struct peak_usb_adapter {
 
 extern struct peak_usb_adapter pcan_usb;
 extern struct peak_usb_adapter pcan_usb_pro;
+extern struct peak_usb_adapter pcan_usb_pro_fd;
+extern struct peak_usb_adapter pcan_usb_fd;
 
 struct peak_time_ref {
 	struct timeval tv_host_0, tv_host;
@@ -92,7 +100,7 @@ struct peak_time_ref {
 struct peak_tx_urb_context {
 	struct peak_usb_device *dev;
 	u32 echo_index;
-	u8 dlc;
+	u8 data_len;
 	struct urb *urb;
 };
 
@@ -139,7 +147,9 @@ void peak_usb_update_ts_now(struct peak_time_ref *time_ref, u32 ts_now);
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

