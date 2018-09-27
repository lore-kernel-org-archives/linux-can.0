From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH net-next] can: xilinx: fix return type of ndo_start_xmit
 function
Date: Thu, 27 Sep 2018 10:58:37 +0200
Message-ID: <b364d678-98ea-2822-624d-3d65cccfc386@pengutronix.de>
References: <20180926103229.13204-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="etIPrS7ePKkPT95zhIwNnsgLGnVR6CKgb"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926103229.13204-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net, wg@grandegger.com, michal.simek@xilinx.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--etIPrS7ePKkPT95zhIwNnsgLGnVR6CKgb
Content-Type: multipart/mixed; boundary="gL8wFpgAPHrRfSYD6YAmIahW2lVVA9IzS";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net,
 wg@grandegger.com, michal.simek@xilinx.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <b364d678-98ea-2822-624d-3d65cccfc386@pengutronix.de>
Subject: Re: [PATCH net-next] can: xilinx: fix return type of ndo_start_xmit
 function
References: <20180926103229.13204-1-yuehaibing@huawei.com>
In-Reply-To: <20180926103229.13204-1-yuehaibing@huawei.com>

--gL8wFpgAPHrRfSYD6YAmIahW2lVVA9IzS
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 09/26/2018 12:32 PM, YueHaibing wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, so make sure the implementation in=

> this driver has returns 'netdev_tx_t' value, and change the function
> return type to netdev_tx_t.
>=20
> Found by coccinelle.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

applied to can-next.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--gL8wFpgAPHrRfSYD6YAmIahW2lVVA9IzS--

--etIPrS7ePKkPT95zhIwNnsgLGnVR6CKgb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlusm70ACgkQk9IU1zQo
ZfH1YAf7BNtGXD8lZ3bkheKFgFtccVKqERrBKMQuP9yn8k2CwJWIp+cC1e1ZzwY8
63eUcLrYv3uNwvItM/iBydCpmM1KVz4YlTtYEPDOi0RfX0kb6DMC0ms0KMO3CKBe
TmSX52gU6Ht31hvztG1fO6qcx65EByczUk67l4Gq0PR2BQ/gr2hijv5/yuD3H6zh
k3vwNQhCr3bR/RvFM1BSoTFEyvdmss9vf/V8z/zT9T3Ur31d8en+7Gh3YuhT9dMx
FzOYvQ13WzaaIN8JNkJaoL2EJp2G2G8MmNrhaOP8Mw+WddS7u1bJQsfAyOZUieeA
XbfGCe/dg66YmoJ0NiYHBfxXe8yv3Q==
=zier
-----END PGP SIGNATURE-----

--etIPrS7ePKkPT95zhIwNnsgLGnVR6CKgb--
