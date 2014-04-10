From: Olivier Sobrie <olivier@sobrie.be>
Subject: [PATCH 2/3] can: kvaser_usb: add support for Kvaser Leaf v2 and usb mini PCIe
Date: Thu, 10 Apr 2014 21:44:22 +0200
Message-ID: <1397159063-12790-2-git-send-email-olivier@sobrie.be>
References: <1397159063-12790-1-git-send-email-olivier@sobrie.be>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:58301 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935701AbaDJTqU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Apr 2014 15:46:20 -0400
Received: by mail-ee0-f47.google.com with SMTP id b15so3404255eek.34
        for <linux-can@vger.kernel.org>; Thu, 10 Apr 2014 12:46:19 -0700 (PDT)
In-Reply-To: <1397159063-12790-1-git-send-email-olivier@sobrie.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Olivier Sobrie <olivier@sobrie.be>

This patch adds support for the Kvaser Leaf v2 and Leaf usb mini
PCIe card.

Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
---
 drivers/net/can/usb/kvaser_usb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index cd5ec5b..d2826e8 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -54,6 +54,8 @@
 #define USB_OEM_MERCURY_PRODUCT_ID	34
 #define USB_OEM_LEAF_PRODUCT_ID		35
 #define USB_CAN_R_PRODUCT_ID		39
+#define USB_LEAF_LITE_V2_PRODUCT_ID	288
+#define USB_MINI_PCIE_HS_PRODUCT_ID	289
 
 /* USB devices features */
 #define KVASER_HAS_SILENT_MODE		BIT(0)
@@ -357,6 +359,8 @@ static const struct usb_device_id kvaser_usb_table[] = {
 		.driver_info = KVASER_HAS_TXRX_ERRORS },
 	{ USB_DEVICE(KVASER_VENDOR_ID, USB_CAN_R_PRODUCT_ID),
 		.driver_info = KVASER_HAS_TXRX_ERRORS },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_LEAF_LITE_V2_PRODUCT_ID) },
+	{ USB_DEVICE(KVASER_VENDOR_ID, USB_MINI_PCIE_HS_PRODUCT_ID) },
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, kvaser_usb_table);
-- 
1.9.0

