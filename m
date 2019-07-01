From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V3] can: flexcan: fix stop mode acknowledgment
Date: Mon, 1 Jul 2019 12:37:58 +0200
Message-ID: <42ef6763-c8a6-9fcd-4706-8ebfa2f51ba0@pengutronix.de>
References: <20190619074035.25719-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="CtEx9EuPCx90ZiAfPbOGGu1CxAL2Apkt1"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190619074035.25719-1-qiangqing.zhang@nxp.com>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CtEx9EuPCx90ZiAfPbOGGu1CxAL2Apkt1
Content-Type: multipart/mixed; boundary="vDeLvfVUrJvD2FXwUXwMD8Hd2EQiXbsiQ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "wg@grandegger.com"
 <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <42ef6763-c8a6-9fcd-4706-8ebfa2f51ba0@pengutronix.de>
Subject: Re: [PATCH V3] can: flexcan: fix stop mode acknowledgment
References: <20190619074035.25719-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20190619074035.25719-1-qiangqing.zhang@nxp.com>

--vDeLvfVUrJvD2FXwUXwMD8Hd2EQiXbsiQ
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 6/19/19 9:42 AM, Joakim Zhang wrote:
> To enter stop mode, the CPU should manually assert a global Stop Mode
> request and check the acknowledgment asserted by FlexCAN. The CPU must
> only consider the FlexCAN in stop mode when both request and
> acknowledgment conditions are satisfied.
>=20
> Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
> Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
>=20
> ChangeLog:
> V1->V2:
> 	* regmap_read()-->regmap_read_poll_timeout()
> V2->V3:
> 	* change the way of error return, it will make easy for function
> 	extension.

Please rebase to linux-next/master, as this is a fix.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--vDeLvfVUrJvD2FXwUXwMD8Hd2EQiXbsiQ--

--CtEx9EuPCx90ZiAfPbOGGu1CxAL2Apkt1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl0Z4oYACgkQWsYho5Hk
nSBrgQgAgLWzsaWnUrrHa4ZkTf04iRA2C9WAbJU9+bkWMaSptOt/u8ndGZXWi91z
xQq8sV+j6CYAoMxYIZj+MiZhhkqkgQEstUYw3hvtWE3x4WAyLPyVYpg6JmnMV/ar
Yrfk2+hkR+UziBOMaKdF8aX+ImiksQrlcGhj2nrxrucLrdCu1rpKxVP4s/4eP34m
4SOLS3MequqZpYtN0rxZeJreRVymm0stNMU54AG9dmaF3EzxKtEmjMHQtzbPW4k3
Cgvgvxy6w3OF0b8syZul3DmcbIkBm2fwJ8rV1Z2ojuraubGGwWW4TkZzIN5RqV0W
Qux43aOkexWnHnav8+N5K6h9dy9NgA==
=VwiK
-----END PGP SIGNATURE-----

--CtEx9EuPCx90ZiAfPbOGGu1CxAL2Apkt1--
