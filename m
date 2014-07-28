From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V2 4/5] can: flexcan: fix transition from and to freeze
 mode in chip_{,un}freeze
Date: Mon, 28 Jul 2014 08:38:28 +0200
Message-ID: <53D5EFE4.8060308@pengutronix.de>
References: <1406529268-20126-1-git-send-email-matthias.klein@optimeas.de> <1406529268-20126-4-git-send-email-matthias.klein@optimeas.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ApGxuBvpTJgFN3V2dEbQFi3oiCAp17ooh"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39237 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbaG1Giq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Jul 2014 02:38:46 -0400
In-Reply-To: <1406529268-20126-4-git-send-email-matthias.klein@optimeas.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Matthias Klein <matthias.klein@optimeas.de>, wg@grandegger.com, linux-can@vger.kernel.org, support@karo-electronics.de
Cc: bigeasy@linutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ApGxuBvpTJgFN3V2dEbQFi3oiCAp17ooh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2014 08:34 AM, Matthias Klein wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> This patch factors out freeze and unfreeze of the CAN core into seperat=
e
> functions. Experiments have shown that the transition from and to freez=
e mode
> may take several microseconds, especially the time entering the freeze =
mode
> depends on the current bitrate.
>=20
> This patch adds a while loop which polls the Freeze Mode ACK bit (FRZ_A=
CK) that
> indicates a successfull mode change. If the function runs into a timeou=
t a
> error value is returned.
>=20
> Cc: linux-stable <stable@vger.kernel.org>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Matthias Klein <matthias.klein@optimeas.de>

This patch is already mainline, please make your series based on the
latest net-next/master tree.

Marc

> ---
>  drivers/net/can/flexcan.c | 60 ++++++++++++++++++++++++++++++++++++++-=
--------
>  1 file changed, 49 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index f6f95ae..b77f1da 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -322,6 +322,44 @@ static int flexcan_chip_disable(struct flexcan_pri=
v *priv)
>  	return 0;
>  }
> =20
> +static int flexcan_chip_freeze(struct flexcan_priv *priv)
> +{
> +	struct flexcan_regs __iomem *regs =3D priv->base;
> +	unsigned int timeout =3D 1000 * 1000 * 10 / priv->can.bittiming.bitra=
te;
> +	u32 reg;
> +
> +	reg =3D flexcan_read(&regs->mcr);
> +	reg |=3D FLEXCAN_MCR_HALT;
> +	flexcan_write(reg, &regs->mcr);
> +
> +	while (timeout-- && !(flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK)=
)
> +		usleep_range(100, 200);
> +
> +	if (!(flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static int flexcan_chip_unfreeze(struct flexcan_priv *priv)
> +{
> +	struct flexcan_regs __iomem *regs =3D priv->base;
> +	unsigned int timeout =3D FLEXCAN_TIMEOUT_US / 10;
> +	u32 reg;
> +
> +	reg =3D flexcan_read(&regs->mcr);
> +	reg &=3D ~FLEXCAN_MCR_HALT;
> +	flexcan_write(reg, &regs->mcr);
> +
> +	while (timeout-- && (flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK))=

> +		usleep_range(10, 20);
> +
> +	if (flexcan_read(&regs->mcr) & FLEXCAN_MCR_FRZ_ACK)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
>  static int flexcan_get_berr_counter(const struct net_device *dev,
>  				    struct can_berr_counter *bec)
>  {
> @@ -776,7 +814,7 @@ static int flexcan_chip_start(struct net_device *de=
v)
>  		netdev_err(dev, "Failed to softreset can module (mcr=3D0x%08x)\n",
>  			   reg_mcr);
>  		err =3D -ENODEV;
> -		goto out;
> +		goto out_chip_disable;
>  	}
> =20
>  	flexcan_set_bittiming(dev);
> @@ -846,12 +884,12 @@ static int flexcan_chip_start(struct net_device *=
dev)
> =20
>  	err =3D flexcan_transceiver_enable(priv);
>  	if (err)
> -		goto out;
> +		goto out_chip_disable;
> =20
>  	/* synchronize with the can bus */
> -	reg_mcr =3D flexcan_read(&regs->mcr);
> -	reg_mcr &=3D ~FLEXCAN_MCR_HALT;
> -	flexcan_write(reg_mcr, &regs->mcr);
> +	err =3D flexcan_chip_unfreeze(priv);
> +	if (err)
> +		goto out_transceiver_disable;
> =20
>  	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> =20
> @@ -864,7 +902,9 @@ static int flexcan_chip_start(struct net_device *de=
v)
> =20
>  	return 0;
> =20
> - out:
> + out_transceiver_disable:
> +	flexcan_transceiver_disable(priv);
> + out_chip_disable:
>  	flexcan_chip_disable(priv);
>  	return err;
>  }
> @@ -879,12 +919,10 @@ static void flexcan_chip_stop(struct net_device *=
dev)
>  {
>  	struct flexcan_priv *priv =3D netdev_priv(dev);
>  	struct flexcan_regs __iomem *regs =3D priv->base;
> -	u32 reg;
> =20
> -	/* Disable + halt module */
> -	reg =3D flexcan_read(&regs->mcr);
> -	reg |=3D FLEXCAN_MCR_MDIS | FLEXCAN_MCR_HALT;
> -	flexcan_write(reg, &regs->mcr);
> +	/* freeze + disable module */
> +	flexcan_chip_freeze(priv);
> +	flexcan_chip_disable(priv);
> =20
>  	/* Disable all interrupts */
>  	flexcan_write(0, &regs->imask1);
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ApGxuBvpTJgFN3V2dEbQFi3oiCAp17ooh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPV7+gACgkQjTAFq1RaXHMfyACfTsz3Tuxsp4Cl5Bh9AV3AmeRT
wfoAnRnf4ayxO8c0BwLMIBuPHDSPwe/9
=pxo8
-----END PGP SIGNATURE-----

--ApGxuBvpTJgFN3V2dEbQFi3oiCAp17ooh--
