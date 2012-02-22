From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC/PATCH] c_can: add driver for the PCH CAN controller
Date: Wed, 22 Feb 2012 13:57:36 +0100
Message-ID: <4F44E640.8010708@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:53405 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab2BVM5j (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Feb 2012 07:57:39 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Linux-CAN <linux-can@vger.kernel.org>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, "bhupesh.sharma" <bhupesh.sharma@st.com>, Tomoya MORINAGA <tomoya.rohm@gmail.com>

For maintenance reasons, this diver should replace the "pch_can" driver
sooner than later as it uses the same CAN controller core. I named it
"pch_pci". Maybe "pch_can" would be more appropriate (common). This
patch is for 2.6.39, but likely it applies fine also to more recent
versions of the Linux kernel.

Alexander, Tomoya, or anybody else, it would be nice if you could test
this patch and give some feedback. Thanks.

---
 drivers/net/can/c_can/Kconfig   |    8 +
 drivers/net/can/c_can/Makefile  |    1 
 drivers/net/can/c_can/c_can.c   |    4 
 drivers/net/can/c_can/c_can.h   |    1 
 drivers/net/can/c_can/pch_pci.c |  181 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 195 insertions(+)

Index: linux-denx/drivers/net/can/c_can/Kconfig
===================================================================
--- linux-denx.orig/drivers/net/can/c_can/Kconfig	2012-02-22 12:16:54.978617264 +0100
+++ linux-denx/drivers/net/can/c_can/Kconfig	2012-02-22 12:16:57.626527332 +0100
@@ -12,4 +12,12 @@
 	  processor attached devices) which can be found on various
 	  boards from ST Microelectronics (http://www.st.com)
 	  like the SPEAr1310 and SPEAr320 evaluation boards.
+
+config CAN_C_CAN_PCH_PCI
+	tristate "CAN on the Intel PCH EG20T"
+	depends on CAN_DEV && PCI
+	---help---
+	  This driver is for PCH CAN of Topcliff which is an IOH for x86
+	  embedded processor.
+
 endif
Index: linux-denx/drivers/net/can/c_can/Makefile
===================================================================
--- linux-denx.orig/drivers/net/can/c_can/Makefile	2012-02-22 12:16:54.979617230 +0100
+++ linux-denx/drivers/net/can/c_can/Makefile	2012-02-22 12:16:57.651526484 +0100
@@ -4,5 +4,6 @@
 
 obj-$(CONFIG_CAN_C_CAN) += c_can.o
 obj-$(CONFIG_CAN_C_CAN_PLATFORM) += c_can_platform.o
+obj-$(CONFIG_CAN_C_CAN_PCH_PCI) += pch_pci.o
 
 ccflags-$(CONFIG_CAN_DEBUG_DEVICES) := -DDEBUG
Index: linux-denx/drivers/net/can/c_can/pch_pci.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-denx/drivers/net/can/c_can/pch_pci.c	2012-02-22 12:20:11.908929647 +0100
@@ -0,0 +1,181 @@
+/*
+
+ * Copyright (C) 1999 - 2010 Intel Corporation.
+ * Copyright (C) 2010 OKI SEMICONDUCTOR CO., LTD.
+ * Copyright (C) 2012 Wolfgang Grandegger <wg@grandegger.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/can.h>
+#include <linux/can/dev.h>
+
+#include "c_can.h"
+
+#define PCH_PCI_SOFT_RESET	(0x1fc / sizeof(u16))
+#define PCH_PCI_CLK		50000000	/* 50MHz */
+
+static DEFINE_PCI_DEVICE_TABLE(pch_pci_tbl) = {
+	{PCI_VENDOR_ID_INTEL, 0x8818, PCI_ANY_ID, PCI_ANY_ID,},
+	{0,}
+};
+MODULE_DEVICE_TABLE(pci, pch_pci_tbl);
+
+static u16 pch_pci_read_reg(struct c_can_priv *priv, void *reg)
+{
+	u32 __iomem *addr = reg + 3 * ((long)reg - (long)priv->regs);
+
+	return (u16)ioread32(addr);
+}
+
+static void pch_pci_write_reg(struct c_can_priv *priv, void *reg, u16 val)
+{
+	u32 __iomem *addr = reg + 3 * ((long)reg - (long)priv->regs);
+
+	iowrite32((u32)val, addr);
+}
+
+static void pch_pci_reset(struct c_can_priv *priv)
+{
+	u32 __iomem *addr = (u32 __iomem *)(priv->regs + PCH_PCI_SOFT_RESET);
+
+	/* write to sw reset register */
+	iowrite32(1, addr);
+	iowrite32(0, addr);
+}
+
+static void __devexit pch_pci_remove(struct pci_dev *pdev)
+{
+	struct net_device *ndev = pci_get_drvdata(pdev);
+	struct c_can_priv *priv = netdev_priv(ndev);
+
+	unregister_c_can_dev(ndev);
+	pci_set_drvdata(pdev, NULL);
+
+	pci_iounmap(pdev, priv->regs);
+	if (pci_msi_enabled())
+		pci_disable_msi(pdev);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+	pch_pci_reset(priv);
+	free_c_can_dev(ndev);
+}
+
+static int __devinit pch_pci_probe(struct pci_dev *pdev,
+				   const struct pci_device_id *id)
+{
+	struct net_device *ndev;
+	struct c_can_priv *priv;
+	void __iomem *addr;
+	int rc;
+
+	rc = pci_enable_device(pdev);
+	if (rc) {
+		dev_err(&pdev->dev, "Failed pci_enable_device %d\n", rc);
+		goto probe_exit_enable_dev;
+	}
+
+	rc = pci_request_regions(pdev, KBUILD_MODNAME);
+	if (rc) {
+		dev_err(&pdev->dev, "Failed pci_request_regions %d\n", rc);
+		goto probe_exit_req_region;
+	}
+
+	addr = pci_iomap(pdev, 1, 0);
+	if (!addr) {
+		rc = -EIO;
+		dev_err(&pdev->dev, "Failed pci_iomap\n");
+		goto probe_exit_iomap;
+	}
+
+	/* allocate the c_can device */
+	ndev = alloc_c_can_dev();
+	if (!ndev) {
+		rc = -ENOMEM;
+		goto probe_exit_alloc_candev;
+	}
+
+	priv = netdev_priv(ndev);
+
+	ndev->irq = pdev->irq;
+	priv->irq_flags = IRQF_SHARED;
+	priv->regs = addr;
+	priv->can.clock.freq = PCH_PCI_CLK; /* Hz */;
+	priv->read_reg = pch_pci_read_reg;
+	priv->write_reg = pch_pci_write_reg;
+	priv->reset = pch_pci_reset;
+
+	pci_set_drvdata(pdev, ndev);
+	SET_NETDEV_DEV(ndev, &pdev->dev);
+
+	rc = pci_enable_msi(pdev);
+	netdev_info(ndev, "PCH-PCI opened with%s MSI\n", rc ? "out" : "");
+
+	rc = register_c_can_dev(ndev);
+	if (rc) {
+		dev_err(&pdev->dev, "Failed register_c_can_dev %d\n", rc);
+		goto probe_exit_reg_candev;
+	}
+
+	return 0;
+
+probe_exit_reg_candev:
+	if (pci_msi_enabled())
+		pci_disable_msi(pdev);
+	free_c_can_dev(ndev);
+probe_exit_alloc_candev:
+	pci_iounmap(pdev, addr);
+probe_exit_iomap:
+	pci_release_regions(pdev);
+probe_exit_req_region:
+	pci_disable_device(pdev);
+probe_exit_enable_dev:
+	return rc;
+}
+
+static struct pci_driver pch_pci_driver = {
+	.name = "pch_pci",
+	.id_table = pch_pci_tbl,
+	.probe = pch_pci_probe,
+	.remove = __devexit_p(pch_pci_remove),
+};
+
+static int __init pch_pci_init(void)
+{
+	return pci_register_driver(&pch_pci_driver);
+}
+module_init(pch_pci_init);
+
+static void __exit pch_pci_exit(void)
+{
+	pci_unregister_driver(&pch_pci_driver);
+}
+module_exit(pch_pci_exit);
+
+MODULE_DESCRIPTION("Intel EG20T PCH CAN(Controller Area Network) Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION("0.94");
Index: linux-denx/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-denx.orig/drivers/net/can/c_can/c_can.c	2012-02-22 12:16:54.978617264 +0100
+++ linux-denx/drivers/net/can/c_can/c_can.c	2012-02-22 12:16:57.653526416 +0100
@@ -1065,6 +1065,10 @@
 		goto exit_irq_fail;
 	}
 
+	/* reset the c_can controller */
+	if (priv->reset)
+		priv->reset(priv);
+
 	/* start the c_can controller */
 	c_can_start(dev);
 
Index: linux-denx/drivers/net/can/c_can/c_can.h
===================================================================
--- linux-denx.orig/drivers/net/can/c_can/c_can.h	2012-02-22 12:16:54.978617264 +0100
+++ linux-denx/drivers/net/can/c_can/c_can.h	2012-02-22 12:16:57.654526382 +0100
@@ -71,6 +71,7 @@
 	int last_status;
 	u16 (*read_reg) (struct c_can_priv *priv, void *reg);
 	void (*write_reg) (struct c_can_priv *priv, void *reg, u16 val);
+	void (*reset) (struct c_can_priv *priv);
 	struct c_can_regs __iomem *regs;
 	unsigned long irq_flags; /* for request_irq() */
 	unsigned int tx_next;
