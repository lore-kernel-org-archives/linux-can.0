From: Aaron Wu <Aaron.wu@analog.com>
Subject: [PATCH V5 2/3] bfin_can: rewrite the driver into common style with MMU
Date: Thu, 5 Feb 2015 18:44:26 +0800
Message-ID: <1423133067-17289-2-git-send-email-Aaron.wu@analog.com>
References: <1423133067-17289-1-git-send-email-Aaron.wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1on0077.outbound.protection.outlook.com ([157.56.110.77]:21241
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757086AbbBEKxm (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 5 Feb 2015 05:53:42 -0500
In-Reply-To: <1423133067-17289-1-git-send-email-Aaron.wu@analog.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, linux-devel@analog.com
Cc: Aaron Wu <Aaron.wu@analog.com>

Rewrite the blackfin CAN driver into more common style in three ways:
part 1/3: rewrite blackfin style of read/write into common readw/writew
part 2/3: introduce ioremap to be compitable with MMU enabled arch
part 3/3: merge the header file from the blackfin arch dependent
location to driver code directly, note the original copy of more completed
bfin_can.h in arch depentdent location is reserved for reg test purpose

V5 changes: merge contents of header file into drivere code in patch 3/3
V4 changes: remove unused variable in patch 2/3
V3 changes: remove redundant cast in patch 2/3
V2 changes: split patch into two parts
V1 changes: rewrite code into common style

Signed-off-by: Aaron Wu <Aaron.wu@analog.com>
---
 drivers/net/can/bfin_can.c |   22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/bfin_can.c b/drivers/net/can/bfin_can.c
index 0a5eff4..0209c14 100644
--- a/drivers/net/can/bfin_can.c
+++ b/drivers/net/can/bfin_can.c
@@ -551,16 +551,10 @@ static int bfin_can_probe(struct platform_device *pdev)
 		goto exit;
 	}
 
-	if (!request_mem_region(res_mem->start, resource_size(res_mem),
-				dev_name(&pdev->dev))) {
-		err = -EBUSY;
-		goto exit;
-	}
-
 	/* request peripheral pins */
 	err = peripheral_request_list(pdata, dev_name(&pdev->dev));
 	if (err)
-		goto exit_mem_release;
+		goto exit;
 
 	dev = alloc_bfin_candev();
 	if (!dev) {
@@ -569,7 +563,13 @@ static int bfin_can_probe(struct platform_device *pdev)
 	}
 
 	priv = netdev_priv(dev);
-	priv->membase = (void __iomem *)res_mem->start;
+
+	priv->membase = devm_ioremap_resource(&pdev->dev, res_mem);
+	if (IS_ERR(priv->membase)) {
+		dev_err(&pdev->dev, "Cannot map IO\n");
+		return PTR_ERR(priv->membase);
+	}
+
 	priv->rx_irq = rx_irq->start;
 	priv->tx_irq = tx_irq->start;
 	priv->err_irq = err_irq->start;
@@ -601,8 +601,6 @@ exit_candev_free:
 	free_candev(dev);
 exit_peri_pin_free:
 	peripheral_free_list(pdata);
-exit_mem_release:
-	release_mem_region(res_mem->start, resource_size(res_mem));
 exit:
 	return err;
 }
@@ -611,15 +609,11 @@ static int bfin_can_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 	struct bfin_can_priv *priv = netdev_priv(dev);
-	struct resource *res;
 
 	bfin_can_set_reset_mode(dev);
 
 	unregister_candev(dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
 	peripheral_free_list(priv->pin_list);
 
 	free_candev(dev);
-- 
1.7.9.5

