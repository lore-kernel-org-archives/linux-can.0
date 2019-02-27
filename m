From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: fix timeout when set small bitrate
Date: Wed, 27 Feb 2019 12:06:26 +0100
Message-ID: <4fab8c56-99a9-f594-6ec7-588251b14837@pengutronix.de>
References: <20190131093509.12613-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="HqLiRd3NGHHLE9FYYUVWUt6MP3Ppw02yc"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190131093509.12613-1-qiangqing.zhang@nxp.com>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HqLiRd3NGHHLE9FYYUVWUt6MP3Ppw02yc
Content-Type: multipart/mixed; boundary="xBCeOyir2Mn1578IvOpSrsyxoANUDJKDF";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>
Message-ID: <4fab8c56-99a9-f594-6ec7-588251b14837@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: fix timeout when set small bitrate
References: <20190131093509.12613-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20190131093509.12613-1-qiangqing.zhang@nxp.com>

--xBCeOyir2Mn1578IvOpSrsyxoANUDJKDF
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 1/31/19 10:37 AM, Joakim Zhang wrote:
> Current we can meet timeout issue when setting a small bitrate like 100=
00
> as follows on i.MX6UL EVK board (ipg clock =3D 66MHZ, per clock =3D 30M=
HZ):
> root@imx6ul7d:~# ip link set can0 up type can bitrate 10000
> A link change request failed with some changes committed already.
> Interface can0 may have been left with an inconsistent configuration, p=
lease check.
> RTNETLINK answers: Connection timed out
>=20
> It is caused by calling of flexcan_chip_unfreeze() timeout.
>=20
> Originally the code is using usleep_range(10, 20) for unfreeze operatio=
n,
> but the patch (8badd65 can: flexcan: avoid calling usleep_range from in=
terrupt
> context) changed it into udelay(10) which is only a half delay of befor=
e,
> there're also some other delay changes.
>=20
> After double to FLEXCAN_TIMEOUT_US to 100 can fix the issue.
>=20
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

Applied to linux-can

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--xBCeOyir2Mn1578IvOpSrsyxoANUDJKDF--

--HqLiRd3NGHHLE9FYYUVWUt6MP3Ppw02yc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlx2bzIACgkQWsYho5Hk
nSAriQf9GclUXEJxnwLULH3PFpNEF3+497fu3m2tSJ2DUCNJSBq9ct24BtpgYvcV
KId9H3mxwGub0nOfqfzxANnUjFNP/IkXQyvWAaUDeqVknJvHg0yRMidk13xeppcA
GNJAo1i8rWKZMY8iAdztEu4dipowpcGMWsV/OCc+GBDUKbX6LRQGDAN/DtsedRQN
1hxMhTreHTX3TK1rG0ef8KxLw6TYVwfwoJ+9L1lOJkFBlcjB6GQiTIc3n5k3DcNl
bWuEohIZnM2/TFFb33SFFQgJSzA/jFf7cVhdmSJdnS2AAOKYzdEgOMZH6runQWTG
tfJhpnPrE5tgCyEsi37C4Mip0O223w==
=yRPQ
-----END PGP SIGNATURE-----

--HqLiRd3NGHHLE9FYYUVWUt6MP3Ppw02yc--
