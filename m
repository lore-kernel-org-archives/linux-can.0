From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: flexcan: use correct clock as base for bit
 rate calculation
Date: Tue, 26 Nov 2013 09:27:06 +0100
Message-ID: <52945B5A.9070601@pengutronix.de>
References: <1385414121-21493-1-git-send-email-mkl@pengutronix.de> <1385414121-21493-2-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1WpR9E8kakD8755tCkHuT4e4PPHOaLW4m"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56272 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab3KZI1M (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 26 Nov 2013 03:27:12 -0500
In-Reply-To: <1385414121-21493-2-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de, lst@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1WpR9E8kakD8755tCkHuT4e4PPHOaLW4m
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/25/2013 10:15 PM, Marc Kleine-Budde wrote:
> The flexcan IP core uses the peripheral clock ("per") as basic clock fo=
r the
> bit timing calculation. However the driver uses the the wrong clock ("i=
pg").
> This leads to wrong bit rates if the rates on both clock are different.=

>=20
> This patch fixes the problem by using the correct clock for the bit rat=
e
> calculation.
>=20
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--1WpR9E8kakD8755tCkHuT4e4PPHOaLW4m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKUW1oACgkQjTAFq1RaXHMiTQCbBtJInG6TTwavHcHbf9Lot8Cx
LNsAnRNb4E8Dfp8E0wmcRWaRVIqRJVA3
=kdtY
-----END PGP SIGNATURE-----

--1WpR9E8kakD8755tCkHuT4e4PPHOaLW4m--
