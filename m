From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] can: flexcan: add a regulator for transceiver
Date: Tue,  3 Jul 2012 20:46:11 +0800
Message-ID: <1341319571-27763-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yw0-f51.google.com ([209.85.213.51]:62678 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177Ab2GCMpp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 Jul 2012 08:45:45 -0400
Received: by yhnn12 with SMTP id n12so7193432yhn.10
        for <linux-can@vger.kernel.org>; Tue, 03 Jul 2012 05:45:44 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

Some system designs may have a controllable power supply for
transceiver.  Add a regulator for that, which can be turned on
or off in flexcan_transceiver_switch function.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/net/can/flexcan.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 81d4741..33ff7f0 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -36,6 +36,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/regulator/consumer.h>
 
 #define DRV_NAME			"flexcan"
 
@@ -179,6 +180,7 @@ struct flexcan_priv {
 	u32 reg_ctrl_default;
 
 	struct clk *clk;
+	struct regulator *reg_xcvr;
 	struct flexcan_platform_data *pdata;
 };
 
@@ -224,6 +226,13 @@ static inline void flexcan_write(u32 val, void __iomem *addr)
  */
 static void flexcan_transceiver_switch(const struct flexcan_priv *priv, int on)
 {
+	if (priv->reg_xcvr) {
+		if (on)
+			regulator_enable(priv->reg_xcvr);
+		else
+			regulator_disable(priv->reg_xcvr);
+	}
+
 	if (priv->pdata && priv->pdata->transceiver_switch)
 		priv->pdata->transceiver_switch(on);
 }
@@ -928,6 +937,7 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 	struct flexcan_priv *priv;
 	struct resource *mem;
 	struct clk *clk = NULL;
+	struct regulator *reg_xcvr;
 	struct pinctrl *pinctrl;
 	void __iomem *base;
 	resource_size_t mem_size;
@@ -957,6 +967,10 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 		clock_freq = clk_get_rate(clk);
 	}
 
+	reg_xcvr = devm_regulator_get(&pdev->dev, "xcvr");
+	if (IS_ERR(reg_xcvr))
+		reg_xcvr = NULL;
+
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
 	if (!mem || irq <= 0) {
@@ -997,6 +1011,7 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 	priv->base = base;
 	priv->dev = dev;
 	priv->clk = clk;
+	priv->reg_xcvr = reg_xcvr;
 	priv->pdata = pdev->dev.platform_data;
 
 	netif_napi_add(dev, &priv->napi, flexcan_poll, FLEXCAN_NAPI_WEIGHT);
-- 
1.7.5.4

