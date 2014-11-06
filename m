From: David Jander <david@protonic.nl>
Subject: [PATCH 08/14] can: rx-fifo: Add support for simple irq offloading
Date: Thu,  6 Nov 2014 09:34:07 +0100
Message-ID: <1415262853-22907-9-git-send-email-david@protonic.nl>
References: <1415262853-22907-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:26402 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbaKFIeI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Nov 2014 03:34:08 -0500
In-Reply-To: <1415262853-22907-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>, David Jander <david@protonic.nl>

Some CAN controllers have a usable FIFO already but can still benefit from
off-loading the CAN controller FIFO in the interrupt into an extra ring-
buffer. Add support for these simpler cases also.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/can/dev.c   | 79 +++++++++++++++++++++++++++++++++++++++++--------
 include/linux/can/dev.h |  2 ++
 2 files changed, 69 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index ffa4f60..2741d42 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -384,10 +384,54 @@ restart_poll:
 	return work_done;
 }
 
+static int can_rx_fifo_init_ring(struct net_device *dev,
+		struct can_rx_fifo *fifo, unsigned int weight)
+{
+	fifo->dev = dev;
+
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
+	fifo->poll_errors = false;
+
+	return 0;
+}
+
+static int can_rx_fifo_add_simple(struct net_device *dev, struct can_rx_fifo *fifo)
+{
+	int ret;
+
+	if (!fifo->mailbox_move_to_buffer || !fifo->poll_bus_error ||
+	    !fifo->poll_can_state)
+		return -EINVAL;
+
+	ret = can_rx_fifo_init_ring(dev, fifo, 64);
+	if (ret)
+		return ret;
+
+	/* init variables */
+	fifo->mask_low = 0;
+	fifo->mask_high = 0;
+
+	return 0;
+}
+
 int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo)
 {
 	unsigned int weight;
-	fifo->dev = dev;
+	int ret;
+
+	if (fifo->simple_offload)
+		return can_rx_fifo_add_simple(dev, fifo);
 
 	if ((fifo->low_first < fifo->high_first) &&
 	    (fifo->high_first < fifo->high_last)) {
@@ -405,17 +449,9 @@ int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo)
 	    !fifo->mailbox_enable)
 		return -EINVAL;
 
-	/* Make ring-buffer a sensible size that is a power of 2 */
-	fifo->ring_size = (2 << fls(weight));
-	fifo->ring = kzalloc(sizeof(struct can_frame) * fifo->ring_size,
-			     GFP_KERNEL);
-	if (!fifo->ring)
-		return -ENOMEM;
-
-	fifo->ring_head = fifo->ring_tail = 0;
-
-	/* Take care of NAPI handling */
-	netif_napi_add(dev, &fifo->napi, can_rx_fifo_napi_poll, weight);
+	ret = can_rx_fifo_init_ring(dev, fifo, weight);
+	if (ret)
+		return ret;
 
 	/* init variables */
 	fifo->mask_low = can_rx_fifo_mask_low(fifo);
@@ -453,12 +489,31 @@ static unsigned int can_rx_fifo_offload_if_full(struct can_rx_fifo *fifo, unsign
 	return ret;
 }
 
+static int can_rx_fifo_irq_offload_simple(struct can_rx_fifo *fifo)
+{
+	unsigned int received = 0;
+	unsigned int ret;
+
+	do {
+		ret = can_rx_fifo_offload_if_full(fifo, 0);
+		received += ret;
+	} while (ret);
+
+	if (received)
+		can_rx_fifo_napi_schedule(fifo);
+
+	return received;
+}
+
 int can_rx_fifo_irq_offload(struct can_rx_fifo *fifo)
 {
 	unsigned int i;
 	unsigned int ret;
 	unsigned int received = 0;
 
+	if (fifo->simple_offload)
+		return can_rx_fifo_irq_offload_simple(fifo);
+
 	if (fifo->scan_high_first) {
 		for (i = fifo->high_first;
 		     can_rx_fifo_le(fifo, i, fifo->high_last);
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index a44108d..c8b8519 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -71,6 +71,8 @@ struct can_rx_fifo {
 	unsigned int high_first;
 	unsigned int high_last;
 
+	bool simple_offload;
+
 	void (*mailbox_enable_mask)(struct can_rx_fifo *rx_fifo, u64 mask);
 	void (*mailbox_enable)(struct can_rx_fifo *rx_fifo, unsigned int mb);
 	unsigned int (*mailbox_move_to_buffer)(struct can_rx_fifo *rx_fifo,
-- 
1.9.1

