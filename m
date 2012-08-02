From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v3 1/3] can: c_can: Add device tree support to Bosch C_CAN/D_CAN controller
Date: Thu, 2 Aug 2012 16:32:17 +0530
Message-ID: <1343905339-4642-2-git-send-email-anilkumar@ti.com>
References: <1343905339-4642-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42113 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375Ab2HBLCo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 Aug 2012 07:02:44 -0400
In-Reply-To: <1343905339-4642-1-git-send-email-anilkumar@ti.com>
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
 drivers/net/can/c_can/c_can.h                      |    5 +-
 drivers/net/can/c_can/c_can_platform.c             |   57 ++++++++++++++------
 3 files changed, 80 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/c_can.txt

diff --git a/Documentation/devicetree/bindings/net/can/c_can.txt b/Documentation/devicetree/bindings/net/can/c_can.txt
new file mode 100644
index 0000000..dc4aec5
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
+- interrupt-parent	: The parent interrupt controller
+
+Optional properties:
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
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 01a7049..4e56baa 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -143,8 +143,9 @@ static const u16 reg_map_d_can[] = {
 };
 
 enum c_can_dev_id {
-	C_CAN_DEVTYPE,
-	D_CAN_DEVTYPE,
+	BOSCH_C_CAN_PLATFORM,
+	BOSCH_C_CAN,
+	BOSCH_D_CAN,
 };
 
 /* c_can private data structure */
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 6ff7ad0..d0a66cf 100644
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
@@ -114,9 +151,8 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 	}
 
 	priv = netdev_priv(dev);
-	id = platform_get_device_id(pdev);
 	switch (id->driver_data) {
-	case C_CAN_DEVTYPE:
+	case BOSCH_C_CAN:
 		priv->regs = reg_map_c_can;
 		switch (mem->flags & IORESOURCE_MEM_TYPE_MASK) {
 		case IORESOURCE_MEM_32BIT:
@@ -130,7 +166,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
 			break;
 		}
 		break;
-	case D_CAN_DEVTYPE:
+	case BOSCH_D_CAN:
 		priv->regs = reg_map_d_can;
 		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
 		priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
@@ -195,24 +231,11 @@ static int __devexit c_can_plat_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct platform_device_id c_can_id_table[] = {
-	{
-		.name = KBUILD_MODNAME,
-		.driver_data = C_CAN_DEVTYPE,
-	}, {
-		.name = "c_can",
-		.driver_data = C_CAN_DEVTYPE,
-	}, {
-		.name = "d_can",
-		.driver_data = D_CAN_DEVTYPE,
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

