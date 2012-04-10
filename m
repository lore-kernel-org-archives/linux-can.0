From: Fabio Baltieri <fabio.baltieri@gmail.com>
Subject: [RFC PATCH] can: add tx/rx led trigger support
Date: Tue, 10 Apr 2012 23:39:25 +0200
Message-ID: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:55229 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755624Ab2DJVip (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Apr 2012 17:38:45 -0400
Received: by wejx9 with SMTP id x9so163375wej.19
        for <linux-can@vger.kernel.org>; Tue, 10 Apr 2012 14:38:44 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Fabio Baltieri <fabio.baltieri@gmail.com>

This patch adds two led triggers, named <ifname>-tx and <ifname>-rx to
each registered canbus interface.

Triggers are called from can_send() and can_rcv() functions in af_can.h,
and can be disabled with a Kconfig option.

The implementation lights up the LED when a packet is transmitted or
received and turn it off after a configurable time using a timer.

This only supports can-dev based drivers, as it uses some support field
in the can_priv structure.

Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
---
Hi all,

this is a try to add generic tx/rx LED triggers for canbus interfaces, somthing
I think is very useful in embedded systems where canbus devices often have
status leds associated with them, maybe on the bus connector itself, like
ethernet interfaces. I saw a couple of hardware implementation to drive status
leds from tx/rx lines but these were not as effective as software ones.

The implementation is similar to the MAC80211_LEDS one, and takes quite a lot
of inspiration and some code from it.

In this case, however, tx and rx events are trapped from the af_can source file
as there are no generic tx/rx functions in can/dev.c. This also required an
additional counter to discard rx events for looped frames.

Also, as all the support data are in the can_priv structure, this only supports
can-dev based drivers. All the others are ignored by checking the
netdev->rtnl_link_ops->kind string. This actually excludes only vcan and slcan
drivers.

The implementation should be quite unintrusive on existing code and can be disabled
altogether with a config option.

This has been tested tested on x86 and a powerpc with a custom USB-CAN
interface (which I hope to publish as open-hardware soon BTW) and i2c-based
leds.

Any thoughts? Do you think this can be merged?

Thanks,
Fabio


 include/linux/can/dev.h |    9 +++
 net/can/Kconfig         |   10 +++
 net/can/Makefile        |    2 +
 net/can/af_can.c        |   14 ++++-
 net/can/led.c           |  154 +++++++++++++++++++++++++++++++++++++++++++++++
 net/can/led.h           |   29 +++++++++
 6 files changed, 217 insertions(+), 1 deletions(-)
 create mode 100644 net/can/led.c
 create mode 100644 net/can/led.h

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 5d2efe7..76eb70c 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -16,6 +16,8 @@
 #include <linux/can.h>
 #include <linux/can/netlink.h>
 #include <linux/can/error.h>
+#include <linux/timer.h>
+#include <linux/leds.h>
 
 /*
  * CAN mode
@@ -52,6 +54,13 @@ struct can_priv {
 
 	unsigned int echo_skb_max;
 	struct sk_buff **echo_skb;
+
+#ifdef CONFIG_CAN_LEDS
+	struct timer_list tx_off_timer, rx_off_timer;
+	struct led_trigger *tx_led, *rx_led;
+	char tx_led_name[32], rx_led_name[32];
+	atomic_t led_discard_count;
+#endif
 };
 
 /*
diff --git a/net/can/Kconfig b/net/can/Kconfig
index 0320069..55894b7 100644
--- a/net/can/Kconfig
+++ b/net/can/Kconfig
@@ -52,4 +52,14 @@ config CAN_GW
 	  They can be modified with AND/OR/XOR/SET operations as configured
 	  by the netlink configuration interface known e.g. from iptables.
 
+config CAN_LEDS
+	bool "Enable LED triggers for Netlink based drivers"
+	depends on CAN
+	depends on CAN_DEV
+	depends on LEDS_CLASS
+	select LEDS_TRIGGERS
+	---help---
+	  This option enables two LED triggers for packet receive and transmit
+	  events on each CAN device based on the can-dev framework.
+
 source "drivers/net/can/Kconfig"
diff --git a/net/can/Makefile b/net/can/Makefile
index cef49eb..fc6b286 100644
--- a/net/can/Makefile
+++ b/net/can/Makefile
@@ -5,6 +5,8 @@
 obj-$(CONFIG_CAN)	+= can.o
 can-y			:= af_can.o proc.o
 
+can-$(CONFIG_CAN_LEDS)	+= led.o
+
 obj-$(CONFIG_CAN_RAW)	+= can-raw.o
 can-raw-y		:= raw.o
 
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 0ce2ad0..e0c17cf 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -61,6 +61,7 @@
 #include <net/sock.h>
 
 #include "af_can.h"
+#include "led.h"
 
 static __initdata const char banner[] = KERN_INFO
 	"can: controller area network core (" CAN_VERSION_STRING ")\n";
@@ -282,6 +283,8 @@ int can_send(struct sk_buff *skb, int loop)
 		skb->pkt_type = PACKET_HOST;
 	}
 
+	can_led_tx(skb->dev, loop);
+
 	/* send to netdevice */
 	err = dev_queue_xmit(skb);
 	if (err > 0)
@@ -674,6 +677,8 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
 		can_stats.matches_delta++;
 	}
 
