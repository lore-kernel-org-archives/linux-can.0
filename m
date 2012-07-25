From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/4] can: c_can: Add device tree support to Bosch C_CAN/D_CAN
 controller
Date: Wed, 25 Jul 2012 11:24:24 +0200
Message-ID: <500FBB48.60005@pengutronix.de>
References: <1343197417-27481-1-git-send-email-anilkumar@ti.com> <1343197417-27481-2-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig16B110348E6978E0EF2B56FC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57231 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932767Ab2GYJYd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Jul 2012 05:24:33 -0400
In-Reply-To: <1343197417-27481-2-git-send-email-anilkumar@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig16B110348E6978E0EF2B56FC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/25/2012 08:23 AM, AnilKumar Ch wrote:
> Add device tree support to C_CAN/D_CAN controller and usage details
> are added to device tree documentation. Driver was tested on AM335x
> EVM.

AFAIK you should add devicetree-discuss@lists.ozlabs.org on Cc for DT
related patches. More comments inline.

>=20
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  .../devicetree/bindings/net/can/c_can.txt          |   38 ++++++++++++=
++
>  drivers/net/can/c_can/c_can_platform.c             |   52 ++++++++++++=
++------
>  2 files changed, 75 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/can/c_can.txt=

>=20
> diff --git a/Documentation/devicetree/bindings/net/can/c_can.txt b/Docu=
mentation/devicetree/bindings/net/can/c_can.txt
> new file mode 100644
> index 0000000..78b8ae8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/c_can.txt
> @@ -0,0 +1,38 @@
> +Bosch C_CAN/D_CAN controller Device Tree Bindings
> +-------------------------------------------------
> +
> +Required properties:
> +- compatible		: Should be "bosch,c_can_platform" or "bosch,c_can"
> +			  for C_CAN controllers and "bosch,d_can" for D_CAN
> +			  controllers.
> +- reg			: physical base address and size of the C_CAN/D_CAN
> +			  registers map
> +- interrupts		: property with a value describing the interrupt
> +			  number
> +- interrupt-parent	: The parent interrupt controller
> +
> +Optional properties:
> +- ti,hwmods		: Must be "d_can<n>" or "c_can<n>", n being the
> +			  instance number
> +
> +Note: "ti,hwmods" field is used to fetch the base address and irq
> +resources from TI, omap hwmod data base during device registration.
> +Future plan is to migrate hwmod data base contents into device tree
> +blob so that, all the required data will be used from device tree dts
> +file.
> +
> +Examples:
> +
> +	d_can@481D0000 {
> +		compatible =3D "bosch,d_can";
> +		reg =3D <0x481D0000 0x1000>;
> +		interrupts =3D <55 0x4>;
> +		interrupt-parent =3D <&intc>;
> +	};
> +
> +(or)
> +
> +	d_can@481D0000 {
> +		compatible =3D "bosch,d_can";
> +		ti,hwmods =3D "d_can1";
> +	};
> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c=
_can/c_can_platform.c
> index 6ff7ad0..2f5b153 100644
> --- a/drivers/net/can/c_can/c_can_platform.c
> +++ b/drivers/net/can/c_can/c_can_platform.c
> @@ -30,6 +30,8 @@
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> =20
>  #include <linux/can/dev.h>
> =20
> @@ -65,17 +67,51 @@ static void c_can_plat_write_reg_aligned_to_32bit(s=
truct c_can_priv *priv,
>  	writew(val, priv->base + 2 * priv->regs[index]);
>  }
> =20
> +static struct platform_device_id c_can_id_table[] =3D {
> +	{
> +		.name =3D KBUILD_MODNAME,
> +		.driver_data =3D C_CAN_DEVTYPE,
> +	}, {
> +		.name =3D "c_can",
> +		.driver_data =3D C_CAN_DEVTYPE,
> +	}, {
> +		.name =3D "d_can",
> +		.driver_data =3D D_CAN_DEVTYPE,
> +	}, {
> +	}
> +};
> +
> +static const struct of_device_id c_can_of_table[] =3D {
> +	{ .compatible =3D "bosch,c_can_platform", .data =3D &c_can_id_table[0=
] },

Please don't add the "legacy bosch,c_can_platform" to the device tree
bindings. I personally would appreciate if you introduce an enum as
array index (BOSCH_C_CAN_PLATFORM, BOSCH_C_CAN, BOSCH_D_CAN) and
initialize the c_can_id_table above using the array indexes, then you
can use these indexes here too.

> +	{ .compatible =3D "bosch,c_can", .data =3D &c_can_id_table[1] },
> +	{ .compatible =3D "bosch,d_can", .data =3D &c_can_id_table[2] },
> +	{ /* sentinel */ },
> +};
> +
>  static int __devinit c_can_plat_probe(struct platform_device *pdev)
>  {
>  	int ret;
>  	void __iomem *addr;
>  	struct net_device *dev;
>  	struct c_can_priv *priv;
> +	const struct of_device_id *match;
>  	const struct platform_device_id *id;
>  	struct resource *mem;
>  	int irq;
>  	struct clk *clk;
> =20
> +	if (pdev->dev.of_node) {
> +		match =3D of_match_device(c_can_of_table, &pdev->dev);
> +		if (!match) {
> +			dev_err(&pdev->dev, "Failed to find matching dt id\n");
> +			ret =3D -EINVAL;
> +			goto exit;
> +		}
> +		id =3D match->data;
> +	} else {
> +		id =3D platform_get_device_id(pdev);
> +	}
> +
>  	/* get the appropriate clk */
>  	clk =3D clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(clk)) {
> @@ -114,7 +150,6 @@ static int __devinit c_can_plat_probe(struct platfo=
rm_device *pdev)
>  	}
> =20
>  	priv =3D netdev_priv(dev);
> -	id =3D platform_get_device_id(pdev);
>  	switch (id->driver_data) {
>  	case C_CAN_DEVTYPE:
>  		priv->regs =3D reg_map_c_can;
> @@ -195,24 +230,11 @@ static int __devexit c_can_plat_remove(struct pla=
tform_device *pdev)
>  	return 0;
>  }
> =20
> -static const struct platform_device_id c_can_id_table[] =3D {
> -	{
> -		.name =3D KBUILD_MODNAME,
> -		.driver_data =3D C_CAN_DEVTYPE,
> -	}, {
> -		.name =3D "c_can",
> -		.driver_data =3D C_CAN_DEVTYPE,
> -	}, {
> -		.name =3D "d_can",
> -		.driver_data =3D D_CAN_DEVTYPE,
> -	}, {
> -	}
> -};
> -
>  static struct platform_driver c_can_plat_driver =3D {
>  	.driver =3D {
>  		.name =3D KBUILD_MODNAME,
>  		.owner =3D THIS_MODULE,
> +		.of_match_table =3D of_match_ptr(c_can_of_table),
>  	},
>  	.probe =3D c_can_plat_probe,
>  	.remove =3D __devexit_p(c_can_plat_remove),
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig16B110348E6978E0EF2B56FC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAPu0sACgkQjTAFq1RaXHO97gCcCUo5TT+hSFg66tprA+hBX6Xp
w28AnR48pt1SRYIxVGzvYzHfMwChQtJR
=1RpQ
-----END PGP SIGNATURE-----

--------------enig16B110348E6978E0EF2B56FC--
