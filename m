From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 08/26] can: c_can: Simplify buffer reenabling
Date: Fri, 25 Apr 2014 00:00:11 +0200
Message-ID: <1398376829-6771-9-git-send-email-mkl@pengutronix.de>
References: <1398376829-6771-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46085 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756206AbaDXWAk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 Apr 2014 18:00:40 -0400
In-Reply-To: <1398376829-6771-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Thomas Gleixner <tglx@linutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

Instead of writing to the message object we can simply clear the
NewDat bit with the get method.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Alexander Stein <alexander.stein@systec-electronic.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 6170e64..2aae073 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
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
@@ -353,17 +354,12 @@ static void c_can_write_msg_object(struct net_device *dev,
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
@@ -829,7 +825,7 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
 
 		if (obj == C_CAN_MSG_RX_LOW_LAST)
 			/* activate all lower message objects */
-			c_can_activate_all_lower_rx_msg_obj(dev, IF_RX, ctrl);
+			c_can_activate_all_lower_rx_msg_obj(dev, IF_RX);
 
 		pkts++;
 		quota--;
-- 
1.9.0.279.gdc9e3eb

