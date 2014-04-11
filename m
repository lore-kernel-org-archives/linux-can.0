From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 02/21] can: c_can: Fix startup logic
Date: Fri, 11 Apr 2014 08:13:10 -0000
Message-ID: <20140411080650.634599352@linutronix.de>
References: <20140411080547.845836199@linutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52355 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755539AbaDKIM7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Apr 2014 04:12:59 -0400
Content-Disposition: inline; filename=can-c_can-fix-startup-logic.patch
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Mark <mark5@del-llc.com>

c_can_start() enables interrupts way too early. The first enabling
happens when setting the control mode in c_can_chip_config() and then
again at the end of the function.

But that happens before napi_enable() and that means that an interrupt
which comes in will disable interrupts again and call napi_schedule,
which ignores the request and the later napi_enable() is not making
thinks work either. So the interface is up with all device interrupts
disabled.

Move the device interrupt after napi_enable() and add it to the other
callsites of c_can_start() in c_can_set_mode() and c_can_power_up()

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/c_can.c |   35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

Index: linux-2.6/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/c_can.c
+++ linux-2.6/drivers/net/can/c_can/c_can.c
@@ -612,30 +612,22 @@ static int c_can_chip_config(struct net_
 	struct c_can_priv *priv = netdev_priv(dev);
 
 	/* enable automatic retransmission */
-	priv->write_reg(priv, C_CAN_CTRL_REG,
-			CONTROL_ENABLE_AR);
+	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_ENABLE_AR);
 
 	if ((priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) &&
 	    (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)) {
 		/* loopback + silent mode : useful for hot self-test */
-		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_EIE |
-				CONTROL_SIE | CONTROL_IE | CONTROL_TEST);
-		priv->write_reg(priv, C_CAN_TEST_REG,
-				TEST_LBACK | TEST_SILENT);
+		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST);
+		priv->write_reg(priv, C_CAN_TEST_REG, TEST_LBACK | TEST_SILENT);
 	} else if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
 		/* loopback mode : useful for self-test function */
-		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_EIE |
-				CONTROL_SIE | CONTROL_IE | CONTROL_TEST);
+		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST);
 		priv->write_reg(priv, C_CAN_TEST_REG, TEST_LBACK);
 	} else if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) {
 		/* silent mode : bus-monitoring mode */
-		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_EIE |
-				CONTROL_SIE | CONTROL_IE | CONTROL_TEST);
+		priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_TEST);
 		priv->write_reg(priv, C_CAN_TEST_REG, TEST_SILENT);
-	} else
-		/* normal mode*/
-		priv->write_reg(priv, C_CAN_CTRL_REG,
-				CONTROL_EIE | CONTROL_SIE | CONTROL_IE);
+	}
 
 	/* configure message objects */
 	c_can_configure_msg_objects(dev);
@@ -662,9 +654,6 @@ static int c_can_start(struct net_device
 	/* reset tx helper pointers */
 	priv->tx_next = priv->tx_echo = 0;
 
-	/* enable status change, error and module interrupts */
-	c_can_enable_all_interrupts(priv, ENABLE_ALL_INTERRUPTS);
-
 	return 0;
 }
 
@@ -681,6 +670,7 @@ static void c_can_stop(struct net_device
 
 static int c_can_set_mode(struct net_device *dev, enum can_mode mode)
 {
+	struct c_can_priv *priv = netdev_priv(dev);
 	int err;
 
 	switch (mode) {
@@ -689,6 +679,8 @@ static int c_can_set_mode(struct net_dev
 		if (err)
 			return err;
 		netif_wake_queue(dev);
+		/* enable status change, error and module interrupts */
+		c_can_enable_all_interrupts(priv, ENABLE_ALL_INTERRUPTS);
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -1184,6 +1176,8 @@ static int c_can_open(struct net_device
 	can_led_event(dev, CAN_LED_EVENT_OPEN);
 
 	napi_enable(&priv->napi);
+	/* enable status change, error and module interrupts */
+	c_can_enable_all_interrupts(priv, ENABLE_ALL_INTERRUPTS);
 	netif_start_queue(dev);
 
 	return 0;
@@ -1281,6 +1275,7 @@ int c_can_power_up(struct net_device *de
 	u32 val;
 	unsigned long time_out;
 	struct c_can_priv *priv = netdev_priv(dev);
+	int ret;
 
 	if (!(dev->flags & IFF_UP))
 		return 0;
@@ -1307,7 +1302,11 @@ int c_can_power_up(struct net_device *de
 	if (time_after(jiffies, time_out))
 		return -ETIMEDOUT;
 
-	return c_can_start(dev);
+	ret = c_can_start(dev);
+	if (!ret)
+		c_can_enable_all_interrupts(priv, ENABLE_ALL_INTERRUPTS);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(c_can_power_up);
 #endif


