From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 11/29] can: xilinx_can: Fix flags field initialization for axi can
Date: Thu, 10 Oct 2019 14:17:32 +0200
Message-ID: <20191010121750.27237-12-mkl@pengutronix.de>
References: <20191010121750.27237-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191010121750.27237-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc: davem@davemloft.net, kernel@pengutronix.de, jhofstee@victronenergy.com, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, Anssi Hannula <anssi.hannula@bitwise.fi>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>

AXI CANIP doesn't support tx fifo empty interrupt feature(TXFEMP),
update the flags filed in the driver for AXI CAN case accordingly.

Fixes: 3281b380ec9f ("can: xilinx_can: Fix flags field initialization for axi can and canps")
Reported-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/xilinx_can.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 911b34316c9d..7c482b2d78d2 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1599,7 +1599,6 @@ static const struct xcan_devtype_data xcan_zynq_data = {
 
 static const struct xcan_devtype_data xcan_axi_data = {
 	.cantype = XAXI_CAN,
-	.flags = XCAN_FLAG_TXFEMP,
 	.bittiming_const = &xcan_bittiming_const,
 	.btr_ts2_shift = XCAN_BTR_TS2_SHIFT,
 	.btr_sjw_shift = XCAN_BTR_SJW_SHIFT,
-- 
2.23.0
