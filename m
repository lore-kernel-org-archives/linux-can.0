From: Martin Kelly <mkelly@xevo.com>
Subject: [PATCH 3/4] can: kvaser_usb: cancel urb on -EPIPE and -EPROTO
Date: Tue,  5 Dec 2017 11:15:49 -0800
Message-ID: <20171205191550.703-4-mkelly@xevo.com>
References: <20171205191550.703-1-mkelly@xevo.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2nam02on0054.outbound.protection.outlook.com ([104.47.38.54]:27091
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751815AbdLETQL (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 5 Dec 2017 14:16:11 -0500
In-Reply-To: <20171205191550.703-1-mkelly@xevo.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>, Jimmy Assarsson <jimmyassarsson@gmail.com>, Martin Kelly <mkelly@xevo.com>

In mcba_usb, we have observed that when you unplug the device, the driver will
endlessly resubmit failing URBs, which can cause CPU stalls. This issue
is fixed in mcba_usb by catching the codes seen on device disconnect
(-EPIPE and -EPROTO).

This driver also resubmits in the case of -EPIPE and -EPROTO, so fix it
in the same way.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
---
 drivers/net/can/usb/kvaser_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index f95945915d20..63587b8e6825 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -1326,6 +1326,8 @@ static void kvaser_usb_read_bulk_callback(struct urb *urb)
 	case 0:
 		break;
 	case -ENOENT:
+	case -EPIPE:
+	case -EPROTO:
 	case -ESHUTDOWN:
 		return;
 	default:
-- 
2.11.0

