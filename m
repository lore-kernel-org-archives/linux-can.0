From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH net-next] can: replace the dev_dbg/info/err/... with the
 new netdev_xxx macros
Date: Wed, 01 Feb 2012 17:11:37 +0100
Message-ID: <4F296439.6080606@pengutronix.de>
References: <4EE61D71.90401@grandegger.com> <4F2864FD.8010909@pengutronix.de> <4F290FF6.4090107@grandegger.com> <201202011051.45893.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig38B3E5249984104AB30AF16C"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34695 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000Ab2BAQLu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 11:11:50 -0500
In-Reply-To: <201202011051.45893.vapier@gentoo.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mike Frysinger <vapier@gentoo.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Anant Gole <anantgole@ti.com>, Chris Elston <celston@katalix.com>, Sebastian Haas <haas@ems-wuensche.com>, Matthias Fuchs <matthias.fuchs@esd.eu>, uclinux-dist-devel@blackfin.uclinux.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig38B3E5249984104AB30AF16C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/01/2012 04:51 PM, Mike Frysinger wrote:

>> Is there somebody else we should inform about patches for the bfin_can=

>> driver. Maybe Mike (now on CC)?
>=20
> for Blackfin devs, you can CC uclinux-dist-devel@blackfin.uclinux.org t=
o get the=20
> relevant people.  Barry Song no longer works for ADI.
>=20
> the bfin_can.c changes in here look fine to me (not that i tried compil=
ing them,=20
> but looks straight forward enough):
> http://thread.gmane.org/gmane.linux.can/251/focus=3D257
>=20
> Acked-by: Mike Frysinger <vapier@gentoo.org>

tnx

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig38B3E5249984104AB30AF16C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8pZD4ACgkQjTAFq1RaXHOuBACePwjSJwYJ5c+5OwzLm/0RrX6y
wj0An0nOHrtOmi5YNEbF0SbIi+Jda3oQ
=A6e4
-----END PGP SIGNATURE-----

--------------enig38B3E5249984104AB30AF16C--
