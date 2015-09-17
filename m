From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: add documentation about CAN FD controller specific
 configuration
Date: Thu, 17 Sep 2015 22:33:16 +0200
Message-ID: <55FB238C.6060601@pengutronix.de>
References: <1442519926-4506-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Ftd14mMSmgdJaKcaAipKuUhW8mhe7bv7F"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:32808 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbbIQUdY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Sep 2015 16:33:24 -0400
In-Reply-To: <1442519926-4506-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ftd14mMSmgdJaKcaAipKuUhW8mhe7bv7F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/17/2015 09:58 PM, Oliver Hartkopp wrote:

Please give short commit message.

> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  Documentation/networking/can.txt | 75 +++++++++++++++++++++++++++++---=
--------
>  1 file changed, 55 insertions(+), 20 deletions(-)
>=20
> diff --git a/Documentation/networking/can.txt b/Documentation/networkin=
g/can.txt

Please add Jonathan (Cc'ed - this time for real) for the next round, he
usually takes Documentation related patches.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |




--Ftd14mMSmgdJaKcaAipKuUhW8mhe7bv7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV+yOMAAoJEP5prqPJtc/HQPwIAJd1W1/6qxG8GU1lXX+ycGDs
O2C/hL+emEo02jIAUfnfiU29Tz2rsEl+f7Wsf5x/p7pezoG9qUyKY138HzZJK7dU
id/+hFolYMn1vJ36VqO0glmDcCXgEhjO4MrmJUTka/WN+Kd1IN/ePCaBcloh6em6
0HCxhR1UWVmEQnye7Cr7i5uIf0wu0SDUOWwEZPNq3dIvKVljoq+0c9qIBg98A6L9
SOu3RSlivMjh8Sp4IIqJRKcz0w2LE+FMMB4aLtbtp69Ra1FMWaT1o8P3jp29OjD7
n1gHf54z8ryQW4sFbNgLwuzfj5wbhlu1KeOsvjg4HYDzyWGtpU4/lw4xYMJsq18=
=vScu
-----END PGP SIGNATURE-----

--Ftd14mMSmgdJaKcaAipKuUhW8mhe7bv7F--
