From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [RFC: PATCH 2/5] can: sja1000_platform: convert ioremap_nocache to devm_request_and_ioremap
Date: Fri,  5 Oct 2012 16:39:04 +0200
Message-ID: <1349447947-18451-3-git-send-email-mkl@pengutronix.de>
References: <1349447947-18451-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38398 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885Ab2JEOjR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 5 Oct 2012 10:39:17 -0400
In-Reply-To: <1349447947-18451-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: andreas@gaisler.com, kernel@pengutronix.de, wg@grandegger.com, Marc Kleine-Budde <mkl@pengutronix.de>

This patch converts the "ioremap_nocache()" to "devm_request_and_ioremap()"
which does automatically cleanup.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000_platform.c |   25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/can/sja1000/sja1000_platform.c
index 80f0d67..36300de 100644
--- a/drivers/net/can/sja1000/sja1000_platform.c
+++ b/drivers/net/can/sja1000/sja1000_platform.c
@@ -89,22 +89,16 @@ static int __devinit sp_probe(struct platform_device *pdev)
 		goto exit;
 	}
 
-	if (!request_mem_region(res_mem->start, resource_size(res_mem),
-				DRV_NAME)) {
-		err = -EBUSY;
-		goto exit;
-	}
-
-	addr = ioremap_nocache(res_mem->start, resource_size(res_mem));
+	addr = devm_request_and_ioremap(&pdev->dev, res_mem);
 	if (!addr) {
 		err = -ENOMEM;
-		goto exit_release;
+		goto exit;
 	}
 
 	dev = alloc_sja1000dev(0);
 	if (!dev) {
 		err = -ENOMEM;
-		goto exit_iounmap;
+		goto exit;
 	}
 	priv = netdev_priv(dev);
 
@@ -150,10 +144,6 @@ static int __devinit sp_probe(struct platform_device *pdev)
 
  exit_free:
 	free_sja1000dev(dev);
- exit_iounmap:
-	iounmap(addr);
- exit_release:
-	release_mem_region(res_mem->start, resource_size(res_mem));
  exit:
 	return err;
 }
@@ -161,18 +151,9 @@ static int __devinit sp_probe(struct platform_device *pdev)
 static int __devexit sp_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = dev_get_drvdata(&pdev->dev);
-	struct sja1000_priv *priv = netdev_priv(dev);
-	struct resource *res;
 
 	unregister_sja1000dev(dev);
 	dev_set_drvdata(&pdev->dev, NULL);
-
-	if (priv->reg_base)
-		iounmap(priv->reg_base);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
 	free_sja1000dev(dev);
 
 	return 0;
-- 
1.7.10

