From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V3 3/6] can: flexcan: add low power enter/exit acknowledgment
 helper
Date: Wed, 4 Dec 2019 11:36:11 +0000
Message-ID: <20191204113249.3381-4-qiangqing.zhang@nxp.com>
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

MCR[LPMACK] this read-only bit indicates that FlexCAN is in a
lower-power mode (Disabled mode, Doze mode, Stop mode), CPU can poll
this bit to know when FlexCAN has actually entered low power mode.
Low power enter/exit acknowledgment helper will reduce code duplication
for disabled mode, doze mode and stop mode.

Tested-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
-----
ChangeLog:
	V3: * split from patch
	      can: flexcan: change the way of stop mode acknowledgment
---
 drivers/net/can/flexcan.c | 46 +++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 1b33936790b4..6c4f1bab7042 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -388,6 +388,34 @@ static struct flexcan_mb __iomem *flexcan_get_mb(const=
 struct flexcan_priv *priv
 		(&priv->regs->mb[bank][priv->mb_size * mb_index]);
 }
=20
+static int flexcan_low_power_enter_ack(struct flexcan_priv *priv)
+{
+	struct flexcan_regs __iomem *regs =3D priv->regs;
+	unsigned int timeout =3D FLEXCAN_TIMEOUT_US / 10;
+
+	while (timeout-- && !(priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
+		udelay(10);
+
+	if (!(priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int flexcan_low_power_exit_ack(struct flexcan_priv *priv)
+{
+	struct flexcan_regs __iomem *regs =3D priv->regs;
+	unsigned int timeout =3D FLEXCAN_TIMEOUT_US / 10;
+
+	while (timeout-- && (priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
+		udelay(10);
+
+	if (priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
 static void flexcan_enable_wakeup_irq(struct flexcan_priv *priv, bool enab=
le)
 {
 	struct flexcan_regs __iomem *regs =3D priv->regs;
@@ -505,39 +533,25 @@ static inline int flexcan_transceiver_disable(const s=
truct flexcan_priv *priv)
 static int flexcan_chip_enable(struct flexcan_priv *priv)
 {
 	struct flexcan_regs __iomem *regs =3D priv->regs;
-	unsigned int timeout =3D FLEXCAN_TIMEOUT_US / 10;
 	u32 reg;
=20
 	reg =3D priv->read(&regs->mcr);
 	reg &=3D ~FLEXCAN_MCR_MDIS;
 	priv->write(reg, &regs->mcr);
=20
-	while (timeout-- && (priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
-		udelay(10);
-
-	if (priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK)
-		return -ETIMEDOUT;
-
-	return 0;
+	return flexcan_low_power_exit_ack(priv);
 }
=20
 static int flexcan_chip_disable(struct flexcan_priv *priv)
 {
 	struct flexcan_regs __iomem *regs =3D priv->regs;
-	unsigned int timeout =3D FLEXCAN_TIMEOUT_US / 10;
 	u32 reg;
=20
 	reg =3D priv->read(&regs->mcr);
 	reg |=3D FLEXCAN_MCR_MDIS;
 	priv->write(reg, &regs->mcr);
=20
-	while (timeout-- && !(priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
-		udelay(10);
-
-	if (!(priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
-		return -ETIMEDOUT;
-
-	return 0;
+	return flexcan_low_power_enter_ack(priv);
 }
=20
 static int flexcan_chip_freeze(struct flexcan_priv *priv)
--=20
2.17.1
