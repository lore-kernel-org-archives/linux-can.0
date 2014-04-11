From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 17/21] can: c_can: Cleanup c_can_msg_obj_put/get()
Date: Fri, 11 Apr 2014 08:13:20 -0000
Message-ID: <20140411080653.492947278@linutronix.de>
References: <20140411080547.845836199@linutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52463 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755541AbaDKINH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Apr 2014 04:13:07 -0400
Content-Disposition: inline; filename=can-c_can-cleanup-msg-obj-put-get.patch
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Mark <mark5@del-llc.com>

Sigh!

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/c_can.c |   60 +++++++++++-------------------------------
 1 file changed, 16 insertions(+), 44 deletions(-)

Index: linux-2.6/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/c_can.c
+++ linux-2.6/drivers/net/can/c_can/c_can.c
@@ -261,61 +261,33 @@ static void c_can_irq_control(struct c_c
 	priv->write_reg(priv, C_CAN_CTRL_REG, ctrl);
 }
 
-static inline int c_can_msg_obj_is_busy(struct c_can_priv *priv, int iface)
+static void c_can_obj_update(struct net_device *dev, int iface, u32 cmd, u32 obj)
 {
-	int count = MIN_TIMEOUT_VALUE;
+	struct c_can_priv *priv = netdev_priv(dev);
+	int cnt, reg = C_CAN_IFACE(COMREQ_REG, iface);
+
+	priv->write_reg(priv, reg + 1, cmd);
+	priv->write_reg(priv, reg, obj);
 
-	while (count && priv->read_reg(priv,
-				C_CAN_IFACE(COMREQ_REG, iface)) &
-				IF_COMR_BUSY) {
-		count--;
+	for (cnt = MIN_TIMEOUT_VALUE; cnt; cnt--) {
+		if (!(priv->read_reg(priv, reg) & IF_COMR_BUSY))
+			return;
 		udelay(1);
 	}
+	netdev_err(dev, "Updating object timed out\n");
 
-	if (!count)
-		return 1;
-
-	return 0;
 }
 
-static inline void c_can_object_get(struct net_device *dev,
-					int iface, int objno, int mask)
+static inline void c_can_object_get(struct net_device *dev, int iface,
+				    u32 obj, u32 cmd)
 {
-	struct c_can_priv *priv = netdev_priv(dev);
-
-	/*
-	 * As per specs, after writting the message object number in the
-	 * IF command request register the transfer b/w interface
-	 * register and message RAM must be complete in 6 CAN-CLK
-	 * period.
-	 */
-	priv->write_reg(priv, C_CAN_IFACE(COMMSK_REG, iface),
-			IFX_WRITE_LOW_16BIT(mask));
-	priv->write_reg(priv, C_CAN_IFACE(COMREQ_REG, iface),
-			IFX_WRITE_LOW_16BIT(objno));
-
-	if (c_can_msg_obj_is_busy(priv, iface))
-		netdev_err(dev, "timed out in object get\n");
+	c_can_obj_update(dev, iface, cmd, obj);
 }
 
-static inline void c_can_object_put(struct net_device *dev,
-					int iface, int objno, int mask)
+static inline void c_can_object_put(struct net_device *dev, int iface,
+				    u32 obj, u32 cmd)
 {
-	struct c_can_priv *priv = netdev_priv(dev);
-
-	/*
-	 * As per specs, after writting the message object number in the
-	 * IF command request register the transfer b/w interface
-	 * register and message RAM must be complete in 6 CAN-CLK
-	 * period.
-	 */
-	priv->write_reg(priv, C_CAN_IFACE(COMMSK_REG, iface),
-			(IF_COMM_WR | IFX_WRITE_LOW_16BIT(mask)));
-	priv->write_reg(priv, C_CAN_IFACE(COMREQ_REG, iface),
-			IFX_WRITE_LOW_16BIT(objno));
-
-	if (c_can_msg_obj_is_busy(priv, iface))
-		netdev_err(dev, "timed out in object put\n");
+	c_can_obj_update(dev, iface, cmd | IF_COMM_WR, obj);
 }
 
 static void c_can_write_msg_object(struct net_device *dev,


