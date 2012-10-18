From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Bitbake recipe building socketcan for angstrom
Date: Thu, 18 Oct 2012 13:17:52 +0200
Message-ID: <507FE560.8070905@pengutronix.de>
References: <loom.20121018T125449-719@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF59191880919A4BF42A94B8D"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51954 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366Ab2JRLSA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 18 Oct 2012 07:18:00 -0400
In-Reply-To: <loom.20121018T125449-719@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: rotesmofa <pascalkrauth@gmail.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF59191880919A4BF42A94B8D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/18/2012 12:55 PM, rotesmofa wrote:
> Hallo everyone,=20
>=20
> I am fighting with Bitbaking Socketcan for Angstrom with a 2.6.32 Kerne=
l for my=20
> Craneboard.=20

Regarding the kernel. It's rather old, doesnt't support much CAN
hardware and may have CAN related bugs. Better update to latest v3.6 or
newer.

> Currently I have a basic lag of understanding for the *.bb files. I sim=
ply want=20
> to build socketcan for my board using either Eclipse with my Angstrom t=
oolchain=20
> or using Bitbake.=20

If you want to use socketcan you have to switch on some kernel features:

	-> Networking support
	-> CAN bus subsystem support
		[ ] Raw CAN Protocol (raw access with CAN-ID filtering)
	-> CAN Device Drivers
		[ ] Platform CAN drivers with Netlink support

+ the driver you need.

No need to change any bitbake files.

> Can anyone guide me? I'am in India and have kind of a research project =
but there=20
> is no support and I'am a Hardware Guy ;-)=20

If you need support for the userspace tools in openembedded/angstrom you
should contact they mailinglist.

regards, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigF59191880919A4BF42A94B8D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlB/5WQACgkQjTAFq1RaXHMGvACfd223TJLhT9Q2zP6wf1S/YoHP
n+AAn0eUjC6yyDKI384Y7r3dh7AbRQ6G
=uGsC
-----END PGP SIGNATURE-----

--------------enigF59191880919A4BF42A94B8D--
