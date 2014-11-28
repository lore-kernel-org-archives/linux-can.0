From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [PATCH v4 3/6] can: mscan: Consolidate and unify state change
 handling.
Date: Fri, 28 Nov 2014 12:12:26 +0000
Message-ID: <7cbe55dc-c00a-462a-9022-e7478771b1e3@GRBSR0089.marel.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0064.outbound.protection.outlook.com ([157.55.234.64]:35281
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751046AbaK1MMg (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 28 Nov 2014 07:12:36 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, wg@grandegger.com

Replacing error state change handling with the new mechanism.

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
---
Changes made since last proposal:
can: mscan: adapt to newer can_change_state

 drivers/net/can/mscan/mscan.c | 48 +++++++++++++------------------------------
 1 file changed, 14 insertions(+), 34 deletions(-)

diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index e0c9be5..e36b740 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -289,18 +289,15 @@ static netdev_tx_t mscan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-/* This function returns the old state to see where we came from */
-static enum can_state check_set_state(struct net_device *dev, u8 canrflg)
+static enum can_state get_new_state(struct net_device *dev, u8 canrflg)
 {
 	struct mscan_priv *priv = netdev_priv(dev);
-	enum can_state state, old_state = priv->can.state;
 
-	if (canrflg & MSCAN_CSCIF && old_state <= CAN_STATE_BUS_OFF) {
-		state = state_map[max(MSCAN_STATE_RX(canrflg),
-				      MSCAN_STATE_TX(canrflg))];
-		priv->can.state = state;
-	}
-	return old_state;
+	if (unlikely(canrflg & MSCAN_CSCIF))
+		return state_map[max(MSCAN_STATE_RX(canrflg),
+				 MSCAN_STATE_TX(canrflg))];
+
+	return priv->can.state;
 }
 
 static void mscan_get_rx_frame(struct net_device *dev, struct can_frame *frame)
@@ -349,7 +346,7 @@ static void mscan_get_err_frame(struct net_device *dev, struct can_frame *frame,
 	struct mscan_priv *priv = netdev_priv(dev);
 	struct mscan_regs __iomem *regs = priv->reg_base;
 	struct net_device_stats *stats = &dev->stats;
-	enum can_state old_state;
+	enum can_state new_state;
 
 	netdev_dbg(dev, "error interrupt (canrflg=%#x)\n", canrflg);
 	frame->can_id = CAN_ERR_FLAG;
@@ -363,27 +360,13 @@ static void mscan_get_err_frame(struct net_device *dev, struct can_frame *frame,
 		frame->data[1] = 0;
 	}
 
-	old_state = check_set_state(dev, canrflg);
-	/* State changed */
-	if (old_state != priv->can.state) {
-		switch (priv->can.state) {
-		case CAN_STATE_ERROR_WARNING:
-			frame->can_id |= CAN_ERR_CRTL;
-			priv->can.can_stats.error_warning++;
-			if ((priv->shadow_statflg & MSCAN_RSTAT_MSK) <
-			    (canrflg & MSCAN_RSTAT_MSK))
-				frame->data[1] |= CAN_ERR_CRTL_RX_WARNING;
-			if ((priv->shadow_statflg & MSCAN_TSTAT_MSK) <
-			    (canrflg & MSCAN_TSTAT_MSK))
-				frame->data[1] |= CAN_ERR_CRTL_TX_WARNING;
-			break;
-		case CAN_STATE_ERROR_PASSIVE:
-			frame->can_id |= CAN_ERR_CRTL;
-			priv->can.can_stats.error_passive++;
-			frame->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
-			break;
-		case CAN_STATE_BUS_OFF:
-			frame->can_id |= CAN_ERR_BUSOFF;
+	new_state = get_new_state(dev, canrflg);
+	if (new_state != priv->can.state) {
+		can_change_state(dev, frame,
+				 state_map[MSCAN_STATE_TX(canrflg)],
+				 state_map[MSCAN_STATE_RX(canrflg)]);
+
+		if (priv->can.state == CAN_STATE_BUS_OFF) {
 			/*
 			 * The MSCAN on the MPC5200 does recover from bus-off
 			 * automatically. To avoid that we stop the chip doing
@@ -396,9 +379,6 @@ static void mscan_get_err_frame(struct net_device *dev, struct can_frame *frame,
 					 MSCAN_SLPRQ | MSCAN_INITRQ);
 			}
 			can_bus_off(dev);
-			break;
-		default:
-			break;
 		}
 	}
 	priv->shadow_statflg = canrflg & MSCAN_STAT_MSK;
-- 
1.9.1

