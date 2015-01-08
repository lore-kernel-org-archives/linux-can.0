From: Aaron Wu <Aaron.wu@analog.com>
Subject: [PATCH V2 2/2] bfin_can: rewrite the driver to support the common
Date: Thu, 8 Jan 2015 14:57:34 +0800
Message-ID: <1420700254-22529-2-git-send-email-Aaron.wu@analog.com>
References: <1420700254-22529-1-git-send-email-Aaron.wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bl2on0082.outbound.protection.outlook.com ([65.55.169.82]:4704
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753017AbbAHHHN (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 8 Jan 2015 02:07:13 -0500
In-Reply-To: <1420700254-22529-1-git-send-email-Aaron.wu@analog.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de, wg@grandegger.com, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: adi-buildroot-devel@lists.sourceforge.net, Aaron Wu <Aaron.wu@analog.com>

Rewrite the driver to comply to common style with MMU 

Signed-off-by: Aaron Wu <Aaron.wu@analog.com>
---
 drivers/net/can/bfin_can.c |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/bfin_can.c b/drivers/net/can/bfin_can.c
index 0a5eff4..1d116a7 100644
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
+	if (IS_ERR((void *)priv->membase)) {
+		dev_err(&pdev->dev, "Cannot map IO\n");
+		return PTR_ERR((void *)priv->membase);
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
@@ -617,9 +615,6 @@ static int bfin_can_remove(struct platform_device *pdev)
 
 	unregister_candev(dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
 	peripheral_free_list(priv->pin_list);
 
 	free_candev(dev);
-- 
1.7.9.5

