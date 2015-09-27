From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [RFC PATCH 2/4] net: can: rename structures
Date: Sun, 27 Sep 2015 18:22:26 +0000
Message-ID: <DB3PR05MB09212A21B0531ADF9ACEEA6389400@DB3PR05MB0921.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0061.outbound.protection.outlook.com ([157.55.234.61]:4536
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752507AbbI0SWr (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 27 Sep 2015 14:22:47 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, John Ernberg <john.ernberg@actia.se>

---
 include/net/af_can.h | 14 +++++++-------
 net/can/af_can.c     | 38 +++++++++++++++++++-------------------
 net/can/proc.c       | 10 +++++-----
 3 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/net/af_can.h b/include/net/af_can.h
index 002b16d..d9e8952 100644
--- a/include/net/af_can.h
+++ b/include/net/af_can.h
@@ -48,7 +48,7 @@
 
 /* af_can rx dispatcher structures */
 
-struct receiver {
+struct can_receiver {
 	struct hlist_node list;
 	struct rcu_head rcu;
 	canid_t can_id;
@@ -66,7 +66,7 @@ struct receiver {
 enum { RX_ERR, RX_ALL, RX_FIL, RX_INV, RX_MAX };
 
 /* per device receive filters linked at dev->ml_priv */
-struct dev_rcv_lists {
+struct can_dev_rcv_lists {
 	struct hlist_head rx[RX_MAX];
 	struct hlist_head rx_sff[CAN_SFF_RCV_ARRAY_SZ];
 	struct hlist_head rx_eff[CAN_EFF_RCV_ARRAY_SZ];
@@ -77,7 +77,7 @@ struct dev_rcv_lists {
 /* statistic structures */
 
 /* can be reset e.g. by can_init_stats() */
-struct s_stats {
+struct can_stats {
 	unsigned long jiffies_init;
 
 	unsigned long rx_frames;
@@ -102,7 +102,7 @@ struct s_stats {
 };
 
 /* persistent statistics */
-struct s_pstats {
+struct can_pstats {
 	unsigned long stats_reset;
 	unsigned long user_reset;
 	unsigned long rcv_entries;
@@ -110,7 +110,7 @@ struct s_pstats {
 };
 
 /* receive filters subscribed for 'all' CAN devices */
-extern struct dev_rcv_lists can_rx_alldev_list;
+extern struct can_dev_rcv_lists can_rx_alldev_list;
 
 /* function prototypes for the CAN networklayer procfs (proc.c) */
 void can_init_proc(void);
@@ -119,8 +119,8 @@ void can_stat_update(unsigned long data);
 
 /* structures and variables from af_can.c needed in proc.c for reading */
 extern struct timer_list can_stattimer;    /* timer for statistics update */
-extern struct s_stats    can_stats;        /* packet statistics */
-extern struct s_pstats   can_pstats;       /* receive list statistics */
+extern struct can_stats  can_stats;        /* packet statistics */
+extern struct can_pstats can_pstats;       /* receive list statistics */
 extern struct hlist_head can_rx_dev_list;  /* rx dispatcher structures */
 
 #endif /* __LINUX_NET_AF_CAN_H__ */
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 1fe846b..73f1cb8 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -76,7 +76,7 @@ module_param(stats_timer, int, S_IRUGO);
 MODULE_PARM_DESC(stats_timer, "enable timer for statistics (default:on)");
 
 /* receive filters subscribed for 'all' CAN devices */
-struct dev_rcv_lists can_rx_alldev_list;
+struct can_dev_rcv_lists can_rx_alldev_list;
 static DEFINE_SPINLOCK(can_rcvlists_lock);
 
 static struct kmem_cache *rcv_cache __read_mostly;
@@ -86,8 +86,8 @@ static const struct can_proto *proto_tab[CAN_NPROTO] __read_mostly;
 static DEFINE_MUTEX(proto_tab_lock);
 
 struct timer_list can_stattimer;   /* timer for statistics update */
-struct s_stats    can_stats;       /* packet statistics */
-struct s_pstats   can_pstats;      /* receive list statistics */
+struct can_stats  can_stats;       /* packet statistics */
+struct can_pstats can_pstats;      /* receive list statistics */
 
 static atomic_t skbcounter = ATOMIC_INIT(0);
 
@@ -331,12 +331,12 @@ EXPORT_SYMBOL(can_send);
  * af_can rx path
  */
 
-static struct dev_rcv_lists *find_dev_rcv_lists(struct net_device *dev)
+static struct can_dev_rcv_lists *find_dev_rcv_lists(struct net_device *dev)
 {
 	if (!dev)
 		return &can_rx_alldev_list;
 	else
-		return (struct dev_rcv_lists *)dev->ml_priv;
+		return (struct can_dev_rcv_lists *)dev->ml_priv;
 }
 
 /**
@@ -390,7 +390,7 @@ static unsigned int effhash(canid_t can_id)
  *  Reduced can_id to have a preprocessed filter compare value.
  */
 static struct hlist_head *find_rcv_list(canid_t *can_id, canid_t *mask,
-					struct dev_rcv_lists *d)
+					struct can_dev_rcv_lists *d)
 {
 	canid_t inv = *can_id & CAN_INV_FILTER; /* save flag before masking */
 
@@ -470,9 +470,9 @@ int can_rx_register(struct net_device *dev, canid_t can_id, canid_t mask,
 		    void (*func)(struct sk_buff *, void *), void *data,
 		    char *ident)
 {
-	struct receiver *r;
+	struct can_receiver *r;
 	struct hlist_head *rl;
-	struct dev_rcv_lists *d;
+	struct can_dev_rcv_lists *d;
 	int err = 0;
 
 	/* insert new receiver  (dev,canid,mask) -> (func,data) */
@@ -519,7 +519,7 @@ EXPORT_SYMBOL(can_rx_register);
  */
 static void can_rx_delete_receiver(struct rcu_head *rp)
 {
-	struct receiver *r = container_of(rp, struct receiver, rcu);
+	struct can_receiver *r = container_of(rp, struct can_receiver, rcu);
 
 	kmem_cache_free(rcv_cache, r);
 }
@@ -538,9 +538,9 @@ static void can_rx_delete_receiver(struct rcu_head *rp)
 void can_rx_unregister(struct net_device *dev, canid_t can_id, canid_t mask,
 		       void (*func)(struct sk_buff *, void *), void *data)
 {
-	struct receiver *r = NULL;
+	struct can_receiver *r = NULL;
 	struct hlist_head *rl;
-	struct dev_rcv_lists *d;
+	struct can_dev_rcv_lists *d;
 
 	if (dev && dev->type != ARPHRD_CAN)
 		return;
@@ -601,15 +601,15 @@ void can_rx_unregister(struct net_device *dev, canid_t can_id, canid_t mask,
 }
 EXPORT_SYMBOL(can_rx_unregister);
 
-static inline void deliver(struct sk_buff *skb, struct receiver *r)
+static inline void deliver(struct sk_buff *skb, struct can_receiver *r)
 {
 	r->func(skb, r->data);
 	r->matches++;
 }
 
-static int can_rcv_filter(struct dev_rcv_lists *d, struct sk_buff *skb)
+static int can_rcv_filter(struct can_dev_rcv_lists *d, struct sk_buff *skb)
 {
-	struct receiver *r;
+	struct can_receiver *r;
 	int matches = 0;
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	canid_t can_id = cf->can_id;
@@ -674,7 +674,7 @@ static int can_rcv_filter(struct dev_rcv_lists *d, struct sk_buff *skb)
 
 static void can_receive(struct sk_buff *skb, struct net_device *dev)
 {
-	struct dev_rcv_lists *d;
+	struct can_dev_rcv_lists *d;
 	int matches;
 
 	/* update statistics */
@@ -825,7 +825,7 @@ static int can_notifier(struct notifier_block *nb, unsigned long msg,
 			void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
-	struct dev_rcv_lists *d;
+	struct can_dev_rcv_lists *d;
 
 	if (!net_eq(dev_net(dev), &init_net))
 		return NOTIFY_DONE;
@@ -906,8 +906,8 @@ static __init int can_init(void)
 
 	memset(&can_rx_alldev_list, 0, sizeof(can_rx_alldev_list));
 
-	rcv_cache = kmem_cache_create("can_receiver", sizeof(struct receiver),
-				      0, 0, NULL);
+	rcv_cache = kmem_cache_create("can_receiver",
+				      sizeof(struct can_receiver), 0, 0, NULL);
 	if (!rcv_cache)
 		return -ENOMEM;
 
@@ -949,7 +949,7 @@ static __exit void can_exit(void)
 	for_each_netdev_rcu(&init_net, dev) {
 		if (dev->type == ARPHRD_CAN && dev->ml_priv) {
 
-			struct dev_rcv_lists *d = dev->ml_priv;
+			struct can_dev_rcv_lists *d = dev->ml_priv;
 
 			BUG_ON(d->entries);
 			kfree(d);
diff --git a/net/can/proc.c b/net/can/proc.c
index b6bbc62..0f9f7dc 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -193,7 +193,7 @@ void can_stat_update(unsigned long data)
 static void can_print_rcvlist(struct seq_file *m, struct hlist_head *rx_list,
 			      struct net_device *dev)
 {
-	struct receiver *r;
+	struct can_receiver *r;
 
 	hlist_for_each_entry_rcu(r, rx_list, list) {
 		char *fmt = (r->can_id & CAN_EFF_FLAG)?
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
 	int idx = (int)(long)m->private;
 	struct net_device *dev;
-	struct dev_rcv_lists *d;
+	struct can_dev_rcv_lists *d;
 
 	seq_printf(m, "\nreceive list '%s':\n", rx_list_name[idx]);
 
@@ -416,7 +416,7 @@ static inline void can_rcvlist_proc_show_array(struct seq_file *m,
 static int can_rcvlist_sff_proc_show(struct seq_file *m, void *v)
 {
 	struct net_device *dev;
-	struct dev_rcv_lists *d;
+	struct can_dev_rcv_lists *d;
 
 	/* RX_SFF */
 	seq_puts(m, "\nreceive list 'rx_sff':\n");
@@ -459,7 +459,7 @@ static const struct file_operations can_rcvlist_sff_proc_fops = {
 static int can_rcvlist_eff_proc_show(struct seq_file *m, void *v)
 {
 	struct net_device *dev;
-	struct dev_rcv_lists *d;
+	struct can_dev_rcv_lists *d;
 
 	/* RX_EFF */
 	seq_puts(m, "\nreceive list 'rx_eff':\n");
-- 
2.5.3

