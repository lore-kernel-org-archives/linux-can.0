From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 1/2] can: network namespace support for CAN gateway
Date: Mon, 24 Apr 2017 15:08:59 +0200
Message-ID: <20170424130900.2284-1-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:31864 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1170590AbdDXNJ0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 24 Apr 2017 09:09:26 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This patch enables the CAN gateway to be used in different namespaces.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/net/netns/can.h |  3 ++
 net/can/gw.c            | 73 +++++++++++++++++++++++++++++++------------------
 2 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/include/net/netns/can.h b/include/net/netns/can.h
index 0f3c31aab8a8..b106e6ae2e5b 100644
--- a/include/net/netns/can.h
+++ b/include/net/netns/can.h
@@ -32,6 +32,9 @@ struct netns_can {
 	struct timer_list can_stattimer;/* timer for statistics update */
 	struct s_stats *can_stats;	/* packet statistics */
 	struct s_pstats *can_pstats;	/* receive list statistics */
+
+	/* CAN GW per-net gateway jobs */
+	struct hlist_head cgw_list;
 };
 
 #endif /* __NETNS_CAN_H__ */
diff --git a/net/can/gw.c b/net/can/gw.c
index 3b84fb7d98aa..e2935d9c1ef3 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -59,7 +59,7 @@
 #include <net/net_namespace.h>
 #include <net/sock.h>
 
-#define CAN_GW_VERSION "20130117"
+#define CAN_GW_VERSION "20170422"
 #define CAN_GW_NAME "can-gw"
 
 MODULE_DESCRIPTION("PF_CAN netlink gateway");
@@ -79,9 +79,8 @@ MODULE_PARM_DESC(max_hops,
 		 __stringify(CGW_MAX_HOPS) " hops, "
 		 "default: " __stringify(CGW_DEFAULT_HOPS) ")");
 
-static HLIST_HEAD(cgw_list);
+static int cangw_net_id;
 static struct notifier_block notifier;
-
 static struct kmem_cache *cgw_cache __read_mostly;
 
 /* structure that contains the (on-the-fly) CAN frame modifications */
@@ -438,16 +437,16 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 		gwj->handled_frames++;
 }
 
