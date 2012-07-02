From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/6] can: dev: fix sparse warning for can_restart
Date: Mon,  2 Jul 2012 14:40:21 +0200
Message-ID: <1341232825-4604-3-git-send-email-mkl@pengutronix.de>
References: <1341232825-4604-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57316 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab2GBMk3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Jul 2012 08:40:29 -0400
In-Reply-To: <1341232825-4604-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Make can_restart static to fix the following sparse warning:
drivers/net/can/dev.c:371:6: warning: symbol 'can_restart' was not
declared. Should it be static?

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 239e4dd..963e2cc 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -401,7 +401,7 @@ EXPORT_SYMBOL_GPL(can_free_echo_skb);
 /*
  * CAN device restart for bus-off recovery
  */
-void can_restart(unsigned long data)
+static void can_restart(unsigned long data)
 {
 	struct net_device *dev = (struct net_device *)data;
 	struct can_priv *priv = netdev_priv(dev);
-- 
1.7.10

