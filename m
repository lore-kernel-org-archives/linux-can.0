From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: imprecise external abort using the flexcan driver on i.MX6Q
Date: Fri, 27 Sep 2013 11:41:27 +0200
Message-ID: <21061.21191.197931.54061@ipc1.ka-ro>
References: <21060.15934.600859.167074@ipc1.ka-ro>
	<524455FD.7070808@pengutronix.de>
	<20130926155422.GQ12758@n2100.arm.linux.org.uk>
	<CAHCPf3u7qpdiqoOhD1yxoHybgS1+mvdd8xxaTKnK-DJ9sJYY7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:62412 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699Ab3I0Jli (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Sep 2013 05:41:38 -0400
In-Reply-To: <CAHCPf3u7qpdiqoOhD1yxoHybgS1+mvdd8xxaTKnK-DJ9sJYY7g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Matt Sealey <neko@bakuhatsu.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

Matt Sealey writes:
> Hi Russel,
>=20
> On Thu, Sep 26, 2013 at 10:54 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >
> > The code here is:
> >
> >    0:   f57ff04e        dsb     st
> >    4:   e3a01000        mov     r1, #0
> >    8:   e5820000        str     r0, [r2]
> >    c:   f57ff04e        dsb     st
> >   10:   e5820004        str     r0, [r2, #4]
> >
> > Given the dsbs there, it's probably the str r0, [r2] which provoked=
 it,
> > and we can see from the register dump, r2 is not NULL.
>=20
> For reference, that was:
>=20
> |r7 : 04000000  r6 : c0a18088  r5 : be168000  r4 : c0a18000
> |r3 : 00000001  r2 : c0a18090  r1 : 00000000  r0 : 00000000
>=20
> If r2 is indeed the address of the access, then this is entirely down
> to a misuse of the hardware; from the manual:
>=20
> ~
> When the FEN bit is set in the MCR, the memory area from 0x80 to 0xFF=
 (which is
> normally occupied by MB0 to MB7) is used by the reception FIFO engine=
=2E
> Table 34-6
> shows the Rx FIFO data structure. The region 0x80-0x8F contains an
> message buffer
>
What manual are you referring to? In my "i.MX 6Dual/6Quad Applications
Processor Reference Manual, Rev. 1, 04/2013" flexcan is chapter 26 and
Table 34-6 is: Single-Ended Source Termination Resistance Settings
of the HDMI interface.

> structure which is the port through which the ARM core reads data fro=
m
> the FIFO (the
> oldest frame received and not read yet). The region 0x90-0xDF is
> reserved for internal
> use of the FIFO engine.
> ^^^^^^^^^^^^^^^^^^^^
> ~
>=20
> In this case, yes, we're trying to write to 0x90. And in
> flexcan_chip_start, above the location where it dumps the array to
> hardware, FEN is set; this is reflected by the debug (mcr=3D0x79a2020=
f).
>=20
> I'm surprised this ever worked.. if the area 0x90-0xDF is being used
> by the FIFO internally then the difference between i.MX53 ('working')
> and i.MX6Q ('imprecise abort') is that the i.MX6Q is causing the
> proper bus response. We can only hope that the i.MX53 is ONLY not
> causing the proper bus response and not actually letting you write
> into a FIFO internal data area..
>=20
This seems a plausible explanation.

The definition:
|struct flexcan_mb {
|	u32 can_ctrl;
|	u32 can_id;
|	u32 data[2];
|};
|
|/* Structure of the hardware registers */
|struct flexcan_regs {
|	u32 mcr;		/* 0x00 */
[...]
|	struct flexcan_mb cantxfg[64];
|	                          ^^
has obviously nothing to do with reality!


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
