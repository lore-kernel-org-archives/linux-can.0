From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 2/4] can: netlink send bittiming data only when bittiming_const is available
Date: Fri, 14 Feb 2014 21:57:25 +0100
Message-ID: <1392411447-9105-2-git-send-email-socketcan@hartkopp.net>
References: <1392411447-9105-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:20669 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbaBNU5i (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 14 Feb 2014 15:57:38 -0500
In-Reply-To: <1392411447-9105-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

The bittiming information is only valid when the CAN driver has a valid
structure of bittiming_const. Therefore provide the information of the
bittiming only when bittiming_const exists.

This is also a preparation for the CAN FD specific bittiming_const structure
which is not existing in non-FD drivers. Therefore all the CAN FD bittiming
stuff has to be disabled when the CAN FD specific bittiming_const structure is
missing.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index e1a3741..b0b950f 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -719,9 +719,10 @@ static size_t can_get_size(const struct net_device *dev)
 	struct can_priv *priv = netdev_priv(dev);
 	size_t size = 0;
 
-	size += nla_total_size(sizeof(struct can_bittiming));	/* IFLA_CAN_BITTIMING */
-	if (priv->bittiming_const)				/* IFLA_CAN_BITTIMING_CONST */
+	if (priv->bittiming_const) { /* IFLA_CAN_BITTIMING[_CONST] */
+		size += nla_total_size(sizeof(struct can_bittiming));
 		size += nla_total_size(sizeof(struct can_bittiming_const));
+	}
 	size += nla_total_size(sizeof(struct can_clock));	/* IFLA_CAN_CLOCK */
 	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_STATE */
 	size += nla_total_size(sizeof(struct can_ctrlmode));	/* IFLA_CAN_CTRLMODE */
@@ -741,15 +742,20 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 	if (priv->do_get_state)
 		priv->do_get_state(dev, &state);
-	if (nla_put(skb, IFLA_CAN_BITTIMING,
-		    sizeof(priv->bittiming), &priv->bittiming) ||
+
+	if ((priv->bittiming_const &&
+	     nla_put(skb, IFLA_CAN_BITTIMING,
+		     sizeof(priv->bittiming), &priv->bittiming)) ||
+
 	    (priv->bittiming_const &&
 	     nla_put(skb, IFLA_CAN_BITTIMING_CONST,
 		     sizeof(*priv->bittiming_const), priv->bittiming_const)) ||
+
 	    nla_put(skb, IFLA_CAN_CLOCK, sizeof(cm), &priv->clock) ||
 	    nla_put_u32(skb, IFLA_CAN_STATE, state) ||
 	    nla_put(skb, IFLA_CAN_CTRLMODE, sizeof(cm), &cm) ||
 	    nla_put_u32(skb, IFLA_CAN_RESTART_MS, priv->restart_ms) ||
+
 	    (priv->do_get_berr_counter &&
 	     !priv->do_get_berr_counter(dev, &bec) &&
 	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)))
-- 
1.9.0.rc3

