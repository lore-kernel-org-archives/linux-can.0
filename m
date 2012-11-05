From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] can: ti_hecc: WIP: fix out-of-order problem - CANMIN Version
Date: Mon,  5 Nov 2012 20:53:52 +0100
Message-ID: <1352145232-16403-1-git-send-email-mkl@pengutronix.de>
References: <a>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37569 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab2KETyO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 5 Nov 2012 14:54:14 -0500
In-Reply-To: <a>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: anilkumar@ti.com, Marc Kleine-Budde <mkl@pengutronix.de>

This is Work-In-Process patch which fixes several problem:
- ti_hecc_xmit: modify CANMIM under spin_lock
- ti_hecc_rx_pkt: don't re-enable current mailbox,
  next CAN frame might do into same mailbox
- ti_hecc_interrupt: modify CANMIM under spin_lock
- ti_hecc_rx_poll: rework polling loop, wrap-around-handling and
  reactivation of mailboxes.

Before acknowledging the received CAN frames in CANRMP wait for CAN core to
finish current rx, otherwise next CAN frame goes into undefined mailbox. Idea
lifted shamelessly from AnilKumar Ch's patch.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello AnilKumar,

here's the CANMIN version. With this patch the rx-path doesn't change the CANME
register, the wait-for-end-of-reception is done before writing to the CANRMP
register. So there isn't any spin_lock after the busy wait loop.

please test,

Marc

 drivers/net/can/ti_hecc.c |  155 ++++++++++++++++++++++++++++++---------------
 1 file changed, 105 insertions(+), 50 deletions(-)

diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 5ec2700..ff0a893 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -5,6 +5,7 @@
  * specs for the same is available at <http://www.ti.com>
  *
  * Copyright (C) 2009 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Marc Kleine-Budde <mkl@pengutronix.de>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -103,6 +104,8 @@ MODULE_VERSION(HECC_MODULE_VERSION);
 #define HECC_RX_BUFFER_MBOX	12 /* as per table above */
 #define HECC_RX_FIRST_MBOX	(HECC_MAX_MAILBOXES - 1)
 #define HECC_RX_HIGH_MBOX_MASK	(~(BIT(HECC_RX_BUFFER_MBOX) - 1))
+#define HECC_RX_LOW_MBOX_MASK	((BIT(HECC_RX_BUFFER_MBOX) - 1) & HECC_TX_MBOX_MASK)
+#define HECC_RX_MBOX_MASK	(HECC_RX_HIGH_MBOX_MASK | HECC_RX_LOW_MBOX_MASK)
 
 /* TI HECC module registers */
 #define HECC_CANME		0x0	/* Mailbox enable */
@@ -170,6 +173,7 @@ MODULE_VERSION(HECC_MODULE_VERSION);
 #define HECC_CANES_SMA		BIT(5)	/* suspend mode ack */
 #define HECC_CANES_CCE		BIT(4)	/* Change config enabled */
 #define HECC_CANES_PDA		BIT(3)	/* Power down mode ack */
+#define HECC_CANES_RM		BIT(1)	/* Receive Mode bit */
 
 #define HECC_CANBTC_SAM		BIT(7)	/* sample points */
 
@@ -195,6 +199,14 @@ MODULE_VERSION(HECC_MODULE_VERSION);
 #define HECC_CANGIM_DEF_MASK	0x700	/* only busoff/warning/passive */
 #define HECC_CANGIM_SIL		BIT(2)	/* system interrupts to int line 1 */
 
+/*
+ * Receive Mode bit reflects what the CAN protocol kernel (CPK) is
+ * actually doing regardless of mailbox configuration. CPK receive
+ * mode timeout. Tried from 1 - 5us and kept 10 as a safety value.
+ */
+#define HECC_RM_TIMEOUT_US	10
+
+
 /* CAN Bittiming constants as per HECC specs */
 static struct can_bittiming_const ti_hecc_bittiming_const = {
 	.name = DRV_NAME,
@@ -218,10 +230,11 @@ struct ti_hecc_priv {
 	u32 hecc_ram_offset;
 	u32 mbx_offset;
 	u32 int_line;
-	spinlock_t mbx_lock; /* CANME register needs protection */
+	spinlock_t mbx_lock; /* CANME and CANMIM registers needs protection */
 	u32 tx_head;
 	u32 tx_tail;
 	u32 rx_next;
+	u32 rx_active;
 	void (*transceiver_switch)(int);
 };
 
@@ -285,6 +298,42 @@ static inline u32 hecc_get_bit(struct ti_hecc_priv *priv, int reg, u32 bit_mask)
 	return (hecc_read(priv, reg) & bit_mask) ? 1 : 0;
 }
 
