From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V2 3/5] can: flexcan: add CANFD BRS support and improve
 bittiming setting
Date: Tue, 19 Mar 2019 05:17:25 +0000
Message-ID: <20190319051512.14950-4-qiangqing.zhang@nxp.com>
References: <20190319051512.14950-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190319051512.14950-1-qiangqing.zhang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

This patch intends to add CANFD BitRate Switch(BRS) support. Bit timing
always set in CBT register other than CTRL1 register when CANFD
supports BRS, it will extend the range of all CAN bit timing variables
(PRESDIV, PROPSEG, PSEG1, PSEG2 and RJW), which will improve the bit
timing accuracy.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

ChangeLog:
----------
V1->V2:
	*both normal mode and fd mode use CBT register to set bittimg on
	i.MX8 platform.
---
 drivers/net/can/flexcan.c | 116 +++++++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 28 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index f28a4c3e8087..63363f1b85d1 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -138,6 +138,14 @@
 	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
 	 FLEXCAN_ESR_WAK_INT)
=20
+/* FLEXCAN Bit Timing register (CBT) bits */
+#define FLEXCAN_CBT_BTF		        BIT(31)
+#define FLEXCAN_CBT_EPRESDIV(x)	        (((x) & 0x3ff) << 21)
+#define FLEXCAN_CBT_ERJW(x)		(((x) & 0x1f) << 16)
+#define FLEXCAN_CBT_EPROPSEG(x)	        (((x) & 0x3f) << 10)
+#define FLEXCAN_CBT_EPSEG1(x)		(((x) & 0x1f) << 5)
+#define FLEXCAN_CBT_EPSEG2(x)		((x) & 0x1f)
+
 /* FLEXCAN FD control register (FDCTRL) bits */
 #define FLEXCAN_FDCTRL_FDRATE		BIT(31)
 #define FLEXCAN_FDCTRL_MBDSR3(x)	(((x) & 0x3) << 25)
