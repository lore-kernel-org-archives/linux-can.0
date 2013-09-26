From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: imprecise external abort using the flexcan driver on i.MX6Q
Date: Thu, 26 Sep 2013 16:54:22 +0100
Message-ID: <20130926155422.GQ12758@n2100.arm.linux.org.uk>
References: <21060.15934.600859.167074@ipc1.ka-ro> <524455FD.7070808@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40112 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752961Ab3IZQAx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 26 Sep 2013 12:00:53 -0400
Content-Disposition: inline
In-Reply-To: <524455FD.7070808@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, linux-arm-kernel@lists.infradead.org, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Thu, Sep 26, 2013 at 05:42:53PM +0200, Marc Kleine-Budde wrote:
> On 09/26/2013 04:01 PM, =?utf-8?Q?Lothar_Wa=C3=9Fmann?= wrote:
> > Hi,
> > 
> > when enabling the can interface with 'ifconfig can0 up' (after
> > configuring the bitrate with canconfig) on an i.MX6Q board (TX6) I'm
> > getting the following kernel dump:
> > 
> > |flexcan 2094000.flexcan can0: writing ctrl=0x0a212003
> > |flexcan 2094000.flexcan can0: flexcan_set_bittiming: mcr=0x5980000f ctrl=0x0a212003
> > |flexcan 2094000.flexcan can0: flexcan_chip_start: writing mcr=0x79a2020f
> > |flexcan 2094000.flexcan can0: flexcan_chip_start: writing ctrl=0x0a21ac53
> > |Unhandled fault: imprecise external abort (0x1c06) at 0x00057adc
> 
> Looks like a NULL pointer deref to me. But it doesn't make any sense,
> because the offset is way beyond the length of the struct flexcan_regs.

NULL pointer derefs don't produce imprecise external aborts.  I believe
that the FAR is unpredictable for such aborts as well, which means the
"at xxxx" should be ignored.

Bearing in mind that it is imprecise, that means that the abort happened
sometime in the past, so the PC isn't reliable either.

The code here is:

   0:	f57ff04e 	dsb	st
   4:	e3a01000 	mov	r1, #0
   8:	e5820000 	str	r0, [r2]
   c:	f57ff04e 	dsb	st
  10:	e5820004 	str	r0, [r2, #4]

Given the dsbs there, it's probably the str r0, [r2] which provoked it,
and we can see from the register dump, r2 is not NULL.

It's probably complaining that a clock necessary for the peripherals
registers to be accessible is not running.
