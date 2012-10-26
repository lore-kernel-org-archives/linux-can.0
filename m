From: Matthias Fuchs <matthias.fuchs@esd.eu>
Subject: [PATCH] can: usb: esd_usb2: Add support for CAN-USB/Micro and listen-only
 mode
Date: Fri, 26 Oct 2012 13:18:08 +0200
Message-ID: <508A7170.2060104@esd.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:58256 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336Ab2JZLUE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 26 Oct 2012 07:20:04 -0400
Received: from [10.0.18.3] (pc-matthias.esd [10.0.18.3])
	by comm-neu.esd (Postfix) with ESMTP id 99A541362D6
	for <linux-can@vger.kernel.org>; Fri, 26 Oct 2012 13:18:03 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This patch extends the esd_usb2 driver to support the
tiny CAN-USB/Micro CAN/USB interface.

Listen-only mode for both supported devices is added also.

Signed-off-by: Matthias Fuchs <matthias.fuchs@esd.eu>
---
 drivers/net/can/usb/Kconfig    |    4 ++--
 drivers/net/can/usb/esd_usb2.c |   39 +++++++++++++++++++++++++++++++--------
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index 0a68768..ef96520 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -8,9 +8,9 @@ config CAN_EMS_USB
 	  from EMS Dr. Thomas Wuensche (http://www.ems-wuensche.de).
 
 config CAN_ESD_USB2
-        tristate "ESD USB/2 CAN/USB interface"
+        tristate "ESD USB/2 and USB/Micro CAN/USB interfaces"
         ---help---
-          This driver supports the CAN-USB/2 interface
+          This driver supports the CAN-USB/2 and CAN-USB/Micro interfaces
           from esd electronic system design gmbh (http://www.esd.eu).
 
 config CAN_PEAK_USB
diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
index bd36e55..a9fe8a2 100644
--- a/drivers/net/can/usb/esd_usb2.c
+++ b/drivers/net/can/usb/esd_usb2.c
@@ -1,7 +1,7 @@
 /*
- * CAN driver for esd CAN-USB/2
+ * CAN driver for esd CAN-USB/2 and CAN-USB/Micro
  *
- * Copyright (C) 2010 Matthias Fuchs <matthias.fuchs@esd.eu>, esd gmbh
+ * Copyright (C) 2010-2012 Matthias Fuchs <matthias.fuchs@esd.eu>, esd gmbh
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published
@@ -28,14 +28,16 @@
 #include <linux/can/error.h>
 
 MODULE_AUTHOR("Matthias Fuchs <matthias.fuchs@esd.eu>");
-MODULE_DESCRIPTION("CAN driver for esd CAN-USB/2 interfaces");
+MODULE_DESCRIPTION("CAN driver for esd CAN-USB/2 and CAN-USB/Micro interfaces");
 MODULE_LICENSE("GPL v2");
 
 /* Define these values to match your devices */
 #define USB_ESDGMBH_VENDOR_ID	0x0ab4
 #define USB_CANUSB2_PRODUCT_ID	0x0010
+#define USB_CANUSBM_PRODUCT_ID	0x0011
 
 #define ESD_USB2_CAN_CLOCK	60000000
+#define ESD_USBM_CAN_CLOCK	36000000
 #define ESD_USB2_MAX_NETS	2
 
 /* USB2 commands */
@@ -69,6 +71,7 @@ MODULE_LICENSE("GPL v2");
 #define ESD_USB2_TSEG2_SHIFT	20
 #define ESD_USB2_SJW_MAX	4
 #define ESD_USB2_SJW_SHIFT	14
+#define ESD_USBM_SJW_SHIFT	24
 #define ESD_USB2_BRP_MIN	1
 #define ESD_USB2_BRP_MAX	1024
 #define ESD_USB2_BRP_INC	1
@@ -183,6 +186,7 @@ struct __attribute__ ((packed)) esd_usb2_msg {
 
 static struct usb_device_id esd_usb2_table[] = {
 	{USB_DEVICE(USB_ESDGMBH_VENDOR_ID, USB_CANUSB2_PRODUCT_ID)},
+	{USB_DEVICE(USB_ESDGMBH_VENDOR_ID, USB_CANUSBM_PRODUCT_ID)},
 	{}
 };
 MODULE_DEVICE_TABLE(usb, esd_usb2_table);
@@ -889,18 +893,29 @@ static int esd_usb2_set_bittiming(struct net_device *netdev)
 	struct can_bittiming *bt = &priv->can.bittiming;
 	struct esd_usb2_msg msg;
 	u32 canbtr;
+	int sjw_shift;
 
 	canbtr = ESD_USB2_UBR;
 	canbtr |= (bt->brp - 1) & (ESD_USB2_BRP_MAX - 1);
+
+	if (le16_to_cpu(priv->usb2->udev->descriptor.idProduct) ==
+	    USB_CANUSBM_PRODUCT_ID)
+		sjw_shift = ESD_USBM_SJW_SHIFT;
+	else {
+		sjw_shift = ESD_USB2_SJW_SHIFT;
+		if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+			canbtr |= ESD_USB2_3_SAMPLES;
+	}
+	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		canbtr |= ESD_USB2_LOM;
+
 	canbtr |= ((bt->sjw - 1) & (ESD_USB2_SJW_MAX - 1))
-		<< ESD_USB2_SJW_SHIFT;
+		<< sjw_shift;
 	canbtr |= ((bt->prop_seg + bt->phase_seg1 - 1)
 		   & (ESD_USB2_TSEG1_MAX - 1))
 		<< ESD_USB2_TSEG1_SHIFT;
 	canbtr |= ((bt->phase_seg2 - 1) & (ESD_USB2_TSEG2_MAX - 1))
 		<< ESD_USB2_TSEG2_SHIFT;
-	if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
-		canbtr |= ESD_USB2_3_SAMPLES;
 
 	msg.msg.hdr.len = 2;
 	msg.msg.hdr.cmd = CMD_SETBAUD;
@@ -971,12 +986,20 @@ static int esd_usb2_probe_one_net(struct usb_interface *intf, int index)
 	priv->index = index;
 
 	priv->can.state = CAN_STATE_STOPPED;
-	priv->can.clock.freq = ESD_USB2_CAN_CLOCK;
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY;
+
+	if (le16_to_cpu(dev->udev->descriptor.idProduct) ==
+	    USB_CANUSBM_PRODUCT_ID)
+		priv->can.clock.freq = ESD_USBM_CAN_CLOCK;
+	else {
+		priv->can.clock.freq = ESD_USB2_CAN_CLOCK;
+		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
+	}
+
 	priv->can.bittiming_const = &esd_usb2_bittiming_const;
 	priv->can.do_set_bittiming = esd_usb2_set_bittiming;
 	priv->can.do_set_mode = esd_usb2_set_mode;
 	priv->can.do_get_berr_counter = esd_usb2_get_berr_counter;
-	priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES;
 
 	netdev->flags |= IFF_ECHO; /* we support local echo */
 
-- 
1.7.4.1
