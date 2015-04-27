From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/3] can: flexcan: Add support for non RX-FIFO
 mode and ERRATA ERR005829
Date: Mon, 27 Apr 2015 09:10:10 +0200
Message-ID: <553DE0D2.8090504@pengutronix.de>
References: <1428593056-13701-1-git-send-email-bhupesh.sharma@freescale.com> <1428593056-13701-3-git-send-email-bhupesh.sharma@freescale.com> <55269D84.1070606@pengutronix.de> <BY1PR0301MB1303A2C667A89188E2E9383B82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com> <55269EDC.7040802@pengutronix.de> <BY1PR0301MB1303BCBCB7BBC7A10409D52E82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com> <5526A4EE.8040401@pengutronix.de> <BY1PR0301MB1303410A178296C5EC58560B82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com> <5526A9D7.8000205@pengutronix.de> <BY1PR0301MB1303351EFA537E82A02D2FC682E90@BY1PR0301MB1303.namprd03.prod.outlook.com> <553DDB0E.4060205@pengutronix.de> <BY1PR0301MB1303C0A7F5733B45719E05AE82E90@BY1PR0301MB1303.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="MjTldhDTBnJtsMUrJidtTnNUWfM1f1Qg8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38377 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143AbbD0HKY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 27 Apr 2015 03:10:24 -0400
In-Reply-To: <BY1PR0301MB1303C0A7F5733B45719E05AE82E90@BY1PR0301MB1303.namprd03.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "bhupesh.sharma@freescale.com" <bhupesh.sharma@freescale.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "Sakar.Arora@freescale.com" <Sakar.Arora@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MjTldhDTBnJtsMUrJidtTnNUWfM1f1Qg8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2015 08:51 AM, bhupesh.sharma@freescale.com wrote:

>>> The errata list is not available for public access on www.freescale.c=
om
>> so far.
>>> The next version of LS1021A SoC, is fixing this bug and since both ar=
e
>>> supposed to be used by customers, the kconfig trick is required to
>>> turn-off this handling for one version, while keeping it intact for t=
he
>> other.
>>
>> Sorry, a compile time switch is not an option here. Please configure i=
t
>> during runtime via the device tree. This can be done by different
>> compatibles, one for the broken another one for the fixed SoC.
> =20
> Well, most of the code is written to handle this on run-time (on basis
> of the dts). Maybe I can create two versions of fsl_ls1021a_devtype_dat=
a rather
> than using the kConfig:
>=20
> For the broken- SoC:
> static struct flexcan_devtype_data fsl_ls1021a_devtype_data =3D {
> 	.features =3D FLEXCAN_HAS_V10_FEATURES | FLEXCAN_HAS_MECR_FEATURES
> 	| FLEXCAN_USES_RX_MB
> 	,
> };
>=20
> and for the new-SoC:
> static struct flexcan_devtype_data fsl_ls1021a_devtype_data =3D {
> 	.features =3D FLEXCAN_HAS_V10_FEATURES | FLEXCAN_HAS_MECR_FEATURES
> 	,
> };

Yes - use two different variables for this and assign them to two
compatible entries.

> Note that the legacy (non-RX FIFO mode) should work on all the FlexCAN =
variants,
> so this a feature which some-one can expose/hide as per their use-case,=
 as long
> as the driver supports both the Rx-FIFO and non-RX-FIFO mode legs.

Sure, but not via a compile time switch.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--MjTldhDTBnJtsMUrJidtTnNUWfM1f1Qg8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVPeDSAAoJECte4hHFiupUXy4P+wdmwL9M/+NuS5GSrAfWctTl
hL2ubVVI+cuDD1STMIXx0NkgwlGDKLwXwCPvzpop/ibLKmQpi6JRELlfzTI4JCPt
SStXkXShofR1GcuQHYLYZAzzGJOiEdQiAE9GKTwiGjT6sEWqpwY3dyjQ+75czJeg
rX2C2fJtLp6ZeIYxCnPB3ryBF57giY3Egd3enCo7i1hxPy1lymvxJ7RroOm8t7H5
S43zLz7Fsg0hnOwBKkA7dVLDOGwEZEu2M4pRqaWe8Z0tssFKYJopkNV5Kpa84x91
nCn6RuqKjTKTaYDKsVQjaPz1AamRKeHr8Hq9VOsjVTPNcGsrIDzCif0mySiXkiw8
Eya/HUZTWs+5BzKX6hpw7cqzKl2mJpbw4YCt2SZFVkSugLaKYe0v2NzIAxJ5Yecv
4WAP9KAs5rh3nsx7p0X3ZnN98YUoJxwl1+wBg3qig2u8UNr9gzuaUzt+n8FCnUM1
pSTNNEaN1DYipRkfy3qOP/zFgLU01Yr6ncw+hcmxQyvk5em7Z1Ti6uWX6OVf5riO
Gt+9GLI8MONuYJ/51cWCIsVlgfu69kYAxBOmpG/8daio1CULHYXQ6YenycouT7N6
mV9ZfZazC6XzzvAkLp/PXvTU/GZTvedAXZGSUBoqun0Yth1CsUhvEXkpE2shbuCu
aG9kKFQq6yFqSr9H+4dv
=4Xxl
-----END PGP SIGNATURE-----

--MjTldhDTBnJtsMUrJidtTnNUWfM1f1Qg8--
