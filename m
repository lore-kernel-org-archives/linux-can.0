From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/2] can: sja1000_platform: fix wrong flag IRQF_SHARED
 for interrupt sharing
Date: Fri, 10 Aug 2012 10:57:07 +0200
Message-ID: <5024CCE3.5030201@pengutronix.de>
References: <1344588862-26470-1-git-send-email-mkl@pengutronix.de> <1344588862-26470-3-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB6E3A5104640E7D8337A7696"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39025 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755474Ab2HJI5M (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Aug 2012 04:57:12 -0400
In-Reply-To: <1344588862-26470-3-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Schmitt, Sven (EVM/8)" <Sven.Schmitt@volkswagen.de>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB6E3A5104640E7D8337A7696
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Sven,

On 08/10/2012 10:54 AM, Marc Kleine-Budde wrote:
> From: "Schmitt, Sven (EVM/8)" <Sven.Schmitt@volkswagen.de>
>=20
> The sja1000 platform driver wrongly assumes that a shared IRQ is indica=
ted
> with the IRQF_SHARED flag in irq resource flags. This patch changes the=

> driver to handle the correct flag IORESOURCE_IRQ_SHAREABLE instead.
>=20
> There are no mainline users of the platform driver which wrongly make u=
se
> of IRQF_SHARED.
>=20
> Signed-off-by: Sven Schmitt <sven.schmitt@volkswagen.de>
> Acked-by: Yegor Yefremov <yegorslists@googlemail.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

I just noticed that your email addresses are slightly different, which
do you prefer?

    "Schmitt, Sven (EVM/8)" <Sven.Schmitt@volkswagen.de>
    Sven Schmitt <sven.schmitt@volkswagen.de>

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigB6E3A5104640E7D8337A7696
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAkzOYACgkQjTAFq1RaXHNLZQCeOnwiUgVQKYJW+3hzrDUXTD7D
wO0AoJTvmI4k0fqyKI9PYsT0GWRmB4OX
=w3iu
-----END PGP SIGNATURE-----

--------------enigB6E3A5104640E7D8337A7696--
