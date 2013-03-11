From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: at91_can: add dt support
Date: Mon, 11 Mar 2013 18:32:19 +0100
Message-ID: <513E1523.4010803@pengutronix.de>
References: <1363022764-7647-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2TSWAPBVOXIMCEXTTRXNJ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34341 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319Ab3CKRch (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 11 Mar 2013 13:32:37 -0400
In-Reply-To: <1363022764-7647-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: ludovic.desroches@atmel.com
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2TSWAPBVOXIMCEXTTRXNJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/11/2013 06:26 PM, ludovic.desroches@atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>=20
> Add device tree support.
>=20
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
> Changes in v2:
> - code cleanup
> - correct typo
>=20
>  .../devicetree/bindings/net/can/atmel-can.txt      | 14 ++++
>  drivers/net/can/at91_can.c                         | 74 ++++++++++++++=
++------
>  2 files changed, 69 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/can/atmel-can=
=2Etxt
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/atmel-can.txt b/=
Documentation/devicetree/bindings/net/can/atmel-can.txt
> new file mode 100644
> index 0000000..72cf0c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/atmel-can.txt
> @@ -0,0 +1,14 @@
> +* AT91 CAN *
> +
> +Required properties:
> +  - compatible: Should be "atmel,at91sam9263-can" or "atmel,at91sam9x5=
-can"
> +  - reg: Should contain CAN controller registers location and length
> +  - interrupts: Should contain IRQ line for the CAN controller
> +
> +Example:
> +
> +	can0: can@f000c000 {
> +		compatbile =3D "atmel,at91sam9x5-can";
> +		reg =3D <0xf000c000 0x300>;
> +		interrupts =3D <40 4 5>
> +	};
> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> index 44f3637..8c113f5 100644
> --- a/drivers/net/can/at91_can.c
> +++ b/drivers/net/can/at91_can.c
> @@ -27,6 +27,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/skbuff.h>
> @@ -155,19 +156,20 @@ struct at91_priv {
>  	canid_t mb0_id;
>  };
> =20
> -static const struct at91_devtype_data at91_devtype_data[] =3D {
> -	[AT91_DEVTYPE_SAM9263] =3D {
> -		.rx_first =3D 1,
> -		.rx_split =3D 8,
> -		.rx_last =3D 11,
> -		.tx_shift =3D 2,
> -	},
> -	[AT91_DEVTYPE_SAM9X5] =3D {
> -		.rx_first =3D 0,
> -		.rx_split =3D 4,
> -		.rx_last =3D 5,
> -		.tx_shift =3D 1,
> -	},
> +static struct at91_devtype_data at91_at91sam9263_data =3D {
> +	.rx_first =3D 1,
> +	.rx_split =3D 8,
> +	.rx_last =3D 11,
> +	.tx_shift =3D 2,
> +	.type =3D AT91_DEVTYPE_SAM9263,
> +};
> +
> +static struct at91_devtype_data at91_at91sam9x5_data =3D {
> +	.rx_first =3D 0,
> +	.rx_split =3D 4,
> +	.rx_last =3D 5,
> +	.tx_shift =3D 1,
> +	.type =3D AT91_DEVTYPE_SAM9X5,
>  };
> =20
>  static const struct can_bittiming_const at91_bittiming_const =3D {
> @@ -1249,10 +1251,40 @@ static struct attribute_group at91_sysfs_attr_g=
roup =3D {
>  	.attrs =3D at91_sysfs_attrs,
>  };
> =20
> +#if defined(CONFIG_OF)
> +static const struct of_device_id at91_can_dt_ids[] =3D {
> +	{
> +		.compatible =3D "atmel,at91sam9x5-can",
> +		.data =3D &at91_at91sam9x5_data,
> +	}, {
> +		.compatible =3D "atmel,at91sam9263-can",
> +		.data =3D &at91_at91sam9263_data,
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(of, at91_can_dt_ids);
> +#else
> +#define at91_can_dt_ids NULL
> +#endif
> +
> +static struct at91_devtype_data* at91_can_get_driver_data(struct platf=
orm_device *pdev)
> +{
> +	if (pdev->dev.of_node) {
> +		const struct of_device_id *match;
> +		match =3D of_match_node(at91_can_dt_ids, pdev->dev.of_node);
> +		if (!match) {
> +			dev_err(&pdev->dev, "no matching node found in dtb\n");
> +			return NULL;
> +		}
> +		return (struct at91_devtype_data *)match->data;
> +	}
> +	return (struct at91_devtype_data *)platform_get_device_id(pdev)->driv=
er_data;
> +}
> +
>  static int at91_can_probe(struct platform_device *pdev)
>  {
>  	const struct at91_devtype_data *devtype_data;
> -	enum at91_devtype devtype;
>  	struct net_device *dev;
>  	struct at91_priv *priv;
>  	struct resource *res;
> @@ -1260,8 +1292,12 @@ static int at91_can_probe(struct platform_device=
 *pdev)
>  	void __iomem *addr;
>  	int err, irq;
> =20
> -	devtype =3D pdev->id_entry->driver_data;
> -	devtype_data =3D &at91_devtype_data[devtype];
> +	devtype_data =3D at91_can_get_driver_data(pdev);
> +	if (!devtype_data) {
> +		dev_err(&pdev->dev, "no driver data\n");
> +		err =3D -ENODEV;
> +		goto exit;
> +	}
> =20
>  	clk =3D clk_get(&pdev->dev, "can_clk");
>  	if (IS_ERR(clk)) {
> @@ -1310,7 +1346,6 @@ static int at91_can_probe(struct platform_device =
*pdev)
>  	priv->dev =3D dev;
>  	priv->reg_base =3D addr;
>  	priv->devtype_data =3D *devtype_data;
> -	priv->devtype_data.type =3D devtype;
>  	priv->clk =3D clk;
>  	priv->pdata =3D pdev->dev.platform_data;
>  	priv->mb0_id =3D 0x7ff;
> @@ -1373,10 +1408,10 @@ static int at91_can_remove(struct platform_devi=
ce *pdev)
>  static const struct platform_device_id at91_can_id_table[] =3D {
>  	{
>  		.name =3D "at91_can",
> -		.driver_data =3D AT91_DEVTYPE_SAM9263,
> +		.driver_data =3D (unsigned long)&at91_at91sam9x5_data,
>  	}, {
>  		.name =3D "at91sam9x5_can",
> -		.driver_data =3D AT91_DEVTYPE_SAM9X5,
> +		.driver_data =3D (unsigned long)&at91_at91sam9263_data,

It's a kernel_ulong_t, not a (unsigned long), I can fix this while
applying the patch.

>  	}, {
>  		/* sentinel */
>  	}
> @@ -1389,6 +1424,7 @@ static struct platform_driver at91_can_driver =3D=
 {
>  	.driver =3D {
>  		.name =3D KBUILD_MODNAME,
>  		.owner =3D THIS_MODULE,
> +		.of_match_table =3D at91_can_dt_ids,
>  	},
>  	.id_table =3D at91_can_id_table,
>  };
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2TSWAPBVOXIMCEXTTRXNJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE+FScACgkQjTAFq1RaXHPPJACePULKPaFP+z8QOsMAP0IyF2IA
fXAAn3WKb4Vel95429RKYL1RzrHxNwZ8
=fozP
-----END PGP SIGNATURE-----

------enig2TSWAPBVOXIMCEXTTRXNJ--
