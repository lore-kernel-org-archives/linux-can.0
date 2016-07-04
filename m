From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 01/12] can: rx-offload: Add support for HW fifo based irq offloading
Date: Mon,  4 Jul 2016 20:32:06 +0200
Message-ID: <1467657137-18891-2-git-send-email-mkl@pengutronix.de>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41741 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753161AbcGDScW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 4 Jul 2016 14:32:22 -0400
In-Reply-To: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

From: David Jander <david@protonic.nl>

Some CAN controllers have a usable FIFO already but can still benefit
from off-loading the CAN controller FIFO. The CAN frames of the FIFO are
read and put into a skb queue during interrupt and then transmitted in a
NAPI context.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/Makefile       |   3 +-
 drivers/net/can/rx-offload.c   | 163 +++++++++++++++++++++++++++++++++++++++++
 include/linux/can/rx-offload.h |  56 ++++++++++++++
 3 files changed, 221 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/can/rx-offload.c
 create mode 100644 include/linux/can/rx-offload.h

diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 26ba4b794a0b..04621f202352 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -6,7 +6,8 @@ obj-$(CONFIG_CAN_VCAN)		+= vcan.o
 obj-$(CONFIG_CAN_SLCAN)		+= slcan.o
 
 obj-$(CONFIG_CAN_DEV)		+= can-dev.o
-can-dev-y			:= dev.o
+can-dev-y			+= dev.o
+can-dev-y			+= rx-offload.o
 
 can-dev-$(CONFIG_CAN_LEDS)	+= led.o
 
diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
new file mode 100644
index 000000000000..db360ddeec97
--- /dev/null
+++ b/drivers/net/can/rx-offload.c
@@ -0,0 +1,163 @@
+/*
+ * Copyright (c) 2014 David Jander, Protonic Holland
+ * Copyright (C) 2014-2016 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the version 2 of the GNU General Public License
+ * as published by the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/can/dev.h>
+#include <linux/can/rx-offload.h>
+
+static int can_rx_offload_napi_poll(struct napi_struct *napi, int quota)
+{
+	struct can_rx_offload *offload = container_of(napi, struct can_rx_offload, napi);
+	struct net_device *dev = offload->dev;
+	struct net_device_stats *stats = &dev->stats;
+	struct sk_buff *skb;
+	int work_done = 0;
+
+	if (offload->poll_pre_read && work_done < quota)
+		work_done += offload->poll_pre_read(offload);
+
+	while ((work_done < quota) &&
+	       (skb = skb_dequeue(&offload->skb_queue))) {
+		struct can_frame *cf = (struct can_frame *)skb->data;
+
+		work_done++;
+		stats->rx_packets++;
+		stats->rx_bytes += cf->can_dlc;
+		netif_receive_skb(skb);
+	}
+
+	if (offload->poll_post_read && work_done < quota)
+		work_done += offload->poll_post_read(offload);
+
+	if (work_done < quota) {
+		napi_complete(napi);
+
+		/* Check if there was another interrupt */
+		if ((!skb_queue_empty(&offload->skb_queue) || offload->poll_errors) &&
+		    napi_reschedule(&offload->napi)) {
+			offload->poll_errors = false;
+		}
+
+		if (offload->poll_error_interrupts_enable)
+			offload->poll_error_interrupts_enable(offload);
+	}
+
+	can_led_event(offload->dev, CAN_LED_EVENT_RX);
+
+	return work_done;
+}
+
+static struct sk_buff *can_rx_offload_offload_one(struct can_rx_offload *offload, unsigned int n)
+{
+	struct sk_buff *skb = NULL;
+	struct can_frame *cf;
+	int ret;
+
+	/* If queue is full or skb not available, read to discard mailbox */
+	if (likely(skb_queue_len(&offload->skb_queue) <=
+		   offload->skb_queue_len_max))
+		skb = alloc_can_skb(offload->dev, &cf);
+
+	if (!skb) {
+		struct can_frame cf_overflow;
+
+		ret = offload->mailbox_read(offload, &cf_overflow, n);
+		if (ret)
+			offload->dev->stats.rx_dropped++;
+
+		return NULL;
+	}
+
+	ret = offload->mailbox_read(offload, cf, n);
+	if (!ret) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	return skb;
+}
+
+int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload)
+{
+	struct sk_buff *skb;
+	int received = 0;
+
+	while ((skb = can_rx_offload_offload_one(offload, 0))) {
+		skb_queue_tail(&offload->skb_queue, skb);
+		received++;
+	}
+
+	if (received)
+		can_rx_offload_schedule(offload);
+
+	return received;
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_fifo);
+
+static int can_rx_offload_init_queue(struct net_device *dev, struct can_rx_offload *offload, unsigned int weight)
+{
+	offload->dev = dev;
+
+	/* Limit queue len to 4x the weight (rounted to next power of two) */
+	offload->skb_queue_len_max = 2 << fls(weight);
+	offload->skb_queue_len_max *= 4;
+	skb_queue_head_init(&offload->skb_queue);
+
+	can_rx_offload_reset(offload);
+	netif_napi_add(dev, &offload->napi, can_rx_offload_napi_poll, weight);
+
+	dev_dbg(dev->dev.parent, "%s: mb_first=%d mb_last=%d queue_len_max=%d\n",
+		__func__, offload->mb_first, offload->mb_last,
+		offload->skb_queue_len_max);
+
+	return 0;
+}
+
+int can_rx_offload_add_fifo(struct net_device *dev, struct can_rx_offload *offload, unsigned int weight)
+{
+	if (!offload->mailbox_read)
+		return -EINVAL;
+
+	return can_rx_offload_init_queue(dev, offload, weight);
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_add_fifo);
+
+void can_rx_offload_enable(struct can_rx_offload *offload)
+{
+	can_rx_offload_reset(offload);
+	napi_enable(&offload->napi);
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_enable);
+
+void can_rx_offload_irq_error(struct can_rx_offload *offload)
+{
+	offload->poll_errors = true;
+	can_rx_offload_schedule(offload);
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_irq_error);
+
+void can_rx_offload_del(struct can_rx_offload *offload)
+{
+	netif_napi_del(&offload->napi);
+	skb_queue_purge(&offload->skb_queue);
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_del);
+
+void can_rx_offload_reset(struct can_rx_offload *offload)
+{
+	offload->poll_errors = false;
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_reset);
diff --git a/include/linux/can/rx-offload.h b/include/linux/can/rx-offload.h
new file mode 100644
index 000000000000..a0ebc49aef2a
--- /dev/null
+++ b/include/linux/can/rx-offload.h
@@ -0,0 +1,56 @@
+/*
+ * linux/can/rx-offload.h
+ *
+ * Copyright (c) 2014 David Jander, Protonic Holland
+ * Copyright (c) 2014-2016 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the version 2 of the GNU General Public License
+ * as published by the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _CAN_RX_OFFLOAD_H
+#define _CAN_RX_OFFLOAD_H
+
+#include <linux/netdevice.h>
+#include <linux/can.h>
+
+struct can_rx_offload {
+	struct net_device *dev;
+
+	void (*poll_error_interrupts_enable)(struct can_rx_offload *offload);
+	unsigned int (*mailbox_read)(struct can_rx_offload *offload, struct can_frame *cf, unsigned int mb);
+	unsigned int (*poll_pre_read)(struct can_rx_offload *offload);
+	unsigned int (*poll_post_read)(struct can_rx_offload *offload);
+
+	struct sk_buff_head skb_queue;
+	u32 skb_queue_len_max;
+
+	struct napi_struct napi;
+
+	bool poll_errors;
+};
+
+int can_rx_offload_add_fifo(struct net_device *dev, struct can_rx_offload *offload, unsigned int weight);
+int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload);
+void can_rx_offload_irq_error(struct can_rx_offload *offload);
+void can_rx_offload_reset(struct can_rx_offload *offload);
+void can_rx_offload_del(struct can_rx_offload *offload);
+void can_rx_offload_enable(struct can_rx_offload *offload);
+
+static inline void can_rx_offload_schedule(struct can_rx_offload *offload)
+{
+	napi_schedule(&offload->napi);
+}
+
+static inline void can_rx_offload_disable(struct can_rx_offload *offload)
+{
+	napi_disable(&offload->napi);
+}
+
+#endif /* !_CAN_RX_OFFLOAD_H */
-- 
2.8.1

