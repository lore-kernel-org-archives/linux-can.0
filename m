From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v3 02/16] can: rx-offload: Add support for timestamp based irq offloading
Date: Wed, 18 Jan 2017 15:52:13 +0100
Message-ID: <20170118145227.24916-3-mkl@pengutronix.de>
References: <20170118145227.24916-1-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51111 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753002AbdARPD4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2017 10:03:56 -0500
In-Reply-To: <20170118145227.24916-1-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Mirza Krak <mirza.krak@hostmobility.com>, Holger Schurig <holgerschurig@gmail.com>, alexander.stein@systec-electronic.com, Marc Kleine-Budde <mkl@pengutronix.de>

Some CAN controllers don't implement a FIFO in hardware, but fill their
mailboxes in a particular order (from lowest to highest or highest to lowest).
This makes problems to read the frames in the correct order from the hardware,
as new frames might be filled into just read (low) mailboxes. This gets worse,
when following new frames are received into not read (higher) mailboxes.

On the bright side some these CAN controllers put a timestamp on each received
CAN frame. This patch adds support to offload CAN frames in interrupt context,
order them by timestamp and then transmitted in a NAPI context.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rx-offload.c   | 137 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/can/rx-offload.h |  10 ++-
 2 files changed, 144 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index 6bd71af76f36..7cb34c0601de 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -18,6 +18,33 @@
 #include <linux/can/dev.h>
 #include <linux/can/rx-offload.h>
 
+struct can_rx_offload_cb {
+	u32 timestamp;
+};
+
+static inline struct can_rx_offload_cb *can_rx_offload_get_cb(struct sk_buff *skb)
+{
+	BUILD_BUG_ON(sizeof(struct can_rx_offload_cb) > sizeof(skb->cb));
+
+	return (struct can_rx_offload_cb *)skb->cb;
+}
+
+static inline bool can_rx_offload_le(struct can_rx_offload *offload, unsigned int a, unsigned int b)
+{
+	if (offload->inc)
+		return a <= b;
+	else
+		return a >= b;
+}
+
+static inline unsigned int can_rx_offload_inc(struct can_rx_offload *offload, unsigned int *val)
+{
+	if (offload->inc)
+		return (*val)++;
+	else
+		return (*val)--;
+}
+
 static int can_rx_offload_napi_poll(struct napi_struct *napi, int quota)
 {
 	struct can_rx_offload *offload = container_of(napi, struct can_rx_offload, napi);
@@ -49,9 +76,50 @@ static int can_rx_offload_napi_poll(struct napi_struct *napi, int quota)
 	return work_done;
 }
 
