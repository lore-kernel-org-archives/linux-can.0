From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH net-next] can: dev: use skb_put_zero to simplfy code
Date: Sun, 29 Apr 2018 18:24:19 +0200
Message-ID: <0f0a2623-da07-d102-8bed-d2034c41520a@pengutronix.de>
References: <20180428074957.17084-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="h7VF7kDEiHZCpqK4hmtA9O6mLmnTRpLUk"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180428074957.17084-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, wg@grandegger.com
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h7VF7kDEiHZCpqK4hmtA9O6mLmnTRpLUk
Content-Type: multipart/mixed; boundary="ZT4sclf9KRnlyTZZdDcm5VvmZvDJrrFkk";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: YueHaibing <yuehaibing@huawei.com>, wg@grandegger.com
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org
Message-ID: <0f0a2623-da07-d102-8bed-d2034c41520a@pengutronix.de>
Subject: Re: [PATCH net-next] can: dev: use skb_put_zero to simplfy code
References: <20180428074957.17084-1-yuehaibing@huawei.com>
In-Reply-To: <20180428074957.17084-1-yuehaibing@huawei.com>

--ZT4sclf9KRnlyTZZdDcm5VvmZvDJrrFkk
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 04/28/2018 09:49 AM, YueHaibing wrote:
> use helper skb_put_zero to replace the pattern of skb_put() && memset()=

>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to linux-can-next.

Tnx,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ZT4sclf9KRnlyTZZdDcm5VvmZvDJrrFkk--

--h7VF7kDEiHZCpqK4hmtA9O6mLmnTRpLUk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlrl8bMACgkQk9IU1zQo
ZfGfIAgAw59vA9/t8GsiIehpDjmL+RTT9WQpYqLCQZSnWkYfV1YZ1OiHpbKiPUrI
+F+mxDzMPrjQE1Z+uxSzvjxUmdKq2EcEek0zgNetd+kLjzJnifeVCt2dH8/pdtNY
fmObXrvvV4xXMf10EBo44CQo7PYpBi2VE0nUVrqSd3PhVMpnV5l6LEkb+7inyftH
KLqC/kZsOqT4aj+fFYkMycExqoPT7c0ud+zr4jvqsavRwOZNm62t6gZgMRQPfW1M
V3vXDv+aG6UlzCqZu634Eujb55yhHZEgIBRRUDekzGo/3AI+ZzDEatIK+sWNSNvs
3+Rsv2r9J+cfQUFfGdp72bsc3vhpVg==
=bZ5U
-----END PGP SIGNATURE-----

--h7VF7kDEiHZCpqK4hmtA9O6mLmnTRpLUk--
