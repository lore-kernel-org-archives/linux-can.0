From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC v2 7/7] c_can: add spinlock to protect tx and rx objects
Date: Thu, 29 Nov 2012 15:39:47 +0100
Message-ID: <1354199987-10350-8-git-send-email-wg@grandegger.com>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:44219 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841Ab2K2Oj6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 29 Nov 2012 09:39:58 -0500
In-Reply-To: <1354199987-10350-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: bhupesh.sharma@st.com, tomoya.rohm@gmail.com, Wolfgang Grandegger <wg@grandegger.com>

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/c_can/c_can.c |   13 +++++++++++++
 drivers/net/can/c_can/c_can.h |    1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 27e45e6..b024665 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -34,6 +34,7 @@
 #include <linux/if_ether.h>
 #include <linux/list.h>
 #include <linux/io.h>
+#include <linux/spinlock.h>
 #include <linux/pm_runtime.h>
 
 #include <linux/can.h>
@@ -541,10 +542,13 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
 	u32 msg_obj_no;
 	struct c_can_priv *priv = netdev_priv(dev);
 	struct can_frame *frame = (struct can_frame *)skb->data;
+	unsigned long flags;
 
 	if (can_dropped_invalid_skb(dev, skb))
 		return NETDEV_TX_OK;
 
+	spin_lock_irqsave(&priv->lock, flags);
+
 	msg_obj_no = get_tx_next_msg_obj(priv);
 
 	/* prepare message object for transmission */
@@ -560,6 +564,8 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
 			(priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) == 0)
 		netif_stop_queue(dev);
 
+	spin_unlock_irqrestore(&priv->lock, flags);
+
 	return NETDEV_TX_OK;
 }
 
@@ -746,6 +752,9 @@ static void c_can_do_tx(struct net_device *dev)
 	u32 msg_obj_no;
 	struct c_can_priv *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
 
 	for (/* nix */; (priv->tx_next - priv->tx_echo) > 0; priv->tx_echo++) {
 		msg_obj_no = get_tx_echo_msg_obj(priv);
@@ -767,6 +776,8 @@ static void c_can_do_tx(struct net_device *dev)
 	if (((priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) != 0) ||
 			((priv->tx_echo & C_CAN_NEXT_MSG_OBJ_MASK) == 0))
 		netif_wake_queue(dev);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
 /*
@@ -1173,6 +1184,8 @@ struct net_device *alloc_c_can_dev(void)
 					CAN_CTRLMODE_LISTENONLY |
 					CAN_CTRLMODE_BERR_REPORTING;
 
+	spin_lock_init(&priv->lock);
+
 	return dev;
 }
 EXPORT_SYMBOL_GPL(alloc_c_can_dev);
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 4baf3f6..3487d5e 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -172,6 +172,7 @@ struct c_can_priv {
 	u32 __iomem *raminit_ctrlreg;
 	unsigned int instance;
 	void (*init) (const struct c_can_priv *priv, bool enable);
+	spinlock_t lock;	/* to protect tx and rx message objects */
 };
 
 struct net_device *alloc_c_can_dev(void);
-- 
1.7.9.5

