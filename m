From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V2 4/5] can: flexcan: add ISO CAN FD feature support
Date: Tue, 19 Mar 2019 05:17:28 +0000
Message-ID: <20190319051512.14950-5-qiangqing.zhang@nxp.com>
References: <20190319051512.14950-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190319051512.14950-1-qiangqing.zhang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

ISO CAN FD is introduced to increase the failture detection capability
than non-ISO CAN FD. The non-ISO CAN FD is still supported by FlexCAN so
that it can be used mainly during an intermediate phase, for evaluation
and development purposes.

Therefore, it is strongly recommended to configure FlexCAN to the ISO
CAN FD protocol by setting the ISOCANFDEN field in the CTRL2 register.

NOTE: if you only set "fd on", driver will use ISO FD MODE by default.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

ChangeLog:
----------
V1->V2:
	*None
---
 drivers/net/can/flexcan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 63363f1b85d1..bcc935ebd105 100644
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
@@ -1257,6 +1258,12 @@ static int flexcan_chip_start(struct net_device *dev=
)
 		reg_mcr =3D priv->read(&regs->mcr);
 		priv->write(reg_mcr | FLEXCAN_MCR_FDEN, &regs->mcr);
=20
+		reg_ctrl2 =3D flexcan_read(&regs->ctrl2);
+		if (!(priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO))
+			flexcan_write(reg_ctrl2 | FLEXCAN_CTRL2_ISOCANFDEN, &regs->ctrl2);
+		else
+			flexcan_write(reg_ctrl2 & ~FLEXCAN_CTRL2_ISOCANFDEN, &regs->ctrl2);
+
 		priv->offload.is_canfd =3D true;
 	}
=20
@@ -1742,7 +1749,7 @@ static int flexcan_probe(struct platform_device *pdev=
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
