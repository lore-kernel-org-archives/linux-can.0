From: David Jander <david@protonic.nl>
Subject: [PATCH 09/15] can: rx-fifo: Add can_rx_fifo_reset() function
Date: Fri, 10 Oct 2014 17:46:54 +0200
Message-ID: <1412956020-21489-10-git-send-email-david@protonic.nl>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:18404 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbaJJPrC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Oct 2014 11:47:02 -0400
In-Reply-To: <1412956020-21489-1-git-send-email-david@protonic.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>, David Jander <david@protonic.nl>

This function needs to be called every time the CAN controller is reset
and before interrupts are enabled. Otherwise the irq-offload loop gets
out of sync. Detect this and BUG() to the user if he forgot.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/net/can/dev.c   | 20 ++++++++++++++++++--
 include/linux/can/dev.h |  1 +
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 3e1160a..fc35d28 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -487,8 +487,17 @@ int can_rx_fifo_irq_offload(struct can_rx_fifo *fifo)
 		fifo->second_first = true;
 	}
 
-	if (received)
-		napi_schedule(&fifo->napi);
+	if (received) {
+		can_rx_fifo_napi_schedule(fifo);
+	} else {
+		/*
+		 * This should only happen if the CAN conroller was reset, but
+		 * can_rx_fifo_reset() was not called. BUG();
+		 */
+		netdev_warn(fifo->dev, "%s: No messages found,"
+			    " RX-FIFO out of sync?\n", __func__);
+		BUG();
+	}
 
 	return received;
 }
@@ -506,6 +515,13 @@ void can_rx_fifo_napi_disable(struct can_rx_fifo *fifo)
 }
 EXPORT_SYMBOL_GPL(can_rx_fifo_napi_disable);
 
+void can_rx_fifo_reset(struct can_rx_fifo *fifo)
+{
+	fifo->second_first = false;
+	fifo->active = fifo->mask_low | fifo->mask_high;
+}
+EXPORT_SYMBOL_GPL(can_rx_fifo_reset);
+
 void can_rx_fifo_del(struct can_rx_fifo *fifo)
 {
 	if (fifo->ring)
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 64a8de3..ada324c 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -137,6 +137,7 @@ int can_rx_fifo_add(struct net_device *dev, struct can_rx_fifo *fifo);
 int can_rx_fifo_irq_offload(struct can_rx_fifo *fifo);
 void can_rx_fifo_napi_enable(struct can_rx_fifo *fifo);
 void can_rx_fifo_napi_disable(struct can_rx_fifo *fifo);
+void can_rx_fifo_reset(struct can_rx_fifo *fifo);
 void can_rx_fifo_del(struct can_rx_fifo *fifo);
 
 struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max);
-- 
1.9.1

