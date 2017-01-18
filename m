From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 03/16] can: flexcan: remove write-only member pdata of struct flexcan_priv
Date: Wed, 18 Jan 2017 15:52:14 +0100
Message-ID: <20170118145227.24916-4-mkl@pengutronix.de>
References: <20170118145227.24916-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38041 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751992AbdARPEU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2017 10:04:20 -0500
In-Reply-To: <20170118145227.24916-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Mirza Krak <mirza.krak@hostmobility.com>, Holger Schurig <holgerschurig@gmail.com>, alexander.stein@systec-electronic.com, Marc Kleine-Budde <mkl@pengutronix.de>

This patch removes the write only member pdata from the struct
flexcan_priv.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 16f7cadda5c3..4c3173f32114 100644
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
2.11.0

