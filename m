From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v6 3/6] can: m_can: Add PM Runtime
Date: Fri, 22 Dec 2017 19:01:25 +0530
Message-ID: <1513949488-13026-4-git-send-email-faiz_abbas@ti.com>
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, faiz_abbas@ti.com, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com
List-Id: linux-can.vger.kernel.org

From: Franklin S Cooper Jr <fcooper@ti.com>

Add support for PM Runtime which is the new way to handle managing clocks.
However, to avoid breaking SoCs not using PM_RUNTIME leave the old clk
management approach in place.

PM_RUNTIME is required by OMAP based devices to handle clock management.
Therefore, this allows future Texas Instruments SoCs that have the MCAN IP
to work with this driver.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
[nsekhar@ti.com: handle pm_runtime_get_sync() failure, fix some bugs]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/net/can/m_can/m_can.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index f72116e..53e764f 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -23,6 +23,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/iopoll.h>
 #include <linux/can/dev.h>
 
@@ -625,19 +626,33 @@ static int m_can_clk_start(struct m_can_priv *priv)
 {
 	int err;
 
+	err = pm_runtime_get_sync(priv->device);
+	if (err) {
+		pm_runtime_put_noidle(priv->device);
+		return err;
+	}
+
 	err = clk_prepare_enable(priv->hclk);
 	if (err)
-		return err;
+		goto pm_runtime_put;
 
 	err = clk_prepare_enable(priv->cclk);
 	if (err)
-		clk_disable_unprepare(priv->hclk);
+		goto disable_hclk;
 
 	return err;
+
+disable_hclk:
+	clk_disable_unprepare(priv->hclk);
+pm_runtime_put:
+	pm_runtime_put_sync(priv->device);
+	return err;
 }
 
 static void m_can_clk_stop(struct m_can_priv *priv)
 {
+	pm_runtime_put_sync(priv->device);
+
 	clk_disable_unprepare(priv->cclk);
 	clk_disable_unprepare(priv->hclk);
 }
@@ -1577,13 +1592,20 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	/* Enable clocks. Necessary to read Core Release in order to determine
 	 * M_CAN version
 	 */
+	pm_runtime_enable(&pdev->dev);
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret)  {
+		pm_runtime_put_noidle(&pdev->dev);
+		goto pm_runtime_fail;
+	}
+
 	ret = clk_prepare_enable(hclk);
 	if (ret)
-		goto disable_hclk_ret;
+		goto pm_runtime_put;
 
 	ret = clk_prepare_enable(cclk);
 	if (ret)
-		goto disable_cclk_ret;
+		goto disable_hclk_ret;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "m_can");
 	addr = devm_ioremap_resource(&pdev->dev, res);
@@ -1666,6 +1688,11 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	clk_disable_unprepare(cclk);
 disable_hclk_ret:
 	clk_disable_unprepare(hclk);
+pm_runtime_put:
+	pm_runtime_put_sync(&pdev->dev);
+pm_runtime_fail:
+	if (ret)
+		pm_runtime_disable(&pdev->dev);
 failed_ret:
 	return ret;
 }
@@ -1723,6 +1750,9 @@ static int m_can_plat_remove(struct platform_device *pdev)
 	struct net_device *dev = platform_get_drvdata(pdev);
 
 	unregister_m_can_dev(dev);
+
+	pm_runtime_disable(&pdev->dev);
+
 	platform_set_drvdata(pdev, NULL);
 
 	free_m_can_dev(dev);
-- 
2.7.4
