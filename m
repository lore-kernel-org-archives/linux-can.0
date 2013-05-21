From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: facing some problem with flexcan driver
Date: Tue, 21 May 2013 08:56:21 +0200
Message-ID: <519B1A95.5060405@pengutronix.de>
References: <CALUo3F9Zmx-rOCOmBone6b-nu3G_0bfOjL1Npp=ku=2fBHpTJw@mail.gmail.com> <519355C2.2050502@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2MPKVWETGOHOIOFPFWSJR"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50722 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab3EUG4b (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 May 2013 02:56:31 -0400
In-Reply-To: <519355C2.2050502@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ashutosh Singh <ashuleapyear@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2MPKVWETGOHOIOFPFWSJR
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/15/2013 11:30 AM, Marc Kleine-Budde wrote:
----->8--------
> commit 28c17d5a382912ee66ed5476616b3d64d425a3e0
> Author: Marc Kleine-Budde <mkl@pengutronix.de>
> Date:   Wed May 15 11:28:38 2013 +0200
>=20
>     net: can: flexcan: switch on clocks before accessing ecr register
>=20
>     Reported-by: Ashutosh Singh <ashuleapyear@gmail.com>
>     Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Does the patch fix your problem?

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2MPKVWETGOHOIOFPFWSJR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGbGpkACgkQjTAFq1RaXHNs8QCfRqLKV47So0tV3ybiYiX1WCv/
tK8AnR0hE4T4QANK2qIeYDn4YZNNeZPV
=uZse
-----END PGP SIGNATURE-----

------enig2MPKVWETGOHOIOFPFWSJR--
