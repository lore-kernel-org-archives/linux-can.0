From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 05/21] can: c_can: Handle state change correctly
Date: Fri, 11 Apr 2014 08:13:12 -0000
Message-ID: <20140411080651.189897920@linutronix.de>
References: <20140411080547.845836199@linutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52371 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755541AbaDKIM7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Apr 2014 04:12:59 -0400
Content-Disposition: inline; filename=can-c_can-fix-state-change.patch
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Mark <mark5@del-llc.com>

If the allocation of an error skb fails, the state change handling
returns w/o doing any work. That leaves the interface in a wreckaged
state as the internal status is wrong.

Split the interface handling and the skb handling.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/c_can.c |   25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/c_can.c
+++ linux-2.6/drivers/net/can/c_can/c_can.c
@@ -914,6 +914,26 @@ static int c_can_handle_state_change(str
 	struct sk_buff *skb;
 	struct can_berr_counter bec;
 
+	switch (error_type) {
+	case C_CAN_ERROR_WARNING:
+		/* error warning state */
+		priv->can.can_stats.error_warning++;
+		priv->can.state = CAN_STATE_ERROR_WARNING;
+		break;
+	case C_CAN_ERROR_PASSIVE:
+		/* error passive state */
+		priv->can.can_stats.error_passive++;
+		priv->can.state = CAN_STATE_ERROR_PASSIVE;
+		break;
+	case C_CAN_BUS_OFF:
+		/* bus-off state */
+		priv->can.state = CAN_STATE_BUS_OFF;
+		can_bus_off(dev);
+		break;
+	default:
+		break;
+	}
+
 	/* propagate the error condition to the CAN stack */
 	skb = alloc_can_err_skb(dev, &cf);
 	if (unlikely(!skb))
@@ -927,8 +947,6 @@ static int c_can_handle_state_change(str
 	switch (error_type) {
 	case C_CAN_ERROR_WARNING:
 		/* error warning state */
-		priv->can.can_stats.error_warning++;
-		priv->can.state = CAN_STATE_ERROR_WARNING;
 		cf->can_id |= CAN_ERR_CRTL;
 		cf->data[1] = (bec.txerr > bec.rxerr) ?
 			CAN_ERR_CRTL_TX_WARNING :
@@ -939,8 +957,6 @@ static int c_can_handle_state_change(str
 		break;
 	case C_CAN_ERROR_PASSIVE:
 		/* error passive state */
-		priv->can.can_stats.error_passive++;
-		priv->can.state = CAN_STATE_ERROR_PASSIVE;
 		cf->can_id |= CAN_ERR_CRTL;
 		if (rx_err_passive)
 			cf->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
@@ -952,7 +968,6 @@ static int c_can_handle_state_change(str
 		break;
 	case C_CAN_BUS_OFF:
 		/* bus-off state */
-		priv->can.state = CAN_STATE_BUS_OFF;
 		cf->can_id |= CAN_ERR_BUSOFF;
 		can_bus_off(dev);
 		break;


