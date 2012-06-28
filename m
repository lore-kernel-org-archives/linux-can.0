From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH v2 2/2] can: flexcan: add hardware controller version support
Date: Thu, 28 Jun 2012 16:21:35 +0800
Message-ID: <1340871695-26327-3-git-send-email-jason77.wang@gmail.com>
References: <1340871695-26327-1-git-send-email-jason77.wang@gmail.com>
 <1340871695-26327-2-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:61076 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab2F1IVz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 04:21:55 -0400
In-Reply-To: <1340871695-26327-2-git-send-email-jason77.wang@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de, wg@grandegger.com, shawn.guo@linaro.org
Cc: linux-can@vger.kernel.org

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
---
 drivers/net/can/flexcan.c |   41 +++++++++++++++++++++++++++++++++--------
 1 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index f63f826..9712bdb 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -34,6 +34,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pinctrl/consumer.h>
 
@@ -165,10 +166,20 @@ struct flexcan_regs {
 	u32 imask1;		/* 0x28 */
 	u32 iflag2;		/* 0x2c */
 	u32 iflag1;		/* 0x30 */
-	u32 _reserved2[19];
+	u32 crl2;		/* 0x34 */
+	u32 esr2;		/* 0x38 */
+	u32 _reserved2[2];
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
@@ -180,6 +191,15 @@ struct flexcan_priv {
 
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
@@ -750,6 +770,9 @@ static int flexcan_chip_start(struct net_device *dev)
 	flexcan_write(0x0, &regs->rx14mask);
 	flexcan_write(0x0, &regs->rx15mask);
 
+	if (priv->devtype_data && priv->devtype_data->hw_ver >= 10)
+		flexcan_write(0x0, &regs->rxfgmask);
+
 	flexcan_transceiver_switch(priv, 1);
 
 	/* synchronize with the can bus */
@@ -922,8 +945,16 @@ static void __devexit unregister_flexcandev(struct net_device *dev)
 	unregister_candev(dev);
 }
 
+static const struct of_device_id flexcan_of_match[] = {
+	{ .compatible = "fsl,p1010-flexcan", .data = &fsl_p1010_devtype_data, },
+	{ .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, },
+	{},
+};
+
 static int __devinit flexcan_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id =
+			of_match_device(flexcan_of_match, &pdev->dev);
 	struct net_device *dev;
 	struct flexcan_priv *priv;
 	struct resource *mem;
@@ -982,6 +1013,7 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 	dev->flags |= IFF_ECHO;
 
 	priv = netdev_priv(dev);
+	priv->devtype_data = of_id ? of_id->data : NULL;
 	priv->can.clock.freq = clock_freq;
 	priv->can.bittiming_const = &flexcan_bittiming_const;
 	priv->can.do_set_mode = flexcan_set_mode;
@@ -1044,13 +1076,6 @@ static int __devexit flexcan_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id flexcan_of_match[] = {
-	{
-		.compatible = "fsl,p1010-flexcan",
-	},
-	{},
-};
-
 static struct platform_driver flexcan_driver = {
 	.driver = {
 		.name = DRV_NAME,
-- 
1.7.6

