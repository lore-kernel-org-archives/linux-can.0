From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] can: flexcan: fix 'passing zero to ERR_PTR()' warning
Date: Wed, 12 Dec 2018 17:24:01 +0800
Message-ID: <20181212092401.25612-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, wg@grandegger.com, mkl@pengutronix.de
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-can.vger.kernel.org

Fix a static code checker warning:
drivers/net/can/flexcan.c:1435 flexcan_setup_stop_mode() warn: passing zero to 'PTR_ERR'

Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0f36eaf..5f09764 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1432,7 +1432,7 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
 	gpr_np = of_find_node_by_phandle(phandle);
 	if (!gpr_np) {
 		dev_dbg(&pdev->dev, "could not find gpr node by phandle\n");
-		return PTR_ERR(gpr_np);
+		return -ENODEV;
 	}
 
 	priv = netdev_priv(dev);
-- 
2.7.0
