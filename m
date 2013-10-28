From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2] can: kvaser_usb: fix usb endpoints detection
Date: Mon, 28 Oct 2013 10:14:18 +0100
Message-ID: <1382951658-19214-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42687 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718Ab3J1JOV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Oct 2013 05:14:21 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Olivier Sobrie <olivier@sobrie.be>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Olivier Sobrie <olivier@sobrie.be>

Some devices, like the Kvaser Memorator Professional, have several
bulk in endpoints. Only the first one found should be used by the
driver. The same holds for the bulk out endpoint.

Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

changes since v1:
- use explizid return in loop if both in and out endpoints are found.

regards,
Marc

 drivers/net/can/usb/kvaser_usb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 3b95465..b88a8e9 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -1557,11 +1557,15 @@ static void kvaser_usb_get_endpoints(const struct usb_interface *intf,
 	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
 		endpoint = &iface_desc->endpoint[i].desc;
 
-		if (usb_endpoint_is_bulk_in(endpoint))
+		if (!*in && usb_endpoint_is_bulk_in(endpoint))
 			*in = endpoint;
 
-		if (usb_endpoint_is_bulk_out(endpoint))
+		if (!*out && usb_endpoint_is_bulk_out(endpoint))
 			*out = endpoint;
+
+		/* only use first bulk endpoint for in and out */
+		if (*in && *out)
+			return;
 	}
 }
 
-- 
1.8.4.rc3

