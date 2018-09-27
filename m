From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can-next] can: ucan: remove set but not used variable
 'udev'
Date: Thu, 27 Sep 2018 12:37:50 +0200
Message-ID: <2f22c7ba-398d-5df0-682f-b4b289475d16@pengutronix.de>
References: <1535507214-145191-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="8cKmBNk7VWcb1aDTRruSsXo4LgHP2Ho0q"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1535507214-145191-1-git-send-email-yuehaibing@huawei.com>
Sender: netdev-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, Martin Elshuber <martin.elshuber@theobroma-systems.com>, Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8cKmBNk7VWcb1aDTRruSsXo4LgHP2Ho0q
Content-Type: multipart/mixed; boundary="ROFIXaM6U90sFTqSQZ7kEuC1RlanGJ6NT";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: YueHaibing <yuehaibing@huawei.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>,
 Martin Elshuber <martin.elshuber@theobroma-systems.com>,
 Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Message-ID: <2f22c7ba-398d-5df0-682f-b4b289475d16@pengutronix.de>
Subject: Re: [PATCH can-next] can: ucan: remove set but not used variable
 'udev'
References: <1535507214-145191-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1535507214-145191-1-git-send-email-yuehaibing@huawei.com>

--ROFIXaM6U90sFTqSQZ7kEuC1RlanGJ6NT
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 08/29/2018 03:46 AM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>=20
> drivers/net/can/usb/ucan.c: In function 'ucan_disconnect':
> drivers/net/can/usb/ucan.c:1578:21: warning:
>  variable 'udev' set but not used [-Wunused-but-set-variable]
>   struct usb_device *udev;
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to linux-can.

tnx.
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ROFIXaM6U90sFTqSQZ7kEuC1RlanGJ6NT--

--8cKmBNk7VWcb1aDTRruSsXo4LgHP2Ho0q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlussv4ACgkQk9IU1zQo
ZfGlzwf7BVIIFVrcRHUmTcmOf78qJTcruqSgSICspv2rNEHAXNx3FpXu582PPf1/
jfS/CYq9EZ5zBD8DsSMaUJk35yzVSP1Qs1Ab4/ggUigFoF9hdJ5tV9nYiPBZmrMd
p0tDPNayud/B2qEwsmJTPHyAcKy6oDjJM9D1yGM7HGHhutW6vStpIGMcia8oXjYY
J2f2NjtVeLh510S1OxUV66ng6mq+dJcobB4kgcxYwFvNtYInRxA6aKGUPCW3GGRR
K/pm5rFcIC8E8ieacT88Z9aTsKDABF7PwEV/0vGmDML1QNQt7axCH+XQwcWvZj0I
kH9vJB/B3OdINg7wN5GacUsieRv6VQ==
=r+n9
-----END PGP SIGNATURE-----

--8cKmBNk7VWcb1aDTRruSsXo4LgHP2Ho0q--
