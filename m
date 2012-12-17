From: Bernd Krumboeck <b.krumboeck@gmail.com>
Subject: [PATCH] usb_8dev: add LED trigger support
Date: Mon, 17 Dec 2012 22:19:49 +0100
Message-ID: <1355779189-23289-1-git-send-email-krumboeck@universalnet.at>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:34420 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544Ab2LQVUJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 17 Dec 2012 16:20:09 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: linux-usb@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com, fabio.baltieri@gmail.com, Bernd Krumboeck <krumboeck@universalnet.at>

Add support for canbus activity led indicators on usb_8dev devices by
calling appropriate can_led functions.

These are only enabled when CONFIG_CAN_LEDS is Y, becomes no-op
otherwise.

Signed-off-by: Bernd Krumboeck <krumboeck@universalnet.at>
---
 drivers/net/can/usb/usb_8dev.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index 660b4f87..adec0d2 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -33,6 +33,7 @@
 #include <linux/can.h>
 #include <linux/can/dev.h>
 #include <linux/can/error.h>
+#include <linux/can/led.h>
 
 /* driver constants */
 #define MAX_RX_URBS			10
@@ -504,6 +505,8 @@ static void usb_8dev_rx_can_msg(struct usb_8dev_priv *priv,
 
 		stats->rx_packets++;
 		stats->rx_bytes += cf->can_dlc;
+
+		can_led_event(priv->netdev, CAN_LED_EVENT_RX);
 	} else {
 		netdev_warn(priv->netdev, "frame type %d unknown",
 			 msg->type);
@@ -606,6 +609,8 @@ static void usb_8dev_write_bulk_callback(struct urb *urb)
 
 	can_get_echo_skb(netdev, context->echo_index);
 
+	can_led_event(netdev, CAN_LED_EVENT_TX);
+
 	/* Release context */
 	context->echo_index = MAX_TX_URBS;
 
@@ -830,6 +835,8 @@ static int usb_8dev_open(struct net_device *netdev)
 	if (err)
 		return err;
 
+	can_led_event(netdev, CAN_LED_EVENT_OPEN);
+
 	/* finally start device */
 	err = usb_8dev_start(priv);
 	if (err) {
@@ -882,6 +889,8 @@ static int usb_8dev_close(struct net_device *netdev)
 
 	close_candev(netdev);
 
+	can_led_event(netdev, CAN_LED_EVENT_STOP);
+
 	return err;
 }
 
@@ -990,6 +999,8 @@ static int usb_8dev_probe(struct usb_interface *intf,
 			 (version>>8) & 0xff, version & 0xff);
 	}
 
+	devm_can_led_init(netdev);
+
 	return 0;
 
 cleanup_cmd_msg_buffer:
-- 
1.7.10.4

