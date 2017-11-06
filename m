From: GBert <info@gerhard-bertelsmann.de>
Subject: [PATCH v5] can: sun4i: fix overrun
Date: Mon,  6 Nov 2017 18:16:56 +0100
Message-ID: <1509988616-19479-1-git-send-email-info@gerhard-bertelsmann.de>
References: <1509983842-18821-1-git-send-email-info@gerhard-bertelsmann.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rdts.de ([195.243.153.28]:35874 "EHLO mail.rdts.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751831AbdKFRRB (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 6 Nov 2017 12:17:01 -0500
In-Reply-To: <1509983842-18821-1-git-send-email-info@gerhard-bertelsmann.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: cb2begq <info@gerhard-bertelsmann.de>

From: cb2begq <info@gerhard-bertelsmann.de>

SUN4Is CAN IP has a 64 byte deep FIFO buffer. If the buffer is not drained
fast enough (overrun) it's getting mangled. Already received frames are
dropped - the data can't be restored.

V5: ignore timeout error and add a comment
V4: add error handling
V3: fix compilation
V2: no duplicate error reporting


Signed-off-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

---
 drivers/net/can/sun4i_can.c |   12 ++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index b0c8085..1d2d12e 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -539,6 +539,13 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 		}
 		stats->rx_over_errors++;
 		stats->rx_errors++;
+
+		/* reset the CAN IP by entering reset mode
+		 * ignoring timeout error
+		 */
+		set_reset_mode(dev);
+		set_normal_mode(dev);
+
 		/* clear bit */
 		sun4i_can_write_cmdreg(priv, SUN4I_CMD_CLEAR_OR_FLAG);
 	}
@@ -653,8 +663,9 @@ static irqreturn_t sun4i_can_interrupt(int irq, void *dev_id)
 			netif_wake_queue(dev);
 			can_led_event(dev, CAN_LED_EVENT_TX);
 		}
-		if (isrc & SUN4I_INT_RBUF_VLD) {
-			/* receive interrupt */
+		if ((isrc & SUN4I_INT_RBUF_VLD) &&
+		    !(isrc & SUN4I_INT_DATA_OR)) {
+			/* receive interrupt - don't read if overrun occurred */
 			while (status & SUN4I_STA_RBUF_RDY) {
 				/* RX buffer is not empty */
 				sun4i_can_rx(dev);
-- 
1.7.9.5

