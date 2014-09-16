From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v4 4/5] can: flexcan: put TX mailbox into TX_INACTIVE mode after tx-complete
Date: Tue, 16 Sep 2014 16:20:33 +0200
Message-ID: <1410877234-29751-4-git-send-email-mkl@pengutronix.de>
References: <1410877234-29751-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34282 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193AbaIPOUk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 16 Sep 2014 10:20:40 -0400
In-Reply-To: <1410877234-29751-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: david@protonic.nl, Marc Kleine-Budde <mkl@pengutronix.de>

After sending a RTR frame the TX mailbox becomes a RX_EMPTY mailbox. To avoid
side effects when the RX-FIFO is full, this patch puts the TX mailbox into
TX_INACTIVE mode after the transmission has been completed.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---

Changes since v3:
- new

 drivers/net/can/flexcan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 54061c4..c17ae9e 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -765,6 +765,9 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		stats->tx_bytes += can_get_echo_skb(dev, 0);
 		stats->tx_packets++;
 		can_led_event(dev, CAN_LED_EVENT_TX);
+		/* after sending a RTR frame mailbox is in RX mode */
+		flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
+			      &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
 		flexcan_write((1 << FLEXCAN_TX_BUF_ID), &regs->iflag1);
 		netif_wake_queue(dev);
 	}
-- 
2.1.0

