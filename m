From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] can: c_can: Fix bit clearing and message object read
Date: Tue, 08 Apr 2014 16:02:47 +0200
Message-ID: <6189770.Mjp8LixSFl@ws-stein>
References: <1396950382-13091-1-git-send-email-alexander.stein@systec-electronic.com> <alpine.DEB.2.02.1404081421140.14882@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:60969 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756351AbaDHOEA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Apr 2014 10:04:00 -0400
In-Reply-To: <alpine.DEB.2.02.1404081421140.14882@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On Tuesday 08 April 2014 15:07:10, Thomas Gleixner wrote:
> On Tue, 8 Apr 2014, Alexander Stein wrote:
> > It seems that clearing some bits in a message object using COMMSK_REG and
> > reading this object afterwards using COMREQ_REG is not race free.
> > It might occur that the read message object still contains the
> > IF_MCONT_NEWDAT bit set while it was already cleared upon write to
> > COMMSK_REG. So insert a dummy read to the hardware.
> 
> No. It does not get cleared with the write to COMMSK_REG. That's just
> a write. That write does nothing.
> 
> The execution of the transfer starts with writing the message object
> number to COMREQ_REG. How should the IF know which message object you
> want to access?

Ok, I agree with you here. Strangly using the followed patch IF_MCONT_NEWDAT is not even set in a single message buffer.
How can that delay influence a write that will happen later?

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 0e9f974..ea0aacc 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -290,6 +290,9 @@ static inline void c_can_object_get(struct net_device *dev,
 	 */
 	priv->write_reg(priv, C_CAN_IFACE(COMMSK_REG, iface),
 			IFX_WRITE_LOW_16BIT(mask));
+
+	udelay(10);
+
 	priv->write_reg(priv, C_CAN_IFACE(COMREQ_REG, iface),
 			IFX_WRITE_LOW_16BIT(objno));
 
@@ -832,12 +835,11 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
 		}
 
 		/*
-		 * This really should not happen, but this covers some
-		 * odd HW behaviour. Do not remove that unless you
-		 * want to brick your machine.
+		 * This really should not happen, but this warns about some
+		 * odd HW behaviour.
 		 */
-		if (!(ctrl & IF_MCONT_NEWDAT))
-			continue;
+		if ((ctrl & IF_MCONT_NEWDAT))
+			netdev_warn(dev, "IF_MCONT_NEWDAT still set on obj: %d", obj);
 
 		/* read the data from the message object */
 		c_can_read_msg_object(dev, IF_RX, ctrl);

> >  	priv->write_reg(priv, C_CAN_IFACE(COMREQ_REG, iface),
> >  			IFX_WRITE_LOW_16BIT(objno));
> >  
> > @@ -832,12 +839,11 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
> >  		}
> >  
> >  		/*
> > -		 * This really should not happen, but this covers some
> > -		 * odd HW behaviour. Do not remove that unless you
> > -		 * want to brick your machine.
> > +		 * This really should not happen, but this warns about some
> > +		 * odd HW behaviour.
> >  		 */
> > -		if (!(ctrl & IF_MCONT_NEWDAT))
> > -			continue;
> > +		if ((ctrl & IF_MCONT_NEWDAT))
> > +			netdev_warn(dev, "IF_MCONT_NEWDAT still set on obj: %d", obj);
> 
> No, that's wrong. That does not work with any hardware I have access
> to.
> 
> From the datasheet:
> 
> "Note: A read access to a message object can be combined with the reset
>  of the INTPND and NEWDAT control bits. The values of these two bits,
>  which will be transferred to the IFm message control register, always
>  reflect the status before resetting them."
> 
> So it is expected, that NEWDAT is set in the crtl register readout if
> the message object in the message ram had the bit set.
> 
> The point is that when the IF transfers the message from message ram
> to the interface it clears the INTPND and NEWDAT bits in the message
> ram. That avoids the extra transfers after reading the message.

The problem is that NEWDAT in the crtl register readout is most of the time set, but sometimes not.
Adding the delay above it is unset all the time :(

Regards,
Alexander
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

