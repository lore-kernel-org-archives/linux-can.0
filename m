From: Marek Vasut <marex@denx.de>
Subject: [PATCH 5/6] net: can: ifi: Increment TX counters only on real transmission
Date: Sun,  8 May 2016 00:34:15 +0200
Message-ID: <1462660456-6179-5-git-send-email-marex@denx.de>
References: <1462660456-6179-1-git-send-email-marex@denx.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:38390 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbcEGWee (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 7 May 2016 18:34:34 -0400
In-Reply-To: <1462660456-6179-1-git-send-email-marex@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Marc Kleine-Budde <mkl@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>

Only increment the TX counters in the irq handler if a CAN message
was sent. The current code incremented the counters also if the TX
FIFO empty interrupt happened, which is incorrect.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/net/can/ifi_canfd/ifi_canfd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 5bd95dd..ba6cd43 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -522,13 +522,15 @@ static irqreturn_t ifi_canfd_isr(int irq, void *dev_id)
 	}
 
 	/* TX IRQ */
-	if (isr & tx_irq_mask) {
+	if (isr & IFI_CANFD_INTERRUPT_TXFIFO_REMOVE) {
 		stats->tx_bytes += can_get_echo_skb(ndev, 0);
 		stats->tx_packets++;
 		can_led_event(ndev, CAN_LED_EVENT_TX);
-		netif_wake_queue(ndev);
 	}
 
+	if (isr & tx_irq_mask)
+		netif_wake_queue(ndev);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.7.0

