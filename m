From: <shubhrajyoti.datta@gmail.com>
Subject: [PATCH] can: xilinx: Enable clocks even when CONFIG_PM is disabled
Date: Tue, 4 Sep 2018 17:57:58 +0530
Message-ID: <1536064078-21539-1-git-send-email-shubhrajyoti.datta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-can@vger.kernel.org
Cc: shubhrajyoti.datta@gmail.com, netdev@vger.kernel.org, davem@davemloft.net, mkl@pengutronix.de, wg@grandegger.com, michal.simek@xilinx.com, linux-kernel@vger.kernel.org, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-Id: linux-can.vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Currently the clocks are enabled only in the runtime calls.
When CONFIG_PM is disabled the driver does not work as the
clocks are disabled.
Fix the same by enabling the clocks in probe.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/net/can/xilinx_can.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 131cce1..bf39b52 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1550,14 +1550,21 @@ static int xcan_probe(struct platform_device *pdev)
 	priv->write_reg = xcan_write_reg_le;
 	priv->read_reg = xcan_read_reg_le;
 
-	pm_runtime_enable(&pdev->dev);
-	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0) {
-		netdev_err(ndev, "%s: pm_runtime_get failed(%d)\n",
-			__func__, ret);
-		goto err_pmdisable;
+	ret = clk_prepare_enable(priv->bus_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Cannot enable clock.\n");
+		goto err_free;
+	}
+
+	ret = clk_prepare_enable(priv->can_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Cannot enable clock.\n");
+		goto err_clk;
 	}
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	if (priv->read_reg(priv, XCAN_SR_OFFSET) != XCAN_SR_CONFIG_MASK) {
 		priv->write_reg = xcan_write_reg_be;
 		priv->read_reg = xcan_read_reg_be;
@@ -1584,9 +1591,11 @@ static int xcan_probe(struct platform_device *pdev)
 	return 0;
 
 err_disableclks:
-	pm_runtime_put(priv->dev);
-err_pmdisable:
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	clk_disable_unprepare(priv->can_clk);
+err_clk:
+	clk_disable_unprepare(priv->bus_clk);
 err_free:
 	free_candev(ndev);
 err:
@@ -1606,6 +1615,12 @@ static int xcan_remove(struct platform_device *pdev)
 	struct xcan_priv *priv = netdev_priv(ndev);
 
 	unregister_candev(ndev);
+
+	if (!pm_runtime_suspended(&pdev->dev)) {
+		clk_disable_unprepare(priv->bus_clk);
+		clk_disable_unprepare(priv->can_clk);
+	}
+
 	pm_runtime_disable(&pdev->dev);
 	netif_napi_del(&priv->napi);
 	free_candev(ndev);
-- 
2.1.1
