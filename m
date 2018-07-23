From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 10/12] can: xilinx_can: fix RX overflow interrupt not being enabled
Date: Mon, 23 Jul 2018 14:58:41 +0200
Message-ID: <20180723125843.391-11-mkl@pengutronix.de>
References: <20180723125843.391-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180723125843.391-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Anssi Hannula <anssi.hannula@bitwise.fi>, Michal Simek <michal.simek@xilinx.com>, stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Anssi Hannula <anssi.hannula@bitwise.fi>

RX overflow interrupt (RXOFLW) is disabled even though xcan_interrupt()
processes it. This means that an RX overflow interrupt will only be
processed when another interrupt gets asserted (e.g. for RX/TX).

Fix that by enabling the RXOFLW interrupt.

Fixes: b1201e44f50b ("can: xilinx CAN controller support")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/xilinx_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index dcbdc3cd651c..ea9f9d1a5ba7 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -104,7 +104,7 @@ enum xcan_reg {
 #define XCAN_INTR_ALL		(XCAN_IXR_TXOK_MASK | XCAN_IXR_BSOFF_MASK |\
 				 XCAN_IXR_WKUP_MASK | XCAN_IXR_SLP_MASK | \
 				 XCAN_IXR_RXNEMP_MASK | XCAN_IXR_ERROR_MASK | \
-				 XCAN_IXR_ARBLST_MASK)
+				 XCAN_IXR_RXOFLW_MASK | XCAN_IXR_ARBLST_MASK)
 
 /* CAN register bit shift - XCAN_<REG>_<BIT>_SHIFT */
 #define XCAN_BTR_SJW_SHIFT		7  /* Synchronous jump width */
-- 
2.18.0
