From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3.18+] Tag current CAN FD controllers as non-ISO
Date: Wed, 07 Jan 2015 14:17:24 +0100
Message-ID: <54AD31E4.6050005@pengutronix.de>
References: <54AADC4F.2090404@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="feBXFivQk6b37NfAwGXtP1Gr6OQcUekdq"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57213 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbbAGNRe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Jan 2015 08:17:34 -0500
In-Reply-To: <54AADC4F.2090404@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>, Dong Aisheng <b29396@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--feBXFivQk6b37NfAwGXtP1Gr6OQcUekdq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2015 07:47 PM, Oliver Hartkopp wrote:
> During the CAN FD standardization process within the ISO it turned out =
that
> the failure detection capability has to be improved.
>=20
> The CAN in Automation organization (CiA) defined the already implemente=
d CAN
> FD controllers as 'non-ISO' and the upcoming improved CAN FD controller=
s as
> 'ISO' compliant. See at http://www.can-cia.com/index.php?id=3D1937
>=20
> Finally there will be three types of CAN FD controllers in the future:
>=20
> 1. ISO compliant (fixed)
> 2. non-ISO compliant (fixed, like the M_CAN IP v3.0.1 in m_can.c)
> 3. ISO/non-ISO CAN FD controllers (switchable, like the PEAK USB FD)
>=20
> So the current M_CAN driver for the M_CAN IP v3.0.1 has to expose its n=
on-ISO
> implementation by setting the CAN_CTRLMODE_FD_NON_ISO ctrlmode at start=
up.
> As this bit cannot be switched at configuration time CAN_CTRLMODE_FD_NO=
N_ISO
> must not be set in ctrlmode_supported of the current M_CAN driver.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Applied to can/master and added stable on Cc.

thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--feBXFivQk6b37NfAwGXtP1Gr6OQcUekdq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrTHkAAoJECte4hHFiupU/skP/RDRjbSjS2HSk6C+jU+vLRBM
jbn3i5bLdJxwknNUwO8IJiCUHc1DJQZ9w+ySJa1asbAgPCJuWuALDMpqTMdR9a8M
pE90eRcCmI75rvwcQc2TKLBSlX2uSotEDfQLoUkRUerJCdT6LKNKtrsK3erbekRv
OulxNJKxhSxyoINtvMH5YJSfBVnx5SntU0zDg8SyM6Rsp6TcUi7zqGrAF5YXrjVy
8oqmiWiHUl3dlBRQK7yEUxwK0GRxoI8cZemsJK5zM4JwVyBwig9e7Veu5h3mVxYA
emDfsVs8PXIyPiNblvrEy/U6NKitQIMNO2ezTZ/ZaoP5OWBOUsAsMYjXvbs7fVVQ
LZlp3KXVGNPOtVZVT4/Qdr9G5qLI17OiKdEnqMVhJX4X1K+mmaTuNRFtsjH5XzsC
HeVk+lvSWE/2Z04dwI3p3+ijFGdi9srWANWO4XflKsd7qP3ndLpgiNEzYeQrWF+Z
ZuGFoK6Vii6IRlafbtrGZyzN+Pr77V4jFFlGMF0gUvoi74cmAkRAvH7gVyKKMhgB
77St0ysw6nVvrUKKERtvwXKG/skgTgsU+e/C57hpw5xM3DukL6fcdYEys3Cd3lNz
oSEXO9I1U3FJM0HskY7d8U8DF/gbZsxRMDZEZ50ZvrDhbzTJ300VZDL7JApuOumq
ZVEPufFMP7y7KpRgVcLS
=kKKz
-----END PGP SIGNATURE-----

--feBXFivQk6b37NfAwGXtP1Gr6OQcUekdq--
