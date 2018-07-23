From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 11/12] can: xilinx_can: fix incorrect clear of non-processed interrupts
Date: Mon, 23 Jul 2018 14:58:42 +0200
Message-ID: <20180723125843.391-12-mkl@pengutronix.de>
References: <20180723125843.391-1-mkl@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180723125843.391-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Anssi Hannula <anssi.hannula@bitwise.fi>, Michal Simek <michal.simek@xilinx.com>, stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Anssi Hannula <anssi.hannula@bitwise.fi>

xcan_interrupt() clears ERROR|RXOFLV|BSOFF|ARBLST interrupts if any of
them is asserted. This does not take into account that some of them
could have been asserted between interrupt status read and interrupt
clear, therefore clearing them without handling them.

Fix the code to only clear those interrupts that it knows are asserted
and therefore going to be processed in xcan_err_interrupt().

Fixes: b1201e44f50b ("can: xilinx CAN controller support")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/xilinx_can.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index ea9f9d1a5ba7..cb80a9aa7281 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -938,6 +938,7 @@ static irqreturn_t xcan_interrupt(int irq, void *dev_id)
 	struct net_device *ndev = (struct net_device *)dev_id;
 	struct xcan_priv *priv = netdev_priv(ndev);
 	u32 isr, ier;
+	u32 isr_errors;
 
 	/* Get the interrupt status from Xilinx CAN */
 	isr = priv->read_reg(priv, XCAN_ISR_OFFSET);
@@ -956,11 +957,10 @@ static irqreturn_t xcan_interrupt(int irq, void *dev_id)
 		xcan_tx_interrupt(ndev, isr);
 
 	/* Check for the type of error interrupt and Processing it */
-	if (isr & (XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
-			XCAN_IXR_BSOFF_MASK | XCAN_IXR_ARBLST_MASK)) {
-		priv->write_reg(priv, XCAN_ICR_OFFSET, (XCAN_IXR_ERROR_MASK |
-				XCAN_IXR_RXOFLW_MASK | XCAN_IXR_BSOFF_MASK |
-				XCAN_IXR_ARBLST_MASK));
+	isr_errors = isr & (XCAN_IXR_ERROR_MASK | XCAN_IXR_RXOFLW_MASK |
+			    XCAN_IXR_BSOFF_MASK | XCAN_IXR_ARBLST_MASK);
+	if (isr_errors) {
+		priv->write_reg(priv, XCAN_ICR_OFFSET, isr_errors);
 		xcan_err_interrupt(ndev, isr);
 	}
 
-- 
2.18.0
