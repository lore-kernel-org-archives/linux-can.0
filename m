From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: mscan: fix sparse warning
Date: Tue,  4 Mar 2014 21:11:29 +0100
Message-ID: <1393963889-1291-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36704 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755261AbaCDULh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Mar 2014 15:11:37 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

This patch fixes the following sparse warning by adding the missing __iomem
annotations and using proper {in,out}_8 to access the mscan register space.

drivers/net/can/mscan/mpc5xxx_can.c:385:36: warning: cast removes address space of expression
drivers/net/can/mscan/mpc5xxx_can.c:387:37: warning: incorrect type in argument 2 (different address spaces)
drivers/net/can/mscan/mpc5xxx_can.c:387:37:    expected void const volatile [noderef] <asn:2>*src
drivers/net/can/mscan/mpc5xxx_can.c:387:37:    got struct mscan_regs *regs
drivers/net/can/mscan/mpc5xxx_can.c:396:36: warning: cast removes address space of expression
drivers/net/can/mscan/mpc5xxx_can.c:408:23: warning: incorrect type in argument 1 (different address spaces)
drivers/net/can/mscan/mpc5xxx_can.c:408:23:    expected void volatile [noderef] <asn:2>*dest
drivers/net/can/mscan/mpc5xxx_can.c:408:23:    got unsigned short *<noident>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/mscan/mpc5xxx_can.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
index 4472529..80045a8 100644
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -382,7 +382,7 @@ static int mpc5xxx_can_suspend(struct platform_device *ofdev, pm_message_t state
 {
 	struct net_device *dev = platform_get_drvdata(ofdev);
 	struct mscan_priv *priv = netdev_priv(dev);
-	struct mscan_regs *regs = (struct mscan_regs *)priv->reg_base;
+	struct mscan_regs __iomem *regs = priv->reg_base;
 
 	_memcpy_fromio(&saved_regs, regs, sizeof(*regs));
 
@@ -393,26 +393,32 @@ static int mpc5xxx_can_resume(struct platform_device *ofdev)
 {
 	struct net_device *dev = platform_get_drvdata(ofdev);
 	struct mscan_priv *priv = netdev_priv(dev);
-	struct mscan_regs *regs = (struct mscan_regs *)priv->reg_base;
+	struct mscan_regs __iomem *regs = priv->reg_base;
+	u8 val;
 
-	regs->canctl0 |= MSCAN_INITRQ;
-	while (!(regs->canctl1 & MSCAN_INITAK))
+	val = in_8(&regs->canctl0);
+	val |= MSCAN_INITRQ;
+	out_8(&regs->canctl0, val);
+
+	while (!(in_8(&regs->canctl1) & MSCAN_INITAK))
 		udelay(10);
 
-	regs->canctl1 = saved_regs.canctl1;
-	regs->canbtr0 = saved_regs.canbtr0;
-	regs->canbtr1 = saved_regs.canbtr1;
-	regs->canidac = saved_regs.canidac;
+	out_8(&regs->canctl1, saved_regs.canctl1);
+	out_8(&regs->canbtr0, saved_regs.canbtr0);
+	out_8(&regs->canbtr1, saved_regs.canbtr1);
+	out_8(&regs->canidac, saved_regs.canidac);
 
 	/* restore masks, buffers etc. */
 	_memcpy_toio(&regs->canidar1_0, (void *)&saved_regs.canidar1_0,
 		     sizeof(*regs) - offsetof(struct mscan_regs, canidar1_0));
 
-	regs->canctl0 &= ~MSCAN_INITRQ;
-	regs->cantbsel = saved_regs.cantbsel;
-	regs->canrier = saved_regs.canrier;
-	regs->cantier = saved_regs.cantier;
-	regs->canctl0 = saved_regs.canctl0;
+	val = in_8(&regs->canctl0);
+	val &= ~MSCAN_INITRQ;
+	out_8(&regs->canctl0, val);
+	out_8(&regs->cantbsel, saved_regs.cantbsel);
+	out_8(&regs->canrier, saved_regs.canrier);
+	out_8(&regs->cantier, saved_regs.cantier);
+	out_8(&regs->canctl0, saved_regs.canctl0);
 
 	return 0;
 }
-- 
1.9.0

