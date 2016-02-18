From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: PCAN USB Pro FD one-shot
Date: Thu, 18 Feb 2016 14:29:33 +0100
Message-ID: <56C5C73D.5080304@pengutronix.de>
References: <56C5BF73.9040402@sevenbyte.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="PBBWxhSorEJ9PdtHPvkLp2DeVDlaGV5OI"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44031 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946126AbcBRN3n (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 18 Feb 2016 08:29:43 -0500
In-Reply-To: <56C5BF73.9040402@sevenbyte.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefan Tatschner <rumpelsepp@sevenbyte.org>, linux-can <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PBBWxhSorEJ9PdtHPvkLp2DeVDlaGV5OI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/18/2016 01:56 PM, Stefan Tatschner wrote:
> I am currently working with the PCAN USB Pro FD device. I wanted to
> experiment with the "one-shot" mode, which is proposed by "ip":
>=20
>     $ ip link set can0 type can help
>     Usage: ip link set DEVICE type can
>     (...)
>         [ loopback { on | off } ]
>         [ listen-only { on | off } ]
>         [ triple-sampling { on | off } ]
>         [ one-shot { on | off } ]
>         [ berr-reporting { on | off } ]
>         [ fd { on | off } ]
>         [ fd-non-iso { on | off } ]
>         [ presume-ack { on | off } ]
>     (...)
>=20
> Unfortunately this seems currently not supported by the SocketCAN
> driver. Do you have any more information on this topic?

Indeed it's not supported by the driver. Maybe Stephane can tell, if at
least the hardware supports this feature.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--PBBWxhSorEJ9PdtHPvkLp2DeVDlaGV5OI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWxcc+AAoJED07qiWsqSVq/cAH/2wXGPyMzBEUhRkgbieB2+P6
nLkzFhKTKqod2cKKxzN6SzLj3AgUYtT1ixMZtSN1E46n1kbeNdwvbpcGTkpiOfUE
+1Q6Q+s0Mrt/whiqRjfjuFuH5AhXw6sh3QGezf2eO2F052IolKmYBwcoV8MudFY6
EoYaao4dlpNcDFGhWCb6SFpT0bO6GocbssEGqoLbh33iJwu5Fy9aTcmJpf6Tdigg
jl+nGqNO5pp/DQUpClAXZ+gMoVxKu1/WFCsFrarM9ljzHRPLbvJuh8vix8+stOcJ
0qqeftU+oGXFxdkOU8PvzqU7QIHqvByGQiOJ3uM9hAIdeeet4MQzj3UN5EEavkA=
=r0Ge
-----END PGP SIGNATURE-----

--PBBWxhSorEJ9PdtHPvkLp2DeVDlaGV5OI--
