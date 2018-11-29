From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 10/68] can: ucan: remove set but not used variable 'udev'
Date: Thu, 29 Nov 2018 00:55:01 -0500
Message-ID: <20181129055559.159228-10-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: YueHaibing <yuehaibing@huawei.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Sasha Levin <sashal@kernel.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 207681fc5f3d5d398f106d1ae0080fc2373f707a ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/can/usb/ucan.c: In function 'ucan_disconnect':
drivers/net/can/usb/ucan.c:1578:21: warning:
 variable 'udev' set but not used [-Wunused-but-set-variable]
  struct usb_device *udev;

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Martin Elshuber <martin.elshuber@theobroma-systems.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/ucan.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 0678a38b1af4..c9fd83e8d947 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -1575,11 +1575,8 @@ static int ucan_probe(struct usb_interface *intf,
 /* disconnect the device */
 static void ucan_disconnect(struct usb_interface *intf)
 {
-	struct usb_device *udev;
 	struct ucan_priv *up = usb_get_intfdata(intf);
 
-	udev = interface_to_usbdev(intf);
-
 	usb_set_intfdata(intf, NULL);
 
 	if (up) {
-- 
2.17.1
