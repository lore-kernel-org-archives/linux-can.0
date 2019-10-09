From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V4 1/2] can: flexcan: fix deadlock when using self wakeup
Date: Wed, 9 Oct 2019 08:13:04 +0000
Message-ID: <20191009080956.29128-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sean@geanix.com" <sean@geanix.com>, dl-linux-imx <linux-imx@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

As reproted by Sean Nyekjaer below:
When suspending, when there is still can traffic on the interfaces the
flexcan immediately wakes the platform again. As it should :-). But it
throws this error msg:
[ 3169.378661] PM: noirq suspend of devices failed

On the way down to suspend the interface that throws the error message does
call flexcan_suspend but fails to call flexcan_noirq_suspend. That means th=
e
flexcan_enter_stop_mode is called, but on the way out of suspend the driver
only calls flexcan_resume and skips flexcan_noirq_resume, thus it doesn't c=
all
flexcan_exit_stop_mode. This leaves the flexcan in stop mode, and with the
current driver it can't recover from this even with a soft reboot, it requi=
res
a hard reboot.

The best way to exit stop mode is in Wake Up interrupt context, and then
suspend() and resume() functions can be symmetric. However, stop mode
request and ack will be controlled by SCU(System Control Unit) firmware(man=
age
clock,power,stop mode, etc. by Cortex-M4 core) in coming i.MX8(QM/QXP). And=
 SCU
firmware interface can't be available in interrupt context.

For compatibillity, the wake up mechanism can't be symmetric, so we need
in_stop_mode hack.

Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
Reported-by: Sean Nyekjaer <sean@geanix.com>
Tested-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

Changelog:
V1->V2:
	* add Reported-by tag.
	* rebase on patch: can:flexcan:fix stop mode acknowledgment.
V2->V3:
	* rebase on linux-can/testing.
	* change into patch set.
V3->V4:
	* add Tested-by tag.
---
 drivers/net/can/flexcan.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 1cd5179cb876..24cc386c4bce 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -286,6 +286,7 @@ struct flexcan_priv {
 	const struct flexcan_devtype_data *devtype_data;
 	struct regulator *reg_xceiver;
 	struct flexcan_stop_mode stm;
+	bool in_stop_mode;
=20
 	/* Read and Write APIs */
 	u32 (*read)(void __iomem *addr);
@@ -1670,6 +1671,8 @@ static int __maybe_unused flexcan_suspend(struct devi=
ce *device)
 			err =3D flexcan_enter_stop_mode(priv);
 			if (err)
 				return err;
+
+			priv->in_stop_mode =3D true;
 		} else {
 			err =3D flexcan_chip_disable(priv);
 			if (err)
@@ -1696,6 +1699,15 @@ static int __maybe_unused flexcan_resume(struct devi=
ce *device)
 		netif_device_attach(dev);
 		netif_start_queue(dev);
 		if (device_may_wakeup(device)) {
+			if (priv->in_stop_mode) {
+				flexcan_enable_wakeup_irq(priv, false);
+				err =3D flexcan_exit_stop_mode(priv);
+				if (err)
+					return err;
+
+				priv->in_stop_mode =3D false;
+			}
+
 			disable_irq_wake(dev->irq);
 		} else {
 			err =3D pm_runtime_force_resume(device);
@@ -1732,6 +1744,11 @@ static int __maybe_unused flexcan_noirq_suspend(stru=
ct device *device)
 	struct net_device *dev =3D dev_get_drvdata(device);
 	struct flexcan_priv *priv =3D netdev_priv(dev);
=20
+	/* Need to enable wakeup interrupt in noirq suspend stage. Otherwise,
+	 * it will trigger continuously wakeup interrupt if the wakeup event
+	 * comes before noirq suspend stage, and simultaneously it has enter
+	 * the stop mode.
+	 */
 	if (netif_running(dev) && device_may_wakeup(device))
 		flexcan_enable_wakeup_irq(priv, true);
=20
@@ -1744,11 +1761,17 @@ static int __maybe_unused flexcan_noirq_resume(stru=
ct device *device)
 	struct flexcan_priv *priv =3D netdev_priv(dev);
 	int err;
=20
+	/* Need to exit stop mode in noirq resume stage. Otherwise, it will
+	 * trigger continuously wakeup interrupt if the wakeup event comes,
+	 * and simultaneously it has still in stop mode.
+	 */
 	if (netif_running(dev) && device_may_wakeup(device)) {
 		flexcan_enable_wakeup_irq(priv, false);
 		err =3D flexcan_exit_stop_mode(priv);
 		if (err)
 			return err;
+
+		priv->in_stop_mode =3D false;
 	}
=20
 	return 0;
--=20
2.17.1
