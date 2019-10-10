From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 16/29] can: rx-offload: can_rx_offload_offload_one(): use ERR_PTR() to propagate error value in case of errors
Date: Thu, 10 Oct 2019 14:17:37 +0200
Message-ID: <20191010121750.27237-17-mkl@pengutronix.de>
References: <20191010121750.27237-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191010121750.27237-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, linux-can <linux-can@vger.kernel.org>
Cc: davem@davemloft.net, kernel@pengutronix.de, jhofstee@victronenergy.com, =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

Before this patch can_rx_offload_offload_one() returns a pointer to a
skb containing the read CAN frame or a NULL pointer.

However the meaning of the NULL pointer is ambiguous, it can either mean
the requested mailbox is empty or there was an error.

This patch fixes this situation by returning:
- pointer to skb on success
- NULL pointer if mailbox is empty
- ERR_PTR(-ENOBUFS), if the maximal queue len is reached and a CAN frame
  is dropped.
- ERR_PTR(-ENOMEM) if no skb can be allocated and a CAN frame is
  dropped.

All users of can_rx_offload_offload_one() have been adopted, no
functional change intended.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rx-offload.c | 54 ++++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
index e224530a0630..2325890bbd14 100644
--- a/drivers/net/can/rx-offload.c
+++ b/drivers/net/can/rx-offload.c
@@ -107,29 +107,67 @@ static int can_rx_offload_compare(struct sk_buff *a, struct sk_buff *b)
 	return cb_b->timestamp - cb_a->timestamp;
 }
 
-static struct sk_buff *can_rx_offload_offload_one(struct can_rx_offload *offload, unsigned int n)
+/**
+ * can_rx_offload_offload_one() - Read one CAN frame from HW
+ * @offload: pointer to rx_offload context
+ * @n: number of mailbox to read
+ *
+ * The task of this function is to read a CAN frame from mailbox @n
+ * from the device and return the mailbox's content as a struct
+ * sk_buff.
+ *
+ * If the struct can_rx_offload::skb_queue exceeds the maximal queue
+ * length (struct can_rx_offload::skb_queue_len_max) or no skb can be
+ * allocated, the mailbox contents is discarded by reading it into an
+ * overflow buffer. This way the mailbox is marked as free by the
+ * driver.
+ *
+ * Return: A pointer to skb containing the CAN frame on success.
+ *
+ *         NULL if the mailbox @n is empty.
+ *
+ *         ERR_PTR(-ENOBUFS) if the maximal queue len is reached and a
+ *         CAN frame is dropped.
+ *
+ *         ERR_PTR(-ENOMEM) if no skb can be allocated and a CAN frame
+ *         is dropped.
+ */
+static struct sk_buff *
+can_rx_offload_offload_one(struct can_rx_offload *offload, unsigned int n)
 {
-	struct sk_buff *skb = NULL;
+	struct sk_buff *skb = NULL, *skb_error;
 	struct can_rx_offload_cb *cb;
 	struct can_frame *cf;
 	int ret;
 
-	/* If queue is full or skb not available, read to discard mailbox */
 	if (likely(skb_queue_len(&offload->skb_queue) <
-		   offload->skb_queue_len_max))
+		   offload->skb_queue_len_max)) {
 		skb = alloc_can_skb(offload->dev, &cf);
+		if (!skb)
+			skb_error = ERR_PTR(-ENOMEM);	/* skb alloc failed */
+	} else {
+		skb_error = ERR_PTR(-ENOBUFS);		/* skb_queue is full */
+	}
 
+	/* If queue is full or skb not available, drop by reading into
+	 * overflow buffer.
+	 */
 	if (!skb) {
 		struct can_frame cf_overflow;
 		u32 timestamp;
 
 		ret = offload->mailbox_read(offload, &cf_overflow,
 					    &timestamp, n);
+
+		/* A frame has been read and dropped. */
 		if (ret) {
 			offload->dev->stats.rx_dropped++;
 			offload->dev->stats.rx_fifo_errors++;
+
+			return skb_error;
 		}
 
+		/* No frame was read. */
 		return NULL;
 	}
 
@@ -159,7 +197,7 @@ int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload, u64 pen
 			continue;
 
 		skb = can_rx_offload_offload_one(offload, i);
-		if (!skb)
+		if (IS_ERR_OR_NULL(skb))
 			break;
 
 		__skb_queue_add_sort(&skb_queue, skb, can_rx_offload_compare);
@@ -190,7 +228,11 @@ int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload)
 	struct sk_buff *skb;
 	int received = 0;
 
-	while ((skb = can_rx_offload_offload_one(offload, 0))) {
+	while (1) {
+		skb = can_rx_offload_offload_one(offload, 0);
+		if (IS_ERR_OR_NULL(skb))
+			break;
+
 		skb_queue_tail(&offload->skb_queue, skb);
 		received++;
 	}
-- 
2.23.0
