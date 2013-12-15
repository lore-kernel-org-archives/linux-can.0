From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH v2 1/2] can: mcp251x: Convert to devm-* API
Date: Sun, 15 Dec 2013 18:16:00 +0400
Message-ID: <1387116961-15261-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp12.mail.ru ([94.100.176.89]:46373 "EHLO smtp12.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487Ab3LOOQW (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 15 Dec 2013 09:16:22 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: devicetree@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Alexander Shiyan <shc_work@mail.ru>

Replace existing resource handling in the driver with managed
device resource, this ensures more consistent error values and
simplifies error paths.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/net/can/mcp251x.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index 08ac401..7a35729 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -1067,15 +1067,17 @@ static int mcp251x_can_probe(struct spi_device *spi)
 
 	/* Allocate non-DMA buffers */
 	if (!mcp251x_enable_dma) {
-		priv->spi_tx_buf = kmalloc(SPI_TRANSFER_BUF_LEN, GFP_KERNEL);
+		priv->spi_tx_buf = devm_kzalloc(&spi->dev, SPI_TRANSFER_BUF_LEN,
+						GFP_KERNEL);
 		if (!priv->spi_tx_buf) {
 			ret = -ENOMEM;
-			goto error_tx_buf;
+			goto error_probe;
 		}
-		priv->spi_rx_buf = kmalloc(SPI_TRANSFER_BUF_LEN, GFP_KERNEL);
+		priv->spi_rx_buf = devm_kzalloc(&spi->dev, SPI_TRANSFER_BUF_LEN,
+						GFP_KERNEL);
 		if (!priv->spi_rx_buf) {
 			ret = -ENOMEM;
-			goto error_rx_buf;
+			goto error_probe;
 		}
 	}
 
@@ -1108,12 +1110,6 @@ static int mcp251x_can_probe(struct spi_device *spi)
 	return ret;
 
 error_probe:
-	if (!mcp251x_enable_dma)
-		kfree(priv->spi_rx_buf);
-error_rx_buf:
-	if (!mcp251x_enable_dma)
-		kfree(priv->spi_tx_buf);
-error_tx_buf:
 	if (mcp251x_enable_dma)
 		dma_free_coherent(&spi->dev, PAGE_SIZE,
 				  priv->spi_tx_buf, priv->spi_tx_dma);
@@ -1136,9 +1132,6 @@ static int mcp251x_can_remove(struct spi_device *spi)
 	if (mcp251x_enable_dma) {
 		dma_free_coherent(&spi->dev, PAGE_SIZE,
 				  priv->spi_tx_buf, priv->spi_tx_dma);
-	} else {
-		kfree(priv->spi_tx_buf);
-		kfree(priv->spi_rx_buf);
 	}
 
 	mcp251x_power_enable(priv->power, 0);
-- 
1.8.3.2

