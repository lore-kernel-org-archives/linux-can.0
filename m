From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/8] can: flexcan: reg_imask2_default
Date: Tue,  1 Sep 2015 12:31:58 +0200
Message-ID: <1441103522-15593-5-git-send-email-mkl@pengutronix.de>
References: <1441103522-15593-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55976 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755757AbbIAKcL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Sep 2015 06:32:11 -0400
In-Reply-To: <1441103522-15593-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 1e213fd24e63..97e8d4581868 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -265,6 +265,7 @@ struct flexcan_priv {
 	u32 poll_esr;			/* used in flexcan_poll_bus_err */
 	u32 reg_ctrl_default;
 	u32 reg_imask1_default;
+	u32 reg_imask2_default;
 
 	struct clk *clk_ipg;
 	struct clk *clk_per;
@@ -933,6 +934,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	disable_irq(dev->irq);
 	flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
 	flexcan_write(priv->reg_imask1_default, &regs->imask1);
+	flexcan_write(priv->reg_imask2_default, &regs->imask2);
 	enable_irq(dev->irq);
 
 	/* print chip status */
@@ -962,6 +964,7 @@ static void flexcan_chip_stop(struct net_device *dev)
 	flexcan_chip_disable(priv);
 
 	/* Disable all interrupts */
+	flexcan_write(0, &regs->imask2);
 	flexcan_write(0, &regs->imask1);
 	flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
 		      &regs->ctrl);
@@ -1224,6 +1227,7 @@ static int flexcan_probe(struct platform_device *pdev)
 	priv->reg_imask1_default = FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
 		FLEXCAN_IFLAG_RX_FIFO_AVAILABLE |
 		FLEXCAN_IFLAG_MB(priv->tx_mb_idx);
+	priv->reg_imask2_default = 0;
 
 	priv->fifo.poll_pre_read = flexcan_poll_state;
 	priv->fifo.poll_post_read = flexcan_poll_bus_err;
-- 
2.5.0

