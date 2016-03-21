From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Testing CAN on Allwinner A20 / Banana Pi
Date: Mon, 21 Mar 2016 17:14:03 +0100
Message-ID: <56F01DCB.6060902@pengutronix.de>
References: <55F3E7A0.9020309@posteo.de> <55F3ECAC.7040508@pengutronix.de>
 <56ED45C9.7080803@posteo.de> <56ED4725.8080209@pengutronix.de>
 <56EFBE77.2020408@eurek.it> <56EFF1B2.9050404@posteo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="eR6W9WkmqmavwjsmV6iBKllwno290ulVx"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39485 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754411AbcCUQOU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 21 Mar 2016 12:14:20 -0400
In-Reply-To: <56EFF1B2.9050404@posteo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Patrick Menschel <menschel.p@posteo.de>, gianluca <gianlucarenzi@eurek.it>
Cc: linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eR6W9WkmqmavwjsmV6iBKllwno290ulVx
Content-Type: multipart/mixed; boundary="HhSwp3kS8i8e8jbumvi8uxQJPCQFII2Dn"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Patrick Menschel <menschel.p@posteo.de>, gianluca <gianlucarenzi@eurek.it>
Cc: linux-can <linux-can@vger.kernel.org>
Message-ID: <56F01DCB.6060902@pengutronix.de>
Subject: Re: Testing CAN on Allwinner A20 / Banana Pi
References: <55F3E7A0.9020309@posteo.de> <55F3ECAC.7040508@pengutronix.de>
 <56ED45C9.7080803@posteo.de> <56ED4725.8080209@pengutronix.de>
 <56EFBE77.2020408@eurek.it> <56EFF1B2.9050404@posteo.de>
In-Reply-To: <56EFF1B2.9050404@posteo.de>

--HhSwp3kS8i8e8jbumvi8uxQJPCQFII2Dn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/21/2016 02:05 PM, Patrick Menschel wrote:
> Thanks for the advice,
>=20
> in my case the sunxi_defconfig already had the driver selected, so no
> change necessary.
> Apparently only the device tree information is missing in the mainline
> kernel. If that were to change, it would work out of the box if a
> transceiver is added.

The CAN node should be added with no status attribute to the SoC dtsi,
so it's disabled. In the board dts you set status =3D "okay". The pinctrl=

goes into the dtsi if there's only one possibility, otherwise into the
board dts.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--HhSwp3kS8i8e8jbumvi8uxQJPCQFII2Dn--

--eR6W9WkmqmavwjsmV6iBKllwno290ulVx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJW8B3LAAoJED07qiWsqSVqt24H/2JgLHwtLWNEojL1TLjFGEi1
2dqNyD4qHX6yXw9807+fHMjNXONNkjpiJAWZMaE1WJw7kPz+x2uOJhTPLkxtY2fe
qtC9daxVjTKLMY2l0X7bBncuqhilkUZ7f4S6mc42/FHC3gL6T1rNtLBr9oHPvHIF
zQFtFJ6ffGd8jDU3z4ZL5Oim3NiTNhvgpLB1OqBb5nCp1jxTL63sUMCYyCBvv7VV
K5O2tnTzfYGEXNjqRZaDTS06AuiUqHLYJTeZxz2ghyc31DVK/26LDzSJ+YdqUIVc
6ejgPlK6OrIU2Ggz8qZXkxU0Aj28V3C5qLQdkeCpFx6sbnAwiwkVYnVkad/DL4g=
=rszQ
-----END PGP SIGNATURE-----

--eR6W9WkmqmavwjsmV6iBKllwno290ulVx--
