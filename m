From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: [RFC PATCH v2 1/2] can: add tx/rx LED trigger support
Date: Mon, 23 Apr 2012 23:02:45 +0200
Message-ID: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:64888 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755464Ab2DWVBQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Apr 2012 17:01:16 -0400
Received: by wgbdr13 with SMTP id dr13so12238586wgb.1
        for <linux-can@vger.kernel.org>; Mon, 23 Apr 2012 14:01:14 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Fabio Baltieri <fabio.baltieri@gmail.com>

This patch implements the functions to add two LED triggers, named
<ifname>-tx and <ifname>-rx, to a canbus device driver.

Triggers are called from specific handlers by each CAN device driver and
can be disabled altogether with a Kconfig option.

The implementation keeps the LED on when the interface is UP and blinks
the LED on network activity at a configurable rate.

This only supports can-dev based drivers, as it uses some support field
in the can_priv structure.

Supported drivers should call can_led_init(), can_led_exit() and
can_led_event() as needed.

Supported events are:
- CAN_LED_EVENT_OPEN: turn on tx/rx LEDs
- CAN_LED_EVENT_STOP: turn off tx/rx LEDs
- CAN_LED_EVENT_TX: trigger tx LED blink
- CAN_LED_EVENT_RX: trigger tx LED blink

Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
---

Hello again!

So, this is the v2 of my can-led patch. I reworked the whole code based on the
v1 and all the comments from the list (thanks guys!).

This version takes a different approach and is just an implementation of three
functions - can_led_{init,exit,event} - to easily add tx/rx led trigger
support to a netlink-based canbus driver. An implementation on flexcan is on
the 2/2.

Working principle:

- the driver register the triggers on probe, free on exit and add events for
  open, close, tx, rx where appropriate
