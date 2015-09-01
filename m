From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 08/12] can: flexcan: enable interrupts atomically at the end of flexcan_chip_start()
Date: Tue,  1 Sep 2015 11:29:11 +0200
Message-ID: <1441099755-8601-9-git-send-email-mkl@pengutronix.de>
References: <1441099755-8601-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51375 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755363AbbIAJ3T (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Sep 2015 05:29:19 -0400
In-Reply-To: <1441099755-8601-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

This patch defers the writing of the interrupts bits of the CTRL register order
to enables all interrupts atomically at the the of the flexcan_chip_start()
function.

Suggested-by: Torsten Lang <torsten.lang@uweschneider.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 28b6283aacf2..868fe945e35a 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -878,6 +878,8 @@ static int flexcan_chip_start(struct net_device *dev)
 
 	/* save for later use */
 	priv->reg_ctrl_default = reg_ctrl;
+	/* leave interrupts disabled for now */
+	reg_ctrl &= ~FLEXCAN_CTRL_ERR_ALL;
 	netdev_dbg(dev, "%s: writing ctrl=0x%08x", __func__, reg_ctrl);
 	flexcan_write(reg_ctrl, &regs->ctrl);
 
@@ -937,8 +939,11 @@ static int flexcan_chip_start(struct net_device *dev)
 
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
-	/* enable FIFO interrupts */
+	/* enable interrupts atomically */
+	disable_irq(dev->irq);
+	flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
 	flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
+	enable_irq(dev->irq);
 
 	/* print chip status */
 	netdev_dbg(dev, "%s: reading mcr=0x%08x ctrl=0x%08x\n", __func__,
-- 
2.5.0

