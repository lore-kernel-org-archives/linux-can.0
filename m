From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: flexcan: fix flexcan_chip_start() on imx6
Date: Fri, 29 Nov 2013 23:43:52 +0100
Message-ID: <1385765032-23630-2-git-send-email-mkl@pengutronix.de>
References: <1385765032-23630-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1385765032-23630-1-git-send-email-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Belser Florian <Florian.Belser@sensor-technik.de>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

commit 0d1862ea1a5bb876cf05555a7307080cb75bf379 upstream.

In the flexcan_chip_start() function first the flexcan core is going th=
rough
the soft reset sequence, then the RX FIFO is enabled.

With the hardware is put into FIFO mode, message buffers 1...7 are rese=
rved by
the FIFO engine. The remaining message buffers are in reset default val=
ues.
This patch removes the bogus initialization of the message buffers, as =
it
causes an imprecise external abort on imx6.

Cc: linux-stable <stable@vger.kernel.org>
Reported-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Tested-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[mkl: adjusted context for stable]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index a8f33a5..f63169d 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -711,7 +711,6 @@ static int flexcan_chip_start(struct net_device *de=
v)
 {
 	struct flexcan_priv *priv =3D netdev_priv(dev);
 	struct flexcan_regs __iomem *regs =3D priv->base;
-	unsigned int i;
 	int err;
 	u32 reg_mcr, reg_ctrl;
=20
@@ -783,17 +782,6 @@ static int flexcan_chip_start(struct net_device *d=
ev)
 	netdev_dbg(dev, "%s: writing ctrl=3D0x%08x", __func__, reg_ctrl);
 	flexcan_write(reg_ctrl, &regs->ctrl);
=20
-	for (i =3D 0; i < ARRAY_SIZE(regs->cantxfg); i++) {
-		flexcan_write(0, &regs->cantxfg[i].can_ctrl);
-		flexcan_write(0, &regs->cantxfg[i].can_id);
-		flexcan_write(0, &regs->cantxfg[i].data[0]);
-		flexcan_write(0, &regs->cantxfg[i].data[1]);
-
-		/* put MB into rx queue */
-		flexcan_write(FLEXCAN_MB_CNT_CODE(0x4),
-			&regs->cantxfg[i].can_ctrl);
-	}
-
 	/* Abort any pending TX, mark Mailbox as INACTIVE */
 	flexcan_write(FLEXCAN_MB_CNT_CODE(0x4),
 		      &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
--=20
1.8.5.rc0
