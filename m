From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V3 5/6] can: flexcan: propagate error value of
 flexcan_chip_stop()
Date: Wed, 4 Dec 2019 11:36:17 +0000
Message-ID: <20191204113249.3381-6-qiangqing.zhang@nxp.com>
References: <20191204113249.3381-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191204113249.3381-1-qiangqing.zhang@nxp.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "sean@geanix.com" <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

Propagate error value of flexcan_chip_stop(), since this could be called
from flexcan_suspend() in some SoCs which support LPSR mode.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
------
ChangeLog:
	V3: * new add.
---
 drivers/net/can/flexcan.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 19602b77907f..c5e4b6928dee 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1263,14 +1263,19 @@ static int flexcan_chip_start(struct net_device *de=
v)
  *
  * this functions is entered with clocks enabled
  */
-static void flexcan_chip_stop(struct net_device *dev)
+static int flexcan_chip_stop(struct net_device *dev)
 {
 	struct flexcan_priv *priv =3D netdev_priv(dev);
 	struct flexcan_regs __iomem *regs =3D priv->regs;
+	int err;
=20
 	/* freeze + disable module */
-	flexcan_chip_freeze(priv);
-	flexcan_chip_disable(priv);
+	err =3D flexcan_chip_freeze(priv);
+	if (err)
+		return err;
+	err =3D flexcan_chip_disable(priv);
+	if (err)
+		goto out_chip_unfreeze;
=20
 	/* Disable all interrupts */
 	priv->write(0, &regs->imask2);
@@ -1278,8 +1283,19 @@ static void flexcan_chip_stop(struct net_device *dev=
)
 	priv->write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
 		    &regs->ctrl);
=20
-	flexcan_transceiver_disable(priv);
+	err =3D flexcan_transceiver_disable(priv);
+	if (err)
+		goto out_chip_enable;
+
 	priv->can.state =3D CAN_STATE_STOPPED;
+
+	return 0;
+
+out_chip_enable:
+	flexcan_chip_enable(priv);
+out_chip_unfreeze:
+	flexcan_chip_unfreeze(priv);
+	return err;
 }
=20
 static int flexcan_open(struct net_device *dev)
--=20
2.17.1
