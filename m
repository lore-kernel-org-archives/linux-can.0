From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] can: xilinx_can: use devm_platform_ioremap_resource() to simplify code
Date: Tue, 15 Oct 2019 22:26:19 +0800
Message-ID: <20191015142619.17148-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, michal.simek@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-can.vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/can/xilinx_can.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 911b343..5d45c50 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1652,7 +1652,6 @@ MODULE_DEVICE_TABLE(of, xcan_of_match);
  */
 static int xcan_probe(struct platform_device *pdev)
 {
-	struct resource *res; /* IO mem resources */
 	struct net_device *ndev;
 	struct xcan_priv *priv;
 	const struct of_device_id *of_id;
@@ -1664,8 +1663,7 @@ static int xcan_probe(struct platform_device *pdev)
 	const char *hw_tx_max_property;
 
 	/* Get the virtual base address for the device */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	addr = devm_ioremap_resource(&pdev->dev, res);
+	addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(addr)) {
 		ret = PTR_ERR(addr);
 		goto err;
-- 
2.7.4
