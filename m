From: Srinivas Neeli <srinivas.neeli@xilinx.com>
Subject: [PATCH V2 2/2] can: xilinx_can: Fix usage of skb memory
Date: Mon,  2 Dec 2019 18:32:11 +0530
Message-ID: <1575291731-11022-3-git-send-email-srinivas.neeli@xilinx.com>
References: <1575291731-11022-1-git-send-email-srinivas.neeli@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1575291731-11022-1-git-send-email-srinivas.neeli@xilinx.com>
Sender: netdev-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, michal.simek@xilinx.com, appanad@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, git@xilinx.com, nagasure@xilinx.com, Srinivas Neeli <srinivas.neeli@xilinx.com>
List-Id: linux-can.vger.kernel.org

As per linux can framework, driver not allowed to touch the skb memory
after can_put_echo_skb() call.
This patch fixes the same.
https://www.spinics.net/lists/linux-can/msg02199.html

Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
Reviewed-by: Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>
---
 drivers/net/can/xilinx_can.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index c5f05b994435..464af939cd8a 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -542,16 +542,17 @@ static int xcan_do_set_mode(struct net_device *ndev, enum can_mode mode)
 
 /**
  * xcan_write_frame - Write a frame to HW
- * @priv:		Driver private data structure
+ * @ndev:		Pointer to net_device structure
  * @skb:		sk_buff pointer that contains data to be Txed
  * @frame_offset:	Register offset to write the frame to
  */
-static void xcan_write_frame(struct xcan_priv *priv, struct sk_buff *skb,
+static void xcan_write_frame(struct net_device *ndev, struct sk_buff *skb,
 			     int frame_offset)
 {
 	u32 id, dlc, data[2] = {0, 0};
 	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
 	u32 ramoff, dwindex = 0, i;
+	struct xcan_priv *priv = netdev_priv(ndev);
 
 	/* Watch carefully on the bit sequence */
 	if (cf->can_id & CAN_EFF_FLAG) {
@@ -587,6 +588,14 @@ static void xcan_write_frame(struct xcan_priv *priv, struct sk_buff *skb,
 		dlc |= XCAN_DLCR_EDL_MASK;
 	}
 
+	if (!(priv->devtype.flags & XCAN_FLAG_TX_MAILBOXES) &&
+	    (priv->devtype.flags & XCAN_FLAG_TXFEMP))
+		can_put_echo_skb(skb, ndev, priv->tx_head % priv->tx_max);
+	else
+		can_put_echo_skb(skb, ndev, 0);
+
+	priv->tx_head++;
+
 	priv->write_reg(priv, XCAN_FRAME_ID_OFFSET(frame_offset), id);
 	/* If the CAN frame is RTR frame this write triggers transmission
 	 * (not on CAN FD)
@@ -638,13 +647,9 @@ static int xcan_start_xmit_fifo(struct sk_buff *skb, struct net_device *ndev)
 			XCAN_SR_TXFLL_MASK))
 		return -ENOSPC;
 
-	can_put_echo_skb(skb, ndev, priv->tx_head % priv->tx_max);
-
 	spin_lock_irqsave(&priv->tx_lock, flags);
 
-	priv->tx_head++;
-
-	xcan_write_frame(priv, skb, XCAN_TXFIFO_OFFSET);
+	xcan_write_frame(ndev, skb, XCAN_TXFIFO_OFFSET);
 
 	/* Clear TX-FIFO-empty interrupt for xcan_tx_interrupt() */
 	if (priv->tx_max > 1)
@@ -675,13 +680,9 @@ static int xcan_start_xmit_mailbox(struct sk_buff *skb, struct net_device *ndev)
 		     BIT(XCAN_TX_MAILBOX_IDX)))
 		return -ENOSPC;
 
-	can_put_echo_skb(skb, ndev, 0);
-
 	spin_lock_irqsave(&priv->tx_lock, flags);
 
-	priv->tx_head++;
-
-	xcan_write_frame(priv, skb,
+	xcan_write_frame(ndev, skb,
 			 XCAN_TXMSG_FRAME_OFFSET(XCAN_TX_MAILBOX_IDX));
 
 	/* Mark buffer as ready for transmit */
-- 
2.7.4
