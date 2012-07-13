From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/2] can: flexcan: make flexcan_priv.devtype_data member point to const data
Date: Fri, 13 Jul 2012 15:04:23 +0200
Message-ID: <1342184664-10720-2-git-send-email-mkl@pengutronix.de>
References: <1342184664-10720-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50410 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756534Ab2GMNE3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Jul 2012 09:04:29 -0400
In-Reply-To: <1342184664-10720-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 81324a1..1b6f562 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -192,7 +192,7 @@ struct flexcan_priv {
 
 	struct clk *clk;
 	struct flexcan_platform_data *pdata;
-	struct flexcan_devtype_data *devtype_data;
+	const struct flexcan_devtype_data *devtype_data;
 };
 
 static struct flexcan_devtype_data fsl_p1010_devtype_data = {
@@ -960,7 +960,7 @@ static const struct platform_device_id flexcan_id_table[] = {
 static int __devinit flexcan_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id;
-	struct flexcan_devtype_data *devtype_data;
+	const struct flexcan_devtype_data *devtype_data;
 	struct net_device *dev;
 	struct flexcan_priv *priv;
 	struct resource *mem;
-- 
1.7.10

