From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6/7] can: flexcan: flexcan_remove(): add missing netif_napi_del()
Date: Fri, 28 Feb 2014 23:06:28 +0100
Message-ID: <1393625189-5568-7-git-send-email-mkl@pengutronix.de>
References: <1393625189-5568-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43123 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbaB1WGf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Feb 2014 17:06:35 -0500
In-Reply-To: <1393625189-5568-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds the missing netif_napi_del() to the flexcan_remove() function.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 330b5b9..01c2e81 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1186,7 +1186,7 @@ static int flexcan_remove(struct platform_device *pdev)
 	struct net_device *dev = platform_get_drvdata(pdev);
 
 	unregister_flexcandev(dev);
-
+	netif_napi_del(&priv->napi);
 	free_candev(dev);
 
 	return 0;
-- 
1.9.0.rc3

