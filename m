From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC v3 3/7] c_can: use different sets of interface registers for rx and tx
Date: Tue, 11 Dec 2012 22:18:50 +0100
Message-ID: <1355260735-18994-4-git-send-email-wg@grandegger.com>
References: <1355260735-18994-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:59221 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053Ab2LKVTP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Dec 2012 16:19:15 -0500
In-Reply-To: <1355260735-18994-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Alexander.Stein@systec-electronic.com, Christian.Bendele@gmx.net, Michael Pellegrini <mikep86@gmail.com>, bhupesh.sharma@st.com, Wolfgang Grandegger <wg@grandegger.com>

To avoid conflicts between CPU access to the message RAM we now
use the first set of interface registers for RX and the second
for TX.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/c_can/c_can.c |   73 ++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 31 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 3ae356f..b0738c9 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -158,6 +158,12 @@
 #define C_CAN_NEXT_MSG_OBJ_MASK	(C_CAN_MSG_OBJ_TX_NUM - 1)
 #define RECEIVE_OBJECT_BITS	0x0000ffff
 
+/* interface register sets used for rx and tx */
+enum c_can_iface {
+	C_CAN_IFACE_RX = 0,
+	C_CAN_IFACE_TX = 1,
+};
+
 /* status interrupt */
 #define STATUS_INTERRUPT	0x8000
 
@@ -272,7 +278,8 @@ static void c_can_enable_all_interrupts(struct c_can_priv *priv,
 	priv->write_reg(priv, C_CAN_CTRL_REG, cntrl_save);
 }
 
