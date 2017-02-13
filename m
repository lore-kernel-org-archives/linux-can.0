From: Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: [PATCH 1/5] can: xilinx_can: fix device dropping off bus on RX overrun
Date: Mon, 13 Feb 2017 15:12:04 +0200
Message-ID: <20170213131208.20227-2-anssi.hannula@bitwise.fi>
References: <20170213131208.20227-1-anssi.hannula@bitwise.fi>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170213131208.20227-1-anssi.hannula@bitwise.fi>
Sender: stable-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Kedareswara rao Appana <appanad@xilinx.com>, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

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
---
 drivers/net/can/xilinx_can.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index c71a035..ddb3287 100644
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
2.8.3
