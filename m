From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/3] can: flexcan: Add support for non RX-FIFO
 mode and ERRATA ERR005829
Date: Thu, 09 Apr 2015 17:46:36 +0200
Message-ID: <55269EDC.7040802@pengutronix.de>
References: <1428593056-13701-1-git-send-email-bhupesh.sharma@freescale.com> <1428593056-13701-3-git-send-email-bhupesh.sharma@freescale.com> <55269D84.1070606@pengutronix.de> <BY1PR0301MB1303A2C667A89188E2E9383B82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="lIgRvfpS5eSaCUId5wvJAkWDACFjQoCVU"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54339 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbbDIPqr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Apr 2015 11:46:47 -0400
In-Reply-To: <BY1PR0301MB1303A2C667A89188E2E9383B82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "bhupesh.sharma@freescale.com" <bhupesh.sharma@freescale.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "Sakar.Arora@freescale.com" <Sakar.Arora@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lIgRvfpS5eSaCUId5wvJAkWDACFjQoCVU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/09/2015 05:45 PM, bhupesh.sharma@freescale.com wrote:
>> -----Original Message-----
>> From: Marc Kleine-Budde [mailto:mkl@pengutronix.de]
>> On 04/09/2015 05:24 PM, Bhupesh Sharma wrote:
>>> This patch adds support for non RX-FIFO (legacy) mode and ERRATA
>>> ERR005829 handling in flexcan driver.
>>
>> What about
>> 25e924450fcb can: flexcan: implement workaround for errata ERR005829 ?=

>=20
> Oops, looks like a typo. Will fix in V2.
>=20
>>> Both these features are now selectable via Kconfig entries and hence
>>> can be turned-on/off as per a SoC feature set availability.
>>
>> Sorry Kconfig is not an option here.
>=20
> I meant the defconfig here. By default the errata handling would be tur=
ned-off
> in the Kconfig.
>=20
> Any other ideas?

Please look at the mainline commit:

25e924450fcb can: flexcan: implement workaround for errata ERR005829

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--lIgRvfpS5eSaCUId5wvJAkWDACFjQoCVU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVJp7gAAoJECte4hHFiupU4pMP/icLGu0GyCN2hUbYzcgYkSbm
xlZiW9kOoOZ/peyb/uT0NjmVNFbHPMwX1f+W7D0JeVMi2zGBGoL9GVTe3BTKyfrd
So5IIIZX3iDFeDmI5ehUo4ePa2DukNKZVyKOoCYLhh6VimrF7eSMyQl2RXjeCIZJ
YCeVygH/y2+dVveUpj6cad2QgkHpl887azKsN7LCLvrIdgKJ7pLkfNC9u4qHEWFm
RBJxhw1j4/O1sHT3S9YTZElpo7Zb7LJrIlb8YBo4Qs7mNRjoWFmATtxvM1zgs4P+
IDN8NVFuWg1sa/7cYREE1CzlnMIbJTt9W/W9PGiRxwIV7DgGcom7DhqPsbHr8gwO
eFwSXW0OydYRrs4COjchr2piBklzZVRFqX6r/zqGn6jOMMIBGeAOSu/hY14UObTn
9hjujhzbW4orqceoc1u/UJsfR0tmQ+gwxB1OTp0li4Xd7MysR+tD0mgUG7YLO8vy
nG3AFUqSqQ1xEFw0vl89cqPJgkgu2fc5Ldm3UO4ikoqejue6WlhW5iobIWJRPkRh
wS3NQJtZSS9icnXTc4tw5c0mqxCys3UkJ340CDAnhVrERiFgxaaeTrAr0R00p8uY
KP6Xhd/bCM0mbrts4OKz7rvuQOO3U0PMSlDXDGyUZFFm+i92tbY42mJ9V6frhnjz
mPEVp7xI5SloQUJ2oMMD
=C3Sh
-----END PGP SIGNATURE-----

--lIgRvfpS5eSaCUId5wvJAkWDACFjQoCVU--
