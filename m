From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [PATCH v4 4/6] can: flexcan: Consolidate and unify state change
 handling.
Date: Fri, 28 Nov 2014 12:12:27 +0000
Message-ID: <3103cd54-1421-4594-855f-7bfca8f4ef49@GRBSR0089.marel.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-am1on0054.outbound.protection.outlook.com ([157.56.112.54]:5856
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751046AbaK1MMi (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 28 Nov 2014 07:12:38 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, wg@grandegger.com

Replacing error state change handling with the new mechanism.

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
---
Changes made since last proposal:
can: flexcan: add FLEXCAN_HAS_BROKEN_ERR_STATE for i.MX6
can: flexcan: adapt to newer can_change_state

 drivers/net/can/flexcan.c | 103 +++++++++-------------------------------------
 1 file changed, 19 insertions(+), 84 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 60f86bd..9f91735 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -266,7 +266,7 @@ static struct flexcan_devtype_data fsl_p1010_devtype_data = {
 };
 static struct flexcan_devtype_data fsl_imx28_devtype_data;
 static struct flexcan_devtype_data fsl_imx6q_devtype_data = {
-	.features = FLEXCAN_HAS_V10_FEATURES,
+	.features = FLEXCAN_HAS_V10_FEATURES | FLEXCAN_HAS_BROKEN_ERR_STATE,
 };
 static struct flexcan_devtype_data fsl_vf610_devtype_data = {
 	.features = FLEXCAN_HAS_V10_FEATURES | FLEXCAN_HAS_MECR_FEATURES,
@@ -577,98 +577,30 @@ static int flexcan_poll_bus_err(struct net_device *dev, u32 reg_esr)
 	return 1;
 }
 
-static void do_state(struct net_device *dev,
-		     struct can_frame *cf, enum can_state new_state)
-{
-	struct flexcan_priv *priv = netdev_priv(dev);
-	struct can_berr_counter bec;
-
-	__flexcan_get_berr_counter(dev, &bec);
-
-	switch (priv->can.state) {
-	case CAN_STATE_ERROR_ACTIVE:
-		/*
-		 * from: ERROR_ACTIVE
-		 * to  : ERROR_WARNING, ERROR_PASSIVE, BUS_OFF
-		 * =>  : there was a warning int
-		 */
-		if (new_state >= CAN_STATE_ERROR_WARNING &&
-		    new_state <= CAN_STATE_BUS_OFF) {
-			netdev_dbg(dev, "Error Warning IRQ\n");
-			priv->can.can_stats.error_warning++;
-
-			cf->can_id |= CAN_ERR_CRTL;
-			cf->data[1] = (bec.txerr > bec.rxerr) ?
-				CAN_ERR_CRTL_TX_WARNING :
-				CAN_ERR_CRTL_RX_WARNING;
-		}
-	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
-		/*
-		 * from: ERROR_ACTIVE, ERROR_WARNING
-		 * to  : ERROR_PASSIVE, BUS_OFF
-		 * =>  : error passive int
-		 */
-		if (new_state >= CAN_STATE_ERROR_PASSIVE &&
-		    new_state <= CAN_STATE_BUS_OFF) {
-			netdev_dbg(dev, "Error Passive IRQ\n");
-			priv->can.can_stats.error_passive++;
-
-			cf->can_id |= CAN_ERR_CRTL;
-			cf->data[1] = (bec.txerr > bec.rxerr) ?
-				CAN_ERR_CRTL_TX_PASSIVE :
-				CAN_ERR_CRTL_RX_PASSIVE;
-		}
-		break;
-	case CAN_STATE_BUS_OFF:
-		netdev_err(dev, "BUG! "
-			   "hardware recovered automatically from BUS_OFF\n");
-		break;
-	default:
-		break;
-	}
-
-	/* process state changes depending on the new state */
-	switch (new_state) {
-	case CAN_STATE_ERROR_WARNING:
-		netdev_dbg(dev, "Error Warning\n");
-		cf->can_id |= CAN_ERR_CRTL;
-		cf->data[1] = (bec.txerr > bec.rxerr) ?
-			CAN_ERR_CRTL_TX_WARNING :
-			CAN_ERR_CRTL_RX_WARNING;
-		break;
-	case CAN_STATE_ERROR_ACTIVE:
-		netdev_dbg(dev, "Error Active\n");
-		cf->can_id |= CAN_ERR_PROT;
-		cf->data[2] = CAN_ERR_PROT_ACTIVE;
-		break;
-	case CAN_STATE_BUS_OFF:
-		cf->can_id |= CAN_ERR_BUSOFF;
-		can_bus_off(dev);
-		break;
-	default:
-		break;
-	}
-}
-
 static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct sk_buff *skb;
 	struct can_frame *cf;
-	enum can_state new_state;
+	enum can_state new_state = 0, rx_state = 0, tx_state = 0;
 	int flt;
+	struct can_berr_counter bec;
 
 	flt = reg_esr & FLEXCAN_ESR_FLT_CONF_MASK;
 	if (likely(flt == FLEXCAN_ESR_FLT_CONF_ACTIVE)) {
-		if (likely(!(reg_esr & (FLEXCAN_ESR_TX_WRN |
-					FLEXCAN_ESR_RX_WRN))))
-			new_state = CAN_STATE_ERROR_ACTIVE;
-		else
-			new_state = CAN_STATE_ERROR_WARNING;
-	} else if (unlikely(flt == FLEXCAN_ESR_FLT_CONF_PASSIVE))
+		tx_state = unlikely(reg_esr & FLEXCAN_ESR_TX_WRN) ?
+			   CAN_STATE_ERROR_WARNING : CAN_STATE_ERROR_ACTIVE;
+		rx_state = unlikely(reg_esr & FLEXCAN_ESR_RX_WRN) ?
+			   CAN_STATE_ERROR_WARNING : CAN_STATE_ERROR_ACTIVE;
+		new_state = max(tx_state, rx_state);
+	} else if (unlikely(flt == FLEXCAN_ESR_FLT_CONF_PASSIVE)) {
+		__flexcan_get_berr_counter(dev, &bec);
 		new_state = CAN_STATE_ERROR_PASSIVE;
-	else
+		rx_state = bec.rxerr >= bec.txerr ? new_state : 0;
+		tx_state = bec.rxerr <= bec.txerr ? new_state : 0;
+	} else {
 		new_state = CAN_STATE_BUS_OFF;
+	}
 
 	/* state hasn't changed */
 	if (likely(new_state == priv->can.state))
@@ -678,8 +610,11 @@ static int flexcan_poll_state(struct net_device *dev, u32 reg_esr)
 	if (unlikely(!skb))
 		return 0;
 
-	do_state(dev, cf, new_state);
-	priv->can.state = new_state;
+	can_change_state(dev, cf, tx_state, rx_state);
+
+	if (unlikely(new_state == CAN_STATE_BUS_OFF))
+		can_bus_off(dev);
+
 	netif_receive_skb(skb);
 
 	dev->stats.rx_packets++;
-- 
1.9.1

