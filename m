From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/7] can: dev: sort can_get_size() by IFLA_CAN_*
Date: Mon,  7 Oct 2013 16:40:35 +0200
Message-ID: <1381156840-24071-3-git-send-email-mkl@pengutronix.de>
References: <1381156840-24071-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33012 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438Ab3JGOkq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Oct 2013 10:40:46 -0400
In-Reply-To: <1381156840-24071-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

This patch sorts the individual addends of the sum by IFLA_CAN_*.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 1870c47..19ebab0 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -702,17 +702,17 @@ static int can_changelink(struct net_device *dev,
 static size_t can_get_size(const struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
-	size_t size;
-
-	size = nla_total_size(sizeof(u32));   /* IFLA_CAN_STATE */
-	size += nla_total_size(sizeof(struct can_ctrlmode));  /* IFLA_CAN_CTRLMODE */
-	size += nla_total_size(sizeof(u32));  /* IFLA_CAN_RESTART_MS */
-	size += nla_total_size(sizeof(struct can_bittiming)); /* IFLA_CAN_BITTIMING */
-	size += nla_total_size(sizeof(struct can_clock));     /* IFLA_CAN_CLOCK */
-	if (priv->do_get_berr_counter)        /* IFLA_CAN_BERR_COUNTER */
-		size += nla_total_size(sizeof(struct can_berr_counter));
-	if (priv->bittiming_const)	      /* IFLA_CAN_BITTIMING_CONST */
+	size_t size = 0;
+
+	size += nla_total_size(sizeof(struct can_bittiming));	/* IFLA_CAN_BITTIMING */
+	if (priv->bittiming_const)				/* IFLA_CAN_BITTIMING_CONST */
 		size += nla_total_size(sizeof(struct can_bittiming_const));
+	size += nla_total_size(sizeof(struct can_clock));	/* IFLA_CAN_CLOCK */
+	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_STATE */
+	size += nla_total_size(sizeof(struct can_ctrlmode));	/* IFLA_CAN_CTRLMODE */
+	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_RESTART_MS */
+	if (priv->do_get_berr_counter)				/* IFLA_CAN_BERR_COUNTER */
+		size += nla_total_size(sizeof(struct can_berr_counter));
 
 	return size;
 }
-- 
1.8.4.rc3

