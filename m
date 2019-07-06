From: Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH] can: flexcan: fix an use-after-free in flexcan_setup_stop_mode()
Date: Sat, 6 Jul 2019 11:37:20 +0800
Message-ID: <1562384240-46581-1-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

The gpr_np variable is still being used in dev_dbg() after the
of_node_put() call, which may result in use-after-free.

Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/can/flexcan.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index f2fe344..33ce45d 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1437,10 +1437,10 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
 
 	priv = netdev_priv(dev);
 	priv->stm.gpr = syscon_node_to_regmap(gpr_np);
-	of_node_put(gpr_np);
 	if (IS_ERR(priv->stm.gpr)) {
 		dev_dbg(&pdev->dev, "could not find gpr regmap\n");
-		return PTR_ERR(priv->stm.gpr);
+		ret = PTR_ERR(priv->stm.gpr);
+		goto out_put_node;
 	}
 
 	priv->stm.req_gpr = out_val[1];
@@ -1455,7 +1455,9 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
 
 	device_set_wakeup_capable(&pdev->dev, true);
 
-	return 0;
+out_put_node:
+	of_node_put(gpr_np);
+	return ret;
 }
 
 static const struct of_device_id flexcan_of_match[] = {
-- 
2.9.5
