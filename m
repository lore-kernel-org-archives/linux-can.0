From: David Jander <david@protonic.nl>
Subject: [PATCH 05/14] can: rx-fifo: Add can_rx_fifo_reset() function
Date: Thu,  6 Nov 2014 09:34:04 +0100
Message-ID: <1415262853-22907-6-git-send-email-david@protonic.nl>
References: <1415262853-22907-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:26397 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbaKFIeH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Nov 2014 03:34:07 -0500
In-Reply-To: <1415262853-22907-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>, David Jander <david@protonic.nl>

This function needs to be called every time the CAN controller is reset
and before interrupts are enabled. Otherwise the irq-offload loop gets
out of sync. Detect this and WARN() to the user if he forgot.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/can/dev.c   | 21 +++++++++++++++++++--
 include/linux/can/dev.h |  1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 3e32ec3..186ce54 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -488,8 +488,18 @@ int can_rx_fifo_irq_offload(struct can_rx_fifo *fifo)
 		fifo->scan_high_first = true;
 	}
 
-	if (received)
-		napi_schedule(&fifo->napi);
+	if (received) {
+		can_rx_fifo_napi_schedule(fifo);
+	} else {
+		/*
+		 * This should only happen if the CAN conroller was reset, but
+		 * can_rx_fifo_reset() was not called. WARN() the user and try
+		 * to recover. This may fail and the system may hang though.
+		 */
+		WARN(true, "%s: No messages found,"
+			    " RX-FIFO out of sync?\n", __func__);
+		can_rx_fifo_reset(fifo);
+	}
 
 	return received;
 }
@@ -507,6 +517,13 @@ void can_rx_fifo_napi_disable(struct can_rx_fifo *fifo)
 }
 EXPORT_SYMBOL_GPL(can_rx_fifo_napi_disable);
 
+void can_rx_fifo_reset(struct can_rx_fifo *fifo)
+{
+	fifo->scan_high_first = false;
+	fifo->active = fifo->mask_low | fifo->mask_high;
+}
+EXPORT_SYMBOL_GPL(can_rx_fifo_reset);
+
 void can_rx_fifo_del(struct can_rx_fifo *fifo)
 {
 	kfree(fifo->ring);
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 66b0228..334626c 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -145,6 +145,7 @@ int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo);
 int can_rx_fifo_irq_offload(struct can_rx_fifo *fifo);
 void can_rx_fifo_napi_enable(struct can_rx_fifo *fifo);
 void can_rx_fifo_napi_disable(struct can_rx_fifo *fifo);
+void can_rx_fifo_reset(struct can_rx_fifo *fifo);
 void can_rx_fifo_del(struct can_rx_fifo *fifo);
 
 struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max);
-- 
1.9.1

