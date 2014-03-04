From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v10 5/7] can: introduce the data bitrate configuration for CAN FD
Date: Tue,  4 Mar 2014 21:44:13 +0100
Message-ID: <1393965855-3408-6-git-send-email-mkl@pengutronix.de>
References: <1393965855-3408-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54699 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932788AbaCDUoV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Mar 2014 15:44:21 -0500
In-Reply-To: <1393965855-3408-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Oliver Hartkopp <socketcan@hartkopp.net>

As CAN FD offers a second bitrate for the data section of the CAN frame the
infrastructure for storing and configuring this second bitrate is introduced.
Improved the readability of the if-statement by inserting some newlines.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Stephane Grosjean <s.grosjean@peak-system.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c            | 38 +++++++++++++++++++++++++++++++++++++-
 include/linux/can/dev.h          |  6 ++++--
 include/uapi/linux/can/netlink.h |  2 ++
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 8141290..3c30920 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -647,6 +647,10 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
 				= { .len = sizeof(struct can_bittiming_const) },
 	[IFLA_CAN_CLOCK]	= { .len = sizeof(struct can_clock) },
 	[IFLA_CAN_BERR_COUNTER]	= { .len = sizeof(struct can_berr_counter) },
+	[IFLA_CAN_DATA_BITTIMING]
+				= { .len = sizeof(struct can_bittiming) },
+	[IFLA_CAN_DATA_BITTIMING_CONST]
+				= { .len = sizeof(struct can_bittiming_const) },
 };
 
 static int can_changelink(struct net_device *dev,
@@ -678,6 +682,20 @@ static int can_changelink(struct net_device *dev,
 		}
 	}
 
+	if (data[IFLA_CAN_DATA_BITTIMING]) {
+		struct can_bittiming dbt;
+
+		/* Do not allow changing bittiming while running */
+		if (dev->flags & IFF_UP)
+			return -EBUSY;
+		memcpy(&dbt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
+		       sizeof(dbt));
+		err = can_get_bittiming(dev, &dbt, priv->data_bittiming_const);
+		if (err)
+			return err;
+		memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
+	}
+
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm;
 
@@ -725,6 +743,10 @@ static size_t can_get_size(const struct net_device *dev)
 	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_RESTART_MS */
 	if (priv->do_get_berr_counter)				/* IFLA_CAN_BERR_COUNTER */
 		size += nla_total_size(sizeof(struct can_berr_counter));
+	if (priv->data_bittiming.bitrate)			/* IFLA_CAN_DATA_BITTIMING */
+		size += nla_total_size(sizeof(struct can_bittiming));
+	if (priv->data_bittiming_const)				/* IFLA_CAN_DATA_BITTIMING_CONST */
+		size += nla_total_size(sizeof(struct can_bittiming_const));
 
 	return size;
 }
@@ -738,20 +760,34 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 	if (priv->do_get_state)
 		priv->do_get_state(dev, &state);
+
 	if ((priv->bittiming.bitrate &&
 	     nla_put(skb, IFLA_CAN_BITTIMING,
 		     sizeof(priv->bittiming), &priv->bittiming)) ||
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
-	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)))
+	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||
+
+	    (priv->data_bittiming.bitrate &&
+	     nla_put(skb, IFLA_CAN_DATA_BITTIMING,
+		     sizeof(priv->data_bittiming), &priv->data_bittiming)) ||
+
+	    (priv->data_bittiming_const &&
+	     nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
+		     sizeof(*priv->data_bittiming_const),
+		     priv->data_bittiming_const)))
 		return -EMSGSIZE;
+
 	return 0;
 }
 
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index dc5f902..8adaee9 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -33,8 +33,9 @@ enum can_mode {
 struct can_priv {
 	struct can_device_stats can_stats;
 
-	struct can_bittiming bittiming;
-	const struct can_bittiming_const *bittiming_const;
+	struct can_bittiming bittiming, data_bittiming;
+	const struct can_bittiming_const *bittiming_const,
+		*data_bittiming_const;
 	struct can_clock clock;
 
 	enum can_state state;
@@ -45,6 +46,7 @@ struct can_priv {
 	struct timer_list restart_timer;
 
 	int (*do_set_bittiming)(struct net_device *dev);
+	int (*do_set_data_bittiming)(struct net_device *dev);
 	int (*do_set_mode)(struct net_device *dev, enum can_mode mode);
 	int (*do_get_state)(const struct net_device *dev,
 			    enum can_state *state);
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index df944ed..b41933d 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -122,6 +122,8 @@ enum {
 	IFLA_CAN_RESTART_MS,
 	IFLA_CAN_RESTART,
 	IFLA_CAN_BERR_COUNTER,
+	IFLA_CAN_DATA_BITTIMING,
+	IFLA_CAN_DATA_BITTIMING_CONST,
 	__IFLA_CAN_MAX
 };
 
-- 
1.9.0

