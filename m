From: Mario Huettel <mario.huettel@de.bosch.com>
Subject: [PATCH v3 6/6] can: m_can: Enable TX FIFO Handling for M_CAN IP version >= v3.1.x
Date: Fri, 24 Mar 2017 17:49:31 +0100
Message-ID: <1490374171-15190-6-git-send-email-mario.huettel@de.bosch.com>
References: <1490374171-15190-1-git-send-email-mario.huettel@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:39182 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758012AbdCXQtv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Mar 2017 12:49:51 -0400
Received: from vsmta13.fe.internet.bosch.com (unknown [10.4.98.53])
        by imta23.fe.bosch.de (Postfix) with ESMTP id 4EB2915801A6
        for <linux-can@vger.kernel.org>; Fri, 24 Mar 2017 17:49:39 +0100 (CET)
Received: from FE-HUB1000.de.bosch.com (vsgw24.fe.internet.bosch.com [10.4.98.24])
        by vsmta13.fe.internet.bosch.com (Postfix) with ESMTP id 01AB42E405A1
        for <linux-can@vger.kernel.org>; Fri, 24 Mar 2017 17:49:39 +0100 (CET)
In-Reply-To: <1490374171-15190-1-git-send-email-mario.huettel@de.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

* Added defines for TX Event FIFO Element
* Adapted ndo_start_xmit function.
  For versions >= v3.1.x it uses the TX FIFO to optimize the data
  throughput. It stores the echo skb at the same index as in the
  M_CAN's TX FIFO. The frame's message marker is set to this index.
  This message marker is received in the TX Event FIFO after
  the message was successfully transmitted. It is used to echo the
  correct echo skb back to the network stack.
* Added m_can_echo_tx_event function. It reads all received
  message markers in the TX Event FIFO and loops back the
  corresponding echo skbs.
* ISR checks for new TX Event Entry interrupt for version >= 3.1.x.

