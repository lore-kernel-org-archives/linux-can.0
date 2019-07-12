From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 6/8] can: flexcan: add Transceiver Delay Compensation suopport
Date: Fri, 12 Jul 2019 08:02:56 +0000
Message-ID: <20190712075926.7357-7-qiangqing.zhang@nxp.com>
References: <20190712075926.7357-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190712075926.7357-1-qiangqing.zhang@nxp.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

The CAN FD protocol allows the transmission and reception of data at a high=
er
bit rate than the nominal rate used in the arbitration phase when the messa=
ge's
BRS bit is set.

The TDC mechanism is effective only during the data phase of FD frames
having BRS bit set. It has no effect either on non-FD frames, or on FD
frames transmitted at normal bit rate.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index daf4f0e88224..2c48151e431f 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -149,8 +149,10 @@
=20
 /* FLEXCAN FD control register (FDCTRL) bits */
 #define FLEXCAN_FDCTRL_FDRATE		BIT(31)
+#define FLEXCAN_FDCTRL_TDCEN		BIT(15)
 #define FLEXCAN_FDCTRL_MBDSR1(x)	(((x) & 0x3) << 19)
 #define FLEXCAN_FDCTRL_MBDSR0(x)	(((x) & 0x3) << 16)
+#define FLEXCAN_FDCTRL_TDCOFF(x)	(((x) & 0x1f) << 8)
=20
 /* FLEXCAN FD Bit Timing register (FDCBT) bits */
 #define FLEXCAN_FDCBT_FPRESDIV(x)	(((x) & 0x3ff) << 20)
@@ -1075,7 +1077,7 @@ static void flexcan_set_bittiming(struct net_device *=
dev)
 	struct can_bittiming *bt =3D &priv->can.bittiming;
 	struct can_bittiming *dbt =3D &priv->can.data_bittiming;
 	struct flexcan_regs __iomem *regs =3D priv->regs;
-	u32 reg, reg_cbt, reg_fdcbt;
+	u32 reg, reg_cbt, reg_fdcbt, reg_fdctrl;
=20
 	reg =3D priv->read(&regs->ctrl);
 	reg &=3D ~(FLEXCAN_CTRL_LPB | FLEXCAN_CTRL_SMP | FLEXCAN_CTRL_LOM);
@@ -1147,6 +1149,19 @@ static void flexcan_set_bittiming(struct net_device =
*dev)
 					FLEXCAN_FDCBT_FPROPSEG(dbt->prop_seg);
 			priv->write(reg_fdcbt, &regs->fdcbt);
=20
+			/* enable transceiver delay compensation(TDC) for fd frame.
+			 * TDC must be disabled when Loop Back mode is enabled.
+			 */
+			reg_fdctrl =3D priv->read(&regs->fdctrl);
+			if (!(reg & FLEXCAN_CTRL_LPB)) {
+				reg_fdctrl |=3D FLEXCAN_FDCTRL_TDCEN;
+				reg_fdctrl &=3D ~FLEXCAN_FDCTRL_TDCOFF(0x1f);
+				/* for the TDC to work reliably, the offset has to use optimal setting=
s */
+				reg_fdctrl |=3D FLEXCAN_FDCTRL_TDCOFF(((dbt->phase_seg1 - 1) + dbt->pr=
op_seg + 2) *
+								    ((dbt->brp -1) + 1));
+			}
+			priv->write(reg_fdctrl, &regs->fdctrl);
+
 			if (bt->brp !=3D dbt->brp)
 				netdev_warn(dev, "Warning!! data brp =3D %d and brp =3D %d don't match=
.\n"
 					    "flexcan may not work. consider using different bitrate or data b=
itrate\n",
@@ -1296,6 +1311,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	/* FDCTRL */
 	if (priv->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
 		reg_fdctrl =3D priv->read(&regs->fdctrl) & ~FLEXCAN_FDCTRL_FDRATE;
+		reg_fdctrl &=3D ~FLEXCAN_FDCTRL_TDCEN;
 		reg_fdctrl &=3D ~(FLEXCAN_FDCTRL_MBDSR1(0x3) | FLEXCAN_FDCTRL_MBDSR0(0x3=
));
 		reg_mcr =3D priv->read(&regs->mcr) & ~FLEXCAN_MCR_FDEN;
 		reg_ctrl2 =3D priv->read(&regs->ctrl2) & ~FLEXCAN_CTRL2_ISOCANFDEN;
--=20
2.17.1
