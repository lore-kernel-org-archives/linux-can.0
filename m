From: GBert <info@gerhard-bertelsmann.de>
Subject: [PATCH v2] can: sun4i: fix overrun
Date: Fri, 27 Oct 2017 14:46:51 +0200
Message-ID: <1509108411-9614-1-git-send-email-info@gerhard-bertelsmann.de>
References: <5511583c-37ac-c6b7-f88d-1fd740fae3f5 () pengutronix ! de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rdts.de ([195.243.153.28]:36804 "EHLO mail.rdts.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752549AbdJ0MrE (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 27 Oct 2017 08:47:04 -0400
In-Reply-To: <5511583c-37ac-c6b7-f88d-1fd740fae3f5 () pengutronix ! de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

From: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

SUN4Is CAN IP has a 64 byte deep FIFO buffer. If the buffer is not drained
fast enough (overrun) it's getting mangled. Already received frames are
dropped - the data can't be restored.

V2: no duplicate error reporting

---
 drivers/net/can/sun4i_can.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 68ef0a4..bcec511 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -539,6 +539,11 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 		}
 		stats->rx_over_errors++;
 		stats->rx_errors++;
+
+		/* reset the CAN IP by entering reset mode */
+		err = set_reset_mode(dev);
+		err = set_normal_mode(dev);
+
 		/* clear bit */
 		sun4i_can_write_cmdreg(priv, SUN4I_CMD_CLEAR_OR_FLAG);
 	}
@@ -653,8 +658,9 @@ static irqreturn_t sun4i_can_interrupt(int irq, void *dev_id)
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