@@ -245,7 +253,8 @@ struct flexcan_regs {
 	u32 crcr;		/* 0x44 */
 	u32 rxfgmask;		/* 0x48 */
 	u32 rxfir;		/* 0x4c */
-	u32 _reserved3[12];	/* 0x50 */
+	u32 cbt;                /* 0x50 */
+	u32 _reserved3[11];     /* 0x54 */
 	u8 mb[2][512];		/* 0x80 */
 	/* FIFO-mode:
 	 *			MB
@@ -360,6 +369,18 @@ static const struct can_bittiming_const flexcan_bittim=
ing_const =3D {
 	.brp_inc =3D 1,
 };
=20
+static const struct can_bittiming_const flexcan_fd_bittiming_const =3D {
+	.name =3D DRV_NAME,
+	.tseg1_min =3D 2,
+	.tseg1_max =3D 64,
+	.tseg2_min =3D 1,
+	.tseg2_max =3D 32,
+	.sjw_max =3D 32,
+	.brp_min =3D 1,
+	.brp_max =3D 1024,
+	.brp_inc =3D 1,
+};
+
 static const struct can_bittiming_const flexcan_fd_data_bittiming_const =
=3D {
 	.name =3D DRV_NAME,
 	.tseg1_min =3D 1,
@@ -665,9 +686,13 @@ static netdev_tx_t flexcan_start_xmit(struct sk_buff *=
skb, struct net_device *de
 	if (cf->can_id & CAN_RTR_FLAG)
 		ctrl |=3D FLEXCAN_MB_CNT_RTR;
=20
-	if (can_is_canfd_skb(skb))
+	if (can_is_canfd_skb(skb)) {
 		ctrl |=3D FLEXCAN_MB_CNT_EDL;
=20
+		if (cf->flags & CANFD_BRS)
+			ctrl |=3D FLEXCAN_MB_CNT_BRS;
+	}
+
 	for (i =3D 0; i < cf->len; i +=3D sizeof(u32)) {
 		data =3D be32_to_cpup((__be32 *)&cf->data[i]);
 		priv->write(data, &priv->tx_mb->data[i / sizeof(u32)]);
@@ -876,6 +901,9 @@ static unsigned int flexcan_mailbox_read(struct can_rx_=
offload *offload,
=20
 	if (reg_ctrl & FLEXCAN_MB_CNT_EDL) {
 		cf->len =3D can_dlc2len((reg_ctrl >> 16) & 0x0F);
+
+		if (reg_ctrl & FLEXCAN_MB_CNT_BRS)
+			cf->flags |=3D CANFD_BRS;
 	} else {
 		cf->len =3D get_can_dlc((reg_ctrl >> 16) & 0x0F);
=20
@@ -1038,21 +1066,7 @@ static void flexcan_set_bittiming(struct net_device =
*dev)
 	u32 reg;
=20
 	reg =3D priv->read(&regs->ctrl);
-	reg &=3D ~(FLEXCAN_CTRL_PRESDIV(0xff) |
-		 FLEXCAN_CTRL_RJW(0x3) |
-		 FLEXCAN_CTRL_PSEG1(0x7) |
-		 FLEXCAN_CTRL_PSEG2(0x7) |
-		 FLEXCAN_CTRL_PROPSEG(0x7) |
-		 FLEXCAN_CTRL_LPB |
-		 FLEXCAN_CTRL_SMP |
-		 FLEXCAN_CTRL_LOM);
-
-	reg |=3D FLEXCAN_CTRL_PRESDIV(bt->brp - 1) |
-		FLEXCAN_CTRL_PSEG1(bt->phase_seg1 - 1) |
-		FLEXCAN_CTRL_PSEG2(bt->phase_seg2 - 1) |
-		FLEXCAN_CTRL_RJW(bt->sjw - 1) |
-		FLEXCAN_CTRL_PROPSEG(bt->prop_seg - 1);
-
+	reg &=3D ~(FLEXCAN_CTRL_LPB | FLEXCAN_CTRL_SMP | FLEXCAN_CTRL_LOM);
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
 		reg |=3D FLEXCAN_CTRL_LPB;
 	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
@@ -1063,18 +1077,63 @@ static void flexcan_set_bittiming(struct net_device=
 *dev)
 	netdev_dbg(dev, "writing ctrl=3D0x%08x\n", reg);
 	priv->write(reg, &regs->ctrl);
=20
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
-		reg =3D FLEXCAN_FDCBT_FPRESDIV(dbt->brp - 1) |
-			FLEXCAN_FDCBT_FPSEG1(dbt->phase_seg1 - 1) |
-			FLEXCAN_FDCBT_FPSEG2(dbt->phase_seg2 - 1) |
-			FLEXCAN_FDCBT_FRJW(dbt->sjw - 1) |
-			FLEXCAN_FDCBT_FPROPSEG(dbt->prop_seg);
-		priv->write(reg, &regs->fdcbt);
+	if (priv->can.ctrlmode_supported & CAN_CTRLMODE_FD) {
+		reg =3D FLEXCAN_CBT_EPRESDIV(bt->brp - 1) |
+			FLEXCAN_CBT_EPSEG1(bt->phase_seg1 - 1) |
+			FLEXCAN_CBT_EPSEG2(bt->phase_seg2 - 1) |
+			FLEXCAN_CBT_ERJW(bt->sjw - 1) |
+			FLEXCAN_CBT_EPROPSEG(bt->prop_seg - 1) |
+			FLEXCAN_CBT_BTF;
+		priv->write(reg, &regs->cbt);
+
+		netdev_dbg(dev, "bt: prediv %d seg1 %d seg2 %d rjw %d propseg %d\n",
+			   bt->brp - 1, bt->phase_seg1 - 1, bt->phase_seg2 - 1,
+			   bt->sjw - 1, bt->prop_seg - 1);
+
+		if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+			reg =3D FLEXCAN_FDCBT_FPRESDIV(dbt->brp - 1) |
+				FLEXCAN_FDCBT_FPSEG1(dbt->phase_seg1 - 1) |
+				FLEXCAN_FDCBT_FPSEG2(dbt->phase_seg2 - 1) |
+				FLEXCAN_FDCBT_FRJW(dbt->sjw - 1) |
+				FLEXCAN_FDCBT_FPROPSEG(dbt->prop_seg);
+			priv->write(reg, &regs->fdcbt);
+
+			if (bt->brp !=3D dbt->brp)
+				netdev_warn(dev, "PRESDIV not the same, may risk transfer errors\n");
+
+			netdev_dbg(dev, "fdbt: prediv %d seg1 %d seg2 %d rjw %d propseg %d\n",
+				   dbt->brp - 1, dbt->phase_seg1 - 1, dbt->phase_seg2 - 1,
+				   dbt->sjw - 1, dbt->prop_seg);
+
+			netdev_dbg(dev, "%s: mcr=3D0x%08x ctrl=3D0x%08x cbt=3D0x%08x fdcbt=3D0x=
%08x\n",
+				   __func__, priv->read(&regs->mcr),
+				   priv->read(&regs->ctrl),
+				   priv->read(&regs->cbt),
+				   priv->read(&regs->fdcbt));
+		}
+	} else {
+		reg =3D priv->read(&regs->ctrl);
+		reg &=3D ~(FLEXCAN_CTRL_PRESDIV(0xff) |
+			 FLEXCAN_CTRL_RJW(0x3) |
+			 FLEXCAN_CTRL_PSEG1(0x7) |
+			 FLEXCAN_CTRL_PSEG2(0x7) |
+			 FLEXCAN_CTRL_PROPSEG(0x7));
+
+		reg |=3D FLEXCAN_CTRL_PRESDIV(bt->brp - 1) |
+			FLEXCAN_CTRL_PSEG1(bt->phase_seg1 - 1) |
+			FLEXCAN_CTRL_PSEG2(bt->phase_seg2 - 1) |
+			FLEXCAN_CTRL_RJW(bt->sjw - 1) |
+			FLEXCAN_CTRL_PROPSEG(bt->prop_seg - 1);
+		priv->write(reg, &regs->ctrl);
+
+		netdev_dbg(dev, "bt: prediv %d seg1 %d seg2 %d rjw %d propseg %d\n",
+			   bt->brp - 1, bt->phase_seg1 - 1, bt->phase_seg2 - 1,
+			   bt->sjw - 1, bt->prop_seg - 1);
+
+		/* print chip status */
+		netdev_dbg(dev, "%s: mcr=3D0x%08x ctrl=3D0x%08x\n", __func__,
+			   priv->read(&regs->mcr), priv->read(&regs->ctrl));
 	}
-
-	/* print chip status */
-	netdev_dbg(dev, "%s: mcr=3D0x%08x ctrl=3D0x%08x\n", __func__,
-		   priv->read(&regs->mcr), priv->read(&regs->ctrl));
 }
=20
 /* flexcan_chip_start
@@ -1684,6 +1743,7 @@ static int flexcan_probe(struct platform_device *pdev=
)
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_TIMESTAMP_SUPPORT_FD) {
 		if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
 			priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_FD;
+			priv->can.bittiming_const =3D &flexcan_fd_bittiming_const;
 			priv->can.data_bittiming_const =3D &flexcan_fd_data_bittiming_const;
 		} else {
 			dev_err(&pdev->dev, "canfd mode can't work on fifo mode\n");
--=20
2.17.1
