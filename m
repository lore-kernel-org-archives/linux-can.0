From: GBert <info@gerhard-bertelsmann.de>
Subject: [PATCH v4] can: sun4i: fix overrun
Date: Mon,  6 Nov 2017 16:57:22 +0100
Message-ID: <1509983842-18821-1-git-send-email-info@gerhard-bertelsmann.de>
References: <d834a10b-414b-2555-a268-39304dd622f3@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rdts.de ([195.243.153.28]:34550 "EHLO mail.rdts.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753982AbdKFP5f (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 6 Nov 2017 10:57:35 -0500
In-Reply-To: <d834a10b-414b-2555-a268-39304dd622f3@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: cb2begq <info@gerhard-bertelsmann.de>

From: cb2begq <info@gerhard-bertelsmann.de>

SUN4Is CAN IP has a 64 byte deep FIFO buffer. If the buffer is not drained
fast enough (overrun) it's getting mangled. Already received frames are
dropped - the data can't be restored.

V4: add error handling
V3: fix compilation
V2: no duplicate error reporting


Signed-off-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

---
 drivers/net/can/sun4i_can.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index b0c8085..1d2d12e 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -539,6 +539,15 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 		}
 		stats->rx_over_errors++;
 		stats->rx_errors++;
+
+		/* reset the CAN IP by entering reset mode */
+		err = set_reset_mode(dev);
+		if (err < 0)
+			return err;
+		err = set_normal_mode(dev);
+		if (err < 0)
+			return err;
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

