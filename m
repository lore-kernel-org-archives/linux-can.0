From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/3] flexcan: Use a regulator to control the CAN transceiver
Date: Mon, 10 Jun 2013 23:12:57 -0300
Message-ID: <1370916778-4406-2-git-send-email-festevam@gmail.com>
References: <1370916778-4406-1-git-send-email-festevam@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yh0-f53.google.com ([209.85.213.53]:58529 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540Ab3FKCNN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 22:13:13 -0400
Received: by mail-yh0-f53.google.com with SMTP id a41so1780621yho.40
        for <linux-can@vger.kernel.org>; Mon, 10 Jun 2013 19:13:12 -0700 (PDT)
In-Reply-To: <1370916778-4406-1-git-send-email-festevam@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: shawn.guo@linaro.org, linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Instead of using a GPIO to turn on/off the CAN transceiver, it is better to
use a regulator as some systems may use a PMIC to power the CAN transceiver.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Marc/Shawn,

Only boot tested. I haven't tested CAN operation.

 .../devicetree/bindings/net/can/fsl-flexcan.txt    |  2 +
 arch/arm/boot/dts/imx28-evk.dts                    | 12 ++++++
 arch/arm/mach-mxs/mach-mxs.c                       | 50 +---------------------
 drivers/net/can/flexcan.c                          | 25 +++++------
 4 files changed, 28 insertions(+), 61 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
index 8ff324e..56d6cc3 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -16,6 +16,8 @@ Optional properties:
 
 - clock-frequency : The oscillator frequency driving the flexcan device
 
+- xceiver-supply: Regulator that powers the CAN transceiver
+
 Example:
 
 	can@1c000 {
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index f0bd987..1637661 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -155,12 +155,14 @@
 			can0: can@80032000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&can0_pins_a>;
+				xceiver-supply = <&reg_can_3v3>;
 				status = "okay";
 			};
 
 			can1: can@80034000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&can1_pins_a>;
+				xceiver-supply = <&reg_can_3v3>;
 				status = "okay";
 			};
 		};
@@ -320,6 +322,16 @@
 			gpio = <&gpio3 30 0>;
 			enable-active-high;
 		};
+
+		reg_can_3v3: can-3v3 {
+			compatible = "regulator-fixed";
+			regulator-name = "can-3v3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio2 13 0>;
+			enable-active-high;
+		};
+
 	};
 
 	sound {
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index f01abe5..994356d 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -14,7 +14,6 @@
 #include <linux/clk/mxs.h>
 #include <linux/clkdev.h>
 #include <linux/clocksource.h>
-#include <linux/can/platform/flexcan.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
@@ -76,41 +75,6 @@ static inline void __mxs_togl(u32 mask, void __iomem *reg)
 	__raw_writel(mask, reg + MXS_TOG_ADDR);
 }
 
-/*
- * MX28EVK_FLEXCAN_SWITCH is shared between both flexcan controllers
- */
-#define MX28EVK_FLEXCAN_SWITCH	MXS_GPIO_NR(2, 13)
-
-static int flexcan0_en, flexcan1_en;
-
-static void mx28evk_flexcan_switch(void)
-{
-	if (flexcan0_en || flexcan1_en)
-		gpio_set_value(MX28EVK_FLEXCAN_SWITCH, 1);
-	else
-		gpio_set_value(MX28EVK_FLEXCAN_SWITCH, 0);
-}
-
-static void mx28evk_flexcan0_switch(int enable)
-{
-	flexcan0_en = enable;
-	mx28evk_flexcan_switch();
-}
-
-static void mx28evk_flexcan1_switch(int enable)
-{
-	flexcan1_en = enable;
-	mx28evk_flexcan_switch();
-}
-
-static struct flexcan_platform_data flexcan_pdata[2];
-
-static struct of_dev_auxdata mxs_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("fsl,imx28-flexcan", 0x80032000, NULL, &flexcan_pdata[0]),
-	OF_DEV_AUXDATA("fsl,imx28-flexcan", 0x80034000, NULL, &flexcan_pdata[1]),
-	{ /* sentinel */ }
-};
-
 #define OCOTP_WORD_OFFSET		0x20
 #define OCOTP_WORD_COUNT		0x20
 
