From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 13/21] can: c_can: Cleanup irq enable/disable
Date: Fri, 11 Apr 2014 08:13:17 -0000
Message-ID: <20140411080652.741486071@linutronix.de>
References: <20140411080547.845836199@linutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52429 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555AbaDKINE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Apr 2014 04:13:04 -0400
Content-Disposition: inline; filename=can-c_can-cleanup-irq-enable-stuff.patch
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Mark <mark5@del-llc.com>

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/c_can.c |   37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

Index: linux-2.6/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/c_can.c
+++ linux-2.6/drivers/net/can/c_can/c_can.c
@@ -60,6 +60,8 @@
 #define CONTROL_IE		BIT(1)
 #define CONTROL_INIT		BIT(0)
 
+#define CONTROL_IRQMSK		(CONTROL_EIE | CONTROL_IE | CONTROL_SIE)
+
 /* test register */
 #define TEST_RX			BIT(7)
 #define TEST_TX1		BIT(6)
@@ -146,13 +148,6 @@
 #define IF_RX			0
 #define IF_TX			1
 
-/* status interrupt */
-#define STATUS_INTERRUPT	0x8000
-
-/* global interrupt masks */
-#define ENABLE_ALL_INTERRUPTS	1
-#define DISABLE_ALL_INTERRUPTS	0
-
 /* minimum timeout for checking BUSY status */
 #define MIN_TIMEOUT_VALUE	6
 
@@ -246,18 +241,14 @@ static u32 c_can_read_reg32(struct c_can
 	return val;
 }
 
-static void c_can_enable_all_interrupts(struct c_can_priv *priv,
-						int enable)
+static void c_can_irq_control(struct c_can_priv *priv, bool enable)
 {
-	unsigned int cntrl_save = priv->read_reg(priv,
-						C_CAN_CTRL_REG);
+	u32 ctrl = priv->read_reg(priv,	C_CAN_CTRL_REG) & ~CONTROL_IRQMSK;
 
 	if (enable)
-		cntrl_save |= (CONTROL_SIE | CONTROL_EIE | CONTROL_IE);
-	else
-		cntrl_save &= ~(CONTROL_EIE | CONTROL_IE | CONTROL_SIE);
+		ctrl |= CONTROL_IRQMSK;
 
-	priv->write_reg(priv, C_CAN_CTRL_REG, cntrl_save);
+	priv->write_reg(priv, C_CAN_CTRL_REG, ctrl);
 }
 
 static inline int c_can_msg_obj_is_busy(struct c_can_priv *priv, int iface)
@@ -664,10 +655,7 @@ static void c_can_stop(struct net_device
 {
 	struct c_can_priv *priv = netdev_priv(dev);
 
-	/* disable all interrupts */
-	c_can_enable_all_interrupts(priv, DISABLE_ALL_INTERRUPTS);
-
-	/* set the state as STOPPED */
+	c_can_irq_control(priv, false);
 	priv->can.state = CAN_STATE_STOPPED;
 }
 
@@ -682,8 +670,7 @@ static int c_can_set_mode(struct net_dev
 		if (err)
 			return err;
 		netif_wake_queue(dev);
-		/* enable status change, error and module interrupts */
-		c_can_enable_all_interrupts(priv, ENABLE_ALL_INTERRUPTS);
+		c_can_irq_control(priv, true);
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -1144,7 +1131,7 @@ end:
 		napi_complete(napi);
 		/* enable all IRQs if we are not in bus off state */
 		if (priv->can.state != CAN_STATE_BUS_OFF)
-			c_can_enable_all_interrupts(priv, ENABLE_ALL_INTERRUPTS);
+			c_can_irq_control(priv, true);
 	}
 
 	return work_done;
@@ -1159,7 +1146,7 @@ static irqreturn_t c_can_isr(int irq, vo
 		return IRQ_NONE;
 
 	/* disable all interrupts and schedule the NAPI */
-	c_can_enable_all_interrupts(priv, DISABLE_ALL_INTERRUPTS);
+	c_can_irq_control(priv, false);
 	napi_schedule(&priv->napi);
 
 	return IRQ_HANDLED;
@@ -1197,7 +1184,7 @@ static int c_can_open(struct net_device
 
 	napi_enable(&priv->napi);
 	/* enable status change, error and module interrupts */
-	c_can_enable_all_interrupts(priv, ENABLE_ALL_INTERRUPTS);
+	c_can_irq_control(priv, true);
 	netif_start_queue(dev);
 
 	return 0;
@@ -1324,7 +1311,7 @@ int c_can_power_up(struct net_device *de
 
 	ret = c_can_start(dev);
 	if (!ret)
-		c_can_enable_all_interrupts(priv, ENABLE_ALL_INTERRUPTS);
+		c_can_irq_control(priv, true);
 
 	return ret;
 }


