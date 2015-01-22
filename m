From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 3/7 v8] can/peak_usb: upgrade core to data bittiming specs
Date: Thu, 22 Jan 2015 16:24:22 +0100
Message-ID: <1421940266-6088-4-git-send-email-s.grosjean@peak-system.com>
References: <1421940266-6088-1-git-send-email-s.grosjean@peak-system.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:27298 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbbAVP0V (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Jan 2015 10:26:21 -0500
In-Reply-To: <1421940266-6088-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>

Upgrade PEAK-System USB adapters core to the new data structures (names) and
callbacks added for the support of the CANFD extension. This specific patch
does the mandatory changes to support new data bittiming specs.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 36 ++++++++++++++++++++++++----
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  3 +++
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index f3ed7c6..6061d8f 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -679,19 +679,43 @@ static int peak_usb_set_mode(struct net_device *netdev, enum can_mode mode)
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
 
@@ -750,6 +774,8 @@ static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
 	dev->can.clock = peak_usb_adapter->clock;
 	dev->can.bittiming_const = &peak_usb_adapter->bittiming_const;
 	dev->can.do_set_bittiming = peak_usb_set_bittiming;
+	dev->can.data_bittiming_const = &peak_usb_adapter->data_bittiming_const;
+	dev->can.do_set_data_bittiming = peak_usb_set_data_bittiming;
 	dev->can.do_set_mode = peak_usb_set_mode;
 	dev->can.do_get_berr_counter = peak_usb_adapter->do_get_berr_counter;
 	dev->can.ctrlmode_supported = peak_usb_adapter->ctrlmode_supported;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 12737d9..fdc5c0d 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -47,6 +47,7 @@ struct peak_usb_adapter {
 	u32 ctrlmode_supported;
 	struct can_clock clock;
 	const struct can_bittiming_const bittiming_const;
+	const struct can_bittiming_const data_bittiming_const;
 	unsigned int ctrl_count;
 
 	int (*intf_probe)(struct usb_interface *intf);
@@ -58,6 +59,8 @@ struct peak_usb_adapter {
 	int (*dev_close)(struct peak_usb_device *dev);
 	int (*dev_set_bittiming)(struct peak_usb_device *dev,
 					struct can_bittiming *bt);
+	int (*dev_set_data_bittiming)(struct peak_usb_device *dev,
+				      struct can_bittiming *bt);
 	int (*dev_set_bus)(struct peak_usb_device *dev, u8 onoff);
 	int (*dev_get_device_id)(struct peak_usb_device *dev, u32 *device_id);
 	int (*dev_decode_buf)(struct peak_usb_device *dev, struct urb *urb);
-- 
1.9.1

