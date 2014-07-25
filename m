From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] net: can: flexcan: reset the error counter after leaving
 passive state
Date: Fri, 25 Jul 2014 20:51:17 +0200
Message-ID: <20140725185117.GB24839@linutronix.de>
References: <1406312202-2542-1-git-send-email-matthias.klein@optimeas.de>
 <1406312202-2542-4-git-send-email-matthias.klein@optimeas.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59214 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758281AbaGYSvU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 14:51:20 -0400
Content-Disposition: inline
In-Reply-To: <1406312202-2542-4-git-send-email-matthias.klein@optimeas.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Matthias Klein <matthias.klein@optimeas.de>
Cc: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, support@karo-electronics.de

The reasoning of why is done what is done is described in the longer
comment which I do not repeat here.
While pleaying with the HALT/Freeze mode/bit I noticed that the manual
says that one has to wait until the core completed the request or
 "otherwise FLEXCAN may operate in an unpredictable way"
therefore flexcan_wait_for_frz() is added to places where the HALT bit
is set / cleared.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/can/flexcan.c | 61 +++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index f6f95ae..0ac99c5 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -441,6 +441,61 @@ static int flexcan_poll_bus_err(struct net_device =
*dev, u32 reg_esr)
 	return 1;
 }
=20
+static void flexcan_wait_for_frz(struct net_device *dev, int en)
+{
+	struct flexcan_priv *priv =3D netdev_priv(dev);
+	struct flexcan_regs __iomem *regs =3D priv->base;
+	u32 reg_mcr;
+	u32 loops =3D 25;
+
+	do {
+		reg_mcr =3D flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK;
+		if ((en && reg_mcr) || (!en && !reg_mcr))
+			return;
+
+		loops--;
+		udelay(1);
+	} while (loops);
+
+	netdev_err(dev, "Timeout during for the FRZ bit\n");
+}
+
+static void flexcan_reset_err_reg(struct net_device *dev)
+{
+	struct flexcan_priv *priv =3D netdev_priv(dev);
+	struct flexcan_regs __iomem *regs =3D priv->base;
+	u32 reg_mcr;
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
+	reg_mcr =3D flexcan_read(&regs->mcr);
+	reg_mcr |=3D FLEXCAN_MCR_HALT;
+	flexcan_write(reg_mcr, &regs->mcr);
+
+	flexcan_wait_for_frz(dev, 1);
+
+	flexcan_write(0, &regs->ecr);
+
+	reg_mcr &=3D ~FLEXCAN_MCR_HALT;
+	flexcan_write(reg_mcr, &regs->mcr);
+	flexcan_wait_for_frz(dev, 0);
+}
+
 static void do_state(struct net_device *dev,
 		     struct can_frame *cf, enum can_state new_state)
 {
@@ -499,6 +554,8 @@ static void do_state(struct net_device *dev,
 		cf->data[1] =3D (bec.txerr > bec.rxerr) ?
 			CAN_ERR_CRTL_TX_WARNING :
 			CAN_ERR_CRTL_RX_WARNING;
+
+		flexcan_reset_err_reg(dev);
 		break;
 	case CAN_STATE_ERROR_ACTIVE:
 		netdev_dbg(dev, "Error Active\n");
@@ -801,6 +858,7 @@ static int flexcan_chip_start(struct net_device *de=
v)
 		FLEXCAN_MCR_MAXMB(FLEXCAN_TX_BUF_ID);
 	netdev_dbg(dev, "%s: writing mcr=3D0x%08x", __func__, reg_mcr);
 	flexcan_write(reg_mcr, &regs->mcr);
+	flexcan_wait_for_frz(dev, 1);
=20
 	/*
 	 * CTRL
@@ -852,6 +910,7 @@ static int flexcan_chip_start(struct net_device *de=
v)
 	reg_mcr =3D flexcan_read(&regs->mcr);
 	reg_mcr &=3D ~FLEXCAN_MCR_HALT;
 	flexcan_write(reg_mcr, &regs->mcr);
+	flexcan_wait_for_frz(dev, 0);
=20
 	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
=20
@@ -885,6 +944,7 @@ static void flexcan_chip_stop(struct net_device *de=
v)
 	reg =3D flexcan_read(&regs->mcr);
 	reg |=3D FLEXCAN_MCR_MDIS | FLEXCAN_MCR_HALT;
 	flexcan_write(reg, &regs->mcr);
+	flexcan_wait_for_frz(dev, 1);
=20
 	/* Disable all interrupts */
 	flexcan_write(0, &regs->imask1);
@@ -1018,6 +1078,7 @@ static int register_flexcandev(struct net_device =
*dev)
 	reg |=3D FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT |
 		FLEXCAN_MCR_FEN | FLEXCAN_MCR_SUPV;
 	flexcan_write(reg, &regs->mcr);
+	flexcan_wait_for_frz(dev, 1);
=20
 	/*
 	 * Currently we only support newer versions of this core
--=20
2.0.1

