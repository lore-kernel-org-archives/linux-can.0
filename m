From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH net-next] can: ti_hecc: fix return value check in ti_hecc_probe()
Date: Tue, 25 Apr 2017 06:44:05 +0000
Message-ID: <20170425064405.3964-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32849 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S980899AbdDYGoM (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Apr 2017 02:44:12 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Anton Glukhov <anton.a.glukhov@gmail.com>, Yegor Yefremov <yegorslists@googlemail.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

In case of error, the function devm_ioremap_resource() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Fixes: dabf54dd1c63 ("can: ti_hecc: Convert TI HECC driver to DT only driver")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/can/ti_hecc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index b8aac53..4d49414 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -898,9 +898,9 @@ static int ti_hecc_probe(struct platform_device *pdev)
 	}
 
 	priv->base = devm_ioremap_resource(&pdev->dev, res);
-	if (!priv->base) {
+	if (IS_ERR(priv->base)) {
 		dev_err(&pdev->dev, "hecc ioremap failed\n");
-		return -ENOMEM;
+		return PTR_ERR(priv->base);
 	}
 
 	/* handle hecc-ram memory */
@@ -911,9 +911,9 @@ static int ti_hecc_probe(struct platform_device *pdev)
 	}
 
 	priv->hecc_ram = devm_ioremap_resource(&pdev->dev, res);
-	if (!priv->hecc_ram) {
+	if (IS_ERR(priv->hecc_ram)) {
 		dev_err(&pdev->dev, "hecc-ram ioremap failed\n");
-		return -ENOMEM;
+		return PTR_ERR(priv->hecc_ram);
 	}
 
 	/* handle mbx memory */
@@ -924,9 +924,9 @@ static int ti_hecc_probe(struct platform_device *pdev)
 	}
 
 	priv->mbx = devm_ioremap_resource(&pdev->dev, res);
-	if (!priv->mbx) {
+	if (IS_ERR(priv->mbx)) {
 		dev_err(&pdev->dev, "mbx ioremap failed\n");
-		return -ENOMEM;
+		return PTR_ERR(priv->mbx);
 	}
 
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);

