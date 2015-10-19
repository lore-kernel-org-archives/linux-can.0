From: Heiko Schocher <hs@denx.de>
Subject: [PATCH] net, can, ti_hecc: fix a run time warn_on.
Date: Mon, 19 Oct 2015 08:22:18 +0200
Message-ID: <1445235739-26537-1-git-send-email-hs@denx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:34387 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbbJSGWY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 19 Oct 2015 02:22:24 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Heiko Schocher <hs@denx.de>, netdev@vger.kernel.org, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

This patch fixes a warning in clk_enable by calling
clk_prepare_enable instead.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 drivers/net/can/ti_hecc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index cf345cb..c08e8ea 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -951,7 +951,7 @@ static int ti_hecc_probe(struct platform_device *pdev)
 	netif_napi_add(ndev, &priv->napi, ti_hecc_rx_poll,
 		HECC_DEF_NAPI_WEIGHT);
 
-	clk_enable(priv->clk);
+	clk_prepare_enable(priv->clk);
 	err = register_candev(ndev);
 	if (err) {
 		dev_err(&pdev->dev, "register_candev() failed\n");
-- 
2.1.0

