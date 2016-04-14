From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: J1939 Linux
Date: Thu, 14 Apr 2016 12:49:59 +0200
Message-ID: <570F75D7.6000708@pengutronix.de>
References: <20160408090444.GA5485@airbook.vandijck-laurijssen.be>
 <570793F6.7080808@eurek.it>
 <4E8D1C61-042C-4AF2-99AF-410CEEBA6861@vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA87095C7B@POCITMSEXMB05.LntUniverse.com>
 <20160409114019.GA8567@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709986A@POCITMSEXMB05.LntUniverse.com>
 <20160412082020.GA19875@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709A50F@POCITMSEXMB05.LntUniverse.com>
 <20160412181540.GE19875@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709B02E@POCITMSEXMB05.LntUniverse.com>
 <20160414100314.GB16018@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="d5DtRc2lrnqFxXv8uiS8JEKs1uKCVseoD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55170 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753838AbcDNKuW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Apr 2016 06:50:22 -0400
In-Reply-To: <20160414100314.GB16018@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dinesh Velayudham <Dinesh.Velayutham@LnTtechservices.com>, gianluca <gianlucarenzi@eurek.it>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d5DtRc2lrnqFxXv8uiS8JEKs1uKCVseoD
Content-Type: multipart/mixed; boundary="hCRxVXDsMSO1TrV23jJdDFTvgmx2IPwbG"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dinesh Velayudham <Dinesh.Velayutham@LnTtechservices.com>,
 gianluca <gianlucarenzi@eurek.it>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <570F75D7.6000708@pengutronix.de>
Subject: Re: J1939 Linux
References: <20160408090444.GA5485@airbook.vandijck-laurijssen.be>
 <570793F6.7080808@eurek.it>
 <4E8D1C61-042C-4AF2-99AF-410CEEBA6861@vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA87095C7B@POCITMSEXMB05.LntUniverse.com>
 <20160409114019.GA8567@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709986A@POCITMSEXMB05.LntUniverse.com>
 <20160412082020.GA19875@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709A50F@POCITMSEXMB05.LntUniverse.com>
 <20160412181540.GE19875@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709B02E@POCITMSEXMB05.LntUniverse.com>
 <20160414100314.GB16018@airbook.vandijck-laurijssen.be>
In-Reply-To: <20160414100314.GB16018@airbook.vandijck-laurijssen.be>

--hCRxVXDsMSO1TrV23jJdDFTvgmx2IPwbG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/14/2016 12:03 PM, Kurt Van Dijck wrote:
> I pushed j1939d-v3.19.
>=20
> I created the branch by merging & cherry-pick, as suggested earlier.
> I didn't have compile problems.
>=20
> I have not tested it, yet I foresee no problems, or at least no
> differences compared to my other j1939d-vx.xx branches.

I want to do the first steps of mainlining j1939. Which is the preferred
branch? I've started with j1939/j1939d-v4.3.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--hCRxVXDsMSO1TrV23jJdDFTvgmx2IPwbG--

--d5DtRc2lrnqFxXv8uiS8JEKs1uKCVseoD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXD3XYAAoJED07qiWsqSVqQa0H/ieiIBXJDU2maW/YrYRhh4oI
SUwOmTn9nFVbR8X6ZanqK1frA1FcW8udPOfkHN8ciNfop+7BQ3p+Vi2wmRX55IhS
uDUmHDxjTeRmb1Bt41r6Nv4HlyNIH5ZJymnuEPEz9a0JCftuovLUs04uHIzffwOx
+q07TX5+woJpNCf/cVeIwSSm3xowkRNZjlsdgy8im2sRNqX+3tzJ6ar78+oqmlkh
33JxHX4WmYcUqsjoCVhSZSqBxAx8z3eqEh88eLlTeh/9rx4+NaUW8geX/sURZLRd
ZVaOx0MVnEJukT4YOLTgMMN5TwnwWfCer2woDALOiPaK3yD4RGMFwYOmhCU/Mzc=
=DYrg
-----END PGP SIGNATURE-----

--d5DtRc2lrnqFxXv8uiS8JEKs1uKCVseoD--
