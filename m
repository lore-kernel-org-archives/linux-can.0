From: zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH] can: usb: Remove some duplicated includes from ucan.c
Date: Wed, 24 Oct 2018 13:58:58 +0800
Message-ID: <1540360738-65328-1-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net
Cc: wg@grandegger.com, mkl@pengutronix.de, martin.elshuber@theobroma-systems.com, philipp.tomsich@theobroma-systems.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Just remove same duplicated includes.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
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
-- 
1.7.12.4
