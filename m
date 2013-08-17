From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: license issues of can-utils
Date: Sat, 17 Aug 2013 22:24:55 +0200
Message-ID: <520FDC17.7070107@pengutronix.de>
References: <20130817190521.GK30496@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="npw7UjiIlcL3kKAU70feUMi3mp86XSFu2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55430 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553Ab3HQUZH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 17 Aug 2013 16:25:07 -0400
In-Reply-To: <20130817190521.GK30496@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: linux-can@vger.kernel.org, Robert Haddon <robert.haddon@verari.com>, Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--npw7UjiIlcL3kKAU70feUMi3mp86XSFu2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/17/2013 09:05 PM, Uwe Kleine-K=C3=B6nig wrote:
> I started to create a Debian package for can-utils and while looking
> through the source files to collect their copyright and license
> information, I noticed two things that probably need fixing before a
> can-utils package can enter Debian.

[...]

> b) several headers below include/socketcan/can have a copyright but no
> license. I think the best approach here (as also suggested by Marc in a=

> private discussion) is to fix the original headers in the kernel and
> then copy these back into can-utils. I assume the standard boilerplate
> with BSD-3-Clause + GPL-2 is the desired addition? If yes I can prepare=

> a patch.

tl;dr IANAL: netlink.h GPL, all others DUAL BSD/GPL.

Marc

We're talking about the uapi can headers which are:

include/uapi/linux/can/error.h		added with initial code which is Dual BSD=
/GPL

Copyright by VW, Author Oliver.


include/uapi/linux/can.h		added with initial code which is Dual BSD/GPL
include/uapi/linux/can/raw.h		added with initial code which is Dual BSD/G=
PL

Both copyright by VW, Author Oliver and Urs.


include/uapi/linux/can/bcm.h		bcm.c has MODULE_LICENSE("Dual BSD/GPL");
include/uapi/linux/can/gw.h		gw.c has MODULE_LICENSE("Dual BSD/GPL")

Both copyright by VW, Author Oliver.


include/uapi/linux/can/netlink.h	was added by Wolfgang Grandegger:
  39549ee can: CAN Network device driver and Netlink interface
dev.c holds the netlink parsing code which has MODULE_LICENSE("GPL v2");

Copyright by Wolfgang.

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--npw7UjiIlcL3kKAU70feUMi3mp86XSFu2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlIP3BcACgkQjTAFq1RaXHPu5QCglUrTbxwUzcGg8QdWNjmmiPSZ
4QEAn0hfjAr3fRCqZxjROXIVCHHBrZBP
=WleY
-----END PGP SIGNATURE-----

--npw7UjiIlcL3kKAU70feUMi3mp86XSFu2--
