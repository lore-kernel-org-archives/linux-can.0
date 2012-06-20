From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: c_can_pci: fix compilation on non HAVE_CLK archs
Date: Wed, 20 Jun 2012 15:04:09 +0200
Message-ID: <4FE1CA49.3010503@pengutronix.de>
References: <1340187910-3437-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4FEB656F4486E355EE8B9948"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34112 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360Ab2FTNEV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 20 Jun 2012 09:04:21 -0400
In-Reply-To: <1340187910-3437-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Federico Vaga <federico.vaga@gmail.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4FEB656F4486E355EE8B9948
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Federico,

have you found Time to test the patch?

Marc
On 06/20/2012 12:25 PM, Marc Kleine-Budde wrote:
> In commit:
>=20
>   5b92da0 c_can_pci: generic module for C_CAN/D_CAN on PCI
>=20
> the c_can_pci driver has been added. It uses clk_*() functions
> resulting in a link error on archs without clock support. This
> patch removed these clk_() functions as these parts of the driver
> hasn't been tested.
>=20
> Cc: Federico Vaga <federico.vaga@gmail.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hello Federico,
>=20
> please test on your hardware. If it works please send me your:
> Tested-by.
>=20
> Thanks, Marc
>=20
>  drivers/net/can/c_can/c_can_pci.c |   29 +++++++----------------------=

>  1 file changed, 7 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/=
c_can_pci.c
> index 914aecf..1011146 100644
> --- a/drivers/net/can/c_can/c_can_pci.c
> +++ b/drivers/net/can/c_can/c_can_pci.c
> @@ -13,7 +13,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
> -#include <linux/clk.h>
>  #include <linux/pci.h>
> =20
>  #include <linux/can/dev.h>
> @@ -30,7 +29,7 @@ struct c_can_pci_data {
>  	enum c_can_dev_id type;
>  	/* Set the register alignment in the memory */
>  	enum c_can_pci_reg_align reg_align;
> -	/* Set the frequency if clk is not usable */
> +	/* Set the frequency */
>  	unsigned int freq;
>  };
> =20
> @@ -71,7 +70,6 @@ static int __devinit c_can_pci_probe(struct pci_dev *=
pdev,
>  	struct c_can_priv *priv;
>  	struct net_device *dev;
>  	void __iomem *addr;
> -	struct clk *clk;
>  	int ret;
> =20
>  	ret =3D pci_enable_device(pdev);
> @@ -113,18 +111,11 @@ static int __devinit c_can_pci_probe(struct pci_d=
ev *pdev,
>  	priv->base =3D addr;
> =20
>  	if (!c_can_pci_data->freq) {
> -		/* get the appropriate clk */
> -		clk =3D clk_get(&pdev->dev, NULL);
> -		if (IS_ERR(clk)) {
> -			dev_err(&pdev->dev, "no clock defined\n");
> -			ret =3D -ENODEV;
> -			goto out_free_c_can;
> -		}
> -		priv->can.clock.freq =3D clk_get_rate(clk);
> -		priv->priv =3D clk;
> +		dev_err(&pdev->dev, "no clock frequency defined\n");
> +		ret =3D -ENODEV;
> +		goto out_free_c_can;
>  	} else {
>  		priv->can.clock.freq =3D c_can_pci_data->freq;
> -		priv->priv =3D NULL;
>  	}
> =20
>  	/* Configure CAN type */
> @@ -138,7 +129,7 @@ static int __devinit c_can_pci_probe(struct pci_dev=
 *pdev,
>  		break;
>  	default:
>  		ret =3D -EINVAL;
> -		goto out_free_clock;
> +		goto out_free_c_can;
>  	}
> =20
>  	/* Configure access to registers */
> @@ -153,14 +144,14 @@ static int __devinit c_can_pci_probe(struct pci_d=
ev *pdev,
>  		break;
>  	default:
>  		ret =3D -EINVAL;
> -		goto out_free_clock;
> +		goto out_free_c_can;
>  	}
> =20
>  	ret =3D register_c_can_dev(dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "registering %s failed (err=3D%d)\n",
>  			KBUILD_MODNAME, ret);
> -		goto out_free_clock;
> +		goto out_free_c_can;
>  	}
> =20
>  	dev_dbg(&pdev->dev, "%s device registered (regs=3D%p, irq=3D%d)\n",
> @@ -168,9 +159,6 @@ static int __devinit c_can_pci_probe(struct pci_dev=
 *pdev,
> =20
>  	return 0;
> =20
> -out_free_clock:
> -	if (priv->priv)
> -		clk_put(priv->priv);
>  out_free_c_can:
>  	pci_set_drvdata(pdev, NULL);
>  	free_c_can_dev(dev);
> @@ -193,9 +181,6 @@ static void __devexit c_can_pci_remove(struct pci_d=
ev *pdev)
> =20
>  	unregister_c_can_dev(dev);
> =20
> -	if (priv->priv)
> -		clk_put(priv->priv);
> -
>  	pci_set_drvdata(pdev, NULL);
>  	free_c_can_dev(dev);
> =20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig4FEB656F4486E355EE8B9948
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/hykwACgkQjTAFq1RaXHNMtACffZtj/SAH75Gv/ldXaFUgObcx
rbsAn271vAXsjXzPTyRgNwwUmvX/lBBy
=CEPy
-----END PGP SIGNATURE-----

--------------enig4FEB656F4486E355EE8B9948--
