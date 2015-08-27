From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN implementation on A20 Allwinner
Date: Thu, 27 Aug 2015 15:49:52 +0200
Message-ID: <55DF1580.3070806@pengutronix.de>
References: <2d24e34ceb8e4fe4b0b7c74b9a36da44@SGPMBX1006.APAC.bosch.com>
 <54770F0F.7050904@hartkopp.net>
 <369acf6bdf8b4ae3840b69bef10b5082@SGPMBX1004.APAC.bosch.com>
 <21623.28007.620480.114111@gargle.gargle.HOWL>
 <58243.88.153.236.115.1417116776.squirrel@webmail.rdts.de>
 <58560.88.153.236.115.1417118037.squirrel@webmail.rdts.de>
 <547DB29B.4070601@pengutronix.de>
 <a3cdd6d97480f7b31a53e94169f8a1eb@mail.rdts.de>
 <55DF0F39.10507@pengutronix.de>
 <c05ac4c76aad5f8e94cb98960ccfbc43@mail.rdts.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="5sKtlMCQ1TQENrir9g7613XjgwJoFfw0s"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56605 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbbH0Nt7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Aug 2015 09:49:59 -0400
In-Reply-To: <c05ac4c76aad5f8e94cb98960ccfbc43@mail.rdts.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Cc: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, Pankajkumar Misra <pankaj.kumar@in.bosch.com>, linux-can@vger.kernel.org, linux-can-owner@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5sKtlMCQ1TQENrir9g7613XjgwJoFfw0s
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/27/2015 03:34 PM, Gerhard Bertelsmann wrote:
>> Which are the registers that have the upper 24 bit used?
>=20
> CAN_STA_REG  status register
> CAN_BUS_TIME bus timing
> CAN_REC_REG  errot counter

That's ok.

> Some regs also have a different address

Which one? How may?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--5sKtlMCQ1TQENrir9g7613XjgwJoFfw0s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV3xWAAAoJEP5prqPJtc/HFMIH/3eNHRNY7h73zntOy3dbqd9w
krSTH+5Z0gpjyw7LS5KfdjZDa8nXD8q4DsPmsEoYm9t0dl6Q25NWFS3Yp+dl8JTh
IQdVAKRpA4cIZOW7LKpnoumLO/r11Je/J4w79KrYW10AsQ9TcHsUsmL4/yNaNCTp
ZwSQmdzum4WflzRwpk7Y7grwMe3/YgxiJuS9YJpWWm5e1VF5IqQmYiFXhST6/L8E
DB7z0OJBD8Jgh00UPDcP2vRX4Rxj3gPVqEq8dAZrGd6RU+lCy0M02TOXngd38xcc
yoEEMIhcnf90p+tWjECY2BooNLapd3FO0Unjw/1rZnY+y5Q8Sr/0xewEMaiBKgI=
=HB22
-----END PGP SIGNATURE-----

--5sKtlMCQ1TQENrir9g7613XjgwJoFfw0s--
