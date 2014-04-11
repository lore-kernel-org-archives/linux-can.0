From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 03/21] can: c_can: Make bus off interrupt disable logic work
Date: Fri, 11 Apr 2014 08:13:11 -0000
Message-ID: <20140411080650.811745846@linutronix.de>
References: <20140411080547.845836199@linutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52359 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755535AbaDKIM7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Apr 2014 04:12:59 -0400
Content-Disposition: inline;
 filename=can-c_can-Make-bus-off-interrupt-disable-logic-work.patch
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Mark <mark5@del-llc.com>

The state change handler is called with device interrupts disabled
already. So no point in disabling them again when we enter bus off
state.

But what's worse is that we reenable the interrupts at the end of NAPI
poll unconditionally. So c_can_start() which is called from the
restart timer can trigger interrupts which confuse the hell out of the
half reinitialized driver/hw.

Remove the pointless device interrupt disable in the BUS_OFF handler
and prevent reenabling the device interrupts at the end of the poll
routine when the current state is BUS_OFF.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/c_can.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/c_can.c
+++ linux-2.6/drivers/net/can/c_can/c_can.c
@@ -954,11 +954,6 @@ static int c_can_handle_state_change(str
 		/* bus-off state */
 		priv->can.state = CAN_STATE_BUS_OFF;
 		cf->can_id |= CAN_ERR_BUSOFF;
-		/*
-		 * disable all interrupts in bus-off mode to ensure that
-		 * the CPU is not hogged down
-		 */
-		c_can_enable_all_interrupts(priv, DISABLE_ALL_INTERRUPTS);
 		can_bus_off(dev);
 		break;
 	default:
@@ -1089,6 +1084,7 @@ static int c_can_poll(struct napi_struct
 			netdev_dbg(dev, "entered bus off state\n");
 			work_done += c_can_handle_state_change(dev,
 						C_CAN_BUS_OFF);
+			goto end;
 		}
 
 		/* handle bus recovery events */
@@ -1122,8 +1118,9 @@ static int c_can_poll(struct napi_struct
 end:
 	if (work_done < quota) {
 		napi_complete(napi);
-		/* enable all IRQs */
-		c_can_enable_all_interrupts(priv, ENABLE_ALL_INTERRUPTS);
+		/* enable all IRQs if we are not in bus off state */
+		if (priv->can.state != CAN_STATE_BUS_OFF)
+			c_can_enable_all_interrupts(priv, ENABLE_ALL_INTERRUPTS);
 	}
 
 	return work_done;


