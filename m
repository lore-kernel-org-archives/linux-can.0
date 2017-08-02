From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 07/14] can: af_can: give variable holding the CAN receiver and the receiver list a sensible name
Date: Wed,  2 Aug 2017 19:44:27 +0200
Message-ID: <20170802174434.4689-8-mkl@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:58545 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752318AbdHBRom (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Aug 2017 13:44:42 -0400
In-Reply-To: <20170802174434.4689-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

This patch gives the variables holding the CAN receiver and the receiver
list a better name by renaming them from "r to "rcv" and "rl" to
"recv_list".

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 101 +++++++++++++++++++++++++++----------------------------
 1 file changed, 50 insertions(+), 51 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 0f1334803aea..cb079d2dcde2 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -462,8 +462,8 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 		    canid_t mask, void (*func)(struct sk_buff *, void *),
 		    void *data, char *ident, struct sock *sk)
 {
-	struct receiver *r;
-	struct hlist_head *rl;
+	struct receiver *rcv;
+	struct hlist_head *rcv_list;
 	struct can_dev_rcv_lists *dev_rcv_lists;
 	struct can_pstats *can_pstats = net->can.can_pstats;
 	int err = 0;
@@ -476,32 +476,32 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	if (dev && !net_eq(net, dev_net(dev)))
 		return -ENODEV;
 
-	r = kmem_cache_alloc(rcv_cache, GFP_KERNEL);
-	if (!r)
+	rcv = kmem_cache_alloc(rcv_cache, GFP_KERNEL);
+	if (!rcv)
 		return -ENOMEM;
 
 	spin_lock(&net->can.can_rcvlists_lock);
 
 	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
 	if (dev_rcv_lists) {
-		rl = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
+		rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
 
-		r->can_id  = can_id;
-		r->mask    = mask;
-		r->matches = 0;
-		r->func    = func;
-		r->data    = data;
-		r->ident   = ident;
-		r->sk      = sk;
+		rcv->can_id = can_id;
+		rcv->mask = mask;
+		rcv->matches = 0;
+		rcv->func = func;
+		rcv->data = data;
+		rcv->ident = ident;
+		rcv->sk = sk;
 
-		hlist_add_head_rcu(&r->list, rl);
+		hlist_add_head_rcu(&rcv->list, rcv_list);
 		dev_rcv_lists->entries++;
 
 		can_pstats->rcv_entries++;
 		if (can_pstats->rcv_entries_max < can_pstats->rcv_entries)
 			can_pstats->rcv_entries_max = can_pstats->rcv_entries;
 	} else {
-		kmem_cache_free(rcv_cache, r);
+		kmem_cache_free(rcv_cache, rcv);
 		err = -ENODEV;
 	}
 
@@ -516,10 +516,10 @@ EXPORT_SYMBOL(can_rx_register);
  */
 static void can_rx_delete_receiver(struct rcu_head *rp)
 {
-	struct receiver *r = container_of(rp, struct receiver, rcu);
-	struct sock *sk = r->sk;
+	struct receiver *rcv = container_of(rp, struct receiver, rcu);
+	struct sock *sk = rcv->sk;
 
-	kmem_cache_free(rcv_cache, r);
+	kmem_cache_free(rcv_cache, rcv);
 	if (sk)
 		sock_put(sk);
 }
@@ -539,8 +539,8 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 		       canid_t mask, void (*func)(struct sk_buff *, void *),
 		       void *data)
 {
-	struct receiver *r = NULL;
-	struct hlist_head *rl;
+	struct receiver *rcv = NULL;
+	struct hlist_head *rcv_list;
 	struct can_pstats *can_pstats = net->can.can_pstats;
 	struct can_dev_rcv_lists *dev_rcv_lists;
 
@@ -560,31 +560,30 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 		goto out;
 	}
 
-	rl = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
+	rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
 
 	/*
 	 * Search the receiver list for the item to delete.  This should
 	 * exist, since no receiver may be unregistered that hasn't
 	 * been registered before.
 	 */
