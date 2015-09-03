From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/4] can: at91_can: switch to rx-fifo implementation
Date: Thu,  3 Sep 2015 10:57:23 +0200
Message-ID: <1441270643-11352-5-git-send-email-mkl@pengutronix.de>
References: <1441270643-11352-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45933 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbbICI51 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Sep 2015 04:57:27 -0400
In-Reply-To: <1441270643-11352-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: guillaume@picquet.fr
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 284 ++++++++++-----------------------------------
 1 file changed, 64 insertions(+), 220 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 945c0955a967..890bf6195c31 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -2,7 +2,7 @@
  * at91_can.c - CAN network driver for AT91 SoC CAN controller
  *
  * (C) 2007 by Hans J. Koch <hjk@hansjkoch.de>
- * (C) 2008, 2009, 2010, 2011 by Marc Kleine-Budde <kernel@pengutronix.de>
+ * (C) 2008-2015 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
  *
  * This software may be distributed under the terms of the GNU General
  * Public License ("GPL") version 2 as distributed in the 'COPYING'
@@ -38,6 +38,7 @@
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
 #include <linux/can/led.h>
+#include <linux/can/rx-fifo.h>
 
 #define AT91_MB_MASK(i)		((1 << (i)) - 1)
 
@@ -138,14 +139,13 @@ struct at91_devtype_data {
 
 struct at91_priv {
 	struct can_priv can;		/* must be the first member! */
-	struct napi_struct napi;
+	struct can_rx_fifo rx_fifo;
 
 	void __iomem *reg_base;
 
 	u32 reg_sr;
 	unsigned int tx_next;
 	unsigned int tx_echo;
-	unsigned int rx_next;
 	struct at91_devtype_data devtype_data;
 
 	struct clk *clk;
@@ -154,6 +154,11 @@ struct at91_priv {
 	canid_t mb0_id;
 };
 
+static inline struct at91_priv *rx_fifo_to_priv(struct can_rx_fifo *fifo)
+{
+	return container_of(fifo, struct at91_priv, rx_fifo);
+}
+
 static const struct at91_devtype_data at91_at91sam9263_data = {
 	.rx_first = 1,
 	.rx_split = 8,
@@ -201,27 +206,11 @@ static inline unsigned int get_mb_rx_last(const struct at91_priv *priv)
 	return priv->devtype_data.rx_last;
 }
 
-static inline unsigned int get_mb_rx_split(const struct at91_priv *priv)
-{
-	return priv->devtype_data.rx_split;
-}
-
 static inline unsigned int get_mb_rx_num(const struct at91_priv *priv)
 {
 	return get_mb_rx_last(priv) - get_mb_rx_first(priv) + 1;
 }
 
-static inline unsigned int get_mb_rx_low_last(const struct at91_priv *priv)
-{
-	return get_mb_rx_split(priv) - 1;
-}
-
-static inline unsigned int get_mb_rx_low_mask(const struct at91_priv *priv)
-{
-	return AT91_MB_MASK(get_mb_rx_split(priv)) &
-		~AT91_MB_MASK(get_mb_rx_first(priv));
-}
-
 static inline unsigned int get_mb_tx_shift(const struct at91_priv *priv)
 {
 	return priv->devtype_data.tx_shift;
@@ -367,9 +356,8 @@ static void at91_setup_mailboxes(struct net_device *dev)
 	for (i = get_mb_tx_first(priv); i <= get_mb_tx_last(priv); i++)
 		set_mb_mode_prio(priv, i, AT91_MB_MODE_TX, 0);
 
-	/* Reset tx and rx helper pointers */
+	/* Reset tx helper pointers */
 	priv->tx_next = priv->tx_echo = 0;
-	priv->rx_next = get_mb_rx_first(priv);
 }
 
 static int at91_set_bittiming(struct net_device *dev)
@@ -428,6 +416,7 @@ static void at91_chip_start(struct net_device *dev)
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	/* Enable interrupts */
+	can_rx_fifo_reset(&priv->rx_fifo);
 	reg_ier = get_irq_mb_rx(priv) | AT91_IRQ_ERRP | AT91_IRQ_ERR_FRAME;
 	at91_write(priv, AT91_IDR, AT91_IRQ_ALL);
 	at91_write(priv, AT91_IER, reg_ier);
@@ -532,32 +521,6 @@ static netdev_tx_t at91_start_xmit(struct sk_buff *skb, struct net_device *dev)
 }
 
 /**
- * at91_activate_rx_low - activate lower rx mailboxes
- * @priv: a91 context
- *
- * Reenables the lower mailboxes for reception of new CAN messages
- */
-static inline void at91_activate_rx_low(const struct at91_priv *priv)
-{
-	u32 mask = get_mb_rx_low_mask(priv);
-	at91_write(priv, AT91_TCR, mask);
-}
-
-/**
- * at91_activate_rx_mb - reactive single rx mailbox
- * @priv: a91 context
- * @mb: mailbox to reactivate
- *
- * Reenables given mailbox for reception of new CAN messages
- */
-static inline void at91_activate_rx_mb(const struct at91_priv *priv,
-		unsigned int mb)
-{
-	u32 mask = 1 << mb;
-	at91_write(priv, AT91_TCR, mask);
-}
-
-/**
  * at91_rx_overflow_err - send error frame due to rx overflow
  * @dev: net device
  */
@@ -580,33 +543,34 @@ static void at91_rx_overflow_err(struct net_device *dev)
 
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
-	netif_receive_skb(skb);
+	netif_rx(skb);
 }
 
 /**
- * at91_read_mb - read CAN msg from mailbox (lowlevel impl)
- * @dev: net device
+ * at91_mailbox_read - read CAN msg from mailbox
+ * @fifo: rx-fifo
+ * @cf: CAN frame where to store message
  * @mb: mailbox number to read from
- * @cf: can frame where to store message
  *
  * Reads a CAN message from the given mailbox and stores data into
- * given can frame. "mb" and "cf" must be valid.
+ * given can frame. "cf" and "mb" must be valid.
  */
