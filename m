From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: c_can: fix error checking of priv->instance in probe()
Date: Wed, 21 Aug 2013 11:48:28 +0200
Message-ID: <1377078508-26713-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39721 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928Ab3HUJsb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Aug 2013 05:48:31 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: gang.chen@asianux.com, anilkumar@ti.com, tony@atomide.com, jg1.han@samsung.com, Marc Kleine-Budde <mkl@pengutronix.de>

From: Chen Gang <gang.chen@asianux.com>

This patch adds a type cast from 'unsigned int' to 'int'.

'priv->instance' may less than zero, so need a type cast, the related
warnings (allmodconfig, "EXTRA_CFLAGS=-W"):

  drivers/net/can/c_can/c_can_platform.c:198:3: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]

Signed-off-by: Chen Gang <gang.chen@asianux.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello Chen Gang,

I've tweaked the commit message a bit. If there a no complains the patch will
be included in my next pull request to David.

Marc

 drivers/net/can/c_can/c_can_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index c6f838d..294ced3 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -195,7 +195,7 @@ static int c_can_plat_probe(struct platform_device *pdev)
 
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 		priv->raminit_ctrlreg = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(priv->raminit_ctrlreg) || priv->instance < 0)
+		if (IS_ERR(priv->raminit_ctrlreg) || (int)priv->instance < 0)
 			dev_info(&pdev->dev, "control memory is not used for raminit\n");
 		else
 			priv->raminit = c_can_hw_raminit;
-- 
1.8.3.1

