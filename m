From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/7] can: flexcan: fix shutdown: first disable chip, then all interrupts
Date: Fri, 28 Feb 2014 23:06:23 +0100
Message-ID: <1393625189-5568-2-git-send-email-mkl@pengutronix.de>
References: <1393625189-5568-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43108 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbaB1WGd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Feb 2014 17:06:33 -0500
In-Reply-To: <1393625189-5568-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

When shutting down the CAN interface (ifconfig canX down) during high CAN bus
loads, the CAN core might hang and freeze the whole CPU.

This patch fixes the shutdown sequence by first disabling the CAN core then
disabling all interrupts.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 320bef2..dcd69c9 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -827,14 +827,16 @@ static void flexcan_chip_stop(struct net_device *dev)
 	struct flexcan_regs __iomem *regs = priv->base;
 	u32 reg;
 
-	/* Disable all interrupts */
-	flexcan_write(0, &regs->imask1);
-
 	/* Disable + halt module */
 	reg = flexcan_read(&regs->mcr);
 	reg |= FLEXCAN_MCR_MDIS | FLEXCAN_MCR_HALT;
 	flexcan_write(reg, &regs->mcr);
 
+	/* Disable all interrupts */
+	flexcan_write(0, &regs->imask1);
+	flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
+		      &regs->ctrl);
+
 	if (priv->reg_xceiver)
 		regulator_disable(priv->reg_xceiver);
 	priv->can.state = CAN_STATE_STOPPED;
-- 
1.9.0.rc3

