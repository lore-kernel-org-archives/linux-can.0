From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: fix timeout when set small bitrate
Date: Thu, 31 Jan 2019 08:34:24 +0100
Message-ID: <1902c81b-86fa-469e-b495-c37dca744cb9@pengutronix.de>
References: <20190131065619.7298-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="iLonVwgznhAG5kZLa30zCunLPJk4hftas"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131065619.7298-1-qiangqing.zhang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iLonVwgznhAG5kZLa30zCunLPJk4hftas
Content-Type: multipart/mixed; boundary="Yppa9ejr8tEgmk3gRDD5A3n1I8iT984sD";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>
Message-ID: <1902c81b-86fa-469e-b495-c37dca744cb9@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: fix timeout when set small bitrate
References: <20190131065619.7298-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20190131065619.7298-1-qiangqing.zhang@nxp.com>

--Yppa9ejr8tEgmk3gRDD5A3n1I8iT984sD
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 1/31/19 7:58 AM, Joakim Zhang wrote:
> From: Dong Aisheng <aisheng.dong@nxp.com>
>=20
> Current we can meet timeout issue when setting a small bitrate
> like 10000 as follows:
> root@imx6qdlsolo:~# ip link set can0 up type can bitrate 10000
> A link change request failed with some changes committed already.
> Interface can0 may have been left with an inconsistent configuration,
> please check.
> RTNETLINK answers: Connection timed out

Which SoC are you using? Which clock rate has the flexcan IP core?

> It is caused by calling of flexcan_chip_unfreeze() timeout.
>=20
> Originally the code is using usleep_range(10, 20) for unfreeze operatio=
n,
> but the patch (8badd65 can: flexcan: avoid calling usleep_range from
> interrupt context) changed it into udelay(10) which is only a half dela=
y
> of before, there're also some other delay changes.
>=20
> After only changed unfreeze delay back to udelay(20), the issue is gone=
=2E
> So other timeout values are kept the same as 8badd65 changed.

Can you change FLEXCAN_TIMEOUT_US instead?

> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  drivers/net/can/flexcan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 2bca867bcfaa..1d3a9053bbeb 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -530,7 +530,7 @@ static int flexcan_chip_unfreeze(struct flexcan_pri=
v *priv)
>  	priv->write(reg, &regs->mcr);
> =20
>  	while (timeout-- && (priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
> -		udelay(10);
> +		udelay(20);
> =20
>  	if (priv->read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK)
>  		return -ETIMEDOUT;
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Yppa9ejr8tEgmk3gRDD5A3n1I8iT984sD--

--iLonVwgznhAG5kZLa30zCunLPJk4hftas
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlxSpQAACgkQk9IU1zQo
ZfEM9wgAlgeJI/sa+IgA/dhYW9a8/YPX9d6CjwiDZaus6Jn/nqQJUlNdrOYjEDQL
oBKXl9cnRhbF3HMBGVGoEuT3IIIZwsNOBroKI0pCyKzKUkqUfJTVQUIiqxBf8spT
b6GsrjCx0CnKo/0plB1NtPT5ZVyvTW8DedUEaKG9iEbZpFzEVHv2KQUJES8eX2Jg
t/vq88ka8VG1F7N5IGjsPfml1g6xTMo5CIF/AW7nLnLJ9c7hnJtWSzfC2YakFSwh
DiidkubLmtV6OVkEqprf8bNSph3PZLit7aHdRmUZN3C5Ozb8/FyZVcSSYL0l5/5Q
ZAj1TZY+ubB07QvO0jsLF1K+fz8Llw==
=rW4Y
-----END PGP SIGNATURE-----

--iLonVwgznhAG5kZLa30zCunLPJk4hftas--
