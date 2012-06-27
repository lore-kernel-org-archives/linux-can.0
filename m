From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH 4/4] can: flexcan: add transceiver switch support when use device tree
Date: Wed, 27 Jun 2012 16:19:21 +0800
Message-ID: <1340785161-3598-5-git-send-email-jason77.wang@gmail.com>
References: <1340785161-3598-1-git-send-email-jason77.wang@gmail.com>
 <1340785161-3598-2-git-send-email-jason77.wang@gmail.com>
 <1340785161-3598-3-git-send-email-jason77.wang@gmail.com>
 <1340785161-3598-4-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:36769 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504Ab2F0ITs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 04:19:48 -0400
In-Reply-To: <1340785161-3598-4-git-send-email-jason77.wang@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de, davem@davemloft.net, shawn.guo@linaro.org
Cc: linux-can@vger.kernel.org

Some platforms (like i.MX6) has an external PHY, the PHY is operated
by some gpios. If the system registers a platform_data, we can
set a callback function pointer to pdata->transceiver_switch to
implement PHY switch. If we use device tree, we couldn't pass
platform_data to the driver, so i move the switch function to the
driver and add device tree entries to let user set which gpios
are used to operate PHY.

This design doesn't break existing platforms, if a platform doesn't
need PHY switch, it doesn't need to set dt entries just as before,
if a platform has platform_data, the pdata->transceiver_switch has
higher priority.

Cc: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---
 .../devicetree/bindings/net/can/fsl-flexcan.txt    |    4 ++
 drivers/net/can/flexcan.c                          |   46 ++++++++++++++++++++
 2 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
index 19952cd..a32bfdb 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -14,6 +14,8 @@ Required properties:
 - clock-frequency : The oscillator frequency driving the flexcan device
 - hw-version : The controller version, for imx25, imx35 and imx53, the version
                is 3, for imx6, the version is 10
+- phy-en-gpio : Specify the gpio to be used as phy enable
+- phy-stby-gpio : Specify the gpio to be used as phy standby
 
 Example:
 
@@ -24,4 +26,6 @@ Example:
 		interrupt-parent = <&mpic>;
 		clock-frequency = <200000000>; // filled in by bootloader
 		hw-version = <10>;
+		phy-en-gpio = <&gpio1 4 0>; /* GPIO1_4 */
+		phy-stby-gpio = <&gpio1 2 0>; /* GPIO1_2 */
 	};
diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index a23c11e..0318584 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -36,6 +36,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/of_gpio.h>
 
 #define DRV_NAME			"flexcan"
 
@@ -184,6 +185,8 @@ struct flexcan_priv {
 	u32 reg_esr;
 	u32 reg_ctrl_default;
 	u32 hw_ver;
+	int phy_en_gpio;
+	int phy_stby_gpio;
 
 	struct clk *clk_ipg;
 	struct clk *clk_per;
@@ -234,6 +237,15 @@ static void flexcan_transceiver_switch(const struct flexcan_priv *priv, int on)
 {
 	if (priv->pdata && priv->pdata->transceiver_switch)
 		priv->pdata->transceiver_switch(on);
+	else if (priv->phy_en_gpio >= 0 && priv->phy_stby_gpio >= 0) {
+		if (on) {
+			gpio_set_value(priv->phy_en_gpio, 1);
+			gpio_set_value(priv->phy_stby_gpio, 1);
+		} else {
+			gpio_set_value(priv->phy_en_gpio, 0);
+			gpio_set_value(priv->phy_stby_gpio, 0);
+		}
+	}
 }
 
 static inline int flexcan_has_and_handle_berr(const struct flexcan_priv *priv,
@@ -951,6 +963,8 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 	int err, irq;
 	u32 clock_freq = 0;
 	u32 hw_ver = 3;
+	int en_gpio = -EINVAL;
+	int stby_gpio = -EINVAL;
 
 	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
 	if (IS_ERR(pinctrl))
@@ -969,6 +983,26 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 						"hw-version", NULL);
 		if (hw_ver_p)
 			hw_ver = be32_to_cpup(hw_ver_p);
+
+		en_gpio = of_get_named_gpio(pdev->dev.of_node, "phy-en-gpio", 0);
+		if (en_gpio >= 0) {
+			int ret;
+			ret = gpio_request(en_gpio, pdev->name);
+			if (ret)
+				en_gpio = -EINVAL;
+			else
+				gpio_direction_output(en_gpio, 0);
+		}
+
+		stby_gpio = of_get_named_gpio(pdev->dev.of_node, "phy-stby-gpio", 0);
+		if (stby_gpio >= 0) {
+			int ret;
+			ret = gpio_request(stby_gpio, pdev->name);
+			if (ret)
+				stby_gpio = -EINVAL;
+			else
+				gpio_direction_output(stby_gpio, 0);
+		}
 	}
 
 	if (!clock_freq) {
@@ -1026,6 +1060,9 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 	priv->clk_ipg = clk_ipg;
 	priv->clk_per = clk_per;
 	priv->hw_ver = hw_ver;
+	priv->phy_en_gpio = en_gpio;
+	priv->phy_stby_gpio = stby_gpio;
+
 	priv->pdata = pdev->dev.platform_data;
 
 	netif_napi_add(dev, &priv->napi, flexcan_poll, FLEXCAN_NAPI_WEIGHT);
@@ -1056,6 +1093,10 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 	if (clk_ipg)
 		clk_put(clk_ipg);
  failed_clock:
+	if (en_gpio >= 0)
+		gpio_free(en_gpio);
+	if (stby_gpio >= 0)
+		gpio_free(stby_gpio);
 	return err;
 }
 
@@ -1077,6 +1118,11 @@ static int __devexit flexcan_remove(struct platform_device *pdev)
 	if (priv->clk_ipg)
 		clk_put(priv->clk_ipg);
 
+	if (priv->phy_en_gpio >= 0)
+		gpio_free(priv->phy_en_gpio);
+	if (priv->phy_stby_gpio >= 0)
+		gpio_free(priv->phy_stby_gpio);
+
 	free_candev(dev);
 
 	return 0;
-- 
1.7.6

