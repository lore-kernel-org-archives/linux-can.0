From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 3/3] can: flexcan: add imx8qm support
Date: Wed, 19 Dec 2018 08:39:07 +0000
Message-ID: <20181219083637.641-4-qiangqing.zhang@nxp.com>
References: <20181219083637.641-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181219083637.641-1-qiangqing.zhang@nxp.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

The Flexcan on i.MX8QM supports CAN FD protocol.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 0fc77d4e8ade..b7ab6ed87344 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -331,6 +331,12 @@ static const struct flexcan_devtype_data fsl_imx6q_dev=
type_data =3D {
 		FLEXCAN_QUIRK_SETUP_STOP_MODE,
 };
=20
+static struct flexcan_devtype_data fsl_imx8qm_devtype_data =3D {
+	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
+		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
+		FLEXCAN_QUIRK_TIMESTAMP_SUPPORT_FD,
+};
+
 static const struct flexcan_devtype_data fsl_vf610_devtype_data =3D {
 	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
 		FLEXCAN_QUIRK_DISABLE_MECR | FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
@@ -1534,6 +1540,7 @@ static int flexcan_setup_stop_mode(struct platform_de=
vice *pdev)
 }
=20
 static const struct of_device_id flexcan_of_match[] =3D {
+	{ .compatible =3D "fsl,imx8qm-flexcan", .data =3D &fsl_imx8qm_devtype_dat=
a, },
 	{ .compatible =3D "fsl,imx6q-flexcan", .data =3D &fsl_imx6q_devtype_data,=
 },
 	{ .compatible =3D "fsl,imx28-flexcan", .data =3D &fsl_imx28_devtype_data,=
 },
 	{ .compatible =3D "fsl,imx53-flexcan", .data =3D &fsl_imx25_devtype_data,=
 },
--=20
2.17.1
