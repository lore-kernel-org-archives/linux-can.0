From: Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: [PATCH 6/7] can: ti_hecc: properly report state changes
Date: Tue, 24 Sep 2019 18:46:03 +0000
Message-ID: <20190924184437.10607-7-jhofstee@victronenergy.com>
References: <20190924184437.10607-1-jhofstee@victronenergy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190924184437.10607-1-jhofstee@victronenergy.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Jeroen Hofstee <jhofstee@victronenergy.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

The HECC_CANES register handles the flags specially, it only updates
the flags after a one is written to them. Since the interrupt for
frame errors is not enabled an old error can hence been seen when a
state interrupt arrives. For example if the device is not connected
to the CAN-bus the error warning interrupt will have HECC_CANES
indicating there is no ack. The error passive interrupt thereafter
will have HECC_CANES flagging that there is a warning level. And if
thereafter there is a message successfully send HECC_CANES points to
an error passive event, while in reality it became error warning
again. In summary, the state is not always reported correctly.

So handle the state changes and frame errors separately. The state
changes are now based on the interrupt flags and handled directly
when they occur. The reporting of the frame errors is still done as
before, as a side effect of another interrupt.

note: the hecc_clear_bit will do a read, modify, write. So it will
not only clear the bit, but also reset all other bits being set as
a side affect, hence it is replaced with only clearing the flags.

note: The HECC_CANMC_CCR is no longer cleared in the state change
interrupt, it is completely unrelated.

And use net_ratelimit to make checkpatch happy.

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
---
 drivers/net/can/ti_hecc.c | 156 ++++++++++++++++++++------------------
 1 file changed, 82 insertions(+), 74 deletions(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 4206ad5cb666..6098725bfdea 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -149,6 +149,8 @@ MODULE_VERSION(HECC_MODULE_VERSION);
 #define HECC_BUS_ERROR		(HECC_CANES_FE | HECC_CANES_BE |\
 				HECC_CANES_CRCE | HECC_CANES_SE |\
 				HECC_CANES_ACKE)
+#define HECC_CANES_FLAGS	(HECC_BUS_ERROR | HECC_CANES_BO |\
+				HECC_CANES_EP | HECC_CANES_EW)
=20
 #define HECC_CANMCF_RTR		BIT(4)	/* Remote transmit request */
