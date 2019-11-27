From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V2 2/4] can: flexcan: try to exit stop mode during probe stage
Date: Wed, 27 Nov 2019 05:56:47 +0000
Message-ID: <20191127055334.1476-3-qiangqing.zhang@nxp.com>
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "sean@geanix.com" <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

CAN controller could be stucked in stop mode once it enters stop mode
when suspend, and then it fails to exit stop mode when resume. Only code
reset can get CAN out of stop mode, so add stop mode remove request
during probe stage for other methods(soft reset from chip level,
unbind/bind driver, etc) to let CAN active again. MCR[LPMACK] will be
checked when enable CAN in register_flexcandev().

Suggested-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
------
ChangeLog:
	V1->V2: new add.
---
 drivers/net/can/flexcan.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 2297663cacb2..5d5ed28d3005 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -449,6 +449,13 @@ static inline int flexcan_exit_stop_mode(struct flexca=
n_priv *priv)
 	return 0;
 }
=20
+static void flexcan_try_exit_stop_mode(struct flexcan_priv *priv)
+{
+	/* remove stop request */
+	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
+			   1 << priv->stm.req_bit, 0);
+}
+
 static inline void flexcan_error_irq_enable(const struct flexcan_priv *pri=
v)
 {
 	struct flexcan_regs __iomem *regs =3D priv->regs;
@@ -1649,6 +1656,21 @@ static int flexcan_probe(struct platform_device *pde=
v)
 	priv->devtype_data =3D devtype_data;
 	priv->reg_xceiver =3D reg_xceiver;
=20
+	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE) {
+		err =3D flexcan_setup_stop_mode(pdev);
+		if (err)
+			dev_dbg(&pdev->dev, "failed to setup stop-mode\n");
+
+		/* CAN controller could be stucked in stop mode once it enters
+		 * stop mode when suspend, and then it fails to exit stop
+		 * mode when resume. Only code reset can get CAN out of stop
+		 * mode, so add stop mode remove request here for other methods
+		 * (soft reset, bind, etc) to let CAN active again. MCR[LPMACK]
+		 * will be checked when enable CAN in register_flexcandev().
+		 */
+		flexcan_try_exit_stop_mode(priv);
+	}
+
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
@@ -1661,12 +1683,6 @@ static int flexcan_probe(struct platform_device *pde=
v)
=20
 	devm_can_led_init(dev);
=20
-	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE) {
-		err =3D flexcan_setup_stop_mode(pdev);
-		if (err)
-			dev_dbg(&pdev->dev, "failed to setup stop-mode\n");
-	}
-
 	return 0;
=20
  failed_register:
--=20
2.17.1
