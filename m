From: Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: [PATCH] can: kvaser_usb: Add support for more Kvaser Leaf v2 devices
Date: Thu, 23 Jun 2016 07:57:21 +0200
Message-ID: <20160623055721.11276-1-jimmyassarsson@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34786 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbcFWF62 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Jun 2016 01:58:28 -0400
Received: by mail-lf0-f67.google.com with SMTP id l184so16762427lfl.1
        for <linux-can@vger.kernel.org>; Wed, 22 Jun 2016 22:58:27 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: extja@kvaser.com, Jimmy Assarsson <jimmyassarsson@gmail.com>

This patch adds support for Kvaser Leaf Light HS v2 OEM,
Mini PCI Express 2xHS and USBcan Light 2xHS.

Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
---
 drivers/net/can/usb/Kconfig      |  2 ++
 drivers/net/can/usb/kvaser_usb.c | 72 ++++++++++++++++++++++------------------
 2 files changed, 41 insertions(+), 33 deletions(-)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index bcb272f..50c8c91 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -46,6 +46,8 @@ config CAN_KVASER_USB
 	    - Kvaser USBcan R
 	    - Kvaser Leaf Light v2
 	    - Kvaser Mini PCI Express HS
+	    - Kvaser Mini PCI Express 2xHS
+	    - Kvaser USBcan Light 2xHS
 	    - Kvaser USBcan II HS/HS
 	    - Kvaser USBcan II HS/LS
 	    - Kvaser USBcan Rugged ("USBcan Rev B")
diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 022bfa1..08e8b18 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -25,45 +25,48 @@
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
 
-#define MAX_RX_URBS			4
-#define START_TIMEOUT			1000 /* msecs */
-#define STOP_TIMEOUT			1000 /* msecs */
-#define USB_SEND_TIMEOUT		1000 /* msecs */
-#define USB_RECV_TIMEOUT		1000 /* msecs */
-#define RX_BUFFER_SIZE			3072
-#define CAN_USB_CLOCK			8000000
-#define MAX_NET_DEVICES			3
-#define MAX_USBCAN_NET_DEVICES		2
+#define MAX_RX_URBS				4
+#define START_TIMEOUT				1000 /* msecs */
+#define STOP_TIMEOUT				1000 /* msecs */
+#define USB_SEND_TIMEOUT			1000 /* msecs */
+#define USB_RECV_TIMEOUT			1000 /* msecs */
+#define RX_BUFFER_SIZE				3072
+#define CAN_USB_CLOCK				8000000
+#define MAX_NET_DEVICES				3
+#define MAX_USBCAN_NET_DEVICES			2
 
 /* Kvaser Leaf USB devices */
-#define KVASER_VENDOR_ID		0x0bfd
-#define USB_LEAF_DEVEL_PRODUCT_ID	10
-#define USB_LEAF_LITE_PRODUCT_ID	11
-#define USB_LEAF_PRO_PRODUCT_ID		12
-#define USB_LEAF_SPRO_PRODUCT_ID	14
-#define USB_LEAF_PRO_LS_PRODUCT_ID	15
-#define USB_LEAF_PRO_SWC_PRODUCT_ID	16
-#define USB_LEAF_PRO_LIN_PRODUCT_ID	17
-#define USB_LEAF_SPRO_LS_PRODUCT_ID	18
-#define USB_LEAF_SPRO_SWC_PRODUCT_ID	19
-#define USB_MEMO2_DEVEL_PRODUCT_ID	22
-#define USB_MEMO2_HSHS_PRODUCT_ID	23
-#define USB_UPRO_HSHS_PRODUCT_ID	24
-#define USB_LEAF_LITE_GI_PRODUCT_ID	25
-#define USB_LEAF_PRO_OBDII_PRODUCT_ID	26
-#define USB_MEMO2_HSLS_PRODUCT_ID	27
-#define USB_LEAF_LITE_CH_PRODUCT_ID	28
-#define USB_BLACKBIRD_SPRO_PRODUCT_ID	29
-#define USB_OEM_MERCURY_PRODUCT_ID	34
-#define USB_OEM_LEAF_PRODUCT_ID		35
-#define USB_CAN_R_PRODUCT_ID		39
-#define USB_LEAF_LITE_V2_PRODUCT_ID	288
-#define USB_MINI_PCIE_HS_PRODUCT_ID	289
+#define KVASER_VENDOR_ID			0x0bfd
+#define USB_LEAF_DEVEL_PRODUCT_ID		10
+#define USB_LEAF_LITE_PRODUCT_ID		11
+#define USB_LEAF_PRO_PRODUCT_ID			12
+#define USB_LEAF_SPRO_PRODUCT_ID		14
+#define USB_LEAF_PRO_LS_PRODUCT_ID		15
+#define USB_LEAF_PRO_SWC_PRODUCT_ID		16
+#define USB_LEAF_PRO_LIN_PRODUCT_ID		17
+#define USB_LEAF_SPRO_LS_PRODUCT_ID		18
+#define USB_LEAF_SPRO_SWC_PRODUCT_ID		19
+#define USB_MEMO2_DEVEL_PRODUCT_ID		22
+#define USB_MEMO2_HSHS_PRODUCT_ID		23
+#define USB_UPRO_HSHS_PRODUCT_ID		24
+#define USB_LEAF_LITE_GI_PRODUCT_ID		25
+#define USB_LEAF_PRO_OBDII_PRODUCT_ID		26
+#define USB_MEMO2_HSLS_PRODUCT_ID		27
+#define USB_LEAF_LITE_CH_PRODUCT_ID		28
+#define USB_BLACKBIRD_SPRO_PRODUCT_ID		29
+#define USB_OEM_MERCURY_PRODUCT_ID		34
+#define USB_OEM_LEAF_PRODUCT_ID			35
+#define USB_CAN_R_PRODUCT_ID			39
+#define USB_LEAF_LITE_V2_PRODUCT_ID		288
+#define USB_MINI_PCIE_HS_PRODUCT_ID		289
+#define USB_LEAF_LIGHT_HS_V2_OEM_PRODUCT_ID	290
+#define USB_USBCAN_LIGHT_2HS_PRODUCT_ID		291
+#define USB_MINI_PCIE_2HS_PRODUCT_ID		292
 
 static inline bool kvaser_is_leaf(const struct usb_device_id *id)
 {
 	return id->idProduct >= USB_LEAF_DEVEL_PRODUCT_ID &&
-	       id->idProduct <= USB_MINI_PCIE_HS_PRODUCT_ID;
+	       id->idProduct <= USB_MINI_PCIE_2HS_PRODUCT_ID;
 }
 
 /* Kvaser USBCan-II devices */
@@ -537,6 +540,9 @@ static const struct usb_device_id kvaser_usb_table[] = {
 		.driver_info = KVASER_HAS_TXRX_ERRORS },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_V2_PRODUCT_ID) },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MINI_PCIE_HS_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LIGHT_HS_V2_OEM_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN_LIGHT_2HS_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MINI_PCIE_2HS_PRODUCT_ID) },
 
 	/* USBCANII family IDs */
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_USBCAN2_PRODUCT_ID),
-- 
2.9.0

