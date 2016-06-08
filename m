From: Maximilian Schneider <max@schneidersoft.net>
Subject: [PATCH] can: gs_usb: Add Basic support for the bytewerk.org
 candleLight interface
Date: Wed, 08 Jun 2016 18:00:26 +0000
Message-ID: <1465408826.1149.15.camel@schneidersoft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from h2448646.stratoserver.net ([85.214.222.201]:54945 "EHLO
	h2448646.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbcFHR5c (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 8 Jun 2016 13:57:32 -0400
Received: from blackbox (unknown [179.80.178.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: max@schneidersoft.net)
	by h2448646.stratoserver.net (Postfix) with ESMTPSA id 4231ED940527
	for <linux-can@vger.kernel.org>; Wed,  8 Jun 2016 17:52:22 +0000 (UTC)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

=46rom aad71889fffa819155ec85d5f5538bc4cca252e6 Mon Sep 17 00:00:00 200=
1
=46rom: Maximilian Schneider <max@schneidersoft.net>
Date: Wed, 8 Jun 2016 17:29:48 +0000
Subject: [PATCH] Add basic support for the bytewerk.org candleLight int=
erface,
a open hardware (CERN OHL) USB CAN adapter.

Signed-off-by: Hubert Denkmair <hubert@denkmair.de>
Signed-off-by: Maximilian Schneider <max@schneidersoft.net>
---
 drivers/net/can/usb/gs_usb.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.=
c
index 1556d42..acb0c84 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1,7 +1,9 @@
-/* CAN driver for Geschwister Schneider USB/CAN devices.
+/* CAN driver for Geschwister Schneider USB/CAN devices
+ * and bytewerk.org candleLight USB CAN interfaces.
  *
- * Copyright (C) 2013 Geschwister Schneider Technologie-,
+ * Copyright (C) 2013-2016 Geschwister Schneider Technologie-,
  * Entwicklungs- und Vertriebs UG (Haftungsbeschr=C3=A4nkt).
+ * Copyright (C) 2016 Hubert Denkmair
  *
  * Many thanks to all socketcan devs!
  *
@@ -29,6 +31,9 @@
 #define USB_GSUSB_1_VENDOR_ID      0x1d50
 #define USB_GSUSB_1_PRODUCT_ID     0x606f
=20
+#define USB_CANDLELIGHT_VENDOR_ID  0x1209
+#define USB_CANDLELIGHT_PRODUCT_ID 0x2323
+
 #define GSUSB_ENDPOINT_IN          1
 #define GSUSB_ENDPOINT_OUT         2
=20
@@ -952,6 +957,8 @@ static void gs_usb_disconnect(struct usb_interface =
*intf)
 static const struct usb_device_id gs_usb_table[] =3D {
 	{ USB_DEVICE_INTERFACE_NUMBER(USB_GSUSB_1_VENDOR_ID,
 				      USB_GSUSB_1_PRODUCT_ID, 0) },
+	{ USB_DEVICE_INTERFACE_NUMBER(USB_CANDLELIGHT_VENDOR_ID,
+				      USB_CANDLELIGHT_PRODUCT_ID, 0) },
 	{} /* Terminating entry */
 };
=20
@@ -969,5 +976,6 @@ module_usb_driver(gs_usb_driver);
 MODULE_AUTHOR("Maximilian Schneider <mws@schneidersoft.net>");
 MODULE_DESCRIPTION(
 "Socket CAN device driver for Geschwister Schneider Technologie-, "
-"Entwicklungs- und Vertriebs UG. USB2.0 to CAN interfaces.");
+"Entwicklungs- und Vertriebs UG. USB2.0 to CAN interfaces\n"
+"and bytewerk.org candleLight USB CAN interfaces.");
 MODULE_LICENSE("GPL v2");
--=20
2.1.4


