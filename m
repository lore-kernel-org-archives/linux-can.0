From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH] j1939: initial namespace support
Date: Fri, 16 Feb 2018 08:31:37 +0100
Message-ID: <20180216073137.17509-1-o.rempel@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35973 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753636AbeBPHbl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Feb 2018 02:31:41 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: ecathinds@gmail.com, linux-can@vger.kernel.org
Cc: Oleksij Rempel <linux@rempel-privat.de>, Oleksij Rempel <o.rempel@pengutronix.de>

From: Oleksij Rempel <linux@rempel-privat.de>

move all transport local variables to can_j1939 namespace

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/net/net_namespace.h   |   4 +
 include/net/netns/can_j1939.h |  22 +++
 net/can/j1939/address-claim.c |   8 +-
 net/can/j1939/bus.c           |   8 +-
 net/can/j1939/j1939-priv.h    |  14 +-
 net/can/j1939/main.c          |  27 ++--
 net/can/j1939/socket.c        |  12 +-
 net/can/j1939/transport.c     | 320 ++++++++++++++++++++++--------------------
 8 files changed, 232 insertions(+), 183 deletions(-)
 create mode 100644 include/net/netns/can_j1939.h

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index f306b2aa15a4..9722a692c3cf 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -30,6 +30,7 @@
 #include <net/netns/xfrm.h>
 #include <net/netns/mpls.h>
 #include <net/netns/can.h>
+#include <net/netns/can_j1939.h>
 #include <linux/ns_common.h>
 #include <linux/idr.h>
 #include <linux/skbuff.h>
