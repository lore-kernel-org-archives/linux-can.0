From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: fix stop mode acknowledgment
Date: Mon, 17 Jun 2019 14:57:31 +0200
Message-ID: <c24b0982-13af-ecdd-c3a2-7ec62863483c@pengutronix.de>
References: <20190611064458.1477-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="cvAjkbgjtIBPFXtwAZGsZw2EolaY2hBIx"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190611064458.1477-1-qiangqing.zhang@nxp.com>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cvAjkbgjtIBPFXtwAZGsZw2EolaY2hBIx
Content-Type: multipart/mixed; boundary="UiByezooILPcSPJ4wew7Ay0aqL1JqGCw1";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "wg@grandegger.com"
 <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <c24b0982-13af-ecdd-c3a2-7ec62863483c@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: fix stop mode acknowledgment
References: <20190611064458.1477-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20190611064458.1477-1-qiangqing.zhang@nxp.com>

--UiByezooILPcSPJ4wew7Ay0aqL1JqGCw1
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 6/11/19 8:47 AM, Joakim Zhang wrote:
> To enter stop mode, the CPU should manually assert a global Stop Mode
> request and check the acknowledgment asserted by FlexCAN. The CPU must
> only consider the FlexCAN in stop mode when both request and
> acknowledgment conditions are satisfied.
>=20
> Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
> Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  drivers/net/can/flexcan.c | 47 ++++++++++++++++++++++++++++++++-------=

>  1 file changed, 39 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index e35083ff31ee..282dac1d8f5c 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -404,9 +404,11 @@ static void flexcan_enable_wakeup_irq(struct flexc=
an_priv *priv, bool enable)
>  	priv->write(reg_mcr, &regs->mcr);
>  }
> =20
> -static inline void flexcan_enter_stop_mode(struct flexcan_priv *priv)
> +static inline int flexcan_enter_stop_mode(struct flexcan_priv *priv)
>  {
>  	struct flexcan_regs __iomem *regs =3D priv->regs;
> +	unsigned int timeout =3D FLEXCAN_TIMEOUT_US / 10;
> +	unsigned int ackval;
>  	u32 reg_mcr;
> =20
>  	reg_mcr =3D priv->read(&regs->mcr);
> @@ -416,20 +418,48 @@ static inline void flexcan_enter_stop_mode(struct=
 flexcan_priv *priv)
>  	/* enable stop request */
>  	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
>  			   1 << priv->stm.req_bit, 1 << priv->stm.req_bit);
> +
> +	/* get stop acknowledgment */
> +	regmap_read(priv->stm.gpr, priv->stm.ack_gpr, &ackval);

Please make use of regmap_read_poll_timeout().

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--UiByezooILPcSPJ4wew7Ay0aqL1JqGCw1--

--cvAjkbgjtIBPFXtwAZGsZw2EolaY2hBIx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl0HjjsACgkQWsYho5Hk
nSAc6Af/SC6IZIEi3x800dtNiFzZK5yxPBNrJYiloomQ0SXnnLugf2+aF3A4xteR
iNYGimTyvKfKYuccbADp9PVhfmvAwoPPssMLMWoThB3yaOyW6EDQz0sx9nvngEQY
u0eWIkmSzFj3fAVeVXpWXUh+40GudQk0gDCPpB05DCOhlS0CRbl91wcUAchSd9rX
zOtt0z08lDcsTgDkqWoP8FULcv56/L9S8gmsg438W0zdHXp71vS3UG3ePl8bvKpD
IQ8I1U/dvZYgFJuaP9/hjiNMDPi64aTfn/h9mUnH6AYIjzgcBuSlVhpny9It0WjJ
gVwAx97DVegOWC51NQxmpEL5vRfg/A==
=5lfw
-----END PGP SIGNATURE-----

--cvAjkbgjtIBPFXtwAZGsZw2EolaY2hBIx--
