From: "Kvaser Support" <support@kvaser.com>
Subject: Re: (Case 14359) Kvaser socketCAN support
Date: Tue, 22 Apr 2014 02:40:58 +0200
Message-ID: <5355ba9a.705c8c0a.a2a6.28aa@mx.google.com>
References: <535559FC.70506@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:36808 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561AbaDVAqg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 21 Apr 2014 20:46:36 -0400
Received: by mail-qg0-f52.google.com with SMTP id q107so4632379qgd.25
        for <linux-can@vger.kernel.org>; Mon, 21 Apr 2014 17:46:36 -0700 (PDT)
In-Reply-To: <535559FC.70506@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Olivier Sobrie <olivier@sobrie.be>

Thanks for the information Oliver.

Is there a good location for us to point to that would list the current=
 hardware supported by Socketcan and the version of Linux needed for th=
at support?  A site that is kept up to date?

I am looking for something that we could put in a FAQ on our website th=
at point people using socketcan in the correct direction.

Best regards,

Troy
--=20
Kvaser Support
support@kvaser.com
-----------------------------------------------------------------------=
----



-----Original Message-----
=46rom: "Oliver Hartkopp" <socketcan@hartkopp.net>
Reply-To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Date: Mon, 21 Apr 2014 19:48:44 +0200
To: "Smith, Christopher - 0999 - MITLL" <chris.smith@ll.mit.edu>
Cc: "Kvaser Support (support@kvaser.com)" <support@kvaser.com>, "linux-=
can@vger.kernel.org" <linux-can@vger.kernel.org>, "Olivier Sobrie" <oli=
vier@sobrie.be>
Subject: Re: Kvaser socketCAN support

>Hello Christopher,
>
>the Kvaser Leaf USB driver has been contributed by Olivier Sobrie (see=
 CC).
>
>See log messages of the driver in the Linux Mainline repository:
>http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/dri=
vers/net/can/usb/kvaser_usb.c
>
>The initial support was added at 2012-11-27 and emerged in Linux 3.8.
>
>Regards,
>Oliver
>
>ps. feel free to ask this kind of questions on the linux-can mailing l=
ist
>which I added in CC. Tnx
>
>On 17.04.2014 03:31, Smith, Christopher - 0999 - MITLL wrote:
>> Hi, I was just looking to get confirmation and a few points for gett=
ing the
>> initial install figured out.=20
>>=20
>> =20
>>=20
>> I have a kvaser leaf device that I'd like to use with socketCAN.  Is=
 this in
>> fact supported?
>>=20
>> =20
>>=20
>> I noticed the general process for setting up socketCAN documented on=
 wikipedia
>> <http://en.wikipedia.org/wiki/SocketCAN>.  When I issue the followin=
g command:
>>=20
>> =20
>>=20
>> ip link add dev vcan0 type vcan
>>=20
>> =20
>>=20
>> What do I replace vcan0 with?  I=92ve tried can0 with no luck.  Is t=
here a way
>> to check which devices are registered?  I=92m not entirely sure that=
 when I
>> plugged in the USB device the proper drivers were recognized.  I may=
 need some
>> of the lower level drivers distributed by Kvaser.
>>=20
>> =20
>>=20
>> Thank you,
>>=20
>> =20
>>=20
>> Chris
>>=20
>> =20
>>=20
>>
