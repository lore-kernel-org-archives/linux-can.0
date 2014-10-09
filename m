From: David Jander <david@protonic.nl>
Subject: [RFC V2 PATCH 2/2] can: rx-fifo: Change to do controller off-load in interrupt and NAPI poll
Date: Thu,  9 Oct 2014 12:18:04 +0200
Message-ID: <1412849884-15004-2-git-send-email-david@protonic.nl>
References: <1412849884-15004-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:14498 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbaJIKSL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Oct 2014 06:18:11 -0400
In-Reply-To: <1412849884-15004-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>, David Jander <david@protonic.nl>

WIP
The idea is to use rx-fifo from interrupt context and take away the need
for NAPI polling from the driver. Currently no support for error-handling
is included.

Signed-off-by: David Jander <david@protonic.nl>
---

Changed since V1:
 - Nearly total re-write.
 - Removed support for fifo-in-napi-poll.

 drivers/net/can/dev.c   | 213 +++++++++++++++++++++++++++++++++++++-----------
 include/linux/can/dev.h |  21 +++--
 2 files changed, 180 insertions(+), 54 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 930b9f4..9abd5a4 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -26,6 +26,7 @@
 #include <linux/can/skb.h>
 #include <linux/can/netlink.h>
 #include <linux/can/led.h>
+#include <linux/circ_buf.h>
 #include <net/rtnetlink.h>
 
 #define MOD_DESC "CAN device driver interface"
@@ -281,6 +282,14 @@ static bool can_rx_fifo_ge(struct can_rx_fifo *fifo, unsigned int a, unsigned in
 		return a <= b;
 }
 
+static bool can_rx_fifo_le(struct can_rx_fifo *fifo, unsigned int a, unsigned int b)
+{
+	if (fifo->inc)
+		return a <= b;
+	else
+		return a >= b;
+}
+
 static unsigned int can_rx_fifo_inc(struct can_rx_fifo *fifo, unsigned int *val)
 {
 	if (fifo->inc)
@@ -305,27 +314,100 @@ static u64 can_rx_fifo_mask_high(struct can_rx_fifo *fifo)
 		return ~0LLU >> (64 - fifo->high_first + fifo->high_last - 1) << fifo->high_last;
 }
 
+static int can_rx_fifo_read_napi_frame(struct can_rx_fifo *fifo, int index)
+{
+	struct net_device *dev = fifo->dev;
+	struct net_device_stats *stats = &dev->stats;
+	struct sk_buff *skb;
+	struct can_frame *cf;
+
+	skb = alloc_can_skb(dev, &cf);
+	if (unlikely(!skb)) {
+		stats->rx_dropped++;
+		return 0;
+	}
+
+	memcpy(cf, &fifo->ring[index], sizeof(*cf));
+
+	netif_receive_skb(skb);
+
+	stats->rx_packets++;
+	stats->rx_bytes += cf->can_dlc;
+
+	can_led_event(dev, CAN_LED_EVENT_RX);
+
+	return 1;
+}
+
+static int can_rx_fifo_napi_poll(struct napi_struct *napi, int quota)
+{
+	struct can_rx_fifo *fifo = container_of(napi, struct can_rx_fifo, napi);
+	int work_done = 0;
+	int ret;
+	unsigned int head;
+	unsigned int tail;
+
+restart_poll:
+	/* handle mailboxes */
+	head = smp_load_acquire(&fifo->ring_head);
+	tail = fifo->ring_tail;
+	while ((CIRC_CNT(head, tail, fifo->ring_size) >= 1) &&
+			(work_done < quota)) {
+		ret = can_rx_fifo_read_napi_frame(fifo, tail);
+		work_done += ret;
+		tail = (tail + 1) & (fifo->ring_size -1);
+		smp_store_release(&fifo->ring_tail, tail);
+	}
+
+	if (work_done < quota) {
+		napi_complete(napi);
+
+		/* Check if there was another interrupt */
+		head = smp_load_acquire(&fifo->ring_head);
+		if ((CIRC_CNT(head, tail, fifo->ring_size) >= 1) &&
+		    napi_reschedule(&fifo->napi))
+			goto restart_poll;
+	}
+
+	return work_done;
+}
+
 int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo)
 {
+	unsigned int weight;
 	fifo->dev = dev;
 
 	if ((fifo->low_first < fifo->high_first) &&
-	    (fifo->high_first < fifo->high_last))
+	    (fifo->high_first < fifo->high_last)) {
 		fifo->inc = true;
-	else if ((fifo->low_first > fifo->high_first) &&
-		 (fifo->high_first > fifo->high_last))
+		weight = fifo->high_last - fifo->low_first;
+	} else if ((fifo->low_first > fifo->high_first) &&
+		 (fifo->high_first > fifo->high_last)) {
 		fifo->inc = false;
-	else
+		weight = fifo->low_first - fifo->high_last;
+	} else
 		return -EINVAL;
 
