From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Kvaser socketCAN support
Date: Mon, 21 Apr 2014 19:48:44 +0200
Message-ID: <535559FC.70506@hartkopp.net>
References: <f0331cq3H1VPknv.RZmta@smtp.rzone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:54883 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660AbaDURss (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 21 Apr 2014 13:48:48 -0400
In-Reply-To: <f0331cq3H1VPknv.RZmta@smtp.rzone.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Smith, Christopher - 0999 - MITLL" <chris.smith@ll.mit.edu>
Cc: "Kvaser Support (support@kvaser.com)" <support@kvaser.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Olivier Sobrie <olivier@sobrie.be>

Hello Christopher,

the Kvaser Leaf USB driver has been contributed by Olivier Sobrie (see =
CC).

See log messages of the driver in the Linux Mainline repository:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/driv=
ers/net/can/usb/kvaser_usb.c

The initial support was added at 2012-11-27 and emerged in Linux 3.8.

Regards,
Oliver

ps. feel free to ask this kind of questions on the linux-can mailing li=
st
which I added in CC. Tnx


On 17.04.2014 03:31, Smith, Christopher - 0999 - MITLL wrote:
> Hi, I was just looking to get confirmation and a few points for getti=
ng the
> initial install figured out.=20
>=20
> =20
>=20
> I have a kvaser leaf device that I'd like to use with socketCAN.  Is =
this in
> fact supported?
>=20
> =20
>=20
> I noticed the general process for setting up socketCAN documented on =
wikipedia
> <http://en.wikipedia.org/wiki/SocketCAN>.  When I issue the following=
 command:
>=20
> =20
>=20
> ip link add dev vcan0 type vcan
>=20
> =20
>=20
> What do I replace vcan0 with?  I=92ve tried can0 with no luck.  Is th=
ere a way
> to check which devices are registered?  I=92m not entirely sure that =
when I
> plugged in the USB device the proper drivers were recognized.  I may =
need some
> of the lower level drivers distributed by Kvaser.
>=20
> =20
>=20
> Thank you,
>=20
> =20
>=20
> Chris
>=20
> =20
>=20
> -----Original Message-----
> From: Kvaser Support [mailto:support@kvaser.com]
> Sent: Monday, April 14, 2014 3:24 PM
> To: Smith, Christopher - 0999 - MITLL
> Subject: Re: (Case 14217) Linux driver support
>=20
> =20
>=20
> Did the response below answer your questions?
>=20
> =20
>=20
> Or do you need more information?
>=20
> =20
>=20
> Best regards,
>=20
> =20
>=20
> Troy
>=20
> --=20
>=20
> Kvaser Support
>=20
> support@kvaser.com <mailto:support@kvaser.com>
>=20
> ---------------------------------------------------------------------=
------
>=20
> =20
>=20
> =20
>=20
> =20
>=20
> -----Original Message-----
>=20
> From: "Kvaser Support" <support@kvaser.com <mailto:support@kvaser.com=
>>
>=20
> Reply-To: "Kvaser Support" <support@kvaser.com <mailto:support@kvaser=
=2Ecom>>
>=20
> Date: Mon, 31 Mar 2014 22:29:00 +02:00
>=20
> To: "Smith, Christopher - 0999 - MITLL" <chris.smith@ll.mit.edu
> <mailto:chris.smith@ll.mit.edu>>
>=20
> Subject: Re: (Case 14217) Linux driver support
>=20
> =20
>=20
>>To our knowledge, support for the Leaf family was added to socketcan =
by
> Oliver Harkopp in 2012.
>=20
>>=20
>=20
>>I tried to perform a google search to determine which version of Linu=
x this
> has been included in without good results.
>=20
>>=20
>=20
>>I hope the socketcan community can point you to the version that incl=
udes
> this patch.
>=20
>>=20
>=20
>>Best regards,
>=20
>>=20
>=20
>>Troy
>=20
>>--
>=20
>>Kvaser Support
>=20
>>support@kvaser.com <mailto:support@kvaser.com>
>=20
>>---------------------------------------------------------------------=
------
>=20
