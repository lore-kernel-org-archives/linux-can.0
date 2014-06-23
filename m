From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 1/2] flexcan: add err_irq handler for flexcan
Date: Mon, 23 Jun 2014 09:17:43 +0200
Message-ID: <53A7D497.7080806@pengutronix.de>
References: <1403507484-46547-1-git-send-email-B45475@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VwKANIDswCNP4sgfF0iBKtq7p1UulWGcl"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45987 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbaFWHRy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Jun 2014 03:17:54 -0400
In-Reply-To: <1403507484-46547-1-git-send-email-B45475@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Zhao Qiang <B45475@freescale.com>, linuxppc-dev@lists.ozlabs.org, linux-can@vger.kernel.org, wg@grandegger.com, B07421@freescale.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VwKANIDswCNP4sgfF0iBKtq7p1UulWGcl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/23/2014 09:11 AM, Zhao Qiang wrote:
> when flexcan is not physically linked, command 'cantest' will
> trigger an err_irq, add err_irq handler for it.
>=20
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
> Changes for v2:
> 	- use a space instead of tab
> 	- use flexcan_poll_state instead of print
> Changes for v3:
> 	- return IRQ_HANDLED if err is triggered
> 	- stop transmitted packets when there is an err_interrupt=20
>=20
>  drivers/net/can/flexcan.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index f425ec2..6802a25 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -208,6 +208,7 @@ struct flexcan_priv {
>  	void __iomem *base;
>  	u32 reg_esr;
>  	u32 reg_ctrl_default;
> +	unsigned int err_irq;
> =20
>  	struct clk *clk_ipg;
>  	struct clk *clk_per;
> @@ -744,6 +745,24 @@ static irqreturn_t flexcan_irq(int irq, void *dev_=
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

When does the hardware trigger the interrupt?

> +		flexcan_write(reg_esr & ~FLEXCAN_ESR_TX_WRN, &regs->esr);
> +		flexcan_write(reg_ctrl & ~FLEXCAN_CTRL_ERR_MSK, &regs->ctrl);
> +		netif_stop_queue(dev);

Why are you stopping the txqueue?

> +		return IRQ_HANDLED;
> +	}
> +	return IRQ_NONE;
> +}
> +

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--VwKANIDswCNP4sgfF0iBKtq7p1UulWGcl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOn1JcACgkQjTAFq1RaXHOXqACdGiFYP77jm6Icc1lq+0Nqdxvr
EdsAnirWAeoICTFxVv18kkY5U+xjsiWT
=F9Dj
-----END PGP SIGNATURE-----

--VwKANIDswCNP4sgfF0iBKtq7p1UulWGcl--
