From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V6 2/2] can: flexcan: add self wakeup support
Date: Fri, 23 Nov 2018 16:03:53 +0100
Message-ID: <1be643fb-e966-fc2d-d19f-2a1e45b58641@pengutronix.de>
References: <20181123083304.3232-1-qiangqing.zhang@nxp.com>
 <20181123083304.3232-3-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="trC1QlQ0mUvy5WJC6BtKgYZWIOhHsXJ07"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181123083304.3232-3-qiangqing.zhang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Aisheng DONG <aisheng.dong@nxp.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--trC1QlQ0mUvy5WJC6BtKgYZWIOhHsXJ07
Content-Type: multipart/mixed; boundary="5ecR1lUw7oiKwKbiJSwsPr7HPuwBbTq2U";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Aisheng DONG <aisheng.dong@nxp.com>
Message-ID: <1be643fb-e966-fc2d-d19f-2a1e45b58641@pengutronix.de>
Subject: Re: [PATCH V6 2/2] can: flexcan: add self wakeup support
References: <20181123083304.3232-1-qiangqing.zhang@nxp.com>
 <20181123083304.3232-3-qiangqing.zhang@nxp.com>
In-Reply-To: <20181123083304.3232-3-qiangqing.zhang@nxp.com>

--5ecR1lUw7oiKwKbiJSwsPr7HPuwBbTq2U
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/23/18 9:35 AM, Joakim Zhang wrote:
> From: Aisheng Dong <aisheng.dong@nxp.com>
>=20
> If wakeup is enabled, enter stop mode, else enter disabled mode. Self w=
ake
> can only work on stop mode.
>=20
> Starting from IMX6, the flexcan stop mode control bits is SoC specific,=

> move it out of IP driver and parse it from devicetree.
>=20
> Signed-off-by: Aisheng Dong <aisheng.dong@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
> ChangeLog:
> V1->V2:
> 	*add a vendor prefix in property (stop-mode -> fsl,stop-mode).
> V2->V3:
> 	*add FLEXCAN_QUIRK_SETUP_STOP_MODE quirk.
> 	*rename function.
> 	*fix system can't be wakeuped during suspend.
> V3->V4:
> 	*normalize the code following Aisheng Dong's comments.
> V4->V5:
> 	*move enable/disable self wakeup feature into
> 	 enter/exit_stop_mode() function.
> V5->V6:
> 	*exchange the order of flexcan_enable_wakeup_irq(priv, false)
> 	 and disable_irq_wake(dev->irq).
> ---
>  drivers/net/can/flexcan.c | 172 ++++++++++++++++++++++++++++++++++++--=

>  1 file changed, 163 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 8e972ef08637..da08a8c113d2 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -19,11 +19,14 @@
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/regmap.h>
> =20
>  #define DRV_NAME			"flexcan"
> =20
> @@ -131,7 +134,8 @@
>  	(FLEXCAN_ESR_ERR_BUS | FLEXCAN_ESR_ERR_STATE)
>  #define FLEXCAN_ESR_ALL_INT \
>  	(FLEXCAN_ESR_TWRN_INT | FLEXCAN_ESR_RWRN_INT | \
> -	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
> +	FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
> +	FLEXCAN_ESR_WAK_INT)

I've fixed the indention while applying the patch.

