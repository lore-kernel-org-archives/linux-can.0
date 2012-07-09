From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [SocketCan] Problem of accuracy
Date: Mon, 9 Jul 2012 08:55:52 +0200
Message-ID: <20120709065552.GA423@vandijck-laurijssen.be>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com>
 <4FF55274.3030006@volkswagen.de>
 <CABMxt4h2mm+FDKBKAGW=UvgOZJVUEmkrH9yKULZaJz5P5HvyBQ@mail.gmail.com>
 <4FF8102C.8030609@grandegger.com>
 <CABMxt4g5KRHYo=+O-ytjHT34aZZWnnJ2AMZoBnxVoV5z5hBE4w@mail.gmail.com>
 <4FF9E9E4.4090602@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:29894 "EHLO mail.eia.be"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752155Ab2GIHCb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jul 2012 03:02:31 -0400
Content-Disposition: inline
In-Reply-To: <4FF9E9E4.4090602@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Mohamed HAMZAOUI <requinham@gmail.com>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can Mailing List <linux-can@vger.kernel.org>

> >=20
> >> - use clock_nanosleep for periodic tasks.
> >=20
> > i use clock_nanosleep with (1000000 ns =3D 1ms) and the result mesu=
red
> > with another CAN transeiver is an average of 1.30 ms (delta =3D 300=
 =C2=B5s)
> > !
>=20
> That means that you see a period of 1.3ms instead of 1ms? That's real=
ly
> strange. I assume that the timing on the system with the other CAN
> transceiver is accurate.

IMHO, the precise receiver side accuracy is less important.
=46or the sender, if each 1ms period becomes 1.3ms, the effective perio=
d
becomes 1.3ms.
On the receiver side, even if receive interrupts may introduce up to .3=
ms delays,
the effective (average) period does not change.

So on the receiver side, with a bit of averaging, you can easily
tell the effective period.

--=20
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
