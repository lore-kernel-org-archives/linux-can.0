From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH] can: c_can: Fix bit clearing and message object read
Date: Tue,  8 Apr 2014 11:46:22 +0200
Message-ID: <1396950382-13091-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:32829 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756398AbaDHJrj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Apr 2014 05:47:39 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org

It seems that clearing some bits in a message object using COMMSK_REG and
reading this object afterwards using COMREQ_REG is not race free.
It might occur that the read message object still contains the
IF_MCONT_NEWDAT bit set while it was already cleared upon write to
COMMSK_REG. So insert a dummy read to the hardware.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/net/can/c_can/c_can.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 0e9f974..625f8e2 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -290,6 +290,13 @@ static inline void c_can_object_get(struct net_device *dev,
 	 */
 	priv->write_reg(priv, C_CAN_IFACE(COMMSK_REG, iface),
 			IFX_WRITE_LOW_16BIT(mask));
+
+	/*
+	 * Insert additional dummy read to let
+	 * the write to COMMSK_REG take effect
+	 */
+	priv->read_reg(priv, C_CAN_IFACE(COMREQ_REG, iface));
+
 	priv->write_reg(priv, C_CAN_IFACE(COMREQ_REG, iface),
 			IFX_WRITE_LOW_16BIT(objno));
 
@@ -832,12 +839,11 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
 		}
 
 		/*
-		 * This really should not happen, but this covers some
-		 * odd HW behaviour. Do not remove that unless you
-		 * want to brick your machine.
+		 * This really should not happen, but this warns about some
+		 * odd HW behaviour.
 		 */
-		if (!(ctrl & IF_MCONT_NEWDAT))
-			continue;
+		if ((ctrl & IF_MCONT_NEWDAT))
+			netdev_warn(dev, "IF_MCONT_NEWDAT still set on obj: %d", obj);
 
 		/* read the data from the message object */
 		c_can_read_msg_object(dev, IF_RX, ctrl);
-- 
1.8.3.2

