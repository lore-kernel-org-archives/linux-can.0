From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] flexcan: add err_irq handler for flexcan
Date: Thu, 19 Jun 2014 10:28:20 +0200
Message-ID: <53A29F24.2050509@pengutronix.de>
References: <1403163973-48239-1-git-send-email-B45475@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HiIp3sK5uMT3pkRAnLvNgr8cToXthlwrF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50544 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757535AbaFSI2i (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Jun 2014 04:28:38 -0400
In-Reply-To: <1403163973-48239-1-git-send-email-B45475@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Zhao Qiang <B45475@freescale.com>, linuxppc-dev@lists.ozlabs.org, linux-can@vger.kernel.org, wg@grandegger.com, B07421@freescale.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HiIp3sK5uMT3pkRAnLvNgr8cToXthlwrF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/19/2014 09:46 AM, Zhao Qiang wrote:
> when flexcan is not physically linked, command 'cantest' will
> trigger an err_irq, add err_irq handler for it.
>=20
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
>  drivers/net/can/flexcan.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index aaed97b..e3c6cfd 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -206,6 +206,7 @@ struct flexcan_priv {
>  	void __iomem *base;
>  	u32 reg_esr;
>  	u32 reg_ctrl_default;
> +	unsigned int	err_irq;

Please use a space instead of a tab before err_irq.

> =20
>  	struct clk *clk_ipg;
>  	struct clk *clk_per;
> @@ -654,6 +655,23 @@ static irqreturn_t flexcan_irq(int irq, void *dev_=
id)
>  	return IRQ_HANDLED;
>  }
> =20
> +static irqreturn_t flexcan_err_irq(int irq, void *dev_id)
> +{
> +	struct net_device *dev =3D dev_id;
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +	struct flexcan_regs __iomem *regs =3D priv->base;
> +	u32 reg_ctrl, reg_esr;
> +
> +	reg_esr =3D flexcan_read(&regs->esr);
> +	reg_ctrl =3D flexcan_read(&regs->ctrl);
> +	if (reg_esr & FLEXCAN_ESR_TX_WRN) {
> +		flexcan_write(reg_esr & ~FLEXCAN_ESR_TX_WRN, &regs->esr);
> +		flexcan_write(reg_ctrl & ~FLEXCAN_CTRL_ERR_MSK, &regs->ctrl);
> +		netdev_err(dev, "No physical link!\n");

A warning IRQ does not imply that you have no physical link. I suggest
to make use of the existing flexcan_poll_state() function.

> +	}
> +	return IRQ_HANDLED;
> +}
> +
>  static void flexcan_set_bittiming(struct net_device *dev)
>  {
>  	const struct flexcan_priv *priv =3D netdev_priv(dev);
> @@ -860,6 +878,12 @@ static int flexcan_open(struct net_device *dev)
>  	if (err)
>  		goto out_close;
> =20
> +	if (priv->err_irq)
> +		err =3D request_irq(priv->err_irq, flexcan_err_irq, IRQF_SHARED,
> +				  dev->name, dev);
> +	if (err)
> +		goto out_close;
> +
>  	/* start chip and queuing */
>  	err =3D flexcan_chip_start(dev);
>  	if (err)
> @@ -1007,7 +1031,7 @@ static int flexcan_probe(struct platform_device *=
pdev)
>  	struct resource *mem;
>  	struct clk *clk_ipg =3D NULL, *clk_per =3D NULL;
>  	void __iomem *base;
> -	int err, irq;
> +	int err, irq, err_irq;
>  	u32 clock_freq =3D 0;
> =20
>  	if (pdev->dev.of_node)
> @@ -1034,6 +1058,10 @@ static int flexcan_probe(struct platform_device =
*pdev)
>  	if (irq <=3D 0)
>  		return -ENODEV;
> =20
> +	err_irq =3D platform_get_irq(pdev, 1);
> +	if (err_irq <=3D 0)
> +		err_irq =3D 0;
> +
>  	base =3D devm_ioremap_resource(&pdev->dev, mem);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> @@ -1057,6 +1085,7 @@ static int flexcan_probe(struct platform_device *=
pdev)
>  	dev->flags |=3D IFF_ECHO;
> =20
>  	priv =3D netdev_priv(dev);
> +	priv->err_irq =3D err_irq;
>  	priv->can.clock.freq =3D clock_freq;
>  	priv->can.bittiming_const =3D &flexcan_bittiming_const;
>  	priv->can.do_set_mode =3D flexcan_set_mode;
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--HiIp3sK5uMT3pkRAnLvNgr8cToXthlwrF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOinycACgkQjTAFq1RaXHPw9gCgipHbnFavmanET3XOt3QkGl0Z
fX4AniLy53jyQS+irNYAiTNwoQ2Vqgek
=IDuR
-----END PGP SIGNATURE-----

--HiIp3sK5uMT3pkRAnLvNgr8cToXthlwrF--
