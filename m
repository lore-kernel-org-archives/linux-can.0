From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 14/21] can: c_can: Cleanup c_can_read_msg_object()
Date: Fri, 11 Apr 2014 08:13:18 -0000
Message-ID: <20140411080652.928280660@linutronix.de>
References: <20140411080547.845836199@linutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52438 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755539AbaDKINF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Apr 2014 04:13:05 -0400
Content-Disposition: inline; filename=can-c_can-cleanup-rcv-path.patch
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Mark <mark5@del-llc.com>

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/c_can.c |   32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

Index: linux-2.6/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/c_can.c
+++ linux-2.6/drivers/net/can/c_can/c_can.c
@@ -380,15 +380,13 @@ static int c_can_handle_lost_msg_obj(str
 	return 1;
 }
 
-static int c_can_read_msg_object(struct net_device *dev, int iface, int ctrl)
+static int c_can_read_msg_object(struct net_device *dev, int iface, u32 ctrl)
 {
-	u16 flags, data;
-	int i;
-	unsigned int val;
-	struct c_can_priv *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
-	struct sk_buff *skb;
+	struct c_can_priv *priv = netdev_priv(dev);
 	struct can_frame *frame;
+	struct sk_buff *skb;
+	u32 arb, data;
 
 	skb = alloc_can_skb(dev, &frame);
 	if (!skb) {
@@ -398,21 +396,21 @@ static int c_can_read_msg_object(struct
 
 	frame->can_dlc = get_can_dlc(ctrl & 0x0F);
 
-	flags =	priv->read_reg(priv, C_CAN_IFACE(ARB2_REG, iface));
-	val = priv->read_reg(priv, C_CAN_IFACE(ARB1_REG, iface)) |
-		(flags << 16);
+	arb = priv->read_reg(priv, C_CAN_IFACE(ARB1_REG, iface));
+	arb |= priv->read_reg(priv, C_CAN_IFACE(ARB2_REG, iface)) << 16;
 
-	if (flags & IF_ARB_MSGXTD)
-		frame->can_id = (val & CAN_EFF_MASK) | CAN_EFF_FLAG;
+	if (arb & (IF_ARB_MSGXTD << 16))
+		frame->can_id = (arb & CAN_EFF_MASK) | CAN_EFF_FLAG;
 	else
-		frame->can_id = (val >> 18) & CAN_SFF_MASK;
+		frame->can_id = (arb >> 18) & CAN_SFF_MASK;
 
-	if (flags & IF_ARB_TRANSMIT)
+	if (arb & (IF_ARB_TRANSMIT << 16)) {
 		frame->can_id |= CAN_RTR_FLAG;
-	else {
-		for (i = 0; i < frame->can_dlc; i += 2) {
-			data = priv->read_reg(priv,
-				C_CAN_IFACE(DATA1_REG, iface) + i / 2);
+	} else {
+		int i, dreg = C_CAN_IFACE(DATA1_REG, iface);
+
+		for (i = 0; i < frame->can_dlc; i += 2, dreg ++) {
+			data = priv->read_reg(priv, dreg);
 			frame->data[i] = data;
 			frame->data[i + 1] = data >> 8;
 		}


