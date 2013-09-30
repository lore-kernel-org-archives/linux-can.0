From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: flexcan: fix flexcan_chip_start() on imx6
Date: Mon, 30 Sep 2013 13:25:20 +0200
Message-ID: <1380540320-20055-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41377 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373Ab3I3L1Z (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 30 Sep 2013 07:27:25 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, neko@bakuhatsu.net, Marc Kleine-Budde <mkl@pengutronix.de>

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

Reported-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Waiting-for-Tested-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 71c677e..3f21142 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -702,7 +702,6 @@ static int flexcan_chip_start(struct net_device *de=
v)
 {
 	struct flexcan_priv *priv =3D netdev_priv(dev);
 	struct flexcan_regs __iomem *regs =3D priv->base;
-	unsigned int i;
 	int err;
 	u32 reg_mcr, reg_ctrl;
=20
@@ -772,17 +771,6 @@ static int flexcan_chip_start(struct net_device *d=
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
 	/* acceptance mask/acceptance code (accept everything) */
 	flexcan_write(0x0, &regs->rxgmask);
 	flexcan_write(0x0, &regs->rx14mask);
--=20
1.8.4.rc3

