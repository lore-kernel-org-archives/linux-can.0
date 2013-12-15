From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH v2 2/2] can: mcp251x: Add device tree support
Date: Sun, 15 Dec 2013 18:16:01 +0400
Message-ID: <1387116961-15261-2-git-send-email-shc_work@mail.ru>
References: <1387116961-15261-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp12.mail.ru ([94.100.176.89]:41497 "EHLO smtp12.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754208Ab3LOOUH (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 15 Dec 2013 09:20:07 -0500
In-Reply-To: <1387116961-15261-1-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: devicetree@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Alexander Shiyan <shc_work@mail.ru>

This patch adds Device Tree support to the Microchip MCP251X driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 .../bindings/net/can/microchip,mcp251x.txt         | 25 +++++++
 drivers/net/can/mcp251x.c                          | 85 +++++++++++++++++-----
 2 files changed, 93 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt b/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
new file mode 100644
index 0000000..ee3723b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251x.txt
@@ -0,0 +1,25 @@
+* Microchip MCP251X stand-alone CAN controller device tree bindings
+
+Required properties:
+ - compatible: Should be one of the following:
+   - "microchip,mcp2510" for MCP2510.
+   - "microchip,mcp2515" for MCP2515.
+ - reg: SPI chip select.
+ - clocks: The clock feeding the CAN controller.
+ - interrupt-parent: The parent interrupt controller.
+ - interrupts: Should contain IRQ line for the CAN controller.
+
+Optional properties:
+ - vdd-supply: Regulator that powers the CAN controller.
+ - xceiver-supply: Regulator that powers the CAN transceiver.
+
+Example:
+	can0: can@1 {
+		compatible = "microchip,mcp2515";
+		reg = <1>;
+		clocks = <&clk24m>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <13 0x2>;
+		vdd-supply = <&reg5v0>;
+		xceiver-supply = <&reg5v0>;
+	};
diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index 7a35729..0091ae1 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -59,6 +59,7 @@
 #include <linux/can/dev.h>
 #include <linux/can/led.h>
 #include <linux/can/platform/mcp251x.h>
+#include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -69,6 +70,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
@@ -995,16 +998,69 @@ static const struct net_device_ops mcp251x_netdev_ops = {
 	.ndo_start_xmit = mcp251x_hard_start_xmit,
 };
 
+static int mcp251x_get_frequency(struct device *dev)
+{
+	struct clk *clk;
+	int freq;
+
+	if (!dev->of_node) {
+		struct mcp251x_platform_data *pdata = dev_get_platdata(dev);
+
+		if (!pdata)
+			return -ENODATA;
+
+		freq = pdata->oscillator_frequency;
+	} else {
+		clk = devm_clk_get(dev, NULL);
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+
+		freq = clk_get_rate(clk);
+	}
+
+	/* Sanity check */
+	if (freq < 1000000 || freq > 25000000)
+		return -EINVAL;
+
+	return freq;
+}
+
+static struct of_device_id __maybe_unused mcp251x_of_match[] = {
+	{
+		.compatible	= "microchip,mcp2510",
+		.data		= (void *)CAN_MCP251X_MCP2510,
+	},
+	{
+		.compatible	= "microchip,mcp2515",
+		.data		= (void *)CAN_MCP251X_MCP2515,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mcp251x_of_match);
+
+static const struct spi_device_id mcp251x_id_table[] = {
+	{
+		.name		= "mcp2510",
+		.driver_data	= (kernel_ulong_t)CAN_MCP251X_MCP2510,
+	},
+	{
+		.name		= "mcp2515",
+		.driver_data	= (kernel_ulong_t)CAN_MCP251X_MCP2515,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, mcp251x_id_table);
+
 static int mcp251x_can_probe(struct spi_device *spi)
 {
+	const struct of_device_id *of_id = of_match_device(mcp251x_of_match,
+							   &spi->dev);
+	int ret = -ENODEV, freq = mcp251x_get_frequency(&spi->dev);
 	struct net_device *net;
 	struct mcp251x_priv *priv;
-	struct mcp251x_platform_data *pdata = dev_get_platdata(&spi->dev);
-	int ret = -ENODEV;
 
-	if (!pdata)
-		/* Platform data is required for osc freq */
-		goto error_out;
+	if (freq < 0)
+		return freq;
 
 	/* Allocate can/net device */
 	net = alloc_candev(sizeof(struct mcp251x_priv), TX_ECHO_SKB_MAX);
@@ -1019,10 +1075,13 @@ static int mcp251x_can_probe(struct spi_device *spi)
 	priv = netdev_priv(net);
 	priv->can.bittiming_const = &mcp251x_bittiming_const;
 	priv->can.do_set_mode = mcp251x_do_set_mode;
-	priv->can.clock.freq = pdata->oscillator_frequency / 2;
+	priv->can.clock.freq = freq / 2;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES |
 		CAN_CTRLMODE_LOOPBACK | CAN_CTRLMODE_LISTENONLY;
-	priv->model = spi_get_device_id(spi)->driver_data;
+	if (of_id)
+		priv->model = (enum mcp251x_model)of_id->data;
+	else
+		priv->model = spi_get_device_id(spi)->driver_data;
 	priv->net = net;
 
 	priv->power = devm_regulator_get(&spi->dev, "vdd");
@@ -1118,7 +1177,7 @@ error_power:
 	free_candev(net);
 error_alloc:
 	dev_err(&spi->dev, "probe failed\n");
-error_out:
+
 	return ret;
 }
 
@@ -1198,21 +1257,13 @@ static int mcp251x_can_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(mcp251x_can_pm_ops, mcp251x_can_suspend,
 	mcp251x_can_resume);
 
-static const struct spi_device_id mcp251x_id_table[] = {
-	{ "mcp2510",	CAN_MCP251X_MCP2510 },
-	{ "mcp2515",	CAN_MCP251X_MCP2515 },
-	{ },
-};
-
-MODULE_DEVICE_TABLE(spi, mcp251x_id_table);
-
 static struct spi_driver mcp251x_can_driver = {
 	.driver = {
 		.name = DEVICE_NAME,
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(mcp251x_of_match),
 		.pm = &mcp251x_can_pm_ops,
 	},
-
 	.id_table = mcp251x_id_table,
 	.probe = mcp251x_can_probe,
 	.remove = mcp251x_can_remove,
-- 
1.8.3.2

