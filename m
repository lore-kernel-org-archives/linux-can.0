From: Zhang Changzhong <zhangchangzhong@huawei.com>
Subject: [PATCH net-next] can: mscan: simplify clock enable/disable
Date: Fri, 17 Jul 2020 16:01:15 +0800
Message-ID: <1594972875-27631-1-git-send-email-zhangchangzhong@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:49170 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726198AbgGQIBX (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 17 Jul 2020 04:01:23 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, kuba@kernel.org, faber@faberman.de
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

All the NULL checks are pointless, clk_*() routines already deal with
NULL just fine.

Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
---
 drivers/net/can/mscan/mscan.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index 99101d7..d4390b6 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -540,16 +540,12 @@ static int mscan_open(struct net_device *dev)
 	struct mscan_priv *priv = netdev_priv(dev);
 	struct mscan_regs __iomem *regs = priv->reg_base;
 
-	if (priv->clk_ipg) {
-		ret = clk_prepare_enable(priv->clk_ipg);
-		if (ret)
-			goto exit_retcode;
-	}
-	if (priv->clk_can) {
-		ret = clk_prepare_enable(priv->clk_can);
-		if (ret)
-			goto exit_dis_ipg_clock;
-	}
+	ret = clk_prepare_enable(priv->clk_ipg);
+	if (ret)
+		goto exit_retcode;
+	ret = clk_prepare_enable(priv->clk_can);
+	if (ret)
+		goto exit_dis_ipg_clock;
 
 	/* common open */
 	ret = open_candev(dev);
@@ -583,11 +579,9 @@ static int mscan_open(struct net_device *dev)
 	napi_disable(&priv->napi);
 	close_candev(dev);
 exit_dis_can_clock:
-	if (priv->clk_can)
-		clk_disable_unprepare(priv->clk_can);
+	clk_disable_unprepare(priv->clk_can);
 exit_dis_ipg_clock:
-	if (priv->clk_ipg)
-		clk_disable_unprepare(priv->clk_ipg);
+	clk_disable_unprepare(priv->clk_ipg);
 exit_retcode:
 	return ret;
 }
@@ -606,10 +600,8 @@ static int mscan_close(struct net_device *dev)
 	close_candev(dev);
 	free_irq(dev->irq, dev);
 
-	if (priv->clk_can)
-		clk_disable_unprepare(priv->clk_can);
-	if (priv->clk_ipg)
-		clk_disable_unprepare(priv->clk_ipg);
+	clk_disable_unprepare(priv->clk_can);
+	clk_disable_unprepare(priv->clk_ipg);
 
 	return 0;
 }
-- 
1.8.3.1
