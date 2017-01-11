From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: add CAN interface termination API
Date: Wed, 11 Jan 2017 16:27:58 +0100
Message-ID: <20170111152758.3578-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33145 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S937075AbdAKP2F (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2017 10:28:05 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Oliver Hartkopp <socketcan@hartkopp.net>

This patch adds a netlink interface to configure the CAN bus termination of
CAN interfaces.

Inside the driver an array of supported termination values is defined:

const u16 drvname_termination[] = { 60, 120, CAN_TERMINATION_DISABLED };

struct drvname_priv *priv;
priv = netdev_priv(dev);

priv->termination_const = &drvname_termination;
priv->termination_const_cnt = ARRAY_SIZE(drvname_termination);
priv->termination = CAN_TERMINATION_DISABLED;

And the funtion to set the value has to be defined:

priv->do_set_termination = drvname_set_termination;

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

picking up Oliver's work.

Changes since v3:
- can_changelink: use "const".
- register_candev: add consistency check for termination_const and termination_const_cnt
- can_get_size & can_fill_info: remove check for termination_const_cnt
- can_get_size: reorder to match IFLA_CAN_ enum.
- can_get_size & can_fill_info: convert sizeof(u16) to use appropriate member of struct can_priv.
- can_fill_info: use || to chain multiple nla_put.

 drivers/net/can/dev.c            | 48 +++++++++++++++++++++++++++++++++++++++-
 include/linux/can/dev.h          |  4 ++++
 include/uapi/linux/can/netlink.h |  5 +++++
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index c240cd9f823b..254183e5baf9 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -978,6 +978,30 @@ static int can_changelink(struct net_device *dev,
 		}
 	}
 
+	if (data[IFLA_CAN_TERMINATION]) {
+		const u16 termval = nla_get_u16(data[IFLA_CAN_TERMINATION]);
+		const int num_term = priv->termination_const_cnt;
+		int i;
+
+		if (!priv->do_set_termination)
+			return -EOPNOTSUPP;
+
+		/* check whether given value is supported by the interface */
+		for (i = 0; i < num_term; i++) {
+			if (termval == priv->termination_const[i])
+				break;
+		}
+		if (i >= num_term)
+			return -EINVAL;
+
+		/* Finally, set the termination value */
+		err = priv->do_set_termination(dev, termval);
+		if (err)
+			return err;
+
+		priv->termination = termval;
+	}
+
 	return 0;
 }
 
@@ -1000,6 +1024,11 @@ static size_t can_get_size(const struct net_device *dev)
 		size += nla_total_size(sizeof(struct can_bittiming));
 	if (priv->data_bittiming_const)				/* IFLA_CAN_DATA_BITTIMING_CONST */
 		size += nla_total_size(sizeof(struct can_bittiming_const));
+	if (priv->termination_const) {
+		size += nla_total_size(sizeof(priv->termination));		/* IFLA_CAN_TERMINATION */
+		size += nla_total_size(sizeof(*priv->termination_const) *	/* IFLA_CAN_TERMINATION_CONST */
+				       priv->termination_const_cnt);
+	}
 
 	return size;
 }
@@ -1038,7 +1067,15 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    (priv->data_bittiming_const &&
 	     nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
 		     sizeof(*priv->data_bittiming_const),
-		     priv->data_bittiming_const)))
+		     priv->data_bittiming_const)) ||
+
+	    (priv->termination_const &&
+	     (nla_put_u16(skb, IFLA_CAN_TERMINATION, priv->termination) ||
+	      nla_put(skb, IFLA_CAN_TERMINATION_CONST,
+		      sizeof(*priv->termination_const) *
+		      priv->termination_const_cnt,
+		      priv->termination_const))))
+
 		return -EMSGSIZE;
 
 	return 0;
@@ -1093,6 +1130,15 @@ static struct rtnl_link_ops can_link_ops __read_mostly = {
  */
 int register_candev(struct net_device *dev)
 {
+	struct can_priv *priv = netdev_priv(dev);
+
+	/* Ensure termination_cost and termination_const_cnt
+	 * consistency. Both must be either set or unset.
+	 */
+	if ((priv->termination_const && priv->termination_const_cnt <= 0) ||
+	    (!priv->termination_const && priv->termination_const_cnt != 0))
+		return -EINVAL;
+
 	dev->rtnl_link_ops = &can_link_ops;
 	return register_netdev(dev);
 }
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 5f5270941ba0..cba7f4b5a722 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -38,6 +38,9 @@ struct can_priv {
 	struct can_bittiming bittiming, data_bittiming;
 	const struct can_bittiming_const *bittiming_const,
 		*data_bittiming_const;
+	const u16 *termination_const;
+	const int termination_const_cnt;
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

