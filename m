From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [RFC: PATCH 3/5] can: sja1000_platform: replace DRV_NAME by KBUILD_MODNAME
Date: Fri,  5 Oct 2012 16:39:05 +0200
Message-ID: <1349447947-18451-4-git-send-email-mkl@pengutronix.de>
References: <1349447947-18451-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38401 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab2JEOjR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 5 Oct 2012 10:39:17 -0400
In-Reply-To: <1349447947-18451-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: andreas@gaisler.com, kernel@pengutronix.de, wg@grandegger.com, Marc Kleine-Budde <mkl@pengutronix.de>

This patch replaces DRV_NAME by KBUILD_MODNAME. DRV_NAME is removed from the
"dev_LEVEL()", as it already provides every relevant information.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000_platform.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000_platform.c b/drivers/net/can/sja1000/sja1000_platform.c
index 36300de..b0ce5ef 100644
--- a/drivers/net/can/sja1000/sja1000_platform.c
+++ b/drivers/net/can/sja1000/sja1000_platform.c
@@ -30,8 +30,6 @@
 
 #include "sja1000.h"
 
-#define DRV_NAME "sja1000_platform"
-
 MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
 MODULE_DESCRIPTION("Socket-CAN driver for SJA1000 on the platform bus");
 MODULE_LICENSE("GPL v2");
@@ -133,13 +131,13 @@ static int __devinit sp_probe(struct platform_device *pdev)
 
 	err = register_sja1000dev(dev);
 	if (err) {
-		dev_err(&pdev->dev, "registering %s failed (err=%d)\n",
-			DRV_NAME, err);
+		dev_err(&pdev->dev, "registering netdev failed (err=%d)\n",
+			err);
 		goto exit_free;
 	}
 
-	dev_info(&pdev->dev, "%s device registered (reg_base=%p, irq=%d)\n",
-		 DRV_NAME, priv->reg_base, dev->irq);
+	dev_info(&pdev->dev, "device registered (reg_base=%p, irq=%d)\n",
+		 priv->reg_base, dev->irq);
 	return 0;
 
  exit_free:
@@ -163,7 +161,7 @@ static struct platform_driver sp_driver = {
 	.probe = sp_probe,
 	.remove = __devexit_p(sp_remove),
 	.driver = {
-		.name = DRV_NAME,
+		.name = KBUILD_MODNAME,
 		.owner = THIS_MODULE,
 	},
 };
-- 
1.7.10

