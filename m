From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] can: grcan: use devm_platform_ioremap_resource() to simplify code
Date: Mon, 30 Sep 2019 17:49:09 +0800
Message-ID: <20190930094909.49672-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-can.vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/can/grcan.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index b8f1f2b69dd3..378200b682fa 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -1652,7 +1652,6 @@ static int grcan_setup_netdev(struct platform_device *ofdev,
 static int grcan_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
-	struct resource *res;
 	u32 sysid, ambafreq;
 	int irq, err;
 	void __iomem *base;
@@ -1672,8 +1671,7 @@ static int grcan_probe(struct platform_device *ofdev)
 		goto exit_error;
 	}
 
-	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&ofdev->dev, res);
+	base = devm_platform_ioremap_resource(ofdev, 0);
 	if (IS_ERR(base)) {
 		err = PTR_ERR(base);
 		goto exit_error;
-- 
2.20.1
