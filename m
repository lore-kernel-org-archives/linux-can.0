From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/1] can: Allwinner A10/A20 CAN Controller
Date: Thu, 24 Sep 2015 08:58:22 +0200
Message-ID: <56039F0E.8020908@pengutronix.de>
References: <1443074048-31307-1-git-send-email-info@gerhard-bertelsmann.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="0XBbHPE5UueIhldxP5f6s7OQLrqWpHdnN"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51879 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932616AbbIXG6d (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 Sep 2015 02:58:33 -0400
In-Reply-To: <1443074048-31307-1-git-send-email-info@gerhard-bertelsmann.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0XBbHPE5UueIhldxP5f6s7OQLrqWpHdnN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/24/2015 07:54 AM, Gerhard Bertelsmann wrote:
> This patch set (linux-next) fixes a bug in arbitration error reporting =
found by
> Dan Carpenter and the modinfo name (thx to Peter Koorsgard) of the modu=
le.
>=20
> ef9bd57 general: fix driver info
> e9d2d74 sun4i_can_err: fix arbitration lost error reporting
  ^^^^^^^

These look like git commits. Can you please send the individual patches?
Please adjust your subject to something like this: "can: sun4i: ....".
If you want to track the people who reported the issue, you can add the t=
ag:

Reported-by:
> Signed-off-by: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>

In the line(s) before your S-o-b.

regards,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--0XBbHPE5UueIhldxP5f6s7OQLrqWpHdnN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWA58OAAoJEP5prqPJtc/HZCoIAIzBfPQ0lh4OjJxy+ZOIrItD
x4bPKzuuJBGmTqCcri/hKL2Kop4k7NFa2/jUZVm+2uyqf1+G5kACfnFOUXMiHv7S
cHPHQXgZTPKK9ADJhCa1/fEhVi+lkAggIvxZTGEtZhsH4kHDS+HzM6WCV/xVudBL
x/SmLI1MpD0qSj1aJaNrnzfcsFAchzP79UsZr0bLMB4qAARv9ofNKd1xJLXNYDaO
SVklgKXyT98HPvwH8Kmih3d9f9yutt5LrWA4am29EKjvhx3epV/oKSi5xtPdkI84
1PR24yKM+t2tkrrR8b5QdBKYFstlrsNQAn4ICptcVemQYbRaYyZs+5mm6VsNfMU=
=GgSz
-----END PGP SIGNATURE-----

--0XBbHPE5UueIhldxP5f6s7OQLrqWpHdnN--
