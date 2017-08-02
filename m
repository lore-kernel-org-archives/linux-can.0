From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 13/14] can: make use of preallocated can_ml_priv for per device struct can_dev_rcv_lists
Date: Wed,  2 Aug 2017 19:44:33 +0200
Message-ID: <20170802174434.4689-14-mkl@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34081 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751956AbdHBRop (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Aug 2017 13:44:45 -0400
In-Reply-To: <20170802174434.4689-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

This patch removes the old method of allocating the per device protocol
specific memory via a netdevice_notifier. This had the drawback, that
the allocation can fail, leading to a lot of null pointer checks in the
code. This also makes the live cycle management of this memory quite
complicated.

This patch switches from the allocating the struct can_dev_rcv_lists in
a NETDEV_REGISTER call to using the dev->ml_priv, which is allocated by
the driver since the previous patch.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c   |  2 ++
 drivers/net/can/slcan.c |  1 +
 drivers/net/can/vcan.c  |  1 +
 drivers/net/can/vxcan.c |  1 +
 net/can/af_can.c        | 45 ++++++++-------------------------------------
 net/can/af_can.h        |  1 -
 6 files changed, 13 insertions(+), 38 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 85a636760b98..89f9a05e97f0 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -735,6 +735,8 @@ struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max)
 	priv = netdev_priv(dev);
 	priv->dev = dev;
 
+	dev->ml_priv = (void *)priv + ALIGN(sizeof_priv, NETDEV_ALIGN);
+
 	if (echo_skb_max) {
 		priv->echo_skb_max = echo_skb_max;
 		priv->echo_skb = (void *)priv +
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index f1647b4fd1e6..38e82710848c 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -535,6 +535,7 @@ static struct slcan *slc_alloc(dev_t line)
 
 	dev->base_addr  = i;
 	sl = netdev_priv(dev);
+	dev->ml_priv = (void *)sl + ALIGN(sizeof(*sl), NETDEV_ALIGN);
 
 	/* Initialize channel control data */
 	sl->magic = SLCAN_MAGIC;
diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index 96e42eab2426..ff388f036124 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -158,6 +158,7 @@ static void vcan_setup(struct net_device *dev)
 	dev->addr_len		= 0;
 	dev->tx_queue_len	= 0;
 	dev->flags		= IFF_NOARP;
+	dev->ml_priv		= netdev_priv(dev);
 
 	/* set flags according to driver capabilities */
 	if (echo)
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 8925d797e8ac..ed9293209ca2 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -157,6 +157,7 @@ static void vxcan_setup(struct net_device *dev)
 	dev->flags		= (IFF_NOARP|IFF_ECHO);
 	dev->netdev_ops		= &vxcan_netdev_ops;
 	dev->needs_free_netdev	= true;
+	dev->ml_priv		= netdev_priv(dev) + ALIGN(sizeof(struct vxcan_priv), NETDEV_ALIGN);
 }
 
 /* forward declaration for rtnl_create_link() */
diff --git a/net/can/af_can.c b/net/can/af_can.c
index d781b9330f2c..c3eac4ab74e9 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -58,6 +58,7 @@
 #include <linux/can.h>
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
+#include <linux/can/can-ml.h>
 #include <linux/ratelimit.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
@@ -324,10 +325,12 @@ EXPORT_SYMBOL(can_send);
 static struct can_dev_rcv_lists *can_dev_rcv_lists_find(struct net *net,
 							struct net_device *dev)
 {
-	if (!dev)
+	if (dev) {
+		struct can_ml_priv *ml_priv = dev->ml_priv;
+		return &ml_priv->dev_rcv_lists;
+	} else {
 		return net->can.can_rx_alldev_list;
-	else
-		return (struct can_dev_rcv_lists *)dev->ml_priv;
+	}
 }
 
 /**
@@ -589,12 +592,6 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
 	if (can_pstats->rcv_entries > 0)
 		can_pstats->rcv_entries--;
 
-	/* remove device structure requested by NETDEV_UNREGISTER */
-	if (dev_rcv_lists->remove_on_zero_entries && !dev_rcv_lists->entries) {
-		kfree(dev_rcv_lists);
-		dev->ml_priv = NULL;
-	}
-
  out:
 	spin_unlock(&net->can.can_rcvlists_lock);
 
@@ -827,7 +824,6 @@ static int can_notifier(struct notifier_block *nb, unsigned long msg,
 			void *ptr)
 {
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
-	struct can_dev_rcv_lists *dev_rcv_lists;
 
 	if (dev->type != ARPHRD_CAN)
 		return NOTIFY_DONE;
@@ -835,33 +831,8 @@ static int can_notifier(struct notifier_block *nb, unsigned long msg,
 	switch (msg) {
 
 	case NETDEV_REGISTER:
-
-		/* create new dev_rcv_lists for this device */
-		dev_rcv_lists = kzalloc(sizeof(*dev_rcv_lists), GFP_KERNEL);
-		if (!dev_rcv_lists)
-			return NOTIFY_DONE;
-		BUG_ON(dev->ml_priv);
-		dev->ml_priv = dev_rcv_lists;
-
-		break;
-
-	case NETDEV_UNREGISTER:
-		spin_lock(&dev_net(dev)->can.can_rcvlists_lock);
-
-		dev_rcv_lists = dev->ml_priv;
-		if (dev_rcv_lists) {
-			if (dev_rcv_lists->entries)
-				dev_rcv_lists->remove_on_zero_entries = 1;
-			else {
-				kfree(dev_rcv_lists);
-				dev->ml_priv = NULL;
-			}
-		} else
-			pr_err("can: notifier: receive list not found for dev "
-			       "%s\n", dev->name);
-
-		spin_unlock(&dev_net(dev)->can.can_rcvlists_lock);
-
+		WARN(!dev->ml_priv,
+		     "No CAN mid layer private allocated, please fix your driver and use alloc_candev()!\n");
 		break;
 	}
 
diff --git a/net/can/af_can.h b/net/can/af_can.h
index 4b77c7951f17..dc198a07a8d1 100644
--- a/net/can/af_can.h
+++ b/net/can/af_can.h
@@ -71,7 +71,6 @@ struct can_dev_rcv_lists {
 	struct hlist_head rx[RX_MAX];
 	struct hlist_head rx_sff[CAN_SFF_RCV_ARRAY_SZ];
 	struct hlist_head rx_eff[CAN_EFF_RCV_ARRAY_SZ];
-	int remove_on_zero_entries;
 	int entries;
 };
 
-- 
2.13.2

