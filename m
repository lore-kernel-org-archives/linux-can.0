From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 4/4] can: mcp251x: Remove unnecessary power disabling
Date: Tue,  1 Apr 2014 23:02:19 +0200
Message-ID: <1396386139-20238-5-git-send-email-mkl@pengutronix.de>
References: <1396386139-20238-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55440 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbaDAVCX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Apr 2014 17:02:23 -0400
In-Reply-To: <1396386139-20238-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Alexander Shiyan <shc_work@mail.ru>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Alexander Shiyan <shc_work@mail.ru>

This patch remove unnecessary power disabling on error and on module
exit since this is already done by regulator API.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

I'm not sure if this actually works.

Marc

 drivers/net/can/mcp251x.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index bc235f9..1e294977 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -1159,7 +1159,6 @@ error_probe:
 	if (mcp251x_enable_dma)
 		dma_free_coherent(&spi->dev, PAGE_SIZE,
 				  priv->spi_tx_buf, priv->spi_tx_dma);
-	mcp251x_power_enable(priv->power, 0);
 
 out_clk:
 	if (!IS_ERR(clk))
@@ -1183,8 +1182,6 @@ static int mcp251x_can_remove(struct spi_device *spi)
 				  priv->spi_tx_buf, priv->spi_tx_dma);
 	}
 
-	mcp251x_power_enable(priv->power, 0);
-
 	if (!IS_ERR(priv->clk))
 		clk_disable_unprepare(priv->clk);
 
-- 
1.9.0.279.gdc9e3eb

