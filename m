From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: bug in DT docs vs mcp251x.c driver
Date: Tue, 21 Feb 2017 19:46:34 +0100
Message-ID: <bd9d08e0-4fc3-f07b-7ce6-f9c14397c744@pengutronix.de>
References: <1d36bb5b-b46a-8e9a-672b-907cac5c5ab4@elpromaelectronics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="vTEmG71CTDR8ShasB3sDOhi1Uiw17IMK7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:43419 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751282AbdBUSqr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Feb 2017 13:46:47 -0500
In-Reply-To: <1d36bb5b-b46a-8e9a-672b-907cac5c5ab4@elpromaelectronics.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Janusz_U=c5=bcycki?= <j.uzycki@elpromaelectronics.com>, Alexander Shiyan <shc_work@mail.ru>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "l.dalek elpromaelectronics.com" <l.dalek@elpromaelectronics.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vTEmG71CTDR8ShasB3sDOhi1Uiw17IMK7
Content-Type: multipart/mixed; boundary="EnGr2narIkMqPTj9DGfKFdRdxBtGgIHI4";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?Q?Janusz_U=c5=bcycki?= <j.uzycki@elpromaelectronics.com>,
 Alexander Shiyan <shc_work@mail.ru>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org,
 Wolfgang Grandegger <wg@grandegger.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "l.dalek elpromaelectronics.com" <l.dalek@elpromaelectronics.com>
Message-ID: <bd9d08e0-4fc3-f07b-7ce6-f9c14397c744@pengutronix.de>
Subject: Re: bug in DT docs vs mcp251x.c driver
References: <1d36bb5b-b46a-8e9a-672b-907cac5c5ab4@elpromaelectronics.com>
In-Reply-To: <1d36bb5b-b46a-8e9a-672b-907cac5c5ab4@elpromaelectronics.com>

--EnGr2narIkMqPTj9DGfKFdRdxBtGgIHI4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 07:08 PM, Janusz U=C5=BCycki wrote:
> Hi,
>=20
> We've noticed the inconsistency in DT which still exist in kernel v4.10=
:
>=20
> devm_regulator_get(&spi->dev, "vdd") in drivers/net/can/mcp251x.c
>=20
> vs vdd-supply: Regulator that powers the CAN controller. in
> bindings/net/can/microchip,mcp251x.txt
> Eg. https://patchwork.ozlabs.org/patch/304371/ best regards Janusz=20

Can you create a patch to fix the issue?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--EnGr2narIkMqPTj9DGfKFdRdxBtGgIHI4--

--vTEmG71CTDR8ShasB3sDOhi1Uiw17IMK7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlisiwoACgkQHv7KIOw4
HPbK4Qf/fWk4qxauBFl7SVu5ZQe2F+ZgK62GIiRK3p25U/Ov/MT2/AZa9B6OSQtf
kQTV1hIXKKJv/zCVPIuclKoxZx4kb/o4snTZ339LVVWJn868BmWQ4n2WijTJS8XX
1x5AzrKcxcJaRzrKk4LtOikwAD5tRvQK2DRvPVeJHkhENbKSzbNWtI+8u9pj0nqC
p37rjkfUiWGtSoJJFiQUholkbVZIhO9llnR3gv26KfXZgQunzWasOKjZtlogjEZf
KE3/5Kj2HcduGpzh7ZieEFxWMXFL4ukf0IzGTlMaIaz7FbDdhQlZZb8AxkwZ7nEU
nIwvx2l4L92ZyvzggUYuY0uofwxNlw==
=EYHP
-----END PGP SIGNATURE-----

--vTEmG71CTDR8ShasB3sDOhi1Uiw17IMK7--
