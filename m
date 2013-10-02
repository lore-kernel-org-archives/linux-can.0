From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: adding can4linux to drivers/char
Date: Wed, 02 Oct 2013 09:49:12 +0200
Message-ID: <747de50e-57ad-4be5-a754-5ad5c16295cf@email.android.com>
References: <1881932.U1kQQJkqCz@heinz.site> <2109885.0l6dWmo4a5@heinz.site> <CADGMhsXTbEc5ifQEbNM=dS3OP6uwGrvGfZ3OCvWJ=aXJyzGs+A@mail.gmail.com> <6536290.C0TsQ59CM7@heinz.site> <206b49e0-6fcb-4895-8fca-19a9b38e6a18@email.android.com> <5B48DC5BA8D5D64A8F5E39AC7EF2A42008B864@ADXV3.win.desy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:28475 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801Ab3JBHtU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Oct 2013 03:49:20 -0400
In-Reply-To: <5B48DC5BA8D5D64A8F5E39AC7EF2A42008B864@ADXV3.win.desy.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "May, Stefan" <stefan.may@desy.de>, =?ISO-8859-1?Q?Heinz-J=FCrgen_Oertel?= <hj.oertel@t-online.de>, linux-can@vger.kernel.org





"May, Stefan" <stefan.may@desy.de> schrieb:
>> And add a CUSE adaption for your legacy costumers.
>
>CUSE adaption is not possible in the case of can4linux API. I tried
>that once and failed. The reason is in read() and write() call where
>can4linux chooses to use the number of frames instead of bytes for the
>count parameter.
>

This is not the standard way :-(

Btw. CUSE is open source.
Why not adding a feature to CUSE that allows to pass the number of stru=
cts instead of the number of bytes?

Regards,
Oliver

>mfg, Stefan May.
>
>
>
>-----Urspr=C3=BCngliche Nachricht-----
>Von: linux-can-owner@vger.kernel.org im Auftrag von Oliver Hartkopp
>Gesendet: Mo 30.09.2013 11:35
>An: Heinz-J=C3=BCrgen Oertel; linux-can@vger.kernel.org
>Betreff: Re: adding can4linux to drivers/char
>=20
>
>
>
>
>"Heinz-J=C3=BCrgen Oertel" <hj.oertel@t-online.de> schrieb:
>>Sebastion,
>>thanks for at least being open for my arguments.
>
>Hello Heinz,=20
>
>I was open to your arguments too.
>
>But I'm definitely against including a separate set of CAN drivers int=
o
>the Kernel. Adding a separate API is ok - but creating separate driver=
s
>for the exactly same hardware will not work!
>
>>Am Sonntag, 29. September 2013, 19:45:09 schrieb Sebastian Haas:
>>> The Socket approach has some real advantages (multi-user for single
>>> CAN controller,
>>
>>I like only comment this one.
>>Multiple applications can of course share one device in can4linux.
>>
>
>Yes but people have to learn about all that. And with the 'even easier=
'
>known and clean socket API there's a proper separation between the use=
r
>stuff and the admin interfaces like bitrate setting. There's a reason
>why developers thank the developers here, when the started with
>SocketCAN.
>
>>And Marc, because some of the drivers exist much longer than
>SocketCAN,
>>one should be respectful and don't name only one driver 'linux CAN'.=20
>
>The reason why SocketCAN was invented was because there was a complete
>mix of different CAN drivers with thousands of different crappy
>programming interfaces (mailbox ids in can frame structures) and many
>vendor lock-ins.
>
>SocketCAN has been discussed at least for two years until it made it's
>way into mainline. There was no contribution from all the CAN hardware
>manifacturers except PEAK, which supported SocketCAN in their
>out-of-tree driver (and now in mainline linux).
>
>Even the 'performance' argument is no argument to go for a different
>CAN  infrastructure in the kernel. See my thesis or the measurements
>from the University of Prague comparing the OCAN driver with SocketCAN=
=2E
>
>If you feel things are missing, please discuss and contribute them
>here. It's never too late. But starting a new chardev discussion with
>all the different chardev flavours from all the different vendors will
>not fix any problem for Linux users. They will get lost, like it was
>before SocketCAN.=20
>Add your currently unsupported hardware as netdev drivers. People will
>appreciate that. And add a CUSE adaption for your legacy costumers. An=
d
>if there's anything that's missing or has to be fixed in SocketCAN hel=
p
>us to fix it.
>
>Regards,
>Oliver
>
>ps. I'm currently on vacation and this mail was sent from my wifes
>mobile.  So I'll not be able to answer like you know it from me.

--=20
Diese Nachricht wurde von meinem Android-Mobiltelefon mit K-9 Mail gese=
ndet.
