From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] [RFCv2] can: add CAN interface termination API
Date: Sun,  8 Jan 2017 17:35:06 +0100
Message-ID: <20170108163506.30818-1-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:25396 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752816AbdAHQfR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 8 Jan 2017 11:35:17 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This patch adds a netlink interface to configure the CAN bus termination of
CAN interfaces.

Inside the driver an array of supported termination values is defined:

const u16 drvname_termination = { 60, 120, CAN_TERMINATION_DISABLED };

struct drvname_priv *priv;
priv = netdev_priv(dev);

priv->termination_const = &drvname_termination;
priv->termination_const_size = sizeof(drvname_termination);
priv->termination = CAN_TERMINATION_DISABLED;

And the funtion to set the value has to be defined:

priv->do_set_termination = drvname_set_termination;

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev.c            | 34 +++++++++++++++++++++++++++++++++-
 include/linux/can/dev.h          |  4 ++++
 include/uapi/linux/can/netlink.h |  5 +++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 8d6208c0b400..f98825f6ea2e 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -958,6 +958,27 @@ static int can_changelink(struct net_device *dev,
 		}
 	}
 
+	if (data[IFLA_CAN_TERMINATION]) {
+		u16 t = nla_get_u16(data[IFLA_CAN_TERMINATION]);
+		int num_t = priv->termination_const_size / sizeof(u16);
+		int i;
+
+		/* check whether given value is supported by the interface */
+		for (i = 0; i < num_t && t != priv->termination_const[i]; i++);
+		if (i >= num_t)
+			return -EINVAL;
+
+		if (priv->do_set_termination) {
+			/* Finally, set the termination */
+			err = priv->do_set_termination(dev, t);
+			if (err)
+				return err;
+
+			priv->termination = t;
+		} else
+			return -EOPNOTSUPP;
+	}
+
 	return 0;
 }
 
@@ -980,6 +1001,11 @@ static size_t can_get_size(const struct net_device *dev)
 		size += nla_total_size(sizeof(struct can_bittiming));
 	if (priv->data_bittiming_const)				/* IFLA_CAN_DATA_BITTIMING_CONST */
 		size += nla_total_size(sizeof(struct can_bittiming_const));
+	if (priv->termination_const &&
+	    priv->termination_const_size) {			/* IFLA_CAN_TERMINATION_CONST */
+		size += nla_total_size(priv->termination_const_size);
+		size += nla_total_size(sizeof(u16));		/* IFLA_CAN_TERMINATION */
+	}
 
 	return size;
 }
@@ -1018,7 +1044,13 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    (priv->data_bittiming_const &&
 	     nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
 		     sizeof(*priv->data_bittiming_const),
-		     priv->data_bittiming_const)))
+		     priv->data_bittiming_const)) ||
+
+	    (priv->termination_const && priv->termination_const_size &&
+	     nla_put(skb, IFLA_CAN_TERMINATION_CONST,
+		     priv->termination_const_size,
+		     priv->termination_const) &&
+	     nla_put_u16(skb, IFLA_CAN_TERMINATION, priv->termination)))
 		return -EMSGSIZE;
 
 	return 0;
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 5f5270941ba0..7aa0eb1a75e3 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -38,6 +38,9 @@ struct can_priv {
 	struct can_bittiming bittiming, data_bittiming;
 	const struct can_bittiming_const *bittiming_const,
 		*data_bittiming_const;
+	const u16 *termination_const;
+	const int termination_const_size;
+	u16 termination;
 	struct can_clock clock;
 
 	enum can_state state;
@@ -53,6 +56,7 @@ struct can_priv {
 	int (*do_set_bittiming)(struct net_device *dev);
 	int (*do_set_data_bittiming)(struct net_device *dev);
 	int (*do_set_mode)(struct net_device *dev, enum can_mode mode);
+	int (*do_set_termination)(struct net_device *dev, u16 term);
 	int (*do_get_state)(const struct net_device *dev,
 			    enum can_state *state);
 	int (*do_get_berr_counter)(const struct net_device *dev,
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 94ffe0c83ce7..7414771926fb 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -127,9 +127,14 @@ enum {
 	IFLA_CAN_BERR_COUNTER,
 	IFLA_CAN_DATA_BITTIMING,
 	IFLA_CAN_DATA_BITTIMING_CONST,
+	IFLA_CAN_TERMINATION,
+	IFLA_CAN_TERMINATION_CONST,
 	__IFLA_CAN_MAX
 };
 
 #define IFLA_CAN_MAX	(__IFLA_CAN_MAX - 1)
 
+/* u16 termination range: 1..65535 Ohms */
+#define CAN_TERMINATION_DISABLED 0
+
 #endif /* !_UAPI_CAN_NETLINK_H */
-- 
2.11.0

