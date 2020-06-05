From: Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] can: xilinx_can: handle failure cases of pm_runtime_get_sync
Date: Thu,  4 Jun 2020 22:32:39 -0500
Message-ID: <20200605033239.60664-1-navid.emamdoost@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Michal Simek <michal.simek@xilinx.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>
List-Id: linux-can.vger.kernel.org

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count. Call pm_runtime_put if
pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/net/can/xilinx_can.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index c1dbab8c896d..748ff70f6a7b 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1391,7 +1391,7 @@ static int xcan_open(struct net_device *ndev)
 	if (ret < 0) {
 		netdev_err(ndev, "%s: pm_runtime_get failed(%d)\n",
 			   __func__, ret);
-		return ret;
+		goto err;
 	}
 
 	ret = request_irq(ndev->irq, xcan_interrupt, priv->irq_flags,
@@ -1475,6 +1475,7 @@ static int xcan_get_berr_counter(const struct net_device *ndev,
 	if (ret < 0) {
 		netdev_err(ndev, "%s: pm_runtime_get failed(%d)\n",
 			   __func__, ret);
+		pm_runtime_put(priv->dev);
 		return ret;
 	}
 
@@ -1789,7 +1790,7 @@ static int xcan_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		netdev_err(ndev, "%s: pm_runtime_get failed(%d)\n",
 			   __func__, ret);
-		goto err_pmdisable;
+		goto err_disableclks;
 	}
 
 	if (priv->read_reg(priv, XCAN_SR_OFFSET) != XCAN_SR_CONFIG_MASK) {
@@ -1824,7 +1825,6 @@ static int xcan_probe(struct platform_device *pdev)
 
 err_disableclks:
 	pm_runtime_put(priv->dev);
-err_pmdisable:
 	pm_runtime_disable(&pdev->dev);
 err_free:
 	free_candev(ndev);
-- 
2.17.1