-	if (!fifo->read_pending || !fifo->mailbox_enable_mask ||
-	    !fifo->mailbox_disable || !fifo->mailbox_receive)
+	if (!fifo->mailbox_enable_mask || !fifo->mailbox_move_to_buffer ||
+	    !fifo->mailbox_enable)
 		return -EINVAL;
 
+	/* Make ring-buffer a sensible size that is a power of 2 */
+	fifo->ring_size = (2 << fls(weight));
+	fifo->ring = kzalloc(sizeof(struct can_frame) * fifo->ring_size,
+			     GFP_KERNEL);
+	if (!fifo->ring)
+		return -ENOMEM;
+
+	fifo->ring_head = fifo->ring_tail = 0;
+
+	/* Take care of NAPI handling */
+	netif_napi_add(dev, &fifo->napi, can_rx_fifo_napi_poll, weight);
+
 	/* init variables */
 	fifo->mask_low = can_rx_fifo_mask_low(fifo);
 	fifo->mask_high = can_rx_fifo_mask_high(fifo);
-	fifo->next = fifo->low_first;
+	fifo->second_first = 0;
 	fifo->active = fifo->mask_low | fifo->mask_high;
 	fifo->mailbox_enable_mask(fifo, fifo->active);
 
@@ -338,60 +420,95 @@ int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo)
 }
 EXPORT_SYMBOL_GPL(can_rx_fifo_add);
 
