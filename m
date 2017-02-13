From: Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: [PATCH 5/5 v2] can: xilinx_can: fix TX FIFO accounting getting out of sync
Date: Mon, 13 Feb 2017 17:39:37 +0200
Message-ID: <20170213153937.1945-1-anssi.hannula@bitwise.fi>
References: <0f108f45-396f-f12f-128a-aa44f61fe547@bitwise.fi>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <0f108f45-396f-f12f-128a-aa44f61fe547@bitwise.fi>
Sender: stable-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Kedareswara rao Appana <appanad@xilinx.com>, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

The xilinx_can driver assumes that the TXOK interrupt only clears after
it has been acknowledged as many times as there have been successfully
sent frames.

However, the documentation does not mention such behavior, instead
saying just that the interrupt is cleared when the clear bit is set.

Similarly, testing seems to also suggest that it is immediately cleared
regardless of the amount of frames having been sent. Performing some
heavy TX load and then going back to idle has the tx_head drifting
further away from tx_tail over time, steadily reducing the amount of
frames the driver keeps in the TX FIFO (but not to zero, as the TXOK
interrupt always frees up space for 1 frame from the driver's
perspective, so frames continue to be sent) and delaying the local echo
frames.

The TX FIFO tracking is also otherwise buggy as it does not account for
TX FIFO being cleared after software resets, causing
  BUG!, TX FIFO full when queue awake!
messages to be output.

Since there does not seem to be any way to accurately track the state of
the TX FIFO, drop the code trying to do that and perform
netif_stop_queue() based on whether the HW reports the FIFO being full.
Driver-side local echo support is also removed as it is not possible to
do accurately (relying instead on the CAN core fallback support).

Tested with the integrated CAN on Zynq-7000 SoC.

v2: Add FIFO space check before TX queue wake with locking to
synchronize with queue stop. This avoids waking the queue when xmit()
had just filled it.

Fixes: b1201e44f50b ("can: xilinx CAN controller support")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: <stable@vger.kernel.org>
---
 drivers/net/can/xilinx_can.c | 52 +++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 392be77..a4f69bc 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -28,6 +28,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/skbuff.h>
