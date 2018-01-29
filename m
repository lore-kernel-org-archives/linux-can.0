From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [PATCH 4/4] can: cc770: Fix dropped RTR frames
Date: Mon, 29 Jan 2018 16:07:59 +0000
Message-ID: <20180129160759.29661-1-andri.yngvason@marel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-eopbgr50083.outbound.protection.outlook.com ([40.107.5.83]:63136
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750959AbeA2QIX (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 29 Jan 2018 11:08:23 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, wg@grandegger.com, sigurbjorn.narfason@marel.com, hrafnkell.eiriksson@marel.com, patric.thysell@br-automation.com, Andri Yngvason <andri.yngvason@marel.com>

Instead of counting lost tx RTR as dropped, it is re-transmitted.

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
---
Re-sent because format-patch didn't put the correct subject.
Should I maybe squash this into the last one?

 drivers/net/can/cc770/cc770.c | 80 +++++++++++++++++++++++++++----------------
 drivers/net/can/cc770/cc770.h |  2 ++
 2 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index 8f32357..8fc4667 100644
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
 	cc770_write_reg(priv, msgobj[mo].ctrl0,
 			MSGVAL_RES | TXIE_RES | RXIE_RES | INTPND_RES);
 	cc770_write_reg(priv, msgobj[mo].ctrl1,
 			RMTPND_RES | TXRQST_RES | CPUUPD_SET | NEWDAT_SET);
+
 	if (id & CAN_EFF_FLAG) {
 		id &= CAN_EFF_MASK;
 		cc770_write_reg(priv, msgobj[mo].config,
@@ -440,15 +425,31 @@ static netdev_tx_t cc770_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	for (i = 0; i < dlc; i++)
 		cc770_write_reg(priv, msgobj[mo].data[i], cf->data[i]);
 
-	/* Store echo skb before starting the transfer */
-	can_put_echo_skb(skb, dev, 0);
-
 	cc770_write_reg(priv, msgobj[mo].ctrl1,
 			RMTPND_UNC | TXRQST_SET | CPUUPD_RES | NEWDAT_UNC);
 	cc770_write_reg(priv, msgobj[mo].ctrl0,
 			MSGVAL_SET | TXIE_SET | RXIE_SET | INTPND_UNC);
+}
 
-	stats->tx_bytes += dlc;
+static netdev_tx_t cc770_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct cc770_priv *priv = netdev_priv(dev);
+	unsigned int mo = obj2msgobj(CC770_OBJ_TX);
+
+	if (can_dropped_invalid_skb(dev, skb))
+		return NETDEV_TX_OK;
+
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
@@ -674,6 +675,7 @@ static void cc770_tx_interrupt(struct net_device *dev, unsigned int o)
 	struct cc770_priv *priv = netdev_priv(dev);
 	struct net_device_stats *stats = &dev->stats;
 	unsigned int mo = obj2msgobj(o);
+	struct can_frame *cf;
 	u8 ctrl1;
 
 	ctrl1 = cc770_read_reg(priv, msgobj[mo].ctrl1);
@@ -683,15 +685,32 @@ static void cc770_tx_interrupt(struct net_device *dev, unsigned int o)
 	cc770_write_reg(priv, msgobj[mo].ctrl1,
 			RMTPND_RES | TXRQST_RES | MSGLST_RES | NEWDAT_RES);
 
-	if (ctrl1 & MSGLST_RES) {
-		can_get_echo_skb(dev, 0);
-		stats->tx_packets++;
-	} else {
-		can_free_echo_skb(dev, 0);
+	if (unlikely(!priv->tx_skb)) {
+		netdev_err(dev, "missing tx skb in tx interrupt\n");
+		return;
+	}
+
+	/* When the CC770 is sending an RTR message and it receives a regular
+	 * message that matches the id of the RTR message, it will overwrite the
+	 * outgoing message in the TX register. When this happens we must
+	 * process the received message and try to transmit the outgoing skb
+	 * again.
+	 */
+	if (unlikely(ctrl1 & MSGLST_SET)) {
 		cc770_rx(dev, mo, ctrl1);
-		stats->tx_dropped++;
+		cc770_tx(dev, mo);
+		return;
 	}
 
+	can_put_echo_skb(priv->tx_skb, dev, 0);
+	can_get_echo_skb(dev, 0);
+
+	cf = (struct can_frame *)priv->tx_skb->data;
+	stats->tx_bytes += cf->can_dlc;
+	stats->tx_packets++;
+
+	priv->tx_skb = NULL;
+
 	netif_wake_queue(dev);
 }
 
@@ -803,6 +822,7 @@ struct net_device *alloc_cc770dev(int sizeof_priv)
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

