From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [SocketCan] Problem of accuracy
Date: Mon, 09 Jul 2012 14:15:44 +0200
Message-ID: <4FFACB70.7020202@grandegger.com>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com> <4FF55274.3030006@volkswagen.de> <CABMxt4h2mm+FDKBKAGW=UvgOZJVUEmkrH9yKULZaJz5P5HvyBQ@mail.gmail.com> <4FF8102C.8030609@grandegger.com> <CABMxt4g5KRHYo=+O-ytjHT34aZZWnnJ2AMZoBnxVoV5z5hBE4w@mail.gmail.com> <4FF9E9E4.4090602@grandegger.com> <CABMxt4jXZMcnRRSrrV8tXnAQFUndFLdysw2r4R2PrzqE=jUMkA@mail.gmail.com> <4FFA85B3.5080800@grandegger.com> <CABMxt4jXUqtEyyhbnm80CW2CVQ7CD2He3ectdivn+aTodu+Y5w@mail.gmail.com> <4FFA9466.3040600@grandegger.com> <CABMxt4jkBNzjWtpRn5YJHyEOGu-XN7ehTZOXCt3pxLr81aH_Bg@mail.gmail.com> <4FFAA2D7.4010905@grandegger.com> <CABMxt4jnztXqAmLFcBnqp3001QXds1nX3xA2y_ka=xCNr0cjjA@mail.gmail.com> <4FFAB09F.6090800@grandegger.com> <CABMxt4jLRKz8xKNbH3Qa=P0k1aEjMsqmo2vArGDo2O1Wf0=wGQ@mail.gmail.com>
  <4FFAC346.7060201@grandegger.com> <CABMxt4iYNuvN14_OtTQHdcMWNs0+KaAE0PqTBCQkT6tFN=NGsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:44547 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280Ab2GIMPr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jul 2012 08:15:47 -0400
In-Reply-To: <CABMxt4iYNuvN14_OtTQHdcMWNs0+KaAE0PqTBCQkT6tFN=NGsQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mohamed HAMZAOUI <requinham@gmail.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

On 07/09/2012 01:57 PM, Mohamed HAMZAOUI wrote:
> If i have understood you correctly, I think it must change the period
> if the write function is a synchronous call !
> if my function is like this :
>=20
> while(1)
> {
>     nannosleep(1000000);
>     write (myFrame in opened CAN socket);
> }
>=20
> then the result is 1ms + timeOf (write) for every iteration.

Yep.

> but if the write call is asynchronous we return to case you mentioned=
 !

The write call is asynchronous and I'm surprised that it takes 300us to
return. Could you show us your test program?

> Is this correct ?

Anyway, in a previous mail you wrote:

> i use clock_nanosleep with (1000000 ns =3D 1ms) and the result mesure=
d
> with another CAN transeiver is an average of 1.30 ms (delta =3D 300 =C2=
=B5s)
> !

You cannot expect precises timing with nanosloeep(). Have a look to
cyclictest.c to understand how to implement a periodic task.

Wolfgang.
