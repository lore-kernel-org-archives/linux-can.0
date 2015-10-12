From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] can: ti_hecc: Add DT support for TI HECC module
Date: Mon, 12 Oct 2015 11:42:40 +0200
Message-ID: <561B8090.5020908@pengutronix.de>
References: <1443988779-19935-1-git-send-email-anton.a.glukhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="wU3B1KEJU775wXHhXkCueFufLWaDdsXam"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37725 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbbJLJmt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 Oct 2015 05:42:49 -0400
In-Reply-To: <1443988779-19935-1-git-send-email-anton.a.glukhov@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Anton Glukhov <anton.a.glukhov@gmail.com>, linux-can@vger.kernel.org, bcousson@baylibre.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wU3B1KEJU775wXHhXkCueFufLWaDdsXam
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/04/2015 09:59 PM, Anton Glukhov wrote:
> These patch set adds device tree support for TI HECC module.
>=20
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

Have you actually tested to compile without CONFIG_OF? I think the
assignment of "of_match_table =3D ti_hecc_dt_ids" will fail. Please remov=
e
the ifdef here. If it's still possible to compile without CONFIG_OF,
please use of_match_ptr and mark the struct as __maybe_unused.

> +static const struct of_device_id ti_hecc_dt_ids[] =3D {
> +	{
> +		.compatible =3D "ti,am35x-hecc",

AFAIK it's considered best practise not to use a generic name "am35x"
but to add the oldest SoC that support this IP core.

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

bool?

> +		pdata->int_line =3D 0;

This makes no sense, as pdata is initialized as "0" anyways.

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


--wU3B1KEJU775wXHhXkCueFufLWaDdsXam
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWG4CQAAoJEP5prqPJtc/HjU0H/jxbjLOX+Q7w2MQ6LEeKb9D9
yV7yHx6ZG2H89Y7k66W2Uh4Mnnpszxndb/cz+zrJO3RETe5+TqEAFrm9CO87czwB
hBoHbEn/ylPDsLs5LQJcnCo33NJsmcwXnSyVxaxXyiDZUsikHtR7NkSTeODKZRKQ
E9TzxnIoBIwRZuudflpPZoRuRwy0JsSVUwWyFNMH/He4fkXIdhYYfzrJH1kgoSY1
vB0FCNmFGTqsI3d5SwzmLy7np1J8ajVQ3+1dxyt1x32RE/YIuuS/y/Z3B+rd8NKZ
7kCXgHXVcfWb2+hsggjMRicrcxH70GfxiG+w9/YX7xDT/gXq+f6tLS1Bqf7QPNs=
=6e0m
-----END PGP SIGNATURE-----

--wU3B1KEJU775wXHhXkCueFufLWaDdsXam--
