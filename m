From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 4/4] can: mcp251x: Remove unnecessary power disabling
Date: Wed, 02 Apr 2014 09:08:55 +0200
Message-ID: <533BB787.4030808@pengutronix.de>
References: <1396386139-20238-1-git-send-email-mkl@pengutronix.de> <1396386139-20238-5-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="jSW2xHL2tFpiq5PpPiJ0WAQQbn6RAswsV"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43200 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757453AbaDBHI6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Apr 2014 03:08:58 -0400
In-Reply-To: <1396386139-20238-5-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Alexander Shiyan <shc_work@mail.ru>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jSW2xHL2tFpiq5PpPiJ0WAQQbn6RAswsV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/01/2014 11:02 PM, Marc Kleine-Budde wrote:
> From: Alexander Shiyan <shc_work@mail.ru>
>=20
> This patch remove unnecessary power disabling on error and on module
> exit since this is already done by regulator API.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hello,
>=20
> I'm not sure if this actually works.

Dropped as discussed.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--jSW2xHL2tFpiq5PpPiJ0WAQQbn6RAswsV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlM7t4cACgkQjTAFq1RaXHPfswCfT1AU3UGbUIzlSoicj7Ju+y1m
Cs8An17r6no2e33yI4LK2aIzsA/p1Vef
=TyrH
-----END PGP SIGNATURE-----

--jSW2xHL2tFpiq5PpPiJ0WAQQbn6RAswsV--
