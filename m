From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/6] net: can: ifi: Start NAPI poll on bus warning too
Date: Sun, 8 May 2016 20:59:28 +0200
Message-ID: <572F8C90.7040601@pengutronix.de>
References: <1462660456-6179-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="1WeAoUwwAo1UXAd4juchW4Jjh8eAHfb1F"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53078 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750854AbcEHS7f (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 8 May 2016 14:59:35 -0400
In-Reply-To: <1462660456-6179-1-git-send-email-marex@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marek Vasut <marex@denx.de>, linux-can@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1WeAoUwwAo1UXAd4juchW4Jjh8eAHfb1F
Content-Type: multipart/mixed; boundary="tH5FwR8XvWuCWaSEhK2gC1o98UuvWDL8X"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Marek Vasut <marex@denx.de>, linux-can@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <572F8C90.7040601@pengutronix.de>
Subject: Re: [PATCH 1/6] net: can: ifi: Start NAPI poll on bus warning too
References: <1462660456-6179-1-git-send-email-marex@denx.de>
In-Reply-To: <1462660456-6179-1-git-send-email-marex@denx.de>

--tH5FwR8XvWuCWaSEhK2gC1o98UuvWDL8X
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2016 12:34 AM, Marek Vasut wrote:
> Start the NAPI polling in case the bus warning interrupt happens,
> since it is the poll function which checks and reports the warning.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: Wolfgang Grandegger <wg@grandegger.com>

Added all 6 to net-next/master.

thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--tH5FwR8XvWuCWaSEhK2gC1o98UuvWDL8X--

--1WeAoUwwAo1UXAd4juchW4Jjh8eAHfb1F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXL4yQAAoJED07qiWsqSVq2DoH/j9+A8gFQPNd55XjY9LX7gLr
fggUbRMZC93Ue6h0ndymQFIVtrLqIKcZBfHy12Oq8bK0EpsRoOUcjPNkpQS7tBoa
X4l5GOqZSlmNIJ8uYLbx0FHL8AbPXGCU9QgEd8O+AHAxBCD4YNVM6Qgdvgxp6QTf
qZz/+i/A3C7MUeoMlqpTWiTYVZFrOmYrm+zABGPmONOFjPcOnXPROCKJTjkn3Zar
yCnnZsJ5un9D5d3SV2T4FkURQ4LUIEh0uo7LqlfL6r2TE+47p1JZPUy6Qw58maNN
en67YUMo5hUpHz80yDcfLNAESa7iwg4EW/6s53rxmmta7z8N0HOxJBlutcb1wrU=
=sY/c
-----END PGP SIGNATURE-----

--1WeAoUwwAo1UXAd4juchW4Jjh8eAHfb1F--
