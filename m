From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 03/14] can: af_can: give struct holding the CAN per device receive lists a sensible name
Date: Wed,  2 Aug 2017 19:44:23 +0200
Message-ID: <20170802174434.4689-4-mkl@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44077 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751991AbdHBRok (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Aug 2017 13:44:40 -0400
In-Reply-To: <20170802174434.4689-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

This patch adds a "can_" prefix to the "struct dev_rcv_lists" to better
reflect the meaning and improbe code readability.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/net/netns/can.h |  4 ++--
 net/can/af_can.c        | 22 +++++++++++-----------
 net/can/af_can.h        |  2 +-
 net/can/proc.c          |  8 ++++----
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/net/netns/can.h b/include/net/netns/can.h
index 5ee0f88ebbac..0594d9e7e309 100644
--- a/include/net/netns/can.h
+++ b/include/net/netns/can.h
@@ -7,7 +7,7 @@
 
 #include <linux/spinlock.h>
 
-struct dev_rcv_lists;
+struct can_dev_rcv_lists;
 struct can_stats;
 struct can_pstats;
 
@@ -27,7 +27,7 @@ struct netns_can {
 #endif
 
 	/* receive filters subscribed for 'all' CAN devices */
-	struct dev_rcv_lists *can_rx_alldev_list;
+	struct can_dev_rcv_lists *can_rx_alldev_list;
 	spinlock_t can_rcvlists_lock;
 	struct timer_list can_stattimer;/* timer for statistics update */
 	struct can_stats *can_stats; /* packet statistics */
diff --git a/net/can/af_can.c b/net/can/af_can.c
index bbd8a9bcf28d..2b12f713f4ca 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -321,13 +321,13 @@ EXPORT_SYMBOL(can_send);
  * af_can rx path
  */
 
-static struct dev_rcv_lists *can_dev_rcv_lists_find(struct net *net,
-						    struct net_device *dev)
+static struct can_dev_rcv_lists *can_dev_rcv_lists_find(struct net *net,
+							struct net_device *dev)
 {
 	if (!dev)
 		return net->can.can_rx_alldev_list;
 	else
-		return (struct dev_rcv_lists *)dev->ml_priv;
+		return (struct can_dev_rcv_lists *)dev->ml_priv;
 }
 
 /**
@@ -381,7 +381,7 @@ static unsigned int effhash(canid_t can_id)
  *  Reduced can_id to have a preprocessed filter compare value.
  */
 static struct hlist_head *find_rcv_list(canid_t *can_id, canid_t *mask,
-					struct dev_rcv_lists *d)
+					struct can_dev_rcv_lists *d)
 {
 	canid_t inv = *can_id & CAN_INV_FILTER; /* save flag before masking */
 
@@ -464,7 +464,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
 {
 	struct receiver *r;
 	struct hlist_head *rl;
-	struct dev_rcv_lists *d;
+	struct can_dev_rcv_lists *d;
 	struct can_pstats *can_pstats = net->can.can_pstats;
 	int err = 0;
 
@@ -542,7 +542,7 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	struct receiver *r = NULL;
 	struct hlist_head *rl;
 	struct can_pstats *can_pstats = net->can.can_pstats;
-	struct dev_rcv_lists *d;
+	struct can_dev_rcv_lists *d;
 
 	if (dev && dev->type != ARPHRD_CAN)
 		return;
@@ -615,7 +615,7 @@ static inline void deliver(struct sk_buff *skb, struct receiver *r)
 	r->matches++;
 }
 
-static int can_rcv_filter(struct dev_rcv_lists *d, struct sk_buff *skb)
+static int can_rcv_filter(struct can_dev_rcv_lists *d, struct sk_buff *skb)
 {
 	struct receiver *r;
 	int matches = 0;
@@ -682,7 +682,7 @@ static int can_rcv_filter(struct dev_rcv_lists *d, struct sk_buff *skb)
 
 static void can_receive(struct sk_buff *skb, struct net_device *dev)
 {
-	struct dev_rcv_lists *d;
+	struct can_dev_rcv_lists *d;
 	struct net *net = dev_net(dev);
 	struct can_stats *can_stats = net->can.can_stats;
 	int matches;
@@ -829,7 +829,7 @@ static int can_notifier(struct notifier_block *nb, unsigned long msg,
 			void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
-	struct dev_rcv_lists *d;
+	struct can_dev_rcv_lists *d;
 
 	if (dev->type != ARPHRD_CAN)
 		return NOTIFY_DONE;
@@ -874,7 +874,7 @@ static int can_pernet_init(struct net *net)
 {
 	spin_lock_init(&net->can.can_rcvlists_lock);
 	net->can.can_rx_alldev_list =
-		kzalloc(sizeof(struct dev_rcv_lists), GFP_KERNEL);
+		kzalloc(sizeof(struct can_dev_rcv_lists), GFP_KERNEL);
 	if (!net->can.can_rx_alldev_list)
 		goto out;
 	net->can.can_stats = kzalloc(sizeof(struct can_stats), GFP_KERNEL);
@@ -920,7 +920,7 @@ static void can_pernet_exit(struct net *net)
 	rcu_read_lock();
 	for_each_netdev_rcu(net, dev) {
 		if (dev->type == ARPHRD_CAN && dev->ml_priv) {
-			struct dev_rcv_lists *d = dev->ml_priv;
+			struct can_dev_rcv_lists *d = dev->ml_priv;
 
 			BUG_ON(d->entries);
 			kfree(d);
diff --git a/net/can/af_can.h b/net/can/af_can.h
index 4e2cb14c1af7..4b77c7951f17 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -67,7 +67,7 @@ struct receiver {
 enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_MAX };
 
 /* per device receive filters linked at dev->ml_priv */
-struct dev_rcv_lists {
+struct can_dev_rcv_lists {
 	struct hlist_head rx[RX_MAX];
 	struct hlist_head rx_sff[CAN_SFF_RCV_ARRAY_SZ];
 	struct hlist_head rx_eff[CAN_EFF_RCV_ARRAY_SZ];
diff --git a/net/can/proc.c b/net/can/proc.c
index 559fca8035aa..b06ea3823b07 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -338,7 +338,7 @@ static const struct file_operations can_version_proc_fops = {
 
 static inline void can_rcvlist_proc_show_one(struct seq_file *m, int idx,
 					     struct net_device *dev,
-					     struct dev_rcv_lists *d)
+					     struct can_dev_rcv_lists *d)
 {
 	if (!hlist_empty(&d->rx[idx])) {
 		can_print_recv_banner(m);
@@ -353,7 +353,7 @@ static int can_rcvlist_proc_show(struct seq_file *m, void *v)
 	/* double cast to prevent GCC warning */
 	int idx = (int)(long)PDE_DATA(m->file->f_inode);
 	struct net_device *dev;
-	struct dev_rcv_lists *d;
+	struct can_dev_rcv_lists *d;
 	struct net *net = m->private;
 
 	seq_printf(m, "\nreceive list '%s':\n", rx_list_name[idx]);
@@ -417,7 +417,7 @@ static inline void can_rcvlist_proc_show_array(struct seq_file *m,
 static int can_rcvlist_sff_proc_show(struct seq_file *m, void *v)
 {
 	struct net_device *dev;
-	struct dev_rcv_lists *d;
+	struct can_dev_rcv_lists *d;
 	struct net *net = m->private;
 
 	/* RX_SFF */
@@ -461,7 +461,7 @@ static const struct file_operations can_rcvlist_sff_proc_fops = {
 static int can_rcvlist_eff_proc_show(struct seq_file *m, void *v)
 {
 	struct net_device *dev;
-	struct dev_rcv_lists *d;
+	struct can_dev_rcv_lists *d;
 	struct net *net = m->private;
 
 	/* RX_EFF */
-- 
2.13.2

