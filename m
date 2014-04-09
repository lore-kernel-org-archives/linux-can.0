From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] can: c_can: Fix bit clearing and message object read
Date: Wed, 9 Apr 2014 02:42:57 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404090232400.14882@ionos.tec.linutronix.de>
References: <1396950382-13091-1-git-send-email-alexander.stein@systec-electronic.com> <6189770.Mjp8LixSFl@ws-stein> <alpine.DEB.2.02.1404081613141.14882@ionos.tec.linutronix.de> <8083460.0p0S3IB599@ws-stein>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35059 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756286AbaDIAmr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Apr 2014 20:42:47 -0400
In-Reply-To: <8083460.0p0S3IB599@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

B1;3202;0cOn Tue, 8 Apr 2014, Alexander Stein wrote:
> On Tuesday 08 April 2014 16:15:37, Thomas Gleixner wrote:
> > On Tue, 8 Apr 2014, Alexander Stein wrote:
> > > On Tuesday 08 April 2014 15:07:10, Thomas Gleixner wrote:
> > > The problem is that NEWDAT in the crtl register readout is most of the time set, but sometimes not.
> > > Adding the delay above it is unset all the time :(
> > 
> > Now what happens if you disable interrupts across the writes:
> > 
> >     local_irq_disable()
> >     write(COMMSK)
> >     write(COMREQ)
> >     local_irq_enable()
> 
> There are still message objects where NEWDAT is unset. Even if the c_can_msg_obj_is_busy check is included.
> 

I found the issue after a I got hold of a PCH afflicted system. It
might not apply cleanly as I changed a few other things in my patch
queue, but you get the idea. Too tired now to write changelogs, run
tests ....

W/o that patch I observe the same problems as you. With that applied I
did not observe any dropout with a 10 * 1e6 packet run.

Thanks,

	tglx
-------------->
Subject: can: c_can: Work around C_CAN RX wreckage
From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 08 Apr 2014 21:41:51 +0200

Alexander reported that the new optimized handling of the RX fifo
causes random packet loss on Intel PCH C_CAN hardware.

After a few fruitless debugging sessions I got hold of a PCH (eg20t)
afflicted system. That machine does not have the CAN interface wired
up, but it was possible to reproduce the issue with the HW loopback
mode.

As Alexander observed correctly, clearing the NewDat flag along with
reading out the message buffer causes that issue on C_CAN, while D_CAN
handles that correctly.

Instead of restoring the original message buffer handling horror the
following workaround solves the issue:

    transfer buffer to IF without clearing the NewDat
    handle the message
    clear NewDat bit

That's similar to the original code but conditional for C_CAN.

I really wonder why all user manuals (C_CAN, Intel PCH and some more)
recommend to clear the NewDat bit right away. The knows it all Oracle
operated by Gurgle does not unearth any useful information either. I
simply cannot believe that we are the first to uncover that HW issue.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/c_can.c |   13 ++++++++++---
 drivers/net/can/c_can/c_can.h |    1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/c_can.c
+++ linux-2.6/drivers/net/can/c_can/c_can.c
@@ -644,6 +644,10 @@ static int c_can_start(struct net_device
 	if (err)
 		return err;
 
+	/* Setup the command for new messages */
+	priv->comm_rcv_high = priv->type != BOSCH_D_CAN ?
+		IF_COMM_RCV_LOW : IF_COMM_RCV_HIGH;
+
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	/* reset tx helper pointers and the rx mask */
@@ -788,14 +792,15 @@ static u32 c_can_adjust_pending(u32 pend
 	return pend & ~((1 << lasts) - 1);
 }
 
-static inline void c_can_rx_object_get(struct net_device *dev, u32 obj)
+static inline void c_can_rx_object_get(struct net_device *dev,
+				       struct c_can_priv *priv, u32 obj)
 {
 #ifdef CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING
 	if (obj < C_CAN_MSG_RX_LOW_LAST)
 		c_can_object_get(dev, IF_RX, obj, IF_COMM_RCV_LOW);
 	else
 #endif
-		c_can_object_get(dev, IF_RX, obj, IF_COMM_RCV_HIGH);
+		c_can_object_get(dev, IF_RX, obj, priv->comm_rcv_high);
 }
 
 static inline void c_can_rx_finalize(struct net_device *dev,
@@ -810,6 +815,8 @@ static inline void c_can_rx_finalize(str
 		c_can_activate_all_lower_rx_msg_obj(dev, IF_RX);
 	}
 #endif
+	if (priv->type != BOSCH_D_CAN)
+		c_can_object_get(dev, IF_RX, obj, IF_COMM_CLR_NEWDAT);
 }
 
 static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
@@ -820,7 +827,7 @@ static int c_can_read_objects(struct net
 	while ((obj = ffs(pend)) && quota > 0) {
 		pend &= ~BIT(obj - 1);
 
-		c_can_rx_object_get(dev, obj);
+		c_can_rx_object_get(dev, priv, obj);
 		ctrl = priv->read_reg(priv, C_CAN_IFACE(MSGCTRL_REG, IF_RX));
 
 		if (ctrl & IF_MCONT_MSGLST) {
Index: linux-2.6/drivers/net/can/c_can/c_can.h
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/c_can.h
+++ linux-2.6/drivers/net/can/c_can/c_can.h
@@ -198,6 +198,7 @@ struct c_can_priv {
 	u32 __iomem *raminit_ctrlreg;
 	unsigned int instance;
 	void (*raminit) (const struct c_can_priv *priv, bool enable);
+	u32 comm_rcv_high;
 	u32 rxmasked;
 	u32 dlc[C_CAN_MSG_OBJ_TX_NUM];
 };
