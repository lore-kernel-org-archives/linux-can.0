From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: Use SIMPLE_DEV_PM_OPS
Date: Mon, 20 May 2013 20:47:08 +0200
Message-ID: <519A6FAC.6080803@pengutronix.de>
References: <1369075423-12792-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2APECXNEEFVNTXDAXDGHG"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52418 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab3ETSrR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 20 May 2013 14:47:17 -0400
In-Reply-To: <1369075423-12792-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2APECXNEEFVNTXDAXDGHG
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/20/2013 08:43 PM, Fabio Estevam wrote:
> Using SIMPLE_DEV_PM_OPS can make the code smaller and simpler.
>    =20
> Also change CONFIG_PM to CONFIG_PM_SLEEP.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/net/can/flexcan.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 4a40a18..d85d9ff 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -1137,10 +1137,10 @@ static int flexcan_remove(struct platform_devic=
e *pdev)
>  	return 0;
>  }
> =20
> -#ifdef CONFIG_PM
> -static int flexcan_suspend(struct platform_device *pdev, pm_message_t =
state)
> +#ifdef CONFIG_PM_SLEEP
> +static int flexcan_suspend(struct device *device)
>  {
> -	struct net_device *dev =3D platform_get_drvdata(pdev);
> +	struct net_device *dev =3D dev_get_drvdata(device);
>  	struct flexcan_priv *priv =3D netdev_priv(dev);
> =20
>  	flexcan_chip_disable(priv);
> @@ -1154,9 +1154,9 @@ static int flexcan_suspend(struct platform_device=
 *pdev, pm_message_t state)
>  	return 0;
>  }
> =20
> -static int flexcan_resume(struct platform_device *pdev)
> +static int flexcan_resume(struct device *device)
>  {
> -	struct net_device *dev =3D platform_get_drvdata(pdev);
> +	struct net_device *dev =3D dev_get_drvdata(device);
>  	struct flexcan_priv *priv =3D netdev_priv(dev);
> =20
>  	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> @@ -1168,21 +1168,19 @@ static int flexcan_resume(struct platform_devic=
e *pdev)
> =20
>  	return 0;
>  }
> -#else
> -#define flexcan_suspend NULL
> -#define flexcan_resume NULL
> -#endif
> +#endif /* CONFIG_PM_SLEEP */
> +
> +static SIMPLE_DEV_PM_OPS(flexcan_pm_ops, flexcan_suspend, flexcan_resu=
me);
> =20
>  static struct platform_driver flexcan_driver =3D {
>  	.driver =3D {
>  		.name =3D DRV_NAME,
>  		.owner =3D THIS_MODULE,
> +		.pm	=3D &flexcan_pm_ops,

Please just indent with one space after ".pm". No need to resend, I'll
fix it while applying it to linux-can-next.

tnx, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2APECXNEEFVNTXDAXDGHG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGab7EACgkQjTAFq1RaXHOIzACgjWqC601jhwrXKbJeakQgLEOg
EV4An0EyLAYCP6b/a9vDMBSlrfKdn9Ma
=FgPD
-----END PGP SIGNATURE-----

------enig2APECXNEEFVNTXDAXDGHG--
