From: Dan Murphy <dmurphy@ti.com>
Subject: [[RFC] PATCH v2 1/4] can: m_can: Create a m_can platform framework
Date: Wed, 5 Dec 2018 13:28:22 -0600
Message-ID: <20181205192825.11555-2-dmurphy@ti.com>
References: <20181205192825.11555-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205192825.11555-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
List-Id: linux-can.vger.kernel.org

Create a m_can platform framework that peripherial
devices can register to and use common code and register sets.
The peripherial devices may provide read/write and configuration
support of the IP.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/can/m_can/m_can_platform.c | 168 +++++++++++++++++++++++++
 drivers/net/can/m_can/m_can_platform.h | 100 +++++++++++++++
 2 files changed, 268 insertions(+)
 create mode 100644 drivers/net/can/m_can/m_can_platform.c
 create mode 100644 drivers/net/can/m_can/m_can_platform.h

diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
new file mode 100644
index 000000000000..261846f9c4e8
--- /dev/null
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -0,0 +1,168 @@
+/*
+ * CAN bus driver for Bosch M_CAN controller
+ *
+ * Copyright (C) 2014 Freescale Semiconductor, Inc.
+ *	Dong Aisheng <b29396@freescale.com>
+ *
+ * Bosch M_CAN user manual can be obtained from:
+ * http://www.bosch-semiconductors.de/media/pdf_1/ipmodules_1/m_can/
+ * mcan_users_manual_v302.pdf
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/can/dev.h>
+#include <linux/pinctrl/consumer.h>
+
+#include "m_can_platform.h"
+
+static int m_can_plat_probe(struct platform_device *pdev)
+{
+	struct m_can_classdev *mcan_class;
+	struct net_device *dev;
+	struct m_can_priv *priv;
+	struct resource *res;
+	void __iomem *addr;
+	void __iomem *mram_addr;
+	int irq, ret = 0;
+
+	mcan_class = m_can_core_allocate_dev(&pdev->dev);
+	m_can_core_get_clocks(mcan_class);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "m_can");
+	addr = devm_ioremap_resource(&pdev->dev, res);
+	irq = platform_get_irq_byname(pdev, "int0");
+	if (IS_ERR(addr) || irq < 0) {
+		ret = -EINVAL;
+		goto failed_ret;
+	}
+
+	/* message ram could be shared */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "message_ram");
+	if (!res) {
+		ret = -ENODEV;
+		goto failed_ret;
+	}
+
+	mram_addr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!mram_addr) {
+		ret = -ENOMEM;
+		goto failed_ret;
+	}
+
+	mcan_class->net->irq = irq;
+	mcan_class->pm_clock_support = 1;
+	mcan_class->mram_base = mram_addr;
+	mcan_class->can.clock.freq = clk_get_rate(mcan_class->cclk);
+	mcan_class->dev = &pdev->dev;
+
+	platform_set_drvdata(pdev, mcan_class->dev);
+
+	m_can_init_ram(mcan_class);
+
+	m_can_core_register(mcan_class);
+
+failed_ret:
+/*	m_can_clk_stop(mcan_class);*/
+	if (ret) {
+		pm_runtime_disable(&pdev->dev);
+		free_candev(mcan_class->net);
+	}
+	return ret;
+}
+
+static __maybe_unused int m_can_suspend(struct device *dev)
+{
+	return m_can_core_suspend(dev);
+}
+
+static __maybe_unused int m_can_resume(struct device *dev)
+{
+	return m_can_core_resume(dev);
+}
+
+static void unregister_m_can_dev(struct net_device *dev)
+{
+	unregister_candev(dev);
+}
+
+static int m_can_plat_remove(struct platform_device *pdev)
+{
+	struct net_device *dev = platform_get_drvdata(pdev);
+
+	unregister_m_can_dev(dev);
+
+	pm_runtime_disable(&pdev->dev);
+
+	platform_set_drvdata(pdev, NULL);
+
+	free_candev(dev);
+
+	return 0;
+}
+
+static int __maybe_unused m_can_runtime_suspend(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct m_can_classdev *priv = netdev_priv(ndev);
+
+	clk_disable_unprepare(priv->cclk);
+	clk_disable_unprepare(priv->hclk);
+
+	return 0;
+}
+
+static int __maybe_unused m_can_runtime_resume(struct device *dev)
+{
+	struct net_device *ndev = dev_get_drvdata(dev);
+	struct m_can_classdev *priv = netdev_priv(ndev);
+	int err;
+
+	err = clk_prepare_enable(priv->hclk);
+	if (err)
+		return err;
+
+	err = clk_prepare_enable(priv->cclk);
+	if (err)
+		clk_disable_unprepare(priv->hclk);
+
+	return err;
+}
+
+static const struct dev_pm_ops m_can_pmops = {
+	SET_RUNTIME_PM_OPS(m_can_runtime_suspend,
+			   m_can_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(m_can_suspend, m_can_resume)
+};
+
+static const struct of_device_id m_can_of_table[] = {
+	{ .compatible = "bosch,m_can", .data = NULL },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, m_can_of_table);
+
+static struct platform_driver m_can_plat_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = m_can_of_table,
+		.pm     = &m_can_pmops,
+	},
+	.probe = m_can_plat_probe,
+	.remove = m_can_plat_remove,
+};
+
+module_platform_driver(m_can_plat_driver);
+
+MODULE_AUTHOR("Dong Aisheng <b29396@freescale.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("CAN bus driver for Bosch M_CAN controller");
diff --git a/drivers/net/can/m_can/m_can_platform.h b/drivers/net/can/m_can/m_can_platform.h
new file mode 100644
index 000000000000..2a83aff323e9
--- /dev/null
+++ b/drivers/net/can/m_can/m_can_platform.h
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+
+#ifndef _CAN_M_CAN_CORE_H_
+#define _CAN_M_CAN_CORE_H_
+
+#include <linux/can/core.h>
+#include <linux/can/led.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/freezer.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/iopoll.h>
+#include <linux/can/dev.h>
+#include <linux/pinctrl/consumer.h>
+
+/* m_can lec values */
+enum m_can_lec_type {
+	LEC_NO_ERROR = 0,
+	LEC_STUFF_ERROR,
+	LEC_FORM_ERROR,
+	LEC_ACK_ERROR,
+	LEC_BIT1_ERROR,
+	LEC_BIT0_ERROR,
+	LEC_CRC_ERROR,
+	LEC_UNUSED,
+};
+
+enum m_can_mram_cfg {
+	MRAM_SIDF = 0,
+	MRAM_XIDF,
+	MRAM_RXF0,
+	MRAM_RXF1,
+	MRAM_RXB,
+	MRAM_TXE,
+	MRAM_TXB,
+	MRAM_CFG_NUM,
+};
+
+/* address offset and element number for each FIFO/Buffer in the Message RAM */
+struct mram_cfg {
+	u16 off;
+	u8  num;
+};
+
+struct m_can_classdev {
+	struct can_priv can;
+	struct napi_struct napi;
+	struct net_device *net;
+	struct device *dev;
+	struct clk *hclk;
+	struct clk *cclk;
+
+	void *device_data;
+
+	int version;
+	int freq;
+	u32 irqstatus;
+
+	u32 (*m_can_read) (const struct m_can_classdev *m_can_class, int reg);
+	int (*m_can_write) (const struct m_can_classdev *m_can_class, int reg, int val);
+	u32 (*m_can_fifo_read) (const struct m_can_classdev *m_can_class, int reg);
+	int (*m_can_fifo_write) (const struct m_can_classdev *m_can_class, int reg, int val);
+	u32 (*m_can_txe_fifo_read) (const struct m_can_classdev *m_can_class);
+
+	/* Memory mapped ip */
+	void __iomem *base;
+	void __iomem *mram_addr;
+	void __iomem *mram_base;
+
+	/* Register based ip */
+	int reg_offset;
+	int mram_start;
+	int pm_clock_support;
+
+	struct mram_cfg mcfg[MRAM_CFG_NUM];
+};
+
+struct m_can_classdev *m_can_core_allocate_dev(struct device *dev);
+int m_can_core_register(struct m_can_classdev *m_can_dev);
+int m_can_core_get_clocks(struct m_can_classdev *m_can_dev);
+void m_can_init_ram(struct m_can_classdev *priv);
+void m_can_config_endisable(const struct m_can_classdev *priv, bool enable);
+
+int m_can_core_suspend(struct device *dev);
+int m_can_core_resume(struct device *dev);
+
+#endif	/* _CAN_M_CAN_CORE_H_ */
-- 
2.20.0.rc2.7.g965798d1f2
