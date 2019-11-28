From: Johan Hovold <johan@kernel.org>
Subject: [PATCH] can: ucan: fix non-atomic allocation in completion handler
Date: Thu, 28 Nov 2019 19:26:03 +0100
Message-ID: <20191128182603.22004-1-johan@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>, Martin Elshuber <martin.elshuber@theobroma-systems.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
List-Id: linux-can.vger.kernel.org

USB completion handlers are called in atomic context and must
specifically not allocate memory using GFP_KERNEL.

Fixes: 9f2d3eae88d2 ("can: ucan: add driver for Theobroma Systems UCAN devices")
Cc: stable <stable@vger.kernel.org>     # 4.19
Cc: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>
Cc: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/can/usb/ucan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 04aac3bb54ef..81e942f713e6 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -792,7 +792,7 @@ static void ucan_read_bulk_callback(struct urb *urb)
 			  up);
 
 	usb_anchor_urb(urb, &up->rx_urbs);
-	ret = usb_submit_urb(urb, GFP_KERNEL);
+	ret = usb_submit_urb(urb, GFP_ATOMIC);
 
 	if (ret < 0) {
 		netdev_err(up->netdev,
-- 
2.24.0