Signed-off-by: Mario Huettel <mario.huettel@de.bosch.com>
---
 drivers/net/can/m_can/m_can.c | 188 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 159 insertions(+), 29 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a9f7de4..7db3f8c 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -334,6 +334,11 @@ enum m_can_mram_cfg {
 #define TX_BUF_MM_SHIFT		24
 #define TX_BUF_MM_MASK		(0xff << TX_BUF_MM_SHIFT)
 
+/* Tx event FIFO Element */
+/* E1 */
+#define TX_EVENT_MM_SHIFT	TX_BUF_MM_SHIFT
+#define TX_EVENT_MM_MASK	(0xff << TX_EVENT_MM_SHIFT)
+
 /* address offset and element number for each FIFO/Buffer in the Message RAM */
 struct mram_cfg {
 	u16 off;
@@ -817,6 +822,44 @@ static int m_can_poll(struct napi_struct *napi, int quota)
 	return work_done;
 }
 
+static void m_can_echo_tx_event(struct net_device *dev)
+{
+	u32 txe_count = 0;
+	u32 m_can_txefs;
+	u32 fgi = 0;
+	int i = 0;
+	unsigned int msg_mark;
+
+	struct m_can_priv *priv = netdev_priv(dev);
+	struct net_device_stats *stats = &dev->stats;
+
+	/* read tx event fifo status */
+	m_can_txefs = m_can_read(priv, M_CAN_TXEFS);
+
+	/* Get Tx Event fifo element count */
+	txe_count = (m_can_txefs & TXEFS_EFFL_MASK)
+			>> TXEFS_EFFL_SHIFT;
+
+	/* Get and process all sent elements */
+	for (i = 0; i < txe_count; i++) {
+		/* retrieve get index */
+		fgi = (m_can_read(priv, M_CAN_TXEFS) & TXEFS_EFGI_MASK)
+			>> TXEFS_EFGI_SHIFT;
+
+		/* get message marker */
+		msg_mark = (m_can_txe_fifo_read(priv, fgi, 4) &
+			    TX_EVENT_MM_MASK) >> TX_EVENT_MM_SHIFT;
+
+		/* ack txe element */
+		m_can_write(priv, M_CAN_TXEFA, (TXEFA_EFAI_MASK &
+						(fgi << TXEFA_EFAI_SHIFT)));
+
+		/* update stats */
+		stats->tx_bytes += can_get_echo_skb(dev, msg_mark);
+		stats->tx_packets++;
+	}
+}
+
 static irqreturn_t m_can_isr(int irq, void *dev_id)
 {
 	struct net_device *dev = (struct net_device *)dev_id;
@@ -843,12 +886,23 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 		napi_schedule(&priv->napi);
 	}
 
-	/* transmission complete interrupt */
-	if (ir & IR_TC) {
-		stats->tx_bytes += can_get_echo_skb(dev, 0);
-		stats->tx_packets++;
-		can_led_event(dev, CAN_LED_EVENT_TX);
-		netif_wake_queue(dev);
+	if (priv->version == 30) {
+		if (ir & IR_TC) {
+			/* Transmission Complete Interrupt*/
+			stats->tx_bytes += can_get_echo_skb(dev, 0);
+			stats->tx_packets++;
+			can_led_event(dev, CAN_LED_EVENT_TX);
+			netif_wake_queue(dev);
+		}
+	} else  {
+		if (ir & IR_TEFN) {
+			/* New TX FIFO Element arrived */
+			m_can_echo_tx_event(dev);
+			can_led_event(dev, CAN_LED_EVENT_TX);
+			if (netif_queue_stopped(dev) &&
+			    !m_can_tx_fifo_full(priv))
+				netif_wake_queue(dev);
+		}
 	}
 
 	return IRQ_HANDLED;
@@ -1291,19 +1345,34 @@ static int m_can_close(struct net_device *dev)
 	return 0;
 }
 
+static int m_can_next_echo_skb_occupied(struct net_device *dev, int putidx)
+{
+	struct m_can_priv *priv = netdev_priv(dev);
+	/*get wrap around for loopback skb index */
+	unsigned int wrap = priv->can.echo_skb_max;
+	int next_idx;
+
+	/* calculate next index */
+	next_idx = (++putidx >= wrap ? 0 : putidx);
+
+	/* check if occupied */
+	return !!priv->can.echo_skb[next_idx];
+}
+
 static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 				    struct net_device *dev)
 {
 	struct m_can_priv *priv = netdev_priv(dev);
 	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
-	u32 id, cccr;
+	u32 id, cccr, fdflags;
 	int i;
+	int putidx;
 
 	if (can_dropped_invalid_skb(dev, skb))
 		return NETDEV_TX_OK;
 
-	netif_stop_queue(dev);
-
+	/* Generate ID field for TX buffer Element */
+	/* Common to all supported M_CAN versions */
 	if (cf->can_id & CAN_EFF_FLAG) {
 		id = cf->can_id & CAN_EFF_MASK;
 		id |= TX_BUF_XTD;
@@ -1314,33 +1383,93 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 	if (cf->can_id & CAN_RTR_FLAG)
 		id |= TX_BUF_RTR;
 
-	/* message ram configuration */
-	m_can_fifo_write(priv, 0, M_CAN_FIFO_ID, id);
-	m_can_fifo_write(priv, 0, M_CAN_FIFO_DLC, can_len2dlc(cf->len) << 16);
+	if (priv->version == 30) {
+		netif_stop_queue(dev);
+
+		/* message ram configuration */
+		m_can_fifo_write(priv, 0, M_CAN_FIFO_ID, id);
+		m_can_fifo_write(priv, 0, M_CAN_FIFO_DLC,
+				 can_len2dlc(cf->len) << 16);
 
-	for (i = 0; i < cf->len; i += 4)
-		m_can_fifo_write(priv, 0, M_CAN_FIFO_DATA(i / 4),
-				 *(u32 *)(cf->data + i));
+		for (i = 0; i < cf->len; i += 4)
+			m_can_fifo_write(priv, 0,
+					 M_CAN_FIFO_DATA(i / 4),
+					 *(u32 *)(cf->data + i));
+
+		can_put_echo_skb(skb, dev, 0);
+
+		if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+			cccr = m_can_read(priv, M_CAN_CCCR);
+			cccr &= ~(CCCR_CMR_MASK << CCCR_CMR_SHIFT);
+			if (can_is_canfd_skb(skb)) {
+				if (cf->flags & CANFD_BRS)
+					cccr |= CCCR_CMR_CANFD_BRS <<
+						CCCR_CMR_SHIFT;
+				else
+					cccr |= CCCR_CMR_CANFD <<
+						CCCR_CMR_SHIFT;
+			} else {
+				cccr |= CCCR_CMR_CAN << CCCR_CMR_SHIFT;
+			}
+			m_can_write(priv, M_CAN_CCCR, cccr);
+		}
+		m_can_write(priv, M_CAN_TXBTIE, 0x1);
+		m_can_write(priv, M_CAN_TXBAR, 0x1);
+		/* End of xmit function for version 3.0.x */
+	} else {
+		/* Transmit routine for version >= v3.1.x */
+
+		/* Check if FIFO full */
+		if (m_can_tx_fifo_full(priv)) {
+			/* This shouldn't happen */
+			netif_stop_queue(dev);
+			netdev_warn(dev,
+				    "TX queue active although FIFO is full.");
+			return NETDEV_TX_BUSY;
+		}
 
-	can_put_echo_skb(skb, dev, 0);
+		/* get put index for frame */
+		putidx = ((m_can_read(priv, M_CAN_TXFQS) & TXFQS_TFQPI_MASK)
+				  >> TXFQS_TFQPI_SHIFT);
+		/* Write ID Field to FIFO Element */
+		m_can_fifo_write(priv, putidx, M_CAN_FIFO_ID, id);
 
-	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
-		cccr = m_can_read(priv, M_CAN_CCCR);
-		cccr &= ~(CCCR_CMR_MASK << CCCR_CMR_SHIFT);
+		/* get CAN FD configuration of frame */
+		fdflags = 0;
 		if (can_is_canfd_skb(skb)) {
+			fdflags |= TX_BUF_FDF;
 			if (cf->flags & CANFD_BRS)
-				cccr |= CCCR_CMR_CANFD_BRS << CCCR_CMR_SHIFT;
-			else
-				cccr |= CCCR_CMR_CANFD << CCCR_CMR_SHIFT;
-		} else {
-			cccr |= CCCR_CMR_CAN << CCCR_CMR_SHIFT;
+				fdflags |= TX_BUF_BRS;
 		}
-		m_can_write(priv, M_CAN_CCCR, cccr);
-	}
 
-	/* enable first TX buffer to start transfer  */
-	m_can_write(priv, M_CAN_TXBTIE, 0x1);
-	m_can_write(priv, M_CAN_TXBAR, 0x1);
+		/* Construct DLC Field. Also contains CAN-FD configuration
+		 * use put index of fifo as message marker
+		 * it is used in TX interrupt for
+		 * sending the correct echo frame
+		 */
+		m_can_fifo_write(priv, putidx, M_CAN_FIFO_DLC,
+				 ((putidx << TX_BUF_MM_SHIFT) &
+				  TX_BUF_MM_MASK) |
+				 (can_len2dlc(cf->len) << 16) |
+				 fdflags | TX_BUF_EFC);
+
+		for (i = 0; i < cf->len; i += 4)
+			m_can_fifo_write(priv, putidx, M_CAN_FIFO_DATA(i / 4),
+					 *(u32 *)(cf->data + i));
+
+		/* Push loopback echo.
+		 * Will be looped back on TX interrupt based on message marker
+		 */
+		can_put_echo_skb(skb, dev, putidx);
+
+		/* Enable TX FIFO element to start transfer  */
+		m_can_write(priv, M_CAN_TXBAR, (1 << putidx));
+
+		/* stop network queue if fifo full */
+			if (m_can_tx_fifo_full(priv) ||
+			    m_can_next_echo_skb_occupied(dev, putidx))
+				netif_stop_queue(dev);
+	}
 
 	return NETDEV_TX_OK;
 }
@@ -1516,6 +1645,7 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	/* Probe finished
 	 * Stop clocks. They will be reactivated once the M_CAN device is opened
 	 */
+
 	goto disable_cclk_ret;
 
 failed_free_dev:
-- 
1.9.1

