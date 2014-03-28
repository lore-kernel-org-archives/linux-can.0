From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/4] can: mcp251x: Check return value of spi_setup()
Date: Fri, 28 Mar 2014 14:14:44 +0400
Message-ID: <1396001687-7092-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fallback2.mail.ru ([94.100.176.87]:56626 "EHLO
	fallback6.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750901AbaC1KVi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Mar 2014 06:21:38 -0400
Received: from smtp11.mail.ru (smtp11.mail.ru [94.100.176.85])
	by fallback6.mail.ru (mPOP.Fallback_MX) with ESMTP id DA4F03534B68
	for <linux-can@vger.kernel.org>; Fri, 28 Mar 2014 14:15:12 +0400 (MSK)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>

This patch moves setup of SPI bus a bit earlier and adds check
for spi_setup() result to be sure SPI bus is communicated with the
device properly.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/net/can/mcp251x.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index 28c11f8..26879c7 100644
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
+		return ret;
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
1.8.3.2

