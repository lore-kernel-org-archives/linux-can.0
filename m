From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3] can: dev: add CAN interface API for fixed bitrates
Date: Wed, 18 Jan 2017 16:03:13 +0100
Message-ID: <20170118150313.10682-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60841 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751480AbdARPDQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2017 10:03:16 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Inside the driver:
const u32 drvname_bitrate[] = { 20000, 50000, 100000 };

struct drvname_priv *priv;
priv = netdev_priv(dev);

priv->bitrate_const = drvname_bitrate;
priv->bitrate_const_cnt = ARRAY_SIZE(drvname_bitrate);

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes since v2:
- fix IFLA_CAN_BITRATE_CONST // IFLA_CAN_DATA_BITRATE_CONST copy/paste error
- do not use const for struct can_priv::{data_,}bitrate_const_cnt

 drivers/net/can/dev.c            | 81 ++++++++++++++++++++++++++++++++--------
 include/linux/can/dev.h          |  4 ++
 include/uapi/linux/can/netlink.h |  2 +
 3 files changed, 71 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index afcf487382c9..611d16a7061d 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -279,8 +279,29 @@ static int can_fixup_bittiming(struct net_device *dev, struct can_bittiming *bt,
 	return 0;
 }
 
+/* Checks the validity of predefined bitrate settings */
+static int can_validate_bitrate(struct net_device *dev, struct can_bittiming *bt,
+				const u32 *bitrate_const,
+				const unsigned int bitrate_const_cnt)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	unsigned int i;
+
+	for (i = 0; i < bitrate_const_cnt; i++) {
+		if (bt->bitrate == bitrate_const[i])
+			break;
+	}
+
+	if (i >= priv->bitrate_const_cnt)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt,
-			     const struct can_bittiming_const *btc)
+			     const struct can_bittiming_const *btc,
+			     const u32 *bitrate_const,
+			     const unsigned int bitrate_const_cnt)
 {
 	int err;
 
@@ -290,10 +311,13 @@ static int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt,
 	 * alternatively the CAN timing parameters (tq, prop_seg, etc.) are
 	 * provided directly which are then checked and fixed up.
 	 */
-	if (!bt->tq && bt->bitrate)
+	if (!bt->tq && bt->bitrate && btc)
 		err = can_calc_bittiming(dev, bt, btc);
-	else if (bt->tq && !bt->bitrate)
+	else if (bt->tq && !bt->bitrate && btc)
 		err = can_fixup_bittiming(dev, bt, btc);
+	else if (!bt->tq && bt->bitrate && bitrate_const)
+		err = can_validate_bitrate(dev, bt, bitrate_const,
+					   bitrate_const_cnt);
 	else
 		err = -EINVAL;
 
@@ -878,12 +902,12 @@ static int can_changelink(struct net_device *dev,
 			return -EOPNOTSUPP;
 
 		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
-		if (priv->bittiming_const) {
-			err = can_get_bittiming(dev, &bt,
-						priv->bittiming_const);
-			if (err)
-				return err;
-		}
+		err = can_get_bittiming(dev, &bt,
+					priv->bittiming_const,
+					priv->bitrate_const,
+					priv->bitrate_const_cnt);
+		if (err)
+			return err;
 		memcpy(&priv->bittiming, &bt, sizeof(bt));
 
 		if (priv->do_set_bittiming) {
@@ -962,12 +986,12 @@ static int can_changelink(struct net_device *dev,
 
 		memcpy(&dbt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
 		       sizeof(dbt));
-		if (priv->data_bittiming_const) {
-			err = can_get_bittiming(dev, &dbt,
-						priv->data_bittiming_const);
-			if (err)
-				return err;
-		}
+		err = can_get_bittiming(dev, &dbt,
+					priv->data_bittiming_const,
+					priv->data_bitrate_const,
+					priv->data_bitrate_const_cnt);
+		if (err)
+			return err;
 		memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
 
 		if (priv->do_set_data_bittiming) {
@@ -1029,6 +1053,12 @@ static size_t can_get_size(const struct net_device *dev)
 		size += nla_total_size(sizeof(*priv->termination_const) *	/* IFLA_CAN_TERMINATION_CONST */
 				       priv->termination_const_cnt);
 	}
+	if (priv->bitrate_const)				/* IFLA_CAN_BITRATE_CONST */
+		size += nla_total_size(sizeof(*priv->bitrate_const) *
+				       priv->bitrate_const_cnt);
+	if (priv->data_bitrate_const)				/* IFLA_CAN_DATA_BITRATE_CONST */
+		size += nla_total_size(sizeof(*priv->data_bitrate_const) *
+				       priv->data_bitrate_const_cnt);
 
 	return size;
 }
@@ -1074,7 +1104,20 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	      nla_put(skb, IFLA_CAN_TERMINATION_CONST,
 		      sizeof(*priv->termination_const) *
 		      priv->termination_const_cnt,
-		      priv->termination_const))))
+		      priv->termination_const))) ||
+
+	    (priv->bitrate_const &&
+	     nla_put(skb, IFLA_CAN_BITRATE_CONST,
+		     sizeof(*priv->bitrate_const) *
+		     priv->bitrate_const_cnt,
+		     priv->bitrate_const)) ||
+
+	    (priv->data_bitrate_const &&
+	     nla_put(skb, IFLA_CAN_DATA_BITRATE_CONST,
+		     sizeof(*priv->data_bitrate_const) *
+		     priv->data_bitrate_const_cnt,
+		     priv->data_bitrate_const))
+	    )
 
 		return -EMSGSIZE;
 
@@ -1140,6 +1183,12 @@ int register_candev(struct net_device *dev)
 	    (!priv->termination_const != !priv->do_set_termination))
 		return -EINVAL;
 
+	if (!priv->bitrate_const != !priv->bitrate_const_cnt)
+		return -EINVAL;
+
+	if (!priv->data_bitrate_const != !priv->data_bitrate_const_cnt)
+		return -EINVAL;
+
 	dev->rtnl_link_ops = &can_link_ops;
 	return register_netdev(dev);
 }
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index f6a57f322f00..141b05aade81 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -41,6 +41,10 @@ struct can_priv {
 	const u16 *termination_const;
 	unsigned int termination_const_cnt;
 	u16 termination;
+	const u32 *bitrate_const;
+	unsigned int bitrate_const_cnt;
+	const u32 *data_bitrate_const;
+	unsigned int data_bitrate_const_cnt;
 	struct can_clock clock;
 
 	enum can_state state;
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 7414771926fb..fdf75f74fdaf 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -129,6 +129,8 @@ enum {
 	IFLA_CAN_DATA_BITTIMING_CONST,
 	IFLA_CAN_TERMINATION,
 	IFLA_CAN_TERMINATION_CONST,
+	IFLA_CAN_BITRATE_CONST,
+	IFLA_CAN_DATA_BITRATE_CONST,
 	__IFLA_CAN_MAX
 };
 
-- 
2.11.0

