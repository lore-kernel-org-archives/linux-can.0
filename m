From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH -next] can: grcan: use devm_platform_ioremap_resource() to
 simplify code
Date: Fri, 4 Oct 2019 23:10:55 +0200
Message-ID: <5a3ed3bd-580d-448c-9ab2-880b5d9ba3c5@pengutronix.de>
References: <20190930094909.49672-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="3WVs5nsC4Uhmw7DbaTre7Jg2QUPg5h5fB"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190930094909.49672-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, wg@grandegger.com, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3WVs5nsC4Uhmw7DbaTre7Jg2QUPg5h5fB
Content-Type: multipart/mixed; boundary="QQ1lPPiiYZFtK40mmFeyoRHn5nrhJo8IT";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: YueHaibing <yuehaibing@huawei.com>, wg@grandegger.com, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <5a3ed3bd-580d-448c-9ab2-880b5d9ba3c5@pengutronix.de>
Subject: Re: [PATCH -next] can: grcan: use devm_platform_ioremap_resource() to
 simplify code
References: <20190930094909.49672-1-yuehaibing@huawei.com>
In-Reply-To: <20190930094909.49672-1-yuehaibing@huawei.com>

--QQ1lPPiiYZFtK40mmFeyoRHn5nrhJo8IT
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 9/30/19 11:49 AM, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to linux-can-next.

tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--QQ1lPPiiYZFtK40mmFeyoRHn5nrhJo8IT--

--3WVs5nsC4Uhmw7DbaTre7Jg2QUPg5h5fB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2XtV8ACgkQWsYho5Hk
nSBlvgf+NGoVOHjE7fObIou7tepHaBlpOebiZGg2fenrYrKgfpuMrMMeSAxO4K/Q
IDP2zNpdjnMecLKXndEtcNQxlV3q0ISCwlmGIgU3dfSpQBU2OAt2hj37TbvKcnEp
U5+IJ1Gl9Lw6FSM6tEmGDmJnxSVpAyueDCvqZeaLkjxJ+haAThOVldbvLHnBT6yf
FYkgTt08abIP+vna7fz+2ubyrmCdZnk72o8ZyMuorYYYOVwZbJr8pfi8LbpGdrGi
+YDzVCmnmqGcbNETWbGM1kqmtueprgVzjxWFB/qccyM0YrFI/bQ7ql3EBSQlw7eN
9XV9awLHEaDjeIkcJWdkSh7DwniIqQ==
=1Dbe
-----END PGP SIGNATURE-----

--3WVs5nsC4Uhmw7DbaTre7Jg2QUPg5h5fB--
