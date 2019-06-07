From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 3/9] can: xilinx_can: use correct bittiming_const for CAN FD core
Date: Fri,  7 Jun 2019 23:15:35 +0200
Message-ID: <20190607211541.16095-4-mkl@pengutronix.de>
References: <20190607211541.16095-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190607211541.16095-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Anssi Hannula <anssi.hannula@bitwise.fi>, Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>, Michal Simek <michal.simek@xilinx.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Anssi Hannula <anssi.hannula@bitwise.fi>

Commit 9e5f1b273e6a ("can: xilinx_can: add support for Xilinx CAN FD
core") added a new can_bittiming_const structure for CAN FD cores that
support larger values for tseg1, tseg2, and sjw than previous Xilinx CAN
cores, but the commit did not actually take that into use.

Fix that.

Tested with CAN FD core on a ZynqMP board.

Fixes: 9e5f1b273e6a ("can: xilinx_can: add support for Xilinx CAN FD core")
Reported-by: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/xilinx_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index f2024404b8d6..63203ff452b5 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1435,7 +1435,7 @@ static const struct xcan_devtype_data xcan_canfd_data = {
 		 XCAN_FLAG_RXMNF |
 		 XCAN_FLAG_TX_MAILBOXES |
 		 XCAN_FLAG_RX_FIFO_MULTI,
-	.bittiming_const = &xcan_bittiming_const,
+	.bittiming_const = &xcan_bittiming_const_canfd,
 	.btr_ts2_shift = XCAN_BTR_TS2_SHIFT_CANFD,
 	.btr_sjw_shift = XCAN_BTR_SJW_SHIFT_CANFD,
 	.bus_clk_name = "s_axi_aclk",
-- 
2.20.1
