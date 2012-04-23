From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: [RFC PATCH v2 2/2] can: flexcan: add LED trigger support
Date: Mon, 23 Apr 2012 23:02:46 +0200
Message-ID: <1335214966-20478-2-git-send-email-fabio.baltieri@gmail.com>
References: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33705 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966Ab2DWVBY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Apr 2012 17:01:24 -0400
Received: by wibhj6 with SMTP id hj6so3241934wib.1
        for <linux-can@vger.kernel.org>; Mon, 23 Apr 2012 14:01:23 -0700 (PDT)
In-Reply-To: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Fabio Baltieri <fabio.baltieri@gmail.com>

Add support for canbus activity led indicators on flexcan interfaces by
calling appropriate can_led_* functions.

These are only enabled when CONFIG_CAN_LEDS is Y, becomes no-op
otherwise.

Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
---
 drivers/net/can/flexcan.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 1efb083..0e55c4c 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -23,6 +23,7 @@
 #include <linux/can.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
+#include <linux/can/led.h>
 #include <linux/can/platform/flexcan.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -524,6 +525,8 @@ static int flexcan_read_frame(struct net_device *dev)
 	stats->rx_packets++;
 	stats->rx_bytes += cf->can_dlc;
 
+	can_led_event(dev, CAN_LED_EVENT_RX);
+
 	return 1;
 }
 
@@ -614,6 +617,8 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
 		stats->tx_packets++;
 		flexcan_write((1 << FLEXCAN_TX_BUF_ID), &regs->iflag1);
 		netif_wake_queue(dev);
+
+		can_led_event(dev, CAN_LED_EVENT_TX);
 	}
 
 	return IRQ_HANDLED;
@@ -813,6 +818,8 @@ static int flexcan_open(struct net_device *dev)
 	if (err)
 		goto out_close;
 
+	can_led_event(dev, CAN_LED_EVENT_OPEN);
+
 	/* start chip and queuing */
 	err = flexcan_chip_start(dev);
 	if (err)
@@ -838,6 +845,8 @@ static int flexcan_close(struct net_device *dev)
 	napi_disable(&priv->napi);
 	flexcan_chip_stop(dev);
 
+	can_led_event(dev, CAN_LED_EVENT_STOP);
+
 	free_irq(dev->irq, dev);
 	clk_disable_unprepare(priv->clk);
 
@@ -1004,6 +1013,8 @@ static int __devinit flexcan_probe(struct platform_device *pdev)
 		goto failed_register;
 	}
 
+	can_led_init(dev);
+
 	dev_info(&pdev->dev, "device registered (reg_base=%p, irq=%d)\n",
 		 priv->base, dev->irq);
 
@@ -1028,6 +1039,8 @@ static int __devexit flexcan_remove(struct platform_device *pdev)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	struct resource *mem;
 
+	can_led_exit(dev);
+
 	unregister_flexcandev(dev);
 	platform_set_drvdata(pdev, NULL);
 	iounmap(priv->base);
-- 
1.7.5.1

