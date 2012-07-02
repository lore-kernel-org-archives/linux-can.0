From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6/6] can: flexcan: add hardware controller version support
Date: Mon,  2 Jul 2012 14:40:25 +0200
Message-ID: <1341232825-4604-7-git-send-email-mkl@pengutronix.de>
References: <1341232825-4604-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57328 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648Ab2GBMkc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Jul 2012 08:40:32 -0400
In-Reply-To: <1341232825-4604-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Hui Wang <jason77.wang@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Shawn Guo <shawn.guo@linaro.org>

From: Hui Wang <jason77.wang@gmail.com>

At least in the i.MX series, the flexcan contrller divides into ver_3
and ver_10, current driver is for ver_3 controller.

i.MX6 has ver_10 controller, it has more reigsters than ver_3 has.
The rxfgmask (Rx FIFO Global Mask) register is one of the new added.
Its reset value is 0xffffffff, this means ID Filter Table must be
checked when receive a packet, but the driver is designed to accept
everything during the chip start, we need to clear this register to
follow this design.

Use the data entry of the struct of_device_id to point chip specific
info, we can set hardware version for each platform.

Cc: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Hui Wang <jason77.wang@gmail.com>
[mkl: add id_table support]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c |   60 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index b429b3f..81324a1 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -34,6 +34,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pinctrl/consumer.h>
 
@@ -165,10 +166,21 @@ struct flexcan_regs {
 	u32 imask1;		/* 0x28 */
 	u32 iflag2;		/* 0x2c */
 	u32 iflag1;		/* 0x30 */
-	u32 _reserved2[19];
+	u32 crl2;		/* 0x34 */
+	u32 esr2;		/* 0x38 */
+	u32 imeur;		/* 0x3c */
+	u32 lrfr;		/* 0x40 */
+	u32 crcr;		/* 0x44 */
+	u32 rxfgmask;		/* 0x48 */
+	u32 rxfir;		/* 0x4c */
+	u32 _reserved3[12];
 	struct flexcan_mb cantxfg[64];
 };
 
+struct flexcan_devtype_data {
+	u32 hw_ver;	/* hardware controller version */
+};
+
 struct flexcan_priv {
 	struct can_priv can;
 	struct net_device *dev;
@@ -180,6 +192,15 @@ struct flexcan_priv {
 
 	struct clk *clk;
 	struct flexcan_platform_data *pdata;
+	struct flexcan_devtype_data *devtype_data;
+};
+
+static struct flexcan_devtype_data fsl_p1010_devtype_data = {
+	.hw_ver = 3,
+};
+
+static struct flexcan_devtype_data fsl_imx6q_devtype_data = {
+	.hw_ver = 10,
 };
 
 static struct can_bittiming_const flexcan_bittiming_const = {
@@ -750,6 +771,9 @@ static int flexcan_chip_start(struct net_device *dev)
 	flexcan_write(0x0, &regs->rx14mask);
 	flexcan_write(0x0, &regs->rx15mask);
 
+	if (priv->devtype_data->hw_ver >= 10)
+		flexcan_write(0x0, &regs->rxfgmask);
+
 	flexcan_transceiver_switch(priv, 1);
 
 	/* synchronize with the can bus */
@@ -922,8 +946,21 @@ static void __devexit unregister_flexcandev(struct net_device *dev)
 	unregister_candev(dev);
 }
 
+static const struct of_device_id flexcan_of_match[] = {
+	{ .compatible = "fsl,p1010-flexcan", .data = &fsl_p1010_devtype_data, },
+	{ .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, },
+	{ /* sentinel */ },
+};
+
+static const struct platform_device_id flexcan_id_table[] = {
+	{ .name = "flexcan", .driver_data = (kernel_ulong_t)&fsl_p1010_devtype_data, },
+	{ /* sentinel */ },
+};
+
 static int __devinit flexcan_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id;
+	struct flexcan_devtype_data *devtype_data;
 	struct net_device *dev;
 	struct flexcan_priv *priv;
 	struct resource *mem;
@@ -977,6 +1014,17 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 		goto failed_alloc;
 	}
 
+	of_id = of_match_device(flexcan_of_match, &pdev->dev);
+	if (of_id) {
+		devtype_data = of_id->data;
+	} else if (pdev->id_entry->driver_data) {
+		devtype_data = (struct flexcan_devtype_data *)
+			pdev->id_entry->driver_data;
+	} else {
+		err = -ENODEV;
+		goto failed_devtype;
+	}
+
 	dev->netdev_ops = &flexcan_netdev_ops;
 	dev->irq = irq;
 	dev->flags |= IFF_ECHO;
@@ -993,6 +1041,7 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 	priv->dev = dev;
 	priv->clk = clk;
 	priv->pdata = pdev->dev.platform_data;
+	priv->devtype_data = devtype_data;
 
 	netif_napi_add(dev, &priv->napi, flexcan_poll, FLEXCAN_NAPI_WEIGHT);
 
@@ -1011,6 +1060,7 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 	return 0;
 
  failed_register:
+ failed_devtype:
 	free_candev(dev);
  failed_alloc:
 	iounmap(base);
@@ -1044,13 +1094,6 @@ static int __devexit flexcan_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id flexcan_of_match[] = {
-	{
-		.compatible = "fsl,p1010-flexcan",
-	},
-	{},
-};
-
 #ifdef CONFIG_PM
 static int flexcan_suspend(struct platform_device *pdev, pm_message_t state)
 {
@@ -1097,6 +1140,7 @@ static struct platform_driver flexcan_driver = {
 	.remove = __devexit_p(flexcan_remove),
 	.suspend = flexcan_suspend,
 	.resume = flexcan_resume,
+	.id_table = flexcan_id_table,
 };
 
 module_platform_driver(flexcan_driver);
-- 
1.7.10

