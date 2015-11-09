From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can-doc: Add missing semicolon to example
Date: Mon, 9 Nov 2015 14:20:51 +0100
Message-ID: <56409DB3.6040803@pengutronix.de>
References: <1447075029-22711-1-git-send-email-rumpelsepp@sevenbyte.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Ob27T7nsKmi5k2UAooXXWV3reNf7ohO8F"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53463 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbbKINVB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Nov 2015 08:21:01 -0500
In-Reply-To: <1447075029-22711-1-git-send-email-rumpelsepp@sevenbyte.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefan Tatschner <rumpelsepp@sevenbyte.org>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ob27T7nsKmi5k2UAooXXWV3reNf7ohO8F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/09/2015 02:17 PM, Stefan Tatschner wrote:
> The example code for CAN_BCM,
>=20
> 	connect(s, (struct sockaddr *)&addr, sizeof(addr))
>=20
> lacks a semicolon at the end of the line. This patch adds that
> missing semicolon to ensure that the given code snippet actually
> compiles.
>=20
> Signed-off-by: Stefan Tatschner <rumpelsepp@sevenbyte.org>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Jonathan, feel free to take the patch via your tree.

regards,
Marc

> ---
>  Documentation/networking/can.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/networking/can.txt b/Documentation/networkin=
g/can.txt
> index 4636b94..05fd83b 100644
> --- a/Documentation/networking/can.txt
> +++ b/Documentation/networking/can.txt
> @@ -681,7 +681,7 @@ solution for a couple of reasons:
>      addr.can_family =3D AF_CAN;
>      addr.can_ifindex =3D ifr.ifr_ifindex;
> =20
> -    connect(s, (struct sockaddr *)&addr, sizeof(addr))
> +    connect(s, (struct sockaddr *)&addr, sizeof(addr));
> =20
>      (..)
> =20
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Ob27T7nsKmi5k2UAooXXWV3reNf7ohO8F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWQJ2zAAoJEP5prqPJtc/H4BAIAMMWxasIfbQkLn88oDYFpF4g
g7ZLWuHsnGXMtctlwpSox+trxhAzrQTns/9GemSlPWJGYQkDiRQ8OcJFL3/UTQaj
bkQeBbBIGPc/OIajquC1NPqIZuS/W5ZPDoZNPE7kOGq5EZxUAZCCqC+pA70AtJZ/
ZtsqpP56ZOhb/tzlT/SLxF1HRKIxt18iviyOiVDb4eai3M7u8PHVGTtaLXc9Cy6c
tG2s2lbtCMKxk5Ld8rVX7ARSWXPnF6NGkBJyPn/UmlGoE12bI4dvws+dsdiix11m
SjQKkvmnuICwHSMEiyL4Ykf6aQpuQ5rPKnQdg1VaDWnkYTtrAntpL6F15arwiu8=
=R4tw
-----END PGP SIGNATURE-----

--Ob27T7nsKmi5k2UAooXXWV3reNf7ohO8F--
