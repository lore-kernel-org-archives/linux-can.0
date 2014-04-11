From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 21/21] can: c_can: Speed up tx buffer invalidation
Date: Fri, 11 Apr 2014 08:13:22 -0000
Message-ID: <20140411080654.280509182@linutronix.de>
References: <20140411080547.845836199@linutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52488 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580AbaDKINK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Apr 2014 04:13:10 -0400
Content-Disposition: inline; filename=can-c_can-speed-up-tx-inval.patch
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Mark <mark5@del-llc.com>

It's suffcient to kill the TXIE bit in the message control register
even if the documentation of C and D CAN says that it's not allowed to
do that while MSGVAL is set. Reality tells a different story and this
change gives us another 2% of CPU back for not waiting on I/O.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/c_can.c |   54 ++++++++++++++++++++++++++++++------------
 drivers/net/can/c_can/c_can.h |    1 
 2 files changed, 40 insertions(+), 15 deletions(-)

Index: linux-2.6/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/c_can.c
+++ linux-2.6/drivers/net/can/c_can/c_can.c
@@ -276,11 +276,34 @@ static inline void c_can_object_put(stru
 	c_can_obj_update(dev, iface, cmd | IF_COMM_WR, obj);
 }
 
+/*
+ * Note: According to documentation clearing TXIE while MSGVAL is set
+ * is not allowed, but works nicely on C/DCAN. And that lowers the I/O
+ * load significantly.
+ */
+static void c_can_inval_tx_object(struct net_device *dev, int iface, int obj)
+{
+	struct c_can_priv *priv = netdev_priv(dev);
+
+	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), 0);
+	c_can_object_put(dev, iface, obj, IF_COMM_INVAL);
+}
+
+static void c_can_inval_msg_object(struct net_device *dev, int iface, int obj)
+{
+	struct c_can_priv *priv = netdev_priv(dev);
+
+	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface), 0);
+	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface), 0);
+	c_can_inval_tx_object(dev, iface, obj);
+}
+
 static void c_can_setup_tx_object(struct net_device *dev, int iface,
-				  struct can_frame *frame, int obj)
+				  struct can_frame *frame, int idx)
 {
 	struct c_can_priv *priv = netdev_priv(dev);
 	u16 ctrl = IF_MCONT_TX | frame->can_dlc;
+	bool rtr = frame->can_id & CAN_RTR_FLAG;
 	u32 arb = IF_ARB_MSGVAL;
 	int i;
 
@@ -291,9 +314,20 @@ static void c_can_setup_tx_object(struct
 		arb |= (frame->can_id & CAN_SFF_MASK) << 18;
 	}
 
-	if (!(frame->can_id & CAN_RTR_FLAG))
+	if (!rtr)
 		arb |= IF_ARB_TRANSMIT;
 
+	/*
+	 * If we change the DIR bit, we need to invalidate the buffer
+	 * first, i.e. clear the MSGVAL flag in the arbiter.
+	 */
+	if (rtr != (bool)test_bit(idx, &priv->tx_dir)) {
+		u32 obj = idx + C_CAN_MSG_OBJ_TX_FIRST;
+
+		c_can_inval_msg_object(dev, iface, obj);
+		change_bit(idx, &priv->tx_dir);
+	}
+
 	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface), arb);
 	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface), arb >> 16);
 
@@ -401,17 +435,6 @@ static void c_can_setup_receive_object(s
 	c_can_object_put(dev, iface, obj, IF_COMM_RCV_SETUP);
 }
 
-static void c_can_inval_msg_object(struct net_device *dev, int iface, int obj)
-{
-	struct c_can_priv *priv = netdev_priv(dev);
-
-	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface), 0);
-	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface), 0);
-	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), 0);
-
-	c_can_object_put(dev, iface, obj, IF_COMM_INVAL);
-}
-
 static netdev_tx_t c_can_start_xmit(struct sk_buff *skb,
 				    struct net_device *dev)
 {
@@ -436,7 +459,7 @@ static netdev_tx_t c_can_start_xmit(stru
 	 * can_put_echo_skb(). We must do this before we enable
 	 * transmit as we might race against do_tx().
 	 */
-	c_can_setup_tx_object(dev, IF_TX, frame, obj);
+	c_can_setup_tx_object(dev, IF_TX, frame, idx);
 	priv->dlc[idx] = frame->can_dlc;
 	can_put_echo_skb(skb, dev, idx);
 
@@ -563,6 +586,7 @@ static int c_can_chip_config(struct net_
 	/* Clear all internal status */
 	atomic_set(&priv->tx_active, 0);
 	priv->rxmasked = 0;
+	priv->tx_dir = 0;
 
 	/* set bittiming params */
 	return c_can_set_bittiming(dev);
@@ -654,7 +678,7 @@ static void c_can_do_tx(struct net_devic
 		idx--;
 		pend &= ~(1 << idx);
 		obj = idx + C_CAN_MSG_OBJ_TX_FIRST;
-		c_can_inval_msg_object(dev, IF_RX, obj);
+		c_can_inval_tx_object(dev, IF_RX, obj);
 		can_get_echo_skb(dev, idx);
 		bytes += priv->dlc[idx];
 		pkts++;
Index: linux-2.6/drivers/net/can/c_can/c_can.h
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/c_can.h
+++ linux-2.6/drivers/net/can/c_can/c_can.h
@@ -174,6 +174,7 @@ struct c_can_priv {
 	struct net_device *dev;
 	struct device *device;
 	atomic_t tx_active;
+	unsigned long tx_dir;
 	int last_status;
 	u16 (*read_reg) (struct c_can_priv *priv, enum reg index);
 	void (*write_reg) (struct c_can_priv *priv, enum reg index, u16 val);


