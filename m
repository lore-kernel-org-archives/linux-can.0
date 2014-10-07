From: David Jander <david@protonic.nl>
Subject: [RFC PATCH 1/2] can: rx-fifo: Increase MB size limit from 32 to 64
Date: Tue,  7 Oct 2014 11:30:04 +0200
Message-ID: <1412674205-23882-1-git-send-email-david@protonic.nl>
References: <20141006131751.75823c82@archvile>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:6941 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbaJGJaI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 7 Oct 2014 05:30:08 -0400
In-Reply-To: <20141006131751.75823c82@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>, David Jander <david@protonic.nl>

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/can/dev.c   | 24 ++++++++++++------------
 include/linux/can/dev.h | 12 ++++++------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index c1e53e9..fe45516 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -289,20 +289,20 @@ static unsigned int can_rx_fifo_inc(struct can_rx_fifo *fifo, unsigned int *val)
 		return (*val)--;
 }
 
-static u32 can_rx_fifo_mask_low(struct can_rx_fifo *fifo)
+static u64 can_rx_fifo_mask_low(struct can_rx_fifo *fifo)
 {
 	if (fifo->inc)
-		return ~0U >> (32 + fifo->low_first - fifo->high_first) << fifo->low_first;
+		return ~0U >> (64 + fifo->low_first - fifo->high_first) << fifo->low_first;
 	else
-		return ~0U >> (32 - fifo->low_first + fifo->high_first) << (fifo->high_first + 1);
+		return ~0U >> (64 - fifo->low_first + fifo->high_first) << (fifo->high_first + 1);
 }
 
-static u32 can_rx_fifo_mask_high(struct can_rx_fifo *fifo)
+static u64 can_rx_fifo_mask_high(struct can_rx_fifo *fifo)
 {
 	if (fifo->inc)
-		return ~0U >> (32 + fifo->high_first - fifo->high_last - 1) << fifo->high_first;
+		return ~0U >> (64 + fifo->high_first - fifo->high_last - 1) << fifo->high_first;
 	else
-		return ~0U >> (32 - fifo->high_first + fifo->high_last - 1) << fifo->high_last;
+		return ~0U >> (64 - fifo->high_first + fifo->high_last - 1) << fifo->high_last;
 }
 
 int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo)
@@ -331,7 +331,7 @@ int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo)
 
 	netdev_dbg(dev, "%s: low_first=%d, high_first=%d, high_last=%d\n", __func__,
 		   fifo->low_first, fifo->high_first, fifo->high_last);
-	netdev_dbg(dev, "%s: mask_low=0x%08x mask_high=0x%08x\n", __func__,
+	netdev_dbg(dev, "%s: mask_low=0x%016llx mask_high=0x%016llx\n", __func__,
 		   fifo->mask_low, fifo->mask_high);
 
 	return 0;
@@ -341,14 +341,14 @@ EXPORT_SYMBOL_GPL(can_rx_fifo_add);
 int can_rx_fifo_poll(struct can_rx_fifo *fifo, int quota)
 {
 	int received = 0;
-	u32 pending;
+	u64 pending;
 	unsigned int mb;
 
 	do {
 		pending = fifo->read_pending(fifo);
 		pending &= fifo->active;
 
-		if (!(pending & BIT(fifo->next))) {
+		if (!(pending & BIT_ULL(fifo->next))) {
 			/*
 			 * Wrap around only if:
 			 * - we are in the upper group and
@@ -356,7 +356,7 @@ int can_rx_fifo_poll(struct can_rx_fifo *fifo, int quota)
 			 *   of the lower group.
 			 */
 			if (can_rx_fifo_ge(fifo, fifo->next, fifo->high_first) &&
-			    (pending & BIT(fifo->low_first))) {
+			    (pending & BIT_ULL(fifo->low_first))) {
 				fifo->next = fifo->low_first;
 
 				fifo->active |= fifo->mask_high;
@@ -369,7 +369,7 @@ int can_rx_fifo_poll(struct can_rx_fifo *fifo, int quota)
 		mb = can_rx_fifo_inc(fifo, &fifo->next);
 
 		/* disable mailbox */
-		fifo->active &= ~BIT(mb);
+		fifo->active &= ~BIT_ULL(mb);
 		fifo->mailbox_disable(fifo, mb);
 
 		fifo->mailbox_receive(fifo, mb);
@@ -387,7 +387,7 @@ int can_rx_fifo_poll(struct can_rx_fifo *fifo, int quota)
 }
 EXPORT_SYMBOL_GPL(can_rx_fifo_poll);
 
-u32 can_rx_fifo_get_active_mb_mask(const struct can_rx_fifo *fifo)
+u64 can_rx_fifo_get_active_mb_mask(const struct can_rx_fifo *fifo)
 {
 	return fifo->active;
 }
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index e9468d0..ed46f7d 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -71,14 +71,14 @@ struct can_rx_fifo {
 	unsigned int high_first;
 	unsigned int high_last;		/* not needed during runtime */
 
-	u32 (*read_pending)(struct can_rx_fifo *rx_fifo);
-	void (*mailbox_enable_mask)(struct can_rx_fifo *rx_fifo, u32 mask);
+	u64 (*read_pending)(struct can_rx_fifo *rx_fifo);
+	void (*mailbox_enable_mask)(struct can_rx_fifo *rx_fifo, u64 mask);
 	void (*mailbox_disable)(struct can_rx_fifo *rx_fifo, unsigned int mb);
 	void (*mailbox_receive)(struct can_rx_fifo *rx_fifo, unsigned int mb);
 
-	u32 mask_low;
-	u32 mask_high;
-	u32 active;
+	u64 mask_low;
+	u64 mask_high;
+	u64 active;
 
 	unsigned int next;
 
@@ -128,7 +128,7 @@ u8 can_len2dlc(u8 len);
 
 int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo);
 int can_rx_fifo_poll(struct can_rx_fifo *fifo, int quota);
-u32 can_rx_fifo_get_active_mb_mask(const struct can_rx_fifo *fifo);
+u64 can_rx_fifo_get_active_mb_mask(const struct can_rx_fifo *fifo);
 
 struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max);
 void free_candev(struct net_device *dev);
-- 
1.9.1

