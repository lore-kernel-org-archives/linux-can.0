From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next] Add CAN FD driver infrastructure
Date: Wed, 05 Feb 2014 20:32:40 +0100
Message-ID: <52F291D8.90008@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:40315 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbaBETcn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Feb 2014 14:32:43 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>

This is a combined patch to create the CAN FD driver infrastructure.

- add a separate configuration for data bittiming (incl. netlink)
- the bitrate information is only provided when the bittiming const exist
- add the helper to create canfd frame skbs
- do not overwrite the skb->protocol in can_put_echo_skb()

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index fc59bc6..485b266 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -99,10 +99,10 @@ static int can_update_spt(const struct can_bittiming_const *btc,
 	return 1000 * (tseg + 1 - *tseg2) / (tseg + 1);
 }
 
-static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt)
+static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt,
+			      const struct can_bittiming_const *btc)
 {
 	struct can_priv *priv = netdev_priv(dev);
-	const struct can_bittiming_const *btc = priv->bittiming_const;
 	long rate, best_rate = 0;
 	long best_error = 1000000000, error = 0;
 	int best_tseg = 0, best_brp = 0, brp = 0;
@@ -110,7 +110,7 @@ static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt)
 	int spt_error = 1000, spt = 0, sampl_pt;
 	u64 v64;
 
-	if (!priv->bittiming_const)
+	if (!btc)
 		return -ENOTSUPP;
 
 	/* Use CIA recommended sample points */
@@ -204,7 +204,8 @@ static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt)
 	return 0;
 }
 #else /* !CONFIG_CAN_CALC_BITTIMING */
-static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt)
+static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt,
+			      const struct can_bittiming_const *btc)
 {
 	netdev_err(dev, "bit-timing calculation not available\n");
 	return -EINVAL;
@@ -217,14 +218,14 @@ static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt)
  * prescaler value brp. You can find more information in the header
  * file linux/can/netlink.h.
  */
-static int can_fixup_bittiming(struct net_device *dev, struct can_bittiming *bt)
+static int can_fixup_bittiming(struct net_device *dev, struct can_bittiming *bt,
+			       const struct can_bittiming_const *btc)
 {
 	struct can_priv *priv = netdev_priv(dev);
-	const struct can_bittiming_const *btc = priv->bittiming_const;
 	int tseg1, alltseg;
 	u64 brp64;
 
-	if (!priv->bittiming_const)
+	if (!btc)
 		return -ENOTSUPP;
 
 	tseg1 = bt->prop_seg + bt->phase_seg1;
@@ -254,21 +255,21 @@ static int can_fixup_bittiming(struct net_device *dev, struct can_bittiming *bt)
 	return 0;
 }
 