+	can_led_rx(dev);
+
 	return NET_RX_SUCCESS;
 
 drop:
@@ -776,6 +781,8 @@ static int can_notifier(struct notifier_block *nb, unsigned long msg,
 		BUG_ON(dev->ml_priv);
 		dev->ml_priv = d;
 
+		can_led_init(dev);
+
 		break;
 
 	case NETDEV_UNREGISTER:
@@ -795,6 +802,8 @@ static int can_notifier(struct notifier_block *nb, unsigned long msg,
 
 		spin_unlock(&can_rcvlists_lock);
 
+		can_led_free(dev);
+
 		break;
 	}
 
@@ -867,7 +876,7 @@ static __exit void can_exit(void)
 	/* remove created dev_rcv_lists from still registered CAN devices */
 	rcu_read_lock();
 	for_each_netdev_rcu(&init_net, dev) {
-		if (dev->type == ARPHRD_CAN && dev->ml_priv){
+		if (dev->type == ARPHRD_CAN && dev->ml_priv) {
 
 			struct dev_rcv_lists *d = dev->ml_priv;
 
@@ -875,6 +884,9 @@ static __exit void can_exit(void)
 			kfree(d);
 			dev->ml_priv = NULL;
 		}
+
+		if (dev->type == ARPHRD_CAN)
+			can_led_free(dev);
 	}
 	rcu_read_unlock();
 
diff --git a/net/can/led.c b/net/can/led.c
new file mode 100644
index 0000000..33e34e8
--- /dev/null
+++ b/net/can/led.c
@@ -0,0 +1,154 @@
+/*
+ * Copyright 2012, Fabio Baltieri <fabio.baltieri@gmail.com>
+ *
+ * Implementation inspired by mac80211_leds driver.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/netdevice.h>
+#include <linux/can/dev.h>
+#include <linux/timer.h>
+
+#include <net/rtnetlink.h>
+
+#include "led.h"
+
+static int led_off_delay = 20;
+module_param(led_off_delay, int, 0644);
+MODULE_PARM_DESC(led_off_delay,
+		"turn-off delay time for activity leds (msecs, default: 20).");
+
+static void tx_off_function(unsigned long data)
+{
+	struct can_priv *priv = (struct can_priv *)data;
+
+	led_trigger_event(priv->tx_led, LED_OFF);
+}
+
+static void rx_off_function(unsigned long data)
+{
+	struct can_priv *priv = (struct can_priv *)data;
+
+	led_trigger_event(priv->rx_led, LED_OFF);
+}
+
+/* This is used to ignore devices not based on the can-dev framework */
+static int rtnl_link_kind_is(struct net_device *netdev, const char *kind)
+{
+	if (netdev->rtnl_link_ops &&
+		strncmp(kind, netdev->rtnl_link_ops->kind, strlen(kind)) == 0)
+		return 1;
+	else
+		return 0;
+}
+
+void can_led_tx(struct net_device *netdev, int loop)
+{
+	struct can_priv *priv = netdev_priv(netdev);
+
+	if (!rtnl_link_kind_is(netdev, "can"))
+		return;
+
+	if (unlikely(!priv->tx_led))
+		return;
+
+	if (!timer_pending(&priv->tx_off_timer)) {
+		led_trigger_event(priv->tx_led, LED_FULL);
+
+		mod_timer(&priv->tx_off_timer,
+			jiffies + msecs_to_jiffies(led_off_delay));
+	}
+
+	if (loop)
+		atomic_dec(&priv->led_discard_count);
+}
+
+void can_led_rx(struct net_device *netdev)
+{
+	struct can_priv *priv = netdev_priv(netdev);
+
+	if (!rtnl_link_kind_is(netdev, "can"))
+		return;
+
+	if (unlikely(!priv->rx_led))
+		return;
+
+	/* discard echoed packets */
+	if (atomic_inc_not_zero(&priv->led_discard_count))
+		return;
+
+	if (!timer_pending(&priv->rx_off_timer)) {
+		led_trigger_event(priv->rx_led, LED_FULL);
+
+		mod_timer(&priv->rx_off_timer,
+			jiffies + msecs_to_jiffies(led_off_delay));
+	}
+}
+
+void can_led_init(struct net_device *netdev)
+{
+	struct can_priv *priv = netdev_priv(netdev);
+
+	if (!rtnl_link_kind_is(netdev, "can"))
+		return;
+
+	snprintf(priv->tx_led_name, sizeof(priv->tx_led_name),
+		"%s-tx", netdev->name);
+	snprintf(priv->rx_led_name, sizeof(priv->rx_led_name),
+		"%s-rx", netdev->name);
+
+	priv->tx_led = kzalloc(sizeof(struct led_trigger), GFP_KERNEL);
+	if (priv->tx_led) {
+		priv->tx_led->name = priv->tx_led_name;
+		if (led_trigger_register(priv->tx_led)) {
+			kfree(priv->tx_led);
+			priv->tx_led = NULL;
+		}
+	}
+
+	priv->rx_led = kzalloc(sizeof(struct led_trigger), GFP_KERNEL);
+	if (priv->rx_led) {
+		priv->rx_led->name = priv->rx_led_name;
+		if (led_trigger_register(priv->rx_led)) {
+			kfree(priv->rx_led);
+			priv->rx_led = NULL;
+		}
+	}
+
+	if (priv->tx_led)
+		setup_timer(&priv->tx_off_timer, tx_off_function,
+			(unsigned long)priv);
+
+	if (priv->rx_led)
+		setup_timer(&priv->rx_off_timer, rx_off_function,
+			(unsigned long)priv);
+
+	atomic_set(&priv->led_discard_count, 0);
+}
+
+void can_led_free(struct net_device *netdev)
+{
+	struct can_priv *priv = netdev_priv(netdev);
+
+	if (!rtnl_link_kind_is(netdev, "can"))
+		return;
+
+	if (priv->tx_led) {
+		del_timer_sync(&priv->tx_off_timer);
+
+		led_trigger_unregister(priv->tx_led);
+		kfree(priv->tx_led);
+	}
+
+	if (priv->rx_led) {
+		del_timer_sync(&priv->rx_off_timer);
+
+		led_trigger_unregister(priv->rx_led);
+		kfree(priv->rx_led);
+	}
+}
diff --git a/net/can/led.h b/net/can/led.h
new file mode 100644
index 0000000..d55151c
--- /dev/null
+++ b/net/can/led.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright 2012, Fabio Baltieri <fabio.baltieri@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/leds.h>
+
+#ifdef CONFIG_CAN_LEDS
+void can_led_tx(struct net_device *netdev, int loop);
+void can_led_rx(struct net_device *netdev);
+void can_led_init(struct net_device *netdev);
+void can_led_free(struct net_device *netdev);
+#else
+static inline void can_led_tx(struct net_device *netdev, int loop)
+{
+}
+static inline void can_led_rx(struct net_device *netdev)
+{
+}
+static inline void can_led_init(struct net_device *netdev)
+{
+}
+static inline void can_led_free(struct net_device *netdev)
+{
+}
+#endif
-- 
1.7.5.1

