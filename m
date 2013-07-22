From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v2 1/2] flexcan: Use devm_ioremap_resource()
Date: Mon, 22 Jul 2013 12:41:39 -0300
Message-ID: <1374507700-21575-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:56524 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755829Ab3GVPly (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 22 Jul 2013 11:41:54 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, festevam@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>

Using devm_ioremap_resource() can make the code simpler and smaller.

Also, place alloc_candev() after of_match_device() to make error handling
easier.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Place alloc_candev() after of_match_device()

 drivers/net/can/flexcan.c | 53 +++++++++++------------------------------------
 1 file changed, 12 insertions(+), 41 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 7b0be09..9ca27e2 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1001,7 +1001,6 @@ static int flexcan_probe(struct platform_device *pdev)
 	struct resource *mem;
 	struct clk *clk_ipg = NULL, *clk_per = NULL;
 	void __iomem *base;
-	resource_size_t mem_size;
 	int err, irq;
 	u32 clock_freq = 0;
 
@@ -1013,43 +1012,25 @@ static int flexcan_probe(struct platform_device *pdev)
 		clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 		if (IS_ERR(clk_ipg)) {
 			dev_err(&pdev->dev, "no ipg clock defined\n");
-			err = PTR_ERR(clk_ipg);
-			goto failed_clock;
+			return PTR_ERR(clk_ipg);
 		}
 		clock_freq = clk_get_rate(clk_ipg);
 
 		clk_per = devm_clk_get(&pdev->dev, "per");
 		if (IS_ERR(clk_per)) {
 			dev_err(&pdev->dev, "no per clock defined\n");
-			err = PTR_ERR(clk_per);
-			goto failed_clock;
+			return PTR_ERR(clk_per);
 		}
 	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
-	if (!mem || irq <= 0) {
-		err = -ENODEV;
-		goto failed_get;
-	}
-
-	mem_size = resource_size(mem);
-	if (!request_mem_region(mem->start, mem_size, pdev->name)) {
-		err = -EBUSY;
-		goto failed_get;
-	}
+	if (irq <= 0)
+		return -ENODEV;
 
-	base = ioremap(mem->start, mem_size);
-	if (!base) {
-		err = -ENOMEM;
-		goto failed_map;
-	}
-
-	dev = alloc_candev(sizeof(struct flexcan_priv), 1);
-	if (!dev) {
-		err = -ENOMEM;
-		goto failed_alloc;
-	}
+	base = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	of_id = of_match_device(flexcan_of_match, &pdev->dev);
 	if (of_id) {
@@ -1058,10 +1039,13 @@ static int flexcan_probe(struct platform_device *pdev)
 		devtype_data = (struct flexcan_devtype_data *)
 			pdev->id_entry->driver_data;
 	} else {
-		err = -ENODEV;
-		goto failed_devtype;
+		return -ENODEV;
 	}
 
+	dev = alloc_candev(sizeof(struct flexcan_priv), 1);
+	if (!dev)
+		return -ENOMEM;
+
 	dev->netdev_ops = &flexcan_netdev_ops;
 	dev->irq = irq;
 	dev->flags |= IFF_ECHO;
@@ -1104,28 +1088,15 @@ static int flexcan_probe(struct platform_device *pdev)
 	return 0;
 
  failed_register:
- failed_devtype:
 	free_candev(dev);
- failed_alloc:
-	iounmap(base);
- failed_map:
-	release_mem_region(mem->start, mem_size);
- failed_get:
- failed_clock:
 	return err;
 }
 
 static int flexcan_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
-	struct flexcan_priv *priv = netdev_priv(dev);
-	struct resource *mem;
 
 	unregister_flexcandev(dev);
-	iounmap(priv->base);
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mem->start, resource_size(mem));
 
 	free_candev(dev);
 
-- 
1.8.1.2


