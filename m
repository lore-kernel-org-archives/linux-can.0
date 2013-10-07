From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/7] can: dev: add berr_limit infrastrucutre
Date: Mon,  7 Oct 2013 16:40:38 +0200
Message-ID: <1381156840-24071-6-git-send-email-mkl@pengutronix.de>
References: <1381156840-24071-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33017 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438Ab3JGOkr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Oct 2013 10:40:47 -0400
In-Reply-To: <1381156840-24071-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

The CAN bus, like the old 10BASE2 Ethernet, needs bus termination. An open CAN
bus doesn't work and will produce lots of CAN bus errors.

If the user wants to detect an open CAN bus, the CAN bus error interrupts have
to be enabled. This is represented by the control mode
CAN_CTRLMODE_BERR_REPORTING.

On an unterminated CAN bus at 500 kbit/s, this can lead to more then 8000
interrupts/s on some SoCs with integrated CAN cores. These interrupts and the
associated processing in software lead to a significant load and may reader the
system unresponsive and even unusable at CAN bus speeds of 1000 kbit/s.

This patch adds the infrastructure to limit these interrupts. The driver has to
implement the do_berr_restart() callback, which re-enables the bus error
interrupts. The idea is to delay the re-enabling of the interrupts after they
have been served. The delay is configured by berr_limit_delay. A value of 0
means interrupts are restarted immediately, any other other value will start a
timer and call do_berr_restart() when the timer fires.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev.c   | 26 ++++++++++++++++++++++++++
 include/linux/can/dev.h |  5 +++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index bda1888..969d3cd 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -486,6 +486,29 @@ void can_bus_off(struct net_device *dev)
 }
 EXPORT_SYMBOL_GPL(can_bus_off);
 
+static void can_berr_restart(unsigned long data)
+{
+	struct net_device *dev = (struct net_device *)data;
+	struct can_priv *priv = netdev_priv(dev);
+
+	netdev_dbg(dev, "berr-restart\n");
+	priv->do_berr_restart(dev);
+}
+
+void can_berr_limit(struct net_device *dev)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	if (priv->berr_limit_delay) {
+		netdev_dbg(dev, "berr-limit\n");
+		mod_timer(&priv->berr_limit_timer,
+			  jiffies + priv->berr_limit_delay);
+	} else {
+		priv->do_berr_restart(dev);
+	}
+}
+EXPORT_SYMBOL_GPL(can_berr_limit);
+
 static void can_setup(struct net_device *dev)
 {
 	dev->type = ARPHRD_CAN;
@@ -567,6 +590,7 @@ struct net_device *alloc_candev(int sizeof_priv, unsigned int echo_skb_max)
 	priv->state = CAN_STATE_STOPPED;
 
 	init_timer(&priv->restart_timer);
+	init_timer(&priv->berr_limit_timer);
 
 	return dev;
 }
@@ -601,6 +625,7 @@ int open_candev(struct net_device *dev)
 		netif_carrier_on(dev);
 
 	setup_timer(&priv->restart_timer, can_restart, (unsigned long)dev);
+	setup_timer(&priv->berr_limit_timer, can_berr_restart, (unsigned long)dev);
 
 	return 0;
 }
@@ -616,6 +641,7 @@ void close_candev(struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
 
+	del_timer_sync(&priv->berr_limit_timer);
 	del_timer_sync(&priv->restart_timer);
 	can_flush_echo_skb(dev);
 }
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index fb0ab65..9162baa 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -44,12 +44,16 @@ struct can_priv {
 	int restart_ms;
 	struct timer_list restart_timer;
 
+	unsigned long berr_limit_delay;		/* in jiffies */
+	struct timer_list berr_limit_timer;
+
 	int (*do_set_bittiming)(struct net_device *dev);
 	int (*do_set_mode)(struct net_device *dev, enum can_mode mode);
 	int (*do_get_state)(const struct net_device *dev,
 			    enum can_state *state);
 	int (*do_get_berr_counter)(const struct net_device *dev,
 				   struct can_berr_counter *bec);
+	void (*do_berr_restart)(const struct net_device *dev);
 
 	unsigned int echo_skb_max;
 	struct sk_buff **echo_skb;
@@ -117,6 +121,7 @@ void unregister_candev(struct net_device *dev);
 
 int can_restart_now(struct net_device *dev);
 void can_bus_off(struct net_device *dev);
+void can_berr_limit(struct net_device *dev);
 
 void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 		      unsigned int idx);
-- 
1.8.4.rc3

