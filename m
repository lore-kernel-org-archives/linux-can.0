From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH can-next] can: ucan: remove duplicated include from ucan.c
Date: Wed, 29 Aug 2018 01:25:45 +0000
Message-ID: <1535505945-143347-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Martin Elshuber <martin.elshuber@theobroma-systems.com>, Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Cc: YueHaibing <yuehaibing@huawei.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/can/usb/ucan.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 0678a38..c6f4b41 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -35,10 +35,6 @@
 #include <linux/slab.h>
 #include <linux/usb.h>
 
-#include <linux/can.h>
-#include <linux/can/dev.h>
-#include <linux/can/error.h>
-
 #define UCAN_DRIVER_NAME "ucan"
 #define UCAN_MAX_RX_URBS 8
 /* the CAN controller needs a while to enable/disable the bus */
