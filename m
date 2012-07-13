From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/2] can: mpc5xxx_can: make data in mpc5xxx_can_probe const
Date: Fri, 13 Jul 2012 15:04:24 +0200
Message-ID: <1342184664-10720-3-git-send-email-mkl@pengutronix.de>
References: <1342184664-10720-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50411 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756629Ab2GMNE3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Jul 2012 09:04:29 -0400
In-Reply-To: <1342184664-10720-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/mscan/mpc5xxx_can.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
index 5caa572..06adf88 100644
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -251,7 +251,7 @@ static struct of_device_id mpc5xxx_can_table[];
 static int __devinit mpc5xxx_can_probe(struct platform_device *ofdev)
 {
 	const struct of_device_id *match;
-	struct mpc5xxx_can_data *data;
+	const struct mpc5xxx_can_data *data;
 	struct device_node *np = ofdev->dev.of_node;
 	struct net_device *dev;
 	struct mscan_priv *priv;
-- 
1.7.10

