From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Tue, 8 Apr 2014 10:26:23 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404081017370.14882@ionos.tec.linutronix.de>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <1963054.jznjb2yEgj@ws-stein> <alpine.DEB.2.02.1404071816100.14882@ionos.tec.linutronix.de> <1513830.2DNAbkNIid@ws-stein>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55337 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756471AbaDHI0M (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Apr 2014 04:26:12 -0400
In-Reply-To: <1513830.2DNAbkNIid@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Tue, 8 Apr 2014, Alexander Stein wrote:
> On Monday 07 April 2014 18:27:11, Thomas Gleixner wrote:
> > > > So it would be interesting to see, whether this event is aligned to
> > > > the lost packets you are hunting:
> > > > 
> > > >     P1 -> P2 -> WARN -> P4
> > > > 
> > > > A few trace printks should tell us pretty fast.
> > > 
> > > I slightly modified my patch (see below) to see which obj is marked
> > > with NEWDAT wrongly.  It turns out it is spread over many message
> > > objects, but object 1 is notably the one most occuring.  Can it
> > > happen, that NEWDAT1 already shows the bit while the NEWDAT bit is
> > > not updated yet?  Or does commit c0a9f4d39 affect this status
> > > because INTPEND is cleared before reading the message object now?
> > 
> > That's what we do not know. On D_CAN it result in hardware silently
> > dropping packets when we reneable the lower message buffers by
> > clearing the NEWDAT bit. So C_CAN might show some different behaviour
> > by giving us objects with the NEWDAT bit cleared.
> > 
> > That's why I came up with the patch which disables the RX Split. With 
> > CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING=n we clear NEWDAT and INTPEND
> > immediately. That's what the docs recommend (including the eg20t one).
> > We trade the lost packets against the potential reordering.
> > 
> > What really buggers me is that this does not work with your
> > hardware. I'll whip up a tracing patch later tonight.
> 
> So I noticed that with CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING=n
> (NEWDAT and INTPEND cleared immediately) the "odd behavior" occurs
> pretty often.
> Before
>   c_can_rx_object_get(dev, obj);
> NEWDAT is still set, but afterwards it is already cleared in
> C_CAN_NEWDAT1_REG.

Which is expected. We clear the newdat bit in c_can_rx_object_get(),
which updates C_CAN_NEWDAT1_REG as well.

> I guess the NEWDAT is already cleared in the message object before
> reading from the message object with this line

> > ctrl = priv->read_reg(priv, C_CAN_IFACE(MSGCTRL_REG, IF_RX));
> 
> So I removed that IF_MCONT_NEWDAT check (see below) and I didn't
> lose any message, but get 5 duplicates in 250000 messages (no
> reordering though).
> 
> Setting CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING=y with that patch I
> lose ~650msg per 250000 frames.

What happens, if you apply the patch below?

Thanks,

	tglx

Index: linux-2.6/drivers/net/can/c_can/c_can.c
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/c_can.c
+++ linux-2.6/drivers/net/can/c_can/c_can.c
@@ -880,7 +880,7 @@ static int c_can_do_rx_poll(struct net_d
 
 	while (quota > 0) {
 		if (!pend) {
-			pend = priv->read_reg(priv, C_CAN_INTPND1_REG);
+			pend = priv->read_reg(priv, C_CAN_NEWDAT1_REG);
 			if (!pend)
 				break;
 			/*
