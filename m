From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 03/12] can: flexcan: remove write-only member pdata of struct flexcan_priv
Date: Mon,  4 Jul 2016 20:32:08 +0200
Message-ID: <1467657137-18891-4-git-send-email-mkl@pengutronix.de>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36507 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750920AbcGDScW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 4 Jul 2016 14:32:22 -0400
In-Reply-To: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

This patch removes the write only member pdata from the struct
flexcan_priv.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 41c0fc9f3b14..dea2bf27cfc4 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -257,7 +257,6 @@ struct flexcan_priv {
 
 	struct clk *clk_ipg;
 	struct clk *clk_per;
-	struct flexcan_platform_data *pdata;
 	const struct flexcan_devtype_data *devtype_data;
 	struct regulator *reg_xceiver;
 };
@@ -1223,7 +1222,6 @@ static int flexcan_probe(struct platform_device *pdev)
 	priv->regs = regs;
 	priv->clk_ipg = clk_ipg;
 	priv->clk_per = clk_per;
-	priv->pdata = dev_get_platdata(&pdev->dev);
 	priv->devtype_data = devtype_data;
 	priv->reg_xceiver = reg_xceiver;
 
-- 
2.8.1

