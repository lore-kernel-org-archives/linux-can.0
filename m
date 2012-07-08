From: Mohamed HAMZAOUI <requinham@gmail.com>
Subject: Re: [SocketCan] Problem of accuracy
Date: Sun, 8 Jul 2012 21:43:03 +0200
Message-ID: <CABMxt4g5KRHYo=+O-ytjHT34aZZWnnJ2AMZoBnxVoV5z5hBE4w@mail.gmail.com>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com>
	<4FF55274.3030006@volkswagen.de>
	<CABMxt4h2mm+FDKBKAGW=UvgOZJVUEmkrH9yKULZaJz5P5HvyBQ@mail.gmail.com>
	<4FF8102C.8030609@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53044 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab2GHTnE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 8 Jul 2012 15:43:04 -0400
Received: by obbuo13 with SMTP id uo13so19301232obb.19
        for <linux-can@vger.kernel.org>; Sun, 08 Jul 2012 12:43:04 -0700 (PDT)
In-Reply-To: <4FF8102C.8030609@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can Mailing List <linux-can@vger.kernel.org>

Hi,

> This problem is not CAN related. Anyway, you can read/try/check:
>
> - are high-resolution timers enabled in your kernel?

My high resolution timers is enabled in Kernel and i activate
Preemptible kernel (low latency desktop)

> - use cyclictest [1] to measure user-space timing accuracy.

the cyclictest mesure with 0% load is 307 in maximum

> - use clock_nanosleep for periodic tasks.

i use clock_nanosleep with (1000000 ns =3D 1ms) and the result mesured
with another CAN transeiver is an average of 1.30 ms (delta =3D 300 =B5=
s)
!

> - try to start cangen with "chrt -f 10 cangen can0".

no effect.

> - read "man sched_setscheduler" for a description of the Linux
>   scheduling scheme.

I test with two type of SCHED : RR and FIFO but the result is same

Maybe i need to pass to Xenomai or PREEMPT-RT ?

Your advise are welcome

Regards,
Mohamed
