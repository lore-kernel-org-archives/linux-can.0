From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V2 2/5] can: flexcan: add CAN FD mode support
Date: Tue, 19 Mar 2019 05:17:22 +0000
Message-ID: <20190319051512.14950-3-qiangqing.zhang@nxp.com>
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

This patch intends to add CAN FD mode support in driver, it means that
payload size can extend up to 64 bytes.

NOTE: Bit rate switch (BRS) enabled by system reset when it enables CAN
FD mode (explicitly set BRS again in driver). So CAN hardware has support
BRS, but now driver has not support it due to bit timing always set in CBT
register other than CTRL1 register. It will add in next patch.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

ChangeLog:
----------
V1->V2:
	*move "priv->offload.is_canfd =3D true" from _probe() to _start()
---
 drivers/net/can/flexcan.c | 110 ++++++++++++++++++++++++++++++++++----
 1 file changed, 100 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index e35083ff31ee..f28a4c3e8087 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -52,6 +52,7 @@
 #define FLEXCAN_MCR_IRMQ		BIT(16)
 #define FLEXCAN_MCR_LPRIO_EN		BIT(13)
 #define FLEXCAN_MCR_AEN			BIT(12)
+#define FLEXCAN_MCR_FDEN		BIT(11)
 /* MCR_MAXMB: maximum used MBs is MAXMB + 1 */
 #define FLEXCAN_MCR_MAXMB(x)		((x) & 0x7f)
 #define FLEXCAN_MCR_IDAM_A		(0x0 << 8)
@@ -137,6 +138,20 @@
 	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
 	 FLEXCAN_ESR_WAK_INT)
=20
+/* FLEXCAN FD control register (FDCTRL) bits */
+#define FLEXCAN_FDCTRL_FDRATE		BIT(31)
+#define FLEXCAN_FDCTRL_MBDSR3(x)	(((x) & 0x3) << 25)
+#define FLEXCAN_FDCTRL_MBDSR2(x)	(((x) & 0x3) << 22)
+#define FLEXCAN_FDCTRL_MBDSR1(x)	(((x) & 0x3) << 19)
+#define FLEXCAN_FDCTRL_MBDSR0(x)	(((x) & 0x3) << 16)
+
+/* FLEXCAN FD Bit Timing register (FDCBT) bits */
+#define FLEXCAN_FDCBT_FPRESDIV(x)	(((x) & 0x3ff) << 20)
+#define FLEXCAN_FDCBT_FRJW(x)		(((x) & 0x07) << 16)
+#define FLEXCAN_FDCBT_FPROPSEG(x)	(((x) & 0x1f) << 10)
+#define FLEXCAN_FDCBT_FPSEG1(x)		(((x) & 0x07) << 5)
+#define FLEXCAN_FDCBT_FPSEG2(x)		((x) & 0x07)
+
 /* FLEXCAN interrupt flag register (IFLAG) bits */
 /* Errata ERR005829 step7: Reserve first valid MB */
 #define FLEXCAN_TX_MB_RESERVED_OFF_FIFO		8
@@ -148,6 +163,10 @@
 #define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
=20
 /* FLEXCAN message buffers */
+#define FLEXCAN_MB_CNT_EDL		BIT(31)
+#define FLEXCAN_MB_CNT_BRS		BIT(30)
+#define FLEXCAN_MB_CNT_ESI		BIT(29)
+
 #define FLEXCAN_MB_CODE_MASK		(0xf << 24)
 #define FLEXCAN_MB_CODE_RX_BUSY_BIT	(0x1 << 24)
 #define FLEXCAN_MB_CODE_RX_INACTIVE	(0x0 << 24)
@@ -192,6 +211,7 @@
 #define FLEXCAN_QUIRK_BROKEN_PERR_STATE	BIT(6) /* No interrupt for error p=
assive */
 #define FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN	BIT(7) /* default to BE register =
access */
 #define FLEXCAN_QUIRK_SETUP_STOP_MODE		BIT(8) /* Setup stop mode to suppor=
