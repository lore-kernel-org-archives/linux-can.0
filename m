From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [RFC: PATCH 1/5] can: sja1000_platform: add __dev{init,exit} annotations
Date: Fri,  5 Oct 2012 16:39:03 +0200
Message-ID: <1349447947-18451-2-git-send-email-mkl@pengutronix.de>
References: <1349447947-18451-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38395 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab2JEOjR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 5 Oct 2012 10:39:17 -0400
In-Reply-To: <1349447947-18451-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: andreas@gaisler.com, kernel@pengutronix.de, wg@grandegger.com, Marc Kleine-Budde <mkl@pengutronix.de>

This patch add "__devinit", "__devexit" and "__devexit_p" annotations to the
sja1000_platform driver.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000_platform.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/can/sja1000/sja1000_platform.c
index 662c5f7..80f0d67 100644
--- a/drivers/net/can/sja1000/sja1000_platform.c
+++ b/drivers/net/can/sja1000/sja1000_platform.c
@@ -66,7 +66,7 @@ static void sp_write_reg32(const struct sja1000_priv *priv, int reg, u8 val)
 	iowrite8(val, priv->reg_base + reg * 4);
 }
 
-static int sp_probe(struct platform_device *pdev)
+static int __devinit sp_probe(struct platform_device *pdev)
 {
 	int err;
 	void __iomem *addr;
@@ -158,7 +158,7 @@ static int sp_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int sp_remove(struct platform_device *pdev)
+static int __devexit sp_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = dev_get_drvdata(&pdev->dev);
 	struct sja1000_priv *priv = netdev_priv(dev);
@@ -180,7 +180,7 @@ static int sp_remove(struct platform_device *pdev)
 
 static struct platform_driver sp_driver = {
 	.probe = sp_probe,
-	.remove = sp_remove,
+	.remove = __devexit_p(sp_remove),
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
-- 
1.7.10

