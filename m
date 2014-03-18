From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/2] can: c_can: free_c_can_dev(): add missing netif_napi_del()
Date: Tue, 18 Mar 2014 19:24:00 +0100
Message-ID: <1395167041-6618-2-git-send-email-mkl@pengutronix.de>
References: <1395167041-6618-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39991 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756914AbaCRSYH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Mar 2014 14:24:07 -0400
In-Reply-To: <1395167041-6618-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: tglx@linutronix.de, b.spranger@linutronix.de, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds the missing netif_napi_del() to the free_c_can_dev() function.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 951bfed..6c03731 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -1269,6 +1269,9 @@ EXPORT_SYMBOL_GPL(c_can_power_up);
 
 void free_c_can_dev(struct net_device *dev)
 {
+	struct c_can_priv *priv = netdev_priv(dev);
+
+	netif_napi_del(&priv->napi);
 	free_candev(dev);
 }
 EXPORT_SYMBOL_GPL(free_c_can_dev);
-- 
1.9.0.279.gdc9e3eb

