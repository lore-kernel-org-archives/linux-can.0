From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: add PM support
Date: Tue, 08 May 2012 17:18:34 +0200
Message-ID: <4FA9394A.90303@pengutronix.de>
References: <1336489937-29645-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF503079A761B24D5AA0D5D6D"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44593 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755671Ab2EHPSo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 May 2012 11:18:44 -0400
In-Reply-To: <1336489937-29645-1-git-send-email-eric@eukrea.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>
Cc: linux-can@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF503079A761B24D5AA0D5D6D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2012 05:12 PM, Eric B=C3=A9nard wrote:
> tested on an i.MX257

What about the transceiver? Does is make sense to switch it off, too?

Marc

> Signed-off-by: Eric B=C3=A9nard <eric@eukrea.com>
> ---
>  drivers/net/can/flexcan.c |   38 +++++++++++++++++++++++++++++++++++++=
+
>  1 files changed, 38 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 1efb083..0d058b0 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -1050,6 +1050,42 @@ static struct of_device_id flexcan_of_match[] =3D=
 {
>  	{},
>  };
> =20
> +#ifdef CONFIG_PM
> +static int flexcan_suspend(struct platform_device *pdev, pm_message_t =
state)
> +{
> +	struct net_device *dev =3D platform_get_drvdata(pdev);
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +
> +	flexcan_chip_disable(priv);
> +
> +	if (netif_running(dev)) {
> +		netif_stop_queue(dev);
> +		netif_device_detach(dev);
> +	}
> +	priv->can.state =3D CAN_STATE_SLEEPING;
> +
> +	return 0;
> +}
> +
> +static int flexcan_resume(struct platform_device *pdev)
> +{
> +	struct net_device *dev =3D platform_get_drvdata(pdev);
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +
> +	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +	if (netif_running(dev)) {
> +		netif_device_attach(dev);
> +		netif_start_queue(dev);
> +	}
> +	flexcan_chip_enable(priv);
> +
> +	return 0;
> +}
> +#else
> +#define flexcan_suspend NULL
> +#define flexcan_resume NULL
> +#endif
> +
>  static struct platform_driver flexcan_driver =3D {
>  	.driver =3D {
>  		.name =3D DRV_NAME,
> @@ -1058,6 +1094,8 @@ static struct platform_driver flexcan_driver =3D =
{
>  	},
>  	.probe =3D flexcan_probe,
>  	.remove =3D __devexit_p(flexcan_remove),
> +	.suspend =3D flexcan_suspend,
> +	.resume =3D flexcan_resume,
>  };
> =20
>  module_platform_driver(flexcan_driver);


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigF503079A761B24D5AA0D5D6D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+pOU8ACgkQjTAFq1RaXHP7NACgk+R6j6F4UfyCYZlQR9lSPZuY
tSsAnA7lymjPYTjP/F1Z/DJQsksZluhn
=EYhA
-----END PGP SIGNATURE-----

--------------enigF503079A761B24D5AA0D5D6D--
