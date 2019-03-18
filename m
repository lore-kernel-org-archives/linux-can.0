From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH 3/6] net: can: xilinx_can: Add cantype parameter in xcan_devtype_data struct
Date: Mon, 18 Mar 2019 17:02:43 +0530
Message-ID: <1552908766-26753-4-git-send-email-appana.durga.rao@xilinx.com>
References: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, michal.simek@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
List-Id: linux-can.vger.kernel.org

To differentiate between different CAN IP's this patch adds
cantype enum variable in the xcan_devtype_data structure

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
 drivers/net/can/xilinx_can.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 22569ef..b45ece9 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -157,7 +157,15 @@ enum xcan_reg {
 #define XCAN_FLAG_RX_FIFO_MULTI	0x0010
 #define XCAN_FLAG_CANFD_2	0x0020
 
+enum xcan_ip_type {
+	XAXI_CAN = 0,
+	XZYNQ_CANPS,
+	XAXI_CANFD,
+	XAXI_CANFD_2_0,
+};
+
 struct xcan_devtype_data {
+	enum xcan_ip_type cantype;
 	unsigned int flags;
 	const struct can_bittiming_const *bittiming_const;
 	const char *bus_clk_name;
@@ -1428,6 +1436,7 @@ static const struct dev_pm_ops xcan_dev_pm_ops = {
 };
 
 static const struct xcan_devtype_data xcan_zynq_data = {
+	.cantype = XZYNQ_CANPS,
 	.flags = XCAN_FLAG_TXFEMP,
 	.bittiming_const = &xcan_bittiming_const,
 	.btr_ts2_shift = XCAN_BTR_TS2_SHIFT,
@@ -1436,6 +1445,7 @@ static const struct xcan_devtype_data xcan_zynq_data = {
 };
 
 static const struct xcan_devtype_data xcan_axi_data = {
+	.cantype = XAXI_CAN,
 	.flags = XCAN_FLAG_TXFEMP,
 	.bittiming_const = &xcan_bittiming_const,
 	.btr_ts2_shift = XCAN_BTR_TS2_SHIFT,
@@ -1444,6 +1454,7 @@ static const struct xcan_devtype_data xcan_axi_data = {
 };
 
 static const struct xcan_devtype_data xcan_canfd_data = {
+	.cantype = XAXI_CANFD,
 	.flags = XCAN_FLAG_EXT_FILTERS |
 		 XCAN_FLAG_RXMNF |
 		 XCAN_FLAG_TX_MAILBOXES |
@@ -1455,6 +1466,7 @@ static const struct xcan_devtype_data xcan_canfd_data = {
 };
 
 static const struct xcan_devtype_data xcan_canfd2_data = {
+	.cantype = XAXI_CANFD_2_0,
 	.flags = XCAN_FLAG_EXT_FILTERS |
 		 XCAN_FLAG_RXMNF |
 		 XCAN_FLAG_TX_MAILBOXES |
-- 
2.7.4
