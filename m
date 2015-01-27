From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v10 1/9] can: peak_usb: use ARRAY_SIZE instead off NULL termination for peak_usb_adapters_list
Date: Tue, 27 Jan 2015 17:41:42 +0100
Message-ID: <1422376910-23754-2-git-send-email-mkl@pengutronix.de>
References: <1422376910-23754-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34158 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbbA0Qlz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Jan 2015 11:41:55 -0500
In-Reply-To: <1422376910-23754-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

This patch converts the list "static struct peak_usb_adapter
*peak_usb_adapters_list[]" to be used with ARRAY_SIZE not with a NULL
termination, as the size is known during compile time.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index c62f48a1161d..26c0cc3ce3b2 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -46,7 +46,6 @@ MODULE_DEVICE_TABLE(usb, peak_usb_table);
 static struct peak_usb_adapter *peak_usb_adapters_list[] = {
 	&pcan_usb,
 	&pcan_usb_pro,
-	NULL,
 };
 
 /*
@@ -857,17 +856,18 @@ static int peak_usb_probe(struct usb_interface *intf,
 {
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
 	const u16 usb_id_product = le16_to_cpu(usb_dev->descriptor.idProduct);
-	struct peak_usb_adapter *peak_usb_adapter, **pp;
+	struct peak_usb_adapter *peak_usb_adapter = NULL;
 	int i, err = -ENOMEM;
 
 	usb_dev = interface_to_usbdev(intf);
 
 	/* get corresponding PCAN-USB adapter */
-	for (pp = peak_usb_adapters_list; *pp; pp++)
-		if ((*pp)->device_id == usb_id_product)
+	for (i = 0; i < ARRAY_SIZE(peak_usb_adapters_list); i++)
+		if (peak_usb_adapters_list[i]->device_id == usb_id_product) {
+			peak_usb_adapter = peak_usb_adapters_list[i];
 			break;
+		}
 
-	peak_usb_adapter = *pp;
 	if (!peak_usb_adapter) {
 		/* should never come except device_id bad usage in this file */
 		pr_err("%s: didn't find device id. 0x%x in devices list\n",
-- 
2.1.4

