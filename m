From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/6] can: cc770: fix sparse warning for cc770_interrupt
Date: Mon,  2 Jul 2012 14:40:20 +0200
Message-ID: <1341232825-4604-2-git-send-email-mkl@pengutronix.de>
References: <1341232825-4604-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57314 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467Ab2GBMk3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Jul 2012 08:40:29 -0400
In-Reply-To: <1341232825-4604-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Make cc770_interrupt static to fix the following sparse warning:
drivers/net/can/cc770/cc770.c:699:13: warning: symbol
'cc770_interrupt' was not declared. Should it be static?

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/cc770/cc770.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index d42a6a7..a138db1 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -695,7 +695,7 @@ static void cc770_tx_interrupt(struct net_device *dev, unsigned int o)
 	netif_wake_queue(dev);
 }
 
-irqreturn_t cc770_interrupt(int irq, void *dev_id)
+static irqreturn_t cc770_interrupt(int irq, void *dev_id)
 {
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct cc770_priv *priv = netdev_priv(dev);
-- 
1.7.10

