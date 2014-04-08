From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Tue, 08 Apr 2014 10:36:23 +0200
Message-ID: <3071984.okmx4UfXFK@ws-stein>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <1513830.2DNAbkNIid@ws-stein> <alpine.DEB.2.02.1404081017370.14882@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:60574 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756351AbaDHIhh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Apr 2014 04:37:37 -0400
In-Reply-To: <alpine.DEB.2.02.1404081017370.14882@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Tuesday 08 April 2014 10:26:23, Thomas Gleixner wrote:
> > So I noticed that with CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING=n
> > (NEWDAT and INTPEND cleared immediately) the "odd behavior" occurs
> > pretty often.
> > Before
> >   c_can_rx_object_get(dev, obj);
> > NEWDAT is still set, but afterwards it is already cleared in
> > C_CAN_NEWDAT1_REG.
> 
> Which is expected. We clear the newdat bit in c_can_rx_object_get(),
> which updates C_CAN_NEWDAT1_REG as well.
> 
> > I guess the NEWDAT is already cleared in the message object before
> > reading from the message object with this line
> 
> > > ctrl = priv->read_reg(priv, C_CAN_IFACE(MSGCTRL_REG, IF_RX));
> > 
> > So I removed that IF_MCONT_NEWDAT check (see below) and I didn't
> > lose any message, but get 5 duplicates in 250000 messages (no
> > reordering though).
> > 
> > Setting CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING=y with that patch I
> > lose ~650msg per 250000 frames.
> 
> What happens, if you apply the patch below?
> 
> Thanks,
> 
> 	tglx
> 
> Index: linux-2.6/drivers/net/can/c_can/c_can.c
> ===================================================================
> --- linux-2.6.orig/drivers/net/can/c_can/c_can.c
> +++ linux-2.6/drivers/net/can/c_can/c_can.c
> @@ -880,7 +880,7 @@ static int c_can_do_rx_poll(struct net_d
>  
>  	while (quota > 0) {
>  		if (!pend) {
> -			pend = priv->read_reg(priv, C_CAN_INTPND1_REG);
> +			pend = priv->read_reg(priv, C_CAN_NEWDAT1_REG);
>  			if (!pend)
>  				break;
>  			/*

Your patch "can: c_can: Get rid of pointless interrupts" already did that change. Or did you mean the reverse?

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

