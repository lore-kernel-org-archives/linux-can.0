From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 07/10] can: c_can: Simplify buffer reenabling
Date: Fri, 04 Apr 2014 15:24:26 -0000
Message-ID: <20140404134857.523481518@linutronix.de>
References: <20140404134816.751883017@linutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41549 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010AbaDDPYO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Apr 2014 11:24:14 -0400
Content-Disposition: inline;
 filename=can-c_can-Simplify-buffer-reenabling.patch
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>

Instead of writing to the message object we can simply clear the
NewDat bit with the get method.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/c_can.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

Index: linux-can/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-can.orig/drivers/net/can/c_can/c_can.c
+++ linux-can/drivers/net/can/c_can/c_can.c
@@ -108,6 +108,7 @@
 #define IF_COMM_CONTROL		BIT(4)
 #define IF_COMM_CLR_INT_PND	BIT(3)
 #define IF_COMM_TXRQST		BIT(2)
+#define IF_COMM_CLR_NEWDAT	IF_COMM_TXRQST
 #define IF_COMM_DATAA		BIT(1)
 #define IF_COMM_DATAB		BIT(0)
 #define IF_COMM_ALL		(IF_COMM_MASK | IF_COMM_ARB | \
@@ -120,7 +121,7 @@
 				 IF_COMM_DATAA | IF_COMM_DATAB)
 
 /* For the high buffers we clear the interrupt bit and newdat */
-#define IF_COMM_RCV_HIGH	(IF_COMM_RCV_LOW | IF_COMM_TXRQST)
+#define IF_COMM_RCV_HIGH	(IF_COMM_RCV_LOW | IF_COMM_CLR_NEWDAT)
 
 /* IFx arbitration */
 #define IF_ARB_MSGVAL		BIT(15)
@@ -353,17 +354,12 @@ static void c_can_write_msg_object(struc
 }
 
 static inline void c_can_activate_all_lower_rx_msg_obj(struct net_device *dev,
-						int iface,
-						int ctrl_mask)
+						       int iface)
 {
 	int i;
-	struct c_can_priv *priv = netdev_priv(dev);
 
-	for (i = C_CAN_MSG_OBJ_RX_FIRST; i <= C_CAN_MSG_RX_LOW_LAST; i++) {
-		priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface),
-				ctrl_mask & ~IF_MCONT_NEWDAT);
-		c_can_object_put(dev, iface, i, IF_COMM_CONTROL);
-	}
+	for (i = C_CAN_MSG_OBJ_RX_FIRST; i <= C_CAN_MSG_RX_LOW_LAST; i++)
+		c_can_object_get(dev, iface, i, IF_COMM_CLR_NEWDAT);
 }
 
 static int c_can_handle_lost_msg_obj(struct net_device *dev,
@@ -829,7 +825,7 @@ static int c_can_read_objects(struct net
 
 		if (obj == C_CAN_MSG_RX_LOW_LAST)
 			/* activate all lower message objects */
-			c_can_activate_all_lower_rx_msg_obj(dev, IF_RX, ctrl);
+			c_can_activate_all_lower_rx_msg_obj(dev, IF_RX);
 
 		pkts++;
 		quota--;


