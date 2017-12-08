From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/6] can: mcba_usb: cancel urb on -EPROTO
Date: Fri,  8 Dec 2017 16:58:12 +0100
Message-ID: <20171208155817.9364-2-mkl@pengutronix.de>
References: <20171208155817.9364-1-mkl@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20171208155817.9364-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Martin Kelly <mkelly@xevo.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Martin Kelly <mkelly@xevo.com>

When we unplug the device, we can see both -EPIPE and -EPROTO depending
on exact timing and what system we run on. If we continue to resubmit
URBs, they will immediately fail, and they can cause stalls, especially
on slower CPUs.

Fix this by not resubmitting on -EPROTO, as we already do on -EPIPE.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
2.15.0
