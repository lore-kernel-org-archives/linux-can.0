From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 14/14] can: af_can: remove NULL-ptr checks from users of can_dev_rcv_lists_find()
Date: Wed,  2 Aug 2017 19:44:34 +0200
Message-ID: <20170802174434.4689-15-mkl@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51341 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752404AbdHBRop (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Aug 2017 13:44:45 -0400
In-Reply-To: <20170802174434.4689-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

Since using the "struct can_ml_priv" for the per device "struct
dev_rcv_lists" the call can_dev_rcv_lists_find() cannot fail anymore.
This patch simplifies af_can by removing the NULL pointer checks from
the dev_rcv_lists returned by can_dev_rcv_lists_find().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/af_can.c | 46 ++++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index c3eac4ab74e9..f940030f797f 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -486,28 +486,22 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 	spin_lock(&net->can.can_rcvlists_lock);
 
 	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
-	if (dev_rcv_lists) {
-		rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
-
-		rcv->can_id = can_id;
-		rcv->mask = mask;
-		rcv->matches = 0;
-		rcv->func = func;
-		rcv->data = data;
-		rcv->ident = ident;
-		rcv->sk = sk;
-
-		hlist_add_head_rcu(&rcv->list, rcv_list);
-		dev_rcv_lists->entries++;
-
-		can_pstats->rcv_entries++;
-		can_pstats->rcv_entries_max = max(can_pstats->rcv_entries_max,
-						  can_pstats->rcv_entries);
-	} else {
-		kmem_cache_free(rcv_cache, rcv);
-		err = -ENODEV;
-	}
+	rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
+
+	rcv->can_id = can_id;
+	rcv->mask = mask;
+	rcv->matches = 0;
+	rcv->func = func;
+	rcv->data = data;
+	rcv->ident = ident;
+	rcv->sk = sk;
 
+	hlist_add_head_rcu(&rcv->list, rcv_list);
+	dev_rcv_lists->entries++;
+
+	can_pstats->rcv_entries++;
+	can_pstats->rcv_entries_max = max(can_pstats->rcv_entries_max,
+					  can_pstats->rcv_entries);
 	spin_unlock(&net->can.can_rcvlists_lock);
 
 	return err;
@@ -556,13 +550,6 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	spin_lock(&net->can.can_rcvlists_lock);
 
 	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
-	if (!dev_rcv_lists) {
-		pr_err("BUG: receive list not found for "
-		       "dev %s, id %03X, mask %03X\n",
-		       DNAME(dev), can_id, mask);
-		goto out;
-	}
-
 	rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
 
 	/*
@@ -697,8 +684,7 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 
 	/* find receive list for this device */
 	dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
-	if (dev_rcv_lists)
-		matches += can_rcv_filter(dev_rcv_lists, skb);
+	matches += can_rcv_filter(dev_rcv_lists, skb);
 
 	rcu_read_unlock();
 
-- 
2.13.2

