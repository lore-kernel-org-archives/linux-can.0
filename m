From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 19/21] can: c_can: Use proper u32 variables in
 c_can_write_msg_object()
Date: Fri, 11 Apr 2014 08:13:21 -0000
Message-ID: <20140411080653.923459107@linutronix.de>
References: <20140411080547.845836199@linutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52476 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576AbaDKINI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Apr 2014 04:13:08 -0400
Content-Disposition: inline;
 filename=can-c-can-use-32bit-mask-and-arb-reg.patch
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Mark <mark5@del-llc.com>

Instead of obfuscating the code by artificial 16 bit splits use the
proper 32 bit assignments and split the result when writing to the
interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/c_can.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

Index: linux-2.6/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/c_can.c
+++ linux-2.6/drivers/net/can/c_can/c_can.c
@@ -135,9 +135,9 @@
 #define IF_COMM_INVAL		(IF_COMM_ARB | IF_COMM_CONTROL)
 
 /* IFx arbitration */
-#define IF_ARB_MSGVAL		BIT(15)
-#define IF_ARB_MSGXTD		BIT(14)
-#define IF_ARB_TRANSMIT		BIT(13)
+#define IF_ARB_MSGVAL		BIT(31)
+#define IF_ARB_MSGXTD		BIT(30)
+#define IF_ARB_TRANSMIT		BIT(29)
 
 /* IFx message control */
 #define IF_MCONT_NEWDAT		BIT(15)
@@ -299,18 +299,18 @@ static void c_can_write_msg_object(struc
 {
 	struct c_can_priv *priv = netdev_priv(dev);
 	u16 ctrl = IF_MCONT_TX | frame->can_dlc;
-	u32 arb = IF_ARB_MSGVAL << 16;
+	u32 arb = IF_ARB_MSGVAL;
 	int i;
 
 	if (frame->can_id & CAN_EFF_FLAG) {
 		arb |= frame->can_id & CAN_EFF_MASK;
-		arb |= IF_ARB_MSGXTD << 16;
+		arb |= IF_ARB_MSGXTD;
 	} else {
 		arb |= (frame->can_id & CAN_SFF_MASK) << 18;
 	}
 
 	if (!(frame->can_id & CAN_RTR_FLAG))
-		arb |= IF_ARB_TRANSMIT << 16;
+		arb |= IF_ARB_TRANSMIT;
 
 	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface), arb);
 	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface), arb >> 16);
@@ -380,12 +380,12 @@ static int c_can_read_msg_object(struct
 	arb = priv->read_reg(priv, C_CAN_IFACE(ARB1_REG, iface));
 	arb |= priv->read_reg(priv, C_CAN_IFACE(ARB2_REG, iface)) << 16;
 
-	if (arb & (IF_ARB_MSGXTD << 16))
+	if (arb & IF_ARB_MSGXTD)
 		frame->can_id = (arb & CAN_EFF_MASK) | CAN_EFF_FLAG;
 	else
 		frame->can_id = (arb >> 18) & CAN_SFF_MASK;
 
-	if (arb & (IF_ARB_TRANSMIT << 16)) {
+	if (arb & IF_ARB_TRANSMIT) {
 		frame->can_id |= CAN_RTR_FLAG;
 	} else {
 		int i, dreg = C_CAN_IFACE(DATA1_REG, iface);
@@ -413,7 +413,7 @@ static void c_can_setup_receive_object(s
 	priv->write_reg(priv, C_CAN_IFACE(MASK1_REG, iface), mask);
 	priv->write_reg(priv, C_CAN_IFACE(MASK2_REG, iface), mask >> 16);
 
-	id |= IF_ARB_MSGVAL << 16;
+	id |= IF_ARB_MSGVAL;
 	priv->write_reg(priv, C_CAN_IFACE(ARB1_REG, iface), id);
 	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface), id >> 16);
 


