From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] at91_can: RX queue could get stuck at high bus load
Date: Fri, 17 Jun 2016 11:06:47 +0200
Message-ID: <88648356-2f45-152d-5d40-ba56ff374a9c@pengutronix.de>
References: <575EB8B3.6050502@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="XKPDugJdGH8dvfU3CO5cFX8QPpEhJA6Nl"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52355 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753942AbcFQJGz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2016 05:06:55 -0400
In-Reply-To: <575EB8B3.6050502@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org
Cc: Amr Bekhit <amrbekhit@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XKPDugJdGH8dvfU3CO5cFX8QPpEhJA6Nl
Content-Type: multipart/mixed; boundary="0n49wvPCgKH4xBSJUSeFKNPAXSDoETQXH"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org
Cc: Amr Bekhit <amrbekhit@gmail.com>
Message-ID: <88648356-2f45-152d-5d40-ba56ff374a9c@pengutronix.de>
Subject: Re: [PATCH] at91_can: RX queue could get stuck at high bus load
References: <575EB8B3.6050502@grandegger.com>
In-Reply-To: <575EB8B3.6050502@grandegger.com>

--0n49wvPCgKH4xBSJUSeFKNPAXSDoETQXH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/13/2016 03:44 PM, Wolfgang Grandegger wrote:
> At high bus load it could happen that "at91_poll()" enters with all RX
> message boxes filled up. If then at the end the "quota" is exceeded as
> well, "rx_next" will not be reset to the first RX mailbox and hence the=

> interrupts remain disabled.
>=20
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> Tested-by: Amr Bekhit <amrbekhit@gmail.com>

Applied to can/master + stable on Cc.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--0n49wvPCgKH4xBSJUSeFKNPAXSDoETQXH--

--XKPDugJdGH8dvfU3CO5cFX8QPpEhJA6Nl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXY72nAAoJED07qiWsqSVqYeMH/j+3p5g+rQcYFyQhBiaYHDYo
CDRou8OGhmTr0tCLK6Dtaaa2V/pkxPdFDvsVpyC9PYciPBoGHdihE/MJ4Vi86W89
5zoUYOpG2zgQMrZsJXDOm2fMyMMHS5iXce/8UbNRIj1hAprkUNsF6bdwbxE85zG/
4WG7BJCny3y6zgaX7ZCbVWOOW5myfzyUvbKG0yd4lb36zikztzUx5oX9OMjyqjzu
tTXolHDDgCsbMkXyzrfmrvB7OM05008x2AoE0wo4Ut+2ot/Kq6waEMX2CeHrf2xu
jnBkyWGehpBV1fF1uerC5ozDoZFe70vtf3uEXtfIvlciU6ZYL1v5+gncqdQU+ac=
=F/p6
-----END PGP SIGNATURE-----

--XKPDugJdGH8dvfU3CO5cFX8QPpEhJA6Nl--
