From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: license issues of can-utils
Date: Sun, 18 Aug 2013 12:26:25 +0200
Message-ID: <5210A151.4070009@hartkopp.net>
References: <20130817190521.GK30496@pengutronix.de> <520FDC17.7070107@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:26447 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab3HRK0c (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 18 Aug 2013 06:26:32 -0400
In-Reply-To: <520FDC17.7070107@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, =?UTF-8?B?VXdlIEtsZWluZS1Lw7Zu?= =?UTF-8?B?aWc=?= <u.kleine-koenig@pengutronix.de>
Cc: linux-can@vger.kernel.org, Robert Haddon <robert.haddon@verari.com>

On 17.08.2013 22:24, Marc Kleine-Budde wrote:
> On 08/17/2013 09:05 PM, Uwe Kleine-K=C3=B6nig wrote:
>> I started to create a Debian package for can-utils and while looking
>> through the source files to collect their copyright and license
>> information, I noticed two things that probably need fixing before a
>> can-utils package can enter Debian.
>=20

Which is a good idea :-)

>=20
>> b) several headers below include/socketcan/can have a copyright but =
no
>> license. I think the best approach here (as also suggested by Marc i=
n a
>> private discussion) is to fix the original headers in the kernel and
>> then copy these back into can-utils. I assume the standard boilerpla=
te
>> with BSD-3-Clause + GPL-2 is the desired addition? If yes I can prep=
are
>> a patch.
>=20
> tl;dr IANAL: netlink.h GPL, all others DUAL BSD/GPL.

Yep.

When intentionally putting the 'missing license' in the header files we=
 just
oriented to other header files, where a more detailed license was only
provided in the C files.

Btw. when reworking the license information in the header files I would
suggest to take the version which was checked by our lawyer - which is =
e.g. in
linux/net/can/raw.c

It has parts of BSD and alternatively refers to GPLv2. And it's not too=
 long.

Does this fit the Debian requirements?

Tnx & brest regards,
Oliver


>=20
> We're talking about the uapi can headers which are:
>=20
> include/uapi/linux/can/error.h		added with initial code which is Dual=
 BSD/GPL
>=20
> Copyright by VW, Author Oliver.
>=20
>=20
> include/uapi/linux/can.h		added with initial code which is Dual BSD/G=
PL
> include/uapi/linux/can/raw.h		added with initial code which is Dual B=
SD/GPL
>=20
> Both copyright by VW, Author Oliver and Urs.
>=20
>=20
> include/uapi/linux/can/bcm.h		bcm.c has MODULE_LICENSE("Dual BSD/GPL"=
);
> include/uapi/linux/can/gw.h		gw.c has MODULE_LICENSE("Dual BSD/GPL")
>=20
> Both copyright by VW, Author Oliver.
>=20
>=20
> include/uapi/linux/can/netlink.h	was added by Wolfgang Grandegger:
>   39549ee can: CAN Network device driver and Netlink interface
> dev.c holds the netlink parsing code which has MODULE_LICENSE("GPL v2=
");
>=20
> Copyright by Wolfgang.
>=20

