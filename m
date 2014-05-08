From: David Jander <david@protonic.nl>
Subject: [PATCH] net: CAN: at91_can.c: decrease likelyhood of RX overruns
Date: Thu,  8 May 2014 16:55:10 +0200
Message-ID: <1399560910-17271-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:27598 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbaEHP0A (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 8 May 2014 11:26:00 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>, "Hans J. Koch" <hjk@hansjkoch.de>, Marcel Gielen <Marcel.Gielen@kvernelandgroup.com>, David Jander <david@protonic.nl>

Use an RX kfifo to empty receive message boxes as soon as possible in
the interrupt handler to avoid RX overruns if napi polls are late due to
latency.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/can/at91_can.c | 100 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 71 insertions(+), 29 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 6ee1acd..1c53a44 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -24,6 +24,7 @@
 #include <linux/if_arp.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/kfifo.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
@@ -153,6 +154,16 @@ struct at91_priv {
 	struct at91_can_data *pdata;
 
 	canid_t mb0_id;
+
+/*
+ * The AT91 SoC CAN controller (specially the one in some newer SoCs)
+ * has very little message boxes. On a busy high-speed network, latency
+ * may be too high for napi to catch up before RX overrun occurs.
+ * Therefor we declare a big enough kfifo and fill it directly from
+ * interrupt.
+ */
+#define RX_KFIFO_SIZE 512
+	DECLARE_KFIFO_PTR(rx_fifo, struct sk_buff *);
 };
 
 static const struct at91_devtype_data at91_at91sam9263_data = {
@@ -449,6 +460,26 @@ static void at91_chip_stop(struct net_device *dev, enum can_state state)
 	priv->can.state = state;
 }
 
+static int at91_rx_fifo_in(struct net_device *dev, struct sk_buff *skb)
+{
+	struct at91_priv *priv = netdev_priv(dev);
+	unsigned int len = kfifo_put(&priv->rx_fifo, skb);
+
+	if (len == sizeof(skb))
+		return 0;
+	return -ENOMEM;
+}
+
+static int at91_rx_fifo_out(struct net_device *dev, struct sk_buff **skb)
+{
+	struct at91_priv *priv = netdev_priv(dev);
+	unsigned int len = kfifo_get(&priv->rx_fifo, skb);
+
+	if (len == sizeof(skb))
+		return 0;
+	return -ENOENT;
+}
+
 /*
  * theory of operation:
  *
@@ -578,7 +609,7 @@ static void at91_rx_overflow_err(struct net_device *dev)
 
 	cf->can_id |= CAN_ERR_CRTL;
 	cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
-	netif_receive_skb(skb);
+	at91_rx_fifo_in(dev, skb);
 
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
@@ -643,7 +674,7 @@ static void at91_read_msg(struct net_device *dev, unsigned int mb)
 	}
 
 	at91_read_mb(dev, mb, cf);
-	netif_receive_skb(skb);
+	at91_rx_fifo_in(dev, skb);
 
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
@@ -700,7 +731,7 @@ static void at91_read_msg(struct net_device *dev, unsigned int mb)
  * quota.
  *
  */
-static int at91_poll_rx(struct net_device *dev, int quota)
+static int at91_poll_rx(struct net_device *dev)
 {
 	struct at91_priv *priv = netdev_priv(dev);
 	u32 reg_sr = at91_read(priv, AT91_SR);
@@ -708,14 +739,9 @@ static int at91_poll_rx(struct net_device *dev, int quota)
 	unsigned int mb;
 	int received = 0;
 
-	if (priv->rx_next > get_mb_rx_low_last(priv) &&
-	    reg_sr & get_mb_rx_low_mask(priv))
-		netdev_info(dev,
-			"order of incoming frames cannot be guaranteed\n");
-
  again:
 	for (mb = find_next_bit(addr, get_mb_tx_first(priv), priv->rx_next);
-	     mb < get_mb_tx_first(priv) && quota > 0;
+	     mb < get_mb_tx_first(priv);
 	     reg_sr = at91_read(priv, AT91_SR),
 	     mb = find_next_bit(addr, get_mb_tx_first(priv), ++priv->rx_next)) {
 		at91_read_msg(dev, mb);
@@ -729,12 +755,11 @@ static int at91_poll_rx(struct net_device *dev, int quota)
 			at91_activate_rx_mb(priv, mb);
 
 		received++;
-		quota--;
 	}
 
 	/* upper group completed, look again in lower */
 	if (priv->rx_next > get_mb_rx_low_last(priv) &&
-	    quota > 0 && mb > get_mb_rx_last(priv)) {
+	    mb > get_mb_rx_last(priv)) {
 		priv->rx_next = get_mb_rx_first(priv);
 		goto again;
 	}
@@ -790,20 +815,17 @@ static void at91_poll_err_frame(struct net_device *dev,
 	}
 }
 
-static int at91_poll_err(struct net_device *dev, int quota, u32 reg_sr)
+static int at91_poll_err(struct net_device *dev, u32 reg_sr)
 {
 	struct sk_buff *skb;
 	struct can_frame *cf;
 
-	if (quota == 0)
-		return 0;
-
 	skb = alloc_can_err_skb(dev, &cf);
 	if (unlikely(!skb))
 		return 0;
 
 	at91_poll_err_frame(dev, cf, reg_sr);
-	netif_receive_skb(skb);
+	at91_rx_fifo_in(dev, skb);
 
 	dev->stats.rx_packets++;
 	dev->stats.rx_bytes += cf->can_dlc;
@@ -811,15 +833,14 @@ static int at91_poll_err(struct net_device *dev, int quota, u32 reg_sr)
 	return 1;
 }
 
-static int at91_poll(struct napi_struct *napi, int quota)
+static void at91_poll(struct net_device *dev)
 {
-	struct net_device *dev = napi->dev;
 	const struct at91_priv *priv = netdev_priv(dev);
 	u32 reg_sr = at91_read(priv, AT91_SR);
-	int work_done = 0;
+	u32 reg_ier;
 
 	if (reg_sr & get_irq_mb_rx(priv))
-		work_done += at91_poll_rx(dev, quota - work_done);
+		at91_poll_rx(dev);
 
 	/*
 	 * The error bits are clear on read,
@@ -827,17 +848,30 @@ static int at91_poll(struct napi_struct *napi, int quota)
 	 */
 	reg_sr |= priv->reg_sr;
 	if (reg_sr & AT91_IRQ_ERR_FRAME)
-		work_done += at91_poll_err(dev, quota - work_done, reg_sr);
+		at91_poll_err(dev, reg_sr);
 
-	if (work_done < quota) {
-		/* enable IRQs for frame errors and all mailboxes >= rx_next */
-		u32 reg_ier = AT91_IRQ_ERR_FRAME;
-		reg_ier |= get_irq_mb_rx(priv) & ~AT91_MB_MASK(priv->rx_next);
+	/* enable IRQs for frame errors and all mailboxes >= rx_next */
+	reg_ier = AT91_IRQ_ERR_FRAME;
+	reg_ier |= get_irq_mb_rx(priv) & ~AT91_MB_MASK(priv->rx_next);
+	at91_write(priv, AT91_IER, reg_ier);
+}
 
-		napi_complete(napi);
-		at91_write(priv, AT91_IER, reg_ier);
+static int at91_napi_poll(struct napi_struct *napi, int quota)
+{
+	struct net_device *dev = napi->dev;
+	const struct at91_priv *priv = netdev_priv(dev);
+	int work_done = 0;
+	struct sk_buff *skb = NULL;
+
+	while(!(kfifo_is_empty(&priv->rx_fifo)) && (work_done < quota)) {
+		at91_rx_fifo_out(dev, &skb);
+		netif_receive_skb(skb);
+		work_done ++;
 	}
 
+	if(work_done < quota)
+		napi_complete(napi);
+
 	return work_done;
 }
 
@@ -1096,7 +1130,7 @@ static irqreturn_t at91_irq(int irq, void *dev_id)
 
 	handled = IRQ_HANDLED;
 
-	/* Receive or error interrupt? -> napi */
+	/* Receive or error interrupt? -> put in rx_fifo and call napi */
 	if (reg_sr & (get_irq_mb_rx(priv) | AT91_IRQ_ERR_FRAME)) {
 		/*
 		 * The error bits are clear on read,
@@ -1105,6 +1139,7 @@ static irqreturn_t at91_irq(int irq, void *dev_id)
 		priv->reg_sr = reg_sr;
 		at91_write(priv, AT91_IDR,
 			   get_irq_mb_rx(priv) | AT91_IRQ_ERR_FRAME);
+		at91_poll(dev);
 		napi_schedule(&priv->napi);
 	}
 
@@ -1356,7 +1391,14 @@ static int at91_can_probe(struct platform_device *pdev)
 	priv->pdata = dev_get_platdata(&pdev->dev);
 	priv->mb0_id = 0x7ff;
 
-	netif_napi_add(dev, &priv->napi, at91_poll, get_mb_rx_num(priv));
+	err = kfifo_alloc(&priv->rx_fifo, RX_KFIFO_SIZE, GFP_KERNEL);
+	if (err) {
+		dev_err(&pdev->dev, "allocating RX fifo failed\n");
+		goto exit_iounmap;
+	}
+
+	netif_napi_add(dev, &priv->napi, at91_napi_poll,
+			RX_KFIFO_SIZE > 64 ? 64 : RX_KFIFO_SIZE);
 
 	if (at91_is_sam9263(priv))
 		dev->sysfs_groups[0] = &at91_sysfs_attr_group;
-- 
1.9.1

