From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: dev: clean up CAN ctrlmode when close CAN device
Date: Wed, 10 Apr 2019 09:19:02 +0200
Message-ID: <39d8ef33-50c3-9b7a-88e1-8ef3a7fbac70@pengutronix.de>
References: <20190410062533.31535-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="yuYaA4LNFs4dLu7PPGHBRcN4mxJ3VATnB"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190410062533.31535-1-qiangqing.zhang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "davem@davemloft.net" <davem@davemloft.net>
Cc: dl-linux-imx <linux-imx@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yuYaA4LNFs4dLu7PPGHBRcN4mxJ3VATnB
Content-Type: multipart/mixed; boundary="u5NSCvlf1hqqom14kB7IbQaDkoNpzzjQz";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>,
 "wg@grandegger.com" <wg@grandegger.com>,
 "davem@davemloft.net" <davem@davemloft.net>
Cc: dl-linux-imx <linux-imx@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <39d8ef33-50c3-9b7a-88e1-8ef3a7fbac70@pengutronix.de>
Subject: Re: [PATCH] can: dev: clean up CAN ctrlmode when close CAN device
References: <20190410062533.31535-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20190410062533.31535-1-qiangqing.zhang@nxp.com>

--u5NSCvlf1hqqom14kB7IbQaDkoNpzzjQz
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 4/10/19 8:27 AM, Joakim Zhang wrote:
> CAN driver always writes registers according to "ctrlmode", and now CAN=

> framework will keep CAN ctrlmode after device closed.
>=20
> e.g. with following sequences:
> 1)ip link set can0 type can bitrate 1000000 loopback on
> 2)ip link set can0 up
> 3)ip link set can0 down
> 4)ip link set can0 type can bitrate 1000000
> 5)ip link set can0 up
>=20
> After this sequence, we may want to test loopback for the first time an=
d
> not to test loopback second time. However, CAN device still keep
> "ctrlmode" as loopback on.

Then you should configure loopback off in userspace.

> This patch intends to clean up CAN ctrlmode when close CAN device. We
> can set which ctrlmode we need when open CAN device again.

Consider a CANFD device, where CANFD has been enabled. It will feel very
weird if the interface looses the CANFD property by just a ifdown; ifup.

>=20
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  drivers/net/can/dev.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index c05e4d50d43d..4f69a8f16ba3 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -870,6 +870,7 @@ void close_candev(struct net_device *dev)
>  	struct can_priv *priv =3D netdev_priv(dev);
> =20
>  	cancel_delayed_work_sync(&priv->restart_work);
> +	priv->ctrlmode =3D 0;
>  	can_flush_echo_skb(dev);
>  }
>  EXPORT_SYMBOL_GPL(close_candev);
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--u5NSCvlf1hqqom14kB7IbQaDkoNpzzjQz--

--yuYaA4LNFs4dLu7PPGHBRcN4mxJ3VATnB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlytmOYACgkQWsYho5Hk
nSC0pwf+IfMYDBoYWMGGo1TCfFJ1+QS4i4Uy+mJn7O75U2vvzDSWSiQcr+0i6fbx
mxGGpdKvfLSjZRbMbcMrlEDSz+/SMnaVfWapGCZ+ZjWu4TqopbIjkcnP5tjQld/d
XAkhyVRL8zlr4nJQeJbMwKoHP1TUHOIXjDGcKWuaQMiuhbqOz999K5CssYivI3MP
7USy5urt264gphIvPS9T/k7Xl8tL2Mf+MqecYUJIB4MN8dZf8edVClAiK04V8jjj
pi1LmDdbquND/PInJNogEqynoCABL4BI45TS16qcfJlpLHRIhJ3nbBEoVcGbdyVQ
h94tjdWn5P0S/jphUlicISEGGXooQw==
=gEjw
-----END PGP SIGNATURE-----

--yuYaA4LNFs4dLu7PPGHBRcN4mxJ3VATnB--
