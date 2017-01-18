From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v6] can: dev: add CAN interface termination API
Date: Wed, 18 Jan 2017 15:59:16 +0100
Message-ID: <20170118145916.10580-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55771 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752102AbdARO7U (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2017 09:59:20 -0500
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
Reviewed-by: Ramesh Shanmugasundaram <Ramesh.shanmugasundaram@bp.renesas.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

changes since v5:
- do not use const for struct can_priv::termination_const_cnt

 drivers/net/can/dev.c            | 49 +++++++++++++++++++++++++++++++++++++++-
 include/linux/can/dev.h          |  4 ++++
 include/uapi/linux/can/netlink.h |  5 ++++
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 8d6208c0b400..fefe2cd17721 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -958,6 +958,30 @@ static int can_changelink(struct net_device *dev,
 		}
 	}
 
+	if (data[IFLA_CAN_TERMINATION]) {
+		const u16 termval = nla_get_u16(data[IFLA_CAN_TERMINATION]);
+		const unsigned int num_term = priv->termination_const_cnt;
+		unsigned int i;
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
 
@@ -980,6 +1004,11 @@ static size_t can_get_size(const struct net_device *dev)
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
@@ -1018,7 +1047,15 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
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
@@ -1073,6 +1110,16 @@ static struct rtnl_link_ops can_link_ops __read_mostly = {
  */
 int register_candev(struct net_device *dev)
 {
+	struct can_priv *priv = netdev_priv(dev);
+
+	/* Ensure termination_const, termination_const_cnt and
+	 * do_set_termination consistency. All must be either set or
+	 * unset.
+	 */
+	if ((!priv->termination_const != !priv->termination_const_cnt) ||
+	    (!priv->termination_const != !priv->do_set_termination))
+		return -EINVAL;
+
 	dev->rtnl_link_ops = &can_link_ops;
 	return register_netdev(dev);
 }
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 5f5270941ba0..f6a57f322f00 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -38,6 +38,9 @@ struct can_priv {
 	struct can_bittiming bittiming, data_bittiming;
 	const struct can_bittiming_const *bittiming_const,
 		*data_bittiming_const;
+	const u16 *termination_const;
+	unsigned int termination_const_cnt;
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

