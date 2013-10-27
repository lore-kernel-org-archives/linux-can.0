From: Olivier Sobrie <olivier@sobrie.be>
Subject: [PATCH] can: kvaser_usb: fix usb endpoints detection
Date: Sun, 27 Oct 2013 22:07:53 +0100
Message-ID: <1382908073-6865-1-git-send-email-olivier@sobrie.be>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41763 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab3J0VIO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 27 Oct 2013 17:08:14 -0400
Received: by mail-wi0-f172.google.com with SMTP id ez12so3044671wid.5
        for <linux-can@vger.kernel.org>; Sun, 27 Oct 2013 14:08:13 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Olivier Sobrie <olivier@sobrie.be>

Some devices, like the Kvaser Memorator Professional, have several
bulk in endpoints. Only the first one found should be used by the
driver. The same holds for the bulk out endpoint.

Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
---
 drivers/net/can/usb/kvaser_usb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index 3b95465..bdbf5bf 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -1554,13 +1554,14 @@ static void kvaser_usb_get_endpoints(const struct usb_interface *intf,
 
 	iface_desc = &intf->altsetting[0];
 
-	for (i = 0; i < iface_desc->desc.bNumEndpoints; ++i) {
+	for (i = 0; (i < iface_desc->desc.bNumEndpoints) && (!*in || !*out);
+	     ++i) {
 		endpoint = &iface_desc->endpoint[i].desc;
 
-		if (usb_endpoint_is_bulk_in(endpoint))
+		if (!*in && usb_endpoint_is_bulk_in(endpoint))
 			*in = endpoint;
 
-		if (usb_endpoint_is_bulk_out(endpoint))
+		if (!*out && usb_endpoint_is_bulk_out(endpoint))
 			*out = endpoint;
 	}
 }
-- 
1.8.3.2