t wakeup */
+#define FLEXCAN_QUIRK_TIMESTAMP_SUPPORT_FD	BIT(9) /* Use timestamp then su=
pport can fd mode */
=20
 /* Structure of the message buffer */
 struct flexcan_mb {
@@ -250,6 +270,9 @@ struct flexcan_regs {
 	u32 rerrdr;		/* 0xaf4 */
 	u32 rerrsynr;		/* 0xaf8 */
 	u32 errsr;		/* 0xafc */
+	u32 _reserved7[64];     /* 0xb00 */
+	u32 fdctrl;             /* 0xc00 */
+	u32 fdcbt;              /* 0xc04 */
 };
=20
 struct flexcan_devtype_data {
@@ -337,6 +360,18 @@ static const struct can_bittiming_const flexcan_bittim=
ing_const =3D {
 	.brp_inc =3D 1,
 };
=20
+static const struct can_bittiming_const flexcan_fd_data_bittiming_const =
=3D {
+	.name =3D DRV_NAME,
+	.tseg1_min =3D 1,
+	.tseg1_max =3D 39,
+	.tseg2_min =3D 1,
+	.tseg2_max =3D 8,
+	.sjw_max =3D 8,
+	.brp_min =3D 1,
+	.brp_max =3D 1024,
+	.brp_inc =3D 1,
+};
+
 /* FlexCAN module is essentially modelled as a little-endian IP in most
  * SoCs, i.e the registers as well as the message buffer areas are
  * implemented in a little-endian fashion.
@@ -609,10 +644,10 @@ static int flexcan_get_berr_counter(const struct net_=
device *dev,
 static netdev_tx_t flexcan_start_xmit(struct sk_buff *skb, struct net_devi=
ce *dev)
 {
 	const struct flexcan_priv *priv =3D netdev_priv(dev);
-	struct can_frame *cf =3D (struct can_frame *)skb->data;
+	struct canfd_frame *cf =3D (struct canfd_frame *)skb->data;
 	u32 can_id;
 	u32 data;
-	u32 ctrl =3D FLEXCAN_MB_CODE_TX_DATA | (cf->can_dlc << 16);
+	u32 ctrl =3D FLEXCAN_MB_CODE_TX_DATA | ((can_len2dlc(cf->len)) << 16);
 	int i;
=20
 	if (can_dropped_invalid_skb(dev, skb))
@@ -630,7 +665,10 @@ static netdev_tx_t flexcan_start_xmit(struct sk_buff *=
skb, struct net_device *de
 	if (cf->can_id & CAN_RTR_FLAG)
 		ctrl |=3D FLEXCAN_MB_CNT_RTR;
=20
-	for (i =3D 0; i < cf->can_dlc; i +=3D sizeof(u32)) {
+	if (can_is_canfd_skb(skb))
+		ctrl |=3D FLEXCAN_MB_CNT_EDL;
+
+	for (i =3D 0; i < cf->len; i +=3D sizeof(u32)) {
 		data =3D be32_to_cpup((__be32 *)&cf->data[i]);
 		priv->write(data, &priv->tx_mb->data[i / sizeof(u32)]);
 	}
@@ -790,7 +828,7 @@ static inline struct flexcan_priv *rx_offload_to_priv(s=
truct can_rx_offload *off
 }
=20
 static unsigned int flexcan_mailbox_read(struct can_rx_offload *offload,
-					 struct can_frame *cf,
+					 struct canfd_frame *cf,
 					 u32 *timestamp, unsigned int n)
 {
 	struct flexcan_priv *priv =3D rx_offload_to_priv(offload);
@@ -836,11 +874,21 @@ static unsigned int flexcan_mailbox_read(struct can_r=
x_offload *offload,
 	else
 		cf->can_id =3D (reg_id >> 18) & CAN_SFF_MASK;
=20
-	if (reg_ctrl & FLEXCAN_MB_CNT_RTR)
-		cf->can_id |=3D CAN_RTR_FLAG;
-	cf->can_dlc =3D get_can_dlc((reg_ctrl >> 16) & 0xf);
+	if (reg_ctrl & FLEXCAN_MB_CNT_EDL) {
+		cf->len =3D can_dlc2len((reg_ctrl >> 16) & 0x0F);
+	} else {
+		cf->len =3D get_can_dlc((reg_ctrl >> 16) & 0x0F);
+
+		if (reg_ctrl & FLEXCAN_MB_CNT_RTR)
+			cf->can_id |=3D CAN_RTR_FLAG;
+	}
+
+	if (reg_ctrl & FLEXCAN_MB_CNT_ESI) {
+		cf->flags |=3D CANFD_ESI;
+		netdev_warn(priv->can.dev, "ESI Error\n");
+	}
=20
-	for (i =3D 0; i < cf->can_dlc; i +=3D sizeof(u32)) {
+	for (i =3D 0; i < cf->len; i +=3D sizeof(u32)) {
 		__be32 data =3D cpu_to_be32(priv->read(&mb->data[i / sizeof(u32)]));
 		*(__be32 *)(cf->data + i) =3D data;
 	}
@@ -985,6 +1033,7 @@ static void flexcan_set_bittiming(struct net_device *d=
ev)
 {
 	const struct flexcan_priv *priv =3D netdev_priv(dev);
 	const struct can_bittiming *bt =3D &priv->can.bittiming;
+	const struct can_bittiming *dbt =3D &priv->can.data_bittiming;
 	struct flexcan_regs __iomem *regs =3D priv->regs;
 	u32 reg;
=20
@@ -1014,6 +1063,15 @@ static void flexcan_set_bittiming(struct net_device =
*dev)
 	netdev_dbg(dev, "writing ctrl=3D0x%08x\n", reg);
 	priv->write(reg, &regs->ctrl);
=20
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+		reg =3D FLEXCAN_FDCBT_FPRESDIV(dbt->brp - 1) |
+			FLEXCAN_FDCBT_FPSEG1(dbt->phase_seg1 - 1) |
+			FLEXCAN_FDCBT_FPSEG2(dbt->phase_seg2 - 1) |
+			FLEXCAN_FDCBT_FRJW(dbt->sjw - 1) |
+			FLEXCAN_FDCBT_FPROPSEG(dbt->prop_seg);
+		priv->write(reg, &regs->fdcbt);
+	}
+
 	/* print chip status */
 	netdev_dbg(dev, "%s: mcr=3D0x%08x ctrl=3D0x%08x\n", __func__,
 		   priv->read(&regs->mcr), priv->read(&regs->ctrl));
@@ -1028,7 +1086,7 @@ static int flexcan_chip_start(struct net_device *dev)
 {
 	struct flexcan_priv *priv =3D netdev_priv(dev);
 	struct flexcan_regs __iomem *regs =3D priv->regs;
-	u32 reg_mcr, reg_ctrl, reg_ctrl2, reg_mecr;
+	u32 reg_mcr, reg_ctrl, reg_ctrl2, reg_mecr, reg_fdctrl;
 	u64 reg_imask;
 	int err, i;
 	struct flexcan_mb __iomem *mb;
@@ -1125,6 +1183,24 @@ static int flexcan_chip_start(struct net_device *dev=
)
 	netdev_dbg(dev, "%s: writing ctrl=3D0x%08x", __func__, reg_ctrl);
 	priv->write(reg_ctrl, &regs->ctrl);
=20
+	/* FDCTRL
+	 *
+	 * support BRS when set CAN FD mode
+	 * 64 bytes payload per MB and 7 MBs per RAM block by default
+	 * enable CAN FD mode
+	 */
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+		reg_fdctrl =3D priv->read(&regs->fdctrl);
+		reg_fdctrl |=3D FLEXCAN_FDCTRL_FDRATE;
+		reg_fdctrl |=3D FLEXCAN_FDCTRL_MBDSR3(3) | FLEXCAN_FDCTRL_MBDSR2(3) |
+				FLEXCAN_FDCTRL_MBDSR1(3) | FLEXCAN_FDCTRL_MBDSR0(3);
+		priv->write(reg_fdctrl, &regs->fdctrl);
+		reg_mcr =3D priv->read(&regs->mcr);
+		priv->write(reg_mcr | FLEXCAN_MCR_FDEN, &regs->mcr);
+
+		priv->offload.is_canfd =3D true;
+	}
+
 	if ((priv->devtype_data->quirks & FLEXCAN_QUIRK_ENABLE_EACEN_RRS)) {
 		reg_ctrl2 =3D priv->read(&regs->ctrl2);
 		reg_ctrl2 |=3D FLEXCAN_CTRL2_EACEN | FLEXCAN_CTRL2_RRS;
@@ -1261,7 +1337,10 @@ static int flexcan_open(struct net_device *dev)
 	if (err)
 		goto out_close;
=20
-	priv->mb_size =3D sizeof(struct flexcan_mb) + CAN_MAX_DLEN;
+	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
+		priv->mb_size =3D sizeof(struct flexcan_mb) + CANFD_MAX_DLEN;
+	else
+		priv->mb_size =3D sizeof(struct flexcan_mb) + CAN_MAX_DLEN;
 	priv->mb_count =3D (sizeof(priv->regs->mb[0]) / priv->mb_size) +
 			 (sizeof(priv->regs->mb[1]) / priv->mb_size);
=20
@@ -1600,6 +1679,17 @@ static int flexcan_probe(struct platform_device *pde=
v)
 	priv->clk_src =3D clk_src;
 	priv->devtype_data =3D devtype_data;
 	priv->reg_xceiver =3D reg_xceiver;
+	priv->offload.is_canfd =3D false;
+
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_TIMESTAMP_SUPPORT_FD) {
+		if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
+			priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_FD;
+			priv->can.data_bittiming_const =3D &flexcan_fd_data_bittiming_const;
+		} else {
+			dev_err(&pdev->dev, "canfd mode can't work on fifo mode\n");
+			err =3D -EINVAL;
+		}
+	}
=20
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
--=20
2.17.1
