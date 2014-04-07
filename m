From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Mon, 7 Apr 2014 18:27:11 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404071816100.14882@ionos.tec.linutronix.de>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <10077840.fz9L5lnEL0@ws-stein> <alpine.DEB.2.02.1404071743270.14882@ionos.tec.linutronix.de> <1963054.jznjb2yEgj@ws-stein>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52520 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753993AbaDGQ1D (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Apr 2014 12:27:03 -0400
In-Reply-To: <1963054.jznjb2yEgj@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Mon, 7 Apr 2014, Alexander Stein wrote:
> On Monday 07 April 2014 17:53:59, Thomas Gleixner wrote:
> > On Mon, 7 Apr 2014, Alexander Stein wrote:
> > > On Monday 07 April 2014 17:24:26, Thomas Gleixner wrote:
> > > > It'd be odd, because we get the buffers with the NEWDAT pending bits
> > > > from the NEWDATA1 register.
> > >
> >  
> > > Using the following patch the warning raises about every 5ms. With
> > > and without your last patchset.
> > 
> > > but reverting c0a9f4d39 this does _NOT_ arise.
> > 
> > So the NEWDAT register is telling us that the newdat bit of that
> > buffer is set. But when we retrieve the message, it's not set.
> > 
> > What's even more confusing: On my D_CAN hardware the NEWDAT is not set
> > event happens when I revert c0a9f4d39
> > 
> > So it would be interesting to see, whether this event is aligned to
> > the lost packets you are hunting:
> > 
> >     P1 -> P2 -> WARN -> P4
> > 
> > A few trace printks should tell us pretty fast.
> 
> I slightly modified my patch (see below) to see which obj is marked
> with NEWDAT wrongly.  It turns out it is spread over many message
> objects, but object 1 is notably the one most occuring.  Can it
> happen, that NEWDAT1 already shows the bit while the NEWDAT bit is
> not updated yet?  Or does commit c0a9f4d39 affect this status
> because INTPEND is cleared before reading the message object now?

That's what we do not know. On D_CAN it result in hardware silently
dropping packets when we reneable the lower message buffers by
clearing the NEWDAT bit. So C_CAN might show some different behaviour
by giving us objects with the NEWDAT bit cleared.

That's why I came up with the patch which disables the RX Split. With 
CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING=n we clear NEWDAT and INTPEND
immediately. That's what the docs recommend (including the eg20t one).
We trade the lost packets against the potential reordering.

What really buggers me is that this does not work with your
hardware. I'll whip up a tracing patch later tonight.

Just for completeness, find the corrected patch below.

Thanks,

	tglx

------------->
Subject: can: c_can : Disable rx split as workaround
From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 03 Apr 2014 16:10:43 +0200

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

[ Oliver Hartkopp: Provided a sane config option and help text and
  made me switch to favour potential and unlikely reordering over
  packet loss ]

[ Alexander Stein: Made the CAN_C_CAN_STRICT_FRAME_ORDERING=n case
  compile ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/Kconfig |    7 +++++
 drivers/net/can/c_can/c_can.c |   54 ++++++++++++++++++++++++++++++------------
 2 files changed, 46 insertions(+), 15 deletions(-)

Index: linux/drivers/net/can/c_can/Kconfig
===================================================================
--- linux.orig/drivers/net/can/c_can/Kconfig
+++ linux/drivers/net/can/c_can/Kconfig
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
Index: linux/drivers/net/can/c_can/c_can.c
===================================================================
--- linux.orig/drivers/net/can/c_can/c_can.c
+++ linux/drivers/net/can/c_can/c_can.c
@@ -789,18 +789,39 @@ static u32 c_can_adjust_pending(u32 pend
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
+static inline void c_can_rx_finalize(struct net_device *dev,
+				     struct c_can_priv *priv, u32 obj)
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
@@ -820,21 +841,25 @@ static int c_can_read_objects(struct net
 		/* read the data from the message object */
 		c_can_read_msg_object(dev, IF_RX, ctrl);
 
-		if (obj < C_CAN_MSG_RX_LOW_LAST)
-			priv->rxmasked |= BIT(obj - 1);
-		else if (obj == C_CAN_MSG_RX_LOW_LAST) {
-			priv->rxmasked = 0;
-			/* activate all lower message objects */
-			c_can_activate_all_lower_rx_msg_obj(dev, IF_RX);
-		}
+		c_can_rx_finalize(dev, priv, obj);
 
 		pkts++;
 		quota--;
-	} while ((obj = ffs(pend)) && quota > 0);
+	}
 
 	return pkts;
 }
 
+static inline u32 c_can_get_pending(struct c_can_priv *priv)
+{
+	u32 pend = priv->read_reg(priv, C_CAN_NEWDAT1_REG);
+
+#ifdef CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING
+	pend &= ~priv->rxmasked;
+#endif
+	return pend;
+}
+
 /*
  * theory of operation:
  *
@@ -871,8 +896,7 @@ static int c_can_do_rx_poll(struct net_d
 
 	while (quota > 0) {
 		if (!pend) {
-			pend = priv->read_reg(priv, C_CAN_NEWDAT1_REG);
-			pend &= ~priv->rxmasked;
+			pend = c_can_get_pending(priv);
 			if (!pend)
 				break;
 			/*





