From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/7] can: flexcan: flexcan_open(): fix error path if flexcan_chip_start() fails
Date: Fri, 28 Feb 2014 23:06:24 +0100
Message-ID: <1393625189-5568-3-git-send-email-mkl@pengutronix.de>
References: <1393625189-5568-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43111 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbaB1WGd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Feb 2014 17:06:33 -0500
In-Reply-To: <1393625189-5568-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

If flexcan_chip_start() in flexcan_open() fails, the interrupt is not freed,
this patch adds the missing cleanup.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index dcd69c9..30af702 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -868,7 +868,7 @@ static int flexcan_open(struct net_device *dev)
 	/* start chip and queuing */
 	err = flexcan_chip_start(dev);
 	if (err)
-		goto out_close;
+		goto out_free_irq;
 
 	can_led_event(dev, CAN_LED_EVENT_OPEN);
 
@@ -877,6 +877,8 @@ static int flexcan_open(struct net_device *dev)
 
 	return 0;
 
+ out_free_irq:
+	free_irq(dev->irq, dev);
  out_close:
 	close_candev(dev);
  out_disable_per:
-- 
1.9.0.rc3

