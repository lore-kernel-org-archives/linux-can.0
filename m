From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH net-next] can: flexcan: fix 'passing zero to ERR_PTR()'
 warning
Date: Fri, 4 Jan 2019 16:21:49 +0100
Message-ID: <0e7e2e17-01b7-e3bb-4bf1-ed73e7e92133@pengutronix.de>
References: <20181212092401.25612-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="598KjyuwFUg2LDEwTQFwVi9wnxPcY3pKj"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212092401.25612-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net, wg@grandegger.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--598KjyuwFUg2LDEwTQFwVi9wnxPcY3pKj
Content-Type: multipart/mixed; boundary="gUmdRbaa1hO8NMK5WjD97YrD3pYkjgn3J";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net, wg@grandegger.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-can@vger.kernel.org
Message-ID: <0e7e2e17-01b7-e3bb-4bf1-ed73e7e92133@pengutronix.de>
Subject: Re: [PATCH net-next] can: flexcan: fix 'passing zero to ERR_PTR()'
 warning
References: <20181212092401.25612-1-yuehaibing@huawei.com>
In-Reply-To: <20181212092401.25612-1-yuehaibing@huawei.com>

--gUmdRbaa1hO8NMK5WjD97YrD3pYkjgn3J
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/12/18 10:24 AM, YueHaibing wrote:
> Fix a static code checker warning:
> drivers/net/can/flexcan.c:1435 flexcan_setup_stop_mode() warn: passing =
zero to 'PTR_ERR'
>=20
> Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to linux-can.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--gUmdRbaa1hO8NMK5WjD97YrD3pYkjgn3J--

--598KjyuwFUg2LDEwTQFwVi9wnxPcY3pKj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlwveg4ACgkQk9IU1zQo
ZfEMoAf/cX8z/ngCxPNd/v6nW/5WJccNxg4CK866HkWE8OqZZeqwTEDEMp3pOaMc
TwLjePxSX+Dp28DmcMA828gp1LHArfnP85miTAtqwxYz+CvTLSIdeWvzTCcBGUSU
TtghNGF5ZTyn0GCO52jXGBhzzZeM6OXkoE4wHQ27PuRX4skiczMeYAgCgizx5Ggw
Kpr8cdRQJ18StxJirlvT9FG35PSBsQQca6ZGKM+HdbwQ5biKyuQgMexzTZEc89Ha
SeSOEE5sZAKxg2wIYGuI2yc9VV1stjI/qlislofBSjBzbqp2L9KHVf6nA+A9BVjP
4MkGC1yLqcRRjBGwubHlYB2+ECLIXQ==
=P//S
-----END PGP SIGNATURE-----

--598KjyuwFUg2LDEwTQFwVi9wnxPcY3pKj--
