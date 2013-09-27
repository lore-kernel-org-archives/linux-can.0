From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: imprecise external abort using the flexcan driver on i.MX6Q
Date: Fri, 27 Sep 2013 11:23:13 +0200
Message-ID: <21061.20097.221946.197751@ipc1.ka-ro>
References: <21060.15934.600859.167074@ipc1.ka-ro>
	<524455FD.7070808@pengutronix.de>
	<20130926155422.GQ12758@n2100.arm.linux.org.uk>
	<52445FBE.4060503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:61537 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206Ab3I0JZA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Sep 2013 05:25:00 -0400
In-Reply-To: <52445FBE.4060503@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

Hi,

Santosh Shilimkar writes:
> On Thursday 26 September 2013 11:54 AM, Russell King - ARM Linux wrot=
e:
> > On Thu, Sep 26, 2013 at 05:42:53PM +0200, Marc Kleine-Budde wrote:
> >> On 09/26/2013 04:01 PM, Lothar Wa=C3=9Fmann wrote:
> >>> Hi,
> >>>
> >>> when enabling the can interface with 'ifconfig can0 up' (after
> >>> configuring the bitrate with canconfig) on an i.MX6Q board (TX6) =
I'm
> >>> getting the following kernel dump:
> >>>
> >>> |flexcan 2094000.flexcan can0: writing ctrl=3D0x0a212003
> >>> |flexcan 2094000.flexcan can0: flexcan_set_bittiming: mcr=3D0x598=
0000f ctrl=3D0x0a212003
> >>> |flexcan 2094000.flexcan can0: flexcan_chip_start: writing mcr=3D=
0x79a2020f
> >>> |flexcan 2094000.flexcan can0: flexcan_chip_start: writing ctrl=3D=
0x0a21ac53
> >>> |Unhandled fault: imprecise external abort (0x1c06) at 0x00057adc
> >>
> >> Looks like a NULL pointer deref to me. But it doesn't make any sen=
se,
> >> because the offset is way beyond the length of the struct flexcan_=
regs.
> >=20
> > NULL pointer derefs don't produce imprecise external aborts.  I bel=
ieve
> > that the FAR is unpredictable for such aborts as well, which means =
the
> > "at xxxx" should be ignored.
> >=20
> yep .. FAR is never reliable for imprecise external aborts.
>=20
> > Bearing in mind that it is imprecise, that means that the abort hap=
pened
> > sometime in the past, so the PC isn't reliable either.
> >=20
> > The code here is:
> >=20
> >    0:	f57ff04e 	dsb	st
> >    4:	e3a01000 	mov	r1, #0
> >    8:	e5820000 	str	r0, [r2]
> >    c:	f57ff04e 	dsb	st
> >   10:	e5820004 	str	r0, [r2, #4]
> >=20
> > Given the dsbs there, it's probably the str r0, [r2] which provoked=
 it,
> > and we can see from the register dump, r2 is not NULL.
> >=20
> > It's probably complaining that a clock necessary for the peripheral=
s
> > registers to be accessible is not running.
> >=20
> Not sure if it helps but almost 90% of the imprecise external aborts
> cases I have seen on OMAP attributed to clock not being available
> at the IP register accesses race conditions either at SW or
> hardware(clock settling time). And rest of the 10 % majority falling
> into interconnect synchronization issues.
>=20
I already checked this by enabling all clocks with devmem.
If a clock would be missing I would expect all register wriites to
fail not the register write to the _second_ mailbox (after the first
mailbox has been successfully initialized).


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