-static int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt)
+static int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt,
+			     const struct can_bittiming_const *btc)
 {
-	struct can_priv *priv = netdev_priv(dev);
 	int err;
 
 	/* Check if the CAN device has bit-timing parameters */
-	if (priv->bittiming_const) {
+	if (btc) {
 
 		/* Non-expert mode? Check if the bitrate has been pre-defined */
 		if (!bt->tq)
 			/* Determine bit-timing parameters */
-			err = can_calc_bittiming(dev, bt);
+			err = can_calc_bittiming(dev, bt, btc);
 		else
 			/* Check bit-timing params and calculate proper brp */
-			err = can_fixup_bittiming(dev, bt);
+			err = can_fixup_bittiming(dev, bt, btc);
 		if (err)
 			return err;
 	}
@@ -317,7 +318,9 @@ void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 	BUG_ON(idx >= priv->echo_skb_max);
 
 	/* check flag whether this packet has to be looped back */
-	if (!(dev->flags & IFF_ECHO) || skb->pkt_type != PACKET_LOOPBACK) {
+	if (!(dev->flags & IFF_ECHO) || skb->pkt_type != PACKET_LOOPBACK ||
+	    (skb->protocol != htons(ETH_P_CAN) &&
+	     skb->protocol != htons(ETH_P_CANFD))) {
 		kfree_skb(skb);
 		return;
 	}
@@ -329,7 +332,6 @@ void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 			return;
 
 		/* make settings for echo to reduce code in irq context */
-		skb->protocol = htons(ETH_P_CAN);
 		skb->pkt_type = PACKET_BROADCAST;
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 		skb->dev = dev;
@@ -512,6 +514,30 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 }
 EXPORT_SYMBOL_GPL(alloc_can_skb);
 
+struct sk_buff *alloc_canfd_skb(struct net_device *dev,
+				struct canfd_frame **cfd)
+{
+	struct sk_buff *skb;
+
+	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
+			       sizeof(struct canfd_frame));
+	if (unlikely(!skb))
+		return NULL;
+
+	skb->protocol = htons(ETH_P_CANFD);
+	skb->pkt_type = PACKET_BROADCAST;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	can_skb_reserve(skb);
+	can_skb_prv(skb)->ifindex = dev->ifindex;
+
+	*cfd = (struct canfd_frame *)skb_put(skb, sizeof(struct canfd_frame));
+	memset(*cfd, 0, sizeof(struct canfd_frame));
+
+	return skb;
+}
+EXPORT_SYMBOL_GPL(alloc_canfd_skb);
+
 struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_frame **cf)
 {
 	struct sk_buff *skb;
@@ -624,6 +650,10 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
 				= { .len = sizeof(struct can_bittiming_const) },
 	[IFLA_CAN_CLOCK]	= { .len = sizeof(struct can_clock) },
 	[IFLA_CAN_BERR_COUNTER]	= { .len = sizeof(struct can_berr_counter) },
+	[IFLA_CAN_DATA_BITTIMING]
+				= { .len = sizeof(struct can_bittiming) },
+	[IFLA_CAN_DATA_BITTIMING_CONST]
+				= { .len = sizeof(struct can_bittiming_const) },
 };
 
 static int can_changelink(struct net_device *dev,
@@ -644,7 +674,7 @@ static int can_changelink(struct net_device *dev,
 		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
 		if ((!bt.bitrate && !bt.tq) || (bt.bitrate && bt.tq))
 			return -EINVAL;
-		err = can_get_bittiming(dev, &bt);
+		err = can_get_bittiming(dev, &bt, priv->bittiming_const);
 		if (err)
 			return err;
 		memcpy(&priv->bittiming, &bt, sizeof(bt));
@@ -657,6 +687,29 @@ static int can_changelink(struct net_device *dev,
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
 
@@ -694,16 +747,23 @@ static size_t can_get_size(const struct net_device *dev)
 	struct can_priv *priv = netdev_priv(dev);
 	size_t size = 0;
 
-	size += nla_total_size(sizeof(struct can_bittiming));	/* IFLA_CAN_BITTIMING */
-	if (priv->bittiming_const)				/* IFLA_CAN_BITTIMING_CONST */
+	if (priv->bittiming_const) {	/* IFLA_CAN_BITTIMING[_CONST] */
+		size += nla_total_size(sizeof(struct can_bittiming));
 		size += nla_total_size(sizeof(struct can_bittiming_const));
+	}
+
 	size += nla_total_size(sizeof(struct can_clock));	/* IFLA_CAN_CLOCK */
 	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_STATE */
 	size += nla_total_size(sizeof(struct can_ctrlmode));	/* IFLA_CAN_CTRLMODE */
 	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_RESTART_MS */
+
 	if (priv->do_get_berr_counter)				/* IFLA_CAN_BERR_COUNTER */
 		size += nla_total_size(sizeof(struct can_berr_counter));
 
+	if (priv->data_bittiming_const)	{/* IFLA_CAN_DATA_BITTIMING[_CONST] */
+		size += nla_total_size(sizeof(struct can_bittiming));
+		size += nla_total_size(sizeof(struct can_bittiming_const));
+	}
 	return size;
 }
 
@@ -716,19 +776,33 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
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
-	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)))
+	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||
+
+	    (priv->data_bittiming_const &&
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
index fb0ab65..8adaee9 100644
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
@@ -124,6 +126,8 @@ unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx);
 void can_free_echo_skb(struct net_device *dev, unsigned int idx);
 
 struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf);
+struct sk_buff *alloc_canfd_skb(struct net_device *dev,
+				struct canfd_frame **cfd);
 struct sk_buff *alloc_can_err_skb(struct net_device *dev,
 				  struct can_frame **cf);
 
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index df944ed..7e2e186 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -96,6 +96,7 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_3_SAMPLES		0x04	/* Triple sampling mode */
 #define CAN_CTRLMODE_ONE_SHOT		0x08	/* One-Shot mode */
 #define CAN_CTRLMODE_BERR_REPORTING	0x10	/* Bus-error reporting */
+#define CAN_CTRLMODE_FD			0x20	/* CAN FD mode */
 
 /*
  * CAN device statistics
@@ -122,6 +123,8 @@ enum {
 	IFLA_CAN_RESTART_MS,
 	IFLA_CAN_RESTART,
 	IFLA_CAN_BERR_COUNTER,
+	IFLA_CAN_DATA_BITTIMING,
+	IFLA_CAN_DATA_BITTIMING_CONST,
 	__IFLA_CAN_MAX
 };
 

