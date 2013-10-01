From: "May, Stefan" <stefan.may@desy.de>
Subject: AW: adding can4linux to drivers/char
Date: Tue, 1 Oct 2013 22:20:55 +0200
Message-ID: <5B48DC5BA8D5D64A8F5E39AC7EF2A42008B864@ADXV3.win.desy.de>
References: <1881932.U1kQQJkqCz@heinz.site> <2109885.0l6dWmo4a5@heinz.site> <CADGMhsXTbEc5ifQEbNM=dS3OP6uwGrvGfZ3OCvWJ=aXJyzGs+A@mail.gmail.com> <6536290.C0TsQ59CM7@heinz.site> <206b49e0-6fcb-4895-8fca-19a9b38e6a18@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp-o-3.desy.de ([131.169.56.156]:37114 "EHLO smtp-o-3.desy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371Ab3JAU2O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Oct 2013 16:28:14 -0400
Received: from smtp-map-3.desy.de (smtp-map-3.desy.de [131.169.56.68])
	by smtp-o-3.desy.de (DESY-O-3) with ESMTP id 48C1F280976
	for <linux-can@vger.kernel.org>; Tue,  1 Oct 2013 22:20:59 +0200 (CEST)
Received: from ZITSWEEP3.win.desy.de (zitsweep3.win.desy.de [131.169.97.97])
	by smtp-map-3.desy.de (DESY_MAP_3) with ESMTP id 3A4F810AF
	for <linux-can@vger.kernel.org>; Tue,  1 Oct 2013 22:20:57 +0200 (MEST)
Content-class: urn:content-classes:message
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, =?iso-8859-1?Q?Heinz-J=FCrgen_Oertel?= <hj.oertel@t-online.de>, linux-can@vger.kernel.org

> And add a CUSE adaption for your legacy costumers.

CUSE adaption is not possible in the case of can4linux API. I tried tha=
t once and failed. The reason is in read() and write() call where can4l=
inux chooses to use the number of frames instead of bytes for the count=
 parameter.

mfg, Stefan May.



-----Urspr=FCngliche Nachricht-----
Von: linux-can-owner@vger.kernel.org im Auftrag von Oliver Hartkopp
Gesendet: Mo 30.09.2013 11:35
An: Heinz-J=FCrgen Oertel; linux-can@vger.kernel.org
Betreff: Re: adding can4linux to drivers/char
=20




"Heinz-J=FCrgen Oertel" <hj.oertel@t-online.de> schrieb:
>Sebastion,
>thanks for at least being open for my arguments.

Hello Heinz,=20

I was open to your arguments too.

But I'm definitely against including a separate set of CAN drivers into=
 the Kernel. Adding a separate API is ok - but creating separate driver=
s for the exactly same hardware will not work!

>Am Sonntag, 29. September 2013, 19:45:09 schrieb Sebastian Haas:
>> The Socket approach has some real advantages (multi-user for single
>> CAN controller,
>
>I like only comment this one.
>Multiple applications can of course share one device in can4linux.
>

Yes but people have to learn about all that. And with the 'even easier'=
 known and clean socket API there's a proper separation between the use=
r stuff and the admin interfaces like bitrate setting. There's a reason=
 why developers thank the developers here, when the started with Socket=
CAN.

>And Marc, because some of the drivers exist much longer than SocketCAN=
,
>one should be respectful and don't name only one driver 'linux CAN'.=20

The reason why SocketCAN was invented was because there was a complete =
mix of different CAN drivers with thousands of different crappy program=
ming interfaces (mailbox ids in can frame structures) and many vendor l=
ock-ins.

SocketCAN has been discussed at least for two years until it made it's =
way into mainline. There was no contribution from all the CAN hardware =
manifacturers except PEAK, which supported SocketCAN in their out-of-tr=
ee driver (and now in mainline linux).

Even the 'performance' argument is no argument to go for a different CA=
N  infrastructure in the kernel. See my thesis or the measurements from=
 the University of Prague comparing the OCAN driver with SocketCAN.

If you feel things are missing, please discuss and contribute them here=
=2E It's never too late. But starting a new chardev discussion with all=
 the different chardev flavours from all the different vendors will not=
 fix any problem for Linux users. They will get lost, like it was befor=
e SocketCAN.=20
Add your currently unsupported hardware as netdev drivers. People will =
appreciate that. And add a CUSE adaption for your legacy costumers. And=
 if there's anything that's missing or has to be fixed in SocketCAN hel=
p us to fix it.

Regards,
Oliver

ps. I'm currently on vacation and this mail was sent from my wifes mobi=
le.  So I'll not be able to answer like you know it from me.


--=20
Diese Nachricht wurde von meinem Android-Mobiltelefon mit K-9 Mail gese=
ndet.
--
To unsubscribe from this list: send the line "unsubscribe linux-can" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

