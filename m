From: Martin Kelly <mkelly@xevo.com>
Subject: [PATCH 2/2] can: mcba_usb: fix device disconnect bug
Date: Mon, 27 Nov 2017 12:42:00 -0800
Message-ID: <20171127204200.32599-2-mkelly@xevo.com>
References: <20171127204200.32599-1-mkelly@xevo.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-sn1nam01on0053.outbound.protection.outlook.com ([104.47.32.53]:61632
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932068AbdK0UmO (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 27 Nov 2017 15:42:14 -0500
In-Reply-To: <20171127204200.32599-1-mkelly@xevo.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: =?UTF-8?q?Remigiusz=20Ko=C5=82=C5=82=C4=85taj?= <remigiusz.kollataj@mobica.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Martin Kelly <mkelly@xevo.com>

Currently, when you disconnect the device, the driver infinitely
resubmits all URBs, so you see:

Rx URB aborted (-32)

in an infinite loop.

Fix this by catching -EPIPE (what we get in urb->status when the device
disconnects) and not resubmitting.

With this patch, I can plug and unplug many times and the driver
recovers correctly.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
---
 drivers/net/can/usb/mcba_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index c4355f0a20d5..ef417dcddbf7 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -592,6 +592,7 @@ static void mcba_usb_read_bulk_callback(struct urb *urb)
 		break;
 
 	case -ENOENT:
+	case -EPIPE:
 	case -ESHUTDOWN:
 		return;
 
-- 
2.11.0

