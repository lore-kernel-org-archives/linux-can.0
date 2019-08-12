From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH v2 4/5] can: xilinx_can: Fix FSR register FL and RI mask values for canfd 2.0
Date: Mon, 12 Aug 2019 15:36:45 +0530
Message-ID: <1565604406-4920-5-git-send-email-appana.durga.rao@xilinx.com>
References: <1565604406-4920-1-git-send-email-appana.durga.rao@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565604406-4920-1-git-send-email-appana.durga.rao@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, michal.simek@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
List-Id: linux-can.vger.kernel.org

For CANFD 2.0 IP configuration existing driver is using incorrect mask
values for FSR register FL and RI fields.

Fixes: c223da6 ("can: xilinx_can: Add support for CANFD FD frames")
Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Acked-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/net/can/xilinx_can.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index c9b951b..4cb8c1c9 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -123,8 +123,10 @@ enum xcan_reg {
 #define XCAN_IDR_RTR_MASK		0x00000001 /* Remote TX request */
 #define XCAN_DLCR_DLC_MASK		0xF0000000 /* Data length code */
 #define XCAN_FSR_FL_MASK		0x00003F00 /* RX Fill Level */
+#define XCAN_2_FSR_FL_MASK		0x00007F00 /* RX Fill Level */
 #define XCAN_FSR_IRI_MASK		0x00000080 /* RX Increment Read Index */
 #define XCAN_FSR_RI_MASK		0x0000001F /* RX Read Index */
+#define XCAN_2_FSR_RI_MASK		0x0000003F /* RX Read Index */
 #define XCAN_DLCR_EDL_MASK		0x08000000 /* EDL Mask in DLC */
 #define XCAN_DLCR_BRS_MASK		0x04000000 /* BRS Mask in DLC */
 
@@ -1138,7 +1140,7 @@ static int xcan_rx_fifo_get_next_frame(struct xcan_priv *priv)
 	int offset;
 
 	if (priv->devtype.flags & XCAN_FLAG_RX_FIFO_MULTI) {
-		u32 fsr;
+		u32 fsr, mask;
 
 		/* clear RXOK before the is-empty check so that any newly
 		 * received frame will reassert it without a race
@@ -1148,12 +1150,17 @@ static int xcan_rx_fifo_get_next_frame(struct xcan_priv *priv)
 		fsr = priv->read_reg(priv, XCAN_FSR_OFFSET);
 
 		/* check if RX FIFO is empty */
-		if (!(fsr & XCAN_FSR_FL_MASK))
+		if (priv->devtype.flags & XCAN_FLAG_CANFD_2)
+			mask = XCAN_2_FSR_FL_MASK;
+		else
+			mask = XCAN_FSR_FL_MASK;
+
+		if (!(fsr & mask))
 			return -ENOENT;
 
 		if (priv->devtype.flags & XCAN_FLAG_CANFD_2)
 			offset =
-			  XCAN_RXMSG_2_FRAME_OFFSET(fsr & XCAN_FSR_RI_MASK);
+			  XCAN_RXMSG_2_FRAME_OFFSET(fsr & XCAN_2_FSR_RI_MASK);
 		else
 			offset =
 			  XCAN_RXMSG_FRAME_OFFSET(fsr & XCAN_FSR_RI_MASK);
-- 
2.7.4