-static void at91_read_mb(struct net_device *dev, unsigned int mb,
-		struct can_frame *cf)
+static unsigned int at91_mailbox_read(struct can_rx_fifo *fifo, struct can_frame *cf, unsigned int mb)
 {
-	const struct at91_priv *priv = netdev_priv(dev);
+	const struct at91_priv *priv = rx_fifo_to_priv(fifo);
 	u32 reg_msr, reg_mid;
 
+	reg_msr = at91_read(priv, AT91_MSR(mb));
+	if (!(reg_msr & AT91_MSR_MRDY))
+		return 0;
+
 	reg_mid = at91_read(priv, AT91_MID(mb));
 	if (reg_mid & AT91_MID_MIDE)
 		cf->can_id = ((reg_mid >> 0) & CAN_EFF_MASK) | CAN_EFF_FLAG;
 	else
 		cf->can_id = (reg_mid >> 18) & CAN_SFF_MASK;
 
-	reg_msr = at91_read(priv, AT91_MSR(mb));
 	cf->can_dlc = get_can_dlc((reg_msr >> 16) & 0xf);
-
 	if (reg_msr & AT91_MSR_MRTR)
 		cf->can_id |= CAN_RTR_FLAG;
 	else {
@@ -618,127 +582,20 @@ static void at91_read_mb(struct net_device *dev, unsigned int mb,
 	at91_write(priv, AT91_MID(mb), AT91_MID_MIDE);
 
 	if (unlikely(mb == get_mb_rx_last(priv) && reg_msr & AT91_MSR_MMI))
-		at91_rx_overflow_err(dev);
-}
-
-/**
- * at91_read_msg - read CAN message from mailbox
- * @dev: net device
- * @mb: mail box to read from
- *
- * Reads a CAN message from given mailbox, and put into linux network
- * RX queue, does all housekeeping chores (stats, ...)
- */
-static void at91_read_msg(struct net_device *dev, unsigned int mb)
-{
-	struct net_device_stats *stats = &dev->stats;
-	struct can_frame *cf;
-	struct sk_buff *skb;
-
-	skb = alloc_can_skb(dev, &cf);
-	if (unlikely(!skb)) {
-		stats->rx_dropped++;
-		return;
-	}
-
-	at91_read_mb(dev, mb, cf);
+		at91_rx_overflow_err(fifo->dev);
 
-	stats->rx_packets++;
-	stats->rx_bytes += cf->can_dlc;
-	netif_receive_skb(skb);
+	/* disable MB for now */
+	at91_write(priv, AT91_IDR, 1 << mb);
 
-	can_led_event(dev, CAN_LED_EVENT_RX);
+	return 1;
 }
 
-/**
- * at91_poll_rx - read multiple CAN messages from mailboxes
- * @dev: net device
- * @quota: max number of pkgs we're allowed to receive
- *
- * Theory of Operation:
- *
- * About 3/4 of the mailboxes (get_mb_rx_first()...get_mb_rx_last())
- * on the chip are reserved for RX. We split them into 2 groups. The
- * lower group ranges from get_mb_rx_first() to get_mb_rx_low_last().
- *
- * Like it or not, but the chip always saves a received CAN message
- * into the first free mailbox it finds (starting with the
- * lowest). This makes it very difficult to read the messages in the
- * right order from the chip. This is how we work around that problem:
- *
- * The first message goes into mb nr. 1 and issues an interrupt. All
- * rx ints are disabled in the interrupt handler and a napi poll is
- * scheduled. We read the mailbox, but do _not_ reenable the mb (to
- * receive another message).
- *
- *    lower mbxs      upper
- *     ____^______    __^__
- *    /           \  /     \
- * +-+-+-+-+-+-+-+-++-+-+-+-+
- * | |x|x|x|x|x|x|x|| | | | |
- * +-+-+-+-+-+-+-+-++-+-+-+-+
- *  0 0 0 0 0 0  0 0 0 0 1 1  \ mail
- *  0 1 2 3 4 5  6 7 8 9 0 1  / box
- *  ^
- *  |
- *   \
- *     unused, due to chip bug
- *
- * The variable priv->rx_next points to the next mailbox to read a
- * message from. As long we're in the lower mailboxes we just read the
- * mailbox but not reenable it.
- *
- * With completion of the last of the lower mailboxes, we reenable the
- * whole first group, but continue to look for filled mailboxes in the
- * upper mailboxes. Imagine the second group like overflow mailboxes,
- * which takes CAN messages if the lower goup is full. While in the
- * upper group we reenable the mailbox right after reading it. Giving
- * the chip more room to store messages.
- *
- * After finishing we look again in the lower group if we've still
- * quota.
- *
- */
-static int at91_poll_rx(struct net_device *dev, int quota)
+static void at91_mailbox_enable_mask(struct can_rx_fifo *fifo, u64 mask)
 {
-	struct at91_priv *priv = netdev_priv(dev);
-	u32 reg_sr = at91_read(priv, AT91_SR);
-	const unsigned long *addr = (unsigned long *)&reg_sr;
-	unsigned int mb;
-	int received = 0;
-
-	if (priv->rx_next > get_mb_rx_low_last(priv) &&
-	    reg_sr & get_mb_rx_low_mask(priv))
-		netdev_info(dev,
-			"order of incoming frames cannot be guaranteed\n");
-
- again:
-	for (mb = find_next_bit(addr, get_mb_tx_first(priv), priv->rx_next);
-	     mb < get_mb_tx_first(priv) && quota > 0;
-	     reg_sr = at91_read(priv, AT91_SR),
-	     mb = find_next_bit(addr, get_mb_tx_first(priv), ++priv->rx_next)) {
-		at91_read_msg(dev, mb);
-
-		/* reactivate mailboxes */
-		if (mb == get_mb_rx_low_last(priv))
-			/* all lower mailboxed, if just finished it */
-			at91_activate_rx_low(priv);
-		else if (mb > get_mb_rx_low_last(priv))
-			/* only the mailbox we read */
-			at91_activate_rx_mb(priv, mb);
-
-		received++;
-		quota--;
-	}
-
-	/* upper group completed, look again in lower */
-	if (priv->rx_next > get_mb_rx_low_last(priv) &&
-	    quota > 0 && mb > get_mb_rx_last(priv)) {
-		priv->rx_next = get_mb_rx_first(priv);
-		goto again;
-	}
+	struct at91_priv *priv = rx_fifo_to_priv(fifo);
 
-	return received;
+	at91_write(priv, AT91_TCR, mask);
+	at91_write(priv, AT91_IER, mask);
 }
 
 static void at91_poll_err_frame(struct net_device *dev,
@@ -789,12 +646,16 @@ static void at91_poll_err_frame(struct net_device *dev,
 	}
 }
 
-static int at91_poll_err(struct net_device *dev, int quota, u32 reg_sr)
+static unsigned int at91_poll_err(struct can_rx_fifo *fifo)
 {
+	struct at91_priv *priv = rx_fifo_to_priv(fifo);
+	struct net_device *dev = fifo->dev;
 	struct sk_buff *skb;
 	struct can_frame *cf;
+	u32 reg_sr;
 
-	if (quota == 0)
+	reg_sr = priv->reg_sr;
+	if (!(reg_sr & AT91_IRQ_ERR_FRAME))
 		return 0;
 
 	skb = alloc_can_err_skb(dev, &cf);
@@ -802,6 +663,7 @@ static int at91_poll_err(struct net_device *dev, int quota, u32 reg_sr)
 		return 0;
 
 	at91_poll_err_frame(dev, cf, reg_sr);
+	priv->reg_sr = 0;
 
 	dev->stats.rx_packets++;
 	dev->stats.rx_bytes += cf->can_dlc;
@@ -810,34 +672,11 @@ static int at91_poll_err(struct net_device *dev, int quota, u32 reg_sr)
 	return 1;
 }
 
-static int at91_poll(struct napi_struct *napi, int quota)
+static void at91_poll_error_interrupts_enable(struct can_rx_fifo *fifo)
 {
-	struct net_device *dev = napi->dev;
-	const struct at91_priv *priv = netdev_priv(dev);
-	u32 reg_sr = at91_read(priv, AT91_SR);
-	int work_done = 0;
-
-	if (reg_sr & get_irq_mb_rx(priv))
-		work_done += at91_poll_rx(dev, quota - work_done);
-
-	/*
-	 * The error bits are clear on read,
-	 * so use saved value from irq handler.
-	 */
-	reg_sr |= priv->reg_sr;
-	if (reg_sr & AT91_IRQ_ERR_FRAME)
-		work_done += at91_poll_err(dev, quota - work_done, reg_sr);
-
-	if (work_done < quota) {
-		/* enable IRQs for frame errors and all mailboxes >= rx_next */
-		u32 reg_ier = AT91_IRQ_ERR_FRAME;
-		reg_ier |= get_irq_mb_rx(priv) & ~AT91_MB_MASK(priv->rx_next);
+	struct at91_priv *priv = rx_fifo_to_priv(fifo);
 
-		napi_complete(napi);
-		at91_write(priv, AT91_IER, reg_ier);
-	}
-
-	return work_done;
+	at91_write(priv, AT91_IER, AT91_IRQ_ERR_FRAME);
 }
 
 /*
@@ -958,7 +797,6 @@ static void at91_irq_err_state(struct net_device *dev,
 		break;
 	}
 
-
 	/* process state changes depending on the new state */
 	switch (new_state) {
 	case CAN_STATE_ERROR_ACTIVE:
@@ -1026,7 +864,6 @@ static int at91_get_state_by_bec(const struct net_device *dev,
 	return 0;
 }
 
-
 static void at91_irq_err(struct net_device *dev)
 {
 	struct at91_priv *priv = netdev_priv(dev);
@@ -1049,7 +886,7 @@ static void at91_irq_err(struct net_device *dev)
 		else if (likely(reg_sr & AT91_IRQ_ERRA))
 			new_state = CAN_STATE_ERROR_ACTIVE;
 		else {
-			netdev_err(dev, "BUG! hardware in undefined state\n");
+			netdev_err(dev, "BUG! hardware in undefined state (reg_sr=0x%08x)\n", reg_sr);
 			return;
 		}
 	} else {
@@ -1082,7 +919,6 @@ static irqreturn_t at91_irq(int irq, void *dev_id)
 {
 	struct net_device *dev = dev_id;
 	struct at91_priv *priv = netdev_priv(dev);
-	irqreturn_t handled = IRQ_NONE;
 	u32 reg_sr, reg_imr;
 
 	reg_sr = at91_read(priv, AT91_SR);
@@ -1091,30 +927,30 @@ static irqreturn_t at91_irq(int irq, void *dev_id)
 	/* Ignore masked interrupts */
 	reg_sr &= reg_imr;
 	if (!reg_sr)
-		goto exit;
-
-	handled = IRQ_HANDLED;
+		return IRQ_NONE;
 
-	/* Receive or error interrupt? -> napi */
-	if (reg_sr & (get_irq_mb_rx(priv) | AT91_IRQ_ERR_FRAME)) {
-		/*
-		 * The error bits are clear on read,
+	/* Error interrupt? -> rx-fifo */
+	if (reg_sr & AT91_IRQ_ERR_FRAME) {
+		/* The error bits are clear on read,
 		 * save for later use.
 		 */
 		priv->reg_sr = reg_sr;
-		at91_write(priv, AT91_IDR,
-			   get_irq_mb_rx(priv) | AT91_IRQ_ERR_FRAME);
-		napi_schedule(&priv->napi);
+
+		at91_write(priv, AT91_IDR, AT91_IRQ_ERR_FRAME);
+		can_rx_fifo_irq_error(&priv->rx_fifo);
 	}
 
+	/* Receive interrupt? */
+	if (reg_sr & (get_irq_mb_rx(priv)))
+		can_rx_fifo_irq_offload(&priv->rx_fifo);
+
 	/* Transmission complete interrupt */
 	if (reg_sr & get_irq_mb_tx(priv))
 		at91_irq_tx(dev, reg_sr);
 
 	at91_irq_err(dev);
 
- exit:
-	return handled;
+	return IRQ_HANDLED;
 }
 
 static int at91_open(struct net_device *dev)
@@ -1142,7 +978,7 @@ static int at91_open(struct net_device *dev)
 
 	/* start chip and queuing */
 	at91_chip_start(dev);
-	napi_enable(&priv->napi);
+	can_rx_fifo_enable(&priv->rx_fifo);
 	netif_start_queue(dev);
 
 	return 0;
@@ -1163,7 +999,7 @@ static int at91_close(struct net_device *dev)
 	struct at91_priv *priv = netdev_priv(dev);
 
 	netif_stop_queue(dev);
-	napi_disable(&priv->napi);
+	can_rx_fifo_disable(&priv->rx_fifo);
 	at91_chip_stop(dev, CAN_STATE_STOPPED);
 
 	free_irq(dev->irq, dev);
@@ -1354,8 +1190,16 @@ static int at91_can_probe(struct platform_device *pdev)
 	priv->clk = clk;
 	priv->pdata = dev_get_platdata(&pdev->dev);
 	priv->mb0_id = 0x7ff;
-
-	netif_napi_add(dev, &priv->napi, at91_poll, get_mb_rx_num(priv));
+	priv->rx_fifo.low_first = devtype_data->rx_first;
+	priv->rx_fifo.high_first = devtype_data->rx_split;
+	priv->rx_fifo.high_last = devtype_data->rx_last;
+	priv->rx_fifo.poll_post_read = at91_poll_err;
+	priv->rx_fifo.poll_error_interrupts_enable =
+		at91_poll_error_interrupts_enable;
+	priv->rx_fifo.mailbox_enable_mask = at91_mailbox_enable_mask;
+	priv->rx_fifo.mailbox_read = at91_mailbox_read;
+
+	can_rx_fifo_add(dev, &priv->rx_fifo);
 
 	if (at91_is_sam9263(priv))
 		dev->sysfs_groups[0] = &at91_sysfs_attr_group;
-- 
2.5.0