@@ -147,6 +148,9 @@ struct net {
 #endif
 #if IS_ENABLED(CONFIG_CAN)
 	struct netns_can	can;
+#endif
+#if IS_ENABLED(CONFIG_CAN_J1939)
+	struct netns_can_j1939	can_j1939;
 #endif
 	struct sock		*diag_nlsk;
 	atomic_t		fnhe_genid;
diff --git a/include/net/netns/can_j1939.h b/include/net/netns/can_j1939.h
new file mode 100644
index 000000000000..d5659ece15d4
--- /dev/null
+++ b/include/net/netns/can_j1939.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * can in net namespaces
+ */
+
+#ifndef __NETNS_CAN_J1939_H__
+#define __NETNS_CAN_J1939_H__
+
+struct netns_can_j1939 {
+#if IS_ENABLED(CONFIG_PROC_FS)
+	struct ctl_table_header *sysctl_hdr;
+#endif
+	spinlock_t tp_lock;
+	struct list_head	tp_sessionq;
+	struct list_head	tp_extsessionq;
+	spinlock_t		tp_dellock;
+	struct list_head	tp_delsessionq;
+	struct work_struct	tp_delwork;
+	wait_queue_head_t	tp_wait;
+};
+
+#endif /* __NETNS_CAN_J1939_H__ */
diff --git a/net/can/j1939/address-claim.c b/net/can/j1939/address-claim.c
index 19e0bcf3e91f..eab37a624c2d 100644
--- a/net/can/j1939/address-claim.c
+++ b/net/can/j1939/address-claim.c
@@ -78,9 +78,9 @@ static int j1939_verify_outgoing_address_claim(struct sk_buff *skb)
 
 int j1939_fixup_address_claim(struct sk_buff *skb)
 {
+	struct j1939_sk_buff_cb *skcb = j1939_get_cb(skb);
 	int ret;
 	u8 sa;
-	struct j1939_sk_buff_cb *skcb = j1939_get_cb(skb);
 
 	/* network mgmt: address claiming msgs */
 	if (skcb->addr.pgn == PGN_ADDRESS_CLAIMED) {
@@ -90,7 +90,7 @@ int j1939_fixup_address_claim(struct sk_buff *skb)
 		/* return both when failure & when successful */
 		if (ret < 0)
 			return ret;
-		ecu = j1939_ecu_find_by_name(skcb->addr.src_name,
+		ecu = j1939_ecu_find_by_name(sock_net(skb->sk), skcb->addr.src_name,
 					     skb->dev->ifindex);
 		if (!ecu)
 			return -ENODEV;
@@ -101,7 +101,7 @@ int j1939_fixup_address_claim(struct sk_buff *skb)
 		put_j1939_ecu(ecu);
 	} else if (skcb->addr.src_name) {
 		/* assign source address */
-		sa = j1939_name_to_sa(skcb->addr.src_name, skb->dev->ifindex);
+		sa = j1939_name_to_sa(sock_net(skb->sk), skcb->addr.src_name, skb->dev->ifindex);
 		if (!j1939_address_is_unicast(sa) &&
 		    !ac_msg_is_request_for_ac(skb)) {
 			pr_notice("tx drop: invalid sa for name 0x%016llx\n",
@@ -113,7 +113,7 @@ int j1939_fixup_address_claim(struct sk_buff *skb)
 
 	/* assign destination address */
 	if (skcb->addr.dst_name) {
-		sa = j1939_name_to_sa(skcb->addr.dst_name, skb->dev->ifindex);
+		sa = j1939_name_to_sa(sock_net(skb->sk), skcb->addr.dst_name, skb->dev->ifindex);
 		if (!j1939_address_is_unicast(sa)) {
 			pr_notice("tx drop: invalid da for name 0x%016llx\n",
 				     skcb->addr.dst_name);
diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index f77d0b5b144d..9c592fce3974 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -111,7 +111,7 @@ struct j1939_ecu *_j1939_ecu_find_by_addr(u8 sa, struct j1939_priv *priv)
 	return ecu;
 }
 
-u8 j1939_name_to_sa(name_t name, int ifindex)
+u8 j1939_name_to_sa(struct net *net, name_t name, int ifindex)
 {
 	struct j1939_ecu *ecu;
 	struct j1939_priv *priv;
@@ -119,7 +119,7 @@ u8 j1939_name_to_sa(name_t name, int ifindex)
 
 	if (!name)
 		return J1939_NO_ADDR;
-	priv = j1939_priv_get_by_ifindex(ifindex);
+	priv = j1939_priv_get_by_ifindex(net, ifindex);
 	if (!priv)
 		return J1939_NO_ADDR;
 
@@ -158,7 +158,7 @@ static struct j1939_ecu *_j1939_ecu_find_by_name(name_t name,
 }
 
 /* ecu lookup by name */
-struct j1939_ecu *j1939_ecu_find_by_name(name_t name, int ifindex)
+struct j1939_ecu *j1939_ecu_find_by_name(struct net *net, name_t name, int ifindex)
 {
 	struct j1939_ecu *ecu;
 	struct j1939_priv *priv;
@@ -167,7 +167,7 @@ struct j1939_ecu *j1939_ecu_find_by_name(name_t name, int ifindex)
 		return NULL;
 	if (!ifindex)
 		return NULL;
-	priv = j1939_priv_get_by_ifindex(ifindex);
+	priv = j1939_priv_get_by_ifindex(net, ifindex);
 	if (!priv)
 		return NULL;
 	ecu = _j1939_ecu_find_by_name(name, priv);
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 67a8a06359b7..52adf1e54586 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -175,9 +175,9 @@ static inline void j1939_ecu_remove_sa(struct j1939_ecu *ecu)
 	write_unlock_bh(&ecu->priv->lock);
 }
 
-u8 j1939_name_to_sa(name_t name, int ifindex);
+u8 j1939_name_to_sa(struct net *net, name_t name, int ifindex);
 struct j1939_ecu *_j1939_ecu_find_by_addr(u8 sa, struct j1939_priv *priv);
-struct j1939_ecu *j1939_ecu_find_by_name(name_t name, int ifindex);
+struct j1939_ecu *j1939_ecu_find_by_name(struct net *net, name_t name, int ifindex);
 /* find_by_name, with kref & read_lock taken */
 struct j1939_ecu *j1939_ecu_find_priv_default_tx(int ifindex, name_t *pname,
 						 u8 *paddr);
@@ -225,12 +225,12 @@ static inline int j1939cb_is_broadcast(const struct j1939_sk_buff_cb *skcb)
 	return (!skcb->addr.dst_name && (skcb->addr.da == 0xff));
 }
 
-int j1939_send(struct sk_buff *);
+int j1939_send(struct net *net, struct sk_buff *);
 void j1939_recv(struct sk_buff *);
 
 /* stack entries */
-int j1939_send_transport(struct sk_buff *);
-int j1939_recv_transport(struct sk_buff *);
+int j1939_send_transport(struct net *net, struct sk_buff *);
+int j1939_recv_transport(struct net *net, struct sk_buff *);
 int j1939_fixup_address_claim(struct sk_buff *);
 void j1939_recv_address_claim(struct sk_buff *, struct j1939_priv *priv);
 
@@ -246,12 +246,12 @@ struct j1939_ecu *_j1939_ecu_get_register(struct j1939_priv *priv,
 /* unregister must be called with lock held */
 void _j1939_ecu_unregister(struct j1939_ecu *);
 
-int j1939_netdev_start(struct net_device *);
+int j1939_netdev_start(struct net *, struct net_device *);
 void j1939_netdev_stop(struct net_device *);
 
 void __j1939_priv_release(struct kref *kref);
 struct j1939_priv *j1939_priv_get(struct net_device *dev);
-struct j1939_priv *j1939_priv_get_by_ifindex(int ifindex);
+struct j1939_priv *j1939_priv_get_by_ifindex(struct net *net, int ifindex);
 
 
 static inline void j1939_priv_set(struct net_device *dev, struct j1939_priv *priv)
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index db0f4de716eb..67c5d0f406d6 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -44,6 +44,8 @@ MODULE_ALIAS("can-proto-" __stringify(CAN_J1939));
 static void j1939_can_recv(struct sk_buff *iskb, void *data)
 {
 	struct j1939_priv *priv = data;
+	struct net_device *netdev = priv->netdev;
+	struct net *net = dev_net(netdev);
 	struct sk_buff *skb;
 	struct j1939_sk_buff_cb *skcb;
 	struct can_frame *cf;
@@ -108,7 +110,7 @@ static void j1939_can_recv(struct sk_buff *iskb, void *data)
 	/* deliver into the j1939 stack ... */
 	j1939_recv_address_claim(skb, priv);
 
-	if (j1939_recv_transport(skb))
+	if (j1939_recv_transport(net, skb))
 		/* this means the transport layer processed the message */
 		goto done;
 	j1939_recv(skb);
@@ -116,7 +118,7 @@ static void j1939_can_recv(struct sk_buff *iskb, void *data)
 	kfree_skb(skb);
 }
 
-int j1939_send(struct sk_buff *skb)
+int j1939_send(struct net *net, struct sk_buff *skb)
 {
 	int ret, dlc;
 	canid_t canid;
@@ -125,7 +127,7 @@ int j1939_send(struct sk_buff *skb)
 
 	if (skb->len > 8)
 		/* re-route via transport protocol */
-		return j1939_send_transport(skb);
+		return j1939_send_transport(net, skb);
 
 	/* apply sanity checks */
 	skcb->addr.pgn &= (pgn_is_pdu1(skcb->addr.pgn)) ? 0x3ff00 : 0x3ffff;
@@ -197,7 +199,7 @@ static void j1939_priv_ac_task(unsigned long val)
 
 static DEFINE_SPINLOCK(j1939_netdev_lock);
 
-int j1939_netdev_start(struct net_device *netdev)
+int j1939_netdev_start(struct net *net, struct net_device *netdev)
 {
 	struct j1939_priv *priv;
 	int ret;
@@ -222,7 +224,7 @@ int j1939_netdev_start(struct net_device *netdev)
 	dev_hold(netdev);
 
 	/* add CAN handler */
-	ret = can_rx_register(&init_net, netdev, J1939_CAN_ID, J1939_CAN_MASK,
+	ret = can_rx_register(net, netdev, J1939_CAN_ID, J1939_CAN_MASK,
 			      j1939_can_recv, priv, "j1939", NULL);
 	if (ret < 0)
 		goto out_dev_put;
@@ -241,7 +243,7 @@ int j1939_netdev_start(struct net_device *netdev)
 	return 0;
 
  out_rx_unregister:
-	can_rx_unregister(&init_net, netdev, J1939_CAN_ID, J1939_CAN_MASK,
+	can_rx_unregister(net, netdev, J1939_CAN_ID, J1939_CAN_MASK,
 			  j1939_can_recv, priv);
  out_dev_put:
 	dev_put(netdev);
@@ -264,15 +266,16 @@ void j1939_netdev_stop(struct net_device *netdev)
 void __j1939_priv_release(struct kref *kref)
 {
 	struct j1939_priv *priv = container_of(kref, struct j1939_priv, kref);
+	struct net_device *netdev = priv->netdev;
 	struct j1939_ecu *ecu;
 
-	can_rx_unregister(&init_net, priv->netdev, J1939_CAN_ID, J1939_CAN_MASK,
+	can_rx_unregister(dev_net(netdev), netdev, J1939_CAN_ID, J1939_CAN_MASK,
 			  j1939_can_recv, priv);
 
 	tasklet_disable_nosync(&priv->ac_task);
 
 	/* remove pending transport protocol sessions */
-	j1939tp_rmdev_notifier(priv->netdev);
+	j1939tp_rmdev_notifier(netdev);
 
 	/* cleanup priv */
 	write_lock_bh(&priv->lock);
@@ -284,9 +287,9 @@ void __j1939_priv_release(struct kref *kref)
 	write_unlock_bh(&priv->lock);
 
 	/* unlink from netdev */
-	j1939_priv_set(priv->netdev, NULL);
+	j1939_priv_set(netdev, NULL);
 
-	dev_put(priv->netdev);
+	dev_put(netdev);
 	kfree(priv);
 }
 
@@ -304,12 +307,12 @@ struct j1939_priv *j1939_priv_get(struct net_device *dev)
 	return priv;
 }
 
-struct j1939_priv *j1939_priv_get_by_ifindex(int ifindex)
+struct j1939_priv *j1939_priv_get_by_ifindex(struct net *net, int ifindex)
 {
 	struct j1939_priv *priv;
 	struct net_device *netdev;
 
-	netdev = dev_get_by_index(&init_net, ifindex);
+	netdev = dev_get_by_index(net, ifindex);
 	if (!netdev)
 		return NULL;
 
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 506ef86a9f7f..d4942e074f0c 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -202,6 +202,8 @@ static int j1939sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 {
 	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
 	struct j1939_sock *jsk = j1939_sk(sock->sk);
+	struct sock *sk = sock->sk;
+	struct net *net = sock_net(sk);
 	struct net_device *netdev;
 	struct j1939_priv *priv;
 	int ret = 0;
@@ -220,7 +222,7 @@ static int j1939sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 
 	lock_sock(sock->sk);
 
-	netdev = dev_get_by_index(&init_net, addr->can_ifindex);
+	netdev = dev_get_by_index(net, addr->can_ifindex);
 	if (!netdev) {
 		ret = -ENODEV;
 		goto out_release_sock;
@@ -246,7 +248,7 @@ static int j1939sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 			goto out_dev_put;
 		}
 
-		ret = j1939_netdev_start(netdev);
+		ret = j1939_netdev_start(net, netdev);
 		if (ret < 0)
 			goto out_dev_put;
 
@@ -385,7 +387,7 @@ static int j1939sk_release(struct socket *sock)
 		list_del_init(&jsk->list);
 		spin_unlock_bh(&j1939_socks_lock);
 
-		netdev = dev_get_by_index(&init_net, jsk->sk.sk_bound_dev_if);
+		netdev = dev_get_by_index(sock_net(sk), jsk->sk.sk_bound_dev_if);
 		if (netdev) {
 			priv = j1939_priv_get(netdev);
 			j1939_addr_local_put(priv, jsk->addr.sa);
@@ -619,7 +621,7 @@ static int j1939sk_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			return -EBADFD;
 	}
 
-	dev = dev_get_by_index(&init_net, ifindex);
+	dev = dev_get_by_index(sock_net(sk), ifindex);
 	if (!dev)
 		return -ENXIO;
 
@@ -680,7 +682,7 @@ static int j1939sk_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		j1939_sock_pending_add(&jsk->sk);
 	}
 
-	ret = j1939_send(skb);
+	ret = j1939_send(dev_net(dev), skb);
 	if (ret < 0)
 		j1939_sock_pending_del(&jsk->sk);
 
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index c15412dae565..016917cb1920 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -94,18 +94,8 @@ struct session {
 /* forward declarations */
 static struct session *j1939_session_new(struct sk_buff *skb);
 static struct session *j1939_session_fresh_new(int size,
-					       struct sk_buff *rel_skb,
-					       pgn_t pgn);
-static void j1939tp_del_work(struct work_struct *work);
-
-/* local variables */
-static DEFINE_SPINLOCK(tp_lock);
-static struct list_head tp_sessionq = LIST_HEAD_INIT(tp_sessionq);
-static struct list_head tp_extsessionq = LIST_HEAD_INIT(tp_extsessionq);
-static DEFINE_SPINLOCK(tp_dellock);
-static struct list_head tp_delsessionq = LIST_HEAD_INIT(tp_delsessionq);
-static DECLARE_WORK(tp_delwork, j1939tp_del_work);
-static DECLARE_WAIT_QUEUE_HEAD(tp_wait);
+					      struct sk_buff *rel_skb,
+					      pgn_t pgn);
 
 /* helpers */
 static inline void fix_cb(struct j1939_sk_buff_cb *cb)
@@ -113,9 +103,9 @@ static inline void fix_cb(struct j1939_sk_buff_cb *cb)
 	cb->msg_flags &= ~MSG_SYN;
 }
 
-static inline struct list_head *sessionq(bool extd)
+static inline struct list_head *sessionq(struct net *net, bool extd)
 {
-	return extd ? &tp_extsessionq : &tp_sessionq;
+	return extd ? &net->can_j1939.tp_extsessionq : &net->can_j1939.tp_sessionq;
 }
 
 static inline void j1939_session_destroy(struct session *session)
@@ -131,19 +121,20 @@ static inline void j1939_session_destroy(struct session *session)
 /* clean up work queue */
 static void j1939tp_del_work(struct work_struct *work)
 {
+	struct netns_can_j1939 *ncj = container_of(work, struct netns_can_j1939, tp_delwork);
 	struct session *session;
 
 	do {
 		session = NULL;
-		spin_lock_bh(&tp_dellock);
-		if (list_empty(&tp_delsessionq)) {
-			spin_unlock_bh(&tp_dellock);
+		spin_lock_bh(&ncj->tp_dellock);
+		if (list_empty(&ncj->tp_delsessionq)) {
+			spin_unlock_bh(&ncj->tp_dellock);
 			break;
 		}
-		session = list_first_entry(&tp_delsessionq,
+		session = list_first_entry(&ncj->tp_delsessionq,
 					   struct session, list);
 		list_del_init(&session->list);
-		spin_unlock_bh(&tp_dellock);
+		spin_unlock_bh(&ncj->tp_dellock);
 		j1939_session_destroy(session);
 	} while (1);
 }
@@ -154,7 +145,7 @@ static inline void j1939_session_get(struct session *session)
 	atomic_inc(&session->refs);
 }
 
-static void j1939_session_put(struct session *session)
+static void j1939_session_put(struct net *net, struct session *session)
 {
 	if (atomic_add_return(-1, &session->refs) >= 0)
 		/* not the last one */
@@ -166,10 +157,10 @@ static void j1939_session_put(struct session *session)
 	tasklet_disable_nosync(&session->txtask);
 
 	if (in_interrupt()) {
-		spin_lock_bh(&tp_dellock);
-		list_add_tail(&session->list, &tp_delsessionq);
-		spin_unlock_bh(&tp_dellock);
-		schedule_work(&tp_delwork);
+		spin_lock_bh(&net->can_j1939.tp_dellock);
+		list_add_tail(&session->list, &net->can_j1939.tp_delsessionq);
+		spin_unlock_bh(&net->can_j1939.tp_dellock);
+		schedule_work(&net->can_j1939.tp_delwork);
 	} else {
 		/* destroy session right here */
 		j1939_session_destroy(session);
@@ -183,20 +174,20 @@ static inline void j1939_session_lock(struct session *session)
 	spin_lock_bh(&session->lock);
 }
 
-static inline void j1939_session_unlock(struct session *session)
+static inline void j1939_session_unlock(struct net *net, struct session *session)
 {
 	spin_unlock_bh(&session->lock);
-	j1939_session_put(session);
+	j1939_session_put(net, session);
 }
 
-static inline void j1939_sessionlist_lock(void)
+static inline void j1939_sessionlist_lock(struct net *net)
 {
-	spin_lock_bh(&tp_lock);
+	spin_lock_bh(&net->can_j1939.tp_lock);
 }
 
-static inline void j1939_sessionlist_unlock(void)
+static inline void j1939_sessionlist_unlock(struct net *net)
 {
-	spin_unlock_bh(&tp_lock);
+	spin_unlock_bh(&net->can_j1939.tp_lock);
 }
 
 /* see if we are receiver
@@ -312,7 +303,7 @@ static struct session *_j1939tp_find(struct list_head *root,
 		j1939_session_get(session);
 		if (j1939tp_match(session, skb, reverse))
 			return session;
-		j1939_session_put(session);
+		j1939_session_put(sock_net(skb->sk), session);
 	}
 
 	return NULL;
@@ -321,11 +312,12 @@ static struct session *_j1939tp_find(struct list_head *root,
 static struct session *j1939tp_find(struct list_head *root,
 				    struct sk_buff *skb, bool reverse)
 {
+	struct net *net = sock_net(skb->sk);
 	struct session *session;
 
-	j1939_sessionlist_lock();
+	j1939_sessionlist_lock(net);
 	session = _j1939tp_find(root, skb, reverse);
-	j1939_sessionlist_unlock();
+	j1939_sessionlist_unlock(net);
 
 	return session;
 }
@@ -371,7 +363,7 @@ static int j1939tp_tx_dat(struct sk_buff *related, bool extd,
 	memcpy(skdat, dat, len);
 	if (padding && len < 8)
 		memset(skb_put(skb, 8 - len), 0xff, 8 - len);
-	return j1939_send(skb);
+	return j1939_send(dev_net(skb->dev), skb);
 }
 
 static int j1939xtp_do_tx_ctl(struct sk_buff *related, bool extd,
@@ -412,7 +404,7 @@ static int j1939xtp_do_tx_ctl(struct sk_buff *related, bool extd,
 	skdat[6] = (pgn >> 8);
 	skdat[7] = (pgn >> 16);
 
-	return j1939_send(skb);
+	return j1939_send(dev_net(skb->dev), skb);
 }
 
 static inline int j1939tp_tx_ctl(struct session *session,
@@ -472,28 +464,28 @@ static inline void j1939tp_set_rxtimeout(struct session *session, int msec)
 /* j1939_session_drop
  * removes a session from open session list
  */
-static inline void j1939_session_drop(struct session *session)
+static inline void j1939_session_drop(struct net *net, struct session *session)
 {
-	j1939_sessionlist_lock();
+	j1939_sessionlist_lock(net);
 	list_del_init(&session->list);
-	j1939_sessionlist_unlock();
+	j1939_sessionlist_unlock(net);
 
 	if (session->transmission) {
 		if (session->skb && session->skb->sk)
 			j1939_sock_pending_del(session->skb->sk);
-		wake_up_all(&tp_wait);
+		wake_up_all(&net->can_j1939.tp_wait);
 	}
-	j1939_session_put(session);
+	j1939_session_put(net, session);
 }
 
-static inline void j1939_session_completed(struct session *session)
+static inline void j1939_session_completed(struct net *net, struct session *session)
 {
 	/* distribute among j1939 receivers */
 	j1939_recv(session->skb);
-	j1939_session_drop(session);
+	j1939_session_drop(net, session);
 }
 
-static void j1939_session_cancel(struct session *session, int err)
+static void j1939_session_cancel(struct net *net, struct session *session, int err)
 {
 	if ((err >= 0) && j1939tp_im_involved_anydir(session->skb)) {
 		if (!j1939cb_is_broadcast(session->cb)) {
@@ -503,7 +495,7 @@ static void j1939_session_cancel(struct session *session, int err)
 					  err, session->cb->addr.pgn);
 		}
 	}
-	j1939_session_drop(session);
+	j1939_session_drop(net, session);
 }
 
 static enum hrtimer_restart j1939tp_rxtimer(struct hrtimer *hrtimer)
@@ -518,49 +510,50 @@ static enum hrtimer_restart j1939tp_rxtimer(struct hrtimer *hrtimer)
 static void j1939tp_rxtask(unsigned long val)
 {
 	struct session *session = (void *)val;
+	struct net *net = sock_net(session->skb->sk);
 
 	j1939_session_get(session);
 	pr_alert("%s: timeout on %i\n", __func__, session->skb_iif);
-	j1939_session_cancel(session, J1939_ABORT_TIMEOUT);
-	j1939_session_put(session);
+	j1939_session_cancel(net, session, J1939_ABORT_TIMEOUT);
+	j1939_session_put(net, session);
 }
 
 /* receive packet functions */
-static void _j1939xtp_rx_bad_message(struct sk_buff *skb, bool extd, bool reverse)
+static void _j1939xtp_rx_bad_message(struct net *net, struct sk_buff *skb, bool extd, bool reverse)
 {
 	struct session *session;
 	pgn_t pgn;
 
 	pgn = j1939xtp_ctl_to_pgn(skb->data);
-	session = j1939tp_find(sessionq(extd), skb, reverse);
+	session = j1939tp_find(sessionq(net, extd), skb, reverse);
 	if (session /*&& (session->cb->addr.pgn == pgn)*/) {
 		/* do not allow TP control messages on 2 pgn's */
-		j1939_session_cancel(session, J1939_ABORT_FAULT);
-		j1939_session_put(session); /* ~j1939tp_find */
+		j1939_session_cancel(net, session, J1939_ABORT_FAULT);
+		j1939_session_put(net, session); /* ~j1939tp_find */
 		return;
 	}
 	j1939xtp_tx_abort(skb, extd, 0, J1939_ABORT_FAULT, pgn);
 	if (!session)
 		return;
-	j1939_session_put(session); /* ~j1939tp_find */
+	j1939_session_put(net, session); /* ~j1939tp_find */
 }
 
 /* abort packets may come in 2 directions */
-static void j1939xtp_rx_bad_message(struct sk_buff *skb, bool extd)
+static void j1939xtp_rx_bad_message(struct net *net, struct sk_buff *skb, bool extd)
 {
 	pr_info("%s, pgn %05x\n", __func__, j1939xtp_ctl_to_pgn(skb->data));
 
-	_j1939xtp_rx_bad_message(skb, extd, 0);
-	_j1939xtp_rx_bad_message(skb, extd, 1);
+	_j1939xtp_rx_bad_message(net, skb, extd, 0);
+	_j1939xtp_rx_bad_message(net, skb, extd, 1);
 }
 
-static void _j1939xtp_rx_abort(struct sk_buff *skb, bool extd, bool reverse)
+static void _j1939xtp_rx_abort(struct net *net, struct sk_buff *skb, bool extd, bool reverse)
 {
 	struct session *session;
 	pgn_t pgn;
 
 	pgn = j1939xtp_ctl_to_pgn(skb->data);
-	session = j1939tp_find(sessionq(extd), skb, reverse);
+	session = j1939tp_find(sessionq(net, extd), skb, reverse);
 	if (!session)
 		return;
 	if (session->transmission && !session->last_txcmd) {
@@ -569,33 +562,33 @@ static void _j1939xtp_rx_abort(struct sk_buff *skb, bool extd, bool reverse)
 		 * start yet
 		 */
 	} else if (session->cb->addr.pgn == pgn) {
-		j1939_session_drop(session);
+		j1939_session_drop(net, session);
 	}
 
 	/* TODO: maybe cancel current connection
 	 * as another pgn was communicated
 	 */
-	j1939_session_put(session); /* ~j1939tp_find */
+	j1939_session_put(net, session); /* ~j1939tp_find */
 }
 
 /* abort packets may come in 2 directions */
-static inline void j1939xtp_rx_abort(struct sk_buff *skb, bool extd)
+static inline void j1939xtp_rx_abort(struct net *net, struct sk_buff *skb, bool extd)
 {
 	pr_info("%s %i, %05x\n", __func__, skb->skb_iif,
 		j1939xtp_ctl_to_pgn(skb->data));
 
-	_j1939xtp_rx_abort(skb, extd, 0);
-	_j1939xtp_rx_abort(skb, extd, 1);
+	_j1939xtp_rx_abort(net, skb, extd, 0);
+	_j1939xtp_rx_abort(net, skb, extd, 1);
 }
 
-static void j1939xtp_rx_eof(struct sk_buff *skb, bool extd)
+static void j1939xtp_rx_eof(struct net *net, struct sk_buff *skb, bool extd)
 {
 	struct session *session;
 	pgn_t pgn;
 
 	/* end of tx cycle */
 	pgn = j1939xtp_ctl_to_pgn(skb->data);
-	session = j1939tp_find(sessionq(extd), skb, 1);
+	session = j1939tp_find(sessionq(net, extd), skb, 1);
 	if (!session) {
 		/* strange, we had EOF on closed connection
 		 * do nothing, as EOF closes the connection anyway
@@ -605,15 +598,15 @@ static void j1939xtp_rx_eof(struct sk_buff *skb, bool extd)
 
 	if (session->cb->addr.pgn != pgn) {
 		j1939xtp_tx_abort(skb, extd, 1, J1939_ABORT_BUSY, pgn);
-		j1939_session_cancel(session, J1939_ABORT_BUSY);
+		j1939_session_cancel(net, session, J1939_ABORT_BUSY);
 	} else {
 		/* transmitted without problems */
-		j1939_session_completed(session);
+		j1939_session_completed(net, session);
 	}
-	j1939_session_put(session); /* ~j1939tp_find */
+	j1939_session_put(net, session); /* ~j1939tp_find */
 }
 
-static void j1939xtp_rx_cts(struct sk_buff *skb, bool extd)
+static void j1939xtp_rx_cts(struct net *net, struct sk_buff *skb, bool extd)
 {
 	struct session *session;
 	pgn_t pgn;
@@ -622,7 +615,7 @@ static void j1939xtp_rx_cts(struct sk_buff *skb, bool extd)
 
 	dat = skb->data;
 	pgn = j1939xtp_ctl_to_pgn(skb->data);
-	session = j1939tp_find(sessionq(extd), skb, 1);
+	session = j1939tp_find(sessionq(net, extd), skb, 1);
 	if (!session) {
 		/* 'CTS shall be ignored' */
 		return;
@@ -631,8 +624,8 @@ static void j1939xtp_rx_cts(struct sk_buff *skb, bool extd)
 	if (session->cb->addr.pgn != pgn) {
 		/* what to do? */
 		j1939xtp_tx_abort(skb, extd, 1, J1939_ABORT_BUSY, pgn);
-		j1939_session_cancel(session, J1939_ABORT_BUSY);
-		j1939_session_put(session); /* ~j1939tp_find */
+		j1939_session_cancel(net, session, J1939_ABORT_BUSY);
+		j1939_session_put(net, session); /* ~j1939tp_find */
 		return;
 	}
 
@@ -656,7 +649,7 @@ static void j1939xtp_rx_cts(struct sk_buff *skb, bool extd)
 	}
 
 	session->last_cmd = dat[0];
-	j1939_session_unlock(session);
+	j1939_session_unlock(net, session);
 	if (dat[1]) {
 		j1939tp_set_rxtimeout(session, 1250);
 		if (j1939tp_im_transmitter(session->skb))
@@ -665,15 +658,15 @@ static void j1939xtp_rx_cts(struct sk_buff *skb, bool extd)
 		/* CTS(0) */
 		j1939tp_set_rxtimeout(session, 550);
 	}
-	j1939_session_put(session); /* ~j1939tp_find */
+	j1939_session_put(net, session); /* ~j1939tp_find */
 	return;
  bad_fmt:
-	j1939_session_unlock(session);
-	j1939_session_cancel(session, J1939_ABORT_FAULT);
-	j1939_session_put(session); /* ~j1939tp_find */
+	j1939_session_unlock(net, session);
+	j1939_session_cancel(net, session, J1939_ABORT_FAULT);
+	j1939_session_put(net, session); /* ~j1939tp_find */
 }
 
-static void j1939xtp_rx_rts(struct sk_buff *skb, bool extd)
+static void j1939xtp_rx_rts(struct net *net, struct sk_buff *skb, bool extd)
 {
 	struct j1939_sk_buff_cb *cb = j1939_get_cb(skb);
 	struct session *session;
@@ -693,13 +686,13 @@ static void j1939xtp_rx_rts(struct sk_buff *skb, bool extd)
 	/* TODO: abort RTS when a similar
 	 * TP is pending in the other direction
 	 */
-	session = j1939tp_find(sessionq(extd), skb, 0);
+	session = j1939tp_find(sessionq(net, extd), skb, 0);
 	if (session && !j1939tp_im_transmitter(skb)) {
 		/* RTS on pending connection */
-		j1939_session_cancel(session, J1939_ABORT_BUSY);
+		j1939_session_cancel(net, session, J1939_ABORT_BUSY);
 		if ((pgn != session->cb->addr.pgn) && (J1939_TP_CMD_BAM != dat[0]))
 			j1939xtp_tx_abort(skb, extd, 1, J1939_ABORT_BUSY, pgn);
-		j1939_session_put(session); /* ~j1939tp_find */
+		j1939_session_put(net, session); /* ~j1939tp_find */
 		return;
 	} else if (!session && j1939tp_im_transmitter(skb)) {
 		pr_alert("%s: I should tx (%i %02x %02x)\n", __func__,
@@ -710,8 +703,8 @@ static void j1939xtp_rx_rts(struct sk_buff *skb, bool extd)
 		/* we received a second rts on the same connection */
 		pr_alert("%s: connection exists (%i %02x %02x)\n", __func__,
 			 skb->skb_iif, cb->addr.sa, cb->addr.da);
-		j1939_session_cancel(session, J1939_ABORT_BUSY);
-		j1939_session_put(session); /* ~j1939tp_find */
+		j1939_session_cancel(net, session, J1939_ABORT_BUSY);
+		j1939_session_put(net, session); /* ~j1939tp_find */
 		return;
 	}
 	if (session) {
@@ -764,9 +757,9 @@ static void j1939xtp_rx_rts(struct sk_buff *skb, bool extd)
 		session->pkt.done = 0;
 		session->pkt.tx = 0;
 		j1939_session_get(session); /* equivalent to j1939tp_find() */
-		j1939_sessionlist_lock();
-		list_add_tail(&session->list, sessionq(extd));
-		j1939_sessionlist_unlock();
+		j1939_sessionlist_lock(net);
+		list_add_tail(&session->list, sessionq(net, extd));
+		j1939_sessionlist_unlock(net);
 	}
 	session->last_cmd = dat[0];
 
@@ -782,17 +775,17 @@ static void j1939xtp_rx_rts(struct sk_buff *skb, bool extd)
 	 * between spin_unlock & next statement
 	 * so, only release here, at the end
 	 */
-	j1939_session_put(session); /* ~j1939tp_find */
+	j1939_session_put(net, session); /* ~j1939tp_find */
 }
 
-static void j1939xtp_rx_dpo(struct sk_buff *skb, bool extd)
+static void j1939xtp_rx_dpo(struct net *net, struct sk_buff *skb, bool extd)
 {
 	struct session *session;
 	pgn_t pgn;
 	const u8 *dat = skb->data;
 
 	pgn = j1939xtp_ctl_to_pgn(dat);
-	session = j1939tp_find(sessionq(extd), skb, 0);
+	session = j1939tp_find(sessionq(net, extd), skb, 0);
 	if (!session) {
 		pr_info("%s: %s\n", __func__, "no connection found");
 		return;
@@ -801,8 +794,8 @@ static void j1939xtp_rx_dpo(struct sk_buff *skb, bool extd)
 	if (session->cb->addr.pgn != pgn) {
 		pr_info("%s: different pgn\n", __func__);
 		j1939xtp_tx_abort(skb, 1, 1, J1939_ABORT_BUSY, pgn);
-		j1939_session_cancel(session, J1939_ABORT_BUSY);
-		j1939_session_put(session); /* ~j1939tp_find */
+		j1939_session_cancel(net, session, J1939_ABORT_BUSY);
+		j1939_session_put(net, session); /* ~j1939tp_find */
 		return;
 	}
 
@@ -810,10 +803,10 @@ static void j1939xtp_rx_dpo(struct sk_buff *skb, bool extd)
 	session->pkt.dpo = j1939etp_ctl_to_packet(skb->data);
 	session->last_cmd = dat[0];
 	j1939tp_set_rxtimeout(session, 750);
-	j1939_session_put(session); /* ~j1939tp_find */
+	j1939_session_put(net, session); /* ~j1939tp_find */
 }
 
-static void j1939xtp_rx_dat(struct sk_buff *skb, bool extd)
+static void j1939xtp_rx_dat(struct net *net, struct sk_buff *skb, bool extd)
 {
 	struct session *session;
 	const u8 *dat;
@@ -824,7 +817,7 @@ static void j1939xtp_rx_dat(struct sk_buff *skb, bool extd)
 	int do_cts_eof;
 	int packet;
 
-	session = j1939tp_find(sessionq(extd), skb, 0);
+	session = j1939tp_find(sessionq(net, extd), skb, 0);
 	if (!session) {
 		pr_info("%s:%s\n", __func__, "no connection found");
 		return;
@@ -879,9 +872,9 @@ static void j1939xtp_rx_dat(struct sk_buff *skb, bool extd)
 		final = 0; /* never final, an EOF must follow */
 		do_cts_eof = (session->pkt.done >= session->pkt.last);
 	}
-	j1939_session_unlock(session);
+	j1939_session_unlock(net, session);
 	if (final) {
-		j1939_session_completed(session);
+		j1939_session_completed(net, session);
 	} else if (do_cts_eof) {
 		j1939tp_set_rxtimeout(session, 1250);
 		if (j1939tp_im_receiver(session->skb))
@@ -890,19 +883,19 @@ static void j1939xtp_rx_dat(struct sk_buff *skb, bool extd)
 		j1939tp_set_rxtimeout(session, 250);
 	}
 	session->last_cmd = 0xff;
-	j1939_session_put(session); /* ~j1939tp_find */
+	j1939_session_put(net, session); /* ~j1939tp_find */
 	return;
 
  strange_packet:
 	/* unlock session (spinlock) before trying to send */
-	j1939_session_unlock(session);
+	j1939_session_unlock(net, session);
  strange_packet_unlocked:
-	j1939_session_cancel(session, J1939_ABORT_FAULT);
-	j1939_session_put(session); /* ~j1939tp_find */
+	j1939_session_cancel(net, session, J1939_ABORT_FAULT);
+	j1939_session_put(net, session); /* ~j1939tp_find */
 }
 
 /* transmit function */
-static int j1939tp_txnext(struct session *session)
+static int j1939tp_txnext(struct net *net, struct session *session)
 {
 	u8 dat[8];
 	const u8 *tpdat;
@@ -1065,55 +1058,57 @@ static int j1939tp_txnext(struct session *session)
 			goto failed;
 		break;
 	}
-	j1939_session_put(session);
+	j1939_session_put(net, session);
 	return 0;
  failed:
-	j1939_session_put(session);
+	j1939_session_put(net, session);
 	return ret;
 }
 
 static void j1939tp_txtask(unsigned long val)
 {
 	struct session *session = (void *)val;
+	struct net *net = sock_net(session->skb->sk);
 	int ret;
 
 	j1939_session_get(session);
-	ret = j1939tp_txnext(session);
+	ret = j1939tp_txnext(net, session);
 	if (ret < 0)
 		j1939tp_schedule_txtimer(session, retry_ms ?: 20);
-	j1939_session_put(session);
+	j1939_session_put(net, session);
 }
 
-static inline int j1939tp_tx_initial(struct session *session)
+static inline int j1939tp_tx_initial(struct net *net, struct session *session)
 {
 	int ret;
 
 	j1939_session_get(session);
-	ret = j1939tp_txnext(session);
+	ret = j1939tp_txnext(net, session);
 	/* set nonblocking for further packets */
 	session->cb->msg_flags |= MSG_DONTWAIT;
-	j1939_session_put(session);
+	j1939_session_put(net, session);
 	return ret;
 }
 
 /* this call is to be used as probe within wait_event_xxx() */
 static int j1939_session_insert(struct session *session)
 {
+	struct net *net = sock_net(session->skb->sk);
 	struct session *pending;
 
-	j1939_sessionlist_lock();
-	pending = _j1939tp_find(sessionq(session->extd), session->skb, 0);
+	j1939_sessionlist_lock(net);
+	pending = _j1939tp_find(sessionq(net, session->extd), session->skb, 0);
 	if (pending)
 		/* revert the effect of find() */
-		j1939_session_put(pending);
+		j1939_session_put(net, pending);
 	else
-		list_add_tail(&session->list, sessionq(session->extd));
-	j1939_sessionlist_unlock();
+		list_add_tail(&session->list, sessionq(net, session->extd));
+	j1939_sessionlist_unlock(net);
 	return pending ? 0 : 1;
 }
 
 /* j1939 main intf */
-int j1939_send_transport(struct sk_buff *skb)
+int j1939_send_transport(struct net *net, struct sk_buff *skb)
 {
 	struct j1939_sk_buff_cb *cb = j1939_get_cb(skb);
 	struct session *session;
@@ -1139,7 +1134,7 @@ int j1939_send_transport(struct sk_buff *skb)
 		return ret;
 
 	/* fix dst_flags, it may be used there soon */
-	priv = j1939_priv_get_by_ifindex(can_skb_prv(skb)->ifindex);
+	priv = j1939_priv_get_by_ifindex(net, can_skb_prv(skb)->ifindex);
 	if (!priv)
 		return -EINVAL;
 	if (j1939_address_is_unicast(cb->addr.da) &&
@@ -1168,88 +1163,88 @@ int j1939_send_transport(struct sk_buff *skb)
 	if (session->cb->msg_flags & MSG_DONTWAIT)
 		ret = j1939_session_insert(session) ? 0 : -EAGAIN;
 	else
-		ret = wait_event_interruptible(tp_wait,
+		ret = wait_event_interruptible(net->can_j1939.tp_wait,
 					       j1939_session_insert(session));
 	if (ret < 0)
 		goto failed;
 
-	ret = j1939tp_tx_initial(session);
+	ret = j1939tp_tx_initial(net, session);
 	if (!ret)
 		/* transmission started */
 		return ret;
-	j1939_sessionlist_lock();
+	j1939_sessionlist_lock(net);
 	list_del_init(&session->list);
-	j1939_sessionlist_unlock();
+	j1939_sessionlist_unlock(net);
  failed:
 	/* hide the skb from j1939_session_drop, as it would
 	 * kfree_skb, but our caller will kfree_skb(skb) too.
 	 */
 	session->skb = NULL;
-	j1939_session_drop(session);
+	j1939_session_drop(net, session);
 	return ret;
 }
 
-int j1939_recv_transport(struct sk_buff *skb)
+int j1939_recv_transport(struct net *net, struct sk_buff *skb)
 {
 	struct j1939_sk_buff_cb *cb = j1939_get_cb(skb);
 	const u8 *dat;
 
 	switch (cb->addr.pgn) {
 	case J1939_ETP_PGN_DAT:
-		j1939xtp_rx_dat(skb, J1939_EXTENDED);
+		j1939xtp_rx_dat(net, skb, J1939_EXTENDED);
 		break;
 	case J1939_ETP_PGN_CTL:
 		if (skb->len < 8) {
-			j1939xtp_rx_bad_message(skb, J1939_EXTENDED);
+			j1939xtp_rx_bad_message(net, skb, J1939_EXTENDED);
 			break;
 		}
 		dat = skb->data;
 		switch (*dat) {
 		case J1939_ETP_CMD_RTS:
-			j1939xtp_rx_rts(skb, J1939_EXTENDED);
+			j1939xtp_rx_rts(net, skb, J1939_EXTENDED);
 			break;
 		case J1939_ETP_CMD_CTS:
-			j1939xtp_rx_cts(skb, J1939_EXTENDED);
+			j1939xtp_rx_cts(net, skb, J1939_EXTENDED);
 			break;
 		case J1939_ETP_CMD_DPO:
-			j1939xtp_rx_dpo(skb, J1939_EXTENDED);
+			j1939xtp_rx_dpo(net, skb, J1939_EXTENDED);
 			break;
 		case J1939_CMD_EOF:
-			j1939xtp_rx_eof(skb, J1939_EXTENDED);
+			j1939xtp_rx_eof(net, skb, J1939_EXTENDED);
 			break;
 		case J1939_ETP_CMD_ABORT:
-			j1939xtp_rx_abort(skb, J1939_EXTENDED);
+			j1939xtp_rx_abort(net, skb, J1939_EXTENDED);
 			break;
 		default:
-			j1939xtp_rx_bad_message(skb, J1939_EXTENDED);
+			j1939xtp_rx_bad_message(net, skb, J1939_EXTENDED);
 			break;
 		}
 		break;
 	case J1939_TP_PGN_DAT:
-		j1939xtp_rx_dat(skb, J1939_REGULAR);
+		j1939xtp_rx_dat(net, skb, J1939_REGULAR);
 		break;
 	case J1939_TP_PGN_CTL:
 		if (skb->len < 8) {
-			j1939xtp_rx_bad_message(skb, J1939_REGULAR);
+			j1939xtp_rx_bad_message(net, skb, J1939_REGULAR);
 			break;
 		}
 		dat = skb->data;
 		switch (*dat) {
 		case J1939_TP_CMD_BAM:
 		case J1939_TP_CMD_RTS:
-			j1939xtp_rx_rts(skb, J1939_REGULAR);
+			j1939xtp_rx_rts(net, skb, J1939_REGULAR);
 			break;
 		case J1939_TP_CMD_CTS:
-			j1939xtp_rx_cts(skb, J1939_REGULAR);
+			j1939xtp_rx_cts(net, skb, J1939_REGULAR);
 			break;
 		case J1939_TP_CMD_EOF:
-			j1939xtp_rx_eof(skb, J1939_REGULAR);
+			j1939xtp_rx_eof(net, skb, J1939_REGULAR);
 			break;
 		case J1939_TP_CMD_ABORT:
-			j1939xtp_rx_abort(skb, J1939_REGULAR);
+			j1939xtp_rx_abort(net, skb, J1939_REGULAR);
 			break;
 		default:
-			j1939xtp_rx_bad_message(skb, J1939_REGULAR);
+			j1939xtp_rx_bad_message(net, skb, J1939_REGULAR);
 			break;
 		}
 		break;
@@ -1317,46 +1312,69 @@ static struct session *j1939_session_new(struct sk_buff *skb)
 
 int j1939tp_rmdev_notifier(struct net_device *netdev)
 {
+	struct net *net = dev_net(netdev);
 	struct session *session, *saved;
 
-	j1939_sessionlist_lock();
-	list_for_each_entry_safe(session, saved, &tp_sessionq, list) {
+	j1939_sessionlist_lock(net);
+	list_for_each_entry_safe(session, saved, &net->can_j1939.tp_sessionq, list) {
 		if (session->skb_iif != netdev->ifindex)
 			continue;
 		list_del_init(&session->list);
-		j1939_session_put(session);
+		j1939_session_put(net, session);
 	}
-	list_for_each_entry_safe(session, saved, &tp_extsessionq, list) {
+	list_for_each_entry_safe(session, saved, &net->can_j1939.tp_extsessionq, list) {
 		if (session->skb_iif != netdev->ifindex)
 			continue;
 		list_del_init(&session->list);
-		j1939_session_put(session);
+		j1939_session_put(net, session);
 	}
-	j1939_sessionlist_unlock();
+	j1939_sessionlist_unlock(net);
 	return NOTIFY_DONE;
 }
 
-/* module init */
-int __init j1939tp_module_init(void)
+static int __net_init j1939tp_pernet_init(struct net *net)
 {
+	spin_lock_init(&net->can_j1939.tp_lock);
+	spin_lock_init(&net->can_j1939.tp_dellock);
+	INIT_LIST_HEAD(&net->can_j1939.tp_sessionq);
+	INIT_LIST_HEAD(&net->can_j1939.tp_extsessionq);
+	INIT_LIST_HEAD(&net->can_j1939.tp_delsessionq);
+	INIT_WORK(&net->can_j1939.tp_delwork, j1939tp_del_work);
+	init_waitqueue_head(&net->can_j1939.tp_wait);
 	return 0;
 }
 
-void j1939tp_module_exit(void)
+static void __net_exit j1939tp_pernet_exit(struct net *net)
 {
 	struct session *session, *saved;
 
-	wake_up_all(&tp_wait);
+	wake_up_all(&net->can_j1939.tp_wait);
 
-	j1939_sessionlist_lock();
-	list_for_each_entry_safe(session, saved, &tp_extsessionq, list) {
+	j1939_sessionlist_lock(net);
+	list_for_each_entry_safe(session, saved, &net->can_j1939.tp_extsessionq, list) {
 		list_del_init(&session->list);
-		j1939_session_put(session);
+		j1939_session_put(net, session);
 	}
-	list_for_each_entry_safe(session, saved, &tp_sessionq, list) {
+	list_for_each_entry_safe(session, saved, &net->can_j1939.tp_sessionq, list) {
 		list_del_init(&session->list);
-		j1939_session_put(session);
+		j1939_session_put(net, session);
 	}
-	j1939_sessionlist_unlock();
-	flush_scheduled_work();
+	j1939_sessionlist_unlock(net);
+}
+
+static struct pernet_operations j1939tp_pernet_ops = {
+	.init = j1939tp_pernet_init,
+	.exit = j1939tp_pernet_exit,
+};
+
+/* module init */
+int __init j1939tp_module_init(void)
+{
+	register_pernet_subsys(&j1939tp_pernet_ops);
+	return 0;
+}
+
+void j1939tp_module_exit(void)
+{
+	unregister_pernet_subsys(&j1939tp_pernet_ops);
 }
-- 
2.15.1

