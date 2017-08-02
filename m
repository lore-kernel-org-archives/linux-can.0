From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 12/14] can: introduce CAN midlayer private and allocate it automatically
Date: Wed,  2 Aug 2017 19:44:32 +0200
Message-ID: <20170802174434.4689-13-mkl@pengutronix.de>
References: <20170802174434.4689-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34063 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752564AbdHBRop (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Aug 2017 13:44:45 -0400
In-Reply-To: <20170802174434.4689-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

This patch introduces the CAN midlayer private structure ("struct
can_ml_priv") which should be used to hold protocol specific per device
data structures. For now it's only member is "struct can_dev_rcv_lists".

The CAN midlayer private is allocated via alloc_netdev()'s private and
assigned to "struct net_device::ml_priv" during device creation. This is
done transparently for CAN drivers using alloc_candev(). The slcan, vcan
and vxcan drivers which are not using alloc_candev() have been adopted
manually. The memory layout of the netdev_priv allocated via
alloc_candev() will looke like this:

  +-------------------------+
  | driver's priv           |
  +-------------------------+
  | struct can_ml_priv      |
  +-------------------------+
  | array of struct sk_buff |
  +-------------------------+

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c      | 22 ++++++++++++++++++----
 drivers/net/can/slcan.c    |  4 +++-
 drivers/net/can/vcan.c     |  6 ++++--
 drivers/net/can/vxcan.c    |  2 +-
 include/linux/can/can-ml.h | 23 +++++++++++++++++++++++
 5 files changed, 49 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/can/can-ml.h

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 365a8cc62405..85a636760b98 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -23,6 +23,7 @@
 #include <linux/if_arp.h>
 #include <linux/workqueue.h>
 #include <linux/can.h>
+#include <linux/can/can-ml.h>
 #include <linux/can/dev.h>
 #include <linux/can/skb.h>
 #include <linux/can/netlink.h>
@@ -708,11 +709,24 @@ struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max)
 	struct can_priv *priv;
 	int size;
 
+	/* We put the driver's priv, the CAN mid layer priv and the
+	 * echo skb into the netdevice's priv. The memory layout for
+	 * the netdev_priv is like this:
+	 *
+	 * +-------------------------+
+	 * | driver's priv           |
+	 * +-------------------------+
+	 * | struct can_ml_priv      |
+	 * +-------------------------+
+	 * | array of struct sk_buff |
+	 * +-------------------------+
+	 */
+
+	size = ALIGN(sizeof_priv, NETDEV_ALIGN) + sizeof(struct can_ml_priv);
+
 	if (echo_skb_max)
-		size = ALIGN(sizeof_priv, sizeof(struct sk_buff *)) +
+		size = ALIGN(size, sizeof(struct sk_buff *)) +
 			echo_skb_max * sizeof(struct sk_buff *);
-	else
-		size = sizeof_priv;
 
 	dev = alloc_netdev(size, "can%d", NET_NAME_UNKNOWN, can_setup);
 	if (!dev)
@@ -724,7 +738,7 @@ struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max)
 	if (echo_skb_max) {
 		priv->echo_skb_max = echo_skb_max;
 		priv->echo_skb = (void *)priv +
-			ALIGN(sizeof_priv, sizeof(struct sk_buff *));
+			(size - echo_skb_max * sizeof(struct sk_buff *));
 	}
 
 	priv->state = CAN_STATE_STOPPED;
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 5d067c1b987f..f1647b4fd1e6 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -514,6 +514,7 @@ static struct slcan *slc_alloc(dev_t line)
 	char name[IFNAMSIZ];
 	struct net_device *dev = NULL;
 	struct slcan       *sl;
+	int size;
 
 	for (i = 0; i < maxdev; i++) {
 		dev = slcan_devs[i];
@@ -527,7 +528,8 @@ static struct slcan *slc_alloc(dev_t line)
 		return NULL;
 
 	sprintf(name, "slcan%d", i);
-	dev = alloc_netdev(sizeof(*sl), name, NET_NAME_UNKNOWN, slc_setup);
+	size = ALIGN(sizeof(*sl), NETDEV_ALIGN) + sizeof(struct can_ml_priv);
+	dev = alloc_netdev(size, name, NET_NAME_UNKNOWN, slc_setup);
 	if (!dev)
 		return NULL;
 
diff --git a/drivers/net/can/vcan.c b/drivers/net/can/vcan.c
index a8cb33264ff1..96e42eab2426 100644
--- a/drivers/net/can/vcan.c
+++ b/drivers/net/can/vcan.c
@@ -45,6 +45,7 @@
 #include <linux/if_arp.h>
 #include <linux/if_ether.h>
 #include <linux/can.h>
+#include <linux/can/can-ml.h>
 #include <linux/can/dev.h>
 #include <linux/can/skb.h>
 #include <linux/slab.h>
@@ -167,8 +168,9 @@ static void vcan_setup(struct net_device *dev)
 }
 
 static struct rtnl_link_ops vcan_link_ops __read_mostly = {
-	.kind	= DRV_NAME,
-	.setup	= vcan_setup,
+	.kind = DRV_NAME,
+	.priv_size = sizeof(struct can_ml_priv),
+	.setup = vcan_setup,
 };
 
 static __init int vcan_init_module(void)
diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 8404e8852a0f..8925d797e8ac 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -292,7 +292,7 @@ static struct net *vxcan_get_link_net(const struct net_device *dev)
 
 static struct rtnl_link_ops vxcan_link_ops = {
 	.kind		= DRV_NAME,
-	.priv_size	= sizeof(struct vxcan_priv),
+	.priv_size	= ALIGN(sizeof(struct vxcan_priv), NETDEV_ALIGN) + sizeof(struct can_ml_priv);
 	.setup		= vxcan_setup,
 	.newlink	= vxcan_newlink,
 	.dellink	= vxcan_dellink,
diff --git a/include/linux/can/can-ml.h b/include/linux/can/can-ml.h
new file mode 100644
index 000000000000..2786b04251ea
--- /dev/null
+++ b/include/linux/can/can-ml.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2017 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+#ifndef CAN_ML_H
+#define CAN_ML_H
+
+#include "../../net/can/af_can.h"
+
+struct can_ml_priv {
+	struct can_dev_rcv_lists dev_rcv_lists;
+};
+
+#endif /* CAN_ML_H */
-- 
2.13.2

