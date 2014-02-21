From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v4 2/7] can: netlink send bittiming data only when a bitrate is available
Date: Fri, 21 Feb 2014 19:57:00 +0100
Message-ID: <1393009025-4903-3-git-send-email-socketcan@hartkopp.net>
References: <1393009025-4903-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:57818 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbaBUS5U (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 21 Feb 2014 13:57:20 -0500
In-Reply-To: <1393009025-4903-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is also a preparation for the CAN FD specific bittiming configurations
which are not existing in non-FD drivers.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index e1a3741..9f99255 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -719,7 +719,8 @@ static size_t can_get_size(const struct net_device *dev)
 	struct can_priv *priv = netdev_priv(dev);
 	size_t size = 0;
 
-	size += nla_total_size(sizeof(struct can_bittiming));	/* IFLA_CAN_BITTIMING */
+	if (priv->bittiming.bitrate)				/* IFLA_CAN_BITTIMING */
+		size += nla_total_size(sizeof(struct can_bittiming));
 	if (priv->bittiming_const)				/* IFLA_CAN_BITTIMING_CONST */
 		size += nla_total_size(sizeof(struct can_bittiming_const));
 	size += nla_total_size(sizeof(struct can_clock));	/* IFLA_CAN_CLOCK */
@@ -741,15 +742,20 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 	if (priv->do_get_state)
 		priv->do_get_state(dev, &state);
-	if (nla_put(skb, IFLA_CAN_BITTIMING,
-		    sizeof(priv->bittiming), &priv->bittiming) ||
+
+	if ((priv->bittiming.bitrate &&
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
1.9.0

