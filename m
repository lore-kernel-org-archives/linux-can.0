From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 4/5] can: introduce the data bitrate configuration for CAN FD
Date: Sat, 15 Feb 2014 08:08:41 +0100
Message-ID: <1392448122-4689-4-git-send-email-socketcan@hartkopp.net>
References: <1392448122-4689-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:52595 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbaBOHIz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 15 Feb 2014 02:08:55 -0500
In-Reply-To: <1392448122-4689-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev.c            | 42 +++++++++++++++++++++++++++++++++++++++-
 include/linux/can/dev.h          |  6 ++++--
 include/uapi/linux/can/netlink.h |  2 ++
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 3a19333..a2b9bce 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -650,6 +650,10 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
 				= { .len = sizeof(struct can_bittiming_const) },
 	[IFLA_CAN_CLOCK]	= { .len = sizeof(struct can_clock) },
 	[IFLA_CAN_BERR_COUNTER]	= { .len = sizeof(struct can_berr_counter) },
+	[IFLA_CAN_DATA_BITTIMING]
+				= { .len = sizeof(struct can_bittiming) },
+	[IFLA_CAN_DATA_BITTIMING_CONST]
+				= { .len = sizeof(struct can_bittiming_const) },
 };
 
 static int can_changelink(struct net_device *dev,
@@ -683,6 +687,29 @@ static int can_changelink(struct net_device *dev,
 		}
 	}
 
+	if (data[IFLA_CAN_DATA_BITTIMING]) {
+		struct can_bittiming bt;
+
+		/* Do not allow changing bittiming while running */
+		if (dev->flags & IFF_UP)
+			return -EBUSY;
+		memcpy(&bt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
+		       sizeof(bt));
+		if ((!bt.bitrate && !bt.tq) || (bt.bitrate && bt.tq))
+			return -EINVAL;
+		err = can_get_bittiming(dev, &bt, priv->data_bittiming_const);
+		if (err)
+			return err;
+		memcpy(&priv->data_bittiming, &bt, sizeof(bt));
+
+		if (priv->do_set_data_bittiming) {
+			/* Finally, set the bit-timing registers */
+			err = priv->do_set_data_bittiming(dev);
+			if (err)
+				return err;
+		}
+	}
+
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm;
 
@@ -730,6 +757,10 @@ static size_t can_get_size(const struct net_device *dev)
 	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_RESTART_MS */
 	if (priv->do_get_berr_counter)				/* IFLA_CAN_BERR_COUNTER */
 		size += nla_total_size(sizeof(struct can_berr_counter));
+	if (priv->data_bittiming.bitrate)			/* IFLA_DATA_CAN_BITTIMING */
+		size += nla_total_size(sizeof(struct can_bittiming));
+	if (priv->data_bittiming_const)				/* IFLA_DATA_CAN_BITTIMING_CONST */
+		size += nla_total_size(sizeof(struct can_bittiming_const));
 
 	return size;
 }
@@ -759,8 +790,17 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
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
+		     sizeof(*priv->data_bittiming_const), priv->data_bittiming_const)))
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
1.9.0.rc3

