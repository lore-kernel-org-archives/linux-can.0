From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V2 3/4] can: flexcan: change the way of stop mode
 acknowledgment
Date: Tue, 3 Dec 2019 19:21:36 +0100
Message-ID: <8795fcdb-d102-758d-6257-ffcd05108715@pengutronix.de>
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-4-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2Ob8pop3426oy7nhLxm2NZsQ1tGt7oV71"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191127055334.1476-4-qiangqing.zhang@nxp.com>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com" <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2Ob8pop3426oy7nhLxm2NZsQ1tGt7oV71
Content-Type: multipart/mixed; boundary="0dKgauQox5wbWHudvwt0wwiXJLKXq2Iv5";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com"
 <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <8795fcdb-d102-758d-6257-ffcd05108715@pengutronix.de>
Subject: Re: [PATCH V2 3/4] can: flexcan: change the way of stop mode
 acknowledgment
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-4-qiangqing.zhang@nxp.com>
In-Reply-To: <20191127055334.1476-4-qiangqing.zhang@nxp.com>

--0dKgauQox5wbWHudvwt0wwiXJLKXq2Iv5
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/27/19 6:56 AM, Joakim Zhang wrote:
> Stop mode is entered when Stop mode is requested at chip level and
> MCR[LPM_ACK] is asserted by the FlexCAN.
>=20
> Double check with IP owner, should poll MCR[LPM_ACK] for stop mode
> acknowledgment, not the acknowledgment from chip level which is used
> for glitch filter.
>=20
> Fixes: 5f186c257fa4(can: flexcan: fix stop mode acknowledgment)
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ------
> ChangeLog:
> 	V1->V2: no change.
> ---
>  drivers/net/can/flexcan.c | 64 ++++++++++++++++++++-------------------=

>  1 file changed, 33 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 5d5ed28d3005..d178146b3da5 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -388,6 +388,34 @@ static struct flexcan_mb __iomem *flexcan_get_mb(c=
onst struct flexcan_priv *priv
>  		(&priv->regs->mb[bank][priv->mb_size * mb_index]);
>  }
> =20
> +static int flexcan_enter_low_power_ack(struct flexcan_priv *priv)

