From: Srinivas Neeli <srinivas.neeli@xilinx.com>
Subject: [PATCH 2/2] can: xilinx_can: Fix usage of skb memory
Date: Wed, 20 Nov 2019 17:41:05 +0530
Message-ID: <1574251865-19592-3-git-send-email-srinivas.neeli@xilinx.com>
References: <1574251865-19592-1-git-send-email-srinivas.neeli@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1574251865-19592-1-git-send-email-srinivas.neeli@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, michal.simek@xilinx.com, appanad@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, git@xilinx.com, nagasure@xilinx.com, Srinivas Neeli <srinivas.neeli@xilinx.com>
List-Id: linux-can.vger.kernel.org

As per linux can framework, driver not allowed to touch the skb memory
after can_put_echo_skb() call.
This patch fixes the same.
https://www.spinics.net/lists/linux-can/msg02199.html

Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/net/can/xilinx_can.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index c5f05b994435..536b0f8272f6 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -191,6 +191,8 @@ struct xcan_devtype_data {
  * @bus_clk:			Pointer to struct clk
  * @can_clk:			Pointer to struct clk
  * @devtype:			Device type specific constants
+ * @cfd:			Variable to struct canfd_frame
+ * @is_canfd:			For checking canfd or not
  */
 struct xcan_priv {
 	struct can_priv can;
@@ -208,6 +210,8 @@ struct xcan_priv {
 	struct clk *bus_clk;
 	struct clk *can_clk;
 	struct xcan_devtype_data devtype;
+	struct canfd_frame cfd;
+	bool is_canfd;
 };
 
 /* CAN Bittiming constants as per Xilinx CAN specs */
@@ -543,14 +547,13 @@ static int xcan_do_set_mode(struct net_device *ndev, enum can_mode mode)
 /**
  * xcan_write_frame - Write a frame to HW
  * @priv:		Driver private data structure
- * @skb:		sk_buff pointer that contains data to be Txed
+ * @cf:			canfd_frame pointer that contains data to be Txed
  * @frame_offset:	Register offset to write the frame to
  */
-static void xcan_write_frame(struct xcan_priv *priv, struct sk_buff *skb,
+static void xcan_write_frame(struct xcan_priv *priv, struct canfd_frame *cf,
 			     int frame_offset)
 {
 	u32 id, dlc, data[2] = {0, 0};
-	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 	u32 ramoff, dwindex = 0, i;
 
 	/* Watch carefully on the bit sequence */
@@ -581,7 +584,7 @@ static void xcan_write_frame(struct xcan_priv *priv, struct sk_buff *skb,
 	}
 
 	dlc = can_len2dlc(cf->len) << XCAN_DLCR_DLC_SHIFT;
-	if (can_is_canfd_skb(skb)) {
+	if (priv->is_canfd) {
 		if (cf->flags & CANFD_BRS)
 			dlc |= XCAN_DLCR_BRS_MASK;
 		dlc |= XCAN_DLCR_EDL_MASK;
@@ -633,6 +636,9 @@ static int xcan_start_xmit_fifo(struct sk_buff *skb, struct net_device *ndev)
 	struct xcan_priv *priv = netdev_priv(ndev);
 	unsigned long flags;
 
+	priv->cfd = *((struct canfd_frame *)skb->data);
+	priv->is_canfd = can_is_canfd_skb(skb);
+
 	/* Check if the TX buffer is full */
 	if (unlikely(priv->read_reg(priv, XCAN_SR_OFFSET) &
 			XCAN_SR_TXFLL_MASK))
@@ -644,7 +650,7 @@ static int xcan_start_xmit_fifo(struct sk_buff *skb, struct net_device *ndev)
 
 	priv->tx_head++;
 
-	xcan_write_frame(priv, skb, XCAN_TXFIFO_OFFSET);
+	xcan_write_frame(priv, &priv->cfd, XCAN_TXFIFO_OFFSET);
 
 	/* Clear TX-FIFO-empty interrupt for xcan_tx_interrupt() */
 	if (priv->tx_max > 1)
@@ -671,6 +677,9 @@ static int xcan_start_xmit_mailbox(struct sk_buff *skb, struct net_device *ndev)
 	struct xcan_priv *priv = netdev_priv(ndev);
 	unsigned long flags;
 
+	priv->cfd = *((struct canfd_frame *)skb->data);
+	priv->is_canfd = can_is_canfd_skb(skb);
+
 	if (unlikely(priv->read_reg(priv, XCAN_TRR_OFFSET) &
 		     BIT(XCAN_TX_MAILBOX_IDX)))
 		return -ENOSPC;
@@ -681,7 +690,7 @@ static int xcan_start_xmit_mailbox(struct sk_buff *skb, struct net_device *ndev)
 
 	priv->tx_head++;
 
-	xcan_write_frame(priv, skb,
+	xcan_write_frame(priv, &priv->cfd,
 			 XCAN_TXMSG_FRAME_OFFSET(XCAN_TX_MAILBOX_IDX));
 
 	/* Mark buffer as ready for transmit */
-- 
2.7.4
