From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH 6/6] net: can: xilinx_can: Fix kernel doc warnings
Date: Mon, 18 Mar 2019 17:02:46 +0530
Message-ID: <1552908766-26753-7-git-send-email-appana.durga.rao@xilinx.com>
References: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552908766-26753-1-git-send-email-appana.durga.rao@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, michal.simek@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
List-Id: linux-can.vger.kernel.org

This patch fixes below kernel doc warnings
warning: Function parameter or member 'priv' not described in
'xcan_write_frame'
warning: Function parameter or member 'skb' not described in
'xcan_start_xmit_fifo'
warning: Function parameter or member 'ndev' not described in
'xcan_start_xmit_fifo'
warning: Function parameter or member 'skb' not described in
'xcan_start_xmit_mailbox'
warning: Function parameter or member 'ndev' not described in
'xcan_start_xmit_mailbox'
warning: Function parameter or member 'priv' not described in
'xcan_rx_fifo_get_next_frame'

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
 drivers/net/can/xilinx_can.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index e1544e0..ac6fcae 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -545,6 +545,7 @@ static int xcan_do_set_mode(struct net_device *ndev, enum can_mode mode)
 
 /**
  * xcan_write_frame - Write a frame to HW
+ * @priv:		Driver private data structure
  * @skb:		sk_buff pointer that contains data to be Txed
  * @frame_offset:	Register offset to write the frame to
  */
@@ -625,6 +626,8 @@ static void xcan_write_frame(struct xcan_priv *priv, struct sk_buff *skb,
 
 /**
  * xcan_start_xmit_fifo - Starts the transmission (FIFO mode)
+ * @skb:	sk_buff pointer that contains data to be Txed
+ * @ndev:	Pointer to net_device structure
  *
  * Return: 0 on success, -ENOSPC if FIFO is full.
  */
@@ -661,6 +664,8 @@ static int xcan_start_xmit_fifo(struct sk_buff *skb, struct net_device *ndev)
 
 /**
  * xcan_start_xmit_mailbox - Starts the transmission (mailbox mode)
+ * @skb:	sk_buff pointer that contains data to be Txed
+ * @ndev:	Pointer to net_device structure
  *
  * Return: 0 on success, -ENOSPC if there is no space
  */
@@ -1148,6 +1153,7 @@ static void xcan_state_interrupt(struct net_device *ndev, u32 isr)
 
 /**
  * xcan_rx_fifo_get_next_frame - Get register offset of next RX frame
+ * @priv:	Driver private data structure
  *
  * Return: Register offset of the next frame in RX FIFO.
  */
-- 
2.7.4
