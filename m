From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC PATCH 07/14] can: flexcan: consolidate error state handling
Date: Wed,  7 Dec 2011 15:55:21 +0100
Message-ID: <1323269728-17491-8-git-send-email-wg@grandegger.com>
References: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:49267 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756560Ab1LGOzk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Dec 2011 09:55:40 -0500
In-Reply-To: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan-users@lists.berlios.de, Wolfgang Grandegger <wg@grandegger.com>

Allow state to decrease bus-off->passive->warning->active.
Use the common function can_chage_state().

Here is an example output of "candump -candump -td -e any,0:0,#FFFFFFFF"
for a recovery from error passive state due to no ack/cable (reconnect
after 5s) for a Flexcan controller on the i.MX28 SOC:

 (000.202225)  can0   07  [8] 07 B4 4F 67 3A 90 D9 E4
 (000.200425)  can0  200002AC  [8] 00 08 00 19 00 00 65 00   ERRORFRAME
        controller-problem{tx-error-warning}
        protocol-violation{{}{acknowledge-slot}}
        no-acknowledgement-on-tx
        bus-error
        state-change{tx-error-warning}
        error-counter-tx-rx{{101}{0}}
 (004.869425)  can0  200002AC  [8] 00 20 00 19 00 00 84 00   ERRORFRAME
        controller-problem{tx-error-passive}
        protocol-violation{{}{acknowledge-slot}}
        no-acknowledgement-on-tx
        bus-error
        state-change{tx-error-passive}
        error-counter-tx-rx{{132}{0}}
 (000.000156)  can0    8  [2] C7 6A
 ...
 (000.000187)  can0  20000200  [8] 00 08 00 00 00 00 7F 00   ERRORFRAME
        state-change{tx-error-warning}
        error-counter-tx-rx{{127}{0}}
 (000.000032)  can0    D  [2] 66 5B
 ...
 (000.200487)  can0   3A  [8] CA BC FF 2C C3 C2 1C 63
 (000.200458)  can0  20000200  [8] 00 40 00 00 00 00 5F 00   ERRORFRAME
        state-change{back-to-error-active}
        error-counter-tx-rx{{95}{0}}
 (000.000125)  can0   3B  [8] 6D 40 BC 19 EA 35 0C 58

The state machine of the Flexcan is somehow buggy. The state change to
error passive is not reported in time but when message sending
restarted.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/flexcan.c |   86 ++++++--------------------------------------
 1 files changed, 12 insertions(+), 74 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 095b74b..73e0597 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -354,72 +354,6 @@ static void do_bus_err(struct net_device *dev,
 		dev->stats.tx_errors++;
 }
 
-static void do_state(struct net_device *dev,
-		     struct can_frame *cf, enum can_state new_state)
-{
-	struct flexcan_priv *priv = netdev_priv(dev);
-	struct can_berr_counter bec;
-
-	flexcan_get_berr_counter(dev, &bec);
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
 static int flexcan_poll_error_state(struct net_device *dev, u32 reg_esr)
 {
 	struct flexcan_priv *priv = netdev_priv(dev);
@@ -431,14 +365,19 @@ static int flexcan_poll_error_state(struct net_device *dev, u32 reg_esr)
 	flt = reg_esr & FLEXCAN_ESR_FLT_CONF_MASK;
 	if (likely(flt == FLEXCAN_ESR_FLT_CONF_ACTIVE)) {
 		if (likely(!(reg_esr & (FLEXCAN_ESR_TX_WRN |
-					FLEXCAN_ESR_RX_WRN))))
+					FLEXCAN_ESR_RX_WRN)))) {
 			new_state = CAN_STATE_ERROR_ACTIVE;
-		else
+			if (priv->can.state == CAN_STATE_BUS_OFF)
+				netif_start_queue(dev);
+		} else {
 			new_state = CAN_STATE_ERROR_WARNING;
-	} else if (unlikely(flt == FLEXCAN_ESR_FLT_CONF_PASSIVE))
+		}
+	} else if (unlikely(flt == FLEXCAN_ESR_FLT_CONF_PASSIVE)) {
 		new_state = CAN_STATE_ERROR_PASSIVE;
-	else
+	} else {
 		new_state = CAN_STATE_BUS_OFF;
+		can_bus_off(dev);
+	}
 
 	/* has state changed or are there bus errros? */
 	if (likely(new_state == priv->can.state &&
@@ -449,10 +388,8 @@ static int flexcan_poll_error_state(struct net_device *dev, u32 reg_esr)
 	if (unlikely(!skb))
 		return 0;
 
-	if (new_state != priv->can.state) {
-		do_state(dev, cf, new_state);
-		priv->can.state = new_state;
-	}
+	if (new_state != priv->can.state)
+		can_change_state(dev, cf, new_state, CAN_ERR_DIR_UNKNOWN);
 
 	if (reg_esr & FLEXCAN_ESR_ERR_BUS)
 		do_bus_err(dev, cf, reg_esr);
@@ -839,6 +776,7 @@ static int flexcan_set_mode(struct net_device *dev, enum can_mode mode)
 			return err;
 
 		netif_wake_queue(dev);
+
 		break;
 
 	default:
-- 
1.7.4.1

