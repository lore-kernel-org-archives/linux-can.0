From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/7] can: dev: sort can_fill_info() by IFLA_CAN_*
Date: Mon,  7 Oct 2013 16:40:36 +0200
Message-ID: <1381156840-24071-4-git-send-email-mkl@pengutronix.de>
References: <1381156840-24071-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33011 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab3JGOkq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Oct 2013 10:40:46 -0400
In-Reply-To: <1381156840-24071-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

This patch sorts the call to nla_put() by IFLA_CAN_*.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 19ebab0..8d6f721 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -726,23 +726,20 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 	if (priv->do_get_state)
 		priv->do_get_state(dev, &state);
-	if (nla_put_u32(skb, IFLA_CAN_STATE, state) ||
-	    nla_put(skb, IFLA_CAN_CTRLMODE, sizeof(cm), &cm) ||
-	    nla_put_u32(skb, IFLA_CAN_RESTART_MS, priv->restart_ms) ||
-	    nla_put(skb, IFLA_CAN_BITTIMING,
+	if (nla_put(skb, IFLA_CAN_BITTIMING,
 		    sizeof(priv->bittiming), &priv->bittiming) ||
+	    (priv->bittiming_const &&
+	     nla_put(skb, IFLA_CAN_BITTIMING_CONST,
+		     sizeof(*priv->bittiming_const), priv->bittiming_const)) ||
 	    nla_put(skb, IFLA_CAN_CLOCK, sizeof(cm), &priv->clock) ||
+	    nla_put_u32(skb, IFLA_CAN_STATE, state) ||
+	    nla_put(skb, IFLA_CAN_CTRLMODE, sizeof(cm), &cm) ||
+	    nla_put_u32(skb, IFLA_CAN_RESTART_MS, priv->restart_ms) ||
 	    (priv->do_get_berr_counter &&
 	     !priv->do_get_berr_counter(dev, &bec) &&
-	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||
-	    (priv->bittiming_const &&
-	     nla_put(skb, IFLA_CAN_BITTIMING_CONST,
-		     sizeof(*priv->bittiming_const), priv->bittiming_const)))
-		goto nla_put_failure;
+	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)))
+		return -EMSGSIZE;
 	return 0;
-
-nla_put_failure:
-	return -EMSGSIZE;
 }
 
 static size_t can_get_xstats_size(const struct net_device *dev)
-- 
1.8.4.rc3

