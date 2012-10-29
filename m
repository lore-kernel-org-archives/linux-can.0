From: matthias.fuchs@esd.eu
Subject: [PATCH v2 2/2] can: usb: esd_usb2: Add support for CAN-USB/Micro
Date: Mon, 29 Oct 2012 10:54:48 +0100
Message-ID: <1351504488-7060-3-git-send-email-matthias.fuchs@esd.eu>
References: <1351504488-7060-1-git-send-email-matthias.fuchs@esd.eu>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:65327 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755307Ab2J2J4P (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Oct 2012 05:56:15 -0400
In-Reply-To: <1351504488-7060-1-git-send-email-matthias.fuchs@esd.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Matthias Fuchs <matthias.fuchs@esd.eu>

From: Matthias Fuchs <matthias.fuchs@esd.eu>

This patch extends the esd_usb2 driver to support the
tiny CAN-USB/Micro CAN/USB interface.

Signed-off-by: Matthias Fuchs <matthias.fuchs@esd.eu>
---
 drivers/net/can/usb/esd_usb2.c |   31 +++++++++++++++++++++++++------
 1 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
index f4317c0..124e0dd 100644
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
@@ -889,14 +893,22 @@ static int esd_usb2_set_bittiming(struct net_device *netdev)
 	struct can_bittiming *bt = &priv->can.bittiming;
 	struct esd_usb2_msg msg;
 	u32 canbtr;
+	int sjw_shift;
 
 	canbtr = ESD_USB2_UBR;
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
 		canbtr |= ESD_USB2_LOM;
 
 	canbtr |= (bt->brp - 1) & (ESD_USB2_BRP_MAX - 1);
+
+	if (le16_to_cpu(priv->usb2->udev->descriptor.idProduct) ==
+	    USB_CANUSBM_PRODUCT_ID)
+		sjw_shift = ESD_USBM_SJW_SHIFT;
+	else
+		sjw_shift = ESD_USB2_SJW_SHIFT;
+
 	canbtr |= ((bt->sjw - 1) & (ESD_USB2_SJW_MAX - 1))
-		<< ESD_USB2_SJW_SHIFT;
+		<< sjw_shift;
 	canbtr |= ((bt->prop_seg + bt->phase_seg1 - 1)
 		   & (ESD_USB2_TSEG1_MAX - 1))
 		<< ESD_USB2_TSEG1_SHIFT;
@@ -975,12 +987,19 @@ static int esd_usb2_probe_one_net(struct usb_interface *intf, int index)
 
 	priv->can.state = CAN_STATE_STOPPED;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY;
-	priv->can.clock.freq = ESD_USB2_CAN_CLOCK;
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

