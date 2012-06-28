From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Thu, 28 Jun 2012 11:21:41 +0800
Message-ID: <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:7448 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753987Ab2F1DVg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 23:21:36 -0400
In-Reply-To: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Hui Wang <jason77.wang@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

The flexcan driver has function pointer transceiver_switch defined in
flexcan_platform_data for platform codes to hook up their transceiver
switch implementation.  However this does not cope with device tree
probe.

It's been observed that platforms mostly use gpios to control the
switch of flexcan transceiver, like enable and standby.  The patch
adds transceiver switch gpios support into flexcan driver, so that
platforms booting from device tree can just define properties
phy-enable-gpios and phy-standby-gpios to have flexcan driver control
the gpios.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/net/can/fsl-flexcan.txt    |    2 +
 drivers/net/can/flexcan.c                          |   62 ++++++++++++++++++++
 2 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
index 8ff324e..e0dbac7 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -15,6 +15,8 @@ Required properties:
 Optional properties:
 
 - clock-frequency : The oscillator frequency driving the flexcan device
+- phy-enable-gpios : Specify the gpio used to enable phy
+- phy-standby-gpios : Specify the gpio used to put phy into STANDBY mode
 
 Example:
 
diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 38c0690..1ce3f9e 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -26,6 +26,7 @@
 #include <linux/can/platform/flexcan.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/if_arp.h>
 #include <linux/if_ether.h>
 #include <linux/interrupt.h>
@@ -34,6 +35,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/pinctrl/consumer.h>
 
@@ -180,6 +182,11 @@ struct flexcan_priv {
 
 	struct clk *clk;
 	struct flexcan_platform_data *pdata;
+
+	int phy_en_gpio;
+	int phy_stby_gpio;
+	bool phy_en_high;
+	bool phy_stby_high;
 };
 
 static struct can_bittiming_const flexcan_bittiming_const = {
@@ -224,6 +231,17 @@ static inline void flexcan_write(u32 val, void __iomem *addr)
  */
 static void flexcan_transceiver_switch(const struct flexcan_priv *priv, int on)
 {
+	/*
+	 * on == 1: enable phy and exit standby
+	 * on == 0: disable phy and enter standby
+	 */
+	if (gpio_is_valid(priv->phy_en_gpio))
+		gpio_set_value(priv->phy_en_gpio,
+			       priv->phy_en_high ? on : !on);
+	if (gpio_is_valid(priv->phy_stby_gpio))
+		gpio_set_value(priv->phy_stby_gpio,
+			       priv->phy_stby_high ? !on : on);
+
 	if (priv->pdata && priv->pdata->transceiver_switch)
 		priv->pdata->transceiver_switch(on);
 }
@@ -933,6 +951,10 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 	resource_size_t mem_size;
 	int err, irq;
 	u32 clock_freq = 0;
+	int phy_en_gpio = -EINVAL;
+	int phy_stby_gpio = -EINVAL;
+	bool phy_en_high = true;
+	bool phy_stby_high = true;
 
 	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
 	if (IS_ERR(pinctrl))
@@ -940,11 +962,46 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 
 	if (pdev->dev.of_node) {
 		const u32 *clock_freq_p;
+		enum of_gpio_flags flags;
 
 		clock_freq_p = of_get_property(pdev->dev.of_node,
 						"clock-frequency", NULL);
 		if (clock_freq_p)
 			clock_freq = *clock_freq_p;
+
+		phy_en_gpio = of_get_named_gpio_flags(pdev->dev.of_node,
+						      "phy-enable-gpios",
+						       0, &flags);
+		if (gpio_is_valid(phy_en_gpio)) {
+			if (flags == OF_GPIO_ACTIVE_LOW)
+				phy_en_high = false;
+			err = devm_gpio_request_one(&pdev->dev, phy_en_gpio,
+						    GPIOF_DIR_OUT,
+						    "phy-enable");
+			if (err) {
+				dev_err(&pdev->dev,
+					"failed to request gpio %d: %d\n",
+					phy_en_gpio, err);
+				goto failed_gpio;
+			}
+		}
+
+		phy_stby_gpio = of_get_named_gpio_flags(pdev->dev.of_node,
+							"phy-standby-gpios",
+							0, &flags);
+		if (gpio_is_valid(phy_stby_gpio)) {
+			if (flags == OF_GPIO_ACTIVE_LOW)
+				phy_stby_high = false;
+			err = devm_gpio_request_one(&pdev->dev, phy_stby_gpio,
+						    GPIOF_DIR_OUT,
+						    "phy-standby");
+			if (err) {
+				dev_err(&pdev->dev,
+					"failed to request gpio %d: %d\n",
+					phy_stby_gpio, err);
+				goto failed_gpio;
+			}
+		}
 	}
 
 	if (!clock_freq) {
@@ -997,6 +1054,10 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 	priv->base = base;
 	priv->dev = dev;
 	priv->clk = clk;
+	priv->phy_en_gpio = phy_en_gpio;
+	priv->phy_en_high = phy_en_high;
+	priv->phy_stby_gpio = phy_stby_gpio;
+	priv->phy_stby_high = phy_stby_high;
 	priv->pdata = pdev->dev.platform_data;
 
 	netif_napi_add(dev, &priv->napi, flexcan_poll, FLEXCAN_NAPI_WEIGHT);
@@ -1025,6 +1086,7 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 	if (clk)
 		clk_put(clk);
  failed_clock:
+ failed_gpio:
 	return err;
 }
 
-- 
1.7.5.4


