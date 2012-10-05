From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [RFC: PATCH 5/5] can: sja1000_platform: add device tree bindings
Date: Fri,  5 Oct 2012 16:39:07 +0200
Message-ID: <1349447947-18451-6-git-send-email-mkl@pengutronix.de>
References: <1349447947-18451-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38409 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab2JEOjS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 5 Oct 2012 10:39:18 -0400
In-Reply-To: <1349447947-18451-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: andreas@gaisler.com, kernel@pengutronix.de, wg@grandegger.com, Marc Kleine-Budde <mkl@pengutronix.de>

This patch add device tree bindings, the are ported from the
sja1000_of_platform driver:

    Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>

The use of "of_get_property()" has been converted to "of_property_read_u32()"
to be endianess safe.

Cc: Wolfgang Grandegger <wg@grandegger.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000_platform.c |   91 +++++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/can/sja1000/sja1000_platform.c
index 6260209..91f7404 100644
--- a/drivers/net/can/sja1000/sja1000_platform.c
+++ b/drivers/net/can/sja1000/sja1000_platform.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (C) 2005 Sascha Hauer, Pengutronix
- * Copyright (C) 2007 Wolfgang Grandegger <wg@grandegger.com>
+ * Copyright (C) 2007-2009 Wolfgang Grandegger <wg@grandegger.com>
+ * Copyright (C) 2012 Marc Kleine-Budde <mkl@pengutronix.de>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the version 2 of the GNU General Public License
@@ -11,15 +12,28 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ * This is a generic driver for SJA1000 chips on the OpenFirmware
+ * platform bus found on embedded systems. You need a SJA1000 CAN node
+ * definition in your flattened device tree source (DTS) file similar
+ * to:
+ *
+ *   can@3,100 {
+ *           compatible = "nxp,sja1000";
+ *           reg = <3 0x100 0x80>;
+ *           interrupts = <2 0>;
+ *           interrupt-parent = <&mpic>;
+ *           nxp,external-clock-frequency = <16000000>;
+ *   };
+ *
+ * See "Documentation/devicetree/bindings/net/can/sja1000.txt" for
+ * further information.
  */
 
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/netdevice.h>
+#include <linux/of.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
@@ -30,6 +44,8 @@
 
 #include "sja1000.h"
 
+#define SP_DEFAULT_CLOCK	(16000000 / 2)
+
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
 MODULE_DESCRIPTION("Socket-CAN driver for SJA1000 on the platform bus");
 MODULE_LICENSE("GPL v2");
@@ -72,6 +88,61 @@ static void __devinit sp_probe_pdata(struct sja1000_priv *priv, const struct sja
 	priv->cdr = pdata->cdr;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id __devinitconst sp_match_table[] = {
+	{ .compatible = "nxp,sja1000" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, sp_match_table);
+
+static void __devinit sp_probe_of(struct sja1000_priv *priv, const struct device_node *of_node)
+{
+	int err;
+	u32 prop;
+	bool bypass;
+
+	err = of_property_read_u32(of_node,
+				   "nxp,external-clock-frequency", &prop);
+	if (err)
+		priv->can.clock.freq = SP_DEFAULT_CLOCK;
+	else
+		priv->can.clock.freq = prop / 2;
+
+	err = of_property_read_u32(of_node, "nxp,tx-output-mode", &prop);
+	if (err)
+		priv->ocr |= OCR_MODE_NORMAL;	/* default */
+	else
+		priv->ocr |= prop & OCR_MODE_MASK;
+
+	err = of_property_read_u32(of_node, "nxp,tx-output-config", &prop);
+	if (err)
+		priv->ocr |= OCR_TX0_PULLDOWN;	/* default */
+	else
+		priv->ocr |= (prop << OCR_TX_SHIFT) & OCR_TX_MASK;
+
+	err = of_property_read_u32(of_node, "nxp,clock-out-frequency", &prop);
+	if (err) {
+		priv->cdr |= CDR_CLK_OFF;	/* default */
+	} else {
+		u32 divider = priv->can.clock.freq * 2 / prop;
+
+		if (divider > 1)
+			priv->cdr |= divider / 2 - 1;
+		else
+			priv->cdr |= CDR_CLKOUT_MASK;
+	}
+
+	bypass = !of_property_read_bool(of_node, "nxp,no-comparator-bypass");
+	if (bypass)
+		priv->cdr |= CDR_CBP;		/* default */
+}
+#else
+static inline void __devinit sp_probe_of(struct sja1000_priv *priv, const struct device_node *of_node)
+{
+	return;
+}
+#endif
+
 static int __devinit sp_probe(struct platform_device *pdev)
 {
 	int err;
@@ -80,10 +151,12 @@ static int __devinit sp_probe(struct platform_device *pdev)
 	struct sja1000_priv *priv;
 	struct resource *res_mem, *res_irq;
 	const struct sja1000_platform_data *pdata;
+	const struct device_node *of_node;
 
 	pdata = pdev->dev.platform_data;
-	if (!pdata) {
-		dev_err(&pdev->dev, "No platform data provided!\n");
+	of_node = pdev->dev.of_node;
+	if (!pdata && !of_node) {
+		dev_err(&pdev->dev, "No platform data provided or no OF device!\n");
 		err = -ENODEV;
 		goto exit;
 	}
@@ -114,7 +187,10 @@ static int __devinit sp_probe(struct platform_device *pdev)
 		priv->irq_flags |= IRQF_SHARED;
 	priv->reg_base = addr;
 
-	sp_probe_pdata(priv, pdata);
+	if (pdata)
+		sp_probe_pdata(priv, pdata);
+	else
+		sp_probe_of(priv, of_node);
 
 	switch (res_mem->flags & IORESOURCE_MEM_TYPE_MASK) {
 	case IORESOURCE_MEM_32BIT:
@@ -168,6 +244,7 @@ static struct platform_driver sp_driver = {
 	.remove = __devexit_p(sp_remove),
 	.driver = {
 		.name = KBUILD_MODNAME,
+		.of_match_table = of_match_ptr(sp_match_table),
 		.owner = THIS_MODULE,
 	},
 };
-- 
1.7.10

