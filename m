From: Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: [PATCH v2] can: xilinx_can: use can_change_state()
Date: Tue, 30 Jan 2018 16:35:45 +0200
Message-ID: <20180130143545.1340-1-anssi.hannula@bitwise.fi>
References: <c5e876f1-47e0-c086-53d1-51c3fe1453d1@bitwise.fi>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.bitwise.fi ([109.204.228.163]:38776 "EHLO mail.bitwise.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752999AbeA3Ogy (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 30 Jan 2018 09:36:54 -0500
In-Reply-To: <c5e876f1-47e0-c086-53d1-51c3fe1453d1@bitwise.fi>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>

Replace some custom code with a call to can_change_state().

This subtly changes the error reporting behavior when both RX and TX
error counters indicate the same state.

Previously, if both RX and TX counters indicated the same state:
- if overall state is PASSIVE, report CAN_ERR_CRTL_RX_PASSIVE
- if overall state is WARNING, report CAN_ERR_CRTL_TX_WARNING or
  CAN_ERR_CRTL_RX_WARNING depending on which counter is higher,
  or CAN_ERR_CRTL_RX_WARNING if the counters have the same value.

After this commit:
- report RX_* or TX_* depending on which counter is higher, or both if
  the counters have exactly the same value.

This behavior is consistent with many other CAN drivers that use this
same code pattern.

Tested with the integrated CAN on Zynq-7000 SoC.

v2: Simplify resolving states as suggested by Andri Yngvason.

Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
---

Here's the simplified version of the patch, again on top of the previous
patchset.


 drivers/net/can/xilinx_can.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 26754e9..3348003 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -594,39 +594,19 @@ static void xcan_set_error_state(struct net_device *ndev,
 	u32 ecr = priv->read_reg(priv, XCAN_ECR_OFFSET);
 	u32 txerr = ecr & XCAN_ECR_TEC_MASK;
 	u32 rxerr = (ecr & XCAN_ECR_REC_MASK) >> XCAN_ESR_REC_SHIFT;
+	enum can_state tx_state = txerr >= rxerr ? new_state : 0;
+	enum can_state rx_state = txerr <= rxerr ? new_state : 0;
 
-	priv->can.state = new_state;
+	/* non-ERROR states are handled elsewhere */
+	if (WARN_ON(new_state > CAN_STATE_ERROR_PASSIVE))
+		return;
+
+	can_change_state(ndev, cf, tx_state, rx_state);
 
 	if (cf) {
-		cf->can_id |= CAN_ERR_CRTL;
 		cf->data[6] = txerr;
 		cf->data[7] = rxerr;
 	}
-
-	switch (new_state) {
-	case CAN_STATE_ERROR_PASSIVE:
-		priv->can.can_stats.error_passive++;
-		if (cf)
-			cf->data[1] = (rxerr > 127) ?
-					CAN_ERR_CRTL_RX_PASSIVE :
-					CAN_ERR_CRTL_TX_PASSIVE;
-		break;
-	case CAN_STATE_ERROR_WARNING:
-		priv->can.can_stats.error_warning++;
-		if (cf)
-			cf->data[1] |= (txerr > rxerr) ?
-					CAN_ERR_CRTL_TX_WARNING :
-					CAN_ERR_CRTL_RX_WARNING;
-		break;
-	case CAN_STATE_ERROR_ACTIVE:
-		if (cf)
-			cf->data[1] |= CAN_ERR_CRTL_ACTIVE;
-		break;
-	default:
-		/* non-ERROR states are handled elsewhere */
-		WARN_ON(1);
-		break;
-	}
 }
 
 /**
-- 
2.8.3

