From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 12/21] can: c_can": Work around C_CAN RX wreckage
Date: Fri, 11 Apr 2014 08:13:17 -0000
Message-ID: <20140411080652.540058139@linutronix.de>
References: <20140411080547.845836199@linutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52421 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553AbaDKINE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Apr 2014 04:13:04 -0400
Content-Disposition: inline;
 filename=can-c_can-workaround-c-can-rx-wreckage.patch
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Mark <mark5@del-llc.com>

Alexander reported that the new optimized handling of the RX fifo
causes random packet loss on Intel PCH C_CAN hardware.

After a few fruitless debugging sessions I got hold of a PCH (eg20t)
afflicted system. That machine does not have the CAN interface wired
up, but it was possible to reproduce the issue with the HW loopback
mode.

As Alexander observed correctly, clearing the NewDat flag along with
reading out the message buffer causes that issue on C_CAN, while D_CAN
handles that correctly.

Instead of restoring the original message buffer handling horror the
following workaround solves the issue:

    transfer buffer to IF without clearing the NewDat
    handle the message
    clear NewDat bit

That's similar to the original code but conditional for C_CAN.

I really wonder why all user manuals (C_CAN, Intel PCH and some more)
recommend to clear the NewDat bit right away. The knows it all Oracle
operated by Gurgle does not unearth any useful information either. I
simply cannot believe that we are the first to uncover that HW issue.

Reported-and-tested-by: Alexander Stein <alexander.stein@systec-electronic.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/c_can.c |   13 ++++++++++---
 drivers/net/can/c_can/c_can.h |    1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/c_can.c
+++ linux-2.6/drivers/net/can/c_can/c_can.c
@@ -647,6 +647,10 @@ static int c_can_start(struct net_device
 	if (err)
 		return err;
 
+	/* Setup the command for new messages */
+	priv->comm_rcv_high = priv->type != BOSCH_D_CAN ?
+		IF_COMM_RCV_LOW : IF_COMM_RCV_HIGH;
+
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	/* reset tx helper pointers and the rx mask */
@@ -791,14 +795,15 @@ static u32 c_can_adjust_pending(u32 pend
 	return pend & ~((1 << lasts) - 1);
 }
 
-static inline void c_can_rx_object_get(struct net_device *dev, u32 obj)
+static inline void c_can_rx_object_get(struct net_device *dev,
+				       struct c_can_priv *priv, u32 obj)
 {
 #ifdef CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING
 	if (obj < C_CAN_MSG_RX_LOW_LAST)
 		c_can_object_get(dev, IF_RX, obj, IF_COMM_RCV_LOW);
 	else
 #endif
-		c_can_object_get(dev, IF_RX, obj, IF_COMM_RCV_HIGH);
+		c_can_object_get(dev, IF_RX, obj, priv->comm_rcv_high);
 }
 
 static inline void c_can_rx_finalize(struct net_device *dev,
@@ -813,6 +818,8 @@ static inline void c_can_rx_finalize(str
 		c_can_activate_all_lower_rx_msg_obj(dev, IF_RX);
 	}
 #endif
+	if (priv->type != BOSCH_D_CAN)
+		c_can_object_get(dev, IF_RX, obj, IF_COMM_CLR_NEWDAT);
 }
 
 static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
@@ -823,7 +830,7 @@ static int c_can_read_objects(struct net
 	while ((obj = ffs(pend)) && quota > 0) {
 		pend &= ~BIT(obj - 1);
 
-		c_can_rx_object_get(dev, obj);
+		c_can_rx_object_get(dev, priv, obj);
 		ctrl = priv->read_reg(priv, C_CAN_IFACE(MSGCTRL_REG, IF_RX));
 
 		if (ctrl & IF_MCONT_MSGLST) {
Index: linux-2.6/drivers/net/can/c_can/c_can.h
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/c_can.h
+++ linux-2.6/drivers/net/can/c_can/c_can.h
@@ -198,6 +198,7 @@ struct c_can_priv {
 	u32 __iomem *raminit_ctrlreg;
 	unsigned int instance;
 	void (*raminit) (const struct c_can_priv *priv, bool enable);
+	u32 comm_rcv_high;
 	u32 rxmasked;
 	u32 dlc[C_CAN_MSG_OBJ_TX_NUM];
 };


