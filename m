From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: disable completely the ECC mechanism
Date: Fri, 16 Aug 2019 08:37:30 +0200
Message-ID: <18178f51-2a64-0401-839c-36f774a22fbe@pengutronix.de>
References: <20190815075806.23212-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="18E0YIb4pnwpQXeRnATY6Y4QMQXHx0j2X"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190815075806.23212-1-qiangqing.zhang@nxp.com>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "stefan@agner.ch" <stefan@agner.ch>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--18E0YIb4pnwpQXeRnATY6Y4QMQXHx0j2X
Content-Type: multipart/mixed; boundary="A3iWmuuPEigh9yYBMKcMtGNdLf2iiSztH";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "stefan@agner.ch" <stefan@agner.ch>, dl-linux-imx <linux-imx@nxp.com>
Message-ID: <18178f51-2a64-0401-839c-36f774a22fbe@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: disable completely the ECC mechanism
References: <20190815075806.23212-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20190815075806.23212-1-qiangqing.zhang@nxp.com>

--A3iWmuuPEigh9yYBMKcMtGNdLf2iiSztH
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 8/15/19 10:00 AM, Joakim Zhang wrote:
> The ECC(memory error detection and correction) mechanism can be
> activated or not, controlled by the ECCDIS bit in CAN_MECR. When
> disabled, updates on indications and reporting registers are stopped.
> So if want to disable ECC completely, had better assert ECCDIS bit,
> not just mask the related interrupts.
>=20
> Fixes:cdce844865be("can: flexcan: add vf610 support for FlexCAN")
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

Added to can.

tnx
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--A3iWmuuPEigh9yYBMKcMtGNdLf2iiSztH--

--18E0YIb4pnwpQXeRnATY6Y4QMQXHx0j2X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1WTyoACgkQWsYho5Hk
nSBqagf/XyBojzLJrtEUEfjyQK6/rbTt8TNegezyPeZcsxzB8G2VCrBXVpUoRtWq
eOOo2vmFhSa+65hr0vDzDsWqRdSC8ce9RiSsV+D+DZP7ejWDYigaW5CrIVF3lx1u
59SgXR5O2x7ZEye3e3X+jyax6Un28qH+v0BuUlcfrLuBzDQ8hvOQ+e1mvGH0csNM
NJaZ9Zg/iyFQyyVC9Ae7emdZmMJUmCpoDc2e9srGiP60Tcv4fwKnTrdCMUEFMcbk
GrTOihO+X2CP/ZHxQbUlsi8YB8tbTNV61ywtw1TCddtv/vAMLdyFJTcR2eP7VdE7
vJ4ZMMVWXPxCcmoB5lkRPbBAhpZjYQ==
=y+VK
-----END PGP SIGNATURE-----

--18E0YIb4pnwpQXeRnATY6Y4QMQXHx0j2X--
