From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH linux-master 2/3] can: m_can_platform: Move clock discovery and init to platform
Date: Fri, 31 Jan 2020 12:34:32 -0600
Message-ID: <20200131183433.11041-3-dmurphy@ti.com>
References: <20200131183433.11041-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49246 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgAaSiH (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 31 Jan 2020 13:38:07 -0500
In-Reply-To: <20200131183433.11041-1-dmurphy@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-kernel@vger.kernel.org, mkl@pengutronix.de, linux-can@vger.kernel.org, wg@grandegger.com, sriram.dash@samsung.com
Cc: davem@davemloft.net, Dan Murphy <dmurphy@ti.com>

Move the clock discovery and init to the platform driver as the platform
driver needs an additional clock to the CAN clock to be initilialized
and managed.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/can/m_can/m_can_platform.c | 37 +++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 38ea5e600fb8..8bd459317eba 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -12,6 +12,9 @@
 struct m_can_plat_priv {
 	void __iomem *base;
 	void __iomem *mram_base;
+
+	struct clk *hclk;
+	struct clk *cclk;
 };
 
 static u32 iomap_read_reg(struct m_can_classdev *cdev, int reg)
@@ -53,6 +56,22 @@ static struct m_can_ops m_can_plat_ops = {
 	.read_fifo = iomap_read_fifo,
 };
 
+static int m_can_plat_get_clocks(struct m_can_plat_priv *priv,
+				 struct m_can_classdev *mcan_class)
+{
+	int ret = 0;
+
+	priv->hclk = devm_clk_get(mcan_class->dev, "hclk");
+
+	priv->cclk = devm_clk_get(mcan_class->dev, "cclk");
+	if (IS_ERR(priv->cclk)) {
+		dev_err(mcan_class->dev, "no clock found\n");
+		ret = -ENODEV;
+	}
+
+	return ret;
+}
+
 static int m_can_plat_probe(struct platform_device *pdev)
 {
 	struct m_can_classdev *mcan_class;
@@ -72,7 +91,9 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	mcan_class->device_data = priv;
 
-	m_can_class_get_clocks(mcan_class);
+	ret = m_can_plat_get_clocks(priv, mcan_class);
+	if (ret)
+		return ret;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "m_can");
 	addr = devm_ioremap_resource(&pdev->dev, res);
@@ -100,7 +121,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	mcan_class->net->irq = irq;
 	mcan_class->pm_clock_support = 1;
-	mcan_class->can.clock.freq = clk_get_rate(mcan_class->cclk);
+	mcan_class->can.clock.freq = clk_get_rate(priv->cclk);
 	mcan_class->dev = &pdev->dev;
 
 	mcan_class->ops = &m_can_plat_ops;
@@ -143,11 +164,12 @@ static int __maybe_unused m_can_runtime_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct m_can_classdev *mcan_class = netdev_priv(ndev);
+	struct m_can_plat_priv *priv = mcan_class->device_data;
 
 	m_can_class_suspend(dev);
 
-	clk_disable_unprepare(mcan_class->cclk);
-	clk_disable_unprepare(mcan_class->hclk);
+	clk_disable_unprepare(priv->cclk);
+	clk_disable_unprepare(priv->hclk);
 
 	return 0;
 }
@@ -156,15 +178,16 @@ static int __maybe_unused m_can_runtime_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct m_can_classdev *mcan_class = netdev_priv(ndev);
+	struct m_can_plat_priv *priv = mcan_class->device_data;
 	int err;
 
-	err = clk_prepare_enable(mcan_class->hclk);
+	err = clk_prepare_enable(priv->hclk);
 	if (err)
 		return err;
 
-	err = clk_prepare_enable(mcan_class->cclk);
+	err = clk_prepare_enable(priv->cclk);
 	if (err)
-		clk_disable_unprepare(mcan_class->hclk);
+		clk_disable_unprepare(priv->hclk);
 
 	return err;
 }
-- 
2.25.0
