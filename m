From: Matthias Klein <matthias.klein@optimeas.de>
Subject: [PATCH V2 5/5] net: can: flexcan: fix for wrong TX error count behaviour on i.MX53
Date: Mon, 28 Jul 2014 08:34:28 +0200
Message-ID: <1406529268-20126-5-git-send-email-matthias.klein@optimeas.de>
References: <1406529268-20126-1-git-send-email-matthias.klein@optimeas.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from obi-wan.optimeas.de ([82.165.198.204]:40271 "EHLO
	obi-wan.optimeas.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbaG1Gei (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Jul 2014 02:34:38 -0400
In-Reply-To: <1406529268-20126-1-git-send-email-matthias.klein@optimeas.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, support@karo-electronics.de
Cc: bigeasy@linutronix.de

Once the CAN-bus is open and a packet is sent, the controller switches
into the PASSIVE state and the TX error count goes to 0x80. When the
bus is closed and the packet gets acknowledged the controller switches
to ERROR-WARNING state and the TX error counter is decremented to 0x7f.
Everything OK so far.

When now the bus is open again and a packet is sent, the controller
switches into PASSIVE state and sets the TX error count to 0x86.
When now the bus is closed the TX error is decremented to 0x85, but
the state does not change to ERROR-WARNING. Now with each successfully
transfered packet (in PASSIVE state!) the TX error counter is
decremented, and when the TX error counter reaches 0x7f the controller
switched back into ERROR-WARNING state.

This fix sets the TX error count back to zero when entering the
ERROR-WARNING state (after the first retransfered packet is acknowledge=
d).

Signed-off-by: Matthias Klein <matthias.klein@optimeas.de>
---
 drivers/net/can/flexcan.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index b77f1da..f9fefcb 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -479,6 +479,34 @@ static int flexcan_poll_bus_err(struct net_device =
*dev, u32 reg_esr)
 	return 1;
 }
=20
+static void flexcan_reset_err_reg(struct flexcan_priv *priv)
+{
+	struct flexcan_regs __iomem *regs =3D priv->base;
+
+	/*
+	 * The reset of the error counter is ugly but I don't see any other w=
ay.
+	 * Open the CAN bus, send packet =3D> HW goes to ERR-pasive, TX-err
+	 * counter is around 128 (maybe 129). Close the CAN-Bus, the TX-err
+	 * counter drops down to somewhere between 126 =E2=80=A6 127, HW goes=
 to
+	 * ERR-Warning, everything is fine.
+	 *
+	 * Now: Repeat the above procedure. What happens is that on send the
+	 * TX-err increases to around 134=E2=80=A6136 and on connect it drops=
 to
+	 * around 130. Occording to ESR the HW is still in passive mode _but_=
 it
+	 * is possible send packets - that means can send packets but has no
+	 * clue about it.
+	 * To get a consistent behavior here, the error counter are reset so =
we
+	 * fall back to Err-Active mode and the second "can send on open bus"
+	 * behaves just like the first one.
+	 */
+
+	flexcan_chip_freeze(priv);
+
+	flexcan_write(0, &regs->ecr);
+
+	flexcan_chip_unfreeze(priv);
+}
+
 static void do_state(struct net_device *dev,
 		     struct can_frame *cf, enum can_state new_state)
 {
@@ -537,6 +565,8 @@ static void do_state(struct net_device *dev,
 		cf->data[1] =3D (bec.txerr > bec.rxerr) ?
 			CAN_ERR_CRTL_TX_WARNING :
 			CAN_ERR_CRTL_RX_WARNING;
+
+		flexcan_reset_err_reg(priv);
 		break;
 	case CAN_STATE_ERROR_ACTIVE:
 		netdev_dbg(dev, "Error Active\n");
--=20
2.0.1

