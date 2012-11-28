From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] Use strcmp instead of sizeof on char* string
Date: Wed, 28 Nov 2012 13:12:03 +0100
Message-ID: <50B5FF93.1080106@pengutronix.de>
References: <1352891586-17729-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFE8B0133E7333E6EF90D7A4E"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58206 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471Ab2K1MMJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 28 Nov 2012 07:12:09 -0500
In-Reply-To: <1352891586-17729-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFE8B0133E7333E6EF90D7A4E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/14/2012 12:13 PM, Alexander Stein wrote:
> This bug was detected by the clang warning:
> libsocketcan.c:384:16: warning: argument to 'sizeof' in 'strncmp' call
> is the same expression as the source; did you mean to provide an
> explicit length? [-Wsizeof-pointer-memaccess]
> sizeof(name)) !=3D 0)
> ~~~~~~~^~~~~~
>=20
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Tnx, applied to master.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigFE8B0133E7333E6EF90D7A4E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC1/5YACgkQjTAFq1RaXHOvawCcCDG7O/ErCgFdb8EwXbdD5nHA
REwAoI/EjszYdRUneegUv8jTkfuuga29
=6W3K
-----END PGP SIGNATURE-----

--------------enigFE8B0133E7333E6EF90D7A4E--
