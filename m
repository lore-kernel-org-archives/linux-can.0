From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 2/2] can: flexcan: disable clocks during stop mode
Date: Tue, 10 Dec 2019 07:16:00 +0000
Message-ID: <20191210071252.26165-2-qiangqing.zhang@nxp.com>
References: <20191210071252.26165-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191210071252.26165-1-qiangqing.zhang@nxp.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "sean@geanix.com" <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

Disable clocks during CAN in stop mode.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
---
 drivers/net/can/flexcan.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 6c1ccf9f6c08..d767f85c80d3 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1786,10 +1786,16 @@ static int __maybe_unused flexcan_noirq_suspend(str=
uct device *device)
 {
 	struct net_device *dev =3D dev_get_drvdata(device);
 	struct flexcan_priv *priv =3D netdev_priv(dev);
+	int err;
=20
-	if (netif_running(dev) && device_may_wakeup(device))
+	if (netif_running(dev) && device_may_wakeup(device)) {
 		flexcan_enable_wakeup_irq(priv, true);
=20
+		err =3D pm_runtime_force_suspend(device);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
=20
@@ -1800,7 +1806,12 @@ static int __maybe_unused flexcan_noirq_resume(struc=
t device *device)
 	int err;
=20
 	if (netif_running(dev) && device_may_wakeup(device)) {
+		err =3D pm_runtime_force_resume(device);
+		if (err)
+			return err;
+
 		flexcan_enable_wakeup_irq(priv, false);
+
 		err =3D flexcan_exit_stop_mode(priv);
 		if (err)
 			return err;
--=20
2.17.1
