From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 1/2] can/peak_usb: preparing existing files for CAN-FD
Date: Wed, 26 Nov 2014 11:21:30 +0100
Message-ID: <1416997291-23092-2-git-send-email-s.grosjean@peak-system.com>
References: <1416997291-23092-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:23774 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbaKZK3e (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Nov 2014 05:29:34 -0500
In-Reply-To: <1416997291-23092-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>

This patch does some modifications to the existing files that support the
PEAK-System Technik CAN 2.0b USB adapters, for preparing the support of CAN-FD.

In particular, this patch adds some new device ids, as well as some new
mandatory callbacks and fields needed by linux-can for CAN-FD support.
This patch also changes some static identifiers to global one, to share
common functionalities with the further incoming CAN-FD specific source files.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c      |  1 +
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 84 ++++++++++++++++++++++------
 drivers/net/can/usb/peak_usb/pcan_usb_core.h | 14 ++++-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 22 +++-----
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |  8 +++
 5 files changed, 94 insertions(+), 35 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 925ab8e..10a4ceb 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -858,6 +858,7 @@ struct peak_usb_adapter pcan_usb = {
 	.name = "PCAN-USB",
 	.device_id = PCAN_USB_PRODUCT_ID,
 	.ctrl_count = 1,
+	.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
 	.clock = {
 		.freq = PCAN_USB_CRYSTAL_HZ / 2 ,
 	},
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
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 263dd92..10887b0 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -27,14 +27,6 @@
 
 MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB Pro adapter");
 
-/* PCAN-USB Pro Endpoints */
-#define PCAN_USBPRO_EP_CMDOUT		1
-#define PCAN_USBPRO_EP_CMDIN		(PCAN_USBPRO_EP_CMDOUT | USB_DIR_IN)
-#define PCAN_USBPRO_EP_MSGOUT_0		2
-#define PCAN_USBPRO_EP_MSGIN		(PCAN_USBPRO_EP_MSGOUT_0 | USB_DIR_IN)
-#define PCAN_USBPRO_EP_MSGOUT_1		3
-#define PCAN_USBPRO_EP_UNUSED		(PCAN_USBPRO_EP_MSGOUT_1 | USB_DIR_IN)
-
 #define PCAN_USBPRO_CHANNEL_COUNT	2
 
 /* PCAN-USB Pro adapter internal clock (MHz) */
@@ -322,8 +314,8 @@ static int pcan_usb_pro_wait_rsp(struct peak_usb_device *dev,
 	return (i >= PCAN_USBPRO_RSP_SUBMIT_MAX) ? -ERANGE : err;
 }
 
-static int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
-				 int req_value, void *req_addr, int req_size)
+int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
+			  int req_value, void *req_addr, int req_size)
 {
 	int err;
 	u8 req_type;
@@ -333,8 +325,6 @@ static int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
 	if (!(dev->state & PCAN_USB_STATE_CONNECTED))
 		return 0;
 
-	memset(req_addr, '\0', req_size);
-
 	req_type = USB_TYPE_VENDOR | USB_RECIP_OTHER;
 
 	switch (req_id) {
@@ -345,6 +335,7 @@ static int pcan_usb_pro_send_req(struct peak_usb_device *dev, int req_id,
 	default:
 		p = usb_rcvctrlpipe(dev->udev, 0);
 		req_type |= USB_DIR_IN;
+		memset(req_addr, '\0', req_size);
 		break;
 	}
 
@@ -476,7 +467,7 @@ static int pcan_usb_pro_set_bittiming(struct peak_usb_device *dev,
 	return pcan_usb_pro_set_bitrate(dev, ccbt);
 }
 
-static void pcan_usb_pro_restart_complete(struct urb *urb)
+void pcan_usb_pro_restart_complete(struct urb *urb)
 {
 	/* can delete usb resources */
 	peak_usb_async_complete(urb);
@@ -932,7 +923,7 @@ static int pcan_usb_pro_init(struct peak_usb_device *dev)
 
 	return 0;
 
- err_out:
+err_out:
 	kfree(bi);
 	kfree(fi);
 	kfree(usb_if);
@@ -978,7 +969,7 @@ static void pcan_usb_pro_free(struct peak_usb_device *dev)
 /*
  * probe function for new PCAN-USB Pro usb interface
  */
-static int pcan_usb_pro_probe(struct usb_interface *intf)
+int pcan_usb_pro_probe(struct usb_interface *intf)
 {
 	struct usb_host_interface *if_desc;
 	int i;
@@ -1016,6 +1007,7 @@ struct peak_usb_adapter pcan_usb_pro = {
 	.name = "PCAN-USB Pro",
 	.device_id = PCAN_USBPRO_PRODUCT_ID,
 	.ctrl_count = PCAN_USBPRO_CHANNEL_COUNT,
+	.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY,
 	.clock = {
 		.freq = PCAN_USBPRO_CRYSTAL_HZ,
 	},
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
index 32275af..1101c9c 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.h
@@ -27,6 +27,14 @@
 #define PCAN_USBPRO_INFO_BL		0
 #define PCAN_USBPRO_INFO_FW		1
 
+/* PCAN-USB Pro (FD) Endpoints */
+#define PCAN_USBPRO_EP_CMDOUT		1
+#define PCAN_USBPRO_EP_CMDIN		(PCAN_USBPRO_EP_CMDOUT | USB_DIR_IN)
+#define PCAN_USBPRO_EP_MSGOUT_0		2
+#define PCAN_USBPRO_EP_MSGIN		(PCAN_USBPRO_EP_MSGOUT_0 | USB_DIR_IN)
+#define PCAN_USBPRO_EP_MSGOUT_1		3
+#define PCAN_USBPRO_EP_UNUSED		(PCAN_USBPRO_EP_MSGOUT_1 | USB_DIR_IN)
+
 /* Vendor Request value for XXX_FCT */
 #define PCAN_USBPRO_FCT_DRVLD		5 /* tell device driver is loaded */
 #define PCAN_USBPRO_FCT_DRVLD_REQ_LEN	16
-- 
1.9.1

