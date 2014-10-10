From: David Jander <david@protonic.nl>
Subject: [PATCH 13/15] can: rx-fifo: Add support for simple irq offloading
Date: Fri, 10 Oct 2014 17:46:58 +0200
Message-ID: <1412956020-21489-14-git-send-email-david@protonic.nl>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:18410 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbaJJPrE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Oct 2014 11:47:04 -0400
In-Reply-To: <1412956020-21489-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>, David Jander <david@protonic.nl>

Some CAN controllers have a usable FIFO already but can still benefit from
off-loading the CAN controller FIFO in the interrupt into an extra ring-
buffer. Add support for these simpler cases also.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/can/dev.c   | 76 ++++++++++++++++++++++++++++++++++++++++---------
 include/linux/can/dev.h |  2 ++
 2 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index dac7579..278aea3 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -384,10 +384,32 @@ restart_poll:
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
 int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo)
 {
 	unsigned int weight;
-	fifo->dev = dev;
+	int ret;
 
 	if ((fifo->low_first < fifo->high_first) &&
 	    (fifo->high_first < fifo->high_last)) {
@@ -405,23 +427,14 @@ int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo)
 	    !fifo->poll_can_state)
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
 	fifo->mask_high = can_rx_fifo_mask_high(fifo);
 	fifo->second_first = false;
-	fifo->poll_errors = false;
 	fifo->active = fifo->mask_low | fifo->mask_high;
 	fifo->mailbox_enable_mask(fifo, fifo->active);
 
@@ -434,6 +447,26 @@ int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo)
 }
 EXPORT_SYMBOL_GPL(can_rx_fifo_add);
 
+int can_rx_fifo_add_simple(struct net_device *dev, struct can_rx_fifo *fifo)
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
+EXPORT_SYMBOL_GPL(can_rx_fifo_add_simple);
+
 static unsigned int can_rx_fifo_offload_if_full(struct can_rx_fifo *fifo, unsigned int n)
 {
 	unsigned int head = fifo->ring_head;
@@ -513,6 +546,23 @@ int can_rx_fifo_irq_offload(struct can_rx_fifo *fifo)
 }
 EXPORT_SYMBOL_GPL(can_rx_fifo_irq_offload);
 
+int can_rx_fifo_irq_offload_simple(struct can_rx_fifo *fifo)
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
+EXPORT_SYMBOL_GPL(can_rx_fifo_irq_offload_simple);
+
 void can_rx_fifo_irq_error(struct can_rx_fifo *fifo)
 {
 	fifo->poll_errors = true;
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index e1ed6d4..18feef3 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -142,7 +142,9 @@ u8 can_dlc2len(u8 can_dlc);
 u8 can_len2dlc(u8 len);
 
 int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo);
+int can_rx_fifo_add_simple(struct net_device *dev, struct can_rx_fifo *fifo);
 int can_rx_fifo_irq_offload(struct can_rx_fifo *fifo);
+int can_rx_fifo_irq_offload_simple(struct can_rx_fifo *fifo);
 void can_rx_fifo_irq_error(struct can_rx_fifo *fifo);
 void can_rx_fifo_napi_enable(struct can_rx_fifo *fifo);
 void can_rx_fifo_napi_disable(struct can_rx_fifo *fifo);
-- 
1.9.1

