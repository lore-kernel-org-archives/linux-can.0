From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC PATCH 11/14] can: mscan: consolidate error state handling
Date: Wed,  7 Dec 2011 15:55:25 +0100
Message-ID: <1323269728-17491-12-git-send-email-wg@grandegger.com>
References: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:49278 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756568Ab1LGOzm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Dec 2011 09:55:42 -0500
In-Reply-To: <1323269728-17491-1-git-send-email-wg@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan-users@lists.berlios.de, Wolfgang Grandegger <wg@grandegger.com>

Allow state to decrease bus-off->passive->warning->active.
Use the common function can_chage_state().

Here is an example output of "candump -candump -td -e any,0:0,#FFFFFFFF"
for a recovery from error passive state due to no ack/cable (reconnect
after 5s) for a MSCAN on a MPC5200 SOC:

 (000.204135)  can2    6  [8] 25 84 EF 0F 3F 3D B7 3E
 (000.206547)  can2  20000204  [8] 00 08 00 00 00 00 00 00   ERRORFRAME
        controller-problem{tx-error-warning}
        state-change{tx-error-warning}
 (000.000909)  can2  20000204  [8] 00 20 00 00 00 00 00 00   ERRORFRAME
        controller-problem{tx-error-passive}
        state-change{tx-error-passive}
 (004.928785)  can2    7  [7] 4D BA 4C 90 60 BB D6
 (000.000204)  can2  20000200  [8] 00 08 00 00 00 00 00 00   ERRORFRAME
        state-change{tx-error-warning}
 (000.000000)  can2    8  [1] 6F
 (000.000239)  can2    9  [8] 24 CD C3 9A 62 16 37 30
 ...
 (000.204000)  can2   33  [8] 58 DC 54 02 4D CF 61 BF
 (000.000152)  can2  20000200  [8] 00 40 00 00 00 00 00 00   ERRORFRAME
        state-change{back-to-error-active}
 (000.203725)  can2   34  [0]
 (000.204074)  can2   35  [5] 71 E9 59 E5 2E

And for a MSCAN on a MPC5121 SOC:

 (000.203997)  can0    6  [8] 0F 21 AA BD 6C F5 2F 43
 (000.206737)  can0  20000204  [8] 00 08 00 00 00 00 60 00   ERRORFRAME
        controller-problem{tx-error-warning}
        state-change{tx-error-warning}
        error-counter-tx-rx{{96}{0}}
 (000.000962)  can0  20000204  [8] 00 20 00 00 00 00 80 00   ERRORFRAME
        controller-problem{tx-error-passive}
        state-change{tx-error-passive}
        error-counter-tx-rx{{128}{0}}
 (004.929359)  can0    7  [8] 64 7E BF 12 15 4A 22 E4
 (000.000117)  can0  20000200  [8] 00 08 00 00 00 00 7F 00   ERRORFRAME
        state-change{tx-error-warning}
        error-counter-tx-rx{{127}{0}}
 (000.000163)  can0    8  [1] 1C
 ...
 (000.204030)  can0   35  [8] 2D 8F 0E CA 26 4D 0D 37
 (000.000123)  can0  20000200  [8] 00 40 00 00 00 00 5F 00   ERRORFRAME
        state-change{back-to-error-active}
        error-counter-tx-rx{{95}{0}}
 (000.203879)  can0   36  [8] 6F C9 05 BA 73 9A A5 E2

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/mscan/mscan.c |   89 ++++++++++++++++-------------------------
 1 files changed, 34 insertions(+), 55 deletions(-)

diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index 41a2a2d..e9e6b14 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -290,20 +290,6 @@ static netdev_tx_t mscan_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-/* This function returns the old state to see where we came from */
-static enum can_state check_set_state(struct net_device *dev, u8 canrflg)
-{
-	struct mscan_priv *priv = netdev_priv(dev);
-	enum can_state state, old_state = priv->can.state;
-
-	if (canrflg & MSCAN_CSCIF && old_state <= CAN_STATE_BUS_OFF) {
-		state = state_map[max(MSCAN_STATE_RX(canrflg),
-				      MSCAN_STATE_TX(canrflg))];
-		priv->can.state = state;
-	}
-	return old_state;
-}
-
 static void mscan_get_rx_frame(struct net_device *dev, struct can_frame *frame)
 {
 	struct mscan_priv *priv = netdev_priv(dev);
@@ -350,60 +336,50 @@ static void mscan_get_err_frame(struct net_device *dev, struct can_frame *frame,
 	struct mscan_priv *priv = netdev_priv(dev);
 	struct mscan_regs __iomem *regs = priv->reg_base;
 	struct net_device_stats *stats = &dev->stats;
-	enum can_state old_state;
 
 	netdev_dbg(dev, "error interrupt (canrflg=%#x)\n", canrflg);
-	frame->can_id = CAN_ERR_FLAG;
 
 	if (canrflg & MSCAN_OVRIF) {
 		frame->can_id |= CAN_ERR_CRTL;
-		frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+		frame->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
 		stats->rx_over_errors++;
 		stats->rx_errors++;
 	} else {
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
+	if (canrflg & MSCAN_CSCIF) {
+		enum can_state state = state_map[max(MSCAN_STATE_RX(canrflg),
+						     MSCAN_STATE_TX(canrflg))];
+		unsigned int err_dir = CAN_ERR_DIR_UNKNOWN;
+
+		if (state != priv->can.state) {
+
+			if ((priv->shadow_statflg & MSCAN_TSTAT_MSK) !=
 			    (canrflg & MSCAN_TSTAT_MSK))
-				frame->data[1] |= CAN_ERR_CRTL_TX_WARNING;
-			break;
-		case CAN_STATE_ERROR_PASSIVE:
-			frame->can_id |= CAN_ERR_CRTL;
-			priv->can.can_stats.error_passive++;
-			frame->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
-			break;
-		case CAN_STATE_BUS_OFF:
-			frame->can_id |= CAN_ERR_BUSOFF;
-			/*
-			 * The MSCAN on the MPC5200 does recover from bus-off
-			 * automatically. To avoid that we stop the chip doing
-			 * a light-weight stop (we are in irq-context).
-			 */
-			if (priv->type != MSCAN_TYPE_MPC5121) {
-				out_8(&regs->cantier, 0);
-				out_8(&regs->canrier, 0);
-				setbits8(&regs->canctl0,
-					 MSCAN_SLPRQ | MSCAN_INITRQ);
+				err_dir |= CAN_ERR_DIR_TX;
+			if ((priv->shadow_statflg & MSCAN_RSTAT_MSK) !=
+			    (canrflg & MSCAN_RSTAT_MSK))
+				err_dir |= CAN_ERR_DIR_RX;
+			if (state == CAN_STATE_BUS_OFF) {
+				/*
+				 * The MSCAN on the MPC5200 does recover from
+				 * bus-off automatically. To avoid that we
+				 * stop the chip doing a light-weight stop
+				 * (we  are in irq-context).
+				 */
+				if (priv->type != MSCAN_TYPE_MPC5121) {
+					out_8(&regs->cantier, 0);
+					out_8(&regs->canrier, 0);
+					setbits8(&regs->canctl0,
+						 MSCAN_SLPRQ | MSCAN_INITRQ);
+				}
+				can_bus_off(dev);
 			}
-			can_bus_off(dev);
-			break;
-		default:
-			break;
+			can_change_state(dev, frame, state, err_dir);
 		}
+		priv->shadow_statflg = canrflg & MSCAN_STAT_MSK;
 	}
-	priv->shadow_statflg = canrflg & MSCAN_STAT_MSK;
-	frame->can_dlc = CAN_ERR_DLC;
 	out_8(&regs->canrflg, MSCAN_ERR_IF);
 }
 
@@ -424,7 +400,10 @@ static int mscan_rx_poll(struct napi_struct *napi, int quota)
 		if (!(canrflg & (MSCAN_RXF | MSCAN_ERR_IF)))
 			break;
 
-		skb = alloc_can_skb(dev, &frame);
+		if (canrflg & MSCAN_RXF)
+			skb = alloc_can_skb(dev, &frame);
+		else /* MSCAN_ERR_IF */
+			skb = alloc_can_err_skb(dev, &frame);
 		if (!skb) {
 			if (printk_ratelimit())
 				netdev_notice(dev, "packet dropped\n");
@@ -435,7 +414,7 @@ static int mscan_rx_poll(struct napi_struct *napi, int quota)
 
 		if (canrflg & MSCAN_RXF)
 			mscan_get_rx_frame(dev, frame);
-		else if (canrflg & MSCAN_ERR_IF)
+		else /* MSCAN_ERR_IF */
 			mscan_get_err_frame(dev, frame, canrflg);
 
 		stats->rx_packets++;
-- 
1.7.4.1

