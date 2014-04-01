From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 16/16] can: c_can: Avoid led toggling for every packet.
Date: Tue,  1 Apr 2014 23:42:30 +0200
Message-ID: <1396388550-23081-17-git-send-email-mkl@pengutronix.de>
References: <1396388550-23081-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42697 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbaDAVmn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Apr 2014 17:42:43 -0400
In-Reply-To: <1396388550-23081-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Thomas Gleixner <tglx@linutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

There is no point to toggle the RX led for every packet. Especially if
we have a full FIFO we want to avoid everything we can.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 42c038d..01dc494 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -433,9 +433,6 @@ static int c_can_read_msg_object(struct net_device *dev, int iface, int ctrl)
 
 	stats->rx_packets++;
 	stats->rx_bytes += frame->can_dlc;
-
-	can_led_event(dev, CAN_LED_EVENT_RX);
-
 	return 0;
 }
 
@@ -901,6 +898,10 @@ static int c_can_do_rx_poll(struct net_device *dev, int quota)
 		pkts += n;
 		quota -= n;
 	}
+
+	if (pkts)
+		can_led_event(dev, CAN_LED_EVENT_RX);
+
 	return pkts;
 }
 
-- 
1.9.0.279.gdc9e3eb

