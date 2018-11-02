From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 3/6] phy: phy-of-simple: Add support for simple generic phy driver
Date: Sat, 3 Nov 2018 00:56:13 +0530
Message-ID: <20181102192616.28291-4-faiz_abbas@ti.com>
References: <20181102192616.28291-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181102192616.28291-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com, kishon@ti.com, faiz_abbas@ti.com
List-Id: linux-can.vger.kernel.org

A good number of phy implementations don't have a dedicated register
map and only do simple clock or regulator configurations. Add support
for a generic driver which just does such simple configurations.

The driver optionally gets all the generic phy attributes and also the
pwr regulator node. It also includes a generic implementation of
phy_power_on() and phy_power_off().

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/phy/Kconfig         |  7 +++
 drivers/phy/Makefile        |  1 +
 drivers/phy/phy-of-simple.c | 90 +++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 drivers/phy/phy-of-simple.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 60f949e2a684..e66039560da9 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -40,6 +40,13 @@ config PHY_XGENE
 	help
 	  This option enables support for APM X-Gene SoC multi-purpose PHY.
 
+config PHY_OF_SIMPLE
+	tristate "PHY Simple Driver"
+	select GENERIC_PHY
+	help
+	  This driver supports simple generic phy implementations which don't
+	  need a dedicated register map.
+
 source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 0301e25d07c1..ffef0fdf2c68 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
+obj-$(CONFIG_PHY_OF_SIMPLE)		+= phy-of-simple.o
 obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
 obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
 obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
diff --git a/drivers/phy/phy-of-simple.c b/drivers/phy/phy-of-simple.c
new file mode 100644
index 000000000000..0194aae90d3c
--- /dev/null
+++ b/drivers/phy/phy-of-simple.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * phy-of-simple.c - phy driver for simple implementations
+ *
+ * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com
+ *
+ */
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+
+static int phy_simple_power_on(struct phy *phy)
+{
+	if (phy->pwr)
+		return regulator_enable(phy->pwr);
+
+	return 0;
+}
+
+static int phy_simple_power_off(struct phy *phy)
+{
+	if (phy->pwr)
+		return regulator_disable(phy->pwr);
+
+	return 0;
+}
+
+static const struct phy_ops phy_simple_ops = {
+	.power_on	= phy_simple_power_on,
+	.power_off	= phy_simple_power_off,
+	.owner		= THIS_MODULE,
+};
+
+int phy_simple_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	struct regulator *pwr = NULL;
+	struct phy *phy;
+	u32 bus_width = 0;
+	u32 max_bitrate = 0;
+	int ret;
+
+	phy = devm_phy_create(dev, dev->of_node,
+				      &phy_simple_ops);
+
+	if (IS_ERR(phy)) {
+		dev_err(dev, "Failed to create phy\n");
+		return PTR_ERR(phy);
+	}
+
+	device_property_read_u32(dev, "bus-width", &bus_width);
+	phy->attrs.bus_width = bus_width;
+	device_property_read_u32(dev, "max-bitrate", &max_bitrate);
+	phy->attrs.max_bitrate = max_bitrate;
+
+	pwr = devm_regulator_get_optional(dev, "pwr");
+	if (IS_ERR(pwr)) {
+		ret = PTR_ERR(pwr);
+		dev_err(dev, "Couldn't get regulator. ret=%d\n", ret);
+		return ret;
+	}
+	phy->pwr = pwr;
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id phy_simple_dt_ids[] = {
+	{ .compatible = "simple-phy"},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, phy_simple_phy_dt_ids);
+
+static struct platform_driver phy_simple_driver = {
+	.probe		= phy_simple_probe,
+	.driver		= {
+		.name	= "phy-of-simple",
+		.of_match_table = phy_simple_dt_ids,
+	},
+};
+
+module_platform_driver(phy_simple_driver);
+
+MODULE_AUTHOR("Faiz Abbas <faiz_abbas@ti.com>");
+MODULE_DESCRIPTION("Simple PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0
