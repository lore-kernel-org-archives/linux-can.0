From: David Jander <david@protonic.nl>
Subject: [PATCH 11/15] can: rx-fifo: Add support for can state tracking and error polling
Date: Fri, 10 Oct 2014 17:46:56 +0200
Message-ID: <1412956020-21489-12-git-send-email-david@protonic.nl>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:18407 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbaJJPrD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Oct 2014 11:47:03 -0400
In-Reply-To: <1412956020-21489-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>, David Jander <david@protonic.nl>

The interrupt handler should store the error flags if needed and call
can_rx_fifo_irq_error() if there was an error flag set. This will trigger
a napi-poll that will call poll_can_state() and poll_bus_error()
callbacks. Those should handle can state machine and send error frames
as needed.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/can/dev.c   | 23 ++++++++++++++++++++---
 include/linux/can/dev.h |  9 +++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index fc35d28..dac7579 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -352,6 +352,9 @@ static int can_rx_fifo_napi_poll(struct napi_struct *napi, int quota)
 	unsigned int tail;
 
 restart_poll:
+	if (work_done < quota)
+		work_done += fifo->poll_can_state(fifo);
+
 	/* handle mailboxes */
 	head = smp_load_acquire(&fifo->ring_head);
 	tail = fifo->ring_tail;
@@ -363,14 +366,19 @@ restart_poll:
 		smp_store_release(&fifo->ring_tail, tail);
 	}
 
+	if (work_done < quota)
+		work_done += fifo->poll_bus_error(fifo);
+
 	if (work_done < quota) {
 		napi_complete(napi);
 
 		/* Check if there was another interrupt */
 		head = smp_load_acquire(&fifo->ring_head);
-		if ((CIRC_CNT(head, tail, fifo->ring_size) >= 1) &&
-		    napi_reschedule(&fifo->napi))
+		if (((CIRC_CNT(head, tail, fifo->ring_size) >= 1) ||
+		    fifo->poll_errors) && napi_reschedule(&fifo->napi)) {
+			fifo->poll_errors = false;
 			goto restart_poll;
+		}
 	}
 
 	return work_done;
@@ -393,7 +401,8 @@ int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo)
 		return -EINVAL;
 
 	if (!fifo->mailbox_enable_mask || !fifo->mailbox_move_to_buffer ||
-	    !fifo->mailbox_enable)
+	    !fifo->mailbox_enable || !fifo->poll_bus_error ||
+	    !fifo->poll_can_state)
 		return -EINVAL;
 
 	/* Make ring-buffer a sensible size that is a power of 2 */
@@ -412,6 +421,7 @@ int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo)
 	fifo->mask_low = can_rx_fifo_mask_low(fifo);
 	fifo->mask_high = can_rx_fifo_mask_high(fifo);
 	fifo->second_first = false;
+	fifo->poll_errors = false;
 	fifo->active = fifo->mask_low | fifo->mask_high;
 	fifo->mailbox_enable_mask(fifo, fifo->active);
 
@@ -503,6 +513,13 @@ int can_rx_fifo_irq_offload(struct can_rx_fifo *fifo)
 }
 EXPORT_SYMBOL_GPL(can_rx_fifo_irq_offload);
 
+void can_rx_fifo_irq_error(struct can_rx_fifo *fifo)
+{
+	fifo->poll_errors = true;
+	can_rx_fifo_napi_schedule(fifo);
+}
+EXPORT_SYMBOL_GPL(can_rx_fifo_irq_error);
+
 void can_rx_fifo_napi_enable(struct can_rx_fifo *fifo)
 {
 	napi_enable(&fifo->napi);
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index c49c37b..e1ed6d4 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -75,12 +75,15 @@ struct can_rx_fifo {
 	void (*mailbox_enable)(struct can_rx_fifo *rx_fifo, unsigned int mb);
 	unsigned int (*mailbox_move_to_buffer)(struct can_rx_fifo *rx_fifo,
 		struct can_frame *frame, unsigned int mb);
+	unsigned int (*poll_can_state)(struct can_rx_fifo *rx_fifo);
+	unsigned int (*poll_bus_error)(struct can_rx_fifo *rx_fifo);
 
 	u64 mask_low;
 	u64 mask_high;
 	u64 active;
 
 	unsigned int second_first;
+	bool poll_errors;
 
 	bool inc;
 
@@ -92,6 +95,11 @@ struct can_rx_fifo {
 	struct napi_struct napi;
 };
 
+static inline void can_rx_fifo_napi_schedule(struct can_rx_fifo *fifo)
+{
+	napi_schedule(&fifo->napi);
+}
+
 /*
  * get_can_dlc(value) - helper macro to cast a given data length code (dlc)
  * to __u8 and ensure the dlc value to be max. 8 bytes.
@@ -135,6 +143,7 @@ u8 can_len2dlc(u8 len);
 
 int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo);
 int can_rx_fifo_irq_offload(struct can_rx_fifo *fifo);
+void can_rx_fifo_irq_error(struct can_rx_fifo *fifo);
 void can_rx_fifo_napi_enable(struct can_rx_fifo *fifo);
 void can_rx_fifo_napi_disable(struct can_rx_fifo *fifo);
 void can_rx_fifo_reset(struct can_rx_fifo *fifo);
-- 
1.9.1

