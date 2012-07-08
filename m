From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [SocketCan] Problem of accuracy
Date: Sun, 08 Jul 2012 22:13:24 +0200
Message-ID: <4FF9E9E4.4090602@grandegger.com>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com> <4FF55274.3030006@volkswagen.de> <CABMxt4h2mm+FDKBKAGW=UvgOZJVUEmkrH9yKULZaJz5P5HvyBQ@mail.gmail.com> <4FF8102C.8030609@grandegger.com> <CABMxt4g5KRHYo=+O-ytjHT34aZZWnnJ2AMZoBnxVoV5z5hBE4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:55132 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab2GHUNa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 8 Jul 2012 16:13:30 -0400
In-Reply-To: <CABMxt4g5KRHYo=+O-ytjHT34aZZWnnJ2AMZoBnxVoV5z5hBE4w@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mohamed HAMZAOUI <requinham@gmail.com>
Cc: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can Mailing List <linux-can@vger.kernel.org>

On 07/08/2012 09:43 PM, Mohamed HAMZAOUI wrote:
> Hi,
>=20
>> This problem is not CAN related. Anyway, you can read/try/check:
>>
>> - are high-resolution timers enabled in your kernel?
>=20
> My high resolution timers is enabled in Kernel and i activate
> Preemptible kernel (low latency desktop)
>=20
>> - use cyclictest [1] to measure user-space timing accuracy.
>=20
> the cyclictest mesure with 0% load is 307 in maximum

You mean 302 us? Did you generate some load? That normally makes a big
difference.

>=20
>> - use clock_nanosleep for periodic tasks.
>=20
> i use clock_nanosleep with (1000000 ns =3D 1ms) and the result mesure=
d
> with another CAN transeiver is an average of 1.30 ms (delta =3D 300 =B5=
s)
> !

That means that you see a period of 1.3ms instead of 1ms? That's really
strange. I assume that the timing on the system with the other CAN
transceiver is accurate.

>> - try to start cangen with "chrt -f 10 cangen can0".
>=20
> no effect.
>=20
>> - read "man sched_setscheduler" for a description of the Linux
>>   scheduling scheme.
>=20
> I test with two type of SCHED : RR and FIFO but the result is same
>=20
> Maybe i need to pass to Xenomai or PREEMPT-RT ?

What system, kernel and CAN controller do you use? Is it an MCP25xx?

Wolfgang.

