From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6/7] can: dev: berr_limit netlink support for configuration
Date: Mon,  7 Oct 2013 16:40:39 +0200
Message-ID: <1381156840-24071-7-git-send-email-mkl@pengutronix.de>
References: <1381156840-24071-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33016 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab3JGOkr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Oct 2013 10:40:47 -0400
In-Reply-To: <1381156840-24071-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds add netlink support to configure the berr_limit delay via
netlink.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c            | 19 ++++++++++++++++++-
 include/uapi/linux/can/netlink.h |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 969d3cd..3119052 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -660,6 +660,7 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
 				= { .len = sizeof(struct can_bittiming_const) },
 	[IFLA_CAN_CLOCK]	= { .len = sizeof(struct can_clock) },
 	[IFLA_CAN_BERR_COUNTER]	= { .len = sizeof(struct can_berr_counter) },
+	[IFLA_CAN_BERR_LIMIT_MS]= { .type = NLA_MSECS },
 };
 
 static int can_changelink(struct net_device *dev,
@@ -722,6 +723,17 @@ static int can_changelink(struct net_device *dev,
 			return err;
 	}
 
+	if (data[IFLA_CAN_BERR_LIMIT_MS]) {
+		/* Do not allow changing berr limit delay while running */
+		if (!priv->do_berr_restart)
+			return -EOPNOTSUPP;
+		if (dev->flags & IFF_UP)
+			return -EBUSY;
+
+		priv->berr_limit_delay =
+			nla_get_msecs(data[IFLA_CAN_BERR_LIMIT_MS]);
+	}
+
 	return 0;
 }
 
@@ -739,6 +751,8 @@ static size_t can_get_size(const struct net_device *dev)
 	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_RESTART_MS */
 	if (priv->do_get_berr_counter)				/* IFLA_CAN_BERR_COUNTER */
 		size += nla_total_size(sizeof(struct can_berr_counter));
+	if (priv->do_berr_restart)				/* IFLA_CAN_BERR_LIMIT_MS */
+		size += nla_total_size(sizeof(u64));
 
 	return size;
 }
@@ -763,7 +777,10 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    nla_put_u32(skb, IFLA_CAN_RESTART_MS, priv->restart_ms) ||
 	    (priv->do_get_berr_counter &&
 	     !priv->do_get_berr_counter(dev, &bec) &&
-	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)))
+	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||
+	    (priv->do_berr_restart &&
+	     nla_put_msecs(skb, IFLA_CAN_BERR_LIMIT_MS,
+			   priv->berr_limit_delay)))
 		return -EMSGSIZE;
 	return 0;
 }
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index df944ed..71f750e 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -122,6 +122,7 @@ enum {
 	IFLA_CAN_RESTART_MS,
 	IFLA_CAN_RESTART,
 	IFLA_CAN_BERR_COUNTER,
+	IFLA_CAN_BERR_LIMIT_MS,
 	__IFLA_CAN_MAX
 };
 
-- 
1.8.4.rc3

