From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] flexcan: Use devm_ioremap_resource()
Date: Mon, 22 Jul 2013 16:53:48 +0200
Message-ID: <51ED477C.5090102@pengutronix.de>
References: <1374502981-16282-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2LVFTMTVKHEJJNJLSFJRP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54258 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320Ab3GVOx6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 22 Jul 2013 10:53:58 -0400
In-Reply-To: <1374502981-16282-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-can@vger.kernel.org, festevam@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2LVFTMTVKHEJJNJLSFJRP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/22/2013 04:23 PM, Fabio Estevam wrote:
> Using devm_ioremap_resource() can make the code simpler and smaller.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/net/can/flexcan.c | 46 +++++++++------------------------------=
-------
>  1 file changed, 9 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 7b0be09..1b07d75 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -1001,7 +1001,6 @@ static int flexcan_probe(struct platform_device *=
pdev)
>  	struct resource *mem;
>  	struct clk *clk_ipg =3D NULL, *clk_per =3D NULL;
>  	void __iomem *base;
> -	resource_size_t mem_size;
>  	int err, irq;
>  	u32 clock_freq =3D 0;
> =20
> @@ -1013,42 +1012,29 @@ static int flexcan_probe(struct platform_device=
 *pdev)
>  		clk_ipg =3D devm_clk_get(&pdev->dev, "ipg");
>  		if (IS_ERR(clk_ipg)) {
>  			dev_err(&pdev->dev, "no ipg clock defined\n");
> -			err =3D PTR_ERR(clk_ipg);
> -			goto failed_clock;
> +			return PTR_ERR(clk_ipg);
>  		}
>  		clock_freq =3D clk_get_rate(clk_ipg);
> =20
>  		clk_per =3D devm_clk_get(&pdev->dev, "per");
>  		if (IS_ERR(clk_per)) {
>  			dev_err(&pdev->dev, "no per clock defined\n");
> -			err =3D PTR_ERR(clk_per);
> -			goto failed_clock;
> +			return PTR_ERR(clk_per);
>  		}
>  	}
> =20
>  	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	irq =3D platform_get_irq(pdev, 0);
> -	if (!mem || irq <=3D 0) {
> -		err =3D -ENODEV;
> -		goto failed_get;
> -	}
> +	if (irq <=3D 0)
> +		return -ENODEV;
> =20
> -	mem_size =3D resource_size(mem);
> -	if (!request_mem_region(mem->start, mem_size, pdev->name)) {
> -		err =3D -EBUSY;
> -		goto failed_get;
> -	}
> -
> -	base =3D ioremap(mem->start, mem_size);
> -	if (!base) {
> -		err =3D -ENOMEM;
> -		goto failed_map;
> -	}
> +	base =3D devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> =20
>  	dev =3D alloc_candev(sizeof(struct flexcan_priv), 1);
>  	if (!dev) {
> -		err =3D -ENOMEM;
> -		goto failed_alloc;
> +		return -ENOMEM;
>  	}
> =20
>  	of_id =3D of_match_device(flexcan_of_match, &pdev->dev);
> @@ -1058,8 +1044,7 @@ static int flexcan_probe(struct platform_device *=
pdev)
>  		devtype_data =3D (struct flexcan_devtype_data *)
>  			pdev->id_entry->driver_data;
>  	} else {
> -		err =3D -ENODEV;
> -		goto failed_devtype;
> +		return -ENODEV;

You're missing "free_candev(dev);". If you move the alloc_candev after
the devtype, the code should be cleaner.

>  	}
> =20
>  	dev->netdev_ops =3D &flexcan_netdev_ops;
> @@ -1104,28 +1089,15 @@ static int flexcan_probe(struct platform_device=
 *pdev)
>  	return 0;
> =20
>   failed_register:
> - failed_devtype:
>  	free_candev(dev);
> - failed_alloc:
> -	iounmap(base);
> - failed_map:
> -	release_mem_region(mem->start, mem_size);
> - failed_get:
> - failed_clock:
>  	return err;
>  }
> =20
>  static int flexcan_remove(struct platform_device *pdev)
>  {
>  	struct net_device *dev =3D platform_get_drvdata(pdev);
> -	struct flexcan_priv *priv =3D netdev_priv(dev);
> -	struct resource *mem;
> =20
>  	unregister_flexcandev(dev);
> -	iounmap(priv->base);
> -
> -	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	release_mem_region(mem->start, resource_size(mem));
> =20
>  	free_candev(dev);
> =20
>=20
Otherwise, looks good.
Marc


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2LVFTMTVKHEJJNJLSFJRP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHtR3wACgkQjTAFq1RaXHPj/gCeMqc3dmARnkIEzkPIXqAMqf69
tBIAnis8Vy+dOGecg7L/RPQfARDmQY97
=cfQ9
-----END PGP SIGNATURE-----

------enig2LVFTMTVKHEJJNJLSFJRP--
