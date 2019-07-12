From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 5/8] can: flexcan: add ISO CAN FD feature support
Date: Fri, 12 Jul 2019 08:02:51 +0000
Message-ID: <20190712075926.7357-6-qiangqing.zhang@nxp.com>
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

ISO CAN FD is introduced to increase the failture detection capability
than non-ISO CAN FD. The non-ISO CAN FD is still supported by FlexCAN so
that it can be used mainly during an intermediate phase, for evaluation
and development purposes.

Therefore, it is strongly recommended to configure FlexCAN to the ISO
CAN FD protocol by setting the ISOCANFDEN field in the CTRL2 register.

NOTE: If you only set "fd on", driver will use ISO FD mode by default.
You should set "fd-non-iso on" after setting "fd on" if you want to use
NON ISO FD mode.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 4956ef64944a..daf4f0e88224 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -92,6 +92,7 @@
 #define FLEXCAN_CTRL2_MRP		BIT(18)
 #define FLEXCAN_CTRL2_RRS		BIT(17)
 #define FLEXCAN_CTRL2_EACEN		BIT(16)
+#define FLEXCAN_CTRL2_ISOCANFDEN	BIT(12)
=20
 /* FLEXCAN memory error control register (MECR) bits */
 #define FLEXCAN_MECR_ECRWRDIS		BIT(31)
@@ -1297,6 +1298,7 @@ static int flexcan_chip_start(struct net_device *dev)
 		reg_fdctrl =3D priv->read(&regs->fdctrl) & ~FLEXCAN_FDCTRL_FDRATE;
 		reg_fdctrl &=3D ~(FLEXCAN_FDCTRL_MBDSR1(0x3) | FLEXCAN_FDCTRL_MBDSR0(0x3=
));
 		reg_mcr =3D priv->read(&regs->mcr) & ~FLEXCAN_MCR_FDEN;
+		reg_ctrl2 =3D priv->read(&regs->ctrl2) & ~FLEXCAN_CTRL2_ISOCANFDEN;
=20
 		/* support BRS when set CAN FD mode
 		 * 64 bytes payload per MB and 7 MBs per RAM block by default
@@ -1306,10 +1308,14 @@ static int flexcan_chip_start(struct net_device *de=
v)
 			reg_fdctrl |=3D FLEXCAN_FDCTRL_FDRATE;
 			reg_fdctrl |=3D FLEXCAN_FDCTRL_MBDSR1(0x3) | FLEXCAN_FDCTRL_MBDSR0(0x3)=
;
 			reg_mcr |=3D FLEXCAN_MCR_FDEN;
+
+			if (!(priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO))
+				reg_ctrl2 |=3D FLEXCAN_CTRL2_ISOCANFDEN;
 		}
=20
 		priv->write(reg_fdctrl, &regs->fdctrl);
 		priv->write(reg_mcr, &regs->mcr);
+		priv->write(reg_ctrl2, &regs->ctrl2);
 	}
=20
 	if ((priv->devtype_data->quirks & FLEXCAN_QUIRK_ENABLE_EACEN_RRS)) {
@@ -1799,7 +1805,7 @@ static int flexcan_probe(struct platform_device *pdev=
)
=20
 	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_TIMESTAMP_SUPPORT_FD) {
 		if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {
-			priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_FD;
+			priv->can.ctrlmode_supported |=3D CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON=
_ISO;
 			priv->can.bittiming_const =3D &flexcan_fd_bittiming_const;
 			priv->can.data_bittiming_const =3D &flexcan_fd_data_bittiming_const;
 		} else {
--=20
2.17.1
