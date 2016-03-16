From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] can: ti_hecc: Add DT support for TI HECC module
Date: Wed, 16 Mar 2016 11:53:22 +0100
Message-ID: <56E93B22.8010602@pengutronix.de>
References: <1443988779-19935-1-git-send-email-anton.a.glukhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="KR4LchiPjSEUUe0tMvrmiUvnaPIWXarHR"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54622 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753642AbcCPKxa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 16 Mar 2016 06:53:30 -0400
In-Reply-To: <1443988779-19935-1-git-send-email-anton.a.glukhov@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Anton Glukhov <anton.a.glukhov@gmail.com>, linux-can@vger.kernel.org, bcousson@baylibre.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KR4LchiPjSEUUe0tMvrmiUvnaPIWXarHR
Content-Type: multipart/mixed; boundary="JN5iIfS8aNqstrDkCtcfHpt1L07mL3BvE"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Anton Glukhov <anton.a.glukhov@gmail.com>, linux-can@vger.kernel.org,
 bcousson@baylibre.com
Message-ID: <56E93B22.8010602@pengutronix.de>
Subject: Re: [PATCH 1/3] can: ti_hecc: Add DT support for TI HECC module
References: <1443988779-19935-1-git-send-email-anton.a.glukhov@gmail.com>
In-Reply-To: <1443988779-19935-1-git-send-email-anton.a.glukhov@gmail.com>

--JN5iIfS8aNqstrDkCtcfHpt1L07mL3BvE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

just stumbled over these patches.

On 10/04/2015 09:59 PM, Anton Glukhov wrote:
> These patch set adds device tree support for TI HECC module.


> Signed-off-by: Anton Glukhov <anton.a.glukhov@gmail.com>
> ---
>  drivers/net/can/ti_hecc.c | 56 +++++++++++++++++++++++++++++++++++++++=
++++----
>  1 file changed, 52 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
> index cf345cb..c1a89fd 100644
> --- a/drivers/net/can/ti_hecc.c
> +++ b/drivers/net/can/ti_hecc.c
> @@ -46,6 +46,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> =20
>  #include <linux/can/dev.h>
>  #include <linux/can/error.h>
> @@ -875,19 +877,64 @@ static const struct net_device_ops ti_hecc_netdev=
_ops =3D {
>  	.ndo_change_mtu		=3D can_change_mtu,
>  };
> =20
> +#if defined(CONFIG_OF)

please remove the ifdef

> +static const struct of_device_id ti_hecc_dt_ids[] =3D {
> +	{
> +		.compatible =3D "ti,am35x-hecc",
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ti_hecc_dt_ids);
> +#endif
> +
> +static struct ti_hecc_platform_data *hecc_parse_dt(struct device *dev)=

> +{
> +	struct ti_hecc_platform_data *pdata;
> +	struct device_node *np =3D dev->of_node;
> +
> +	pdata =3D devm_kzalloc(dev, sizeof(struct ti_hecc_platform_data), GFP=
_KERNEL);

Please don't allocate pdata - better create two functions, one parsing
the pdata and one parse the dt.

> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (of_property_read_u32(np, "ti,scc-ram-offset", &pdata->scc_ram_off=
set)) {
> +		dev_err(dev, "Missing scc-ram-offset property in the DT.\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (of_property_read_u32(np, "ti,hecc-ram-offset", &pdata->hecc_ram_o=
ffset)) {
> +		dev_err(dev, "Missing hecc-ram-offset property in the DT.\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +	if (of_property_read_u32(np, "ti,mbx-offset", &pdata->mbx_offset)) {
> +		dev_err(dev, "Missing mbx-offset property in the DT.\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +	if (of_property_read_u32(dev->of_node, "ti,int-line", &pdata->int_lin=
e)) {
> +		pdata->int_line =3D 0;
> +	}
> +
> +	return pdata;
> +}
> +
>  static int ti_hecc_probe(struct platform_device *pdev)
>  {
>  	struct net_device *ndev =3D (struct net_device *)0;
>  	struct ti_hecc_priv *priv;
> -	struct ti_hecc_platform_data *pdata;
> +	struct ti_hecc_platform_data *pdata =3D dev_get_platdata(&pdev->dev);=

> +	struct device_node *np =3D pdev->dev.of_node;
>  	struct resource *mem, *irq;
>  	void __iomem *addr;
>  	int err =3D -ENODEV;
> =20
> -	pdata =3D dev_get_platdata(&pdev->dev);
> +	if (!pdata && np) {
> +		pdata =3D hecc_parse_dt(&pdev->dev);
> +		if (IS_ERR(pdata))
> +			return PTR_ERR(pdata);
> +	}
> +
>  	if (!pdata) {
> -		dev_err(&pdev->dev, "No platform data\n");
> -		goto probe_exit;
> +		dev_err(&pdev->dev, "Platform data missing\n");
> +		return -EINVAL;
>  	}
> =20
>  	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -1040,6 +1087,7 @@ static int ti_hecc_resume(struct platform_device =
*pdev)
>  static struct platform_driver ti_hecc_driver =3D {
>  	.driver =3D {
>  		.name    =3D DRV_NAME,
> +		.of_match_table =3D ti_hecc_dt_ids,
>  	},
>  	.probe =3D ti_hecc_probe,
>  	.remove =3D ti_hecc_remove,
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--JN5iIfS8aNqstrDkCtcfHpt1L07mL3BvE--

--KR4LchiPjSEUUe0tMvrmiUvnaPIWXarHR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJW6TsiAAoJED07qiWsqSVqxasH/0K51W7xg9iu0wJ31WwCJ2+q
sJqb0Ae7qcSfvuUq8P6i5aRRkCFFQZaGcfYYcfoQEz8TYoAgmJ/xbHvtBq6O6EfR
W0btQzoggyzdtpFRqEJuzKVuzjydkdOzfh8ksYCobHvudLmRPE7Qr53P0ZqwcBEa
mTr89wtmpwE/WEYJjN9uEVTEL2nFX+u4fUUZ0CLR8aZ+LFpruV1V3K5E1rV+aFdV
wfa0/Q9dZx3cEUtKgXzlXAYYtIzghlYdpa2lC85CYpZksRx5NcdOXGdyILRWyBa+
aTCiZece6Jg/1rV4DRkDnnw3qJR/e9ZbV3dUk0YlhpumFBU/yupomN1vroMQhcc=
=Uceq
-----END PGP SIGNATURE-----

--KR4LchiPjSEUUe0tMvrmiUvnaPIWXarHR--
