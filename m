From: Colin King <colin.king@canonical.com>
Subject: [PATCH] can: ucan: remove redundant pointer 'udev'
Date: Thu, 30 Aug 2018 11:27:27 +0100
Message-ID: <20180830102727.30818-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'udev' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
variable 'udev' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
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
