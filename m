From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V2 4/4] can: flexcan: add LPSR mode support
Date: Wed, 27 Nov 2019 05:56:52 +0000
Message-ID: <20191127055334.1476-5-qiangqing.zhang@nxp.com>
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

For i.MX7D LPSR mode, the controller will lost power and got the
configuration state lost after system resume back. (coming i.MX8QM/QXP
will also completely power off the domain, the controller state will be
lost and needs restore).
So we need to set pinctrl state again and re-start chip to do
re-configuration after resume.

For wakeup case, it should not set pinctrl to sleep state by
pinctrl_pm_select_sleep_state.
For interface is not up before suspend case, we don't need
re-configure as it will be configured by user later by interface up.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
------
ChangeLog:
	V1->V2: no change.
---
 drivers/net/can/flexcan.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index d178146b3da5..d1509cffdd24 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/regmap.h>
=20
 #define DRV_NAME			"flexcan"
@@ -1707,7 +1708,7 @@ static int __maybe_unused flexcan_suspend(struct devi=
ce *device)
 {
 	struct net_device *dev =3D dev_get_drvdata(device);
 	struct flexcan_priv *priv =3D netdev_priv(dev);
-	int err =3D 0;
+	int err;
=20
 	if (netif_running(dev)) {
 		/* if wakeup is enabled, enter stop mode
@@ -1719,25 +1720,27 @@ static int __maybe_unused flexcan_suspend(struct de=
vice *device)
 			if (err)
 				return err;
 		} else {
-			err =3D flexcan_chip_disable(priv);
+			flexcan_chip_stop(dev);
+
+			err =3D pm_runtime_force_suspend(device);
 			if (err)
 				return err;
=20
-			err =3D pm_runtime_force_suspend(device);
+			pinctrl_pm_select_sleep_state(device);
 		}
 		netif_stop_queue(dev);
 		netif_device_detach(dev);
 	}
 	priv->can.state =3D CAN_STATE_SLEEPING;
=20
-	return err;
+	return 0;
 }
=20
 static int __maybe_unused flexcan_resume(struct device *device)
 {
 	struct net_device *dev =3D dev_get_drvdata(device);
 	struct flexcan_priv *priv =3D netdev_priv(dev);
-	int err =3D 0;
+	int err;
=20
 	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
 	if (netif_running(dev)) {
@@ -1749,15 +1752,19 @@ static int __maybe_unused flexcan_resume(struct dev=
ice *device)
 			if (err)
 				return err;
 		} else {
+			pinctrl_pm_select_default_state(device);
+
 			err =3D pm_runtime_force_resume(device);
 			if (err)
 				return err;
=20
-			err =3D flexcan_chip_enable(priv);
+			err =3D flexcan_chip_start(dev);
+			if (err)
+				return err;
 		}
 	}
=20
-	return err;
+	return 0;
 }
=20
 static int __maybe_unused flexcan_runtime_suspend(struct device *device)
--=20
2.17.1
