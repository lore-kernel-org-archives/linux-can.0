From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 05/20] can: ucan: remove duplicated include from ucan.c
Date: Mon, 12 Nov 2018 12:57:13 +0100
Message-ID: <20181112115728.18331-6-mkl@pengutronix.de>
References: <20181112115728.18331-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181112115728.18331-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, YueHaibing <yuehaibing@huawei.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Martin Elshuber <martin.elshuber@theobroma-systems.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/ucan.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index c9fd83e8d947..f3d5bda012a1 100644
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
2.19.1
