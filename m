From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] slcand: fix build warnings
Date: Mon, 04 Feb 2013 12:13:58 +0100
Message-ID: <510F97F6.4060408@pengutronix.de>
References: <1359969022-4620-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2QXJRARFWPRDBTXSMNDWG"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40544 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab3BDLOB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 4 Feb 2013 06:14:01 -0500
In-Reply-To: <1359969022-4620-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegorslists@googlemail.com
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2QXJRARFWPRDBTXSMNDWG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/04/2013 10:10 AM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>=20
> Remove unused variable name.
>=20
> Fix FILE pointer check (fopen() returns a pointer not an integer).
>=20
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Applied.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2QXJRARFWPRDBTXSMNDWG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlEPl/cACgkQjTAFq1RaXHMEggCeK9Jtv6S6+UfVFSHLKw7f2YVk
peoAn105YeSS0EO8yDau5k9MbVr2K/wv
=WZbi
-----END PGP SIGNATURE-----

------enig2QXJRARFWPRDBTXSMNDWG--
