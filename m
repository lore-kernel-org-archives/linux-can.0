From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [RFC PATCH 3/4] net: can: move shared data into net namespace
Date: Sun, 27 Sep 2015 18:22:37 +0000
Message-ID: <DB3PR05MB0924BD7A3C97079C5957466889400@DB3PR05MB0924.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0093.outbound.protection.outlook.com ([157.55.234.93]:44717
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752507AbbI0SW4 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 27 Sep 2015 14:22:56 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, John Ernberg <john.ernberg@actia.se>

---
 include/linux/can/core.h    |   4 +-
 include/net/af_can.h        |  27 ++--
 include/net/net_namespace.h |   4 +
 include/net/netns/can.h     |  20 +++
 net/can/af_can.c            | 141 ++++++++++++---------
 net/can/bcm.c               |  29 +++--
 net/can/gw.c                |  11 +-
 net/can/proc.c              | 295 ++++++++++++++++++++++++--------------------
 net/can/raw.c               |  31 +++--
 9 files changed, 330 insertions(+), 232 deletions(-)
 create mode 100644 include/net/netns/can.h

diff --git a/include/linux/can/core.h b/include/linux/can/core.h
index a087500..276d7b6 100644
--- a/include/linux/can/core.h
+++ b/include/linux/can/core.h
@@ -48,12 +48,12 @@ extern void can_proto_unregister(const struct can_proto *cp);
 extern int  can_rx_register(struct net_device *dev, canid_t can_id,
 			    canid_t mask,
 			    void (*func)(struct sk_buff *, void *),
-			    void *data, char *ident);
+			    void *data, char *ident, struct net *net);
 
 extern void can_rx_unregister(struct net_device *dev, canid_t can_id,
 			      canid_t mask,
 			      void (*func)(struct sk_buff *, void *),
-			      void *data);
+			      void *data, struct net *net);
 
 extern int can_send(struct sk_buff *skb, int loop);
 extern int can_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
diff --git a/include/net/af_can.h b/include/net/af_can.h
index d9e8952..b3e1ecc 100644
--- a/include/net/af_can.h
+++ b/include/net/af_can.h
@@ -41,7 +41,7 @@
 #define __LINUX_NET_AF_CAN_H__
 
 #include <linux/skbuff.h>
-#include <linux/netdevice.h>
+#include <net/net_namespace.h>
 #include <linux/list.h>
 #include <linux/rcupdate.h>
 #include <linux/can.h>
@@ -109,18 +109,23 @@ struct can_pstats {
 	unsigned long rcv_entries_max;
 };
 
-/* receive filters subscribed for 'all' CAN devices */
-extern struct can_dev_rcv_lists can_rx_alldev_list;
+struct can_proc {
+	struct proc_dir_entry *can_dir;
+	struct proc_dir_entry *version;
+	struct proc_dir_entry *stats;
+	struct proc_dir_entry *reset_stats;
+	struct proc_dir_entry *rcvlist_all;
+	struct proc_dir_entry *rcvlist_fil;
+	struct proc_dir_entry *rcvlist_inv;
+	struct proc_dir_entry *rcvlist_sff;
+	struct proc_dir_entry *rcvlist_eff;
+	struct proc_dir_entry *rcvlist_err;
+	int                    user_reset;
+};
 
 /* function prototypes for the CAN networklayer procfs (proc.c) */
-void can_init_proc(void);
-void can_remove_proc(void);
+void can_init_proc(struct net* net);
+void can_remove_proc(struct net* net);
 void can_stat_update(unsigned long data);
 
-/* structures and variables from af_can.c needed in proc.c for reading */
-extern struct timer_list can_stattimer;    /* timer for statistics update */
-extern struct can_stats  can_stats;        /* packet statistics */
-extern struct can_pstats can_pstats;       /* receive list statistics */
-extern struct hlist_head can_rx_dev_list;  /* rx dispatcher structures */
-
 #endif /* __LINUX_NET_AF_CAN_H__ */
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 2dcea63..2218eec 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -27,6 +27,7 @@
 #include <net/netns/nftables.h>
 #include <net/netns/xfrm.h>
 #include <net/netns/mpls.h>
+#include <net/netns/can.h>
 #include <linux/ns_common.h>
 #include <linux/idr.h>
 #include <linux/skbuff.h>
@@ -137,6 +138,9 @@ struct net {
 #if IS_ENABLED(CONFIG_MPLS)
 	struct netns_mpls	mpls;
 #endif
+#if IS_ENABLED(CONFIG_CAN)
+	struct netns_can        can;
+#endif
 	struct sock		*diag_nlsk;
 	atomic_t		fnhe_genid;
 };
diff --git a/include/net/netns/can.h b/include/net/netns/can.h
new file mode 100644
index 0000000..2037f2b
--- /dev/null
+++ b/include/net/netns/can.h
@@ -0,0 +1,20 @@
+/*
+ * CAN network namespace
+ */
+#ifndef __NETNS_CAN_H__
+#define __NETNS_CAN_H__
+
+#include <linux/timer.h>
+#include <net/af_can.h>
+#include <linux/proc_fs.h>
+
+struct netns_can {
+	struct timer_list        can_stattimer;
+	struct can_stats         can_stats;
+	struct can_pstats        can_pstats;
+	struct hlist_head        can_rx_dev_list;
+	struct can_proc          can_proc;
+	struct can_dev_rcv_lists can_rx_alldev_list;
+};
+
+#endif /* __NETNS_CAN_H__ */
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 73f1cb8..aaeb93a 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -76,7 +76,6 @@ module_param(stats_timer, int, S_IRUGO);
 MODULE_PARM_DESC(stats_timer, "enable timer for statistics (default:on)");
 
 /* receive filters subscribed for 'all' CAN devices */
-struct can_dev_rcv_lists can_rx_alldev_list;
 static DEFINE_SPINLOCK(can_rcvlists_lock);
 
 static struct kmem_cache *rcv_cache __read_mostly;
@@ -85,10 +84,6 @@ static struct kmem_cache *rcv_cache __read_mostly;
 static const struct can_proto *proto_tab[CAN_NPROTO] __read_mostly;
 static DEFINE_MUTEX(proto_tab_lock);
 
