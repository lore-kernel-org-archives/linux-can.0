From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Mon, 07 Apr 2014 18:06:55 +0200
Message-ID: <1963054.jznjb2yEgj@ws-stein>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <10077840.fz9L5lnEL0@ws-stein> <alpine.DEB.2.02.1404071743270.14882@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:53940 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751946AbaDGQIH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Apr 2014 12:08:07 -0400
In-Reply-To: <alpine.DEB.2.02.1404071743270.14882@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Monday 07 April 2014 17:53:59, Thomas Gleixner wrote:
> On Mon, 7 Apr 2014, Alexander Stein wrote:
> > On Monday 07 April 2014 17:24:26, Thomas Gleixner wrote:
> > > It'd be odd, because we get the buffers with the NEWDAT pending bits
> > > from the NEWDATA1 register.
> >
>  
> > Using the following patch the warning raises about every 5ms. With
> > and without your last patchset.
> 
> > but reverting c0a9f4d39 this does _NOT_ arise.
> 
> So the NEWDAT register is telling us that the newdat bit of that
> buffer is set. But when we retrieve the message, it's not set.
> 
> What's even more confusing: On my D_CAN hardware the NEWDAT is not set
> event happens when I revert c0a9f4d39
> 
> So it would be interesting to see, whether this event is aligned to
> the lost packets you are hunting:
> 
>     P1 -> P2 -> WARN -> P4
> 
> A few trace printks should tell us pretty fast.

I slightly modified my patch (see below) to see which obj is marked with NEWDAT wrongly.
It turns out it is spread over many message objects, but object 1 is notably the one most occuring.
Can it happen, that NEWDAT1 already shows the bit while the NEWDAT bit is not updated yet?
Or does commit c0a9f4d39 affect this status because INTPEND is cleared before reading the message object now?

Regards,
Alexander

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 0e9f974..f65124a 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -836,8 +836,10 @@ static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
 		 * odd HW behaviour. Do not remove that unless you
 		 * want to brick your machine.
 		 */
-		if (!(ctrl & IF_MCONT_NEWDAT))
+		if (!(ctrl & IF_MCONT_NEWDAT)) {
+			netdev_warn(dev, "Odd behavior on obj: %d", obj);
 			continue;
+		}
 
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

