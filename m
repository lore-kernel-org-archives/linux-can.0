From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3] can: kvaser_usb: fix usb endpoints detection
Date: Mon, 28 Oct 2013 13:24:41 +0100
Message-ID: <1382963081-11012-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51513 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756403Ab3J1MYo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Oct 2013 08:24:44 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Olivier Sobrie <olivier@sobrie.be>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Olivier Sobrie <olivier@sobrie.be>

Some devices, like the Kvaser Memorator Professional, have several bulk in
endpoints. Only the first one found must be used by the driver. The same holds
for the bulk out endpoint. The official Kvaser driver (leaf) was used as
reference.

Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

changes since v2:
- let kvaser_usb_get_endpoints() return 0 on success, -ENODEV otherwise

changes since v1:
- use explizid return in loop if both in and out endpoints are found.

 drivers/net/can/usb/kvaser_usb.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 3b95465..4b2d5ed 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -1544,9 +1544,9 @@ static int kvaser_usb_init_one(struct usb_interface *intf,
 	return 0;
 }
 
-static void kvaser_usb_get_endpoints(const struct usb_interface *intf,
-				     struct usb_endpoint_descriptor **in,
-				     struct usb_endpoint_descriptor **out)
+static int kvaser_usb_get_endpoints(const struct usb_interface *intf,
+				    struct usb_endpoint_descriptor **in,
+				    struct usb_endpoint_descriptor **out)
 {
 	const struct usb_host_interface *iface_desc;
 	struct usb_endpoint_descriptor *endpoint;
@@ -1557,12 +1557,18 @@ static void kvaser_usb_get_endpoints(const struct usb_interface *intf,
 	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
 		endpoint = &iface_desc->endpoint[i].desc;
 
-		if (usb_endpoint_is_bulk_in(endpoint))
+		if (!*in && usb_endpoint_is_bulk_in(endpoint))
 			*in = endpoint;
 
-		if (usb_endpoint_is_bulk_out(endpoint))
+		if (!*out && usb_endpoint_is_bulk_out(endpoint))
 			*out = endpoint;
+
+		/* use first bulk endpoint for in and out */
+		if (*in && *out)
+			return 0;
 	}
+
+	return -ENODEV;
 }
 
 static int kvaser_usb_probe(struct usb_interface *intf,
@@ -1576,8 +1582,8 @@ static int kvaser_usb_probe(struct usb_interface *intf,
 	if (!dev)
 		return -ENOMEM;
 
-	kvaser_usb_get_endpoints(intf, &dev->bulk_in, &dev->bulk_out);
-	if (!dev->bulk_in || !dev->bulk_out) {
+	err = kvaser_usb_get_endpoints(intf, &dev->bulk_in, &dev->bulk_out);
+	if (err) {
 		dev_err(&intf->dev, "Cannot get usb endpoint(s)");
 		return err;
 	}
-- 
1.8.4.rc3

