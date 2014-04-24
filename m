From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 06/26] can: c_can: Fix berr reporting
Date: Fri, 25 Apr 2014 00:00:09 +0200
Message-ID: <1398376829-6771-7-git-send-email-mkl@pengutronix.de>
References: <1398376829-6771-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46070 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789AbaDXWAi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 Apr 2014 18:00:38 -0400
In-Reply-To: <1398376829-6771-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Thomas Gleixner <tglx@linutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

Reading the LEC type with

  return (mode & ENABLED) && (status & LEC_MASK);

is not guaranteed to return (status & LEC_MASK) if the enabled bit in
mode is set. It's guaranteed to return 0 or !=0.

Remove the inline function and call unconditionally into the
berr_handling code and return early when the reporting is disabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Alexander Stein <alexander.stein@systec-electronic.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 246bcf9..9ef45b0 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -171,6 +171,7 @@ enum c_can_lec_type {
 	LEC_BIT0_ERROR,
 	LEC_CRC_ERROR,
 	LEC_UNUSED,
+	LEC_MASK = LEC_UNUSED,
 };
 
 /*
@@ -897,12 +898,6 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
 	return pkts;
 }
 
-static inline int c_can_has_and_handle_berr(struct c_can_priv *priv)
-{
-	return (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) &&
-		(priv->current_status & LEC_UNUSED);
-}
-
 static int c_can_handle_state_change(struct net_device *dev,
 				enum c_can_bus_error_types error_type)
 {
@@ -998,6 +993,9 @@ static int c_can_handle_bus_err(struct net_device *dev,
 	if (lec_type == LEC_UNUSED || lec_type == LEC_NO_ERROR)
 		return 0;
 
+	if (!(priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
+		return 0;
+
 	/* propagate the error condition to the CAN stack */
 	skb = alloc_can_err_skb(dev, &cf);
 	if (unlikely(!skb))
@@ -1057,7 +1055,6 @@ static int c_can_handle_bus_err(struct net_device *dev,
 static int c_can_poll(struct napi_struct *napi, int quota)
 {
 	u16 irqstatus;
-	int lec_type = 0;
 	int work_done = 0;
 	struct net_device *dev = napi->dev;
 	struct c_can_priv *priv = netdev_priv(dev);
@@ -1116,9 +1113,8 @@ static int c_can_poll(struct napi_struct *napi, int quota)
 		priv->last_status = priv->current_status;
 
 		/* handle lec errors on the bus */
-		lec_type = c_can_has_and_handle_berr(priv);
-		if (lec_type)
-			work_done += c_can_handle_bus_err(dev, lec_type);
+		work_done += c_can_handle_bus_err(dev,
+					priv->current_status & LEC_MASK);
 	} else if ((irqstatus >= C_CAN_MSG_OBJ_RX_FIRST) &&
 			(irqstatus <= C_CAN_MSG_OBJ_RX_LAST)) {
 		/* handle events corresponding to receive message objects */
-- 
1.9.0.279.gdc9e3eb

