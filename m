From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/3] can: dev: remove do_get_state() form can_fill_info()
Date: Mon,  7 Oct 2013 16:46:07 +0200
Message-ID: <1381157168-24588-3-git-send-email-mkl@pengutronix.de>
References: <1381157168-24588-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51926 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755477Ab3JGOqP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Oct 2013 10:46:15 -0400
In-Reply-To: <1381157168-24588-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

As there is no driver that implements do_get_state(), remove the call from
can_fill_info().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index f9cba41..54eca2f 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -724,8 +724,6 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	struct can_berr_counter bec;
 	enum can_state state = priv->state;
 
-	if (priv->do_get_state)
-		priv->do_get_state(dev, &state);
 	if (nla_put_u32(skb, IFLA_CAN_STATE, state) ||
 	    nla_put(skb, IFLA_CAN_CTRLMODE, sizeof(cm), &cm) ||
 	    nla_put_u32(skb, IFLA_CAN_RESTART_MS, priv->restart_ms) ||
-- 
1.8.4.rc3

