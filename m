From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 16/21] can: c_can: Cleanup c_can_inval_msg_object()
Date: Fri, 11 Apr 2014 08:13:19 -0000
Message-ID: <20140411080653.317288696@linutronix.de>
References: <20140411080547.845836199@linutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52456 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755563AbaDKING (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Apr 2014 04:13:06 -0400
Content-Disposition: inline; filename=can-c_can-cleanup-inval-msg.patch
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Mark <mark5@del-llc.com>

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/c_can.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/c_can.c
+++ linux-2.6/drivers/net/can/c_can/c_can.c
@@ -129,6 +129,9 @@
 /* Receive setup of message objects */
 #define IF_COMM_RCV_SETUP	(IF_COMM_MASK | IF_COMM_ARB | IF_COMM_CONTROL)
 
+/* Invalidation of message objects */
+#define IF_COMM_INVAL		(IF_COMM_ARB | IF_COMM_CONTROL)
+
 /* IFx arbitration */
 #define IF_ARB_MSGVAL		BIT(15)
 #define IF_ARB_MSGXTD		BIT(14)
@@ -447,7 +450,7 @@ static void c_can_setup_receive_object(s
 	c_can_object_put(dev, iface, obj, IF_COMM_RCV_SETUP);
 }
 
-static void c_can_inval_msg_object(struct net_device *dev, int iface, int objno)
+static void c_can_inval_msg_object(struct net_device *dev, int iface, int obj)
 {
 	struct c_can_priv *priv = netdev_priv(dev);
 
@@ -455,10 +458,7 @@ static void c_can_inval_msg_object(struc
 	priv->write_reg(priv, C_CAN_IFACE(ARB2_REG, iface), 0);
 	priv->write_reg(priv, C_CAN_IFACE(MSGCTRL_REG, iface), 0);
 
-	c_can_object_put(dev, iface, objno, IF_COMM_ARB | IF_COMM_CONTROL);
-
-	netdev_dbg(dev, "obj no:%d, msgval:0x%08x\n", objno,
-			c_can_read_reg32(priv, C_CAN_MSGVAL1_REG));
+	c_can_object_put(dev, iface, obj, IF_COMM_INVAL);
 }
 
 static inline int c_can_is_next_tx_obj_busy(struct c_can_priv *priv, int objno)


