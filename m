From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 1/4] can: mcp251x: Check return value of spi_setup()
Date: Tue,  1 Apr 2014 23:02:16 +0200
Message-ID: <1396386139-20238-2-git-send-email-mkl@pengutronix.de>
References: <1396386139-20238-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55434 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbaDAVCW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Apr 2014 17:02:22 -0400
In-Reply-To: <1396386139-20238-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Alexander Shiyan <shc_work@mail.ru>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Alexander Shiyan <shc_work@mail.ru>

This patch moves setup of SPI bus a bit earlier and adds check for spi_setup()
result to be sure SPI bus is communicating with the device properly.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/mcp251x.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index 28c11f8..356d3da 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -1032,8 +1032,8 @@ static int mcp251x_can_probe(struct spi_device *spi)
 	struct mcp251x_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct net_device *net;
 	struct mcp251x_priv *priv;
-	int freq, ret = -ENODEV;
 	struct clk *clk;
+	int freq, ret;
 
 	clk = devm_clk_get(&spi->dev, NULL);
 	if (IS_ERR(clk)) {
@@ -1076,6 +1076,18 @@ static int mcp251x_can_probe(struct spi_device *spi)
 	priv->net = net;
 	priv->clk = clk;
 
+	spi_set_drvdata(spi, priv);
+
+	/* Configure the SPI bus */
+	spi->bits_per_word = 8;
+	if (mcp251x_is_2510(spi))
+		spi->max_speed_hz = spi->max_speed_hz ? : 5 * 1000 * 1000;
+	else
+		spi->max_speed_hz = spi->max_speed_hz ? : 10 * 1000 * 1000;
+	ret = spi_setup(spi);
+	if (ret)
+		goto out_clk;
+
 	priv->power = devm_regulator_get(&spi->dev, "vdd");
 	priv->transceiver = devm_regulator_get(&spi->dev, "xceiver");
 	if ((PTR_ERR(priv->power) == -EPROBE_DEFER) ||
@@ -1088,8 +1100,6 @@ static int mcp251x_can_probe(struct spi_device *spi)
 	if (ret)
 		goto out_clk;
 
-	spi_set_drvdata(spi, priv);
-
 	priv->spi = spi;
 	mutex_init(&priv->mcp_lock);
 
@@ -1134,15 +1144,6 @@ static int mcp251x_can_probe(struct spi_device *spi)
 
 	SET_NETDEV_DEV(net, &spi->dev);
 
-	/* Configure the SPI bus */
-	spi->mode = spi->mode ? : SPI_MODE_0;
-	if (mcp251x_is_2510(spi))
-		spi->max_speed_hz = spi->max_speed_hz ? : 5 * 1000 * 1000;
-	else
-		spi->max_speed_hz = spi->max_speed_hz ? : 10 * 1000 * 1000;
-	spi->bits_per_word = 8;
-	spi_setup(spi);
-
 	/* Here is OK to not lock the MCP, no one knows about it yet */
 	if (!mcp251x_hw_probe(spi)) {
 		ret = -ENODEV;
-- 
1.9.0.279.gdc9e3eb

