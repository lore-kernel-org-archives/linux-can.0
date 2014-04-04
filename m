From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 10/10 V2] can: c_can: Disable rx buffer split to prevent
 packet loss
Date: Fri, 4 Apr 2014 22:54:09 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404042216390.14882@ionos.tec.linutronix.de>
References: <20140404134816.751883017@linutronix.de> <20140404134858.173427806@linutronix.de> <533EEEC8.3090905@hartkopp.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43297 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbaDDUx6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Apr 2014 16:53:58 -0400
In-Reply-To: <533EEEC8.3090905@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>

The RX buffer split, which was invented to prevent packet reordering
causes packet loss in the hardware. The logic of the RX buffer split
is to keep the lower 8 buffers marked busy so we get a head start
against the hardware. Once we have read out the 8th buffer we reenable
them in ascending order:

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

But if during that clearing of newdat bits, a new message comes in,
the HW gets confused and drops it.

It does not matter how many of them you clear. I put a delay between
clear of buffer 1 and buffer 2 which was long enough that the message
should have been queued either in buffer 1 or buffer 9. But it did not
show up anywhere. The next message ended up in buffer 1. Finer grained
instrumentation shows that it's the reenabling of buffer 1 which
causes the hardware to go bonkers. Of course there is no sign that the
hardware tells us anything about that via one of the various error
accounting mechanisms.

That does not happen on all clear newdat bit events. I see one of 10k
packets dropped in the scenario which allows us to reproduce. But the
trace looks always the same. So the race is probably at the scope of a
few clock cycles.

Not splitting the RX Buffer avoids the packet loss but can cause
reordering. It's hard to trigger, but it CAN happen. Look at the
following scenario:

3 new messages are in the buffers 1-3

Read Packet 1 from buffer 1 
                                Hardware queues a new packet in buffer 1
                                Hardware queues a new packet in buffer 4

Read Packet 2 from buffer 2
Read Packet 3 from buffer 3

Now we have two new messages in the buffers 1 and 4, but no way to
tell which one got queued first because it might have been ordered
this way:

Read Packet 1 from buffer 1     Hardware queues a new packet in buffer 4

Read Packet 2 from buffer 2
                                Hardware queues a new packet in buffer 1
Read Packet 3 from buffer 3

And there is no way to avoid that even not by reading the NewDat
pending register between every packet readout simply because that
information is completely asynchronous.

With that mode we use the HW as it was probably designed for. We read
from the buffer 1 upwards and clear the buffer as we get the
message. That's how all microcontrollers use it. So I assume that the
way we handled the buffers so far was never really tested. According
to the public documentation it should just work. Emphasis on should :)

Let the user decide which evil is the lesser one. By default not
losing packets is the lesser evil. There is a rationale for this:

The only use cases which I can imagine (CAN power users might correct
me) are

1) A streaming protocol over CAN which lacks a mechanism to deal
   with that. But I consider such a protocol broken as it wont deal with
   lost packets either.

2) Attaching two sniffers to the same bus which see a different frame
   ordering. But you really do not care unless you try to decode a
   streaming protocol wreckage where the protocol lacks any protection
   against reordering and packet loss. See #1

Thanks to Oliver Hartkopp who provided a sane config option plus help
text and made me rethink and switch to favour the very unlikely
reordering over the very likely packet loss in the Kconfig default.

As a side note:

It's amazing how hardware designers can come up with a way to
implement non functional stuff which has been implemented a gazillion
times in a functional way already.

I knew so far that there are several ways to implement non functional
timers, but non functional FIFOs are definitely a new experience.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/Kconfig |    7 +++++++
 drivers/net/can/c_can/c_can.c |   38 ++++++++++++++++++++++++++------------
 2 files changed, 33 insertions(+), 12 deletions(-)

Index: linux-2.6/drivers/net/can/c_can/Kconfig
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/Kconfig
+++ linux-2.6/drivers/net/can/c_can/Kconfig
@@ -14,6 +14,13 @@ config CAN_C_CAN_PLATFORM
 	  SPEAr1310 and SPEAr320 evaluation boards & TI (www.ti.com)
 	  boards like am335x, dm814x, dm813x and dm811x.
 
+config CAN_C_CAN_STRICT_FRAME_ORDERING
+	bool "Force a strict RX CAN frame order (may cause frame loss)"
+	---help---
+	  The RX split buffer prevents packet reordering but can cause packet
+	  loss. Only enable this option when you accept to lose CAN frames
+	  in favour of getting the received CAN frames in the correct order.
+
 config CAN_C_CAN_PCI
 	tristate "Generic PCI Bus based C_CAN/D_CAN driver"
 	depends on PCI
Index: linux-2.6/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/c_can.c
+++ linux-2.6/drivers/net/can/c_can/c_can.c
@@ -789,18 +789,38 @@ static u32 c_can_adjust_pending(u32 pend
 	return pend & ~((1 << lasts) - 1);
 }
 
+static inline void c_can_rx_object_get(struct net_device *dev, u32 obj)
+{
+#ifdef CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING
+	if (obj < C_CAN_MSG_RX_LOW_LAST)
+		c_can_object_get(dev, IF_RX, obj, IF_COMM_RCV_LOW);
+	else
+#endif
+		c_can_object_get(dev, IF_RX, obj, IF_COMM_RCV_HIGH);
+}
+
+static inline void c_can_rx_finalize(struct c_can_priv *priv, u32 obj)
+{
+#ifdef CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING
+	if (obj < C_CAN_MSG_RX_LOW_LAST)
+		priv->rxmasked |= BIT(obj - 1);
+	else if (obj == C_CAN_MSG_RX_LOW_LAST) {
+		priv->rxmasked = 0;
+		/* activate all lower message objects */
+		c_can_activate_all_lower_rx_msg_obj(dev, IF_RX);
+	}
+#endif
+}
+
 static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
 			      u32 pend, int quota)
 {
-	u32 pkts = 0, ctrl, obj, mcmd;
+	u32 pkts = 0, ctrl, obj;
 
 	while ((obj = ffs(pend)) && quota > 0) {
 		pend &= ~BIT(obj - 1);
 
-		mcmd = obj < C_CAN_MSG_RX_LOW_LAST ?
-			IF_COMM_RCV_LOW : IF_COMM_RCV_HIGH;
-
-		c_can_object_get(dev, IF_RX, obj, mcmd);
+		c_can_rx_object_get(dev, obj);
 		ctrl = priv->read_reg(priv, C_CAN_IFACE(MSGCTRL_REG, IF_RX));
 
 		if (ctrl & IF_MCONT_MSGLST) {
@@ -822,13 +842,7 @@ static int c_can_read_objects(struct net
 		/* read the data from the message object */
 		c_can_read_msg_object(dev, IF_RX, ctrl);
 
-		if (obj < C_CAN_MSG_RX_LOW_LAST)
-			priv->rxmasked |= BIT(obj - 1);
-		else if (obj == C_CAN_MSG_RX_LOW_LAST) {
-			priv->rxmasked = 0;
-			/* activate all lower message objects */
-			c_can_activate_all_lower_rx_msg_obj(dev, IF_RX);
-		}
+		c_can_rx_finalize(priv, obj);
 
 		pkts++;
 		quota--;