+#include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/can/dev.h>
@@ -119,9 +120,7 @@ enum xcan_reg {
 /**
  * struct xcan_priv - This definition define CAN driver instance
  * @can:			CAN private data structure.
- * @tx_head:			Tx CAN packets ready to send on the queue
- * @tx_tail:			Tx CAN packets successfully sended on the queue
- * @tx_max:			Maximum number packets the driver can send
+ * @txfifo_lock:		Lock for synchronizing queue start/stop
  * @napi:			NAPI structure
  * @read_reg:			For reading data from CAN registers
  * @write_reg:			For writing data to CAN registers
@@ -133,9 +132,7 @@ enum xcan_reg {
  */
 struct xcan_priv {
 	struct can_priv can;
-	unsigned int tx_head;
-	unsigned int tx_tail;
-	unsigned int tx_max;
+	spinlock_t txfifo_lock;
 	struct napi_struct napi;
 	u32 (*read_reg)(const struct xcan_priv *priv, enum xcan_reg reg);
 	void (*write_reg)(const struct xcan_priv *priv, enum xcan_reg reg,
@@ -393,6 +390,7 @@ static int xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	struct net_device_stats *stats = &ndev->stats;
 	struct can_frame *cf = (struct can_frame *)skb->data;
 	u32 id, dlc, data[2] = {0, 0};
+	unsigned long flags;
 
 	if (can_dropped_invalid_skb(ndev, skb))
 		return NETDEV_TX_OK;
@@ -439,9 +437,6 @@ static int xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	if (cf->can_dlc > 4)
 		data[1] = be32_to_cpup((__be32 *)(cf->data + 4));
 
-	can_put_echo_skb(skb, ndev, priv->tx_head % priv->tx_max);
-	priv->tx_head++;
-
 	/* Write the Frame to Xilinx CAN TX FIFO */
 	priv->write_reg(priv, XCAN_TXFIFO_ID_OFFSET, id);
 	/* If the CAN frame is RTR frame this write triggers tranmission */
@@ -453,12 +448,19 @@ static int xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		 */
 		priv->write_reg(priv, XCAN_TXFIFO_DW2_OFFSET, data[1]);
 		stats->tx_bytes += cf->can_dlc;
+		stats->tx_packets++;
 	}
 
+	dev_kfree_skb_any(skb);
+
+	spin_lock_irqsave(&priv->txfifo_lock, flags);
+
 	/* Check if the TX buffer is full */
-	if ((priv->tx_head - priv->tx_tail) == priv->tx_max)
+	if (priv->read_reg(priv, XCAN_SR_OFFSET) & XCAN_SR_TXFLL_MASK)
 		netif_stop_queue(ndev);
 
+	spin_unlock_irqrestore(&priv->txfifo_lock, flags);
+
 	return NETDEV_TX_OK;
 }
 
@@ -832,20 +834,20 @@ static int xcan_rx_poll(struct napi_struct *napi, int quota)
 static void xcan_tx_interrupt(struct net_device *ndev, u32 isr)
 {
 	struct xcan_priv *priv = netdev_priv(ndev);
-	struct net_device_stats *stats = &ndev->stats;
+	unsigned long flags;
+
+	priv->write_reg(priv, XCAN_ICR_OFFSET, XCAN_IXR_TXOK_MASK);
 
-	while ((priv->tx_head - priv->tx_tail > 0) &&
-			(isr & XCAN_IXR_TXOK_MASK)) {
-		priv->write_reg(priv, XCAN_ICR_OFFSET, XCAN_IXR_TXOK_MASK);
-		can_get_echo_skb(ndev, priv->tx_tail %
-					priv->tx_max);
-		priv->tx_tail++;
-		stats->tx_packets++;
-		isr = priv->read_reg(priv, XCAN_ISR_OFFSET);
-	}
 	can_led_event(ndev, CAN_LED_EVENT_TX);
 	xcan_update_error_state_after_rxtx(ndev);
-	netif_wake_queue(ndev);
+
+	spin_lock_irqsave(&priv->txfifo_lock, flags);
+
+	if (netif_queue_stopped(ndev) &&
+	    !(priv->read_reg(priv, XCAN_SR_OFFSET) & XCAN_SR_TXFLL_MASK))
+		netif_wake_queue(ndev);
+
+	spin_unlock_irqrestore(&priv->txfifo_lock, flags);
 }
 
 /**
@@ -1177,6 +1179,7 @@ static int xcan_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	/* tx-fifo-depth is currently not used for anything by the driver */
 	ret = of_property_read_u32(pdev->dev.of_node, "tx-fifo-depth", &tx_max);
 	if (ret < 0)
 		goto err;
@@ -1186,7 +1189,7 @@ static int xcan_probe(struct platform_device *pdev)
 		goto err;
 
 	/* Create a CAN device instance */
-	ndev = alloc_candev(sizeof(struct xcan_priv), tx_max);
+	ndev = alloc_candev(sizeof(struct xcan_priv), 0);
 	if (!ndev)
 		return -ENOMEM;
 
@@ -1198,11 +1201,10 @@ static int xcan_probe(struct platform_device *pdev)
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 					CAN_CTRLMODE_BERR_REPORTING;
 	priv->reg_base = addr;
-	priv->tx_max = tx_max;
+	spin_lock_init(&priv->txfifo_lock);
 
 	/* Get IRQ for the device */
 	ndev->irq = platform_get_irq(pdev, 0);
-	ndev->flags |= IFF_ECHO;	/* We support local echo */
 
 	platform_set_drvdata(pdev, ndev);
 	SET_NETDEV_DEV(ndev, &pdev->dev);
@@ -1265,7 +1267,7 @@ static int xcan_probe(struct platform_device *pdev)
 
 	netdev_dbg(ndev, "reg_base=0x%p irq=%d clock=%d, tx fifo depth:%d\n",
 			priv->reg_base, ndev->irq, priv->can.clock.freq,
-			priv->tx_max);
+			tx_max);
 
 	return 0;
 
-- 
2.8.3
