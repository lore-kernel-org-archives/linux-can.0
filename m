From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/4] can: flexcan: fix 'passing zero to ERR_PTR()' warning
Date: Tue, 22 Jan 2019 14:21:15 +0100
Message-ID: <20190122132116.7074-4-mkl@pengutronix.de>
References: <20190122132116.7074-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190122132116.7074-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, YueHaibing <yuehaibing@huawei.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix a static code checker warning:
drivers/net/can/flexcan.c:1435 flexcan_setup_stop_mode() warn: passing zero to 'PTR_ERR'

Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0f36eafe3ac1..5f097648d12d 100644
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
2.20.1
