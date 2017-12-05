From: Martin Kelly <mkelly@xevo.com>
Subject: [PATCH] can: mcba_usb: cancel urb on -EPROTO
Date: Tue,  5 Dec 2017 10:34:03 -0800
Message-ID: <20171205183403.27955-1-mkelly@xevo.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-co1nam03on0068.outbound.protection.outlook.com ([104.47.40.68]:43442
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752310AbdLESeX (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 5 Dec 2017 13:34:23 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: =?UTF-8?q?Remigiusz=20Ko=C5=82=C5=82=C4=85taj?= <remigiusz.kollataj@mobica.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Martin Kelly <mkelly@xevo.com>

When we unplug the device, we can see both -EPIPE and -EPROTO depending
on exact timing and what system we run on. If we continue to resubmit
URBs, they will immediately fail, and they can cause stalls, especially
on slower CPUs.

Fix this by not resubmitting on -EPROTO, as we already do on -EPIPE.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
---
 drivers/net/can/usb/mcba_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index ef417dcddbf7..8d8c2086424d 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -593,6 +593,7 @@ static void mcba_usb_read_bulk_callback(struct urb *urb)
 
 	case -ENOENT:
 	case -EPIPE:
+	case -EPROTO:
 	case -ESHUTDOWN:
 		return;
 
-- 
2.11.0

