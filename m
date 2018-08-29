From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH can-next] can: ucan: remove set but not used variable 'udev'
Date: Wed, 29 Aug 2018 01:46:54 +0000
Message-ID: <1535507214-145191-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Martin Elshuber <martin.elshuber@theobroma-systems.com>, Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Cc: YueHaibing <yuehaibing@huawei.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/can/usb/ucan.c: In function 'ucan_disconnect':
drivers/net/can/usb/ucan.c:1578:21: warning:
 variable 'udev' set but not used [-Wunused-but-set-variable]
  struct usb_device *udev;

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/can/usb/ucan.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 0678a38..c9fd83e 100644
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