+static inline void __skb_queue_add_sort(struct sk_buff_head *head, struct sk_buff *new,
+					int (*compare)(struct sk_buff *a, struct sk_buff *b))
+{
+	struct sk_buff *pos, *insert = (struct sk_buff *)head;
+
+	skb_queue_reverse_walk(head, pos) {
+		const struct can_rx_offload_cb *cb_pos, *cb_new;
+
+		cb_pos = can_rx_offload_get_cb(pos);
+		cb_new = can_rx_offload_get_cb(new);
+
+		netdev_dbg(new->dev,
+			   "%s: pos=0x%08x, new=0x%08x, diff=%10d, queue_len=%d\n",
+			   __func__,
+			   cb_pos->timestamp, cb_new->timestamp,
+			   cb_new->timestamp - cb_pos->timestamp,
+			   skb_queue_len(head));
+
+		if (compare(pos, new) < 0)
+			continue;
+		insert = pos;
+		break;
+	}
+
+	__skb_queue_after(head, insert, new);
+}
+
+static int can_rx_offload_compare(struct sk_buff *a, struct sk_buff *b)
+{
+	const struct can_rx_offload_cb *cb_a, *cb_b;
+
+	cb_a = can_rx_offload_get_cb(a);
+	cb_b = can_rx_offload_get_cb(b);
+
+	/* Substract two u32 and return result as int, to keep
+	 * difference steady around the u32 overflow.
+	 */
+	return cb_b->timestamp - cb_a->timestamp;
+}
+
 static struct sk_buff *can_rx_offload_offload_one(struct can_rx_offload *offload, unsigned int n)
 {
 	struct sk_buff *skb = NULL;
+	struct can_rx_offload_cb *cb;
 	struct can_frame *cf;
 	int ret;
 
@@ -62,15 +130,18 @@ static struct sk_buff *can_rx_offload_offload_one(struct can_rx_offload *offload
 
 	if (!skb) {
 		struct can_frame cf_overflow;
+		u32 timestamp;
 
-		ret = offload->mailbox_read(offload, &cf_overflow, n);
+		ret = offload->mailbox_read(offload, &cf_overflow,
+					    &timestamp, n);
 		if (ret)
 			offload->dev->stats.rx_dropped++;
 
 		return NULL;
 	}
 
-	ret = offload->mailbox_read(offload, cf, n);
+	cb = can_rx_offload_get_cb(skb);
+	ret = offload->mailbox_read(offload, cf, &cb->timestamp, n);
 	if (!ret) {
 		kfree_skb(skb);
 		return NULL;
@@ -79,6 +150,48 @@ static struct sk_buff *can_rx_offload_offload_one(struct can_rx_offload *offload
 	return skb;
 }
 
+int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload, u64 pending)
+{
+	struct sk_buff_head skb_queue;
+	unsigned int i;
+
+	__skb_queue_head_init(&skb_queue);
+
+	for (i = offload->mb_first;
+	     can_rx_offload_le(offload, i, offload->mb_last);
+	     can_rx_offload_inc(offload, &i)) {
+		struct sk_buff *skb;
+
+		if (!(pending & BIT_ULL(i)))
+			continue;
+
+		skb = can_rx_offload_offload_one(offload, i);
+		if (!skb)
+			break;
+
+		__skb_queue_add_sort(&skb_queue, skb, can_rx_offload_compare);
+	}
+
+	if (!skb_queue_empty(&skb_queue)) {
+		unsigned long flags;
+		u32 queue_len;
+
+		spin_lock_irqsave(&offload->skb_queue.lock, flags);
+		skb_queue_splice_tail(&skb_queue, &offload->skb_queue);
+		spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
+
+		if ((queue_len = skb_queue_len(&offload->skb_queue)) >
+		    (offload->skb_queue_len_max / 8))
+			netdev_dbg(offload->dev, "%s: queue_len=%d\n",
+				   __func__, queue_len);
+
+		can_rx_offload_schedule(offload);
+	}
+
+	return skb_queue_len(&skb_queue);
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_timestamp);
+
 int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload)
 {
 	struct sk_buff *skb;
@@ -127,6 +240,26 @@ static int can_rx_offload_init_queue(struct net_device *dev, struct can_rx_offlo
 	return 0;
 }
 
+int can_rx_offload_add_timestamp(struct net_device *dev, struct can_rx_offload *offload)
+{
+	unsigned int weight;
+
+	if (offload->mb_first > BITS_PER_LONG_LONG ||
+	    offload->mb_last > BITS_PER_LONG_LONG || !offload->mailbox_read)
+		return -EINVAL;
+
+	if (offload->mb_first < offload->mb_last) {
+		offload->inc = true;
+		weight = offload->mb_last - offload->mb_first;
+	} else {
+		offload->inc = false;
+		weight = offload->mb_first - offload->mb_last;
+	}
+
+	return can_rx_offload_init_queue(dev, offload, weight);;
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_add_timestamp);
+
 int can_rx_offload_add_fifo(struct net_device *dev, struct can_rx_offload *offload, unsigned int weight)
 {
 	if (!offload->mailbox_read)
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.h
index cadfe9869600..cb31683bbe15 100644
--- a/include/linux/can/rx-offload.h
+++ b/include/linux/can/rx-offload.h
@@ -23,15 +23,23 @@
 struct can_rx_offload {
 	struct net_device *dev;
 
-	unsigned int (*mailbox_read)(struct can_rx_offload *offload, struct can_frame *cf, unsigned int mb);
+	unsigned int (*mailbox_read)(struct can_rx_offload *offload, struct can_frame *cf,
+				     u32 *timestamp, unsigned int mb);
 
 	struct sk_buff_head skb_queue;
 	u32 skb_queue_len_max;
 
+	unsigned int mb_first;
+	unsigned int mb_last;
+
 	struct napi_struct napi;
+
+	bool inc;
 };
 
+int can_rx_offload_add_timestamp(struct net_device *dev, struct can_rx_offload *offload);
 int can_rx_offload_add_fifo(struct net_device *dev, struct can_rx_offload *offload, unsigned int weight);
+int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload, u64 reg);
 int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload);
 int can_rx_offload_irq_queue_err_skb(struct can_rx_offload *offload, struct sk_buff *skb);
 void can_rx_offload_reset(struct can_rx_offload *offload);
-- 
2.11.0

