From: Martin Kelly <mkelly@xevo.com>
Subject: [PATCH 1/4] can: ems_usb: cancel urb on -EPIPE and -EPROTO
Date: Tue,  5 Dec 2017 11:15:47 -0800
Message-ID: <20171205191550.703-2-mkelly@xevo.com>
References: <20171205191550.703-1-mkelly@xevo.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2nam02on0049.outbound.protection.outlook.com ([104.47.38.49]:29120
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751394AbdLETQI (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 5 Dec 2017 14:16:08 -0500
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
 drivers/net/can/usb/ems_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index b3d02759c226..b00358297424 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -288,6 +288,8 @@ static void ems_usb_read_interrupt_callback(struct urb *urb)
 
 	case -ECONNRESET: /* unlink */
 	case -ENOENT:
+	case -EPIPE:
+	case -EPROTO:
 	case -ESHUTDOWN:
 		return;
 
-- 
2.11.0

