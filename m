From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: imprecise external abort using the flexcan driver on i.MX6Q
Date: Mon, 30 Sep 2013 13:37:09 +0200
Message-ID: <21065.25189.119250.773885@ipc1.ka-ro>
References: <21060.15934.600859.167074@ipc1.ka-ro>
	<524455FD.7070808@pengutronix.de>
	<20130926155422.GQ12758@n2100.arm.linux.org.uk>
	<CAHCPf3u7qpdiqoOhD1yxoHybgS1+mvdd8xxaTKnK-DJ9sJYY7g@mail.gmail.com>
	<21061.21191.197931.54061@ipc1.ka-ro>
	<CAHCPf3vJi5HH52XRsJ5tsaOsGk_1YsoSHHgJNPpeJLBpd5EZsA@mail.gmail.com>
	<5245E2C5.1030705@pengutronix.de>
	<21065.23354.418805.871480@ipc1.ka-ro>
	<52495E24.4080703@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:57511 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854Ab3I3LhW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 30 Sep 2013 07:37:22 -0400
In-Reply-To: <52495E24.4080703@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Matt Sealey <neko@bakuhatsu.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

Marc Kleine-Budde writes:
> On 09/30/2013 01:06 PM, Lothar Wa=C3=9Fmann wrote:
> > Hi,
> >=20
> > Marc Kleine-Budde writes:
> >> On 09/27/2013 07:24 PM, Matt Sealey wrote:
> >>> Marc - I don't think FLEXCAN has changed layout at all in these a=
reas.
> >>> The hardware always worked this way..
> >>
> >> All flexcan cores support the RX FIFO, the mx6 supports an additio=
nal
> >> mode for different acceptance filters.
> >>
> >>> The only difference here  is that the i.MX53 is doing something w=
eird
> >>> on the bus. The i.MX6Q is giving the absolutely correct BRESP for=
 the
> >>> transfer to the peripheral (in effect, a "go away, this is my dat=
a"
> >>> failure, which the CPU turns into an imprecise abort since it no =
idea
> >>> which transaction it committed aeons ago caused it).
> >>>
> >>> Writes to 0x90 to 0xDF while MCR[FEN] is set *should* cause a dat=
a
> >>> abort.. because it's not even a read-only region, it *should* be
> >>> totally inaccessible to the CPU.
> >>>
> >>> The question I have is, when MCR[FEN] is set on i.MX53, does read=
ing
> >>> from those reserved registers give anything but 0's or garbage? I=
'm
> >>> curious, that's all, it doesn't really matter ;)
> >>
> >> The driver only read from message buffer 0, and uses buffer 8 for =
tx.
> >> The others are not accessed, unless in that chip start routine. We=
 don't
> >> need this loop, it comes from the original driver. I think no one =
has
> >> ever noticed that bug, because all other CPUs have not complained.
> >>
> >> The driver without the loop is working on mx6 and Lothar is testin=
g it
> >> on mx53.
> >>
> > I can confirm, that the driver still works on i.MX53 as before the
> > patch.
> > Is someone going to prepare a patch, or should I do it, as I was th=
e
> > one who first brought up this issue?
>=20
> I have a patch ready, it's basically what I send you. Can I add your
> Tested-by?
>=20
Yes, of course.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