-	hlist_for_each_entry_rcu(r, rl, list) {
-		if (r->can_id == can_id && r->mask == mask &&
-		    r->func == func && r->data == data)
+	hlist_for_each_entry_rcu(rcv, rcv_list, list) {
+		if (rcv->can_id == can_id && rcv->mask == mask &&
+		    rcv->func == func && rcv->data == data)
 			break;
 	}
 
 	/*
 	 * Check for bugs in CAN protocol implementations using af_can.c:
-	 * 'r' will be NULL if no matching list item was found for removal.
+	 * 'rcv' will be NULL if no matching list item was found for removal.
 	 */
-
-	if (!r) {
+	if (!rcv) {
 		WARN(1, "BUG: receive list entry not found for dev %s, "
 		     "id %03X, mask %03X\n", DNAME(dev), can_id, mask);
 		goto out;
 	}
 
-	hlist_del_rcu(&r->list);
+	hlist_del_rcu(&rcv->list);
 	dev_rcv_lists->entries--;
 
 	if (can_pstats->rcv_entries > 0)
@@ -600,23 +599,23 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	spin_unlock(&net->can.can_rcvlists_lock);
 
 	/* schedule the receiver item for deletion */
-	if (r) {
-		if (r->sk)
-			sock_hold(r->sk);
-		call_rcu(&r->rcu, can_rx_delete_receiver);
+	if (rcv) {
+		if (rcv->sk)
+			sock_hold(rcv->sk);
+		call_rcu(&rcv->rcu, can_rx_delete_receiver);
 	}
 }
 EXPORT_SYMBOL(can_rx_unregister);
 
-static inline void deliver(struct sk_buff *skb, struct receiver *r)
+static inline void deliver(struct sk_buff *skb, struct receiver *rcv)
 {
-	r->func(skb, r->data);
-	r->matches++;
+	rcv->func(skb, rcv->data);
+	rcv->matches++;
 }
 
 static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buff *skb)
 {
-	struct receiver *r;
+	struct receiver *rcv;
 	int matches = 0;
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	canid_t can_id = cf->can_id;
@@ -626,9 +625,9 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
 
 	if (can_id & CAN_ERR_FLAG) {
 		/* check for error message frame entries only */
-		hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx[RX_ERR], list) {
-			if (can_id & r->mask) {
-				deliver(skb, r);
+		hlist_for_each_entry_rcu(rcv, &dev_rcv_lists->rx[RX_ERR], list) {
+			if (can_id & rcv->mask) {
+				deliver(skb, rcv);
 				matches++;
 			}
 		}
@@ -636,23 +635,23 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
 	}
 
 	/* check for unfiltered entries */
-	hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx[RX_ALL], list) {
-		deliver(skb, r);
+	hlist_for_each_entry_rcu(rcv, &dev_rcv_lists->rx[RX_ALL], list) {
+		deliver(skb, rcv);
 		matches++;
 	}
 
 	/* check for can_id/mask entries */
-	hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx[RX_FIL], list) {
-		if ((can_id & r->mask) == r->can_id) {
-			deliver(skb, r);
+	hlist_for_each_entry_rcu(rcv, &dev_rcv_lists->rx[RX_FIL], list) {
+		if ((can_id & rcv->mask) == rcv->can_id) {
+			deliver(skb, rcv);
 			matches++;
 		}
 	}
 
 	/* check for inverted can_id/mask entries */
-	hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx[RX_INV], list) {
-		if ((can_id & r->mask) != r->can_id) {
-			deliver(skb, r);
+	hlist_for_each_entry_rcu(rcv, &dev_rcv_lists->rx[RX_INV], list) {
+		if ((can_id & rcv->mask) != rcv->can_id) {
+			deliver(skb, rcv);
 			matches++;
 		}
 	}
@@ -662,16 +661,16 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
 		return matches;
 
 	if (can_id & CAN_EFF_FLAG) {
-		hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx_eff[effhash(can_id)], list) {
-			if (r->can_id == can_id) {
-				deliver(skb, r);
+		hlist_for_each_entry_rcu(rcv, &dev_rcv_lists->rx_eff[effhash(can_id)], list) {
+			if (rcv->can_id == can_id) {
+				deliver(skb, rcv);
 				matches++;
 			}
 		}
 	} else {
 		can_id &= CAN_SFF_MASK;
-		hlist_for_each_entry_rcu(r, &dev_rcv_lists->rx_sff[can_id], list) {
-			deliver(skb, r);
+		hlist_for_each_entry_rcu(rcv, &dev_rcv_lists->rx_sff[can_id], list) {
+			deliver(skb, rcv);
 			matches++;
 		}
 	}
-- 
2.13.2

