From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 02/10] can: rx-fifo: introduce software rx-fifo implementation
Date: Mon,  9 May 2016 12:52:26 +0200
Message-ID: <1462791154-13375-3-git-send-email-mkl@pengutronix.de>
References: <1462791154-13375-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42191 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751420AbcEIKwo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 May 2016 06:52:44 -0400
In-Reply-To: <1462791154-13375-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, David Jander <david@protonic.nl>

This patch adds a software rx-fifo implementation for CAN controllers which
offer only a number of mailboxes, where the incoming message is stored into the
first free one. Both controllers which start with the lowest or highest free
mailbox are supported.

The mailboxes are copied to a ring buffer during the interrupt and then
transmitted in a NAPI context.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rx-fifo.c   | 181 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/can/rx-fifo.h |  14 ++++
 2 files changed, 195 insertions(+)

diff --git a/drivers/net/can/rx-fifo.c b/drivers/net/can/rx-fifo.c
index 9ec8f99d8e2e..f72159bad7d3 100644
--- a/drivers/net/can/rx-fifo.c
+++ b/drivers/net/can/rx-fifo.c
@@ -19,6 +19,50 @@
 #include <linux/can/dev.h>
 #include <linux/can/rx-fifo.h>
 
+static bool can_rx_fifo_ge(struct can_rx_fifo *fifo, unsigned int a, unsigned int b)
+{
+	if (fifo->inc)
+		return a >= b;
+	else
+		return a <= b;
+}
+
+static bool can_rx_fifo_le(struct can_rx_fifo *fifo, unsigned int a, unsigned int b)
+{
+	if (fifo->inc)
+		return a <= b;
+	else
+		return a >= b;
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
+static u64 can_rx_fifo_mask_low(struct can_rx_fifo *fifo)
+{
+	if (fifo->inc)
+		return ~0LLU >> (64 + fifo->low_first - fifo->high_first)
+			     << fifo->low_first;
+	else
+		return ~0LLU >> (64 - fifo->low_first + fifo->high_first)
+			     << (fifo->high_first + 1);
+}
+
+static u64 can_rx_fifo_mask_high(struct can_rx_fifo *fifo)
+{
+	if (fifo->inc)
+		return ~0LLU >> (64 + fifo->high_first - fifo->high_last - 1)
+			     << fifo->high_first;
+	else
+		return ~0LLU >> (64 - fifo->high_first + fifo->high_last - 1)
+			     << fifo->high_last;
+}
+
 static int can_rx_fifo_napi_read_frame(struct can_rx_fifo *fifo, int index)
 {
 	struct net_device *dev = fifo->dev;
@@ -109,6 +153,71 @@ static unsigned int can_rx_fifo_offload_one(struct can_rx_fifo *fifo, unsigned i
 	return ret;
 }
 
+int can_rx_fifo_irq_offload(struct can_rx_fifo *fifo, u64 pending)
+{
+	unsigned int i;
+	unsigned int ret;
+	unsigned int received = 0;
+
+	if (fifo->scan_high_first) {
+		fifo->scan_high_first = false;
+		for (i = fifo->high_first;
+		     can_rx_fifo_le(fifo, i, fifo->high_last);
+		     can_rx_fifo_inc(fifo, &i)) {
+			if (pending & BIT_ULL(i)) {
+				received += can_rx_fifo_offload_one(fifo, i);
+
+				fifo->active |= BIT_ULL(i);
+				fifo->mailbox_enable(fifo, i);
+			}
+		}
+	}
+
+	/* Copy and disable FULL MBs */
+	for (i = fifo->low_first;
+	     can_rx_fifo_le(fifo, i, fifo->high_last);
+	     can_rx_fifo_inc(fifo, &i)) {
+		if (!(fifo->active & BIT_ULL(i) & pending))
+			continue;
+
+		ret = can_rx_fifo_offload_one(fifo, i);
+		if (!ret)
+			break;
+
+		received += ret;
+		fifo->active &= ~BIT_ULL(i);
+	}
+
+	if (can_rx_fifo_ge(fifo, i, fifo->high_first) && fifo->scan_high_first)
+		netdev_warn(fifo->dev, "%s: RX order cannot be guaranteed. (count=%d)\n",
+			    __func__, i);
+
+	/* No EMPTY MB in first half? */
+	if (can_rx_fifo_ge(fifo, i, fifo->high_first)) {
+		/* Re-enable all disabled MBs */
+		fifo->active = fifo->mask_low | fifo->mask_high;
+		fifo->mailbox_enable_mask(fifo, fifo->active);
+
+		/* Next time we need to check the second half first */
+		fifo->scan_high_first = true;
+	}
+
+	if (WARN(!received, "%s: No messages found, RX-FIFO out of sync?\n",
+		 __func__)) {
+		/* This should only happen if the CAN conroller was
+		 * reset, but can_rx_fifo_reset() was not
+		 * called. WARN() the user and try to recover. This
+		 * may fail and the system may hang though.
+		 */
+		can_rx_fifo_reset(fifo);
+	} else {
+		can_rx_fifo_schedule(fifo);
+	}
+
+	return received;
+}
+EXPORT_SYMBOL_GPL(can_rx_fifo_irq_offload);
+
 int can_rx_fifo_irq_offload_simple(struct can_rx_fifo *fifo)
 {
 	unsigned int received = 0;
@@ -139,11 +248,72 @@ static int can_rx_fifo_init_ring(struct net_device *dev,
 		return -ENOMEM;
 
 	fifo->ring_head = fifo->ring_tail = 0;
+	can_rx_fifo_reset(fifo);
 	netif_napi_add(dev, &fifo->napi, can_rx_fifo_napi_poll, weight);
 
 	return 0;
 }
 
+static void rx_fifo_enable_mask_default(struct can_rx_fifo *fifo, u64 mask)
+{
+	unsigned int i;
+
+	for (i = fifo->low_first;
+	     can_rx_fifo_le(fifo, i, fifo->high_last);
+	     can_rx_fifo_inc(fifo, &i)) {
+		if (mask & BIT_ULL(i))
+			fifo->mailbox_enable(fifo, i);
+	}
+}
+
+static void rx_fifo_enable_default(struct can_rx_fifo *fifo, unsigned int mb)
+{
+	fifo->mailbox_enable_mask(fifo, BIT_ULL(mb));
+}
+
+int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo)
+{
+	unsigned int weight;
+	int ret;
+
+	if ((fifo->low_first < fifo->high_first) &&
+	    (fifo->high_first < fifo->high_last)) {
+		fifo->inc = true;
+		weight = fifo->high_last - fifo->low_first;
+	} else if ((fifo->low_first > fifo->high_first) &&
+		   (fifo->high_first > fifo->high_last)) {
+		fifo->inc = false;
+		weight = fifo->low_first - fifo->high_last;
+	} else {
+		return -EINVAL;
+	}
+
+	if ((!fifo->mailbox_enable_mask && !fifo->mailbox_enable) ||
+	    !fifo->mailbox_read)
+		return -EINVAL;
+
+	if (!fifo->mailbox_enable_mask)
+		fifo->mailbox_enable_mask = rx_fifo_enable_mask_default;
+	if (!fifo->mailbox_enable)
+		fifo->mailbox_enable = rx_fifo_enable_default;
+
+	/* init variables */
+	fifo->mask_low = can_rx_fifo_mask_low(fifo);
+	fifo->mask_high = can_rx_fifo_mask_high(fifo);
+
+	ret = can_rx_fifo_init_ring(dev, fifo, weight);
+	if (ret)
+		return ret;
+
+	netdev_dbg(dev, "%s: low_first=%d, high_first=%d, high_last=%d\n", __func__,
+		   fifo->low_first, fifo->high_first, fifo->high_last);
+	netdev_dbg(dev, "%s: mask_low=0x%016llx mask_high=0x%016llx\n", __func__,
+		   fifo->mask_low, fifo->mask_high);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(can_rx_fifo_add);
+
 int can_rx_fifo_add_simple(struct net_device *dev, struct can_rx_fifo *fifo, unsigned int weight)
 {
 	if (!fifo->mailbox_read)
@@ -155,6 +325,9 @@ EXPORT_SYMBOL_GPL(can_rx_fifo_add_simple);
 
 void can_rx_fifo_enable(struct can_rx_fifo *fifo)
 {
+	can_rx_fifo_reset(fifo);
+	if (fifo->mailbox_enable_mask)
+		fifo->mailbox_enable_mask(fifo, fifo->active);
 	napi_enable(&fifo->napi);
 }
 EXPORT_SYMBOL_GPL(can_rx_fifo_enable);
@@ -172,3 +345,11 @@ void can_rx_fifo_del(struct can_rx_fifo *fifo)
 	kfree(fifo->ring);
 }
 EXPORT_SYMBOL_GPL(can_rx_fifo_del);
+
+void can_rx_fifo_reset(struct can_rx_fifo *fifo)
+{
+	fifo->scan_high_first = false;
+	fifo->poll_errors = false;
+	fifo->active = fifo->mask_low | fifo->mask_high;
+}
+EXPORT_SYMBOL_GPL(can_rx_fifo_reset);
diff --git a/include/linux/can/rx-fifo.h b/include/linux/can/rx-fifo.h
index 0582564deaaf..6b19ae1584be 100644
--- a/include/linux/can/rx-fifo.h
+++ b/include/linux/can/rx-fifo.h
@@ -23,25 +23,39 @@
 struct can_rx_fifo {
 	struct net_device *dev;
 
+	void (*mailbox_enable_mask)(struct can_rx_fifo *fifo, u64 mask);
+	void (*mailbox_enable)(struct can_rx_fifo *fifo, unsigned int mb);
 	void (*poll_error_interrupts_enable)(struct can_rx_fifo *fifo);
 	unsigned int (*mailbox_read)(struct can_rx_fifo *fifo, struct can_frame *cf, unsigned int mb);
 	unsigned int (*poll_pre_read)(struct can_rx_fifo *fifo);
 	unsigned int (*poll_post_read)(struct can_rx_fifo *fifo);
 
+	u64 mask_low;
+	u64 mask_high;
+	u64 active;
+
 	unsigned int ring_size;
 	unsigned int ring_head;
 	unsigned int ring_tail;
+	unsigned int low_first;
+	unsigned int high_first;
+	unsigned int high_last;
 
 	struct can_frame *ring;
 	struct can_frame overflow;
 	struct napi_struct napi;
 
+	bool inc;
+	bool scan_high_first;
 	bool poll_errors;
 };
 
+int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo);
 int can_rx_fifo_add_simple(struct net_device *dev, struct can_rx_fifo *fifo, unsigned int weight);
+int can_rx_fifo_irq_offload(struct can_rx_fifo *fifo, u64 reg);
 int can_rx_fifo_irq_offload_simple(struct can_rx_fifo *fifo);
 void can_rx_fifo_irq_error(struct can_rx_fifo *fifo);
+void can_rx_fifo_reset(struct can_rx_fifo *fifo);
 void can_rx_fifo_del(struct can_rx_fifo *fifo);
 void can_rx_fifo_enable(struct can_rx_fifo *fifo);
 
-- 
2.8.1

