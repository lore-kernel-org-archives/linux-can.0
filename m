From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 4/4] leds: netdev trigger: allow setting initial values in device tree
Date: Wed, 13 Mar 2019 21:26:15 +0100
Message-ID: <20190313202615.22883-5-linux@rasmusvillemoes.dk>
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

It can be quite convenient to initialize a netdev-triggered LED with a
device name and setting the rx,tx,link properties from device tree,
instead of having to do that in an init script in userspace.

My main motivation for this is to be able to switch away from the
deprecated CONFIG_CAN_LEDS, so add an example based on that and add a
pointer in the net/can/Kconfig file.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 .../devicetree/bindings/leds/common.txt       | 17 ++++++++++
 drivers/leds/trigger/ledtrig-netdev.c         | 31 +++++++++++++++++++
 drivers/net/can/Kconfig                       |  3 +-
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
index 7cb88460a47c..4f3a97e73417 100644
--- a/Documentation/devicetree/bindings/leds/common.txt
+++ b/Documentation/devicetree/bindings/leds/common.txt
@@ -43,6 +43,23 @@ Optional properties for child nodes:
                 Documentation/ABI/testing/sysfs-class-led-trigger-netdev)
                 to reflect the state and activity of a net device.
 
+                The optional child node netdev can be used to
+                configure initial values for the link, rx, tx and
+                device_name properties. For example, setting
+                linux,default-trigger = "netdev" and adding the child
+                node
+
+                netdev {
+                    rx;
+                    tx;
+                    link;
+                    device-name = "can0";
+                };
+
+                can be used to replace 'linux,default-trigger =
+                "can0-rxtx"' that relies on the deprecated
+                CONFIG_CAN_LEDS.
+
 - led-pattern : Array of integers with default pattern for certain triggers.
                 Each trigger may parse this property differently:
                 - one-shot : two numbers specifying delay on and delay off (in ms),
diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 55153a7e8433..1f7c86df1e91 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -20,6 +20,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/of.h>
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 #include "../leds.h"
@@ -395,6 +396,35 @@ static void netdev_trig_work(struct work_struct *work)
 			(atomic_read(&trigger_data->interval)*2));
 }
 
+static void netdev_trig_of_init(struct led_classdev *led_cdev,
+				struct led_netdev_data *trigger_data)
+{
+	struct device_node *np = led_cdev->dev->of_node;
+	const char *device_name;
+
+	if (!np)
+		return;
+	np = of_get_child_by_name(np, "netdev");
+	if (!np)
+		return;
+
+	if (of_property_read_bool(np, "link"))
+		__set_bit(NETDEV_LED_LINK, &trigger_data->mode);
+	if (of_property_read_bool(np, "tx"))
+		__set_bit(NETDEV_LED_TX, &trigger_data->mode);
+	if (of_property_read_bool(np, "rx"))
+		__set_bit(NETDEV_LED_RX, &trigger_data->mode);
+	if (!of_property_read_string(np, "device-name", &device_name)) {
+		unsigned len = strlen(device_name);
+
+		if (len < IFNAMSIZ)
+			set_device(trigger_data, device_name, len);
+	}
+	set_baseline_state(trigger_data);
+
+	of_node_put(np);
+}
+
 static int netdev_trig_activate(struct led_classdev *led_cdev)
 {
 	struct led_netdev_data *trigger_data;
@@ -418,6 +448,7 @@ static int netdev_trig_activate(struct led_classdev *led_cdev)
 	trigger_data->mode = 0;
 	atomic_set(&trigger_data->interval, msecs_to_jiffies(50));
 	trigger_data->last_activity = 0;
+	netdev_trig_of_init(led_cdev, trigger_data);
 
 	led_set_trigger_data(led_cdev, trigger_data);
 
diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index e0f0ad7a550a..91703a96b636 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -77,7 +77,8 @@ config CAN_LEDS
 	# everything that this driver is doing. This is marked as broken
 	# because it uses stuff that is intended to be changed or removed.
 	# Please consider switching to the netdev trigger and confirm it
-	# fulfills your needs instead of fixing this driver.
+	# fulfills your needs instead of fixing this driver. See e.g.
+	# Documentation/devicetree/bindings/leds/common.txt
 	depends on BROKEN
 	select LEDS_TRIGGERS
 	---help---
-- 
2.20.1
