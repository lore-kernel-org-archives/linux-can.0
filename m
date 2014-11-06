From: David Jander <david@protonic.nl>
Subject: [PATCH 01/14] can: dev: add preliminary rx-fifo
Date: Thu,  6 Nov 2014 09:34:00 +0100
Message-ID: <1415262853-22907-2-git-send-email-david@protonic.nl>
References: <1415262853-22907-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:26340 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbaKFIeF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Nov 2014 03:34:05 -0500
In-Reply-To: <1415262853-22907-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>

From: Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c   | 120 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/can/dev.h |  25 ++++++++++
 2 files changed, 145 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 02492d2..c1e53e9 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -273,6 +273,126 @@ static int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt,
 	return err;
 }
 
+static bool can_rx_fifo_ge(struct can_rx_fifo *fifo, unsigned int a, unsigned int b)
+{
+	if (fifo->inc)
+		return a >= b;
+	else
+		return a <= b;
+}
+
+static unsigned int can_rx_fifo_inc(struct can_rx_fifo *fifo, unsigned int *val)
+{
+	if (fifo->inc)
+		return (*val)++;
+	else
+		return (*val)--;
+}
+
+static u32 can_rx_fifo_mask_low(struct can_rx_fifo *fifo)
+{
+	if (fifo->inc)
+		return ~0U >> (32 + fifo->low_first - fifo->high_first) << fifo->low_first;
+	else
+		return ~0U >> (32 - fifo->low_first + fifo->high_first) << (fifo->high_first + 1);
+}
+
+static u32 can_rx_fifo_mask_high(struct can_rx_fifo *fifo)
+{
+	if (fifo->inc)
+		return ~0U >> (32 + fifo->high_first - fifo->high_last - 1) << fifo->high_first;
+	else
+		return ~0U >> (32 - fifo->high_first + fifo->high_last - 1) << fifo->high_last;
+}
+
+int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo)
+{
+	fifo->dev = dev;
+
+	if ((fifo->low_first < fifo->high_first) &&
+	    (fifo->high_first < fifo->high_last))
+		fifo->inc = true;
+	else if ((fifo->low_first > fifo->high_first) &&
+		 (fifo->high_first > fifo->high_last))
+		fifo->inc = false;
+	else
+		return -EINVAL;
+
+	if (!fifo->read_pending || !fifo->mailbox_enable_mask ||
+	    !fifo->mailbox_disable || !fifo->mailbox_receive)
+		return -EINVAL;
+
+	/* init variables */
+	fifo->mask_low = can_rx_fifo_mask_low(fifo);
+	fifo->mask_high = can_rx_fifo_mask_high(fifo);
+	fifo->next = fifo->low_first;
+	fifo->active = fifo->mask_low | fifo->mask_high;
+	fifo->mailbox_enable_mask(fifo, fifo->active);
+
+	netdev_dbg(dev, "%s: low_first=%d, high_first=%d, high_last=%d\n", __func__,
+		   fifo->low_first, fifo->high_first, fifo->high_last);
+	netdev_dbg(dev, "%s: mask_low=0x%08x mask_high=0x%08x\n", __func__,
+		   fifo->mask_low, fifo->mask_high);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(can_rx_fifo_add);
+
+int can_rx_fifo_poll(struct can_rx_fifo *fifo, int quota)
+{
+	int received = 0;
+	u32 pending;
+	unsigned int mb;
+
+	do {
+		pending = fifo->read_pending(fifo);
+		pending &= fifo->active;
+
+		if (!(pending & BIT(fifo->next))) {
+			/*
+			 * Wrap around only if:
+			 * - we are in the upper group and
+			 * - there is a CAN frame in the first mailbox
+			 *   of the lower group.
+			 */
+			if (can_rx_fifo_ge(fifo, fifo->next, fifo->high_first) &&
+			    (pending & BIT(fifo->low_first))) {
+				fifo->next = fifo->low_first;
+
+				fifo->active |= fifo->mask_high;
+				fifo->mailbox_enable_mask(fifo, fifo->mask_high);
+			} else {
+				break;
+			}
+		}
+
+		mb = can_rx_fifo_inc(fifo, &fifo->next);
+
+		/* disable mailbox */
+		fifo->active &= ~BIT(mb);
+		fifo->mailbox_disable(fifo, mb);
+
+		fifo->mailbox_receive(fifo, mb);
+
+		if (fifo->next == fifo->high_first) {
+			fifo->active |= fifo->mask_low;
+			fifo->mailbox_enable_mask(fifo, fifo->mask_low);
+		}
+
+		received++;
+		quota--;
+	} while (quota);
+
+	return received;
+}
+EXPORT_SYMBOL_GPL(can_rx_fifo_poll);
+
+u32 can_rx_fifo_get_active_mb_mask(const struct can_rx_fifo *fifo)
+{
+	return fifo->active;
+}
+EXPORT_SYMBOL_GPL(can_rx_fifo_get_active_mb_mask);
+
 /*
  * Local echo of CAN messages
  *
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 6992afc..e9468d0 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -64,6 +64,27 @@ struct can_priv {
 #endif
 };
 
+struct can_rx_fifo {
+	struct net_device *dev;
+
+	unsigned int low_first;
+	unsigned int high_first;
+	unsigned int high_last;		/* not needed during runtime */
+
+	u32 (*read_pending)(struct can_rx_fifo *rx_fifo);
+	void (*mailbox_enable_mask)(struct can_rx_fifo *rx_fifo, u32 mask);
+	void (*mailbox_disable)(struct can_rx_fifo *rx_fifo, unsigned int mb);
+	void (*mailbox_receive)(struct can_rx_fifo *rx_fifo, unsigned int mb);
+
+	u32 mask_low;
+	u32 mask_high;
+	u32 active;
+
+	unsigned int next;
+
+	bool inc;
+};
+
 /*
  * get_can_dlc(value) - helper macro to cast a given data length code (dlc)
  * to __u8 and ensure the dlc value to be max. 8 bytes.
@@ -105,6 +126,10 @@ u8 can_dlc2len(u8 can_dlc);
 /* map the sanitized data length to an appropriate data length code */
 u8 can_len2dlc(u8 len);
 
+int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo);
+int can_rx_fifo_poll(struct can_rx_fifo *fifo, int quota);
+u32 can_rx_fifo_get_active_mb_mask(const struct can_rx_fifo *fifo);
+
 struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max);
 void free_candev(struct net_device *dev);
 
-- 
1.9.1

