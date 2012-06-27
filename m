From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH 3/4] can: flexcan: add ipg and ser clocks support
Date: Wed, 27 Jun 2012 16:19:20 +0800
Message-ID: <1340785161-3598-4-git-send-email-jason77.wang@gmail.com>
References: <1340785161-3598-1-git-send-email-jason77.wang@gmail.com>
 <1340785161-3598-2-git-send-email-jason77.wang@gmail.com>
 <1340785161-3598-3-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:36768 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435Ab2F0ITr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 04:19:47 -0400
In-Reply-To: <1340785161-3598-3-git-send-email-jason77.wang@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de, davem@davemloft.net, shawn.guo@linaro.org
Cc: linux-can@vger.kernel.org

Some i.MX chip (like i.MX6) has two clocks to drive flexcan module,
one is ipg clock, another is serial clock, if we want the flexcan
to work, we need to enable both two clocks, but current driver only
support one clock.

My modification doesn't break existing platforms. For those without
clocks (like powerpc platforms), two clk pointers are set to NULL as
before, for those only have one clock (like i.MX25 and i.MX35), the
second clk pointer is set to NULL.

Cc: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---
 drivers/net/can/flexcan.c |   49 +++++++++++++++++++++++++++++---------------
 1 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 9d024a4..a23c11e 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -185,7 +185,8 @@ struct flexcan_priv {
 	u32 reg_ctrl_default;
 	u32 hw_ver;
 
-	struct clk *clk;
+	struct clk *clk_ipg;
+	struct clk *clk_per;
 	struct flexcan_platform_data *pdata;
 };
 
@@ -814,7 +815,8 @@ static int flexcan_open(struct net_device *dev)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	int err;
 
-	clk_prepare_enable(priv->clk);
+	clk_prepare_enable(priv->clk_ipg);
+	clk_prepare_enable(priv->clk_per);
 
 	err = open_candev(dev);
 	if (err)
@@ -836,7 +838,8 @@ static int flexcan_open(struct net_device *dev)
  out_close:
 	close_candev(dev);
  out:
-	clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(priv->clk_ipg);
+	clk_disable_unprepare(priv->clk_per);
 
 	return err;
 }
@@ -850,7 +853,8 @@ static int flexcan_close(struct net_device *dev)
 	flexcan_chip_stop(dev);
 
 	free_irq(dev->irq, dev);
-	clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(priv->clk_ipg);
+	clk_disable_unprepare(priv->clk_per);
 
 	close_candev(dev);
 
@@ -889,7 +893,8 @@ static int __devinit register_flexcandev(struct net_device *dev)
 	struct flexcan_regs __iomem *regs = priv->base;
 	u32 reg, err;
 
-	clk_prepare_enable(priv->clk);
+	clk_prepare_enable(priv->clk_ipg);
+	clk_prepare_enable(priv->clk_per);
 
 	/* select "bus clock", chip must be disabled */
 	flexcan_chip_disable(priv);
@@ -922,7 +927,8 @@ static int __devinit register_flexcandev(struct net_device *dev)
  out:
 	/* disable core and turn off clocks */
 	flexcan_chip_disable(priv);
-	clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(priv->clk_ipg);
+	clk_disable_unprepare(priv->clk_per);
 
 	return err;
 }
@@ -937,7 +943,8 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 	struct net_device *dev;
 	struct flexcan_priv *priv;
 	struct resource *mem;
-	struct clk *clk = NULL;
+	struct clk *clk_per = NULL;
+	struct clk *clk_ipg = NULL;
 	struct pinctrl *pinctrl;
 	void __iomem *base;
 	resource_size_t mem_size;
@@ -965,15 +972,18 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 	}
 
 	if (!clock_freq) {
-		clk = clk_get(&pdev->dev, NULL);
-		if (IS_ERR(clk)) {
+		clk_ipg = clk_get(&pdev->dev, "ipg");
+		if (IS_ERR(clk_ipg)) {
 			dev_err(&pdev->dev, "no clock defined\n");
-			err = PTR_ERR(clk);
+			err = PTR_ERR(clk_ipg);
 			goto failed_clock;
 		}
-		clock_freq = clk_get_rate(clk);
-	}
+		clock_freq = clk_get_rate(clk_ipg);
 
+		clk_per = clk_get(&pdev->dev, "per");
+		if (IS_ERR(clk_per) || clk_per == clk_ipg)
+			clk_per = NULL;
+	}
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
 	if (!mem || irq <= 0) {
@@ -1013,7 +1023,8 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 		CAN_CTRLMODE_BERR_REPORTING;
 	priv->base = base;
 	priv->dev = dev;
-	priv->clk = clk;
+	priv->clk_ipg = clk_ipg;
+	priv->clk_per = clk_per;
 	priv->hw_ver = hw_ver;
 	priv->pdata = pdev->dev.platform_data;
 
@@ -1040,8 +1051,10 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
  failed_map:
 	release_mem_region(mem->start, mem_size);
  failed_get:
-	if (clk)
-		clk_put(clk);
+	if (clk_per)
+		clk_put(clk_per);
+	if (clk_ipg)
+		clk_put(clk_ipg);
  failed_clock:
 	return err;
 }
@@ -1059,8 +1072,10 @@ static int __devexit flexcan_remove(struct platform_device *pdev)
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(mem->start, resource_size(mem));
 
-	if (priv->clk)
-		clk_put(priv->clk);
+	if (priv->clk_per)
+		clk_put(priv->clk_per);
+	if (priv->clk_ipg)
+		clk_put(priv->clk_ipg);
 
 	free_candev(dev);
 
-- 
1.7.6