-static inline int c_can_msg_obj_is_busy(struct c_can_priv *priv, int iface)
+static inline int c_can_msg_obj_is_busy(struct c_can_priv *priv,
+					enum c_can_iface iface)
 {
 	int count = MIN_TIMEOUT_VALUE;
 
@@ -290,7 +297,7 @@ static inline int c_can_msg_obj_is_busy(struct c_can_priv *priv, int iface)
 }
 
 static inline void c_can_object_get(struct net_device *dev,
-					int iface, int objno, int mask)
+				enum c_can_iface iface, int objno, int mask)
 {
 	struct c_can_priv *priv = netdev_priv(dev);
 
@@ -310,7 +317,7 @@ static inline void c_can_object_get(struct net_device *dev,
 }
 
 static inline void c_can_object_put(struct net_device *dev,
-					int iface, int objno, int mask)
+				enum c_can_iface iface, int objno, int mask)
 {
 	struct c_can_priv *priv = netdev_priv(dev);
 
@@ -330,7 +337,7 @@ static inline void c_can_object_put(struct net_device *dev,
 }
 
 static void c_can_write_msg_object(struct net_device *dev,
-			int iface, struct can_frame *frame, int objno)
+		enum c_can_iface iface, struct can_frame *frame, int objno)
 {
 	int i;
 	u16 flags = 0;
@@ -366,8 +373,7 @@ static void c_can_write_msg_object(struct net_device *dev,
 }
 
 static inline void c_can_mark_rx_msg_obj(struct net_device *dev,
-						int iface, int ctrl_mask,
-						int obj)
+				enum c_can_iface iface, int ctrl_mask, int obj)
 {
 	struct c_can_priv *priv = netdev_priv(dev);
 
@@ -378,8 +384,7 @@ static inline void c_can_mark_rx_msg_obj(struct net_device *dev,
 }
 
 static inline void c_can_activate_all_lower_rx_msg_obj(struct net_device *dev,
-						int iface,
-						int ctrl_mask)
+					enum c_can_iface iface, int ctrl_mask)
 {
 	int i;
 	struct c_can_priv *priv = netdev_priv(dev);
@@ -393,8 +398,7 @@ static inline void c_can_activate_all_lower_rx_msg_obj(struct net_device *dev,
 }
 
 static inline void c_can_activate_rx_msg_obj(struct net_device *dev,
-						int iface, int ctrl_mask,
-						int obj)
+				enum c_can_iface iface, int ctrl_mask, int obj)
 {
 	struct c_can_priv *priv = netdev_priv(dev);
 
@@ -405,7 +409,7 @@ static inline void c_can_activate_rx_msg_obj(struct net_device *dev,
 }
 
 static void c_can_handle_lost_msg_obj(struct net_device *dev,
-					int iface, int objno)
+					enum c_can_iface iface, int objno)
 {
 	struct c_can_priv *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
@@ -434,7 +438,8 @@ static void c_can_handle_lost_msg_obj(struct net_device *dev,
 	netif_receive_skb(skb);
 }
 
-static int c_can_read_msg_object(struct net_device *dev, int iface, int ctrl)
+static int c_can_read_msg_object(struct net_device *dev,
+					enum c_can_iface iface, int ctrl)
 {
 	u16 flags, data;
 	int i;
@@ -480,7 +485,8 @@ static int c_can_read_msg_object(struct net_device *dev, int iface, int ctrl)
 	return 0;
 }
 
-static void c_can_setup_receive_object(struct net_device *dev, int iface,
+static void c_can_setup_receive_object(struct net_device *dev,
+					enum c_can_iface iface,
 					int objno, unsigned int mask,
 					unsigned int id, unsigned int mcont)
 {
@@ -503,7 +509,8 @@ static void c_can_setup_receive_object(struct net_device *dev, int iface,
 			c_can_read_reg32(priv, C_CAN_MSGVAL1_REG));
 }
 
-static void c_can_inval_msg_object(struct net_device *dev, int iface, int objno)
+static void c_can_inval_msg_object(struct net_device *dev,
+					enum c_can_iface iface, int objno)
 {
 	struct c_can_priv *priv = netdev_priv(dev);
 
@@ -544,7 +551,7 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
 	msg_obj_no = get_tx_next_msg_obj(priv);
 
 	/* prepare message object for transmission */
-	c_can_write_msg_object(dev, 0, frame, msg_obj_no);
+	c_can_write_msg_object(dev, C_CAN_IFACE_TX, frame, msg_obj_no);
 	can_put_echo_skb(skb, dev, msg_obj_no - C_CAN_MSG_OBJ_TX_FIRST);
 
 	/*
@@ -606,16 +613,18 @@ static void c_can_configure_msg_objects(struct net_device *dev)
 	int i;
 
 	/* first invalidate all message objects */
-	for (i = C_CAN_MSG_OBJ_RX_FIRST; i <= C_CAN_NO_OF_OBJECTS; i++)
-		c_can_inval_msg_object(dev, 0, i);
+	for (i = C_CAN_MSG_OBJ_RX_FIRST; i <= C_CAN_MSG_OBJ_RX_LAST; i++)
+		c_can_inval_msg_object(dev, C_CAN_IFACE_RX, i);
+	for (i = C_CAN_MSG_OBJ_TX_FIRST; i <= C_CAN_MSG_OBJ_TX_LAST; i++)
+		c_can_inval_msg_object(dev, C_CAN_IFACE_TX, i);
 
 	/* setup receive message objects */
 	for (i = C_CAN_MSG_OBJ_RX_FIRST; i < C_CAN_MSG_OBJ_RX_LAST; i++)
-		c_can_setup_receive_object(dev, 0, i, 0, 0,
+		c_can_setup_receive_object(dev, C_CAN_IFACE_RX, i, 0, 0,
 			(IF_MCONT_RXIE | IF_MCONT_UMASK) & ~IF_MCONT_EOB);
 
-	c_can_setup_receive_object(dev, 0, C_CAN_MSG_OBJ_RX_LAST, 0, 0,
-			IF_MCONT_EOB | IF_MCONT_RXIE | IF_MCONT_UMASK);
+	c_can_setup_receive_object(dev, C_CAN_IFACE_RX, C_CAN_MSG_OBJ_RX_LAST,
+			0, 0, IF_MCONT_EOB | IF_MCONT_RXIE | IF_MCONT_UMASK);
 }
 
 /*
@@ -748,10 +757,10 @@ static void c_can_do_tx(struct net_device *dev)
 			can_get_echo_skb(dev,
 					msg_obj_no - C_CAN_MSG_OBJ_TX_FIRST);
 			stats->tx_bytes += priv->read_reg(priv,
-					C_CAN_IFACE(MSGCTRL_REG, 0))
-					& IF_MCONT_DLC_MASK;
+				C_CAN_IFACE(MSGCTRL_REG, C_CAN_IFACE_TX))
+				& IF_MCONT_DLC_MASK;
 			stats->tx_packets++;
-			c_can_inval_msg_object(dev, 0, msg_obj_no);
+			c_can_inval_msg_object(dev, C_CAN_IFACE_TX, msg_obj_no);
 		} else {
 			break;
 		}
@@ -801,16 +810,17 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
 		 * message object n, we need to handle the same properly.
 		 */
 		if (val & (1 << (msg_obj - 1))) {
-			c_can_object_get(dev, 0, msg_obj, IF_COMM_ALL &
-					~IF_COMM_TXRQST);
+			c_can_object_get(dev, C_CAN_IFACE_RX, msg_obj,
+					IF_COMM_ALL & ~IF_COMM_TXRQST);
 			msg_ctrl_save = priv->read_reg(priv,
-					C_CAN_IFACE(MSGCTRL_REG, 0));
+				C_CAN_IFACE(MSGCTRL_REG, C_CAN_IFACE_RX));
 
 			if (msg_ctrl_save & IF_MCONT_EOB)
 				return num_rx_pkts;
 
 			if (msg_ctrl_save & IF_MCONT_MSGLST) {
-				c_can_handle_lost_msg_obj(dev, 0, msg_obj);
+				c_can_handle_lost_msg_obj(dev, C_CAN_IFACE_RX,
+								msg_obj);
 				num_rx_pkts++;
 				quota--;
 				continue;
@@ -820,19 +830,20 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
 				continue;
 
 			/* read the data from the message object */
-			c_can_read_msg_object(dev, 0, msg_ctrl_save);
+			c_can_read_msg_object(dev, C_CAN_IFACE_RX,
+						msg_ctrl_save);
 
 			if (msg_obj < C_CAN_MSG_RX_LOW_LAST)
-				c_can_mark_rx_msg_obj(dev, 0,
+				c_can_mark_rx_msg_obj(dev, C_CAN_IFACE_RX,
 						msg_ctrl_save, msg_obj);
 			else if (msg_obj > C_CAN_MSG_RX_LOW_LAST)
 				/* activate this msg obj */
-				c_can_activate_rx_msg_obj(dev, 0,
+				c_can_activate_rx_msg_obj(dev, C_CAN_IFACE_RX,
 						msg_ctrl_save, msg_obj);
 			else if (msg_obj == C_CAN_MSG_RX_LOW_LAST)
 				/* activate all lower message objects */
 				c_can_activate_all_lower_rx_msg_obj(dev,
-						0, msg_ctrl_save);
+						C_CAN_IFACE_RX, msg_ctrl_save);
 
 			num_rx_pkts++;
 			quota--;
-- 
1.7.9.5

