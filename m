From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 06/12] can: xilinx_can: fix device dropping off bus on RX overrun
Date: Mon, 23 Jul 2018 14:58:37 +0200
Message-ID: <20180723125843.391-7-mkl@pengutronix.de>
References: <20180723125843.391-1-mkl@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180723125843.391-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Anssi Hannula <anssi.hannula@bitwise.fi>, stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Anssi Hannula <anssi.hannula@bitwise.fi>

The xilinx_can driver performs a software reset when an RX overrun is
detected. This causes the device to enter Configuration mode where no
messages are received or transmitted.

The documentation does not mention any need to perform a reset on an RX
overrun, and testing by inducing an RX overflow also indicated that the
device continues to work just fine without a reset.

Remove the software reset.

Tested with the integrated CAN on Zynq-7000 SoC.

Fixes: b1201e44f50b ("can: xilinx CAN controller support")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/xilinx_can.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 89aec07c225f..389a9603db8c 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -600,7 +600,6 @@ static void xcan_err_interrupt(struct net_device *ndev, u32 isr)
 	if (isr & XCAN_IXR_RXOFLW_MASK) {
 		stats->rx_over_errors++;
 		stats->rx_errors++;
-		priv->write_reg(priv, XCAN_SRR_OFFSET, XCAN_SRR_RESET_MASK);
 		if (skb) {
 			cf->can_id |= CAN_ERR_CRTL;
 			cf->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
-- 
2.18.0