nitpick: please call this flexcan_low_power_enter_ack()
> +{
> +	struct flexcan_regs __iomem *regs =3D priv->regs;
> +	unsigned int timeout =3D FLEXCAN_TIMEOUT_US / 10;
> +
> +	while (timeout-- && !(priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
> +		udelay(10);
> +
> +	if (!(priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static int flexcan_exit_low_power_ack(struct flexcan_priv *priv)

=2E..and this one flexcan_low_power_exit_ack()

> +{
> +	struct flexcan_regs __iomem *regs =3D priv->regs;
> +	unsigned int timeout =3D FLEXCAN_TIMEOUT_US / 10;
> +
> +	while (timeout-- && (priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
> +		udelay(10);
> +
> +	if (priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}

Can you move split the creation of
flexcan_low_power_enter_ack()/flexcan_low_power_exit_ack() and use in
flexcan_chip_enable/disable() into one patch and the conversion of
flexcan_enter_stop_mode()/flexcan_exit_stop_mode() into another.

Marc

> +
>  static void flexcan_enable_wakeup_irq(struct flexcan_priv *priv, bool =
enable)
>  {
>  	struct flexcan_regs __iomem *regs =3D priv->regs;
> @@ -406,7 +434,6 @@ static void flexcan_enable_wakeup_irq(struct flexca=
n_priv *priv, bool enable)
>  static inline int flexcan_enter_stop_mode(struct flexcan_priv *priv)
>  {
>  	struct flexcan_regs __iomem *regs =3D priv->regs;
> -	unsigned int ackval;
>  	u32 reg_mcr;
> =20
>  	reg_mcr =3D priv->read(&regs->mcr);
> @@ -418,35 +445,24 @@ static inline int flexcan_enter_stop_mode(struct =
flexcan_priv *priv)
>  			   1 << priv->stm.req_bit, 1 << priv->stm.req_bit);
> =20
>  	/* get stop acknowledgment */
> -	if (regmap_read_poll_timeout(priv->stm.gpr, priv->stm.ack_gpr,
> -				     ackval, ackval & (1 << priv->stm.ack_bit),
> -				     0, FLEXCAN_TIMEOUT_US))
> -		return -ETIMEDOUT;
> -
> -	return 0;
> +	return flexcan_enter_low_power_ack(priv);
>  }
> =20
>  static inline int flexcan_exit_stop_mode(struct flexcan_priv *priv)
>  {
>  	struct flexcan_regs __iomem *regs =3D priv->regs;
> -	unsigned int ackval;
>  	u32 reg_mcr;
> =20
>  	/* remove stop request */
>  	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
>  			   1 << priv->stm.req_bit, 0);
> =20
> -	/* get stop acknowledgment */
> -	if (regmap_read_poll_timeout(priv->stm.gpr, priv->stm.ack_gpr,
> -				     ackval, !(ackval & (1 << priv->stm.ack_bit)),
> -				     0, FLEXCAN_TIMEOUT_US))
> -		return -ETIMEDOUT;
> -
>  	reg_mcr =3D priv->read(&regs->mcr);
>  	reg_mcr &=3D ~FLEXCAN_MCR_SLF_WAK;
>  	priv->write(reg_mcr, &regs->mcr);
> =20
> -	return 0;
> +	/* get stop acknowledgment */
> +	return flexcan_exit_low_power_ack(priv);
>  }
> =20
>  static void flexcan_try_exit_stop_mode(struct flexcan_priv *priv)
> @@ -512,39 +528,25 @@ static inline int flexcan_transceiver_disable(con=
st struct flexcan_priv *priv)
>  static int flexcan_chip_enable(struct flexcan_priv *priv)
>  {
>  	struct flexcan_regs __iomem *regs =3D priv->regs;
> -	unsigned int timeout =3D FLEXCAN_TIMEOUT_US / 10;
>  	u32 reg;
> =20
>  	reg =3D priv->read(&regs->mcr);
>  	reg &=3D ~FLEXCAN_MCR_MDIS;
>  	priv->write(reg, &regs->mcr);
> =20
> -	while (timeout-- && (priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
> -		udelay(10);
> -
> -	if (priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK)
> -		return -ETIMEDOUT;
> -
> -	return 0;
> +	return flexcan_exit_low_power_ack(priv);
>  }
> =20
>  static int flexcan_chip_disable(struct flexcan_priv *priv)
>  {
>  	struct flexcan_regs __iomem *regs =3D priv->regs;
> -	unsigned int timeout =3D FLEXCAN_TIMEOUT_US / 10;
>  	u32 reg;
> =20
>  	reg =3D priv->read(&regs->mcr);
>  	reg |=3D FLEXCAN_MCR_MDIS;
>  	priv->write(reg, &regs->mcr);
> =20
> -	while (timeout-- && !(priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
> -		udelay(10);
> -
> -	if (!(priv->read(&regs->mcr) & FLEXCAN_MCR_LPM_ACK))
> -		return -ETIMEDOUT;
> -
> -	return 0;
> +	return flexcan_enter_low_power_ack(priv);
>  }
> =20
>  static int flexcan_chip_freeze(struct flexcan_priv *priv)
>=20


--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--0dKgauQox5wbWHudvwt0wwiXJLKXq2Iv5--

--2Ob8pop3426oy7nhLxm2NZsQ1tGt7oV71
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3mp7AACgkQWsYho5Hk
nSBRMQf/fIElqnTsXHrm17GDRyQ2uUqFDG0aosj4xTj2Twz1v9E0NJd3KJR5LKmA
wdi527vCf3hL//OI2GapaE3AeZb754VhjMiOhGVsPeTepRVqGX7TEZAqILxwjH6z
9J4+6b+/4OMq6eP5tBdjy46G1pNuAfVFugnW60DTcrgSpxpaUyCBcubOHG0tq9UU
vckjnHigFSkWKu8jg8s7uCGn/KZgdAeU6kPv9PP0OBsKeZ30Jk4XGjjIZNPrClTr
yVzsP6PPGI+jgBuBG0sY8F9GVUQuvv23zsLEyrnPijUjSZvRJfbODkDn3xWGxoEO
3TEiCN7JMxvpswKbr3U9M/KQOgTeNw==
=IGww
-----END PGP SIGNATURE-----

--2Ob8pop3426oy7nhLxm2NZsQ1tGt7oV71--
