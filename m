From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3] can: at91_can: add dt support
Date: Tue, 12 Mar 2013 13:39:16 +0100
Message-ID: <1363091956-30421-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51889 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017Ab3CLMjT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Mar 2013 08:39:19 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Add device tree support.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello Ludovic,

I've added some const qualifiers to the at91_devtype_data. Compiles without
warnings/erros. Can you please re-test.

git://gitorious.org/linux-can/linux-can-next.git testing

regards, Marc

 .../devicetree/bindings/net/can/atmel-can.txt      | 14 ++++
 drivers/net/can/at91_can.c                         | 76 ++++++++++++++++------
 2 files changed, 71 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/atmel-can.txt

diff --git a/Documentation/devicetree/bindings/net/can/atmel-can.txt b/Documentation/devicetree/bindings/net/can/atmel-can.txt
new file mode 100644
index 0000000..72cf0c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/atmel-can.txt
@@ -0,0 +1,14 @@
+* AT91 CAN *
+
+Required properties:
+  - compatible: Should be "atmel,at91sam9263-can" or "atmel,at91sam9x5-can"
+  - reg: Should contain CAN controller registers location and length
+  - interrupts: Should contain IRQ line for the CAN controller
+
+Example:
+
+	can0: can@f000c000 {
+		compatbile = "atmel,at91sam9x5-can";
+		reg = <0xf000c000 0x300>;
+		interrupts = <40 4 5>
+	};
diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 44f3637..db52f441 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -27,6 +27,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/rtnetlink.h>
 #include <linux/skbuff.h>
@@ -155,19 +156,20 @@ struct at91_priv {
 	canid_t mb0_id;
 };
 
-static const struct at91_devtype_data at91_devtype_data[] = {
-	[AT91_DEVTYPE_SAM9263] = {
-		.rx_first = 1,
-		.rx_split = 8,
-		.rx_last = 11,
-		.tx_shift = 2,
-	},
-	[AT91_DEVTYPE_SAM9X5] = {
-		.rx_first = 0,
-		.rx_split = 4,
-		.rx_last = 5,
-		.tx_shift = 1,
-	},
+static const struct at91_devtype_data at91_at91sam9263_data = {
+	.rx_first = 1,
+	.rx_split = 8,
+	.rx_last = 11,
+	.tx_shift = 2,
+	.type = AT91_DEVTYPE_SAM9263,
+};
+
+static const struct at91_devtype_data at91_at91sam9x5_data = {
+	.rx_first = 0,
+	.rx_split = 4,
+	.rx_last = 5,
+	.tx_shift = 1,
+	.type = AT91_DEVTYPE_SAM9X5,
 };
 
 static const struct can_bittiming_const at91_bittiming_const = {
@@ -1249,10 +1251,42 @@ static struct attribute_group at91_sysfs_attr_group = {
 	.attrs = at91_sysfs_attrs,
 };
 
+#if defined(CONFIG_OF)
+static const struct of_device_id at91_can_dt_ids[] = {
+	{
+		.compatible = "atmel,at91sam9x5-can",
+		.data = &at91_at91sam9x5_data,
+	}, {
+		.compatible = "atmel,at91sam9263-can",
+		.data = &at91_at91sam9263_data,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, at91_can_dt_ids);
+#else
+#define at91_can_dt_ids NULL
+#endif
+
+static const struct at91_devtype_data *at91_can_get_driver_data(struct platform_device *pdev)
+{
+	if (pdev->dev.of_node) {
+		const struct of_device_id *match;
+
+		match = of_match_node(at91_can_dt_ids, pdev->dev.of_node);
+		if (!match) {
+			dev_err(&pdev->dev, "no matching node found in dtb\n");
+			return NULL;
+		}
+		return (const struct at91_devtype_data *)match->data;
+	}
+	return (const struct at91_devtype_data *)
+		platform_get_device_id(pdev)->driver_data;
+}
+
 static int at91_can_probe(struct platform_device *pdev)
 {
 	const struct at91_devtype_data *devtype_data;
-	enum at91_devtype devtype;
 	struct net_device *dev;
 	struct at91_priv *priv;
 	struct resource *res;
@@ -1260,8 +1294,12 @@ static int at91_can_probe(struct platform_device *pdev)
 	void __iomem *addr;
 	int err, irq;
 
-	devtype = pdev->id_entry->driver_data;
-	devtype_data = &at91_devtype_data[devtype];
+	devtype_data = at91_can_get_driver_data(pdev);
+	if (!devtype_data) {
+		dev_err(&pdev->dev, "no driver data\n");
+		err = -ENODEV;
+		goto exit;
+	}
 
 	clk = clk_get(&pdev->dev, "can_clk");
 	if (IS_ERR(clk)) {
@@ -1310,7 +1348,6 @@ static int at91_can_probe(struct platform_device *pdev)
 	priv->dev = dev;
 	priv->reg_base = addr;
 	priv->devtype_data = *devtype_data;
-	priv->devtype_data.type = devtype;
 	priv->clk = clk;
 	priv->pdata = pdev->dev.platform_data;
 	priv->mb0_id = 0x7ff;
@@ -1373,10 +1410,10 @@ static int at91_can_remove(struct platform_device *pdev)
 static const struct platform_device_id at91_can_id_table[] = {
 	{
 		.name = "at91_can",
-		.driver_data = AT91_DEVTYPE_SAM9263,
+		.driver_data = (kernel_ulong_t)&at91_at91sam9x5_data,
 	}, {
 		.name = "at91sam9x5_can",
-		.driver_data = AT91_DEVTYPE_SAM9X5,
+		.driver_data = (kernel_ulong_t)&at91_at91sam9263_data,
 	}, {
 		/* sentinel */
 	}
@@ -1389,6 +1426,7 @@ static struct platform_driver at91_can_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.owner = THIS_MODULE,
+		.of_match_table = at91_can_dt_ids,
 	},
 	.id_table = at91_can_id_table,
 };
-- 
1.8.2.rc2

