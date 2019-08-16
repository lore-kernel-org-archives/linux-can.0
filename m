From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH REPOST 2/2] can: flexcan: add LPSR mode support for i.MX7D
Date: Fri, 16 Aug 2019 08:20:44 +0000
Message-ID: <20190816081749.19300-3-qiangqing.zhang@nxp.com>
References: <20190816081749.19300-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190816081749.19300-1-qiangqing.zhang@nxp.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "sean@geanix.com" <sean@geanix.com>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
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

ChangeLog:
V1->V2:
	* rebase on linux-can/testing.
	* move into a patch set.
---
 drivers/net/can/flexcan.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index de2bf71b335b..b3edaf6a5a61 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -25,6 +25,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/regmap.h>
=20
 #define DRV_NAME			"flexcan"
@@ -1640,9 +1641,9 @@ static int __maybe_unused flexcan_suspend(struct devi=
ce *device)
=20
 			priv->in_stop_mode =3D true;
 		} else {
-			err =3D flexcan_chip_disable(priv);
-			if (err)
-				return err;
+			flexcan_chip_stop(dev);
+
+			pinctrl_pm_select_sleep_state(device);
 		}
 		netif_stop_queue(dev);
 		netif_device_detach(dev);
@@ -1674,7 +1675,9 @@ static int __maybe_unused flexcan_resume(struct devic=
e *device)
=20
 			disable_irq_wake(dev->irq);
 		} else {
-			err =3D flexcan_chip_enable(priv);
+			pinctrl_pm_select_default_state(device);
+
+			err =3D flexcan_chip_start(dev);
 			if (err)
 				return err;
 		}
--=20
2.17.1
