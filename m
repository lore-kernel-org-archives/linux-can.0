From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 04/14] can: af_can: give variable holding the CAN per device receive lists a sensible name
Date: Wed,  2 Aug 2017 19:44:24 +0200
Message-ID: <20170802174434.4689-5-mkl@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48637 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752062AbdHBRol (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Aug 2017 13:44:41 -0400
In-Reply-To: <20170802174434.4689-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

This patch gives the variables holding the CAN receive filter lists a
better name by renaming them from "d" to "dev_rcv_lists".

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 87 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 43 insertions(+), 44 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 2b12f713f4ca..43f4f51d5a73 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -381,7 +381,7 @@ static unsigned int effhash(canid_t can_id)
  *  Reduced can_id to have a preprocessed filter compare value.
  */
 static struct hlist_head *find_rcv_list(canid_t *can_id, canid_t *mask,
-					struct can_dev_rcv_lists *d)
+					struct can_dev_rcv_lists *dev_rcv_lists)
 {
 	canid_t inv = *can_id & CAN_INV_FILTER; /* save flag before masking */
 
@@ -389,7 +389,7 @@ static struct hlist_head *find_rcv_list(canid_t *can_id, canid_t *mask,
 	if (*mask & CAN_ERR_FLAG) {
 		/* clear CAN_ERR_FLAG in filter entry */
 		*mask &= CAN_ERR_MASK;
-		return &d->rx[RX_ERR];
+		return &dev_rcv_lists->rx[RX_ERR];
 	}
 
 	/* with cleared CAN_ERR_FLAG we have a simple mask/value filterpair */
@@ -405,11 +405,11 @@ static struct hlist_head *find_rcv_list(canid_t *can_id, canid_t *mask,
 
 	/* inverse can_id/can_mask filter */
 	if (inv)
-		return &d->rx[RX_INV];
+		return &dev_rcv_lists->rx[RX_INV];
 
 	/* mask == 0 => no condition testing at receive time */
 	if (!(*mask))
-		return &d->rx[RX_ALL];
+		return &dev_rcv_lists->rx[RX_ALL];
 
 	/* extra filterlists for the subscription of a single non-RTR can_id */
 	if (((*mask & CAN_EFF_RTR_FLAGS) == CAN_EFF_RTR_FLAGS) &&
@@ -417,15 +417,15 @@ static struct hlist_head *find_rcv_list(canid_t *can_id, canid_t *mask,
 
 		if (*can_id & CAN_EFF_FLAG) {
 			if (*mask == (CAN_EFF_MASK | CAN_EFF_RTR_FLAGS))
-				return &d->rx_eff[effhash(*can_id)];
+				return &dev_rcv_lists->rx_eff[effhash(*can_id)];
 		} else {
 			if (*mask == (CAN_SFF_MASK | CAN_EFF_RTR_FLAGS))
-				return &d->rx_sff[*can_id];
+				return &dev_rcv_lists->rx_sff[*can_id];
 		}
 	}
 
 	/* default: filter via can_id/can_mask */
-	return &d->rx[RX_FIL];
+	return &dev_rcv_lists->rx[RX_FIL];
 }
 
 /**
@@ -464,7 +464,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 {
 	struct receiver *r;
 	struct hlist_head *rl;
-	struct can_dev_rcv_lists *d;
+	struct can_dev_rcv_lists *dev_rcv_lists;
 	struct can_pstats *can_pstats = net->can.can_pstats;
 	int err = 0;
 
@@ -482,9 +482,9 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 
 	spin_lock(&net->can.can_rcvlists_lock);
 
-	d = can_dev_rcv_lists_find(net, dev);
-	if (d) {
-		rl = find_rcv_list(&can_id, &mask, d);
+	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
+	if (dev_rcv_lists) {
+		rl = find_rcv_list(&can_id, &mask, dev_rcv_lists);
 
 		r->can_id  = can_id;
 		r->mask    = mask;
@@ -495,7 +495,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 		r->sk      = sk;
 
 		hlist_add_head_rcu(&r->list, rl);
-		d->entries++;
+		dev_rcv_lists->entries++;
 
 		can_pstats->rcv_entries++;
 		if (can_pstats->rcv_entries_max < can_pstats->rcv_entries)
@@ -542,7 +542,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	struct receiver *r = NULL;
 	struct hlist_head *rl;
 	struct can_pstats *can_pstats = net->can.can_pstats;
-	struct can_dev_rcv_lists *d;
+	struct can_dev_rcv_lists *dev_rcv_lists;
 
 	if (dev && dev->type != ARPHRD_CAN)
 		return;
@@ -552,22 +552,21 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 
 	spin_lock(&net->can.can_rcvlists_lock);
 
-	d = can_dev_rcv_lists_find(net, dev);
-	if (!d) {
+	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
+	if (!dev_rcv_lists) {
 		pr_err("BUG: receive list not found for "
 		       "dev %s, id %03X, mask %03X\n",
 		       DNAME(dev), can_id, mask);
 		goto out;
 	}
 
-	rl = find_rcv_list(&can_id, &mask, d);
+	rl = find_rcv_list(&can_id, &mask, dev_rcv_lists);
 
 	/*
 	 * Search the receiver list for the item to delete.  This should
 	 * exist, since no receiver may be unregistered that hasn't
 	 * been registered before.
 	 */
-
 	hlist_for_each_entry_rcu(r, rl, list) {
 		if (r->can_id == can_id && r->mask == mask &&
 		    r->func == func && r->data == data)
@@ -586,14 +585,14 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	}
 
 	hlist_del_rcu(&r->list);
-	d->entries--;
+	dev_rcv_lists->entries--;
 
 	if (can_pstats->rcv_entries > 0)
 		can_pstats->rcv_entries--;
 
 	/* remove device structure requested by NETDEV_UNREGISTER */
-	if (d->remove_on_zero_entries && !d->entries) {
-		kfree(d);
+	if (dev_rcv_lists->remove_on_zero_entries && !dev_rcv_lists->entries) {
+		kfree(dev_rcv_lists);
 		dev->ml_priv = NULL;
 	}
 
@@ -615,19 +614,19 @@ static inline void deliver(struct sk_buff *skb, struct receiver *r)
 	r->matches++;
 }
 
-static int can_rcv_filter(struct can_dev_rcv_lists *d, struct sk_buff *skb)
+static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buff *skb)
 {
 	struct receiver *r;
 	int matches = 0;
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	canid_t can_id = cf->can_id;
 
-	if (d->entries == 0)
+	if (dev_rcv_lists->entries == 0)
 		return 0;
 
 	if (can_id & CAN_ERR_FLAG) {
 		/* check for error message frame entries only */
-		hlist_for_each_entry_rcu(r, &d->rx[RX_ERR], list) {
+		hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx[RX_ERR], list) {
 			if (can_id & r->mask) {
 				deliver(skb, r);
 				matches++;
@@ -637,13 +636,13 @@ static int can_rcv_filter(struct can_dev_rcv_lists *d, struct sk_buff *skb)
 	}
 
 	/* check for unfiltered entries */
-	hlist_for_each_entry_rcu(r, &d->rx[RX_ALL], list) {
+	hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx[RX_ALL], list) {
 		deliver(skb, r);
 		matches++;
 	}
 
 	/* check for can_id/mask entries */
-	hlist_for_each_entry_rcu(r, &d->rx[RX_FIL], list) {
+	hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx[RX_FIL], list) {
 		if ((can_id & r->mask) == r->can_id) {
 			deliver(skb, r);
 			matches++;
@@ -651,7 +650,7 @@ static int can_rcv_filter(struct can_dev_rcv_lists *d, struct sk_buff *skb)
 	}
 
 	/* check for inverted can_id/mask entries */
-	hlist_for_each_entry_rcu(r, &d->rx[RX_INV], list) {
+	hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx[RX_INV], list) {
 		if ((can_id & r->mask) != r->can_id) {
 			deliver(skb, r);
 			matches++;
@@ -663,7 +662,7 @@ static int can_rcv_filter(struct can_dev_rcv_lists *d, struct sk_buff *skb)
 		return matches;
 
 	if (can_id & CAN_EFF_FLAG) {
-		hlist_for_each_entry_rcu(r, &d->rx_eff[effhash(can_id)], list) {
+		hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx_eff[effhash(can_id)], list) {
 			if (r->can_id == can_id) {
 				deliver(skb, r);
 				matches++;
@@ -671,7 +670,7 @@ static int can_rcv_filter(struct can_dev_rcv_lists *d, struct sk_buff *skb)
 		}
 	} else {
 		can_id &= CAN_SFF_MASK;
-		hlist_for_each_entry_rcu(r, &d->rx_sff[can_id], list) {
+		hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx_sff[can_id], list) {
 			deliver(skb, r);
 			matches++;
 		}
@@ -682,7 +681,7 @@ static int can_rcv_filter(struct can_dev_rcv_lists *d, struct sk_buff *skb)
 
 static void can_receive(struct sk_buff *skb, struct net_device *dev)
 {
-	struct can_dev_rcv_lists *d;
+	struct can_dev_rcv_lists *dev_rcv_lists;
 	struct net *net = dev_net(dev);
 	struct can_stats *can_stats = net->can.can_stats;
 	int matches;
@@ -701,9 +700,9 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 	matches = can_rcv_filter(net->can.can_rx_alldev_list, skb);
 
 	/* find receive list for this device */
-	d = can_dev_rcv_lists_find(net, dev);
-	if (d)
-		matches += can_rcv_filter(d, skb);
+	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
+	if (dev_rcv_lists)
+		matches += can_rcv_filter(dev_rcv_lists, skb);
 
 	rcu_read_unlock();
 
@@ -829,7 +828,7 @@ static int can_notifier(struct notifier_block *nb, unsigned long msg,
 			void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
-	struct can_dev_rcv_lists *d;
+	struct can_dev_rcv_lists *dev_rcv_lists;
 
 	if (dev->type != ARPHRD_CAN)
 		return NOTIFY_DONE;
@@ -839,23 +838,23 @@ static int can_notifier(struct notifier_block *nb, unsigned long msg,
 	case NETDEV_REGISTER:
 
 		/* create new dev_rcv_lists for this device */
-		d = kzalloc(sizeof(*d), GFP_KERNEL);
-		if (!d)
+		dev_rcv_lists = kzalloc(sizeof(*dev_rcv_lists), GFP_KERNEL);
+		if (!dev_rcv_lists)
 			return NOTIFY_DONE;
 		BUG_ON(dev->ml_priv);
-		dev->ml_priv = d;
+		dev->ml_priv = dev_rcv_lists;
 
 		break;
 
 	case NETDEV_UNREGISTER:
 		spin_lock(&dev_net(dev)->can.can_rcvlists_lock);
 
-		d = dev->ml_priv;
-		if (d) {
-			if (d->entries)
-				d->remove_on_zero_entries = 1;
+		dev_rcv_lists = dev->ml_priv;
+		if (dev_rcv_lists) {
+			if (dev_rcv_lists->entries)
+				dev_rcv_lists->remove_on_zero_entries = 1;
 			else {
-				kfree(d);
+				kfree(dev_rcv_lists);
 				dev->ml_priv = NULL;
 			}
 		} else
@@ -920,10 +919,10 @@ static void can_pernet_exit(struct net *net)
 	rcu_read_lock();
 	for_each_netdev_rcu(net, dev) {
 		if (dev->type == ARPHRD_CAN && dev->ml_priv) {
-			struct can_dev_rcv_lists *d = dev->ml_priv;
+			struct can_dev_rcv_lists *dev_rcv_lists = dev->ml_priv;
 
-			BUG_ON(d->entries);
-			kfree(d);
+			BUG_ON(dev_rcv_lists->entries);
+			kfree(dev_rcv_lists);
 			dev->ml_priv = NULL;
 		}
 	}
-- 
2.13.2

