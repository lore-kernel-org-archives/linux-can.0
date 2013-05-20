From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] can: flexcan: Use SIMPLE_DEV_PM_OPS
Date: Mon, 20 May 2013 15:43:43 -0300
Message-ID: <1369075423-12792-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db8lp0186.outbound.messaging.microsoft.com ([213.199.154.186]:35691
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755999Ab3ETSnq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 20 May 2013 14:43:46 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Using SIMPLE_DEV_PM_OPS can make the code smaller and simpler.
    
Also change CONFIG_PM to CONFIG_PM_SLEEP.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/net/can/flexcan.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 4a40a18..d85d9ff 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1137,10 +1137,10 @@ static int flexcan_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int flexcan_suspend(struct platform_device *pdev, pm_message_t state)
+#ifdef CONFIG_PM_SLEEP
+static int flexcan_suspend(struct device *device)
 {
-	struct net_device *dev = platform_get_drvdata(pdev);
+	struct net_device *dev = dev_get_drvdata(device);
 	struct flexcan_priv *priv = netdev_priv(dev);
 
 	flexcan_chip_disable(priv);
@@ -1154,9 +1154,9 @@ static int flexcan_suspend(struct platform_device *pdev, pm_message_t state)
 	return 0;
 }
 
-static int flexcan_resume(struct platform_device *pdev)
+static int flexcan_resume(struct device *device)
 {
-	struct net_device *dev = platform_get_drvdata(pdev);
+	struct net_device *dev = dev_get_drvdata(device);
 	struct flexcan_priv *priv = netdev_priv(dev);
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
@@ -1168,21 +1168,19 @@ static int flexcan_resume(struct platform_device *pdev)
 
 	return 0;
 }
-#else
-#define flexcan_suspend NULL
-#define flexcan_resume NULL
-#endif
+#endif /* CONFIG_PM_SLEEP */
+
+static SIMPLE_DEV_PM_OPS(flexcan_pm_ops, flexcan_suspend, flexcan_resume);
 
 static struct platform_driver flexcan_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
+		.pm	= &flexcan_pm_ops,
 		.of_match_table = flexcan_of_match,
 	},
 	.probe = flexcan_probe,
 	.remove = flexcan_remove,
-	.suspend = flexcan_suspend,
-	.resume = flexcan_resume,
 	.id_table = flexcan_id_table,
 };
 
-- 
1.8.1.2


