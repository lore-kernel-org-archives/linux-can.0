From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] can: rcar_can: Remove unused platform data support
Date: Wed, 14 Aug 2019 11:22:21 +0200
Message-ID: <20190814092221.12959-1-geert+renesas@glider.be>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "David S . Miller" <davem@davemloft.net>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-can.vger.kernel.org

All R-Car platforms use DT for describing CAN controllers.
R-Car CAN platform data support was never used in any upstream kernel.

Move the Clock Select Register settings enum into the driver, and remove
platform data support and the corresponding header file.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/can/rcar/rcar_can.c       | 22 +++++++++-------------
 include/linux/can/platform/rcar_can.h | 18 ------------------
 2 files changed, 9 insertions(+), 31 deletions(-)
 delete mode 100644 include/linux/can/platform/rcar_can.h

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index cf218949a8fb52d5..3c5e9c2c5342147f 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -15,11 +15,17 @@
 #include <linux/can/led.h>
 #include <linux/can/dev.h>
 #include <linux/clk.h>
-#include <linux/can/platform/rcar_can.h>
 #include <linux/of.h>
 
 #define RCAR_CAN_DRV_NAME	"rcar_can"
 
+/* Clock Select Register settings */
+enum CLKR {
+	CLKR_CLKP1 = 0,	/* Peripheral clock (clkp1) */
+	CLKR_CLKP2 = 1,	/* Peripheral clock (clkp2) */
+	CLKR_CLKEXT = 3	/* Externally input clock */
+};
+
 #define RCAR_SUPPORTED_CLOCKS	(BIT(CLKR_CLKP1) | BIT(CLKR_CLKP2) | \
 				 BIT(CLKR_CLKEXT))
 
@@ -736,7 +742,6 @@ static const char * const clock_names[] = {
 
 static int rcar_can_probe(struct platform_device *pdev)
 {
-	struct rcar_can_platform_data *pdata;
 	struct rcar_can_priv *priv;
 	struct net_device *ndev;
 	struct resource *mem;
@@ -745,17 +750,8 @@ static int rcar_can_probe(struct platform_device *pdev)
 	int err = -ENODEV;
 	int irq;
 
-	if (pdev->dev.of_node) {
-		of_property_read_u32(pdev->dev.of_node,
-				     "renesas,can-clock-select", &clock_select);
-	} else {
-		pdata = dev_get_platdata(&pdev->dev);
-		if (!pdata) {
-			dev_err(&pdev->dev, "No platform data provided!\n");
-			goto fail;
-		}
-		clock_select = pdata->clock_select;
-	}
+	of_property_read_u32(pdev->dev.of_node, "renesas,can-clock-select",
+			     &clock_select);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
diff --git a/include/linux/can/platform/rcar_can.h b/include/linux/can/platform/rcar_can.h
deleted file mode 100644
index a43dcd0cf79ee3ec..0000000000000000
--- a/include/linux/can/platform/rcar_can.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _CAN_PLATFORM_RCAR_CAN_H_
-#define _CAN_PLATFORM_RCAR_CAN_H_
-
-#include <linux/types.h>
-
-/* Clock Select Register settings */
-enum CLKR {
-	CLKR_CLKP1 = 0,	/* Peripheral clock (clkp1) */
-	CLKR_CLKP2 = 1,	/* Peripheral clock (clkp2) */
-	CLKR_CLKEXT = 3	/* Externally input clock */
-};
-
-struct rcar_can_platform_data {
-	enum CLKR clock_select;	/* Clock source select */
-};
-
-#endif	/* !_CAN_PLATFORM_RCAR_CAN_H_ */
-- 
2.17.1