-static inline int cgw_register_filter(struct cgw_job *gwj)
+static inline int cgw_register_filter(struct net *net, struct cgw_job *gwj)
 {
-	return can_rx_register(&init_net, gwj->src.dev, gwj->ccgw.filter.can_id,
+	return can_rx_register(net, gwj->src.dev, gwj->ccgw.filter.can_id,
 			       gwj->ccgw.filter.can_mask, can_can_gw_rcv,
 			       gwj, "gw", NULL);
 }
 
-static inline void cgw_unregister_filter(struct cgw_job *gwj)
+static inline void cgw_unregister_filter(struct net *net, struct cgw_job *gwj)
 {
-	can_rx_unregister(&init_net, gwj->src.dev, gwj->ccgw.filter.can_id,
+	can_rx_unregister(net, gwj->src.dev, gwj->ccgw.filter.can_id,
 			  gwj->ccgw.filter.can_mask, can_can_gw_rcv, gwj);
 }
 
@@ -455,9 +454,8 @@ static int cgw_notifier(struct notifier_block *nb,
 			unsigned long msg, void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct net *net = dev_net(dev);
 
-	if (!net_eq(dev_net(dev), &init_net))
-		return NOTIFY_DONE;
 	if (dev->type != ARPHRD_CAN)
 		return NOTIFY_DONE;
 
@@ -468,11 +466,11 @@ static int cgw_notifier(struct notifier_block *nb,
 
 		ASSERT_RTNL();
 
-		hlist_for_each_entry_safe(gwj, nx, &cgw_list, list) {
+		hlist_for_each_entry_safe(gwj, nx, &net->can.cgw_list, list) {
 
 			if (gwj->src.dev == dev || gwj->dst.dev == dev) {
 				hlist_del(&gwj->list);
-				cgw_unregister_filter(gwj);
+				cgw_unregister_filter(net, gwj);
 				kmem_cache_free(cgw_cache, gwj);
 			}
 		}
@@ -592,12 +590,13 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
 /* Dump information about all CAN gateway jobs, in response to RTM_GETROUTE */
 static int cgw_dump_jobs(struct sk_buff *skb, struct netlink_callback *cb)
 {
+	struct net *net = sock_net(skb->sk);
 	struct cgw_job *gwj = NULL;
 	int idx = 0;
 	int s_idx = cb->args[0];
 
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(gwj, &cgw_list, list) {
+	hlist_for_each_entry_rcu(gwj, &net->can.cgw_list, list) {
 		if (idx < s_idx)
 			goto cont;
 
@@ -811,6 +810,7 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 
 static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh)
 {
+	struct net *net = sock_net(skb->sk);
 	struct rtcanmsg *r;
 	struct cgw_job *gwj;
 	struct cf_mod mod;
@@ -841,7 +841,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh)
 		ASSERT_RTNL();
 
 		/* check for updating an existing job with identical uid */
-		hlist_for_each_entry(gwj, &cgw_list, list) {
+		hlist_for_each_entry(gwj, &net->can.cgw_list, list) {
 
 			if (gwj->mod.uid != mod.uid)
 				continue;
@@ -879,7 +879,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh)
 
 	err = -ENODEV;
 
-	gwj->src.dev = __dev_get_by_index(&init_net, gwj->ccgw.src_idx);
+	gwj->src.dev = __dev_get_by_index(net, gwj->ccgw.src_idx);
 
 	if (!gwj->src.dev)
 		goto out;
@@ -887,7 +887,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh)
 	if (gwj->src.dev->type != ARPHRD_CAN)
 		goto out;
 
-	gwj->dst.dev = __dev_get_by_index(&init_net, gwj->ccgw.dst_idx);
+	gwj->dst.dev = __dev_get_by_index(net, gwj->ccgw.dst_idx);
 
 	if (!gwj->dst.dev)
 		goto out;
@@ -897,9 +897,9 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh)
 
 	ASSERT_RTNL();
 
-	err = cgw_register_filter(gwj);
+	err = cgw_register_filter(net, gwj);
 	if (!err)
-		hlist_add_head_rcu(&gwj->list, &cgw_list);
+		hlist_add_head_rcu(&gwj->list, &net->can.cgw_list);
 out:
 	if (err)
 		kmem_cache_free(cgw_cache, gwj);
@@ -907,22 +907,23 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh)
 	return err;
 }
 
-static void cgw_remove_all_jobs(void)
+static void cgw_remove_all_jobs(struct net *net)
 {
 	struct cgw_job *gwj = NULL;
 	struct hlist_node *nx;
 
 	ASSERT_RTNL();
 
-	hlist_for_each_entry_safe(gwj, nx, &cgw_list, list) {
+	hlist_for_each_entry_safe(gwj, nx, &net->can.cgw_list, list) {
 		hlist_del(&gwj->list);
-		cgw_unregister_filter(gwj);
+		cgw_unregister_filter(net, gwj);
 		kmem_cache_free(cgw_cache, gwj);
 	}
 }
 
 static int cgw_remove_job(struct sk_buff *skb, struct nlmsghdr *nlh)
 {
+	struct net *net = sock_net(skb->sk);
 	struct cgw_job *gwj = NULL;
 	struct hlist_node *nx;
 	struct rtcanmsg *r;
@@ -951,7 +952,7 @@ static int cgw_remove_job(struct sk_buff *skb, struct nlmsghdr *nlh)
 
 	/* two interface indices both set to 0 => remove all entries */
 	if (!ccgw.src_idx && !ccgw.dst_idx) {
-		cgw_remove_all_jobs();
+		cgw_remove_all_jobs(net);
 		return 0;
 	}
 
@@ -960,7 +961,7 @@ static int cgw_remove_job(struct sk_buff *skb, struct nlmsghdr *nlh)
 	ASSERT_RTNL();
 
 	/* remove only the first matching entry */
-	hlist_for_each_entry_safe(gwj, nx, &cgw_list, list) {
+	hlist_for_each_entry_safe(gwj, nx, &net->can.cgw_list, list) {
 
 		if (gwj->flags != r->flags)
 			continue;
@@ -983,7 +984,7 @@ static int cgw_remove_job(struct sk_buff *skb, struct nlmsghdr *nlh)
 			continue;
 
 		hlist_del(&gwj->list);
-		cgw_unregister_filter(gwj);
+		cgw_unregister_filter(net, gwj);
 		kmem_cache_free(cgw_cache, gwj);
 		err = 0;
 		break;
@@ -992,6 +993,26 @@ static int cgw_remove_job(struct sk_buff *skb, struct nlmsghdr *nlh)
 	return err;
 }
 
+static int __net_init cangw_pernet_init(struct net *net)
+{
+	INIT_HLIST_HEAD(&net->can.cgw_list);
+	return 0;
+}
+
+static void __net_exit cangw_pernet_exit(struct net *net)
+{
+	rtnl_lock();
+	cgw_remove_all_jobs(net);
+	rtnl_unlock();
+}
+
+static struct pernet_operations cangw_pernet_ops = {
+	.init = cangw_pernet_init,
+	.exit = cangw_pernet_exit,
+	.id = &cangw_net_id,
+	.size = 0,
+};
+
 static __init int cgw_module_init(void)
 {
 	/* sanitize given module parameter */
@@ -1000,6 +1021,7 @@ static __init int cgw_module_init(void)
 	pr_info("can: netlink gateway (rev " CAN_GW_VERSION ") max_hops=%d\n",
 		max_hops);
 
+	register_pernet_subsys(&cangw_pernet_ops);
 	cgw_cache = kmem_cache_create("can_gw", sizeof(struct cgw_job),
 				      0, 0, NULL);
 
@@ -1029,10 +1051,7 @@ static __exit void cgw_module_exit(void)
 
 	unregister_netdevice_notifier(&notifier);
 
-	rtnl_lock();
-	cgw_remove_all_jobs();
-	rtnl_unlock();
-
+	unregister_pernet_subsys(&cangw_pernet_ops);
 	rcu_barrier(); /* Wait for completion of call_rcu()'s */
 
 	kmem_cache_destroy(cgw_cache);
-- 
2.11.0

