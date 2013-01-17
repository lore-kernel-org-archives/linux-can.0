From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 1/4] can: add private data space for CAN sk_buffs
Date: Thu, 17 Jan 2013 18:43:39 +0100
Message-ID: <50F8384B.6000608@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:39027 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab3AQRnl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Jan 2013 12:43:41 -0500
Received: from [192.168.178.31] (p5B0B0333.dip0.t-ipconnect.de [91.11.3.51])
	by smtp.strato.de (josoe mo37) (RZmta 31.12 DYNA|AUTH)
	with ESMTPA id 407c9ep0HGmJHP for <linux-can@vger.kernel.org>;
	Thu, 17 Jan 2013 18:43:40 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

From a5c67ec58a44ce986bb6a927807a697021ce3926 Mon Sep 17 00:00:00 2001
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Wed, 16 Jan 2013 21:53:06 +0100
Subject: [PATCH 1/4] can: add private data space for CAN sk_buffs

The struct can_skb_priv is used to transport additional information along
with the stored struct can(fd)_frame that can not be contained in existing
struct sk_buff elements.

can_skb_priv is located in the skb headroom, which does not touch the existing
CAN sk_buff usage with skb->data and skb->len, so that even out-of-tree
CAN drivers can be used without changes.

Btw. out-of-tree CAN drivers without can_skb_priv in the sk_buff headroom
would not support features based on can_skb_priv.

The can_skb_priv->ifindex contains the first interface where the CAN frame
appeared on the local host. Unfortunately skb->skb_iif can not be used as this
value is overwritten in every netif_receive_skb() call.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev.c   |    8 +++++++-
 drivers/net/can/slcan.c |    8 +++++++-
 include/linux/can/skb.h |   35 +++++++++++++++++++++++++++++++++++
 net/can/bcm.c           |   12 +++++++++---
 net/can/raw.c           |    8 ++++++--
 5 files changed, 64 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/can/skb.h

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 6abc6e5..59ada08 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -24,6 +24,7 @@
 #include <linux/if_arp.h>
 #include <linux/can.h>
 #include <linux/can/dev.h>
+#include <linux/can/skb.h>
 #include <linux/can/netlink.h>
 #include <linux/can/led.h>
 #include <net/rtnetlink.h>
@@ -502,13 +503,18 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 {
 	struct sk_buff *skb;
 
-	skb = netdev_alloc_skb(dev, sizeof(struct can_frame));
+	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
+			       sizeof(struct can_frame));
 	if (unlikely(!skb))
 		return NULL;
 
 	skb->protocol = htons(ETH_P_CAN);
 	skb->pkt_type = PACKET_BROADCAST;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	skb_reserve(skb, sizeof(struct can_skb_priv));
+	((struct can_skb_priv *)(skb->head))->ifindex = dev->ifindex;
+
 	*cf = (struct can_frame *)skb_put(skb, sizeof(struct can_frame));
 	memset(*cf, 0, sizeof(struct can_frame));
 
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index adc3708..e79a8d1 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -55,6 +55,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/can.h>
+#include <linux/can/skb.h>
 
 static __initconst const char banner[] =
 	KERN_INFO "slcan: serial line CAN interface driver\n";
@@ -184,7 +185,8 @@ static void slc_bump(struct slcan *sl)
 		cf.data[i] |= tmp;
 	}
 
-	skb = dev_alloc_skb(sizeof(struct can_frame));
+	skb = dev_alloc_skb(sizeof(struct can_frame) +
+			    sizeof(struct can_skb_priv));
 	if (!skb)
 		return;
 
