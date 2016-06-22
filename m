From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: [PATCH v2 2/2] can: rcar_canfd: Add back-to-error-active support
Date: Wed, 22 Jun 2016 13:31:47 +0100
Message-ID: <1466598707-44076-3-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
References: <1466434007-50873-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1466598707-44076-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1466598707-44076-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: mkl@pengutronix.de, wg@grandegger.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: devicetree@vger.kernel.org, chris.paterson2@renesas.com, socketcan@hartkopp.net, magnus.damm@gmail.com, linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, horms@verge.net.au, ulrich.hecht+renesas@gmail.com, Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-can.vger.kernel.org

As per Wolfgang G, all new drivers should support decreasing state
transition(back-to-error-active). This patch adds this support.

This driver configures the controller to halt on bus-off entry. Hence,
when in error states less than bus off state, the TEC/REC counters
are checked for lower state transition eligibility and action.

Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 76 ++++++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 20 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 6bcc474..43cdd55 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -917,16 +917,17 @@ static void rcar_canfd_global_error(struct net_device *ndev)
 	rcar_canfd_write(priv->base, RCANFD_GERFL, 0);
 }
 
-static void rcar_canfd_error(struct net_device *ndev)
+static void rcar_canfd_error(struct net_device *ndev, u32 cerfl,
+			     u16 txerr, u16 rxerr)
 {
 	struct rcar_canfd_channel *priv = netdev_priv(ndev);
 	struct net_device_stats *stats = &ndev->stats;
 	struct can_frame *cf;
 	struct sk_buff *skb;
-	u32 cerfl, csts;
-	u32 txerr = 0, rxerr = 0;
 	u32 ch = priv->channel;
 
+	netdev_dbg(ndev, "ch erfl %x txerr %u rxerr %u\n", cerfl, txerr, rxerr);
+
 	/* Propagate the error condition to the CAN stack */
 	skb = alloc_can_err_skb(ndev, &cf);
 	if (!skb) {
@@ -934,15 +935,7 @@ static void rcar_canfd_error(struct net_device *ndev)
 		return;
 	}
 
-	/* Channel error interrupt */
-	cerfl = rcar_canfd_read(priv->base, RCANFD_CERFL(ch));
-	csts = rcar_canfd_read(priv->base, RCANFD_CSTS(ch));
-	txerr = RCANFD_CSTS_TECCNT(csts);
-	rxerr = RCANFD_CSTS_RECCNT(csts);
-
-	netdev_dbg(ndev, "ch erfl %x sts %x txerr %u rxerr %u\n",
-		   cerfl, csts, txerr, rxerr);
-
+	/* Channel error interrupts */
 	if (cerfl & RCANFD_CERFL_BEF) {
 		netdev_dbg(ndev, "Bus error\n");
 		cf->can_id |= CAN_ERR_BUSERROR | CAN_ERR_PROT;
@@ -1032,8 +1025,9 @@ static void rcar_canfd_error(struct net_device *ndev)
 		cf->data[2] |= CAN_ERR_PROT_OVERLOAD;
 	}
 
-	/* Clear all channel error interrupts */
-	rcar_canfd_write(priv->base, RCANFD_CERFL(ch), 0);
+	/* Clear channel error interrupts that are handled */
+	rcar_canfd_write(priv->base, RCANFD_CERFL(ch),
+			 RCANFD_CERFL_ERR(~cerfl));
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
 	netif_rx(skb);
@@ -1098,12 +1092,12 @@ static irqreturn_t rcar_canfd_global_interrupt(int irq, void *dev_id)
 
 		/* Global error interrupts */
 		gerfl = rcar_canfd_read(priv->base, RCANFD_GERFL);
-		if (RCANFD_GERFL_ERR(gpriv, gerfl))
+		if (unlikely(RCANFD_GERFL_ERR(gpriv, gerfl)))
 			rcar_canfd_global_error(ndev);
 
 		/* Handle Rx interrupts */
 		sts = rcar_canfd_read(priv->base, RCANFD_RFSTS(ridx));
-		if (sts & RCANFD_RFSTS_RFIF) {
+		if (likely(sts & RCANFD_RFSTS_RFIF)) {
 			if (napi_schedule_prep(&priv->napi)) {
 				/* Disable Rx FIFO interrupts */
 				rcar_canfd_clear_bit(priv->base,
@@ -1116,12 +1110,46 @@ static irqreturn_t rcar_canfd_global_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void rcar_canfd_state_change(struct net_device *ndev,
+				    u16 txerr, u16 rxerr)
+{
+	struct rcar_canfd_channel *priv = netdev_priv(ndev);
+	struct net_device_stats *stats = &ndev->stats;
+	enum can_state rx_state, tx_state, state = priv->can.state;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+
+	/* Handle transition from error to normal states */
+	if (txerr < 96 && rxerr < 96)
+		state = CAN_STATE_ERROR_ACTIVE;
+	else if (txerr < 128 && rxerr < 128)
+		state = CAN_STATE_ERROR_WARNING;
+
+	if (state != priv->can.state) {
+		netdev_dbg(ndev, "state: new %d, old %d: txerr %u, rxerr %u\n",
+			   state, priv->can.state, txerr, rxerr);
+		skb = alloc_can_err_skb(ndev, &cf);
+		if (!skb) {
+			stats->rx_dropped++;
+			return;
+		}
+		tx_state = txerr >= rxerr ? state : 0;
+		rx_state = txerr <= rxerr ? state : 0;
+
+		can_change_state(ndev, cf, tx_state, rx_state);
+		stats->rx_packets++;
+		stats->rx_bytes += cf->can_dlc;
+		netif_rx(skb);
+	}
+}
+
 static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
 {
 	struct rcar_canfd_global *gpriv = dev_id;
 	struct net_device *ndev;
 	struct rcar_canfd_channel *priv;
-	u32 sts, cerfl, ch;
+	u32 sts, ch, cerfl;
+	u16 txerr, rxerr;
 
 	/* Common FIFO is a per channel resource */
 	for_each_set_bit(ch, &gpriv->channels_mask, RCANFD_NUM_CHANNELS) {
@@ -1130,13 +1158,21 @@ static irqreturn_t rcar_canfd_channel_interrupt(int irq, void *dev_id)
 
 		/* Channel error interrupts */
 		cerfl = rcar_canfd_read(priv->base, RCANFD_CERFL(ch));
-		if (RCANFD_CERFL_ERR(cerfl))
-			rcar_canfd_error(ndev);
+		sts = rcar_canfd_read(priv->base, RCANFD_CSTS(ch));
+		txerr = RCANFD_CSTS_TECCNT(sts);
+		rxerr = RCANFD_CSTS_RECCNT(sts);
+		if (unlikely(RCANFD_CERFL_ERR(cerfl)))
+			rcar_canfd_error(ndev, cerfl, txerr, rxerr);
+
+		/* Handle state change to lower states */
+		if (unlikely((priv->can.state != CAN_STATE_ERROR_ACTIVE) &&
+			     (priv->can.state != CAN_STATE_BUS_OFF)))
+			rcar_canfd_state_change(ndev, txerr, rxerr);
 
 		/* Handle Tx interrupts */
 		sts = rcar_canfd_read(priv->base,
 				      RCANFD_CFSTS(ch, RCANFD_CFFIFO_IDX));
-		if (sts & RCANFD_CFSTS_CFTXIF)
+		if (likely(sts & RCANFD_CFSTS_CFTXIF))
 			rcar_canfd_tx_done(ndev);
 	}
 	return IRQ_HANDLED;
-- 
1.9.1
