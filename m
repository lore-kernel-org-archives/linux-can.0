From: David Jander <david@protonic.nl>
Subject: [RFC PATCH 2/2] can: rx-fifo: Add support for IRQ readout and NAPI poll
Date: Tue,  7 Oct 2014 11:30:05 +0200
Message-ID: <1412674205-23882-2-git-send-email-david@protonic.nl>
References: <20141006131751.75823c82@archvile>
 <1412674205-23882-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:6947 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbaJGJaN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 7 Oct 2014 05:30:13 -0400
In-Reply-To: <1412674205-23882-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>, David Jander <david@protonic.nl>

WIP!
The idea is to use rx-fifo from interrupt context and take away the need
for NAPI polling from the driver. Currently no support for error-handling
is included.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/can/dev.c   | 116 +++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/can/dev.h |   8 ++++
 2 files changed, 118 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index fe45516..6efceb7 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -26,6 +26,7 @@
 #include <linux/can/skb.h>
 #include <linux/can/netlink.h>
 #include <linux/can/led.h>
+#include <linux/circ_buf.h>
 #include <net/rtnetlink.h>
 
 #define MOD_DESC "CAN device driver interface"
@@ -305,23 +306,86 @@ static u64 can_rx_fifo_mask_high(struct can_rx_fifo *fifo)
 		return ~0U >> (64 - fifo->high_first + fifo->high_last - 1) << fifo->high_last;
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
+	if (work_done < quota)
+		napi_complete(napi);
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
 
 	if (!fifo->read_pending || !fifo->mailbox_enable_mask ||
-	    !fifo->mailbox_disable || !fifo->mailbox_receive)
+	    !fifo->mailbox_disable ||
+	    (!fifo->mailbox_receive && !fifo->mailbox_move_to_buffer))
 		return -EINVAL;
 
+	if (fifo->mailbox_move_to_buffer) {
+		/* Make ring-buffer a sensible size that is a power of 2 */
+		fifo->ring_size = (2 << fls(weight));
+		fifo->ring = kzalloc(sizeof(struct can_frame) * fifo->ring_size,
+				     GFP_KERNEL);
+		if (!fifo->ring)
+			return -ENOMEM;
+
+		/* Take care of NAPI handling */
+		netif_napi_add(dev, &fifo->napi, can_rx_fifo_napi_poll, weight);
+	}
+
 	/* init variables */
 	fifo->mask_low = can_rx_fifo_mask_low(fifo);
 	fifo->mask_high = can_rx_fifo_mask_high(fifo);
@@ -343,6 +407,7 @@ int can_rx_fifo_poll(struct can_rx_fifo *fifo, int quota)
 	int received = 0;
 	u64 pending;
 	unsigned int mb;
+	unsigned int head, tail;
 
 	do {
 		pending = fifo->read_pending(fifo);
@@ -372,7 +437,17 @@ int can_rx_fifo_poll(struct can_rx_fifo *fifo, int quota)
 		fifo->active &= ~BIT_ULL(mb);
 		fifo->mailbox_disable(fifo, mb);
 
-		fifo->mailbox_receive(fifo, mb);
+		if (fifo->mailbox_move_to_buffer) {
+			head = fifo->ring_head;
+			tail = ACCESS_ONCE(fifo->ring_tail);
+			if (CIRC_SPACE(head, tail, fifo->ring_size) < 1)
+				break;
+			fifo->mailbox_move_to_buffer(fifo, &fifo->ring[head], mb);
+			smp_store_release(&fifo->ring_head,
+				(head + 1) & (fifo->ring_size - 1));
+		} else {
+			fifo->mailbox_receive(fifo, mb);
+		}
 
 		if (fifo->next == fifo->high_first) {
 			fifo->active |= fifo->mask_low;
@@ -383,6 +458,9 @@ int can_rx_fifo_poll(struct can_rx_fifo *fifo, int quota)
 		quota--;
 	} while (quota);
 
+	if (received && fifo->mailbox_move_to_buffer)
+		napi_schedule(&fifo->napi);
+
 	return received;
 }
 EXPORT_SYMBOL_GPL(can_rx_fifo_poll);
@@ -393,6 +471,32 @@ u64 can_rx_fifo_get_active_mb_mask(const struct can_rx_fifo *fifo)
 }
 EXPORT_SYMBOL_GPL(can_rx_fifo_get_active_mb_mask);
 
+int can_rx_fifo_irq_offload(struct can_rx_fifo *fifo)
+{
+	return can_rx_fifo_poll(fifo, 64);
+}
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
+
+void can_rx_fifo_del(struct can_rx_fifo *fifo)
+{
+	if (fifo->ring)
+		kfree(fifo->ring);
+	netif_napi_del(&fifo->napi);
+}
+EXPORT_SYMBOL_GPL(can_rx_fifo_del);
+
 /*
  * Local echo of CAN messages
  *
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index ed46f7d..b71f30f 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -75,6 +75,8 @@ struct can_rx_fifo {
 	void (*mailbox_enable_mask)(struct can_rx_fifo *rx_fifo, u64 mask);
 	void (*mailbox_disable)(struct can_rx_fifo *rx_fifo, unsigned int mb);
 	void (*mailbox_receive)(struct can_rx_fifo *rx_fifo, unsigned int mb);
+	void (*mailbox_move_to_buffer)(struct can_rx_fifo *rx_fifo,
+		struct can_frame *frame, unsigned int mb);
 
 	u64 mask_low;
 	u64 mask_high;
@@ -83,6 +85,12 @@ struct can_rx_fifo {
 	unsigned int next;
 
 	bool inc;
+
+	struct can_frame *ring;		/* Used by can_rx_fifo_irq_offload */
+	size_t ring_size;
+	unsigned int ring_head;
+	unsigned int ring_tail;
+	struct napi_struct napi;
 };
 
 /*
-- 
1.9.1