=20
@@ -578,91 +580,63 @@ static int ti_hecc_error(struct net_device *ndev, int=
 int_status,
 	struct sk_buff *skb;
 	u32 timestamp;
=20
-	/* propagate the error condition to the can stack */
-	skb =3D alloc_can_err_skb(ndev, &cf);
-	if (!skb) {
-		if (printk_ratelimit())
-			netdev_err(priv->ndev,
-				   "%s: alloc_can_err_skb() failed\n",
-				   __func__);
-		return -ENOMEM;
-	}
-
-	if (int_status & HECC_CANGIF_WLIF) { /* warning level int */
-		if ((int_status & HECC_CANGIF_BOIF) =3D=3D 0) {
-			priv->can.state =3D CAN_STATE_ERROR_WARNING;
-			++priv->can.can_stats.error_warning;
-			cf->can_id |=3D CAN_ERR_CRTL;
-			if (hecc_read(priv, HECC_CANTEC) > 96)
-				cf->data[1] |=3D CAN_ERR_CRTL_TX_WARNING;
-			if (hecc_read(priv, HECC_CANREC) > 96)
-				cf->data[1] |=3D CAN_ERR_CRTL_RX_WARNING;
-		}
-		hecc_set_bit(priv, HECC_CANES, HECC_CANES_EW);
-		netdev_dbg(priv->ndev, "Error Warning interrupt\n");
-		hecc_clear_bit(priv, HECC_CANMC, HECC_CANMC_CCR);
-	}
-
-	if (int_status & HECC_CANGIF_EPIF) { /* error passive int */
-		if ((int_status & HECC_CANGIF_BOIF) =3D=3D 0) {
-			priv->can.state =3D CAN_STATE_ERROR_PASSIVE;
-			++priv->can.can_stats.error_passive;
-			cf->can_id |=3D CAN_ERR_CRTL;
-			if (hecc_read(priv, HECC_CANTEC) > 127)
-				cf->data[1] |=3D CAN_ERR_CRTL_TX_PASSIVE;
-			if (hecc_read(priv, HECC_CANREC) > 127)
-				cf->data[1] |=3D CAN_ERR_CRTL_RX_PASSIVE;
+	if (err_status & HECC_BUS_ERROR) {
+		/* propagate the error condition to the can stack */
+		skb =3D alloc_can_err_skb(ndev, &cf);
+		if (!skb) {
+			if (net_ratelimit())
+				netdev_err(priv->ndev,
+					   "%s: alloc_can_err_skb() failed\n",
+					   __func__);
+			return -ENOMEM;
 		}
-		hecc_set_bit(priv, HECC_CANES, HECC_CANES_EP);
-		netdev_dbg(priv->ndev, "Error passive interrupt\n");
-		hecc_clear_bit(priv, HECC_CANMC, HECC_CANMC_CCR);
-	}
-
-	/* Need to check busoff condition in error status register too to
-	 * ensure warning interrupts don't hog the system
-	 */
-	if ((int_status & HECC_CANGIF_BOIF) || (err_status & HECC_CANES_BO)) {
-		priv->can.state =3D CAN_STATE_BUS_OFF;
-		cf->can_id |=3D CAN_ERR_BUSOFF;
-		hecc_set_bit(priv, HECC_CANES, HECC_CANES_BO);
-		hecc_clear_bit(priv, HECC_CANMC, HECC_CANMC_CCR);
-		/* Disable all interrupts in bus-off to avoid int hog */
-		hecc_write(priv, HECC_CANGIM, 0);
-		++priv->can.can_stats.bus_off;
-		can_bus_off(ndev);
-	}
=20
-	if (err_status & HECC_BUS_ERROR) {
 		++priv->can.can_stats.bus_error;
 		cf->can_id |=3D CAN_ERR_BUSERROR | CAN_ERR_PROT;
-		if (err_status & HECC_CANES_FE) {
-			hecc_set_bit(priv, HECC_CANES, HECC_CANES_FE);
+		if (err_status & HECC_CANES_FE)
 			cf->data[2] |=3D CAN_ERR_PROT_FORM;
-		}
-		if (err_status & HECC_CANES_BE) {
-			hecc_set_bit(priv, HECC_CANES, HECC_CANES_BE);
+		if (err_status & HECC_CANES_BE)
 			cf->data[2] |=3D CAN_ERR_PROT_BIT;
-		}
-		if (err_status & HECC_CANES_SE) {
-			hecc_set_bit(priv, HECC_CANES, HECC_CANES_SE);
+		if (err_status & HECC_CANES_SE)
 			cf->data[2] |=3D CAN_ERR_PROT_STUFF;
-		}
-		if (err_status & HECC_CANES_CRCE) {
-			hecc_set_bit(priv, HECC_CANES, HECC_CANES_CRCE);
+		if (err_status & HECC_CANES_CRCE)
 			cf->data[3] =3D CAN_ERR_PROT_LOC_CRC_SEQ;
-		}
-		if (err_status & HECC_CANES_ACKE) {
-			hecc_set_bit(priv, HECC_CANES, HECC_CANES_ACKE);
+		if (err_status & HECC_CANES_ACKE)
 			cf->data[3] =3D CAN_ERR_PROT_LOC_ACK;
-		}
+
+		timestamp =3D hecc_read(priv, HECC_CANLNT);
+		can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
 	}
=20
-	timestamp =3D hecc_read(priv, HECC_CANLNT);
-	can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
+	hecc_write(priv, HECC_CANES, HECC_CANES_FLAGS);
=20
 	return 0;
 }
=20
+static void change_state(struct ti_hecc_priv *priv, enum can_state rx_stat=
e,
+			 enum can_state tx_state)
+{
+	struct can_frame *cf;
+	struct sk_buff *skb;
+	u32 timestamp;
+
+	skb =3D alloc_can_err_skb(priv->ndev, &cf);
+	if (unlikely(!skb)) {
+		priv->can.state =3D max(tx_state, rx_state);
+		return;
+	}
+
+	can_change_state(priv->ndev, cf, tx_state, rx_state);
+
+	if (max(tx_state, rx_state) !=3D CAN_STATE_BUS_OFF) {
+		cf->data[6] =3D hecc_read(priv, HECC_CANTEC);
+		cf->data[7] =3D hecc_read(priv, HECC_CANREC);
+	}
+
+	timestamp =3D hecc_read(priv, HECC_CANLNT);
+	can_rx_offload_queue_sorted(&priv->offload, skb, timestamp);
+}
+
 static irqreturn_t ti_hecc_interrupt(int irq, void *dev_id)
 {
 	struct net_device *ndev =3D (struct net_device *)dev_id;
@@ -670,6 +644,7 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *dev=
_id)
 	struct net_device_stats *stats =3D &ndev->stats;
 	u32 mbxno, mbx_mask, int_status, err_status, stamp;
 	unsigned long flags, rx_pending;
+	u32 handled =3D 0;
=20
 	int_status =3D hecc_read(priv,
 			       priv->use_hecc1int ?
@@ -679,10 +654,43 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *d=
ev_id)
 		return IRQ_NONE;
=20
 	err_status =3D hecc_read(priv, HECC_CANES);
-	if (err_status & (HECC_BUS_ERROR | HECC_CANES_BO |
-			  HECC_CANES_EP | HECC_CANES_EW))
+	if (unlikely(err_status & HECC_CANES_FLAGS))
 		ti_hecc_error(ndev, int_status, err_status);
=20
+	if (unlikely(int_status & HECC_CANGIM_DEF_MASK)) {
+		enum can_state rx_state, tx_state;
+		u32 rec =3D hecc_read(priv, HECC_CANREC);
+		u32 tec =3D hecc_read(priv, HECC_CANTEC);
+
+		if (int_status & HECC_CANGIF_WLIF) {
+			handled |=3D HECC_CANGIF_WLIF;
+			rx_state =3D rec >=3D tec ? CAN_STATE_ERROR_WARNING : 0;
+			tx_state =3D rec <=3D tec ? CAN_STATE_ERROR_WARNING : 0;
+			netdev_dbg(priv->ndev, "Error Warning interrupt\n");
+			change_state(priv, rx_state, tx_state);
+		}
+
+		if (int_status & HECC_CANGIF_EPIF) {
+			handled |=3D HECC_CANGIF_EPIF;
+			rx_state =3D rec >=3D tec ? CAN_STATE_ERROR_PASSIVE : 0;
+			tx_state =3D rec <=3D tec ? CAN_STATE_ERROR_PASSIVE : 0;
+			netdev_dbg(priv->ndev, "Error passive interrupt\n");
+			change_state(priv, rx_state, tx_state);
+		}
+
+		if (int_status & HECC_CANGIF_BOIF) {
+			handled |=3D HECC_CANGIF_BOIF;
+			rx_state =3D CAN_STATE_BUS_OFF;
+			tx_state =3D CAN_STATE_BUS_OFF;
+			netdev_dbg(priv->ndev, "Bus off interrupt\n");
+
+			/* Disable all interrupts */
+			hecc_write(priv, HECC_CANGIM, 0);
+			can_bus_off(ndev);
+			change_state(priv, rx_state, tx_state);
+		}
+	}
+
 	if (int_status & HECC_CANGIF_GMIF) {
 		while (priv->tx_tail - priv->tx_head > 0) {
 			mbxno =3D get_tx_tail_mb(priv);
@@ -718,10 +726,10 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *d=
ev_id)
=20
 	/* clear all interrupt conditions - read back to avoid spurious ints */
 	if (priv->use_hecc1int) {
-		hecc_write(priv, HECC_CANGIF1, HECC_SET_REG);
+		hecc_write(priv, HECC_CANGIF1, handled);
 		int_status =3D hecc_read(priv, HECC_CANGIF1);
 	} else {
-		hecc_write(priv, HECC_CANGIF0, HECC_SET_REG);
+		hecc_write(priv, HECC_CANGIF0, handled);
 		int_status =3D hecc_read(priv, HECC_CANGIF0);
 	}
=20
--=20
2.17.1
