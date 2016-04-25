From: Maximilian Schneider <max@schneidersoft.net>
Subject: [PATCH] can: gs_usb: Modify the usb device table to use only the
 first usb interface
Date: Mon, 25 Apr 2016 08:54:19 +0000
Message-ID: <1461574459.1383.10.camel@schneidersoft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from h2448646.stratoserver.net ([85.214.222.201]:36415 "EHLO
	h2448646.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985AbcDYIqz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 25 Apr 2016 04:46:55 -0400
Received: from blackbox (unknown [179.80.141.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: max@schneidersoft.net)
	by h2448646.stratoserver.net (Postfix) with ESMTPSA id 1292CD94054C
	for <linux-can@vger.kernel.org>; Mon, 25 Apr 2016 08:46:51 +0000 (UTC)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

From 24680c50e6b07292e7ee6ebfec0a826a32d5bcb9 Mon Sep 17 00:00:00 2001
From: Maximilian Schneider <max@schneidersoft.net>
Date: Sun, 24 Apr 2016 01:10:01 +0000
Subject: [PATCH] Modified the USB device table to use only the first USB
 interface, as is the case with GS USB devices. This allows other GS USB
 compatible devices to be more flexible with their remaining interfaces.

Signed-off-by: Maximilian Schneider <max@schneidersoft.net>
---
 drivers/net/can/usb/gs_usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index cbc99d5..4731cb2 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -950,7 +950,8 @@ static void gs_usb_disconnect(struct usb_interface *intf)
 }
 
 static const struct usb_device_id gs_usb_table[] = {
-	{USB_DEVICE(USB_GSUSB_1_VENDOR_ID, USB_GSUSB_1_PRODUCT_ID)},
+	{USB_DEVICE_INTERFACE_NUMBER(USB_GSUSB_1_VENDOR_ID,
+		USB_GSUSB_1_PRODUCT_ID, 0)},
 	{} /* Terminating entry */
 };
 
-- 
2.1.4