-int can_rx_fifo_poll(struct can_rx_fifo *fifo, int quota)
+static unsigned int can_rx_fifo_offload_if_full(struct can_rx_fifo *fifo, unsigned int n)
+{
+	unsigned int head = fifo->ring_head;
+	unsigned int tail = ACCESS_ONCE(fifo->ring_tail);
+	unsigned int ret = 0;
+
+	if (CIRC_SPACE(head, tail, fifo->ring_size) >= 1) {
+		ret = fifo->mailbox_move_to_buffer(fifo, &fifo->ring[head], n);
+		if (ret)
+			smp_store_release(&fifo->ring_head,
+				(head + 1) & (fifo->ring_size - 1));
+	} else {
+		ret = fifo->mailbox_move_to_buffer(fifo, &fifo->overflow, n);
+		if (ret)
+			fifo->dev->stats.rx_dropped++;
+	}
+	return ret;
+}
+
+int can_rx_fifo_irq_offload(struct can_rx_fifo *fifo)
 {
-	int received = 0;
-	u64 pending;
-	unsigned int mb;
-
-	do {
-		pending = fifo->read_pending(fifo);
-		pending &= fifo->active;
-
-		if (!(pending & BIT_ULL(fifo->next))) {
-			/*
-			 * Wrap around only if:
-			 * - we are in the upper group and
-			 * - there is a CAN frame in the first mailbox
-			 *   of the lower group.
-			 */
-			if (can_rx_fifo_ge(fifo, fifo->next, fifo->high_first) &&
-			    (pending & BIT_ULL(fifo->low_first))) {
-				fifo->next = fifo->low_first;
-
-				fifo->active |= fifo->mask_high;
-				fifo->mailbox_enable_mask(fifo, fifo->mask_high);
-			} else {
-				break;
-			}
+	unsigned int i;
+	unsigned int ret;
+	unsigned int received = 0;
+
+	if (fifo->second_first) {
+		for (i = fifo->high_first;
+		     can_rx_fifo_le(fifo, i, fifo->high_last);
+		     can_rx_fifo_inc(fifo, &i)) {
+			received += can_rx_fifo_offload_if_full(fifo, i);
+			fifo->active |= BIT_ULL(i);
+			fifo->mailbox_enable(fifo, i);
 		}
+	}
 
-		mb = can_rx_fifo_inc(fifo, &fifo->next);
+	/* Copy and disable FULL MBs */
+	for (i = fifo->low_first; can_rx_fifo_le(fifo, i, fifo->high_last);
+			can_rx_fifo_inc(fifo, &i)) {
+		if (!(fifo->active & BIT_ULL(i)))
+			continue;
+		ret = can_rx_fifo_offload_if_full(fifo, i);
+		if (!ret)
+			break;
+		received += ret;
+		fifo->active &= ~BIT_ULL(i);
+	}
 
-		/* disable mailbox */
-		fifo->active &= ~BIT_ULL(mb);
-		fifo->mailbox_disable(fifo, mb);
+	if (can_rx_fifo_ge(fifo, i, fifo->high_first) && fifo->second_first)
+		netdev_warn(fifo->dev, "%s: RX order cannot be guaranteed."
+			" (count=%d)\n", __FUNCTION__, i);
 
-		fifo->mailbox_receive(fifo, mb);
+	fifo->second_first = false;
 
-		if (fifo->next == fifo->high_first) {
-			fifo->active |= fifo->mask_low;
-			fifo->mailbox_enable_mask(fifo, fifo->mask_low);
-		}
+	/* No EMPTY MB in first half? */
+	if (can_rx_fifo_ge(fifo, i, fifo->high_first)) {
+		/* Re-enable all disabled MBs */
+		fifo->active = fifo->mask_low | fifo->mask_high;
+		fifo->mailbox_enable_mask(fifo, fifo->active);
+
+		/* Next time we need to check the second half first */
+		fifo->second_first = true;
+	}
 
-		received++;
-		quota--;
-	} while (quota);
+	if (received)
+		napi_schedule(&fifo->napi);
 
 	return received;
 }
-EXPORT_SYMBOL_GPL(can_rx_fifo_poll);
+EXPORT_SYMBOL_GPL(can_rx_fifo_irq_offload);
+
+void can_rx_fifo_napi_enable(struct can_rx_fifo *fifo)
+{
+	napi_enable(&fifo->napi);
+}
+EXPORT_SYMBOL_GPL(can_rx_fifo_napi_enable);
+
+void can_rx_fifo_napi_disable(struct can_rx_fifo *fifo)
+{
+	napi_disable(&fifo->napi);
+}
+EXPORT_SYMBOL_GPL(can_rx_fifo_napi_disable);
 
-u64 can_rx_fifo_get_active_mb_mask(const struct can_rx_fifo *fifo)
+void can_rx_fifo_del(struct can_rx_fifo *fifo)
 {
-	return fifo->active;
+	if (fifo->ring)
+		kfree(fifo->ring);
+	netif_napi_del(&fifo->napi);
 }
-EXPORT_SYMBOL_GPL(can_rx_fifo_get_active_mb_mask);
+EXPORT_SYMBOL_GPL(can_rx_fifo_del);
 
 /*
  * Local echo of CAN messages
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index ed46f7d..64a8de3 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -71,18 +71,25 @@ struct can_rx_fifo {
 	unsigned int high_first;
 	unsigned int high_last;		/* not needed during runtime */
 
-	u64 (*read_pending)(struct can_rx_fifo *rx_fifo);
 	void (*mailbox_enable_mask)(struct can_rx_fifo *rx_fifo, u64 mask);
-	void (*mailbox_disable)(struct can_rx_fifo *rx_fifo, unsigned int mb);
-	void (*mailbox_receive)(struct can_rx_fifo *rx_fifo, unsigned int mb);
+	void (*mailbox_enable)(struct can_rx_fifo *rx_fifo, unsigned int mb);
+	unsigned int (*mailbox_move_to_buffer)(struct can_rx_fifo *rx_fifo,
+		struct can_frame *frame, unsigned int mb);
 
 	u64 mask_low;
 	u64 mask_high;
 	u64 active;
 
-	unsigned int next;
+	unsigned int second_first;
 
 	bool inc;
+
+	struct can_frame *ring;
+	struct can_frame overflow;
+	size_t ring_size;
+	unsigned int ring_head;
+	unsigned int ring_tail;
+	struct napi_struct napi;
 };
 
 /*
@@ -127,8 +134,10 @@ u8 can_dlc2len(u8 can_dlc);
 u8 can_len2dlc(u8 len);
 
 int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo);
-int can_rx_fifo_poll(struct can_rx_fifo *fifo, int quota);
-u64 can_rx_fifo_get_active_mb_mask(const struct can_rx_fifo *fifo);
+int can_rx_fifo_irq_offload(struct can_rx_fifo *fifo);
+void can_rx_fifo_napi_enable(struct can_rx_fifo *fifo);
+void can_rx_fifo_napi_disable(struct can_rx_fifo *fifo);
+void can_rx_fifo_del(struct can_rx_fifo *fifo);
 
 struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max);
 void free_candev(struct net_device *dev);
-- 
1.9.1

