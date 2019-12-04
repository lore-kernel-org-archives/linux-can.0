From: Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V3 2/6] can: flexcan: Ack wakeup interrupt separately
Date: Wed, 4 Dec 2019 11:36:08 +0000
Message-ID: <20191204113249.3381-3-qiangqing.zhang@nxp.com>
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

As FLEXCAN_ESR_ALL_INT is for all bus errors and state change IRQ
sources, and FLEXCAN_ESR_WAK_INT does not belong to these. So add
wakeup interrupt ack separately to existing ack of the interrupts.

Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
------
ChangeLog:
	V3: *split from the patch
	     can: flexcan: fix deadlock when using self wakeup
---
 drivers/net/can/flexcan.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 99aae90c1cdd..1b33936790b4 100644
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
@@ -960,10 +959,10 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
=20
 	reg_esr =3D priv->read(&regs->esr);
=20
-	/* ACK all bus error and state change IRQ sources */
-	if (reg_esr & FLEXCAN_ESR_ALL_INT) {
+	/* ACK all bus error, state change and wake IRQ sources */
+	if (reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT)) {
 		handled =3D IRQ_HANDLED;
-		priv->write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
+		priv->write(reg_esr & (FLEXCAN_ESR_ALL_INT | FLEXCAN_ESR_WAK_INT), &regs=
->esr);
 	}
=20
 	/* state change interrupt or broken error state quirk fix is enabled */
--=20
2.17.1
