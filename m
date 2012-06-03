From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/4] can: cc770: Fix likely misuse of | for &
Date: Mon,  4 Jun 2012 00:22:00 +0200
Message-ID: <1338762120-12695-5-git-send-email-mkl@pengutronix.de>
References: <1338762120-12695-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55236 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006Ab2FCWWW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 3 Jun 2012 18:22:22 -0400
In-Reply-To: <1338762120-12695-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, Joe Perches <joe@perches.com>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Joe Perches <joe@perches.com>

Using | with a constant is always true.
Likely this should have be &.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/cc770/cc770_platform.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/can/cc770/cc770_platform.c b/drivers/net/can/cc770/cc770_platform.c
index 53115ee..688371c 100644
--- a/drivers/net/can/cc770/cc770_platform.c
+++ b/drivers/net/can/cc770/cc770_platform.c
@@ -154,7 +154,7 @@ static int __devinit cc770_get_platform_data(struct platform_device *pdev,
 	struct cc770_platform_data *pdata = pdev->dev.platform_data;
 
 	priv->can.clock.freq = pdata->osc_freq;
-	if (priv->cpu_interface | CPUIF_DSC)
+	if (priv->cpu_interface & CPUIF_DSC)
 		priv->can.clock.freq /= 2;
 	priv->clkout = pdata->cor;
 	priv->bus_config = pdata->bcr;
-- 
1.7.4.1

