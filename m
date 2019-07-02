From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V4] can: flexcan: fix stop mode acknowledgment
Date: Tue, 2 Jul 2019 01:45:41 +0000
Message-ID: <20190702014316.26444-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

To enter stop mode, the CPU should manually assert a global Stop Mode
request and check the acknowledgment asserted by FlexCAN. The CPU must
only consider the FlexCAN in stop mode when both request and
acknowledgment conditions are satisfied.

Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

ChangeLog:
V1->V2:
	* regmap_read()-->regmap_read_poll_timeout()
V2->V3:
	* change the way of error return, it will make easy for function
	extension.
V3->V4:
	* rebase to linux-next/master, as this is a fix.
---
 drivers/net/can/flexcan.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 1c66fb2ad76b..bf1bd6f5dbb1 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -400,9 +400,10 @@ static void flexcan_enable_wakeup_irq(struct flexcan_p=
riv *priv, bool enable)
 	priv->write(reg_mcr, &regs->mcr);
 }
=20
-static inline void flexcan_enter_stop_mode(struct flexcan_priv *priv)
+static inline int flexcan_enter_stop_mode(struct flexcan_priv *priv)
 {
 	struct flexcan_regs __iomem *regs =3D priv->regs;
+	unsigned int ackval;
 	u32 reg_mcr;
=20
 	reg_mcr =3D priv->read(&regs->mcr);
@@ -412,20 +413,37 @@ static inline void flexcan_enter_stop_mode(struct fle=
xcan_priv *priv)
 	/* enable stop request */
 	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
 			   1 << priv->stm.req_bit, 1 << priv->stm.req_bit);
+
+	/* get stop acknowledgment */
+	if (regmap_read_poll_timeout(priv->stm.gpr, priv->stm.ack_gpr,
+				     ackval, ackval & (1 << priv->stm.ack_bit),
+				     0, FLEXCAN_TIMEOUT_US))
+		return -ETIMEDOUT;
+
+	return 0;
 }
=20
-static inline void flexcan_exit_stop_mode(struct flexcan_priv *priv)
+static inline int flexcan_exit_stop_mode(struct flexcan_priv *priv)
 {
 	struct flexcan_regs __iomem *regs =3D priv->regs;
+	unsigned int ackval;
 	u32 reg_mcr;
=20
 	/* remove stop request */
 	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
 			   1 << priv->stm.req_bit, 0);
=20
+	/* get stop acknowledgment */
+	if (regmap_read_poll_timeout(priv->stm.gpr, priv->stm.ack_gpr,
+				     ackval, !(ackval & (1 << priv->stm.ack_bit)),
+				     0, FLEXCAN_TIMEOUT_US))
+		return -ETIMEDOUT;
+
 	reg_mcr =3D priv->read(&regs->mcr);
 	reg_mcr &=3D ~FLEXCAN_MCR_SLF_WAK;
 	priv->write(reg_mcr, &regs->mcr);
+
+	return 0;
 }
=20
 static inline void flexcan_error_irq_enable(const struct flexcan_priv *pri=
v)
@@ -1615,7 +1633,9 @@ static int __maybe_unused flexcan_suspend(struct devi=
ce *device)
 		 */
 		if (device_may_wakeup(device)) {
 			enable_irq_wake(dev->irq);
-			flexcan_enter_stop_mode(priv);
+			err =3D flexcan_enter_stop_mode(priv);
+			if (err)
+				return err;
 		} else {
 			err =3D flexcan_chip_disable(priv);
 			if (err)
@@ -1665,10 +1685,13 @@ static int __maybe_unused flexcan_noirq_resume(stru=
ct device *device)
 {
 	struct net_device *dev =3D dev_get_drvdata(device);
 	struct flexcan_priv *priv =3D netdev_priv(dev);
+	int err;
=20
 	if (netif_running(dev) && device_may_wakeup(device)) {
 		flexcan_enable_wakeup_irq(priv, false);
-		flexcan_exit_stop_mode(priv);
+		err =3D flexcan_exit_stop_mode(priv);
+		if (err)
+			return err;
 	}
=20
 	return 0;
--=20
2.17.1