@@ -270,15 +234,6 @@ static void __init imx28_evk_init(void)
 	mxs_saif_clkmux_select(MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0);
 }
 
-static void __init imx28_evk_post_init(void)
-{
-	if (!gpio_request_one(MX28EVK_FLEXCAN_SWITCH, GPIOF_DIR_OUT,
-			      "flexcan-switch")) {
-		flexcan_pdata[0].transceiver_switch = mx28evk_flexcan0_switch;
-		flexcan_pdata[1].transceiver_switch = mx28evk_flexcan1_switch;
-	}
-}
-
 static int apx4devkit_phy_fixup(struct phy_device *phy)
 {
 	phy->dev_flags |= MICREL_PHY_50MHZ_CLK;
@@ -488,13 +443,10 @@ static void __init mxs_machine_init(void)
 		cfa10049_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table,
-			     mxs_auxdata_lookup, parent);
+			     NULL, parent);
 
 	if (of_machine_is_compatible("karo,tx28"))
 		tx28_post_init();
-
-	if (of_machine_is_compatible("fsl,imx28-evk"))
-		imx28_evk_post_init();
 }
 
 #define MX23_CLKCTRL_RESET_OFFSET	0x120
diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index f873b9f..7b0be09 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -24,7 +24,6 @@
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
 #include <linux/can/led.h>
-#include <linux/can/platform/flexcan.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/if_arp.h>
@@ -37,6 +36,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 
 #define DRV_NAME			"flexcan"
 
@@ -211,6 +211,7 @@ struct flexcan_priv {
 	struct clk *clk_per;
 	struct flexcan_platform_data *pdata;
 	const struct flexcan_devtype_data *devtype_data;
+	struct regulator *reg_xceiver;
 };
 
 static struct flexcan_devtype_data fsl_p1010_devtype_data = {
@@ -258,15 +259,6 @@ static inline void flexcan_write(u32 val, void __iomem *addr)
 }
 #endif
 
-/*
- * Swtich transceiver on or off
- */
-static void flexcan_transceiver_switch(const struct flexcan_priv *priv, int on)
-{
-	if (priv->pdata && priv->pdata->transceiver_switch)
-		priv->pdata->transceiver_switch(on);
-}
-
 static inline int flexcan_has_and_handle_berr(const struct flexcan_priv *priv,
 					      u32 reg_esr)
 {
@@ -799,7 +791,11 @@ static int flexcan_chip_start(struct net_device *dev)
 	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
 		flexcan_write(0x0, &regs->rxfgmask);
 
-	flexcan_transceiver_switch(priv, 1);
+	if (priv->reg_xceiver)	{
+		err = regulator_enable(priv->reg_xceiver);
+		if (err)
+			goto out;
+	}
 
 	/* synchronize with the can bus */
 	reg_mcr = flexcan_read(&regs->mcr);
@@ -842,7 +838,8 @@ static void flexcan_chip_stop(struct net_device *dev)
 	reg |= FLEXCAN_MCR_MDIS | FLEXCAN_MCR_HALT;
 	flexcan_write(reg, &regs->mcr);
 
-	flexcan_transceiver_switch(priv, 0);
+	if (priv->reg_xceiver)
+		regulator_disable(priv->reg_xceiver);
 	priv->can.state = CAN_STATE_STOPPED;
 
 	return;
@@ -1084,6 +1081,10 @@ static int flexcan_probe(struct platform_device *pdev)
 	priv->pdata = pdev->dev.platform_data;
 	priv->devtype_data = devtype_data;
 
+	priv->reg_xceiver = devm_regulator_get(&pdev->dev, "xceiver");
+	if (IS_ERR(priv->reg_xceiver))
+		priv->reg_xceiver = NULL;
+
 	netif_napi_add(dev, &priv->napi, flexcan_poll, FLEXCAN_NAPI_WEIGHT);
 
 	dev_set_drvdata(&pdev->dev, dev);
-- 
1.8.1.2

