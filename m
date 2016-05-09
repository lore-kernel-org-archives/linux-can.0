From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 03/10] can: flexcan: calculate default value for imask1 during runtime
Date: Mon,  9 May 2016 12:52:27 +0200
Message-ID: <1462791154-13375-4-git-send-email-mkl@pengutronix.de>
References: <1462791154-13375-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46983 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751426AbcEIKwo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 May 2016 06:52:44 -0400
In-Reply-To: <1462791154-13375-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

This patch converts the define FLEXCAN_IFLAG_DEFAULT into the runtime
calculated value priv->reg_imask1_default. This is a preparation patch to make
the TX mailbox selectable during runtime, too.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 41c0fc9f3b14..b377e1069bf8 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -149,9 +149,6 @@
 #define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW	BIT(7)
 #define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
 #define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
-#define FLEXCAN_IFLAG_DEFAULT \
-	(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW | FLEXCAN_IFLAG_RX_FIFO_AVAILABLE | \
-	 FLEXCAN_IFLAG_BUF(FLEXCAN_TX_BUF_ID))
 
 /* FLEXCAN message buffers */
 #define FLEXCAN_MB_CODE_RX_INACTIVE	(0x0 << 24)
@@ -254,6 +251,7 @@ struct flexcan_priv {
 	struct flexcan_regs __iomem *regs;
 	u32 reg_esr;
 	u32 reg_ctrl_default;
+	u32 reg_imask1_default;
 
 	struct clk *clk_ipg;
 	struct clk *clk_per;
@@ -705,7 +703,7 @@ static int flexcan_poll(struct napi_struct *napi, int quota)
 	if (work_done < quota) {
 		napi_complete(napi);
 		/* enable IRQs */
-		flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
+		flexcan_write(priv->reg_imask1_default, &regs->imask1);
 		flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
 	}
 
@@ -739,7 +737,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		 * save them for later use.
 		 */
 		priv->reg_esr = reg_esr & FLEXCAN_ESR_ERR_BUS;
-		flexcan_write(FLEXCAN_IFLAG_DEFAULT &
+		flexcan_write(priv->reg_imask1_default &
 			      ~FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->imask1);
 		flexcan_write(priv->reg_ctrl_default & ~FLEXCAN_CTRL_ERR_ALL,
 			      &regs->ctrl);
@@ -942,7 +940,7 @@ static int flexcan_chip_start(struct net_device *dev)
 	/* enable interrupts atomically */
 	disable_irq(dev->irq);
 	flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
-	flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
+	flexcan_write(priv->reg_imask1_default, &regs->imask1);
 	enable_irq(dev->irq);
 
 	/* print chip status */
@@ -1227,6 +1225,10 @@ static int flexcan_probe(struct platform_device *pdev)
 	priv->devtype_data = devtype_data;
 	priv->reg_xceiver = reg_xceiver;
 
+	priv->reg_imask1_default = FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
+		FLEXCAN_IFLAG_RX_FIFO_AVAILABLE |
+		FLEXCAN_IFLAG_BUF(FLEXCAN_TX_BUF_ID);
+
 	netif_napi_add(dev, &priv->napi, flexcan_poll, FLEXCAN_NAPI_WEIGHT);
 
 	platform_set_drvdata(pdev, dev);
-- 
2.8.1

