From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: cansend uses wrong ID and gives wrong Payload, candump works
 fine
Date: Tue, 06 Nov 2012 13:27:17 +0100
Message-ID: <50990225.3010009@pengutronix.de>
References: <loom.20121106T132252-54@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCDAD24B116CF4D65527E160B"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59341 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab2KFM1V (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 6 Nov 2012 07:27:21 -0500
In-Reply-To: <loom.20121106T132252-54@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pascal <Pascalkrauth@gmail.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCDAD24B116CF4D65527E160B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/06/2012 01:23 PM, Pascal wrote:
> Hello,=20
>=20
> I test the canutils. I can use candump and read CAN Messages correctly =
which I=20
> send throug a PEAK CAN from another machine.=20
> If I try to send a message back using: "cansend can0 500#1E.10.10" whic=
h from my=20
> understanding should give my a Message on ID 500 with Paylod 1E 10 and =
10 I=20
> receive on ID 1 with DLC 1 Payload F4.=20
>=20
> Is this a common issue?=20
> I use a craneboard with Angstrom.=20

Are you using the same "cansend" programm on both sides?

What's the output of "cansend --help"?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigCDAD24B116CF4D65527E160B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCZAiUACgkQjTAFq1RaXHMrLgCfaL8zLgjBwB48Eo7vHFkm6P2l
BusAoJU16lIZQnEi28PEFTJcRrN3XVaT
=2mpi
-----END PGP SIGNATURE-----

--------------enigCDAD24B116CF4D65527E160B--
