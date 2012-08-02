From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v4 2/3] can: c_can: Add device tree support to Bosch C_CAN/D_CAN controller
Date: Thu, 2 Aug 2012 18:43:10 +0530
Message-ID: <1343913191-14722-3-git-send-email-anilkumar@ti.com>
References: <1343913191-14722-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44788 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753406Ab2HBNNh (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 2 Aug 2012 09:13:37 -0400
In-Reply-To: <1343913191-14722-1-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, anantgole@ti.com, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

Add device tree support to C_CAN/D_CAN controller and usage details
are added to device tree documentation. Driver was tested on AM335x
EVM.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 .../devicetree/bindings/net/can/c_can.txt          |   37 +++++++++++++
 drivers/net/can/c_can/c_can_platform.c             |   55 ++++++++++++++------
 2 files changed, 75 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/c_can.txt

diff --git a/Documentation/devicetree/bindings/net/can/c_can.txt b/Documentation/devicetree/bindings/net/can/c_can.txt
new file mode 100644
index 0000000..a43f083
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/c_can.txt
@@ -0,0 +1,37 @@
+Bosch C_CAN/D_CAN controller Device Tree Bindings
+-------------------------------------------------
+
+Required properties:
+- compatible		: Should be "bosch,c_can" for C_CAN controllers and
+			  "bosch,d_can" for D_CAN controllers.
+- reg			: physical base address and size of the C_CAN/D_CAN
+			  registers map
+- interrupts		: property with a value describing the interrupt
+			  number
+
+Optional properties:
+- interrupt-parent	: The parent interrupt controller
+- ti,hwmods		: Must be "d_can<n>" or "c_can<n>", n being the
+			  instance number
+
+Note: "ti,hwmods" field is used to fetch the base address and irq
+resources from TI, omap hwmod data base during device registration.
+Future plan is to migrate hwmod data base contents into device tree
+blob so that, all the required data will be used from device tree dts
+file.
+
+Examples:
+
+	d_can@481D0000 {
+		compatible = "bosch,d_can";
+		reg = <0x481D0000 0x1000>;
+		interrupts = <55 0x4>;
+		interrupt-parent = <&intc>;
+	};
+
+(or)
+
+	d_can@481D0000 {
+		compatible = "bosch,d_can";
+		ti,hwmods = "d_can1";
+	};
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 5c46d1c..d0a66cf 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -30,6 +30,8 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <linux/can/dev.h>
 
@@ -65,17 +67,52 @@ static void c_can_plat_write_reg_aligned_to_32bit(struct c_can_priv *priv,
 	writew(val, priv->base + 2 * priv->regs[index]);
 }
 
+static struct platform_device_id c_can_id_table[] = {
+	[BOSCH_C_CAN_PLATFORM] = {
+		.name = KBUILD_MODNAME,
+		.driver_data = BOSCH_C_CAN,
+	},
+	[BOSCH_C_CAN] = {
+		.name = "c_can",
+		.driver_data = BOSCH_C_CAN,
+	},
+	[BOSCH_D_CAN] = {
+		.name = "d_can",
+		.driver_data = BOSCH_D_CAN,
+	}, {
+	}
+};
+
+static const struct of_device_id c_can_of_table[] = {
+	{ .compatible = "bosch,c_can", .data = &c_can_id_table[BOSCH_C_CAN] },
+	{ .compatible = "bosch,d_can", .data = &c_can_id_table[BOSCH_D_CAN] },
+	{ /* sentinel */ },
+};
+
 static int __devinit c_can_plat_probe(struct platform_device *pdev)
 {
 	int ret;
 	void __iomem *addr;
 	struct net_device *dev;
 	struct c_can_priv *priv;
+	const struct of_device_id *match;
 	const struct platform_device_id *id;
 	struct resource *mem;
 	int irq;
 	struct clk *clk;
 
+	if (pdev->dev.of_node) {
+		match = of_match_device(c_can_of_table, &pdev->dev);
+		if (!match) {
+			dev_err(&pdev->dev, "Failed to find matching dt id\n");
+			ret = -EINVAL;
+			goto exit;
+		}
+		id = match->data;
+	} else {
+		id = platform_get_device_id(pdev);
+	}
+
 	/* get the appropriate clk */
 	clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
@@ -114,7 +151,6 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 	}
 
 	priv = netdev_priv(dev);
-	id = platform_get_device_id(pdev);
 	switch (id->driver_data) {
 	case BOSCH_C_CAN:
 		priv->regs = reg_map_c_can;
@@ -195,26 +231,11 @@ static int __devexit c_can_plat_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct platform_device_id c_can_id_table[] = {
-	[BOSCH_C_CAN_PLATFORM] = {
-		.name = KBUILD_MODNAME,
-		.driver_data = BOSCH_C_CAN,
-	},
-	[BOSCH_C_CAN] = {
-		.name = "c_can",
-		.driver_data = BOSCH_C_CAN,
-	},
-	[BOSCH_D_CAN] = {
-		.name = "d_can",
-		.driver_data = BOSCH_D_CAN,
-	}, {
-	}
-};
-
 static struct platform_driver c_can_plat_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(c_can_of_table),
 	},
 	.probe = c_can_plat_probe,
 	.remove = __devexit_p(c_can_plat_remove),
-- 
1.7.9.5

