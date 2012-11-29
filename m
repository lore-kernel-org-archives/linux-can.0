From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC v2 3/7] c_can: use different sets of interface registers for rx and tx
Date: Thu, 29 Nov 2012 15:39:43 +0100
Message-ID: <1354199987-10350-4-git-send-email-wg@grandegger.com>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:44194 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836Ab2K2Oj4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 29 Nov 2012 09:39:56 -0500
In-Reply-To: <1354199987-10350-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: bhupesh.sharma@st.com, tomoya.rohm@gmail.com, Wolfgang Grandegger <wg@grandegger.com>

To avoid conflicts between CPU access to the message RAM we now
use the first set of interface registers for RX and the second
for TX.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/c_can/c_can.c |   37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 3ae356f..27e45e6 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -158,6 +158,10 @@
 #define C_CAN_NEXT_MSG_OBJ_MASK	(C_CAN_MSG_OBJ_TX_NUM - 1)
 #define RECEIVE_OBJECT_BITS	0x0000ffff
 
+/* message interface used for rx and tx */
+#define IFACE_RX		0
+#define IFACE_TX		1
+
 /* status interrupt */
 #define STATUS_INTERRUPT	0x8000
 
@@ -544,7 +548,7 @@ static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
 	msg_obj_no = get_tx_next_msg_obj(priv);
 
 	/* prepare message object for transmission */
-	c_can_write_msg_object(dev, 0, frame, msg_obj_no);
+	c_can_write_msg_object(dev, IFACE_TX, frame, msg_obj_no);
 	can_put_echo_skb(skb, dev, msg_obj_no - C_CAN_MSG_OBJ_TX_FIRST);
 
 	/*
@@ -606,16 +610,18 @@ static void c_can_configure_msg_objects(struct net_device *dev)
 	int i;
 
 	/* first invalidate all message objects */
-	for (i = C_CAN_MSG_OBJ_RX_FIRST; i <= C_CAN_NO_OF_OBJECTS; i++)
-		c_can_inval_msg_object(dev, 0, i);
+	for (i = C_CAN_MSG_OBJ_RX_FIRST; i <= C_CAN_MSG_OBJ_RX_LAST; i++)
+		c_can_inval_msg_object(dev, IFACE_RX, i);
+	for (i = C_CAN_MSG_OBJ_TX_FIRST; i <= C_CAN_MSG_OBJ_TX_LAST; i++)
+		c_can_inval_msg_object(dev, IFACE_TX, i);
 
 	/* setup receive message objects */
 	for (i = C_CAN_MSG_OBJ_RX_FIRST; i < C_CAN_MSG_OBJ_RX_LAST; i++)
-		c_can_setup_receive_object(dev, 0, i, 0, 0,
+		c_can_setup_receive_object(dev, IFACE_RX, i, 0, 0,
 			(IF_MCONT_RXIE | IF_MCONT_UMASK) & ~IF_MCONT_EOB);
 
-	c_can_setup_receive_object(dev, 0, C_CAN_MSG_OBJ_RX_LAST, 0, 0,
-			IF_MCONT_EOB | IF_MCONT_RXIE | IF_MCONT_UMASK);
+	c_can_setup_receive_object(dev, IFACE_RX, C_CAN_MSG_OBJ_RX_LAST,
+			0, 0, IF_MCONT_EOB | IF_MCONT_RXIE | IF_MCONT_UMASK);
 }
 
 /*
@@ -748,10 +754,10 @@ static void c_can_do_tx(struct net_device *dev)
 			can_get_echo_skb(dev,
 					msg_obj_no - C_CAN_MSG_OBJ_TX_FIRST);
 			stats->tx_bytes += priv->read_reg(priv,
-					C_CAN_IFACE(MSGCTRL_REG, 0))
+					C_CAN_IFACE(MSGCTRL_REG, IFACE_TX))
 					& IF_MCONT_DLC_MASK;
 			stats->tx_packets++;
-			c_can_inval_msg_object(dev, 0, msg_obj_no);
+			c_can_inval_msg_object(dev, IFACE_TX, msg_obj_no);
 		} else {
 			break;
 		}
@@ -801,16 +807,17 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
 		 * message object n, we need to handle the same properly.
 		 */
 		if (val & (1 << (msg_obj - 1))) {
-			c_can_object_get(dev, 0, msg_obj, IF_COMM_ALL &
+			c_can_object_get(dev, IFACE_RX, msg_obj, IF_COMM_ALL &
 					~IF_COMM_TXRQST);
 			msg_ctrl_save = priv->read_reg(priv,
-					C_CAN_IFACE(MSGCTRL_REG, 0));
+					C_CAN_IFACE(MSGCTRL_REG, IFACE_RX));
 
 			if (msg_ctrl_save & IF_MCONT_EOB)
 				return num_rx_pkts;
 
 			if (msg_ctrl_save & IF_MCONT_MSGLST) {
-				c_can_handle_lost_msg_obj(dev, 0, msg_obj);
+				c_can_handle_lost_msg_obj(dev, IFACE_RX,
+								msg_obj);
 				num_rx_pkts++;
 				quota--;
 				continue;
@@ -820,19 +827,19 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
 				continue;
 
 			/* read the data from the message object */
-			c_can_read_msg_object(dev, 0, msg_ctrl_save);
+			c_can_read_msg_object(dev, IFACE_RX, msg_ctrl_save);
 
 			if (msg_obj < C_CAN_MSG_RX_LOW_LAST)
-				c_can_mark_rx_msg_obj(dev, 0,
+				c_can_mark_rx_msg_obj(dev, IFACE_RX,
 						msg_ctrl_save, msg_obj);
 			else if (msg_obj > C_CAN_MSG_RX_LOW_LAST)
 				/* activate this msg obj */
-				c_can_activate_rx_msg_obj(dev, 0,
+				c_can_activate_rx_msg_obj(dev, IFACE_RX,
 						msg_ctrl_save, msg_obj);
 			else if (msg_obj == C_CAN_MSG_RX_LOW_LAST)
 				/* activate all lower message objects */
 				c_can_activate_all_lower_rx_msg_obj(dev,
-						0, msg_ctrl_save);
+						IFACE_RX, msg_ctrl_save);
 
 			num_rx_pkts++;
 			quota--;
-- 
1.7.9.5

