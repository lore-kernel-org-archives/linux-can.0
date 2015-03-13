From: yegorslists@googlemail.com
Subject: [PATCH] can: add combined rx/tx LED trigger support
Date: Fri, 13 Mar 2015 16:16:00 +0100
Message-ID: <1426259760-14394-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.visionsystems.de ([213.209.99.202]:33225 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbbCMPdb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Mar 2015 11:33:31 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: fabio.baltieri@gmail.com, socketcan@hartkopp.net, mkl@pengutronix.de, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Add <ifname>-rxtx trigger, that will be activated both for tx
as rx events. This trigger mimics "activity" LED for Ethernet
devices.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/net/can/led.c   |   14 ++++++++++++--
 include/linux/can/dev.h |    2 ++
 include/linux/can/led.h |    2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/led.c b/drivers/net/can/led.c
index ab7f1b0..56d940a 100644
--- a/drivers/net/can/led.c
+++ b/drivers/net/can/led.c
@@ -36,14 +36,20 @@ void can_led_event(struct net_device *netdev, enum can_led_event event)
 		led_trigger_event(priv->rx_led_trig, LED_OFF);
 		break;
 	case CAN_LED_EVENT_TX:
-		if (led_delay)
+		if (led_delay) {
 			led_trigger_blink_oneshot(priv->tx_led_trig,
 						  &led_delay, &led_delay, 1);
+			led_trigger_blink_oneshot(priv->rxtx_led_trig,
+						  &led_delay, &led_delay, 1);
+		}
 		break;
 	case CAN_LED_EVENT_RX:
-		if (led_delay)
+		if (led_delay) {
 			led_trigger_blink_oneshot(priv->rx_led_trig,
 						  &led_delay, &led_delay, 1);
+			led_trigger_blink_oneshot(priv->rxtx_led_trig,
+						  &led_delay, &led_delay, 1);
+		}
 		break;
 	}
 }
@@ -76,11 +82,15 @@ void devm_can_led_init(struct net_device *netdev)
 		 "%s-tx", netdev->name);
 	snprintf(priv->rx_led_trig_name, sizeof(priv->rx_led_trig_name),
 		 "%s-rx", netdev->name);
+	snprintf(priv->rxtx_led_trig_name, sizeof(priv->rxtx_led_trig_name),
+		 "%s-rxtx", netdev->name);
 
 	led_trigger_register_simple(priv->tx_led_trig_name,
 				    &priv->tx_led_trig);
 	led_trigger_register_simple(priv->rx_led_trig_name,
 				    &priv->rx_led_trig);
+	led_trigger_register_simple(priv->rxtx_led_trig_name,
+				    &priv->rxtx_led_trig);
 
 	devres_add(&netdev->dev, res);
 }
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index c05ff0f..c3a9c8f 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -61,6 +61,8 @@ struct can_priv {
 	char tx_led_trig_name[CAN_LED_NAME_SZ];
 	struct led_trigger *rx_led_trig;
 	char rx_led_trig_name[CAN_LED_NAME_SZ];
+	struct led_trigger *rxtx_led_trig;
+	char rxtx_led_trig_name[CAN_LED_NAME_SZ];
 #endif
 };
 
diff --git a/include/linux/can/led.h b/include/linux/can/led.h
index e0475c5..c60f542 100644
--- a/include/linux/can/led.h
+++ b/include/linux/can/led.h
@@ -22,7 +22,7 @@ enum can_led_event {
 #ifdef CONFIG_CAN_LEDS
 
 /* keep space for interface name + "-tx"/"-rx" suffix and null terminator */
-#define CAN_LED_NAME_SZ (IFNAMSIZ + 4)
+#define CAN_LED_NAME_SZ (IFNAMSIZ + 6)
 
 void can_led_event(struct net_device *netdev, enum can_led_event event);
 void devm_can_led_init(struct net_device *netdev);
-- 
1.7.7

