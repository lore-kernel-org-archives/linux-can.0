From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] can: mcp251x: Use dev_pm_ops
Date: Tue, 12 Mar 2013 13:13:53 +0100
Message-ID: <1363090433-11461-3-git-send-email-lars@metafoo.de>
References: <1363090433-11461-1-git-send-email-lars@metafoo.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp-out-038.synserver.de ([212.40.185.38]:1135 "EHLO
	smtp-out-038.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755143Ab3CLMSz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Mar 2013 08:18:55 -0400
In-Reply-To: <1363090433-11461-1-git-send-email-lars@metafoo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

Use dev_pm_ops instead of the deprecated legacy suspend/resume callbacks.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/net/can/mcp251x.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index 4dc7b9d..2b620c8 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -1138,9 +1138,11 @@ static int mcp251x_can_remove(struct spi_device *spi)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int mcp251x_can_suspend(struct spi_device *spi, pm_message_t state)
+#ifdef CONFIG_PM_SLEEP
+
+static int mcp251x_can_suspend(struct device *dev)
 {
+	struct spi_device *spi = to_spi_device(dev);
 	struct mcp251x_platform_data *pdata = spi->dev.platform_data;
 	struct mcp251x_priv *priv = dev_get_drvdata(&spi->dev);
 	struct net_device *net = priv->net;
@@ -1170,8 +1172,9 @@ static int mcp251x_can_suspend(struct spi_device *spi, pm_message_t state)
 	return 0;
 }
 
-static int mcp251x_can_resume(struct spi_device *spi)
+static int mcp251x_can_resume(struct device *dev)
 {
+	struct spi_device *spi = to_spi_device(dev);
 	struct mcp251x_platform_data *pdata = spi->dev.platform_data;
 	struct mcp251x_priv *priv = dev_get_drvdata(&spi->dev);
 
@@ -1191,9 +1194,13 @@ static int mcp251x_can_resume(struct spi_device *spi)
 	enable_irq(spi->irq);
 	return 0;
 }
+
+static SIMPLE_DEV_PM_OPS(mcp251x_can_pm_ops, mcp251x_can_suspend,
+	mcp251x_can_resume);
+#define MCP251X_PM_OPS (&mcp251x_can_pm_ops)
+
 #else
-#define mcp251x_can_suspend NULL
-#define mcp251x_can_resume NULL
+#define MCP251X_PM_OPS NULL
 #endif
 
 static const struct spi_device_id mcp251x_id_table[] = {
@@ -1208,13 +1215,12 @@ static struct spi_driver mcp251x_can_driver = {
 	.driver = {
 		.name = DEVICE_NAME,
 		.owner = THIS_MODULE,
+		.pm = MCP251X_PM_OPS,
 	},
 
 	.id_table = mcp251x_id_table,
 	.probe = mcp251x_can_probe,
 	.remove = mcp251x_can_remove,
-	.suspend = mcp251x_can_suspend,
-	.resume = mcp251x_can_resume,
 };
 module_spi_driver(mcp251x_can_driver);
 
-- 
1.8.0

