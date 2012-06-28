From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] can: flexcan: add hardware controller version
 support
Date: Thu, 28 Jun 2012 12:20:04 +0200
Message-ID: <4FEC2FD4.4060602@pengutronix.de>
References: <1340871695-26327-1-git-send-email-jason77.wang@gmail.com> <1340871695-26327-2-git-send-email-jason77.wang@gmail.com> <1340871695-26327-3-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8EFC8BAEED59D559031FC16F"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55568 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932466Ab2F1KUO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 06:20:14 -0400
In-Reply-To: <1340871695-26327-3-git-send-email-jason77.wang@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
Cc: wg@grandegger.com, shawn.guo@linaro.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8EFC8BAEED59D559031FC16F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/28/2012 10:21 AM, Hui Wang wrote:
> At least in the i.MX series, the flexcan contrller divides into ver_3
> and ver_10, current driver is for ver_3 controller.
>=20
> i.MX6 has ver_10 controller, it has more reigsters than ver_3 has.
> The rxfgmask (Rx FIFO Global Mask) register is one of the new added.
> Its reset value is 0xffffffff, this means ID Filter Table must be
> checked when receive a packet, but the driver is designed to accept
> everything during the chip start, we need to clear this register to
> follow this design.
>=20
> Use the data entry of the struct of_device_id to point chip specific
> info, we can set hardware version for each platform.

The patch looks quite good. Can you please add an id_table for the
platform binding, too. Just a single entry with .nam =3D DRV_NAME and
=2Edriver_data =3D fsl_p1010_devtype_data, have a look at c_can_platform.=
c
for example[1]. This way, it's no special case to have the hw_ver info.

[1]
http://git.kernel.org/?p=3Dlinux/kernel/git/next/linux-next.git;a=3Dcommi=
tdiff;h=3D69927fccd96b15bd228bb82d356a7a2a0cfaeefb;hp=3D33f8100977693fa09=
c2a32b1ca6dbf4d6eabdd0c

Some nitpicks inline,
Marc

>=20
> Cc: linux-can@vger.kernel.org
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
> ---
>  drivers/net/can/flexcan.c |   41 +++++++++++++++++++++++++++++++++----=
----
>  1 files changed, 33 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index f63f826..9712bdb 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -34,6 +34,7 @@
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pinctrl/consumer.h>
> =20
> @@ -165,10 +166,20 @@ struct flexcan_regs {
>  	u32 imask1;		/* 0x28 */
>  	u32 iflag2;		/* 0x2c */
>  	u32 iflag1;		/* 0x30 */
> -	u32 _reserved2[19];
> +	u32 crl2;		/* 0x34 */
> +	u32 esr2;		/* 0x38 */
> +	u32 _reserved2[2];
> +	u32 crcr;		/* 0x44 */
> +	u32 rxfgmask;		/* 0x48 */
> +	u32 rxfir;		/* 0x4c */
> +	u32 _reserved3[12];
>  	struct flexcan_mb cantxfg[64];
>  };
> =20
> +struct flexcan_devtype_data {
> +	u32 hw_ver;	/* hardware controller version */
> +};
> +
>  struct flexcan_priv {
>  	struct can_priv can;
>  	struct net_device *dev;
> @@ -180,6 +191,15 @@ struct flexcan_priv {
> =20
>  	struct clk *clk;
>  	struct flexcan_platform_data *pdata;
> +	struct flexcan_devtype_data *devtype_data;
> +};
> +
> +static struct flexcan_devtype_data fsl_p1010_devtype_data =3D {
const?
> +	.hw_ver =3D 3,
> +};
> +
> +static struct flexcan_devtype_data fsl_imx6q_devtype_data =3D {
const
> +	.hw_ver =3D 10,
>  };
> =20
>  static struct can_bittiming_const flexcan_bittiming_const =3D {
> @@ -750,6 +770,9 @@ static int flexcan_chip_start(struct net_device *de=
v)
>  	flexcan_write(0x0, &regs->rx14mask);
>  	flexcan_write(0x0, &regs->rx15mask);
> =20
> +	if (priv->devtype_data && priv->devtype_data->hw_ver >=3D 10)

If you have always devtype_data, this should simplify

> +		flexcan_write(0x0, &regs->rxfgmask);
> +
>  	flexcan_transceiver_switch(priv, 1);
> =20
>  	/* synchronize with the can bus */
> @@ -922,8 +945,16 @@ static void __devexit unregister_flexcandev(struct=
 net_device *dev)
>  	unregister_candev(dev);
>  }
> =20
> +static const struct of_device_id flexcan_of_match[] =3D {
> +	{ .compatible =3D "fsl,p1010-flexcan", .data =3D &fsl_p1010_devtype_d=
ata, },
> +	{ .compatible =3D "fsl,imx6q-flexcan", .data =3D &fsl_imx6q_devtype_d=
ata, },
> +	{},
> +};
> +
>  static int __devinit flexcan_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *of_id =3D
> +			of_match_device(flexcan_of_match, &pdev->dev);
>  	struct net_device *dev;
>  	struct flexcan_priv *priv;
>  	struct resource *mem;
> @@ -982,6 +1013,7 @@ static int __devinit flexcan_probe(struct platform=
_device *pdev)
>  	dev->flags |=3D IFF_ECHO;
> =20
>  	priv =3D netdev_priv(dev);
> +	priv->devtype_data =3D of_id ? of_id->data : NULL;
>  	priv->can.clock.freq =3D clock_freq;
>  	priv->can.bittiming_const =3D &flexcan_bittiming_const;
>  	priv->can.do_set_mode =3D flexcan_set_mode;
> @@ -1044,13 +1076,6 @@ static int __devexit flexcan_remove(struct platf=
orm_device *pdev)
>  	return 0;
>  }
> =20
> -static struct of_device_id flexcan_of_match[] =3D {
> -	{
> -		.compatible =3D "fsl,p1010-flexcan",
> -	},
> -	{},
> -};
> -
>  static struct platform_driver flexcan_driver =3D {
>  	.driver =3D {
>  		.name =3D DRV_NAME,


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig8EFC8BAEED59D559031FC16F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/sL9gACgkQjTAFq1RaXHOjdgCfYSrLOe3rDrz5K7UM4rBHwk6R
RjoAnRn5HzmDhyU7floR7fzhTSlP9Es+
=SCFR
-----END PGP SIGNATURE-----

--------------enig8EFC8BAEED59D559031FC16F--
