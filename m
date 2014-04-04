From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 10/10] can: c_can : Disable rx split as workaround
Date: Fri, 04 Apr 2014 15:24:28 -0000
Message-ID: <20140404134858.173427806@linutronix.de>
References: <20140404134816.751883017@linutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41571 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbaDDPYQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Apr 2014 11:24:16 -0400
Content-Disposition: inline;
 filename=can-c_can-disable-rx-split-as-workaround.patch
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>

The RX buffer split causes packet loss in the hardware:

What happens is:

RX Packet 1 --> message buffer 1 (newdat bit is not cleared)
RX Packet 2 --> message buffer 2 (newdat bit is not cleared)
RX Packet 3 --> message buffer 3 (newdat bit is not cleared)
RX Packet 4 --> message buffer 4 (newdat bit is not cleared)
RX Packet 5 --> message buffer 5 (newdat bit is not cleared)
RX Packet 6 --> message buffer 6 (newdat bit is not cleared)
RX Packet 7 --> message buffer 7 (newdat bit is not cleared)
RX Packet 8 --> message buffer 8 (newdat bit is not cleared)

Clear newdat bit in message buffer 1
Clear newdat bit in message buffer 2
Clear newdat bit in message buffer 3
Clear newdat bit in message buffer 4
Clear newdat bit in message buffer 5
Clear newdat bit in message buffer 6
Clear newdat bit in message buffer 7
Clear newdat bit in message buffer 8

Now if during that clearing of newdat bits, a new message comes in,
the HW gets confused and drops it. 

It does not matter how many of them you clear. I put a delay between
clear of buffer 1 and buffer 2 which was long enough that the message
should have been queued either in buffer 1 or buffer 9. But it did not
show up anywhere. The next message ended up in buffer 1. So the
hardware lost a packet of course without telling it via one of the
error handlers.

That does not happen on all clear newdat bit events. I see one of 10k
packets dropped in the scenario which allows us to reproduce. But the
trace looks always the same.

Not splitting the RX Buffer avoids the packet loss but can cause
reordering. It's hard to trigger, but it CAN happen.

With that mode we use the HW as it was probably designed for. We read
from the buffer 1 upwards and clear the buffer as we get the
message. That's how all microcontrollers use it. So I assume that the
way we handle the buffers was never really tested. According to the
public documentation it should just work :)

Let the user decide which evil is the lesser one.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/Kconfig |    6 ++++++
 drivers/net/can/c_can/c_can.c |    7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

Index: linux-can/drivers/net/can/c_can/Kconfig
===================================================================
--- linux-can.orig/drivers/net/can/c_can/Kconfig
+++ linux-can/drivers/net/can/c_can/Kconfig
@@ -14,6 +14,12 @@ config CAN_C_CAN_PLATFORM
 	  SPEAr1310 and SPEAr320 evaluation boards & TI (www.ti.com)
 	  boards like am335x, dm814x, dm813x and dm811x.
 
+config CAN_C_CAN_NO_RX_SPLIT
+	bool "Disable RX Split buffer"
+	---help---
+	  RX Split buffer prevents packet reordering but can cause packet
+	  loss. Select the less of the two evils.
+
 config CAN_C_CAN_PCI
 	tristate "Generic PCI Bus based C_CAN/D_CAN driver"
 	depends on PCI
Index: linux-can/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-can.orig/drivers/net/can/c_can/c_can.c
+++ linux-can/drivers/net/can/c_can/c_can.c
@@ -797,8 +797,12 @@ static int c_can_read_objects(struct net
 	while ((obj = ffs(pend)) && quota > 0) {
 		pend &= ~BIT(obj - 1);
 
+#ifndef CONFIG_CAN_C_CAN_NO_RX_SPLIT
 		mcmd = obj < C_CAN_MSG_RX_LOW_LAST ?
 			IF_COMM_RCV_LOW : IF_COMM_RCV_HIGH;
+#else
+		mcmd = IF_COMM_RCV_HIGH;
+#endif
 
 		c_can_object_get(dev, IF_RX, obj, mcmd);
 		ctrl = priv->read_reg(priv, C_CAN_IFACE(MSGCTRL_REG, IF_RX));
@@ -822,6 +826,7 @@ static int c_can_read_objects(struct net
 		/* read the data from the message object */
 		c_can_read_msg_object(dev, IF_RX, ctrl);
 
+#ifndef CONFIG_CAN_C_CAN_NO_RX_SPLIT
 		if (obj < C_CAN_MSG_RX_LOW_LAST)
 			priv->rxmasked |= BIT(obj - 1);
 		else if (obj == C_CAN_MSG_RX_LOW_LAST) {
@@ -829,7 +834,7 @@ static int c_can_read_objects(struct net
 			/* activate all lower message objects */
 			c_can_activate_all_lower_rx_msg_obj(dev, IF_RX);
 		}
-
+#endif
 		pkts++;
 		quota--;
 	}


