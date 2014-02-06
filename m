From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v4 1/5] can: sja1000: convert printk to use netdev API
Date: Thu,  6 Feb 2014 12:09:52 +0100
Message-ID: <1391684996-612-2-git-send-email-mkl@pengutronix.de>
References: <1391684996-612-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46249 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034AbaBFLJ7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Feb 2014 06:09:59 -0500
In-Reply-To: <1391684996-612-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Florian Vaussard <florian.vaussard@epfl.ch>

Use netdev_* where applicable.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/sja1000/sja1000.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index f17c301..55cce47 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -106,8 +106,7 @@ static int sja1000_probe_chip(struct net_device *dev)
 	struct sja1000_priv *priv = netdev_priv(dev);
 
 	if (priv->reg_base && sja1000_is_absent(priv)) {
-		printk(KERN_INFO "%s: probing @0x%lX failed\n",
-		       DRV_NAME, dev->base_addr);
+		netdev_err(dev, "probing failed\n");
 		return 0;
 	}
 	return -1;
-- 
1.8.5.3