> =20
>  /* FLEXCAN interrupt flag register (IFLAG) bits */
>  /* Errata ERR005829 step7: Reserve first valid MB */
> @@ -190,6 +194,7 @@
>  #define FLEXCAN_QUIRK_USE_OFF_TIMESTAMP	BIT(5) /* Use timestamp based =
offloading */
>  #define FLEXCAN_QUIRK_BROKEN_PERR_STATE	BIT(6) /* No interrupt for err=
or passive */
>  #define FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN	BIT(7) /* default to BE regis=
ter access */
> +#define FLEXCAN_QUIRK_SETUP_STOP_MODE		BIT(8) /* Setup stop mode to su=
pport wakeup */
> =20
>  /* Structure of the message buffer */
>  struct flexcan_mb {
> @@ -254,6 +259,14 @@ struct flexcan_devtype_data {
>  	u32 quirks;		/* quirks needed for different IP cores */
>  };
> =20
> +struct flexcan_stop_mode {
> +	struct regmap *gpr;
> +	u8 req_gpr;
> +	u8 req_bit;
> +	u8 ack_gpr;
> +	u8 ack_bit;
> +};
> +
>  struct flexcan_priv {
>  	struct can_priv can;
>  	struct can_rx_offload offload;
> @@ -270,6 +283,7 @@ struct flexcan_priv {
>  	struct clk *clk_per;
>  	const struct flexcan_devtype_data *devtype_data;
>  	struct regulator *reg_xceiver;
> +	struct flexcan_stop_mode stm;
> =20
>  	/* Read and Write APIs */
>  	u32 (*read)(void __iomem *addr);
> @@ -293,7 +307,8 @@ static const struct flexcan_devtype_data fsl_imx28_=
devtype_data =3D {
> =20
>  static const struct flexcan_devtype_data fsl_imx6q_devtype_data =3D {
>  	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG | FLEXCAN_QUIRK_ENABLE_EACEN_R=
RS |
> -		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP | FLEXCAN_QUIRK_BROKEN_PERR_STATE,
> +		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP | FLEXCAN_QUIRK_BROKEN_PERR_STATE |
> +		FLEXCAN_QUIRK_SETUP_STOP_MODE,
>  };
> =20
>  static const struct flexcan_devtype_data fsl_vf610_devtype_data =3D {
> @@ -353,6 +368,49 @@ static inline void flexcan_write_le(u32 val, void =
__iomem *addr)
>  	iowrite32(val, addr);
>  }
> =20
> +static void flexcan_enable_wakeup_irq(struct flexcan_priv *priv, bool =
enable)
> +{
> +	struct flexcan_regs __iomem *regs =3D priv->regs;
> +	u32 reg_mcr;
> +
> +	reg_mcr =3D priv->read(&regs->mcr);
> +
> +	if (enable)
> +		reg_mcr |=3D FLEXCAN_MCR_WAK_MSK;
> +	else
> +		reg_mcr &=3D ~FLEXCAN_MCR_WAK_MSK;
> +
> +	priv->write(reg_mcr, &regs->mcr);
> +}
> +
> +static inline void flexcan_enter_stop_mode(struct flexcan_priv *priv)
> +{
> +	struct flexcan_regs __iomem *regs =3D priv->regs;
> +	u32 reg_mcr;
> +
> +	reg_mcr =3D priv->read(&regs->mcr);
> +	reg_mcr |=3D FLEXCAN_MCR_SLF_WAK;
> +	priv->write(reg_mcr, &regs->mcr);
> +
> +	/* enable stop request */
> +	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
> +			   1 << priv->stm.req_bit, 1 << priv->stm.req_bit);
> +}
> +
> +static inline void flexcan_exit_stop_mode(struct flexcan_priv *priv)
> +{
> +	struct flexcan_regs __iomem *regs =3D priv->regs;
> +	u32 reg_mcr;
> +
> +	/* remove stop request */
> +	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
> +			   1 << priv->stm.req_bit, 0);
> +
> +	reg_mcr =3D priv->read(&regs->mcr);
> +	reg_mcr &=3D ~FLEXCAN_MCR_SLF_WAK;
> +	priv->write(reg_mcr, &regs->mcr);
> +}
> +
>  static inline void flexcan_error_irq_enable(const struct flexcan_priv =
*priv)
>  {
>  	struct flexcan_regs __iomem *regs =3D priv->regs;
> @@ -1244,6 +1302,57 @@ static void unregister_flexcandev(struct net_dev=
ice *dev)
>  	unregister_candev(dev);
>  }
> =20
> +static int flexcan_setup_stop_mode(struct platform_device *pdev)
> +{
> +	struct net_device *dev =3D platform_get_drvdata(pdev);
> +	struct device_node *np =3D pdev->dev.of_node;
> +	struct device_node *gpr_np;
> +	struct flexcan_priv *priv;
> +	phandle phandle;
> +	u32 out_val[5];
> +	int ret;
> +
> +	if (!np)
> +		return -EINVAL;
> +
> +	/* stop mode property format is:
> +	 * <&gpr req_gpr req_bit ack_gpr ack_bit>.
> +	 */
> +	ret =3D of_property_read_u32_array(np, "fsl,stop-mode", out_val, 5);

I've changed the 5 to ARRAY_SIZE() while applying the patch + rewrap to
80 cols.

> +	if (ret) {
> +		dev_dbg(&pdev->dev, "no stop-mode property\n");
> +		return ret;
> +	}
> +	phandle =3D *out_val;
> +
> +	gpr_np =3D of_find_node_by_phandle(phandle);
> +	if (!gpr_np) {
> +		dev_dbg(&pdev->dev, "could not find gpr node by phandle\n");
> +		return PTR_ERR(gpr_np);
> +	}
> +
> +	priv =3D netdev_priv(dev);
> +	priv->stm.gpr =3D syscon_node_to_regmap(gpr_np);
> +	of_node_put(gpr_np);
> +	if (IS_ERR(priv->stm.gpr)) {
> +		dev_dbg(&pdev->dev, "could not find gpr regmap\n");
> +		return PTR_ERR(priv->stm.gpr);
> +	}
> +
> +	priv->stm.req_gpr =3D out_val[1];
> +	priv->stm.req_bit =3D out_val[2];
> +	priv->stm.ack_gpr =3D out_val[3];
> +	priv->stm.ack_bit =3D out_val[4];
> +
> +	dev_dbg(&pdev->dev, "gpr %s req_gpr 0x%x req_bit %u ack_gpr 0x%x ack_=
bit %u\n",
> +		gpr_np->full_name, priv->stm.req_gpr, priv->stm.req_bit, priv->stm.a=
ck_gpr,
> +		priv->stm.ack_bit);

For the hex values I've changed to 0x%x to 0x%02x + rewarp to 80 cols.

> +
> +	device_set_wakeup_capable(&pdev->dev, true);
> +
> +	return 0;
> +}
> +
>  static const struct of_device_id flexcan_of_match[] =3D {
>  	{ .compatible =3D "fsl,imx6q-flexcan", .data =3D &fsl_imx6q_devtype_d=
ata, },
>  	{ .compatible =3D "fsl,imx28-flexcan", .data =3D &fsl_imx28_devtype_d=
ata, },
> @@ -1396,6 +1505,12 @@ static int flexcan_probe(struct platform_device =
*pdev)
> =20
>  	devm_can_led_init(dev);
> =20
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE) {
> +		err =3D flexcan_setup_stop_mode(pdev);
> +		if (err)
> +			dev_dbg(&pdev->dev, "failed to setup stop-mode\n");
> +	}
> +
>  	dev_info(&pdev->dev, "device registered (reg_base=3D%p, irq=3D%d)\n",=

>  		 priv->regs, dev->irq);
> =20
> @@ -1426,9 +1541,17 @@ static int __maybe_unused flexcan_suspend(struct=
 device *device)
>  	int err;
> =20
>  	if (netif_running(dev)) {
> -		err =3D flexcan_chip_disable(priv);
> -		if (err)
> -			return err;
> +		/* if wakeup is enabled, enter stop mode
> +		 * else enter disabled mode.
> +		 */
> +		if (device_may_wakeup(device)) {
> +			enable_irq_wake(dev->irq);
> +			flexcan_enter_stop_mode(priv);
> +		} else {
> +			err =3D flexcan_chip_disable(priv);
> +			if (err)
> +				return err;
> +		}
>  		netif_stop_queue(dev);
>  		netif_device_detach(dev);
>  	}
> @@ -1447,14 +1570,45 @@ static int __maybe_unused flexcan_resume(struct=
 device *device)
>  	if (netif_running(dev)) {
>  		netif_device_attach(dev);
>  		netif_start_queue(dev);
> -		err =3D flexcan_chip_enable(priv);
> -		if (err)
> -			return err;
> +		if (device_may_wakeup(device)) {
> +			disable_irq_wake(dev->irq);
> +		} else {
> +			err =3D flexcan_chip_enable(priv);
> +			if (err)
> +				return err;
> +		}
>  	}
>  	return 0;
>  }
> =20
> -static SIMPLE_DEV_PM_OPS(flexcan_pm_ops, flexcan_suspend, flexcan_resu=
me);
> +static int __maybe_unused flexcan_noirq_suspend(struct device *device)=

> +{
> +	struct net_device *dev =3D dev_get_drvdata(device);
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +
> +	if (netif_running(dev) && device_may_wakeup(device))
> +		flexcan_enable_wakeup_irq(priv, true);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused flexcan_noirq_resume(struct device *device)
> +{
> +	struct net_device *dev =3D dev_get_drvdata(device);
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +
> +	if (netif_running(dev) && device_may_wakeup(device)) {
> +		flexcan_enable_wakeup_irq(priv, false);
> +		flexcan_exit_stop_mode(priv);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops flexcan_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(flexcan_suspend, flexcan_resume)
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(flexcan_noirq_suspend, flexcan_noirq_re=
sume)
> +};
> =20
>  static struct platform_driver flexcan_driver =3D {
>  	.driver =3D {
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--5ecR1lUw7oiKwKbiJSwsPr7HPuwBbTq2U--

--trC1QlQ0mUvy5WJC6BtKgYZWIOhHsXJ07
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlv4FtkACgkQk9IU1zQo
ZfFCKAf/Y+KL119RjC9tHBCaTEjf9yhxWSA/HYA2Rr6Ie8XAhD3OebpAtAAZ0zhi
vxKJMfeoDmfcXoOXHsbXgY32/fsjZYCk2rSOi7U1D/mYbSrohBbjXPVabwennkFU
mSVMwVQxKwXmiGpc1lNdv8LQHaaO2UJRaommUzKI3MaUqmQh5jZy40xOWtyfhsAj
XgunPWyCFPkqh/XJELkOy0czQH6NOWMI8rjE0NAcEhzj1MIe+hCGHaK9a/UEf1/s
RRSB4G5zjUZedgHufTOJxOkitLAIWd02tVk6ZqFj3ZdISDgh38ZBzxg8mBlmdjC+
fAQteB3RyuWiHya5VRPl/aa2aqnrsg==
=yQhJ
-----END PGP SIGNATURE-----

--trC1QlQ0mUvy5WJC6BtKgYZWIOhHsXJ07--
