From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: (Case 14359) Kvaser socketCAN support
Date: Thu, 24 Apr 2014 11:19:45 +0200
Message-ID: <5358D731.9000908@pengutronix.de>
References: <CAGm1_ks40c8SGE+BuokShMmOXkGk0PO4MF67N+jhYh+DBWnp6w@mail.gmail.com> <5357e7f5.c72de00a.4ba2.40ff@mx.google.com> <CAGm1_kuo9J1_0nPew_urkF-jh6Y0J0oFaW9QVZe4k4T0KqcVkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nU4N0s7wBwXR1pLpmfS5Re9g1XhhKj7FX"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35864 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbaDXJUT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 Apr 2014 05:20:19 -0400
In-Reply-To: <CAGm1_kuo9J1_0nPew_urkF-jh6Y0J0oFaW9QVZe4k4T0KqcVkg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>, Kvaser Support <support@kvaser.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Olivier Sobrie <olivier@sobrie.be>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nU4N0s7wBwXR1pLpmfS5Re9g1XhhKj7FX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2014 09:46 AM, Yegor Yefremov wrote:
> What about making a table with following columns:
>=20
> 1. driver module name
> 2. supported devices
> 3. kernel version, where all these devices are supported
>=20
> *alternative variant*
>=20
> 1. device name
> 2. related driver module name
> 3. kernel version

^^^ I think this is the most useful variant.

> *another alternative*
>=20
> the central wiki page shows all modules as a list, each element of the
> list opens a new page with following table:
>=20
> 1. device name (perhaps with a product link)
> 2. kernel version
>=20
> Marc, Oliver what do you think?
>=20
> Yegor

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--nU4N0s7wBwXR1pLpmfS5Re9g1XhhKj7FX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNY1zEACgkQjTAFq1RaXHN8eACfd1G1iRzgjUHyDQx1G2PBdQSg
nacAn3VYFKeJgPKKGUXUrJ9xdiTuC6TS
=pIPT
-----END PGP SIGNATURE-----

--nU4N0s7wBwXR1pLpmfS5Re9g1XhhKj7FX--
