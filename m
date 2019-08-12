From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH v2 3/5] can: xilinx_can: Fix the data updation logic for CANFD FD frames
Date: Mon, 12 Aug 2019 15:36:44 +0530
Message-ID: <1565604406-4920-4-git-send-email-appana.durga.rao@xilinx.com>
References: <1565604406-4920-1-git-send-email-appana.durga.rao@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565604406-4920-1-git-send-email-appana.durga.rao@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, michal.simek@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
List-Id: linux-can.vger.kernel.org

commit c223da689324 ("can: xilinx_can: Add support for CANFD FD frames")
is writing data to a wrong offset for FD frames.

This patch fixes this issue.

Fixes: c223da6 ("can: xilinx_can: Add support for CANFD FD frames")
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Reviewed-by: Shubhrajyoti Datta <Shubhrajyoti.datta@xilinx.com>
Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/net/can/xilinx_can.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 2d3399e..c9b951b 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -66,8 +66,7 @@ enum xcan_reg {
 #define XCAN_FRAME_DLC_OFFSET(frame_base)	((frame_base) + 0x04)
 #define XCAN_FRAME_DW1_OFFSET(frame_base)	((frame_base) + 0x08)
 #define XCAN_FRAME_DW2_OFFSET(frame_base)	((frame_base) + 0x0C)
-#define XCANFD_FRAME_DW_OFFSET(frame_base, n)	(((frame_base) + 0x08) + \
-						 ((n) * XCAN_CANFD_FRAME_SIZE))
+#define XCANFD_FRAME_DW_OFFSET(frame_base)	((frame_base) + 0x08)
 
 #define XCAN_CANFD_FRAME_SIZE		0x48
 #define XCAN_TXMSG_FRAME_OFFSET(n)	(XCAN_TXMSG_BASE_OFFSET + \
@@ -600,7 +599,7 @@ static void xcan_write_frame(struct xcan_priv *priv, struct sk_buff *skb,
 	if (priv->devtype.cantype == XAXI_CANFD ||
 	    priv->devtype.cantype == XAXI_CANFD_2_0) {
 		for (i = 0; i < cf->len; i += 4) {
-			ramoff = XCANFD_FRAME_DW_OFFSET(frame_offset, dwindex) +
+			ramoff = XCANFD_FRAME_DW_OFFSET(frame_offset) +
 					(dwindex * XCANFD_DW_BYTES);
 			priv->write_reg(priv, ramoff,
 					be32_to_cpup((__be32 *)(cf->data + i)));
@@ -816,10 +815,8 @@ static int xcanfd_rx(struct net_device *ndev, int frame_base)
 	struct net_device_stats *stats = &ndev->stats;
 	struct canfd_frame *cf;
 	struct sk_buff *skb;
-	u32 id_xcan, dlc, data[2] = {0, 0}, dwindex = 0, i, fsr, readindex;
+	u32 id_xcan, dlc, data[2] = {0, 0}, dwindex = 0, i, dw_offset;
 
-	fsr = priv->read_reg(priv, XCAN_FSR_OFFSET);
-	readindex = fsr & XCAN_FSR_RI_MASK;
 	id_xcan = priv->read_reg(priv, XCAN_FRAME_ID_OFFSET(frame_base));
 	dlc = priv->read_reg(priv, XCAN_FRAME_DLC_OFFSET(frame_base));
 	if (dlc & XCAN_DLCR_EDL_MASK)
@@ -863,26 +860,16 @@ static int xcanfd_rx(struct net_device *ndev, int frame_base)
 	/* Check the frame received is FD or not*/
 	if (dlc & XCAN_DLCR_EDL_MASK) {
 		for (i = 0; i < cf->len; i += 4) {
-			if (priv->devtype.flags & XCAN_FLAG_CANFD_2)
-				data[0] = priv->read_reg(priv,
-					(XCAN_RXMSG_2_FRAME_OFFSET(readindex) +
-					(dwindex * XCANFD_DW_BYTES)));
-			else
-				data[0] = priv->read_reg(priv,
-					(XCAN_RXMSG_FRAME_OFFSET(readindex) +
-					(dwindex * XCANFD_DW_BYTES)));
+			dw_offset = XCANFD_FRAME_DW_OFFSET(frame_base) +
+					(dwindex * XCANFD_DW_BYTES);
+			data[0] = priv->read_reg(priv, dw_offset);
 			*(__be32 *)(cf->data + i) = cpu_to_be32(data[0]);
 			dwindex++;
 		}
 	} else {
 		for (i = 0; i < cf->len; i += 4) {
-			if (priv->devtype.flags & XCAN_FLAG_CANFD_2)
-				data[0] = priv->read_reg(priv,
-					XCAN_RXMSG_2_FRAME_OFFSET(readindex) +
-								  i);
-			else
-				data[0] = priv->read_reg(priv,
-					XCAN_RXMSG_FRAME_OFFSET(readindex) + i);
+			dw_offset = XCANFD_FRAME_DW_OFFSET(frame_base);
+			data[0] = priv->read_reg(priv, dw_offset + i);
 			*(__be32 *)(cf->data + i) = cpu_to_be32(data[0]);
 		}
 	}
-- 
2.7.4
