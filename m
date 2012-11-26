From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC 2/6] c_can: add spinlock to protect tx and rx objects
Date: Mon, 26 Nov 2012 09:23:02 +0100
Message-ID: <1353918186-4234-3-git-send-email-wg@grandegger.com>
References: <1353918186-4234-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:33878 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315Ab2KZIXg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 03:23:36 -0500
In-Reply-To: <1353918186-4234-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: bhupesh.sharma@st.com, tomoya.rohm@gmail.com, Wolfgang Grandegger <wg@grandegger.com>

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/c_can/c_can.c |   21 ++++++++++++++++++++-
 drivers/net/can/c_can/c_can.h |    1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index e5180df..4fab6b8 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -34,6 +34,7 @@
 #include <linux/if_ether.h>
 #include <linux/list.h>
 #include <linux/io.h>
+#include <linux/spinlock.h>
 #include <linux/pm_runtime.h>
 
 #include <linux/can.h>
@@ -531,10 +532,13 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
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
@@ -550,6 +554,8 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
 			(priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) == 0)
 		netif_stop_queue(dev);
 
+	spin_unlock_irqrestore(&priv->lock, flags);
+
 	return NETDEV_TX_OK;
 }
 
@@ -734,6 +740,9 @@ static void c_can_do_tx(struct net_device *dev)
 	u32 msg_obj_no;
 	struct c_can_priv *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
 
 	for (/* nix */; (priv->tx_next - priv->tx_echo) > 0; priv->tx_echo++) {
 		msg_obj_no = get_tx_echo_msg_obj(priv);
@@ -755,6 +764,8 @@ static void c_can_do_tx(struct net_device *dev)
 	if (((priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) != 0) ||
 			((priv->tx_echo & C_CAN_NEXT_MSG_OBJ_MASK) == 0))
 		netif_wake_queue(dev);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
 /*
@@ -785,6 +796,9 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
 	unsigned int msg_obj, msg_ctrl_save;
 	struct c_can_priv *priv = netdev_priv(dev);
 	u32 val = c_can_read_reg32(priv, C_CAN_INTPND1_REG);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
 
 	for (msg_obj = C_CAN_MSG_OBJ_RX_FIRST;
 			msg_obj <= C_CAN_MSG_OBJ_RX_LAST && quota > 0;
@@ -801,7 +815,7 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
 					C_CAN_IFACE(MSGCTRL_REG, 0));
 
 			if (msg_ctrl_save & IF_MCONT_EOB)
-				return num_rx_pkts;
+				goto out;
 
 			if (msg_ctrl_save & IF_MCONT_MSGLST) {
 				c_can_handle_lost_msg_obj(dev, 0, msg_obj);
@@ -833,6 +847,9 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
 		}
 	}
 
+out:
+	spin_unlock_irqrestore(&priv->lock, flags);
+
 	return num_rx_pkts;
 }
 
@@ -1156,6 +1173,8 @@ struct net_device *alloc_c_can_dev(void)
 					CAN_CTRLMODE_LISTENONLY |
 					CAN_CTRLMODE_BERR_REPORTING;
 
+	spin_lock_init(&priv->lock);
+
 	return dev;
 }
 EXPORT_SYMBOL_GPL(alloc_c_can_dev);
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index e5ed41d..c683f0d 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -169,6 +169,7 @@ struct c_can_priv {
 	void *priv;		/* for board-specific data */
 	u16 irqstatus;
 	enum c_can_dev_id type;
+	spinlock_t lock;	/* to protect tx and rx message objects */
 };
 
 struct net_device *alloc_c_can_dev(void);
-- 
1.7.9.5

