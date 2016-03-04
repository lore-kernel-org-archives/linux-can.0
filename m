From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mcp251x: avoid write to error flag register if it's
 unnecessary
Date: Fri, 4 Mar 2016 08:52:28 +0100
Message-ID: <56D93EBC.3010209@pengutronix.de>
References: <1457071647-17098-1-git-send-email-edo.rus@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="SiwkVm68sNfmqfrNn9hbohK0rmLx45vci"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38030 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751080AbcCDHwi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Mar 2016 02:52:38 -0500
In-Reply-To: <1457071647-17098-1-git-send-email-edo.rus@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ed Spiridonov <edo.rus@gmail.com>
Cc: linux-can@vger.kernel.org, celston@katalix.com, chripell@evolware.org, sbabic@denx.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SiwkVm68sNfmqfrNn9hbohK0rmLx45vci
Content-Type: multipart/mixed; boundary="Ltkf8geanTIg33FrKkoxvlR7837Rfbmei"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ed Spiridonov <edo.rus@gmail.com>
Cc: linux-can@vger.kernel.org, celston@katalix.com, chripell@evolware.org,
 sbabic@denx.de
Message-ID: <56D93EBC.3010209@pengutronix.de>
Subject: Re: [PATCH] can: mcp251x: avoid write to error flag register if it's
 unnecessary
References: <1457071647-17098-1-git-send-email-edo.rus@gmail.com>
In-Reply-To: <1457071647-17098-1-git-send-email-edo.rus@gmail.com>

--Ltkf8geanTIg33FrKkoxvlR7837Rfbmei
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/04/2016 07:07 AM, Ed Spiridonov wrote:
> Only two bits (RX0OVR and RX1OVR) are writable in EFLG, write is useles=
s if these bits aren't set.
>=20
> Signed-off-by: Ed Spiridonov <edo.rus@gmail.com>

Added to can.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Ltkf8geanTIg33FrKkoxvlR7837Rfbmei--

--SiwkVm68sNfmqfrNn9hbohK0rmLx45vci
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJW2T68AAoJED07qiWsqSVqx80IAI7cs1wn1qOnr1wHGL4qeLWM
X/MqZvdm27C+3g64KU9fq4o5zK4auAO2BmOpM/HrTk+XmOxA7xTC5e6BqSZIv45r
lcjZNCJH+l29NVs/igafW0GEsAiyzYSGpNp6gcbYFTGX189iFd/20aE1l8VPRXy0
eTfLIfTfaMAWswvoBftQrvbpotpUhjxEHV6Hy4WIM2rjI1EdJ9hfXARipEGs700z
FTChmodF/lVG1PUJZMYNoCU/hwo3LI/7BJSvw0fDIDJW3qerYd5I41A+3W/QtK+A
sJutDxVg92IU8rVRsV2YMzAzJ1B+S0/ieTaTIBZPaBiGBi/0IvgcXZzYm2a6v8Y=
=XvvZ
-----END PGP SIGNATURE-----

--SiwkVm68sNfmqfrNn9hbohK0rmLx45vci--
