From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 9/9] can: mcba_usb: fix device disconnect bug
Date: Fri,  1 Dec 2017 15:17:39 +0100
Message-ID: <20171201141739.5816-10-mkl@pengutronix.de>
References: <20171201141739.5816-1-mkl@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20171201141739.5816-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Martin Kelly <mkelly@xevo.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Martin Kelly <mkelly@xevo.com>

Currently, when you disconnect the device, the driver infinitely
resubmits all URBs, so you see:

Rx URB aborted (-32)

in an infinite loop.

Fix this by catching -EPIPE (what we get in urb->status when the device
disconnects) and not resubmitting.

With this patch, I can plug and unplug many times and the driver
recovers correctly.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
2.15.0
