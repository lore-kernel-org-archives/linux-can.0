From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: can-utils: install in /usr/bin instead of /usr/local/bin ??
Date: Thu, 23 Jan 2014 15:00:33 +0100
Message-ID: <52E12081.4010301@pengutronix.de>
References: <52E12015.7000201@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="DfTIjeGMgaTeQvXQG9QkWaviBjpCeMTtk"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43896 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754084AbaAWOAg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Jan 2014 09:00:36 -0500
In-Reply-To: <52E12015.7000201@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DfTIjeGMgaTeQvXQG9QkWaviBjpCeMTtk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/23/2014 02:58 PM, Oliver Hartkopp wrote:
> Hi Marc,
>=20
> when can-utils are now intended to be packaged for Debian:
>=20
> Does it make sense to move the installation directory to /usr/bin inste=
ad of
> the current /usr/local/bin target??

No, Uwe will probably use ./configure --prefix=3D/usr

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--DfTIjeGMgaTeQvXQG9QkWaviBjpCeMTtk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlLhIIEACgkQjTAFq1RaXHM6JwCeIXDMo8VowHnD/EKcbm+zHFo/
GVIAnRnLYOvNbbiZfTzOG4cznGtH411H
=iFZd
-----END PGP SIGNATURE-----

--DfTIjeGMgaTeQvXQG9QkWaviBjpCeMTtk--
