From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: CAN implementation on A20 Allwinner
Date: Tue, 02 Dec 2014 13:37:47 +0100
Message-ID: <547DB29B.4070601@pengutronix.de>
References: <2d24e34ceb8e4fe4b0b7c74b9a36da44@SGPMBX1006.APAC.bosch.com>    <54770F0F.7050904@hartkopp.net>    <369acf6bdf8b4ae3840b69bef10b5082@SGPMBX1004.APAC.bosch.com>    <21623.28007.620480.114111@gargle.gargle.HOWL>    <58243.88.153.236.115.1417116776.squirrel@webmail.rdts.de> <58560.88.153.236.115.1417118037.squirrel@webmail.rdts.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="BbSFS8Xk9Gv5Tu819u3jr4rUAl4kIsklM"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59585 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbaLBMhu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Dec 2014 07:37:50 -0500
In-Reply-To: <58560.88.153.236.115.1417118037.squirrel@webmail.rdts.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: info@gerhard-bertelsmann.de, Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, Pankajkumar Misra <pankaj.kumar@in.bosch.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BbSFS8Xk9Gv5Tu819u3jr4rUAl4kIsklM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/27/2014 08:53 PM, Gerhard Bertelsmann wrote:
> Hi again,
>=20
> here are some updates:
>=20
> https://github.com/btolfa/sunxi-can-driver

It it's sja1000 compatible, it should work out of the box with the
existing sja1000 device tree binding.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--BbSFS8Xk9Gv5Tu819u3jr4rUAl4kIsklM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfbKbAAoJECte4hHFiupUyU0QAJODojh4qvBFHJZmGUpy05am
oUMSZPUi4TAeEMYhF/jQXtDsuvWxWYNI2PaTWwCUmKsxbEkNC1g6kKlwoVMejRvm
g+v7y+uYxJs9XqbZTwgbdxj7/j7JanK83xY4Xz1yri51qIvUgIT9MSBjnfSL1LSq
9Ai4UqJZcg1loWV2dt5uTkR88DYFbnWKiJ7+XyT3HjpAIoErt8KyRIOD0Gtpo6JU
iH/Ju96Rbbe2b34iBcDTgwwDGlLPXvKECpjoQIX7hEZ/y65wrKWpHURrAbnU5D+U
ggSHxFmNi/8plcU9b8/yd5CM8IDCHMvNP81r9Nxu3zuPnYiJTraOMoB+ITJtP2R/
xjyVclTr92XI7HC0Envh1D2bfTgTooY1Sx43VABHMWZqn3uc9mzSYzvcUaeReJE9
1i9t80dBs6keePjhoSt5pC8qzJsNXuHEAgqOnyXE7yyzajkCsoDDJ6djzXghTrxi
IC/pLCY8S9t05aLSdfSfKBYgTMkaeXhmaNlXpx6m9pGOHbf8l39h+NR2Vr+qNcfL
ubv3+R2JcIraTfWkiuQuIYzj+eNWGvSmCeQEqF9rypTTq1wpshOFZteLoEfih70h
fs8sndjSDbdbFN7qlnQK6R4fjROcgSsyLReeg+LjXI7HcIM93rkQ60ONiTa3lDzc
vwfEA9i0ICMIDNE2w0Cd
=wcFg
-----END PGP SIGNATURE-----

--BbSFS8Xk9Gv5Tu819u3jr4rUAl4kIsklM--
