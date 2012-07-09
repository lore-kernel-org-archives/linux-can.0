From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [SocketCan] Problem of accuracy
Date: Mon, 09 Jul 2012 13:40:54 +0200
Message-ID: <4FFAC346.7060201@grandegger.com>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com> <4FF55274.3030006@volkswagen.de> <CABMxt4h2mm+FDKBKAGW=UvgOZJVUEmkrH9yKULZaJz5P5HvyBQ@mail.gmail.com> <4FF8102C.8030609@grandegger.com> <CABMxt4g5KRHYo=+O-ytjHT34aZZWnnJ2AMZoBnxVoV5z5hBE4w@mail.gmail.com> <4FF9E9E4.4090602@grandegger.com> <CABMxt4jXZMcnRRSrrV8tXnAQFUndFLdysw2r4R2PrzqE=jUMkA@mail.gmail.com> <4FFA85B3.5080800@grandegger.com> <CABMxt4jXUqtEyyhbnm80CW2CVQ7CD2He3ectdivn+aTodu+Y5w@mail.gmail.com> <4FFA9466.3040600@grandegger.com> <CABMxt4jkBNzjWtpRn5YJHyEOGu-XN7ehTZOXCt3pxLr81aH_Bg@mail.gmail.com> <4FFAA2D7.4010905@grandegger.com> <CABMxt4jnztXqAmLFcBnqp3001QXds1nX3xA2y_ka=xCNr0cjjA@mail.gmail.com> <4FFAB09F.6090800@grandegger.com> <CABMxt4jLRKz8xKNbH3Qa=P0k1aEjMsqmo2vArGDo2O1Wf0=wGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:43703 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991Ab2GILk4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jul 2012 07:40:56 -0400
In-Reply-To: <CABMxt4jLRKz8xKNbH3Qa=P0k1aEjMsqmo2vArGDo2O1Wf0=wGQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mohamed HAMZAOUI <requinham@gmail.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

Please do not drop the CC to the Linux-CAN mailing list...

On 07/09/2012 01:25 PM, Mohamed HAMZAOUI wrote:
> I think that is caused by Socketcan. Maybe, the nannosecond sleep is
> correct but when the system call write on a CAN socket it takes 0.3 m=
s
> to inject the data on the bus
>=20
> |_______________________________|_____________|
> nannosleep        1000=B5s                  call        300=B5s    re=
al sending time
>=20
> It's this possible and if this is true can i assume a fix 0.3 ms in
> all my period ?

Even if it takes 0.3ms to get the message out to the bus, it should not
change the period if you program clock_nanosleep() properly (waiting on
the next 1ms period).

Wolfgang.
