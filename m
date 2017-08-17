From: GBert <info@gerhard-bertelsmann.de>
Subject: [PATCH 1/2] can: sun4i: fix overrun
Date: Thu, 17 Aug 2017 15:59:48 +0200
Message-ID: <4bd237f72c933953238738b1d12d11ff16a0b6b0.1502971879.git.info@gerhard-bertelsmann.de>
References: <cover.1502971879.git.info@gerhard-bertelsmann.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rdts.de ([195.243.153.28]:59234 "EHLO mail.rdts.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751637AbdHQOFj (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 17 Aug 2017 10:05:39 -0400
In-Reply-To: <cover.1502971879.git.info@gerhard-bertelsmann.de>
In-Reply-To: <cover.1502971879.git.info@gerhard-bertelsmann.de>
References: <cover.1502971879.git.info@gerhard-bertelsmann.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

From: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

SUN4Is CAN IP has a 64 byte deep FIFO buffer. If the buffer is not drained
fast enough (overrun) it's getting mangled. The fix resets the buffer for
faster recovery - unrecoverable data in the buffer will be ignored

Signed-off-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
---
 drivers/net/can/sun4i_can.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git drivers/net/can/sun4i_can.c drivers/net/can/sun4i_can.c
index 68ef0a4..0d673ff 100644
--- drivers/net/can/sun4i_can.c
+++ drivers/net/can/sun4i_can.c
@@ -531,6 +531,7 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 	}
 
 	if (isrc & SUN4I_INT_DATA_OR) {
+		int err;
 		/* data overrun interrupt */
 		netdev_dbg(dev, "data overrun interrupt\n");
 		if (likely(skb)) {
@@ -539,6 +540,15 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 		}
 		stats->rx_over_errors++;
 		stats->rx_errors++;
+
+		/* reset the CAN IP by entering reset mode */
+		err = set_reset_mode(dev);
+		if (err)
+			netdev_err(dev, "could not enter reset mode\n");
+		err = set_normal_mode(dev);
+		if (err)
+			netdev_err(dev, "could not enter normal mode\n");
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

