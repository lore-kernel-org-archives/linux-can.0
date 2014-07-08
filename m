From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] Add missing header canframelen.h to noinst_HEADERS
Date: Tue, 08 Jul 2014 09:17:58 +0200
Message-ID: <53BB9B26.1040101@pengutronix.de>
References: <1404801278-28351-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6maeJWCEIDeO36QjSilnP8VH0AhcN88fH"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33552 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbaGHHTa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Jul 2014 03:19:30 -0400
In-Reply-To: <1404801278-28351-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6maeJWCEIDeO36QjSilnP8VH0AhcN88fH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/08/2014 08:34 AM, Alexander Stein wrote:
> This is necessary so this header gets included when running make dist.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Applied to master.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--6maeJWCEIDeO36QjSilnP8VH0AhcN88fH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlO7mykACgkQjTAFq1RaXHPozwCcDq6zfn6c9aQWrcHcCtbjvJM9
D1EAnA06R4GJMHNqXHySYLgaPRgRFO3t
=wOYe
-----END PGP SIGNATURE-----

--6maeJWCEIDeO36QjSilnP8VH0AhcN88fH--
