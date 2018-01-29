From: Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: [PATCH] can: xilinx_can: use can_change_state()
Date: Mon, 29 Jan 2018 18:49:53 +0200
Message-ID: <20180129164953.6596-1-anssi.hannula@bitwise.fi>
References: <151722269077.27204.8452699005718607415@maxwell>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.bitwise.fi ([109.204.228.163]:49680 "EHLO mail.bitwise.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751072AbeA2QwJ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 29 Jan 2018 11:52:09 -0500
In-Reply-To: <151722269077.27204.8452699005718607415@maxwell>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>

Replace some custom code with a call to can_change_state().

This subtly changes the error reporting behavior in some cases.

Previously, if both RX and TX error counters indicated the same state,
and the status register agreed:
- if overall state is PASSIVE, report CAN_ERR_CRTL_RX_PASSIVE
- if overall state is WARNING, report CAN_ERR_CRTL_TX_WARNING or
  CAN_ERR_CRTL_RX_WARNING depending on which counter is higher.

Previously, if status registers indicated a different state than the
worst state indicated by the RX/TX error counters (I have not observed
this to happen, though):
- if status register says PASSIVE, report CAN_ERR_CRTL_RX_PASSIVE if
  RX error counter indicates PASSIVE as well, otherwise report
  CAN_ERR_CRTL_TX_PASSIVE
- if status register says WARNING, report CAN_ERR_CRTL_TX_WARNING
  or CAN_ERR_CRTL_RX_WARNING depending on which counter is higher.

After this commit, in both of the above scenarios:
- if overall state is PASSIVE, report
  CAN_ERR_CRTL_RX_PASSIVE | CAN_ERR_CRTL_TX_PASSIVE
- if overall state is WARNING, report
  CAN_ERR_CRTL_RX_WARNING | CAN_ERR_CRTL_TX_WARNING.

Tested with the integrated CAN on Zynq-7000 SoC.

Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
---

Andri Yngvason wrote:
> There is a function in drivers/net/can/dev.c that does this:
[...]
> It's not a big function, but the idea was to try to make this behaviour
> consistent between drivers by putting it into a function.

I didn't use it because I didn't have separate TX and RX states
available, and if I calculated them based on RX/TX error counters the
behavior would still be subtly different.

So I opted to just keep the previous error frame generation code as-is
to make sure the only behavior changed was the recovery from error
states being fixed, like the commit message said.

But here is a patch that makes it use can_change_state(), on top of the
posted patchset.

If wanted, I can squash this one into patch 3 (and 4), though I'd prefer
it to be kept separate as it introduces subtle behavior changes
unrelated to the actual fix in patch 3.


 drivers/net/can/xilinx_can.c | 63 +++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 26754e9..9525016 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -578,6 +578,27 @@ static enum can_state xcan_current_error_state(struct net_device *ndev)
 }
 
 /**
+ * xcan_errcounter_to_state - Get state based on error counter
+ * @err:	RX/TX error counter
+ *
+ * Get the CAN error state based on just the error counter. This is useful
+ * for determining RX and TX states separately as we only get a single global
+ * state from the device.
+ *
+ * Return:
+ * The CAN state based on the error counter.
+ */
+static enum can_state xcan_errcounter_to_state(u32 err)
+{
+	if (err >= 128)
+		return CAN_STATE_ERROR_PASSIVE;
+	else if (err >= 96)
+		return CAN_STATE_ERROR_WARNING;
+
+	return CAN_STATE_ERROR_ACTIVE;
+}
+
+/**
  * xcan_set_error_state - Set new CAN error state
  * @ndev:	Pointer to net_device structure
  * @new_state:	The new CAN state to be set
@@ -595,38 +616,26 @@ static void xcan_set_error_state(struct net_device *ndev,
 	u32 txerr = ecr & XCAN_ECR_TEC_MASK;
 	u32 rxerr = (ecr & XCAN_ECR_REC_MASK) >> XCAN_ESR_REC_SHIFT;
 
-	priv->can.state = new_state;
+	enum can_state tx_state = xcan_errcounter_to_state(txerr);
+	enum can_state rx_state = xcan_errcounter_to_state(rxerr);
+
+	/* non-ERROR states are handled elsewhere */
+	if (WARN_ON(new_state > CAN_STATE_ERROR_PASSIVE))
+		return;
+
+	if (max(rx_state, tx_state) != new_state) {
+		/* hw has a different idea of the state, just set both
+		 * tx and rx states to the same value
+		 */
+		rx_state = tx_state = new_state;
+	}
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

