From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mcp251x: avoid repeated frame bug
Date: Wed, 05 Sep 2012 21:59:05 +0200
Message-ID: <5047AF09.50800@pengutronix.de>
References: <1346674649-10181-1-git-send-email-mkl@pengutronix.de> <5044E54F.7020507@pouic.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig23B920B1D39824530212388C"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56724 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab2IET7K (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Sep 2012 15:59:10 -0400
In-Reply-To: <5044E54F.7020507@pouic.eu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Beno=EEt?= <benoit@pouic.eu>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig23B920B1D39824530212388C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/03/2012 07:13 PM, Beno=EEt wrote:
[...]
> I just carefully ran some before/after tests with your updated patch an=
d
> I confirm the problem is still fixed with it.
>=20
> As for my "Signed-off-by", here it goes:
>=20
> Signed-off-by: Beno=EEt Locher <Benoit.Locher@skf.com>

Congrats, the patch will be part of v3.6. :)

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig23B920B1D39824530212388C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBHrwkACgkQjTAFq1RaXHMNkACfVBGYAMfo8sTTwmFhWd5LKMez
urkAoJd57/xaHrxpfdpUFyL+MbkyR5gl
=yYOx
-----END PGP SIGNATURE-----

--------------enig23B920B1D39824530212388C--
