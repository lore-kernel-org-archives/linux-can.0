From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/9] can: flexcan: add 2nd clock to support imx53 and newer
Date: Fri, 20 Jul 2012 13:11:42 +0200
Message-ID: <1342782709-4868-3-git-send-email-mkl@pengutronix.de>
References: <1342782709-4868-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42081 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106Ab2GTLLz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Jul 2012 07:11:55 -0400
In-Reply-To: <1342782709-4868-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

This patch adds support for a second clock to the flexcan driver. On
modern freescale ARM cores like the imx53 and imx6q two clocks ("ipg"
and "per") must be enabled in order to access the CAN core.

In the original driver, the clock was requested without specifying the
connection id, further all mainline ARM archs with flexcan support
(imx28, imx25, imx35) register their flexcan clock without a
connection id, too.

This patch first renames the existing clk variable to clk_ipg and
converts it to devm for easier error handling. The connection id "ipg"
is added to the devm_clk_get() call. Then a second clock "per" is
requested. As all archs don't specify a connection id, both clk_get
return the same clock. This ensures compatibility to existing flexcan
support and adds support for imx53 at the same time.

After this patch hits mainline, the archs may give their existing
flexcan clock the "ipg" connection id and implement a dummy "per"
clock.

This patch has been tested on imx28 (unmodified clk tree) and on imx53
with a seperate "ipg" and "per" clock.

Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Acked-by: Hui Wang <jason77.wang@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c |   45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index c8a6fc7..c5f1431 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -190,7 +190,8 @@ struct flexcan_priv {
 	u32 reg_esr;
 	u32 reg_ctrl_default;
 
-	struct clk *clk;
+	struct clk *clk_ipg;
+	struct clk *clk_per;
 	struct flexcan_platform_data *pdata;
 	const struct flexcan_devtype_data *devtype_data;
 };
@@ -828,7 +829,8 @@ static int flexcan_open(struct net_device *dev)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	int err;
 
-	clk_prepare_enable(priv->clk);
+	clk_prepare_enable(priv->clk_ipg);
+	clk_prepare_enable(priv->clk_per);
 
 	err = open_candev(dev);
 	if (err)
@@ -850,7 +852,8 @@ static int flexcan_open(struct net_device *dev)
  out_close:
 	close_candev(dev);
  out:
-	clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(priv->clk_per);
+	clk_disable_unprepare(priv->clk_ipg);
 
 	return err;
 }
@@ -864,7 +867,8 @@ static int flexcan_close(struct net_device *dev)
 	flexcan_chip_stop(dev);
 
 	free_irq(dev->irq, dev);
-	clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(priv->clk_per);
+	clk_disable_unprepare(priv->clk_ipg);
 
 	close_candev(dev);
 
@@ -903,7 +907,8 @@ static int __devinit register_flexcandev(struct net_device *dev)
 	struct flexcan_regs __iomem *regs = priv->base;
 	u32 reg, err;
 
-	clk_prepare_enable(priv->clk);
+	clk_prepare_enable(priv->clk_ipg);
+	clk_prepare_enable(priv->clk_per);
 
 	/* select "bus clock", chip must be disabled */
 	flexcan_chip_disable(priv);
@@ -936,7 +941,8 @@ static int __devinit register_flexcandev(struct net_device *dev)
  out:
 	/* disable core and turn off clocks */
 	flexcan_chip_disable(priv);
-	clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(priv->clk_per);
+	clk_disable_unprepare(priv->clk_ipg);
 
 	return err;
 }
@@ -964,7 +970,7 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 	struct net_device *dev;
 	struct flexcan_priv *priv;
 	struct resource *mem;
-	struct clk *clk = NULL;
+	struct clk *clk_ipg = NULL, *clk_per = NULL;
 	struct pinctrl *pinctrl;
 	void __iomem *base;
 	resource_size_t mem_size;
@@ -980,13 +986,20 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 						"clock-frequency", &clock_freq);
 
 	if (!clock_freq) {
-		clk = clk_get(&pdev->dev, NULL);
-		if (IS_ERR(clk)) {
-			dev_err(&pdev->dev, "no clock defined\n");
-			err = PTR_ERR(clk);
+		clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+		if (IS_ERR(clk_ipg)) {
+			dev_err(&pdev->dev, "no ipg clock defined\n");
+			err = PTR_ERR(clk_ipg);
+			goto failed_clock;
+		}
+		clock_freq = clk_get_rate(clk_ipg);
+
+		clk_per = devm_clk_get(&pdev->dev, "per");
+		if (IS_ERR(clk_per)) {
+			dev_err(&pdev->dev, "no per clock defined\n");
+			err = PTR_ERR(clk_per);
 			goto failed_clock;
 		}
-		clock_freq = clk_get_rate(clk);
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1039,7 +1052,8 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 		CAN_CTRLMODE_BERR_REPORTING;
 	priv->base = base;
 	priv->dev = dev;
-	priv->clk = clk;
+	priv->clk_ipg = clk_ipg;
+	priv->clk_per = clk_per;
 	priv->pdata = pdev->dev.platform_data;
 	priv->devtype_data = devtype_data;
 
@@ -1067,8 +1081,6 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
  failed_map:
 	release_mem_region(mem->start, mem_size);
  failed_get:
-	if (clk)
-		clk_put(clk);
  failed_clock:
 	return err;
 }
@@ -1086,9 +1098,6 @@ static int __devexit flexcan_remove(struct platform_device *pdev)
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(mem->start, resource_size(mem));
 
-	if (priv->clk)
-		clk_put(priv->clk);
-
 	free_candev(dev);
 
 	return 0;
-- 
1.7.10