-struct timer_list can_stattimer;   /* timer for statistics update */
-struct can_stats  can_stats;       /* packet statistics */
-struct can_pstats can_pstats;      /* receive list statistics */
-
 static atomic_t skbcounter = ATOMIC_INIT(0);
 
 /*
@@ -226,6 +221,7 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
  */
 int can_send(struct sk_buff *skb, int loop)
 {
+	struct net* net = sock_net(skb->sk);
 	struct sk_buff *newskb = NULL;
 	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
 	int err = -EINVAL;
@@ -316,8 +312,8 @@ int can_send(struct sk_buff *skb, int loop)
 		netif_rx_ni(newskb);
 
 	/* update statistics */
-	can_stats.tx_frames++;
-	can_stats.tx_frames_delta++;
+	net->can.can_stats.tx_frames++;
+	net->can.can_stats.tx_frames_delta++;
 
 	return 0;
 
@@ -331,10 +327,11 @@ EXPORT_SYMBOL(can_send);
  * af_can rx path
  */
 
-static struct can_dev_rcv_lists *find_dev_rcv_lists(struct net_device *dev)
+static struct can_dev_rcv_lists *find_dev_rcv_lists(struct net_device *dev,
+						    struct net* net)
 {
 	if (!dev)
-		return &can_rx_alldev_list;
+		return &net->can.can_rx_alldev_list;
 	else
 		return (struct can_dev_rcv_lists *)dev->ml_priv;
 }
@@ -468,7 +465,7 @@ static struct hlist_head *find_rcv_list(canid_t *can_id, canid_t *mask,
  */
 int can_rx_register(struct net_device *dev, canid_t can_id, canid_t mask,
 		    void (*func)(struct sk_buff *, void *), void *data,
-		    char *ident)
+		    char *ident, struct net *net)
 {
 	struct can_receiver *r;
 	struct hlist_head *rl;
@@ -486,7 +483,7 @@ int can_rx_register(struct net_device *dev, canid_t can_id, canid_t mask,
 
 	spin_lock(&can_rcvlists_lock);
 
-	d = find_dev_rcv_lists(dev);
+	d = find_dev_rcv_lists(dev, net);
 	if (d) {
 		rl = find_rcv_list(&can_id, &mask, d);
 
@@ -500,9 +497,9 @@ int can_rx_register(struct net_device *dev, canid_t can_id, canid_t mask,
 		hlist_add_head_rcu(&r->list, rl);
 		d->entries++;
 
-		can_pstats.rcv_entries++;
-		if (can_pstats.rcv_entries_max < can_pstats.rcv_entries)
-			can_pstats.rcv_entries_max = can_pstats.rcv_entries;
+		net->can.can_pstats.rcv_entries++;
+		if (net->can.can_pstats.rcv_entries_max < net->can.can_pstats.rcv_entries)
+			net->can.can_pstats.rcv_entries_max = net->can.can_pstats.rcv_entries;
 	} else {
 		kmem_cache_free(rcv_cache, r);
 		err = -ENODEV;
@@ -536,7 +533,8 @@ static void can_rx_delete_receiver(struct rcu_head *rp)
  *  Removes subscription entry depending on given (subscription) values.
  */
 void can_rx_unregister(struct net_device *dev, canid_t can_id, canid_t mask,
-		       void (*func)(struct sk_buff *, void *), void *data)
+		       void (*func)(struct sk_buff *, void *), void *data,
+		       struct net *net)
 {
 	struct can_receiver *r = NULL;
 	struct hlist_head *rl;
@@ -547,7 +545,7 @@ void can_rx_unregister(struct net_device *dev, canid_t can_id, canid_t mask,
 
 	spin_lock(&can_rcvlists_lock);
 
-	d = find_dev_rcv_lists(dev);
+	d = find_dev_rcv_lists(dev, net);
 	if (!d) {
 		pr_err("BUG: receive list not found for "
 		       "dev %s, id %03X, mask %03X\n",
@@ -583,8 +581,8 @@ void can_rx_unregister(struct net_device *dev, canid_t can_id, canid_t mask,
 	hlist_del_rcu(&r->list);
 	d->entries--;
 
-	if (can_pstats.rcv_entries > 0)
-		can_pstats.rcv_entries--;
+	if (net->can.can_pstats.rcv_entries > 0)
+		net->can.can_pstats.rcv_entries--;
 
 	/* remove device structure requested by NETDEV_UNREGISTER */
 	if (d->remove_on_zero_entries && !d->entries) {
@@ -674,12 +672,13 @@ static int can_rcv_filter(struct can_dev_rcv_lists *d, struct sk_buff *skb)
 
 static void can_receive(struct sk_buff *skb, struct net_device *dev)
 {
+	struct net *net = dev_net(dev);
 	struct can_dev_rcv_lists *d;
 	int matches;
 
 	/* update statistics */
-	can_stats.rx_frames++;
-	can_stats.rx_frames_delta++;
+	net->can.can_stats.rx_frames++;
+	net->can.can_stats.rx_frames_delta++;
 
 	/* create non-zero unique skb identifier together with *skb */
 	while (!(can_skb_prv(skb)->skbcnt))
@@ -688,10 +687,10 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 	rcu_read_lock();
 
 	/* deliver the packet to sockets listening on all devices */
-	matches = can_rcv_filter(&can_rx_alldev_list, skb);
+	matches = can_rcv_filter(&net->can.can_rx_alldev_list, skb);
 
 	/* find receive list for this device */
-	d = find_dev_rcv_lists(dev);
+	d = find_dev_rcv_lists(dev, net);
 	if (d)
 		matches += can_rcv_filter(d, skb);
 
@@ -701,8 +700,8 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
 	consume_skb(skb);
 
 	if (matches > 0) {
-		can_stats.matches++;
-		can_stats.matches_delta++;
+		net->can.can_stats.matches++;
+		net->can.can_stats.matches_delta++;
 	}
 }
 
@@ -894,8 +893,58 @@ static struct notifier_block can_netdev_notifier __read_mostly = {
 	.notifier_call = can_notifier,
 };
 
-static __init int can_init(void)
+static __net_init int can_init_net(struct net *net)
+{
+	memset(&net->can.can_rx_alldev_list, 0,
+	       sizeof(net->can.can_rx_alldev_list));
+
+	if (stats_timer) {
+		/* the statistics are updated every second (timer triggered) */
+		setup_timer(&net->can.can_stattimer, can_stat_update,
+			    (unsigned long)net);
+		mod_timer(&net->can.can_stattimer, round_jiffies(jiffies + HZ));
+	} else
+		net->can.can_stattimer.function = NULL;
+
+	can_init_proc(net);
+
+	return 0;
+}
+
+static __net_exit void can_exit_net(struct net *net)
 {
+	struct net_device *dev;
+
+	can_remove_proc(net);
+
+	if (stats_timer)
+		del_timer_sync(&net->can.can_stattimer);
+
+	/* remove created dev_rcv_lists from still registered CAN devices */
+	rcu_read_lock();
+	for_each_netdev_rcu(net, dev) {
+		if (dev->type == ARPHRD_CAN && dev->ml_priv) {
+			struct can_dev_rcv_lists *d = dev->ml_priv;
+
+			BUG_ON(d->entries);
+			kfree(d);
+			dev->ml_priv = NULL;
+		}
+	}
+	rcu_read_unlock();
+
+	rcu_barrier(); /* Wait for completion of call_rcu()'s */
+}
+
+static __net_initdata struct pernet_operations can_ops = {
+	.init = can_init_net,
+	.exit = can_exit_net
+};
+
+static int __init can_init(void)
+{
+	int rc;
+
 	/* check for correct padding to be able to use the structs similarly */
 	BUILD_BUG_ON(offsetof(struct can_frame, can_dlc) !=
 		     offsetof(struct canfd_frame, len) ||
@@ -904,21 +953,14 @@ static __init int can_init(void)
 
 	pr_info("can: controller area network core (" CAN_VERSION_STRING ")\n");
 
-	memset(&can_rx_alldev_list, 0, sizeof(can_rx_alldev_list));
-
 	rcv_cache = kmem_cache_create("can_receiver",
 				      sizeof(struct can_receiver), 0, 0, NULL);
 	if (!rcv_cache)
 		return -ENOMEM;
 
-	if (stats_timer) {
-		/* the statistics are updated every second (timer triggered) */
-		setup_timer(&can_stattimer, can_stat_update, 0);
-		mod_timer(&can_stattimer, round_jiffies(jiffies + HZ));
-	} else
-		can_stattimer.function = NULL;
-
-	can_init_proc();
+	rc = register_pernet_subsys(&can_ops);
+	if (rc < 0)
+		goto failure;
 
 	/* protocol register */
 	sock_register(&can_family_ops);
@@ -927,38 +969,21 @@ static __init int can_init(void)
 	dev_add_pack(&canfd_packet);
 
 	return 0;
+
+failure:
+	kmem_cache_destroy(rcv_cache);
+	return rc;
 }
 
-static __exit void can_exit(void)
+static void __exit can_exit(void)
 {
-	struct net_device *dev;
-
-	if (stats_timer)
-		del_timer_sync(&can_stattimer);
-
-	can_remove_proc();
-
 	/* protocol unregister */
 	dev_remove_pack(&canfd_packet);
 	dev_remove_pack(&can_packet);
 	unregister_netdevice_notifier(&can_netdev_notifier);
 	sock_unregister(PF_CAN);
 
-	/* remove created dev_rcv_lists from still registered CAN devices */
-	rcu_read_lock();
-	for_each_netdev_rcu(&init_net, dev) {
-		if (dev->type == ARPHRD_CAN && dev->ml_priv) {
-
-			struct can_dev_rcv_lists *d = dev->ml_priv;
-
-			BUG_ON(d->entries);
-			kfree(d);
-			dev->ml_priv = NULL;
-		}
-	}
-	rcu_read_unlock();
-
-	rcu_barrier(); /* Wait for completion of call_rcu()'s */
+	unregister_pernet_subsys(&can_ops);
 
 	kmem_cache_destroy(rcv_cache);
 }
diff --git a/net/can/bcm.c b/net/can/bcm.c
index a1ba687..2b70715 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -723,11 +723,12 @@ static void bcm_remove_op(struct bcm_op *op)
 	kfree(op);
 }
 
-static void bcm_rx_unreg(struct net_device *dev, struct bcm_op *op)
+static void bcm_rx_unreg(struct net_device *dev, struct bcm_op *op,
+			 struct net* net)
 {
 	if (op->rx_reg_dev == dev) {
 		can_rx_unregister(dev, op->can_id, REGMASK(op->can_id),
-				  bcm_rx_handler, op);
+				  bcm_rx_handler, op, net);
 
 		/* mark as removed subscription */
 		op->rx_reg_dev = NULL;
@@ -739,7 +740,8 @@ static void bcm_rx_unreg(struct net_device *dev, struct bcm_op *op)
 /*
  * bcm_delete_rx_op - find and remove a rx op (returns number of removed ops)
  */
-static int bcm_delete_rx_op(struct list_head *ops, canid_t can_id, int ifindex)
+static int bcm_delete_rx_op(struct list_head *ops, canid_t can_id, int ifindex,
+			    struct net* net)
 {
 	struct bcm_op *op, *n;
 
@@ -763,14 +765,14 @@ static int bcm_delete_rx_op(struct list_head *ops, canid_t can_id, int ifindex)
 					dev = dev_get_by_index(&init_net,
 							       op->ifindex);
 					if (dev) {
-						bcm_rx_unreg(dev, op);
+						bcm_rx_unreg(dev, op, net);
 						dev_put(dev);
 					}
 				}
 			} else
 				can_rx_unregister(NULL, op->can_id,
 						  REGMASK(op->can_id),
-						  bcm_rx_handler, op);
+						  bcm_rx_handler, op, net);
 
 			list_del(&op->list);
 			bcm_remove_op(op);
@@ -986,6 +988,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 			int ifindex, struct sock *sk)
 {
 	struct bcm_sock *bo = bcm_sk(sk);
+	struct net *net = sock_net(sk);
 	struct bcm_op *op;
 	int do_rx_register;
 	int err = 0;
@@ -1165,7 +1168,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 				err = can_rx_register(dev, op->can_id,
 						      REGMASK(op->can_id),
 						      bcm_rx_handler, op,
-						      "bcm");
+						      "bcm", net);
 
 				op->rx_reg_dev = dev;
 				dev_put(dev);
@@ -1174,7 +1177,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		} else
 			err = can_rx_register(NULL, op->can_id,
 					      REGMASK(op->can_id),
-					      bcm_rx_handler, op, "bcm");
+					      bcm_rx_handler, op, "bcm", net);
 		if (err) {
 			/* this bcm rx op is broken -> remove it */
 			list_del(&op->list);
@@ -1236,6 +1239,7 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk)
 static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
+	struct net *net = sock_net(sk);
 	struct bcm_sock *bo = bcm_sk(sk);
 	int ifindex = bo->ifindex; /* default ifindex for this bcm_op */
 	struct bcm_msg_head msg_head;
@@ -1305,7 +1309,8 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		break;
 
 	case RX_DELETE:
-		if (bcm_delete_rx_op(&bo->rx_ops, msg_head.can_id, ifindex))
+		if (bcm_delete_rx_op(&bo->rx_ops, msg_head.can_id, ifindex,
+				     net))
 			ret = MHSIZ;
 		else
 			ret = -EINVAL;
@@ -1350,6 +1355,7 @@ static int bcm_notifier(struct notifier_block *nb, unsigned long msg,
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct bcm_sock *bo = container_of(nb, struct bcm_sock, notifier);
 	struct sock *sk = &bo->sk;
+	struct net *net = sock_net(sk);
 	struct bcm_op *op;
 	int notify_enodev = 0;
 
@@ -1367,7 +1373,7 @@ static int bcm_notifier(struct notifier_block *nb, unsigned long msg,
 		/* remove device specific receive entries */
 		list_for_each_entry(op, &bo->rx_ops, list)
 			if (op->rx_reg_dev == dev)
-				bcm_rx_unreg(dev, op);
+				bcm_rx_unreg(dev, op, net);
 
 		/* remove device reference, if this is our bound device */
 		if (bo->bound && bo->ifindex == dev->ifindex) {
@@ -1425,6 +1431,7 @@ static int bcm_init(struct sock *sk)
 static int bcm_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
+	struct net *net = sock_net(sk);
 	struct bcm_sock *bo;
 	struct bcm_op *op, *next;
 
@@ -1458,14 +1465,14 @@ static int bcm_release(struct socket *sock)
 
 				dev = dev_get_by_index(&init_net, op->ifindex);
 				if (dev) {
-					bcm_rx_unreg(dev, op);
+					bcm_rx_unreg(dev, op, net);
 					dev_put(dev);
 				}
 			}
 		} else
 			can_rx_unregister(NULL, op->can_id,
 					  REGMASK(op->can_id),
-					  bcm_rx_handler, op);
+					  bcm_rx_handler, op, net);
 
 		bcm_remove_op(op);
 	}
diff --git a/net/can/gw.c b/net/can/gw.c
index 4551687..082a144 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -149,6 +149,7 @@ struct cgw_job {
 	u8 gwtype;
 	u8 limit_hops;
 	u16 flags;
+	struct net* net;
 };
 
 /* modification functions that are invoked in the hot path in can_can_gw_rcv */
@@ -442,13 +443,14 @@ static inline int cgw_register_filter(struct cgw_job *gwj)
 {
 	return can_rx_register(gwj->src.dev, gwj->ccgw.filter.can_id,
 			       gwj->ccgw.filter.can_mask, can_can_gw_rcv,
-			       gwj, "gw");
+			       gwj, "gw", gwj->net);
 }
 
 static inline void cgw_unregister_filter(struct cgw_job *gwj)
 {
 	can_rx_unregister(gwj->src.dev, gwj->ccgw.filter.can_id,
-			  gwj->ccgw.filter.can_mask, can_can_gw_rcv, gwj);
+			  gwj->ccgw.filter.can_mask, can_can_gw_rcv, gwj,
+			  gwj->net);
 }
 
 static int cgw_notifier(struct notifier_block *nb,
@@ -872,6 +874,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh)
 	gwj->flags = r->flags;
 	gwj->gwtype = r->gwtype;
 	gwj->limit_hops = limhops;
+	gwj->net = sock_net(skb->sk);
 
 	/* insert already parsed information */
 	memcpy(&gwj->mod, &mod, sizeof(mod));
@@ -879,7 +882,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh)
 
 	err = -ENODEV;
 
-	gwj->src.dev = __dev_get_by_index(&init_net, gwj->ccgw.src_idx);
+	gwj->src.dev = __dev_get_by_index(gwj->net, gwj->ccgw.src_idx);
 
 	if (!gwj->src.dev)
 		goto out;
@@ -887,7 +890,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh)
 	if (gwj->src.dev->type != ARPHRD_CAN)
 		goto out;
 
-	gwj->dst.dev = __dev_get_by_index(&init_net, gwj->ccgw.dst_idx);
+	gwj->dst.dev = __dev_get_by_index(gwj->net, gwj->ccgw.dst_idx);
 
 	if (!gwj->dst.dev)
 		goto out;
diff --git a/net/can/proc.c b/net/can/proc.c
index 0f9f7dc..a80f5e5 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -45,6 +45,7 @@
 #include <linux/rcupdate.h>
 #include <linux/if_arp.h>
 #include <linux/can/core.h>
+#include <net/net_namespace.h>
 
 #include <net/af_can.h>
 
@@ -62,18 +63,6 @@
 #define CAN_PROC_RCVLIST_EFF "rcvlist_eff"
 #define CAN_PROC_RCVLIST_ERR "rcvlist_err"
 
-static struct proc_dir_entry *can_dir;
-static struct proc_dir_entry *pde_version;
-static struct proc_dir_entry *pde_stats;
-static struct proc_dir_entry *pde_reset_stats;
-static struct proc_dir_entry *pde_rcvlist_all;
-static struct proc_dir_entry *pde_rcvlist_fil;
-static struct proc_dir_entry *pde_rcvlist_inv;
-static struct proc_dir_entry *pde_rcvlist_sff;
-static struct proc_dir_entry *pde_rcvlist_eff;
-static struct proc_dir_entry *pde_rcvlist_err;
-
-static int user_reset;
 
 static const char rx_list_name[][8] = {
 	[RX_ERR] = "rx_err",
@@ -86,21 +75,21 @@ static const char rx_list_name[][8] = {
  * af_can statistics stuff
  */
 
-static void can_init_stats(void)
+static void can_init_stats(struct net *net)
 {
 	/*
 	 * This memset function is called from a timer context (when
 	 * can_stattimer is active which is the default) OR in a process
 	 * context (reading the proc_fs when can_stattimer is disabled).
 	 */
-	memset(&can_stats, 0, sizeof(can_stats));
-	can_stats.jiffies_init = jiffies;
+	memset(&net->can.can_stats, 0, sizeof(net->can.can_stats));
+	net->can.can_stats.jiffies_init = jiffies;
 
-	can_pstats.stats_reset++;
+	net->can.can_pstats.stats_reset++;
 
-	if (user_reset) {
-		user_reset = 0;
-		can_pstats.user_reset++;
+	if (net->can.can_proc.user_reset) {
+		net->can.can_proc.user_reset = 0;
+		net->can.can_pstats.user_reset++;
 	}
 }
 
@@ -126,64 +115,71 @@ static unsigned long calc_rate(unsigned long oldjif, unsigned long newjif,
 
 void can_stat_update(unsigned long data)
 {
+	struct net *net = (struct net *)data;
+
 	unsigned long j = jiffies; /* snapshot */
 
+	struct can_stats* can_stats = &net->can.can_stats;
+
 	/* restart counting in timer context on user request */
-	if (user_reset)
-		can_init_stats();
+	if (net->can.can_proc.user_reset)
+		can_init_stats(net);
 
 	/* restart counting on jiffies overflow */
-	if (j < can_stats.jiffies_init)
-		can_init_stats();
+	if (j < can_stats->jiffies_init)
+		can_init_stats(net);
 
 	/* prevent overflow in calc_rate() */
-	if (can_stats.rx_frames > (ULONG_MAX / HZ))
-		can_init_stats();
+	if (can_stats->rx_frames > (ULONG_MAX / HZ))
+		can_init_stats(net);
 
 	/* prevent overflow in calc_rate() */
-	if (can_stats.tx_frames > (ULONG_MAX / HZ))
-		can_init_stats();
+	if (can_stats->tx_frames > (ULONG_MAX / HZ))
+		can_init_stats(net);
 
 	/* matches overflow - very improbable */
-	if (can_stats.matches > (ULONG_MAX / 100))
-		can_init_stats();
+	if (can_stats->matches > (ULONG_MAX / 100))
+		can_init_stats(net);
 
 	/* calc total values */
-	if (can_stats.rx_frames)
-		can_stats.total_rx_match_ratio = (can_stats.matches * 100) /
-			can_stats.rx_frames;
+	if (can_stats->rx_frames)
+		can_stats->total_rx_match_ratio = (can_stats->matches * 100) /
+						  can_stats->rx_frames;
 
-	can_stats.total_tx_rate = calc_rate(can_stats.jiffies_init, j,
-					    can_stats.tx_frames);
-	can_stats.total_rx_rate = calc_rate(can_stats.jiffies_init, j,
-					    can_stats.rx_frames);
+	can_stats->total_tx_rate = calc_rate(can_stats->jiffies_init, j,
+					     can_stats->tx_frames);
+	can_stats->total_rx_rate = calc_rate(can_stats->jiffies_init, j,
+					     can_stats->rx_frames);
 
 	/* calc current values */
-	if (can_stats.rx_frames_delta)
-		can_stats.current_rx_match_ratio =
-			(can_stats.matches_delta * 100) /
-			can_stats.rx_frames_delta;
+	if (can_stats->rx_frames_delta)
+		can_stats->current_rx_match_ratio =
+			(can_stats->matches_delta * 100) /
+			can_stats->rx_frames_delta;
 
-	can_stats.current_tx_rate = calc_rate(0, HZ, can_stats.tx_frames_delta);
-	can_stats.current_rx_rate = calc_rate(0, HZ, can_stats.rx_frames_delta);
+	can_stats->current_tx_rate = calc_rate(0, HZ,
+					      can_stats->tx_frames_delta);
+	can_stats->current_rx_rate = calc_rate(0, HZ,
+					      can_stats->rx_frames_delta);
 
 	/* check / update maximum values */
-	if (can_stats.max_tx_rate < can_stats.current_tx_rate)
-		can_stats.max_tx_rate = can_stats.current_tx_rate;
+	if (can_stats->max_tx_rate < can_stats->current_tx_rate)
+		can_stats->max_tx_rate = can_stats->current_tx_rate;
 
-	if (can_stats.max_rx_rate < can_stats.current_rx_rate)
-		can_stats.max_rx_rate = can_stats.current_rx_rate;
+	if (can_stats->max_rx_rate < can_stats->current_rx_rate)
+		can_stats->max_rx_rate = can_stats->current_rx_rate;
 
-	if (can_stats.max_rx_match_ratio < can_stats.current_rx_match_ratio)
-		can_stats.max_rx_match_ratio = can_stats.current_rx_match_ratio;
+	if (can_stats->max_rx_match_ratio < can_stats->current_rx_match_ratio)
+		can_stats->max_rx_match_ratio =
+			can_stats->current_rx_match_ratio;
 
 	/* clear values for 'current rate' calculation */
-	can_stats.tx_frames_delta = 0;
-	can_stats.rx_frames_delta = 0;
-	can_stats.matches_delta   = 0;
+	can_stats->tx_frames_delta = 0;
+	can_stats->rx_frames_delta = 0;
+	can_stats->matches_delta   = 0;
 
 	/* restart timer (one second) */
-	mod_timer(&can_stattimer, round_jiffies(jiffies + HZ));
+	mod_timer(&net->can.can_stattimer, round_jiffies(jiffies + HZ));
 }
 
 /*
@@ -217,57 +213,61 @@ static void can_print_recv_banner(struct seq_file *m)
 
 static int can_stats_proc_show(struct seq_file *m, void *v)
 {
+	struct net *net = m->private;
+	struct can_stats *can_stats = &net->can.can_stats;
+	struct can_pstats *can_pstats = &net->can.can_pstats;
+
 	seq_putc(m, '\n');
-	seq_printf(m, " %8ld transmitted frames (TXF)\n", can_stats.tx_frames);
-	seq_printf(m, " %8ld received frames (RXF)\n", can_stats.rx_frames);
-	seq_printf(m, " %8ld matched frames (RXMF)\n", can_stats.matches);
+	seq_printf(m, " %8ld transmitted frames (TXF)\n", can_stats->tx_frames);
+	seq_printf(m, " %8ld received frames (RXF)\n", can_stats->rx_frames);
+	seq_printf(m, " %8ld matched frames (RXMF)\n", can_stats->matches);
 
 	seq_putc(m, '\n');
 
-	if (can_stattimer.function == can_stat_update) {
+	if (net->can.can_stattimer.function == can_stat_update) {
 		seq_printf(m, " %8ld %% total match ratio (RXMR)\n",
-				can_stats.total_rx_match_ratio);
+				can_stats->total_rx_match_ratio);
 
 		seq_printf(m, " %8ld frames/s total tx rate (TXR)\n",
-				can_stats.total_tx_rate);
+				can_stats->total_tx_rate);
 		seq_printf(m, " %8ld frames/s total rx rate (RXR)\n",
-				can_stats.total_rx_rate);
+				can_stats->total_rx_rate);
 
 		seq_putc(m, '\n');
 
 		seq_printf(m, " %8ld %% current match ratio (CRXMR)\n",
-				can_stats.current_rx_match_ratio);
+				can_stats->current_rx_match_ratio);
 
 		seq_printf(m, " %8ld frames/s current tx rate (CTXR)\n",
-				can_stats.current_tx_rate);
+				can_stats->current_tx_rate);
 		seq_printf(m, " %8ld frames/s current rx rate (CRXR)\n",
-				can_stats.current_rx_rate);
+				can_stats->current_rx_rate);
 
 		seq_putc(m, '\n');
 
 		seq_printf(m, " %8ld %% max match ratio (MRXMR)\n",
-				can_stats.max_rx_match_ratio);
+				can_stats->max_rx_match_ratio);
 
 		seq_printf(m, " %8ld frames/s max tx rate (MTXR)\n",
-				can_stats.max_tx_rate);
+				can_stats->max_tx_rate);
 		seq_printf(m, " %8ld frames/s max rx rate (MRXR)\n",
-				can_stats.max_rx_rate);
+				can_stats->max_rx_rate);
 
 		seq_putc(m, '\n');
 	}
 
 	seq_printf(m, " %8ld current receive list entries (CRCV)\n",
-			can_pstats.rcv_entries);
+			can_pstats->rcv_entries);
 	seq_printf(m, " %8ld maximum receive list entries (MRCV)\n",
-			can_pstats.rcv_entries_max);
+			can_pstats->rcv_entries_max);
 
-	if (can_pstats.stats_reset)
+	if (can_pstats->stats_reset)
 		seq_printf(m, "\n %8ld statistic resets (STR)\n",
-				can_pstats.stats_reset);
+				can_pstats->stats_reset);
 
-	if (can_pstats.user_reset)
+	if (can_pstats->user_reset)
 		seq_printf(m, " %8ld user statistic resets (USTR)\n",
-				can_pstats.user_reset);
+				can_pstats->user_reset);
 
 	seq_putc(m, '\n');
 	return 0;
@@ -275,7 +275,8 @@ static int can_stats_proc_show(struct seq_file *m, void *v)
 
 static int can_stats_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, can_stats_proc_show, NULL);
+	return single_open(file, can_stats_proc_show,
+			   proc_get_parent_data(inode));
 }
 
 static const struct file_operations can_stats_proc_fops = {
@@ -288,25 +289,29 @@ static const struct file_operations can_stats_proc_fops = {
 
 static int can_reset_stats_proc_show(struct seq_file *m, void *v)
 {
-	user_reset = 1;
+	struct net *net = m->private;
+	struct can_stats *can_stats = &net->can.can_stats;
+	struct can_pstats *can_pstats = &net->can.can_pstats;
+	net->can.can_proc.user_reset = 1;
 
-	if (can_stattimer.function == can_stat_update) {
+	if (net->can.can_stattimer.function == can_stat_update) {
 		seq_printf(m, "Scheduled statistic reset #%ld.\n",
-				can_pstats.stats_reset + 1);
+				can_pstats->stats_reset + 1);
 
 	} else {
-		if (can_stats.jiffies_init != jiffies)
-			can_init_stats();
+		if (can_stats->jiffies_init != jiffies)
+			can_init_stats(net);
 
 		seq_printf(m, "Performed statistic reset #%ld.\n",
-				can_pstats.stats_reset);
+				can_pstats->stats_reset);
 	}
 	return 0;
 }
 
 static int can_reset_stats_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, can_reset_stats_proc_show, NULL);
+	return single_open(file, can_reset_stats_proc_show,
+			   proc_get_parent_data(inode));
 }
 
 static const struct file_operations can_reset_stats_proc_fops = {
@@ -325,7 +330,8 @@ static int can_version_proc_show(struct seq_file *m, void *v)
 
 static int can_version_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, can_version_proc_show, NULL);
+	return single_open(file, can_version_proc_show,
+			   proc_get_parent_data(inode));
 }
 
 static const struct file_operations can_version_proc_fops = {
@@ -348,23 +354,25 @@ static inline void can_rcvlist_proc_show_one(struct seq_file *m, int idx,
 
 }
 
-static int can_rcvlist_proc_show(struct seq_file *m, void *v)
+static int can_rcvlist_proc_show(struct seq_file *m, void* v)
 {
 	/* double cast to prevent GCC warning */
-	int idx = (int)(long)m->private;
+	struct inode *inode = m->private;
+	int idx = (int)(long)PDE_DATA(inode);
 	struct net_device *dev;
 	struct can_dev_rcv_lists *d;
+	struct net *net = proc_get_parent_data(inode);
 
 	seq_printf(m, "\nreceive list '%s':\n", rx_list_name[idx]);
 
 	rcu_read_lock();
 
 	/* receive list for 'all' CAN devices (dev == NULL) */
-	d = &can_rx_alldev_list;
+	d = &net->can.can_rx_alldev_list;
 	can_rcvlist_proc_show_one(m, idx, NULL, d);
 
 	/* receive list for registered CAN devices */
-	for_each_netdev_rcu(&init_net, dev) {
+	for_each_netdev_rcu(net, dev) {
 		if (dev->type == ARPHRD_CAN && dev->ml_priv)
 			can_rcvlist_proc_show_one(m, idx, dev, dev->ml_priv);
 	}
@@ -377,7 +385,7 @@ static int can_rcvlist_proc_show(struct seq_file *m, void *v)
 
 static int can_rcvlist_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, can_rcvlist_proc_show, PDE_DATA(inode));
+	return single_open(file, can_rcvlist_proc_show, inode);
 }
 
 static const struct file_operations can_rcvlist_proc_fops = {
@@ -417,6 +425,7 @@ static int can_rcvlist_sff_proc_show(struct seq_file *m, void *v)
 {
 	struct net_device *dev;
 	struct can_dev_rcv_lists *d;
+	struct net *net = m->private;
 
 	/* RX_SFF */
 	seq_puts(m, "\nreceive list 'rx_sff':\n");
@@ -424,11 +433,11 @@ static int can_rcvlist_sff_proc_show(struct seq_file *m, void *v)
 	rcu_read_lock();
 
 	/* sff receive list for 'all' CAN devices (dev == NULL) */
-	d = &can_rx_alldev_list;
+	d = &net->can.can_rx_alldev_list;
 	can_rcvlist_proc_show_array(m, NULL, d->rx_sff, ARRAY_SIZE(d->rx_sff));
 
 	/* sff receive list for registered CAN devices */
-	for_each_netdev_rcu(&init_net, dev) {
+	for_each_netdev_rcu(net, dev) {
 		if (dev->type == ARPHRD_CAN && dev->ml_priv) {
 			d = dev->ml_priv;
 			can_rcvlist_proc_show_array(m, dev, d->rx_sff,
@@ -444,7 +453,8 @@ static int can_rcvlist_sff_proc_show(struct seq_file *m, void *v)
 
 static int can_rcvlist_sff_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, can_rcvlist_sff_proc_show, NULL);
+	return single_open(file, can_rcvlist_sff_proc_show,
+			   proc_get_parent_data(inode));
 }
 
 static const struct file_operations can_rcvlist_sff_proc_fops = {
@@ -460,6 +470,7 @@ static int can_rcvlist_eff_proc_show(struct seq_file *m, void *v)
 {
 	struct net_device *dev;
 	struct can_dev_rcv_lists *d;
+	struct net *net = m->private;
 
 	/* RX_EFF */
 	seq_puts(m, "\nreceive list 'rx_eff':\n");
@@ -467,11 +478,11 @@ static int can_rcvlist_eff_proc_show(struct seq_file *m, void *v)
 	rcu_read_lock();
 
 	/* eff receive list for 'all' CAN devices (dev == NULL) */
-	d = &can_rx_alldev_list;
+	d = &net->can.can_rx_alldev_list;
 	can_rcvlist_proc_show_array(m, NULL, d->rx_eff, ARRAY_SIZE(d->rx_eff));
 
 	/* eff receive list for registered CAN devices */
-	for_each_netdev_rcu(&init_net, dev) {
+	for_each_netdev_rcu(net, dev) {
 		if (dev->type == ARPHRD_CAN && dev->ml_priv) {
 			d = dev->ml_priv;
 			can_rcvlist_proc_show_array(m, dev, d->rx_eff,
@@ -487,7 +498,8 @@ static int can_rcvlist_eff_proc_show(struct seq_file *m, void *v)
 
 static int can_rcvlist_eff_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, can_rcvlist_eff_proc_show, NULL);
+	return single_open(file, can_rcvlist_eff_proc_show,
+			   proc_get_parent_data(inode));
 }
 
 static const struct file_operations can_rcvlist_eff_proc_fops = {
@@ -502,19 +514,22 @@ static const struct file_operations can_rcvlist_eff_proc_fops = {
  * proc utility functions
  */
 
-static void can_remove_proc_readentry(const char *name)
+static void can_remove_proc_readentry(struct net* net, const char *name)
 {
-	if (can_dir)
-		remove_proc_entry(name, can_dir);
+	if (net->can.can_proc.can_dir)
+		remove_proc_entry(name, net->can.can_proc.can_dir);
 }
 
 /*
  * can_init_proc - create main CAN proc directory and procfs entries
  */
-void can_init_proc(void)
+void can_init_proc(struct net *net)
 {
 	/* create /proc/net/can directory */
-	can_dir = proc_mkdir("can", init_net.proc_net);
+	struct proc_dir_entry *can_dir;
+	struct can_proc *pde;
+
+	can_dir = proc_net_mkdir(net, "can", net->proc_net);
 
 	if (!can_dir) {
 		printk(KERN_INFO "can: failed to create /proc/net/can . "
@@ -522,59 +537,69 @@ void can_init_proc(void)
 		return;
 	}
 
+	net->can.can_proc.can_dir = can_dir;
+
+	pde = &net->can.can_proc;
+
 	/* own procfs entries from the AF_CAN core */
-	pde_version     = proc_create(CAN_PROC_VERSION, 0644, can_dir,
-				      &can_version_proc_fops);
-	pde_stats       = proc_create(CAN_PROC_STATS, 0644, can_dir,
-				      &can_stats_proc_fops);
-	pde_reset_stats = proc_create(CAN_PROC_RESET_STATS, 0644, can_dir,
-				      &can_reset_stats_proc_fops);
-	pde_rcvlist_err = proc_create_data(CAN_PROC_RCVLIST_ERR, 0644, can_dir,
-					   &can_rcvlist_proc_fops, (void *)RX_ERR);
-	pde_rcvlist_all = proc_create_data(CAN_PROC_RCVLIST_ALL, 0644, can_dir,
-					   &can_rcvlist_proc_fops, (void *)RX_ALL);
-	pde_rcvlist_fil = proc_create_data(CAN_PROC_RCVLIST_FIL, 0644, can_dir,
-					   &can_rcvlist_proc_fops, (void *)RX_FIL);
-	pde_rcvlist_inv = proc_create_data(CAN_PROC_RCVLIST_INV, 0644, can_dir,
-					   &can_rcvlist_proc_fops, (void *)RX_INV);
-	pde_rcvlist_eff = proc_create(CAN_PROC_RCVLIST_EFF, 0644, can_dir,
-				      &can_rcvlist_eff_proc_fops);
-	pde_rcvlist_sff = proc_create(CAN_PROC_RCVLIST_SFF, 0644, can_dir,
-				      &can_rcvlist_sff_proc_fops);
+	pde->version     = proc_create(CAN_PROC_VERSION, 0644, can_dir,
+				       &can_version_proc_fops);
+	pde->stats       = proc_create(CAN_PROC_STATS, 0644, can_dir,
+				       &can_stats_proc_fops);
+	pde->reset_stats = proc_create(CAN_PROC_RESET_STATS, 0644, can_dir,
+				       &can_reset_stats_proc_fops);
+	pde->rcvlist_err = proc_create_data(CAN_PROC_RCVLIST_ERR, 0644, can_dir,
+					    &can_rcvlist_proc_fops,
+					    (void *)RX_ERR);
+	pde->rcvlist_all = proc_create_data(CAN_PROC_RCVLIST_ALL, 0644, can_dir,
+					    &can_rcvlist_proc_fops,
+					    (void *)RX_ALL);
+	pde->rcvlist_fil = proc_create_data(CAN_PROC_RCVLIST_FIL, 0644, can_dir,
+					    &can_rcvlist_proc_fops,
+					    (void *)RX_FIL);
+	pde->rcvlist_inv = proc_create_data(CAN_PROC_RCVLIST_INV, 0644, can_dir,
+					    &can_rcvlist_proc_fops,
+					    (void *)RX_INV);
+	pde->rcvlist_eff = proc_create(CAN_PROC_RCVLIST_EFF, 0644, can_dir,
+				       &can_rcvlist_eff_proc_fops);
+	pde->rcvlist_sff = proc_create(CAN_PROC_RCVLIST_SFF, 0644, can_dir,
+				       &can_rcvlist_sff_proc_fops);
 }
 
 /*
  * can_remove_proc - remove procfs entries and main CAN proc directory
  */
-void can_remove_proc(void)
+void can_remove_proc(struct net *net)
 {
-	if (pde_version)
-		can_remove_proc_readentry(CAN_PROC_VERSION);
+	struct can_proc *pde = &net->can.can_proc;
+
+	if (pde->version)
+		can_remove_proc_readentry(net, CAN_PROC_VERSION);
 
-	if (pde_stats)
-		can_remove_proc_readentry(CAN_PROC_STATS);
+	if (pde->stats)
+		can_remove_proc_readentry(net, CAN_PROC_STATS);
 
-	if (pde_reset_stats)
-		can_remove_proc_readentry(CAN_PROC_RESET_STATS);
+	if (pde->reset_stats)
+		can_remove_proc_readentry(net, CAN_PROC_RESET_STATS);
 
-	if (pde_rcvlist_err)
-		can_remove_proc_readentry(CAN_PROC_RCVLIST_ERR);
+	if (pde->rcvlist_err)
+		can_remove_proc_readentry(net, CAN_PROC_RCVLIST_ERR);
 
-	if (pde_rcvlist_all)
-		can_remove_proc_readentry(CAN_PROC_RCVLIST_ALL);
+	if (pde->rcvlist_all)
+		can_remove_proc_readentry(net, CAN_PROC_RCVLIST_ALL);
 
-	if (pde_rcvlist_fil)
-		can_remove_proc_readentry(CAN_PROC_RCVLIST_FIL);
+	if (pde->rcvlist_fil)
+		can_remove_proc_readentry(net, CAN_PROC_RCVLIST_FIL);
 
-	if (pde_rcvlist_inv)
-		can_remove_proc_readentry(CAN_PROC_RCVLIST_INV);
+	if (pde->rcvlist_inv)
+		can_remove_proc_readentry(net, CAN_PROC_RCVLIST_INV);
 
-	if (pde_rcvlist_eff)
-		can_remove_proc_readentry(CAN_PROC_RCVLIST_EFF);
+	if (pde->rcvlist_eff)
+		can_remove_proc_readentry(net, CAN_PROC_RCVLIST_EFF);
 
-	if (pde_rcvlist_sff)
-		can_remove_proc_readentry(CAN_PROC_RCVLIST_SFF);
+	if (pde->rcvlist_sff)
+		can_remove_proc_readentry(net, CAN_PROC_RCVLIST_SFF);
 
-	if (can_dir)
-		remove_proc_entry("can", init_net.proc_net);
+	if (pde->can_dir)
+		remove_proc_entry("can", net->proc_net);
 }
diff --git a/net/can/raw.c b/net/can/raw.c
index 2e67b14..c5c0cb9 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -184,19 +184,20 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 static int raw_enable_filters(struct net_device *dev, struct sock *sk,
 			      struct can_filter *filter, int count)
 {
+	struct net *net = sock_net(sk);
 	int err = 0;
 	int i;
 
 	for (i = 0; i < count; i++) {
 		err = can_rx_register(dev, filter[i].can_id,
 				      filter[i].can_mask,
-				      raw_rcv, sk, "raw");
+				      raw_rcv, sk, "raw", net);
 		if (err) {
 			/* clean up successfully registered filters */
 			while (--i >= 0)
 				can_rx_unregister(dev, filter[i].can_id,
 						  filter[i].can_mask,
-						  raw_rcv, sk);
+						  raw_rcv, sk, net);
 			break;
 		}
 	}
@@ -207,11 +208,12 @@ static int raw_enable_filters(struct net_device *dev, struct sock *sk,
 static int raw_enable_errfilter(struct net_device *dev, struct sock *sk,
 				can_err_mask_t err_mask)
 {
+	struct net *net = sock_net(sk);
 	int err = 0;
 
 	if (err_mask)
 		err = can_rx_register(dev, 0, err_mask | CAN_ERR_FLAG,
-				      raw_rcv, sk, "raw");
+				      raw_rcv, sk, "raw", net);
 
 	return err;
 }
@@ -219,11 +221,12 @@ static int raw_enable_errfilter(struct net_device *dev, struct sock *sk,
 static void raw_disable_filters(struct net_device *dev, struct sock *sk,
 			      struct can_filter *filter, int count)
 {
+	struct net *net = sock_net(sk);
 	int i;
 
 	for (i = 0; i < count; i++)
 		can_rx_unregister(dev, filter[i].can_id, filter[i].can_mask,
-				  raw_rcv, sk);
+				  raw_rcv, sk, net);
 }
 
 static inline void raw_disable_errfilter(struct net_device *dev,
@@ -231,9 +234,11 @@ static inline void raw_disable_errfilter(struct net_device *dev,
 					 can_err_mask_t err_mask)
 
 {
+	struct net *net = sock_net(sk);
+
 	if (err_mask)
 		can_rx_unregister(dev, 0, err_mask | CAN_ERR_FLAG,
-				  raw_rcv, sk);
+				  raw_rcv, sk, net);
 }
 
 static inline void raw_disable_allfilters(struct net_device *dev,
@@ -342,6 +347,7 @@ static int raw_init(struct sock *sk)
 static int raw_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
+	struct net *net = sock_net(sk);
 	struct raw_sock *ro;
 
 	if (!sk)
@@ -358,7 +364,7 @@ static int raw_release(struct socket *sock)
 		if (ro->ifindex) {
 			struct net_device *dev;
 
-			dev = dev_get_by_index(&init_net, ro->ifindex);
+			dev = dev_get_by_index(net, ro->ifindex);
 			if (dev) {
 				raw_disable_allfilters(dev, sk);
 				dev_put(dev);
@@ -389,6 +395,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
+	struct net *net = sock_net(sk);
 	int ifindex;
 	int err = 0;
 	int notify_enetdown = 0;
@@ -404,7 +411,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 	if (addr->can_ifindex) {
 		struct net_device *dev;
 
-		dev = dev_get_by_index(&init_net, addr->can_ifindex);
+		dev = dev_get_by_index(net, addr->can_ifindex);
 		if (!dev) {
 			err = -ENODEV;
 			goto out;
@@ -435,7 +442,7 @@ static int raw_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 			if (ro->ifindex) {
 				struct net_device *dev;
 
-				dev = dev_get_by_index(&init_net, ro->ifindex);
+				dev = dev_get_by_index(net, ro->ifindex);
 				if (dev) {
 					raw_disable_allfilters(dev, sk);
 					dev_put(dev);
@@ -483,6 +490,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
+	struct net *net = sock_net(sk);
 	struct can_filter *filter = NULL;  /* dyn. alloc'ed filters */
 	struct can_filter sfilter;         /* single filter */
 	struct net_device *dev = NULL;
@@ -514,7 +522,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		lock_sock(sk);
 
 		if (ro->bound && ro->ifindex)
-			dev = dev_get_by_index(&init_net, ro->ifindex);
+			dev = dev_get_by_index(net, ro->ifindex);
 
 		if (ro->bound) {
 			/* (try to) register the new filters */
@@ -566,7 +574,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		lock_sock(sk);
 
 		if (ro->bound && ro->ifindex)
-			dev = dev_get_by_index(&init_net, ro->ifindex);
+			dev = dev_get_by_index(net, ro->ifindex);
 
 		/* remove current error mask */
 		if (ro->bound) {
@@ -711,6 +719,7 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
+	struct net *net = sock_net(sk);
 	struct raw_sock *ro = raw_sk(sk);
 	struct sk_buff *skb;
 	struct net_device *dev;
@@ -738,7 +747,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			return -EINVAL;
 	}
 
-	dev = dev_get_by_index(&init_net, ifindex);
+	dev = dev_get_by_index(net, ifindex);
 	if (!dev)
 		return -ENXIO;
 
-- 
2.5.3

