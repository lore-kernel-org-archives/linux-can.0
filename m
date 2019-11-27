From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V2 1/4] can: flexcan: fix deadlock when using self wakeup
Date: Wed, 27 Nov 2019 05:56:45 +0000
Message-ID: <20191127055334.1476-2-qiangqing.zhang@nxp.com>
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

From: Sean Nyekjaer <sean@geanix.com>

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

This patch can fix deadlock when using self wakeup, it happenes to be
able to fix another issue that frames out-of-order in first IRQ handler
run after wakeup.

In wakeup case, after system resume, frames received out-of-order in
first IRQ handler, the problem is wakeup latency from frame reception to
IRQ handler is much bigger than the counter overflow. This means it's
impossible to sort the CAN frames by timestamp. The reason is that controll=
er
exits stop mode during noirq resume, then it can receive the frame immediat=
ely.
If noirq reusme stage consumes much time, it will extend interrupt response
time. So exit stop mode during resume stage instead of noirq resume can
fix this issue.

Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
------
ChangeLog:
	V1->V2: no change.
---
 drivers/net/can/flexcan.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 2efa06119f68..2297663cacb2 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -134,8 +134,7 @@
 	(FLEXCAN_ESR_ERR_BUS | FLEXCAN_ESR_ERR_STATE)
 #define FLEXCAN_ESR_ALL_INT \
 	(FLEXCAN_ESR_TWRN_INT | FLEXCAN_ESR_RWRN_INT | \
-	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
-	 FLEXCAN_ESR_WAK_INT)
+	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
=20
 /* FLEXCAN interrupt flag register (IFLAG) bits */
 /* Errata ERR005829 step7: Reserve first valid MB */
@@ -960,6 +959,12 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
=20
 	reg_esr =3D priv->read(&regs->esr);
=20
+	/* ACK wakeup interrupt */
+	if (reg_esr & FLEXCAN_ESR_WAK_INT) {
+		handled =3D IRQ_HANDLED;
+		priv->write(reg_esr & FLEXCAN_ESR_WAK_INT, &regs->esr);
+	}
+
 	/* ACK all bus error and state change IRQ sources */
 	if (reg_esr & FLEXCAN_ESR_ALL_INT) {
 		handled =3D IRQ_HANDLED;
@@ -1722,6 +1727,9 @@ static int __maybe_unused flexcan_resume(struct devic=
e *device)
 		netif_start_queue(dev);
 		if (device_may_wakeup(device)) {
 			disable_irq_wake(dev->irq);
+			err =3D flexcan_exit_stop_mode(priv);
+			if (err)
+				return err;
 		} else {
 			err =3D pm_runtime_force_resume(device);
 			if (err)
@@ -1767,14 +1775,9 @@ static int __maybe_unused flexcan_noirq_resume(struc=
t device *device)
 {
 	struct net_device *dev =3D dev_get_drvdata(device);
 	struct flexcan_priv *priv =3D netdev_priv(dev);
-	int err;
=20
-	if (netif_running(dev) && device_may_wakeup(device)) {
+	if (netif_running(dev) && device_may_wakeup(device))
 		flexcan_enable_wakeup_irq(priv, false);
-		err =3D flexcan_exit_stop_mode(priv);
-		if (err)
-			return err;
-	}
=20
 	return 0;
 }
--=20
2.17.1
