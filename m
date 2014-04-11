From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 18/21] can: c_can: Cleanup c_can_write_msg_object()
Date: Fri, 11 Apr 2014 08:13:21 -0000
Message-ID: <20140411080653.707858937@linutronix.de>
References: <20140411080547.845836199@linutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52470 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755567AbaDKINI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Apr 2014 04:13:08 -0400
Content-Disposition: inline; filename=can-c_can-cleanup-write-msg-object.patch
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Mark <mark5@del-llc.com>

Remove the MASK from the TX transfer side.

Make the code readable and get rid of the annoying IFX_WRITE_XXX_16BIT
macros which are just obfuscating the code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/c_can.c |   51 ++++++++++++++++++++----------------------
 drivers/net/can/c_can/c_can.h |    8 ------
 2 files changed, 25 insertions(+), 34 deletions(-)

Index: linux-2.6/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/c_can.c
+++ linux-2.6/drivers/net/can/c_can/c_can.c
@@ -113,9 +113,11 @@
 #define IF_COMM_CLR_NEWDAT	IF_COMM_TXRQST
 #define IF_COMM_DATAA		BIT(1)
 #define IF_COMM_DATAB		BIT(0)
-#define IF_COMM_ALL		(IF_COMM_MASK | IF_COMM_ARB | \
-				IF_COMM_CONTROL | IF_COMM_TXRQST | \
-				IF_COMM_DATAA | IF_COMM_DATAB)
+
+/* TX buffer setup */
+#define IF_COMM_TX		(IF_COMM_ARB | IF_COMM_CONTROL | \
+				 IF_COMM_TXRQST |		 \
+				 IF_COMM_DATAA | IF_COMM_DATAB)
 
 /* For the low buffers we clear the interrupt bit, but keep newdat */
 #define IF_COMM_RCV_LOW		(IF_COMM_MASK | IF_COMM_ARB | \
@@ -152,6 +154,8 @@
 #define IF_MCONT_RCV		(IF_MCONT_RXIE | IF_MCONT_UMASK)
 #define IF_MCONT_RCV_EOB	(IF_MCONT_RCV | IF_MCONT_EOB)
 
+#define IF_MCONT_TX		(IF_MCONT_TXIE | IF_MCONT_EOB)
+
 /*
  * Use IF1 for RX and IF2 for TX
  */
@@ -290,40 +294,35 @@ static inline void c_can_object_put(stru
 	c_can_obj_update(dev, iface, cmd | IF_COMM_WR, obj);
 }
 
-static void c_can_write_msg_object(struct net_device *dev,
-			int iface, struct can_frame *frame, int objno)
+static void c_can_write_msg_object(struct net_device *dev, int iface,
+				   struct can_frame *frame, int obj)
 {
-	int i;
-	u16 flags = 0;
-	unsigned int id;
 	struct c_can_priv *priv = netdev_priv(dev);
+	u16 ctrl = IF_MCONT_TX | frame->can_dlc;
+	u32 arb = IF_ARB_MSGVAL << 16;
+	int i;
+
+	if (frame->can_id & CAN_EFF_FLAG) {
+		arb |= frame->can_id & CAN_EFF_MASK;
+		arb |= IF_ARB_MSGXTD << 16;
+	} else {
+		arb |= (frame->can_id & CAN_SFF_MASK) << 18;
+	}
 
 	if (!(frame->can_id & CAN_RTR_FLAG))
-		flags |= IF_ARB_TRANSMIT;
+		arb |= IF_ARB_TRANSMIT << 16;
 
-	if (frame->can_id & CAN_EFF_FLAG) {
-		id = frame->can_id & CAN_EFF_MASK;
-		flags |= IF_ARB_MSGXTD;
-	} else
-		id = ((frame->can_id & CAN_SFF_MASK) << 18);
-
-	flags |= IF_ARB_MSGVAL;
-
-	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface),
-				IFX_WRITE_LOW_16BIT(id));
-	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface), flags |
-				IFX_WRITE_HIGH_16BIT(id));
+	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface), arb);
+	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface), arb >> 16);
+
+	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), ctrl);
 
 	for (i = 0; i < frame->can_dlc; i += 2) {
 		priv->write_reg(priv, C_CAN_IFACE(DATA1_REG, iface) + i / 2,
 				frame->data[i] | (frame->data[i + 1] << 8));
 	}
 
-	/* enable interrupt for this message object */
-	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface),
-			IF_MCONT_TXIE | IF_MCONT_TXRQST | IF_MCONT_EOB |
-			frame->can_dlc);
-	c_can_object_put(dev, iface, objno, IF_COMM_ALL);
+	c_can_object_put(dev, iface, obj, IF_COMM_TX);
 }
 
 static inline void c_can_activate_all_lower_rx_msg_obj(struct net_device *dev,
Index: linux-2.6/drivers/net/can/c_can/c_can.h
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/c_can.h
+++ linux-2.6/drivers/net/can/c_can/c_can.h
@@ -22,14 +22,6 @@
 #ifndef C_CAN_H
 #define C_CAN_H
 
-/*
- * IFx register masks:
- * allow easy operation on 16-bit registers when the
- * argument is 32-bit instead
- */
-#define IFX_WRITE_LOW_16BIT(x)	((x) & 0xFFFF)
-#define IFX_WRITE_HIGH_16BIT(x)	(((x) & 0xFFFF0000) >> 16)
-
 /* message object split */
 #define C_CAN_NO_OF_OBJECTS	32
 #define C_CAN_MSG_OBJ_RX_NUM	16