+static inline void hecc_set_bit_canme(struct ti_hecc_priv *priv, u32 bit_mask)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->mbx_lock, flags);
+	hecc_set_bit(priv, HECC_CANME, bit_mask);
+	spin_unlock_irqrestore(&priv->mbx_lock, flags);
+}
+
+static inline void hecc_clear_bit_canme(struct ti_hecc_priv *priv, u32 bit_mask)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->mbx_lock, flags);
+	hecc_clear_bit(priv, HECC_CANME, bit_mask);
+	spin_unlock_irqrestore(&priv->mbx_lock, flags);
+}
+
+static inline void hecc_set_bit_canmim(struct ti_hecc_priv *priv, u32 bit_mask)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->mbx_lock, flags);
+	hecc_set_bit(priv, HECC_CANMIM, bit_mask);
+	spin_unlock_irqrestore(&priv->mbx_lock, flags);
+}
+
+static inline void hecc_clear_bit_canmim(struct ti_hecc_priv *priv, u32 bit_mask)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->mbx_lock, flags);
+	hecc_clear_bit(priv, HECC_CANMIM, bit_mask);
+	spin_unlock_irqrestore(&priv->mbx_lock, flags);
+}
+
 static int ti_hecc_get_state(const struct net_device *ndev,
 	enum can_state *state)
 {
@@ -400,6 +449,7 @@ static void ti_hecc_start(struct net_device *ndev)
 
 	priv->tx_head = priv->tx_tail = HECC_TX_MASK;
 	priv->rx_next = HECC_RX_FIRST_MBOX;
+	priv->rx_active = HECC_RX_MBOX_MASK;
 
 	/* Enable local and global acceptance mask registers */
 	hecc_write(priv, HECC_CANGAM, HECC_SET_REG);
@@ -544,7 +594,7 @@ static netdev_tx_t ti_hecc_xmit(struct sk_buff *skb, struct net_device *ndev)
 	spin_unlock_irqrestore(&priv->mbx_lock, flags);
 
 	hecc_clear_bit(priv, HECC_CANMD, mbx_mask);
-	hecc_set_bit(priv, HECC_CANMIM, mbx_mask);
+	hecc_set_bit_canmim(priv, mbx_mask);
 	hecc_write(priv, HECC_CANTRS, mbx_mask);
 
 	return NETDEV_TX_OK;
@@ -556,7 +606,6 @@ static int ti_hecc_rx_pkt(struct ti_hecc_priv *priv, int mbxno)
 	struct can_frame *cf;
 	struct sk_buff *skb;
 	u32 data, mbx_mask;
-	unsigned long flags;
 
 	skb = alloc_can_skb(priv->ndev, &cf);
 	if (!skb) {
@@ -584,13 +633,6 @@ static int ti_hecc_rx_pkt(struct ti_hecc_priv *priv, int mbxno)
 	} else {
 		*(u32 *)(cf->data + 4) = 0;
 	}
-	spin_lock_irqsave(&priv->mbx_lock, flags);
-	hecc_clear_bit(priv, HECC_CANME, mbx_mask);
-	hecc_write(priv, HECC_CANRMP, mbx_mask);
-	/* enable mailbox only if it is part of rx buffer mailboxes */
-	if (priv->rx_next < HECC_RX_BUFFER_MBOX)
-		hecc_set_bit(priv, HECC_CANME, mbx_mask);
-	spin_unlock_irqrestore(&priv->mbx_lock, flags);
 
 	stats->rx_bytes += cf->can_dlc;
 	netif_receive_skb(skb);
@@ -624,47 +666,61 @@ static int ti_hecc_rx_poll(struct napi_struct *napi, int quota)
 {
 	struct net_device *ndev = napi->dev;
 	struct ti_hecc_priv *priv = netdev_priv(ndev);
-	u32 num_pkts = 0;
-	u32 mbx_mask;
-	unsigned long pending_pkts, flags;
-
-	if (!netif_running(ndev))
-		return 0;
-
-	while ((pending_pkts = hecc_read(priv, HECC_CANRMP)) &&
-		num_pkts < quota) {
-		mbx_mask = BIT(priv->rx_next); /* next rx mailbox to process */
-		if (mbx_mask & pending_pkts) {
-			if (ti_hecc_rx_pkt(priv, priv->rx_next) < 0)
-				return num_pkts;
-			++num_pkts;
-		} else if (priv->rx_next > HECC_RX_BUFFER_MBOX) {
-			break; /* pkt not received yet */
+	u32 reg_rmp;
+	unsigned int mb;
+	int received = 0;
+
+	do {
+		reg_rmp = hecc_read(priv, HECC_CANRMP) & priv->rx_active;
+		if (!(reg_rmp & BIT(priv->rx_next))) {
+			/*
+			 * Wrap around only if:
+			 * - we are in the lower group and
+			 * - there is a CAN frame in the first mailbox
+			 *   of the high group.
+			 */
+			if ((priv->rx_next <= HECC_RX_BUFFER_MBOX) &&
+			    (reg_rmp & BIT(HECC_RX_FIRST_MBOX)))
+				priv->rx_next = HECC_RX_FIRST_MBOX;
+			else
+				break;
 		}
-		--priv->rx_next;
-		if (priv->rx_next == HECC_RX_BUFFER_MBOX) {
-			/* enable high bank mailboxes */
-			spin_lock_irqsave(&priv->mbx_lock, flags);
-			mbx_mask = hecc_read(priv, HECC_CANME);
-			mbx_mask |= HECC_RX_HIGH_MBOX_MASK;
-			hecc_write(priv, HECC_CANME, mbx_mask);
-			spin_unlock_irqrestore(&priv->mbx_lock, flags);
-		} else if (priv->rx_next == HECC_MAX_TX_MBOX - 1) {
-			priv->rx_next = HECC_RX_FIRST_MBOX;
-			break;
+		mb = priv->rx_next--;
+
+		/* disable mailbox */
+		priv->rx_active &= ~BIT(mb);
+
+		ti_hecc_rx_pkt(priv, mb);
+
+		/* enable mailboxes */
+		if (mb == HECC_RX_BUFFER_MBOX) {
+			unsigned long timeout = jiffies + usecs_to_jiffies(HECC_RM_TIMEOUT_US);
+
+			while (hecc_get_bit(priv, HECC_CANES, HECC_CANES_RM)) {
+				if (time_after(jiffies, timeout)) {
+					netdev_warn(priv->ndev, "receiving pkt\n");
+					break;
+				}
+				cpu_relax();
+			}
+			hecc_write(priv, HECC_CANRMP, HECC_RX_HIGH_MBOX_MASK);
+			priv->rx_active |= HECC_RX_HIGH_MBOX_MASK;
+		} else if (mb == HECC_RX_FIRST_MBOX) {
+			hecc_write(priv, HECC_CANRMP, HECC_RX_LOW_MBOX_MASK);
+			priv->rx_active |= HECC_RX_LOW_MBOX_MASK;
 		}
-	}
 
-	/* Enable packet interrupt if all pkts are handled */
-	if (hecc_read(priv, HECC_CANRMP) == 0) {
+		received++;
+		quota--;
+	} while (quota);
+
+	if (quota) {
 		napi_complete(napi);
 		/* Re-enable RX mailbox interrupts */
-		mbx_mask = hecc_read(priv, HECC_CANMIM);
-		mbx_mask |= HECC_TX_MBOX_MASK;
-		hecc_write(priv, HECC_CANMIM, mbx_mask);
+		hecc_set_bit_canmim(priv, priv->rx_active);
 	}
 
-	return num_pkts;
+	return received;
 }
 
 static int ti_hecc_error(struct net_device *ndev, int int_status,
@@ -769,7 +825,7 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *dev_id)
 	struct ti_hecc_priv *priv = netdev_priv(ndev);
 	struct net_device_stats *stats = &ndev->stats;
 	u32 mbxno, mbx_mask, int_status, err_status;
-	unsigned long ack, flags;
+	unsigned long flags;
 
 	int_status = hecc_read(priv,
 		(priv->int_line) ? HECC_CANGIF1 : HECC_CANGIF0);
@@ -788,9 +844,9 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *dev_id)
 			mbx_mask = BIT(mbxno);
 			if (!(mbx_mask & hecc_read(priv, HECC_CANTA)))
 				break;
-			hecc_clear_bit(priv, HECC_CANMIM, mbx_mask);
 			hecc_write(priv, HECC_CANTA, mbx_mask);
 			spin_lock_irqsave(&priv->mbx_lock, flags);
+			hecc_clear_bit(priv, HECC_CANMIM, mbx_mask);
 			hecc_clear_bit(priv, HECC_CANME, mbx_mask);
 			spin_unlock_irqrestore(&priv->mbx_lock, flags);
 			stats->tx_bytes += hecc_read_mbx(priv, mbxno,
@@ -808,10 +864,8 @@ static irqreturn_t ti_hecc_interrupt(int irq, void *dev_id)
 			netif_wake_queue(ndev);
 
 		/* Disable RX mailbox interrupts and let NAPI reenable them */
-		if (hecc_read(priv, HECC_CANRMP)) {
-			ack = hecc_read(priv, HECC_CANMIM);
-			ack &= BIT(HECC_MAX_TX_MBOX) - 1;
-			hecc_write(priv, HECC_CANMIM, ack);
+		if (hecc_read(priv, HECC_CANRMP) & priv->rx_active) {
+			hecc_clear_bit_canmim(priv, HECC_RX_MBOX_MASK);
 			napi_schedule(&priv->napi);
 		}
 	}
@@ -1055,3 +1109,4 @@ module_platform_driver(ti_hecc_driver);
 MODULE_AUTHOR("Anant Gole <anantgole@ti.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION(DRV_DESC);
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
1.7.10.4

