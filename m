From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH 2/6] net: can: xilinx_can: Fix flags field initialization for axi can and canps
Date: Mon, 18 Mar 2019 17:02:42 +0530
Message-ID: <1552908766-26753-3-git-send-email-appana.durga.rao@xilinx.com>
References: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, michal.simek@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
List-Id: linux-can.vger.kernel.org

AXI CAN IP and CANPS IP supports tx fifo empty feature, this patch updates
the flags field for the same.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
 drivers/net/can/xilinx_can.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 2de51ac..22569ef 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1428,6 +1428,7 @@ static const struct dev_pm_ops xcan_dev_pm_ops = {
 };
 
 static const struct xcan_devtype_data xcan_zynq_data = {
+	.flags = XCAN_FLAG_TXFEMP,
 	.bittiming_const = &xcan_bittiming_const,
 	.btr_ts2_shift = XCAN_BTR_TS2_SHIFT,
 	.btr_sjw_shift = XCAN_BTR_SJW_SHIFT,
@@ -1435,6 +1436,7 @@ static const struct xcan_devtype_data xcan_zynq_data = {
 };
 
 static const struct xcan_devtype_data xcan_axi_data = {
+	.flags = XCAN_FLAG_TXFEMP,
 	.bittiming_const = &xcan_bittiming_const,
 	.btr_ts2_shift = XCAN_BTR_TS2_SHIFT,
 	.btr_sjw_shift = XCAN_BTR_SJW_SHIFT,
-- 
2.7.4