@@ -192,6 +194,10 @@ static void slc_bump(struct slcan *sl)
 	skb->protocol = htons(ETH_P_CAN);
 	skb->pkt_type = PACKET_BROADCAST;
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	skb_reserve(skb, sizeof(struct can_skb_priv));
+	((struct can_skb_priv *)(skb->head))->ifindex = sl->dev->ifindex;
+
 	memcpy(skb_put(skb, sizeof(struct can_frame)),
 	       &cf, sizeof(struct can_frame));
 	netif_rx_ni(skb);
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
new file mode 100644
index 0000000..4b0f24d
--- /dev/null
+++ b/include/linux/can/skb.h
@@ -0,0 +1,35 @@
+/*
+ * linux/can/skb.h
+ *
+ * Definitions for the CAN network socket buffer
+ *
+ * Copyright (C) 2012 Oliver Hartkopp <socketcan@hartkopp.net>
+ *
+ */
+
+#ifndef CAN_SKB_H
+#define CAN_SKB_H
+
+#include <linux/types.h>
+#include <linux/can.h>
+
+/*
+ * The struct can_skb_priv is used to transport additional information along
+ * with the stored struct can(fd)_frame that can not be contained in existing
+ * struct sk_buff elements.
+ * N.B. that this information must not be modified in cloned CAN sk_buffs.
+ * To modify the CAN frame content or the struct can_skb_priv content
+ * skb_copy() needs to be used instead of skb_clone().
+ */
+
+/**
+ * struct can_skb_priv - private additional data inside CAN sk_buffs
+ * @ifindex:	ifindex of the first interface the CAN frame appeared on
+ * @cf:		align to the following CAN frame at skb->data
+ */
+struct can_skb_priv {
+	int ifindex;
+	struct can_frame cf[0];
+};
+
+#endif /* CAN_SKB_H */
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 969b7cd..ccc27b9 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -54,6 +54,7 @@
 #include <linux/skbuff.h>
 #include <linux/can.h>
 #include <linux/can/core.h>
+#include <linux/can/skb.h>
 #include <linux/can/bcm.h>
 #include <linux/slab.h>
 #include <net/sock.h>
@@ -256,10 +257,13 @@ static void bcm_can_tx(struct bcm_op *op)
 		return;
 	}
 
-	skb = alloc_skb(CFSIZ, gfp_any());
+	skb = alloc_skb(CFSIZ + sizeof(struct can_skb_priv), gfp_any());
 	if (!skb)
 		goto out;
 
+	skb_reserve(skb, sizeof(struct can_skb_priv));
+	((struct can_skb_priv *)(skb->head))->ifindex = dev->ifindex;
+
 	memcpy(skb_put(skb, CFSIZ), cf, CFSIZ);
 
 	/* send with loopback */
@@ -1199,11 +1203,12 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk)
 	if (!ifindex)
 		return -ENODEV;
 
-	skb = alloc_skb(CFSIZ, GFP_KERNEL);
-
+	skb = alloc_skb(CFSIZ + sizeof(struct can_skb_priv), GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
 
+	skb_reserve(skb, sizeof(struct can_skb_priv));
+
 	err = memcpy_fromiovec(skb_put(skb, CFSIZ), msg->msg_iov, CFSIZ);
 	if (err < 0) {
 		kfree_skb(skb);
@@ -1216,6 +1221,7 @@ static int bcm_tx_send(struct msghdr *msg, int ifindex, struct sock *sk)
 		return -ENODEV;
 	}
 
+	((struct can_skb_priv *)(skb->head))->ifindex = dev->ifindex;
 	skb->dev = dev;
 	skb->sk  = sk;
 	err = can_send(skb, 1); /* send with loopback */
diff --git a/net/can/raw.c b/net/can/raw.c
index 5b0e3e3..5d860e8 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -50,6 +50,7 @@
 #include <linux/skbuff.h>
 #include <linux/can.h>
 #include <linux/can/core.h>
+#include <linux/can/skb.h>
 #include <linux/can/raw.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
@@ -699,11 +700,14 @@ static int raw_sendmsg(struct kiocb *iocb, struct socket *sock,
 	if (!dev)
 		return -ENXIO;
 
-	skb = sock_alloc_send_skb(sk, size, msg->msg_flags & MSG_DONTWAIT,
-				  &err);
+	skb = sock_alloc_send_skb(sk, size + sizeof(struct can_skb_priv),
+				  msg->msg_flags & MSG_DONTWAIT, &err);
 	if (!skb)
 		goto put_dev;
 
+	skb_reserve(skb, sizeof(struct can_skb_priv));
+	((struct can_skb_priv *)(skb->head))->ifindex = dev->ifindex;
+
 	err = memcpy_fromiovec(skb_put(skb, size), msg->msg_iov, size);
 	if (err < 0)
 		goto free_skb;
-- 
1.7.10.4

