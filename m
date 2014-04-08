From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Tue, 08 Apr 2014 09:07:06 +0200
Message-ID: <1513830.2DNAbkNIid@ws-stein>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <1963054.jznjb2yEgj@ws-stein> <alpine.DEB.2.02.1404071816100.14882@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:56961 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751109AbaDHHIT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Apr 2014 03:08:19 -0400
In-Reply-To: <alpine.DEB.2.02.1404071816100.14882@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Monday 07 April 2014 18:27:11, Thomas Gleixner wrote:
> > > So it would be interesting to see, whether this event is aligned to
> > > the lost packets you are hunting:
> > > 
> > >     P1 -> P2 -> WARN -> P4
> > > 
> > > A few trace printks should tell us pretty fast.
> > 
> > I slightly modified my patch (see below) to see which obj is marked
> > with NEWDAT wrongly.  It turns out it is spread over many message
> > objects, but object 1 is notably the one most occuring.  Can it
> > happen, that NEWDAT1 already shows the bit while the NEWDAT bit is
> > not updated yet?  Or does commit c0a9f4d39 affect this status
> > because INTPEND is cleared before reading the message object now?
> 
> That's what we do not know. On D_CAN it result in hardware silently
> dropping packets when we reneable the lower message buffers by
> clearing the NEWDAT bit. So C_CAN might show some different behaviour
> by giving us objects with the NEWDAT bit cleared.
> 
> That's why I came up with the patch which disables the RX Split. With 
> CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING=n we clear NEWDAT and INTPEND
> immediately. That's what the docs recommend (including the eg20t one).
> We trade the lost packets against the potential reordering.
> 
> What really buggers me is that this does not work with your
> hardware. I'll whip up a tracing patch later tonight.

So I noticed that with CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING=n (NEWDAT and INTPEND cleared immediately) the "odd behavior" occurs pretty often.
Before
> c_can_rx_object_get(dev, obj);
NEWDAT is still set, but afterwards it is already cleared in C_CAN_NEWDAT1_REG.
I guess the NEWDAT is already cleared in the message object before reading from the message object with this line
> ctrl = priv->read_reg(priv, C_CAN_IFACE(MSGCTRL_REG, IF_RX));

So I removed that IF_MCONT_NEWDAT check (see below) and I didn't lose any message, but get 5 duplicates in 250000 messages (no reordering though).

Setting CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING=y with that patch I lose ~650msg per 250000 frames.

Regards,
Alexander

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 0e9f974..dd75360 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -831,14 +831,6 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
 			continue;
 		}
 
-		/*
-		 * This really should not happen, but this covers some
-		 * odd HW behaviour. Do not remove that unless you
-		 * want to brick your machine.
-		 */
-		if (!(ctrl & IF_MCONT_NEWDAT))
-			continue;
-
 		/* read the data from the message object */
 		c_can_read_msg_object(dev, IF_RX, ctrl);
 

-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

