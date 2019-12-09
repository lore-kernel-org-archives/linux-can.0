From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 05/13] can: xilinx_can: Fix missing Rx can packets on CANFD2.0
Date: Mon,  9 Dec 2019 17:32:48 +0100
Message-ID: <20191209163256.12000-6-mkl@pengutronix.de>
References: <20191209163256.12000-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191209163256.12000-1-mkl@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Srinivas Neeli <srinivas.neeli@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Srinivas Neeli <srinivas.neeli@xilinx.com>

CANFD2.0 core uses BRAM for storing acceptance filter ID(AFID) and MASK
(AFMASK)registers. So by default AFID and AFMASK registers contain random
data. Due to random data, we are not able to receive all CAN ids.

Initializing AFID and AFMASK registers with Zero before enabling
acceptance filter to receive all packets irrespective of ID and Mask.

Fixes: 0db9071353a0 ("can: xilinx: add can 2.0 support")
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
Reviewed-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc: linux-stable <stable@vger.kernel.org> # >= v5.0
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/xilinx_can.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 464af939cd8a..c1dbab8c896d 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -60,6 +60,8 @@ enum xcan_reg {
 	XCAN_TXMSG_BASE_OFFSET	= 0x0100, /* TX Message Space */
 	XCAN_RXMSG_BASE_OFFSET	= 0x1100, /* RX Message Space */
 	XCAN_RXMSG_2_BASE_OFFSET	= 0x2100, /* RX Message Space */
+	XCAN_AFR_2_MASK_OFFSET	= 0x0A00, /* Acceptance Filter MASK */
+	XCAN_AFR_2_ID_OFFSET	= 0x0A04, /* Acceptance Filter ID */
 };
 
 #define XCAN_FRAME_ID_OFFSET(frame_base)	((frame_base) + 0x00)
@@ -1809,6 +1811,11 @@ static int xcan_probe(struct platform_device *pdev)
 
 	pm_runtime_put(&pdev->dev);
 
+	if (priv->devtype.flags & XCAN_FLAG_CANFD_2) {
+		priv->write_reg(priv, XCAN_AFR_2_ID_OFFSET, 0x00000000);
+		priv->write_reg(priv, XCAN_AFR_2_MASK_OFFSET, 0x00000000);
+	}
+
 	netdev_dbg(ndev, "reg_base=0x%p irq=%d clock=%d, tx buffers: actual %d, using %d\n",
 		   priv->reg_base, ndev->irq, priv->can.clock.freq,
 		   hw_tx_max, priv->tx_max);
-- 
2.24.0
