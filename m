From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] net: can: peak: fix bad memory access and free sequence
Date: Thu, 8 Dec 2016 16:44:38 +0100
Message-ID: <5cbead3e-fa18-7272-0590-ad6633d41c52@pengutronix.de>
References: <CGME20161208114907epcms1p263def532c5b3705a19fff179385a50a0@epcms1p2>
 <201778981.871011.1481198473938.JavaMail.weblogic@ep1ml101a>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="12NveEPMQ6hHFTlq3Dp1k2XA9KIl8CoWk"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42735 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932790AbcLHPon (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 8 Dec 2016 10:44:43 -0500
In-Reply-To: <201778981.871011.1481198473938.JavaMail.weblogic@ep1ml101a>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: jiho.chu@samsung.com
Cc: "wg@grandegger.com" <wg@grandegger.com>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--12NveEPMQ6hHFTlq3Dp1k2XA9KIl8CoWk
Content-Type: multipart/mixed; boundary="qKMcmlheuHbgtJQa6VMgtd8LaPUfB0gUX";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: jiho.chu@samsung.com
Cc: "wg@grandegger.com" <wg@grandegger.com>,
 linux-can <linux-can@vger.kernel.org>
Message-ID: <5cbead3e-fa18-7272-0590-ad6633d41c52@pengutronix.de>
Subject: Re: [PATCH] net: can: peak: fix bad memory access and free sequence
References: <CGME20161208114907epcms1p263def532c5b3705a19fff179385a50a0@epcms1p2>
 <201778981.871011.1481198473938.JavaMail.weblogic@ep1ml101a>
In-Reply-To: <201778981.871011.1481198473938.JavaMail.weblogic@ep1ml101a>

--qKMcmlheuHbgtJQa6VMgtd8LaPUfB0gUX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/08/2016 01:01 PM, =EC=B6=94=EC=A7=80=ED=98=B8 wrote:
> Fix for bad memory access while disconnecting. netdev is freed
> before private data free, and dev is accessed after freeing netdev.
> =20
> This makes a slub problem, and it raise kernel oops with slub debugger
> config.
> =20
> Signed-off-by: Jiho Chu <jiho.chu@samsung.com>

Applied to can.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--qKMcmlheuHbgtJQa6VMgtd8LaPUfB0gUX--

--12NveEPMQ6hHFTlq3Dp1k2XA9KIl8CoWk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlhJf+YACgkQPTuqJayp
JWrqIQf/UYAxe0sbH4uaWTIDHINKL1P/TEoLX8iUZSD10R8yd1PR0dG+QQcmpo3g
uEexEDToq1tJzVRLHXtl7nQdUKfegJ9nd7+073ghHEzqoW/hQFwvuFpePDEM/v4R
bUrrfhb5CSaARONJ1g4/ZgP6vjG3zintqocTUABi5ytAuex+huhXWEDBKrV95AQo
f0x16tZ+wPUeArsAyuRm8LV+VUkK2hfMpNVB307sSjK/Nm/ZzWMoIjLryDTRzs8l
17kwFWh6ScGucMorWeN+TbBgS08m44RYpcXDg3AwHR3kkxPS/1ZQLyznIYq+aFqm
asc7GK8x8tr9XiuQraaU6DDa4Zl7Og==
=tvQc
-----END PGP SIGNATURE-----

--12NveEPMQ6hHFTlq3Dp1k2XA9KIl8CoWk--
