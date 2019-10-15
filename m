From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] can: sun4i: use devm_platform_ioremap_resource() to simplify code
Date: Tue, 15 Oct 2019 22:27:44 +0800
Message-ID: <20191015142744.25236-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, mripard@kernel.org, wens@csie.org
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-can.vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/can/sun4i_can.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index f4cd881..e3ba8ab 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -771,7 +771,6 @@ static int sun4ican_remove(struct platform_device *pdev)
 static int sun4ican_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct resource *mem;
 	struct clk *clk;
 	void __iomem *addr;
 	int err, irq;
@@ -791,8 +790,7 @@ static int sun4ican_probe(struct platform_device *pdev)
 		goto exit;
 	}
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	addr = devm_ioremap_resource(&pdev->dev, mem);
+	addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(addr)) {
 		err = -EBUSY;
 		goto exit;
-- 
2.7.4
