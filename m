From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/6] can: ucan: fix non-atomic allocation in completion handler
Date: Tue,  3 Dec 2019 11:47:01 +0100
Message-ID: <20191203104703.14620-5-mkl@pengutronix.de>
References: <20191203104703.14620-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191203104703.14620-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>, Martin Elshuber <martin.elshuber@theobroma-systems.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Johan Hovold <johan@kernel.org>

USB completion handlers are called in atomic context and must
specifically not allocate memory using GFP_KERNEL.

Fixes: 9f2d3eae88d2 ("can: ucan: add driver for Theobroma Systems UCAN devices")
Cc: stable <stable@vger.kernel.org>     # 4.19
Cc: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>
Cc: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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