- both LEDs stay off when device is down, on when device is up
- each LED blinks for led_delay off + led_delay on on tx/rx event using a
  kernel timer (well, that's actually the opposite to keep critical path
  cleaner but don't tell anyone, k?).
- new tx/rx packets don't retrigger the timer until the blink sequence is over,
  so that on heavy traffic the LED keeps blinking at constate rate.  

Notes:

- I considered putting all structures in can_priv to skip a couple of kzallocs
  as suggested by Oliver, but those pointers are actually useful to check if
  triggers registered properly, so the code now uses an internal structure with
  timer, state and name, and add just two pointers into struct can_dev.

- The blink timer is implemented as:
  * keep on for delay_time
  * turn off and retrigger the timer
  * turn back on after delay
  so that the hot-path only contains a switch-case, some checks and a mod_timer.

This is tested on an x86 with a custom usb-can interface and on a flexcan-based
Freescale ARM board. I'll post some patch to implement support in other drivers
if anyone is interested into testing this one.

Any comments?

Regards,
Fabio

 drivers/net/can/Kconfig  |   13 ++++
 drivers/net/can/Makefile |    2 +
 drivers/net/can/led.c    |  143 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/can/dev.h  |    6 ++
 include/linux/can/led.h  |   46 +++++++++++++++
 5 files changed, 210 insertions(+), 0 deletions(-)
 create mode 100644 drivers/net/can/led.c
 create mode 100644 include/linux/can/led.h

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index bb709fd..74d6bfb 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -54,6 +54,19 @@ config CAN_CALC_BITTIMING
 	  arguments "tq", "prop_seg", "phase_seg1", "phase_seg2" and "sjw".
 	  If unsure, say Y.
 
+config CAN_LEDS
+	bool "Enable LED triggers for Netlink based drivers"
+	depends on CAN
+	depends on CAN_DEV
+	depends on LEDS_CLASS
+	select LEDS_TRIGGERS
+	---help---
+	  This option adds two LED triggers for packet receive and transmit
+	  events on each supported CAN device.
+
+	  Say Y here if you are working on a system with led-class supported
+	  LEDs and you want to use them as canbus activity indicators.
+
 config CAN_AT91
 	tristate "Atmel AT91 onchip CAN controller"
 	depends on CAN_DEV && (ARCH_AT91SAM9263 || ARCH_AT91SAM9X5)
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 938be37..24ee98b 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -8,6 +8,8 @@ obj-$(CONFIG_CAN_SLCAN)		+= slcan.o
 obj-$(CONFIG_CAN_DEV)		+= can-dev.o
 can-dev-y			:= dev.o
 
+can-dev-$(CONFIG_CAN_LEDS)	+= led.o
+
 obj-y				+= usb/
 obj-y				+= softing/
 
diff --git a/drivers/net/can/led.c b/drivers/net/can/led.c
new file mode 100644
index 0000000..3479e38
--- /dev/null
+++ b/drivers/net/can/led.c
@@ -0,0 +1,143 @@
+/*
+ * Copyright 2012, Fabio Baltieri <fabio.baltieri@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/netdevice.h>
+#include <linux/can/dev.h>
+#include <linux/timer.h>
+
+#include <linux/can/led.h>
+
+static int led_delay = 50;
+module_param(led_delay, int, 0644);
+MODULE_PARM_DESC(led_delay,
+		"blink delay time for activity leds (msecs, default: 50).");
+
+static void can_led_timerfunc(unsigned long data)
+{
+	struct can_led_data *led_data = (struct can_led_data *)data;
+
+	if (led_data->phase == 0) {
+		led_trigger_event(&led_data->trig, LED_OFF);
+		led_data->phase = 1;
+
+		mod_timer(&led_data->timer,
+			jiffies + msecs_to_jiffies(led_delay));
+	} else {
+		led_trigger_event(&led_data->trig, LED_FULL);
+		led_data->phase = 0;
+	}
+}
+
+void can_led_event(struct net_device *netdev, enum can_led_event event)
+{
+	struct can_priv *priv = netdev_priv(netdev);
+	struct can_led_data *tx_led = priv->tx_led_data;
+	struct can_led_data *rx_led = priv->rx_led_data;
+
+	switch (event) {
+	case CAN_LED_EVENT_OPEN:
+		if (likely(tx_led))
+			led_trigger_event(&tx_led->trig, LED_FULL);
+		if (likely(rx_led))
+			led_trigger_event(&rx_led->trig, LED_FULL);
+		break;
+	case CAN_LED_EVENT_STOP:
+		if (likely(tx_led)) {
+			del_timer_sync(&tx_led->timer);
+			led_trigger_event(&tx_led->trig, LED_OFF);
+		}
+		if (likely(rx_led)) {
+			del_timer_sync(&rx_led->timer);
+			led_trigger_event(&rx_led->trig, LED_OFF);
+		}
+		break;
+	case CAN_LED_EVENT_TX:
+		if (led_delay && likely(tx_led) &&
+		    !timer_pending(&tx_led->timer))
+			mod_timer(&tx_led->timer,
+				jiffies + msecs_to_jiffies(led_delay));
+		break;
+	case CAN_LED_EVENT_RX:
+		if (led_delay && likely(rx_led) &&
+		    !timer_pending(&rx_led->timer))
+			mod_timer(&rx_led->timer,
+				jiffies + msecs_to_jiffies(led_delay));
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(can_led_event);
+
+void can_led_init(struct net_device *netdev)
+{
+	struct can_priv *priv = netdev_priv(netdev);
+
+	priv->tx_led_data = kzalloc(sizeof(struct can_led_data), GFP_KERNEL);
+	if (!priv->tx_led_data)
+		goto tx_led_data_failed;
+
+	priv->rx_led_data = kzalloc(sizeof(struct can_led_data), GFP_KERNEL);
+	if (!priv->rx_led_data)
+		goto rx_led_data_failed;
+
+	snprintf(priv->tx_led_data->name, sizeof(priv->tx_led_data->name),
+		"%s-tx", netdev->name);
+
+	snprintf(priv->rx_led_data->name, sizeof(priv->rx_led_data->name),
+		"%s-rx", netdev->name);
+
+	priv->tx_led_data->trig.name = priv->tx_led_data->name;
+	if (led_trigger_register(&priv->tx_led_data->trig)) {
+		kfree(priv->tx_led_data);
+		priv->tx_led_data = NULL;
+	}
+
+	if (priv->tx_led_data)
+		setup_timer(&priv->tx_led_data->timer,
+			can_led_timerfunc, (unsigned long)priv->tx_led_data);
+
+	priv->rx_led_data->trig.name = priv->rx_led_data->name;
+	if (led_trigger_register(&priv->rx_led_data->trig)) {
+		kfree(priv->rx_led_data);
+		priv->rx_led_data = NULL;
+	}
+
+	if (priv->rx_led_data)
+		setup_timer(&priv->rx_led_data->timer,
+			can_led_timerfunc, (unsigned long)priv->rx_led_data);
+	return;
+
+rx_led_data_failed:
+	kfree(priv->tx_led_data);
+	priv->tx_led_data = NULL;
+tx_led_data_failed:
+	return;
+}
+EXPORT_SYMBOL_GPL(can_led_init);
+
+void can_led_exit(struct net_device *netdev)
+{
+	struct can_priv *priv = netdev_priv(netdev);
+
+	if (priv->tx_led_data) {
+		del_timer_sync(&priv->tx_led_data->timer);
+
+		led_trigger_unregister(&priv->tx_led_data->trig);
+		kfree(priv->tx_led_data);
+	}
+
+	if (priv->rx_led_data) {
+		del_timer_sync(&priv->rx_led_data->timer);
+
+		led_trigger_unregister(&priv->rx_led_data->trig);
+		kfree(priv->rx_led_data);
+	}
+}
+EXPORT_SYMBOL_GPL(can_led_exit);
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 5d2efe7..a5a70bd 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -16,6 +16,7 @@
 #include <linux/can.h>
 #include <linux/can/netlink.h>
 #include <linux/can/error.h>
+#include <linux/can/led.h>
 
 /*
  * CAN mode
@@ -52,6 +53,11 @@ struct can_priv {
 
 	unsigned int echo_skb_max;
 	struct sk_buff **echo_skb;
+
+#ifdef CONFIG_CAN_LEDS
+	struct can_led_data *tx_led_data;
+	struct can_led_data *rx_led_data;
+#endif
 };
 
 /*
diff --git a/include/linux/can/led.h b/include/linux/can/led.h
new file mode 100644
index 0000000..6496db5
--- /dev/null
+++ b/include/linux/can/led.h
@@ -0,0 +1,46 @@
+/*
+ * Copyright 2012, Fabio Baltieri <fabio.baltieri@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef CAN_LED_H
+#define CAN_LED_H
+
+#include <linux/timer.h>
+#include <linux/leds.h>
+
+enum can_led_event {
+	CAN_LED_EVENT_OPEN,
+	CAN_LED_EVENT_STOP,
+	CAN_LED_EVENT_TX,
+	CAN_LED_EVENT_RX,
+};
+
+#ifdef CONFIG_CAN_LEDS
+struct can_led_data {
+	char name[16];
+	struct led_trigger trig;
+	struct timer_list timer;
+	unsigned int phase;
+};
+
+void can_led_event(struct net_device *netdev, enum can_led_event event);
+void can_led_init(struct net_device *netdev);
+void can_led_exit(struct net_device *netdev);
+#else
+static inline void can_led_event(struct net_device *netdev,
+				 enum can_led_event event)
+{
+}
+static inline void can_led_init(struct net_device *netdev)
+{
+}
+static inline void can_led_exit(struct net_device *netdev)
+{
+}
+#endif
+
+#endif
-- 
1.7.5.1

