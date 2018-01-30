From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [PATCH v2 3/3] can: cc770: Fix queue stall & dropped RTR reply
Date: Tue, 30 Jan 2018 16:56:49 +0000
Message-ID: <20180130165649.22732-3-andri.yngvason@marel.com>
References: <20180130165649.22732-1-andri.yngvason@marel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ve1eur01on0089.outbound.protection.outlook.com ([104.47.1.89]:31424
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753495AbeA3Q53 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 30 Jan 2018 11:57:29 -0500
In-Reply-To: <20180130165649.22732-1-andri.yngvason@marel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, wg@grandegger.com, sigurbjorn.narfason@marel.com, hrafnkell.eiriksson@marel.com, patric.thysell@br-automation.com, Andri Yngvason <andri.yngvason@marel.com>

While waiting for the TX object to send an RTR, an external message with a
matching id can overwrite the TX data. In this case we must call the rx
routine and then try transmitting the message that was overwritten again.

The queue was being stalled because the RX event did not generate an
interrupt to wake up the queue again and the TX event did not happen
because the TXRQST flag is reset by the chip when new data is received.

According to the CC770 datasheet the id of a message object should not be
changed while the MSGVAL bit is set. This has been fixed by resetting the
MSGVAL bit before modifying the object in the transmit function and setting
it after. It is not enough to set & reset CPUUPD.

It is important to keep the MSGVAL bit reset while the message object is
being modified. Otherwise, during RTR transmission, a frame with matching
id could trigger an rx-interrupt, which would cause a race condition
between the interrupt routine and the transmit function.

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
---
Changes from v1:
 - Squashed 4 into 3
 - Modified comment
 - Now using NEWDAT flag instead of MSGLST to check if a message was
   received into TX object. This allows us to check if the message object
   was overwritten more than once, and report it.

 drivers/net/can/cc770/cc770.c | 96 ++++++++++++++++++++++++++++++-------------
 drivers/net/can/cc770/cc770.h |  2 +
 2 files changed, 69 insertions(+), 29 deletions(-)

diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index 12d3b89..e6458cb 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -390,38 +390,23 @@ static int cc770_get_berr_counter(const struct net_device *dev,
 	return 0;
 }
 
-static netdev_tx_t cc770_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static void cc770_tx(struct net_device *dev, int mo)
 {
 	struct cc770_priv *priv = netdev_priv(dev);
-	struct net_device_stats *stats = &dev->stats;
-	struct can_frame *cf = (struct can_frame *)skb->data;
-	unsigned int mo = obj2msgobj(CC770_OBJ_TX);
+	struct can_frame *cf = (struct can_frame *)priv->tx_skb->data;
 	u8 dlc, rtr;
 	u32 id;
 	int i;
 
-	if (can_dropped_invalid_skb(dev, skb))
-		return NETDEV_TX_OK;
-
-	if ((cc770_read_reg(priv,
-			    msgobj[mo].ctrl1) & TXRQST_UNC) == TXRQST_SET) {
-		netif_stop_queue(dev);
-		netdev_err(dev, "TX register is still occupied!\n");
-		return NETDEV_TX_BUSY;
-	}
-
-	netif_stop_queue(dev);
-
 	dlc = cf->can_dlc;
 	id = cf->can_id;
-	if (cf->can_id & CAN_RTR_FLAG)
-		rtr = 0;
-	else
-		rtr = MSGCFG_DIR;
+	rtr = cf->can_id & CAN_RTR_FLAG ? 0 : MSGCFG_DIR;
+
+	cc770_write_reg(priv, msgobj[mo].ctrl0,
+			MSGVAL_RES | TXIE_RES | RXIE_RES | INTPND_RES);
 	cc770_write_reg(priv, msgobj[mo].ctrl1,
 			RMTPND_RES | TXRQST_RES | CPUUPD_SET | NEWDAT_RES);
-	cc770_write_reg(priv, msgobj[mo].ctrl0,
-			MSGVAL_SET | TXIE_SET | RXIE_RES | INTPND_RES);
+
 	if (id & CAN_EFF_FLAG) {
 		id &= CAN_EFF_MASK;
 		cc770_write_reg(priv, msgobj[mo].config,
@@ -440,13 +425,31 @@ static netdev_tx_t cc770_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	for (i = 0; i < dlc; i++)
 		cc770_write_reg(priv, msgobj[mo].data[i], cf->data[i]);
 
-	/* Store echo skb before starting the transfer */
-	can_put_echo_skb(skb, dev, 0);
-
 	cc770_write_reg(priv, msgobj[mo].ctrl1,
-			RMTPND_RES | TXRQST_SET | CPUUPD_RES | NEWDAT_UNC);
+			RMTPND_UNC | TXRQST_SET | CPUUPD_RES | NEWDAT_UNC);
+	cc770_write_reg(priv, msgobj[mo].ctrl0,
+			MSGVAL_SET | TXIE_SET | RXIE_SET | INTPND_UNC);
+}
+
+static netdev_tx_t cc770_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct cc770_priv *priv = netdev_priv(dev);
+	unsigned int mo = obj2msgobj(CC770_OBJ_TX);
+
+	if (can_dropped_invalid_skb(dev, skb))
+		return NETDEV_TX_OK;
 
-	stats->tx_bytes += dlc;
+	if ((cc770_read_reg(priv,
+			    msgobj[mo].ctrl1) & TXRQST_UNC) == TXRQST_SET) {
+		netif_stop_queue(dev);
+		netdev_err(dev, "TX register is still occupied!\n");
+		return NETDEV_TX_BUSY;
+	}
+
+	netif_stop_queue(dev);
+
+	priv->tx_skb = skb;
+	cc770_tx(dev, mo);
 
 	return NETDEV_TX_OK;
 }
@@ -672,13 +675,47 @@ static void cc770_tx_interrupt(struct net_device *dev, unsigned int o)
 	struct cc770_priv *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 	unsigned int mo = obj2msgobj(o);
+	struct can_frame *cf;
+	u8 ctrl1;
+
+	ctrl1 = cc770_read_reg(priv, msgobj[mo].ctrl1);
 
-	/* Nothing more to send, switch off interrupts */
 	cc770_write_reg(priv, msgobj[mo].ctrl0,
 			MSGVAL_RES | TXIE_RES | RXIE_RES | INTPND_RES);
+	cc770_write_reg(priv, msgobj[mo].ctrl1,
+			RMTPND_RES | TXRQST_RES | MSGLST_RES | NEWDAT_RES);
 
-	stats->tx_packets++;
+	if (unlikely(!priv->tx_skb)) {
+		netdev_err(dev, "missing tx skb in tx interrupt\n");
+		return;
+	}
+
+	if (unlikely(ctrl1 & MSGLST_SET)) {
+		stats->rx_over_errors++;
+		stats->rx_errors++;
+	}
+
+	/* When the CC770 is sending an RTR message and it receives a regular
+	 * message that matches the id of the RTR message, it will overwrite the
+	 * outgoing message in the TX register. When this happens we must
+	 * process the received message and try to transmit the outgoing skb
+	 * again.
+	 */
+	if (unlikely(ctrl1 & NEWDAT_SET)) {
+		cc770_rx(dev, mo, ctrl1);
+		cc770_tx(dev, mo);
+		return;
+	}
+
+	can_put_echo_skb(priv->tx_skb, dev, 0);
 	can_get_echo_skb(dev, 0);
+
+	cf = (struct can_frame *)priv->tx_skb->data;
+	stats->tx_bytes += cf->can_dlc;
+	stats->tx_packets++;
+
+	priv->tx_skb = NULL;
+
 	netif_wake_queue(dev);
 }
 
@@ -790,6 +827,7 @@ struct net_device *alloc_cc770dev(int sizeof_priv)
 	priv->can.do_set_bittiming = cc770_set_bittiming;
 	priv->can.do_set_mode = cc770_set_mode;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES;
+	priv->tx_skb = NULL;
 
 	memcpy(priv->obj_flags, cc770_obj_flags, sizeof(cc770_obj_flags));
 
diff --git a/drivers/net/can/cc770/cc770.h b/drivers/net/can/cc770/cc770.h
index a1739db..95752e1 100644
--- a/drivers/net/can/cc770/cc770.h
+++ b/drivers/net/can/cc770/cc770.h
@@ -193,6 +193,8 @@ struct cc770_priv {
 	u8 cpu_interface;	/* CPU interface register */
 	u8 clkout;		/* Clock out register */
 	u8 bus_config;		/* Bus conffiguration register */
+
+	struct sk_buff *tx_skb;
 };
 
 struct net_device *alloc_cc770dev(int sizeof_priv);
-- 
1.9.1

