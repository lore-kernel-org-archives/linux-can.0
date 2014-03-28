From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 4/4] can: mcp251x: Remove unnecessary power disabling
Date: Fri, 28 Mar 2014 14:14:47 +0400
Message-ID: <1396001687-7092-4-git-send-email-shc_work@mail.ru>
References: <1396001687-7092-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fallback6.mail.ru ([94.100.176.134]:34458 "EHLO
	fallback6.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbaC1KPV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Mar 2014 06:15:21 -0400
Received: from smtp11.mail.ru (smtp11.mail.ru [94.100.176.85])
	by fallback6.mail.ru (mPOP.Fallback_MX) with ESMTP id F0D9837B4DE8
	for <linux-can@vger.kernel.org>; Fri, 28 Mar 2014 14:15:18 +0400 (MSK)
In-Reply-To: <1396001687-7092-1-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>

This patch remove unnecessary power disabling on error and on module
exit since this is already done by regulator API.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/net/can/mcp251x.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index f4786c8..54a57b0 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -1151,7 +1151,6 @@ error_probe:
 	if (mcp251x_enable_dma)
 		dma_free_coherent(&spi->dev, PAGE_SIZE,
 				  priv->spi_tx_buf, priv->spi_tx_dma);
-	mcp251x_power_enable(priv->power, 0);
 
 out_clk:
 	if (!IS_ERR(clk))
@@ -1175,8 +1174,6 @@ static int mcp251x_can_remove(struct spi_device *spi)
 				  priv->spi_tx_buf, priv->spi_tx_dma);
 	}
 
-	mcp251x_power_enable(priv->power, 0);
-
 	if (!IS_ERR(priv->clk))
 		clk_disable_unprepare(priv->clk);
 
-- 
1.8.3.2

