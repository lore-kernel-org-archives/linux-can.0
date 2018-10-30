From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V2 1/2] can: flexcan: Add self wakeup support
Date: Tue, 30 Oct 2018 14:44:45 +0100
Message-ID: <ba4fb4bb-c1f2-6033-af02-023719382d36@pengutronix.de>
References: <20181026085814.23370-1-qiangqing.zhang@nxp.com>
 <20181026085814.23370-2-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="YkG2zGMbIh1v6OzZoI17gLKdRglWKyPjq"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181026085814.23370-2-qiangqing.zhang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "A.s. Dong" <aisheng.dong@nxp.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YkG2zGMbIh1v6OzZoI17gLKdRglWKyPjq
Content-Type: multipart/mixed; boundary="sJuwh9D2cdwW2SVRTx6CKeLEAPTEcw3C4";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, "A.s. Dong" <aisheng.dong@nxp.com>
Message-ID: <ba4fb4bb-c1f2-6033-af02-023719382d36@pengutronix.de>
Subject: Re: [PATCH V2 1/2] can: flexcan: Add self wakeup support
References: <20181026085814.23370-1-qiangqing.zhang@nxp.com>
 <20181026085814.23370-2-qiangqing.zhang@nxp.com>
In-Reply-To: <20181026085814.23370-2-qiangqing.zhang@nxp.com>

--sJuwh9D2cdwW2SVRTx6CKeLEAPTEcw3C4
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 10/26/2018 11:00 AM, Joakim Zhang wrote:
> From: Dong Aisheng <aisheng.dong@nxp.com>
>=20
> If wakeup is enabled, enter stop mode, else enter disabled mode.
> Self wake can only work on stop mode.
>=20
> Starting from IMX6, the flexcan stop mode control bits is SoC specific,=

> move it out of IP driver and parse it from devicetree.
>=20
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  drivers/net/can/flexcan.c | 141 +++++++++++++++++++++++++++++++++++---=

>  1 file changed, 132 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 3813f6708201..d4708ba28c44 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -19,12 +19,17 @@
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/regmap.h>
> =20
>  #define DRV_NAME			"flexcan"
> =20
> @@ -132,7 +137,8 @@
>  	(FLEXCAN_ESR_ERR_BUS | FLEXCAN_ESR_ERR_STATE)
>  #define FLEXCAN_ESR_ALL_INT \
>  	(FLEXCAN_ESR_TWRN_INT | FLEXCAN_ESR_RWRN_INT | \
> -	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
> +	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
> +	 FLEXCAN_ESR_WAK_INT)
> =20
>  /* FLEXCAN interrupt flag register (IFLAG) bits */
>  /* Errata ERR005829 step7: Reserve first valid MB */
> @@ -255,6 +261,14 @@ struct flexcan_devtype_data {
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
> @@ -272,6 +286,7 @@ struct flexcan_priv {
>  	struct clk *clk_per;
>  	const struct flexcan_devtype_data *devtype_data;
>  	struct regulator *reg_xceiver;
> +	struct flexcan_stop_mode stm;
> =20
>  	/* Read and Write APIs */
>  	u32 (*read)(void __iomem *addr);
> @@ -392,6 +407,22 @@ static void flexcan_clks_disable(const struct flex=
can_priv *priv)
>  	clk_disable_unprepare(priv->clk_per);
>  }
> =20
> +static inline void flexcan_enter_stop_mode(struct flexcan_priv *priv)
> +{
> +	/* enable stop request */
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)

Why do you check the quirk here? This should only be called if the
device is wakeup capable.

> +		regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
> +			1 << priv->stm.req_bit, 1 << priv->stm.req_bit);

Please align with the opening bracket of "regmap_update_bits(".

> +}
> +
> +static inline void flexcan_exit_stop_mode(struct flexcan_priv *priv)
> +{
> +	/* remove stop request */
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP)

same here

> +		regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
> +			1 << priv->stm.req_bit, 0);

same here

> +}
> +
>  static inline int flexcan_transceiver_enable(const struct flexcan_priv=
 *priv)
>  {
>  	if (!priv->reg_xceiver)
> @@ -955,6 +986,10 @@ static int flexcan_chip_start(struct net_device *d=
ev)
>  		reg_mcr |=3D FLEXCAN_MCR_FEN |
>  			FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
>  	}
> +
> +	/* enable self wakeup */
> +	reg_mcr |=3D FLEXCAN_MCR_WAK_MSK | FLEXCAN_MCR_SLF_WAK;
> +
>  	netdev_dbg(dev, "%s: writing mcr=3D0x%08x", __func__, reg_mcr);
>  	priv->write(reg_mcr, &regs->mcr);
> =20
> @@ -1240,6 +1275,56 @@ static void unregister_flexcandev(struct net_dev=
ice *dev)
>  	unregister_candev(dev);
>  }
> =20
> +static int flexcan_of_parse_stop_mode(struct platform_device *pdev)
> +{
> +	struct net_device *dev =3D platform_get_drvdata(pdev);
> +	struct device_node *np =3D pdev->dev.of_node;
> +	struct device_node *node;
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
> +	if (ret) {
> +		dev_dbg(&pdev->dev, "no stop-mode property\n");
> +		return ret;
> +	}
> +	phandle =3D *out_val;
> +
> +	node =3D of_find_node_by_phandle(phandle);
> +	if (!node) {
> +		dev_dbg(&pdev->dev, "could not find gpr node by phandle\n");
> +		return PTR_ERR(node);
> +	}
> +
> +	priv =3D netdev_priv(dev);
> +	priv->stm.gpr =3D syscon_node_to_regmap(node);
> +	if (IS_ERR(priv->stm.gpr)) {
> +		dev_dbg(&pdev->dev, "could not find gpr regmap\n");
> +		return PTR_ERR(priv->stm.gpr);
> +	}
> +
> +	of_node_put(node);
> +
> +	priv->stm.req_gpr =3D out_val[1];
> +	priv->stm.req_bit =3D out_val[2];
> +	priv->stm.ack_gpr =3D out_val[3];
> +	priv->stm.ack_bit =3D out_val[4];
> +
> +	dev_dbg(&pdev->dev, "gpr %s req_gpr 0x%x req_bit %u ack_gpr 0x%x ack_=
bit %u\n",
> +			node->full_name, priv->stm.req_gpr,
> +			priv->stm.req_bit, priv->stm.ack_gpr,
> +			priv->stm.ack_bit);
> +	return 0;
> +}
> +
>  static const struct of_device_id flexcan_of_match[] =3D {
>  	{ .compatible =3D "fsl,imx6q-flexcan", .data =3D &fsl_imx6q_devtype_d=
ata, },
>  	{ .compatible =3D "fsl,imx28-flexcan", .data =3D &fsl_imx28_devtype_d=
ata, },
> @@ -1271,6 +1356,7 @@ static int flexcan_probe(struct platform_device *=
pdev)
>  	struct flexcan_regs __iomem *regs;
>  	int err, irq;
>  	u32 clock_freq =3D 0;
> +	int wakeup =3D 1;

Make it a bool.
Why is is default enabled?
See below.

> =20
>  	reg_xceiver =3D devm_regulator_get(&pdev->dev, "xceiver");
>  	if (PTR_ERR(reg_xceiver) =3D=3D -EPROBE_DEFER)
> @@ -1400,6 +1486,16 @@ static int flexcan_probe(struct platform_device =
*pdev)
> =20
>  	devm_can_led_init(dev);
> =20
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_USE_OFF_TIMESTAMP) {

Please add another QUIRK.

> +		err =3D flexcan_of_parse_stop_mode(pdev);
> +		if (err) {
> +			wakeup =3D 0;
> +			dev_dbg(&pdev->dev, "failed to parse stop-mode\n");
> +		}
> +	}
> +
> +	device_set_wakeup_capable(&pdev->dev, wakeup);

What about moving this into "flexcan_of_parse_stop_mode(pdev);", and
rename this function into ..._setup_stop_mode() or something similar.

> +
>  	pm_runtime_put(&pdev->dev);
> =20
>  	dev_info(&pdev->dev, "device registered (reg_base=3D%p, irq=3D%d)\n",=

> @@ -1437,10 +1533,18 @@ static int __maybe_unused flexcan_suspend(struc=
t device *device)
>  	int err =3D 0;
> =20
>  	if (netif_running(dev)) {
> -		err =3D flexcan_chip_disable(priv);
> -		if (err)
> -			return err;
> -		err =3D pm_runtime_force_suspend(device);
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
> +			err =3D pm_runtime_force_suspend(device);
> +		}
> =20
>  		netif_stop_queue(dev);
>  		netif_device_detach(dev);
> @@ -1461,10 +1565,12 @@ static int __maybe_unused flexcan_resume(struct=
 device *device)
>  		netif_device_attach(dev);
>  		netif_start_queue(dev);
> =20
> -		err =3D pm_runtime_force_resume(device);
> -		if (err)
> -			return err;
> -		err =3D flexcan_chip_enable(priv);
> +		if (!device_may_wakeup(device)) {
> +			err =3D pm_runtime_force_resume(device);
> +			if (err)
> +				return err;
> +			err =3D flexcan_chip_enable(priv);
> +		}
>  	}
>  	return err;
>  }
> @@ -1489,10 +1595,27 @@ static int __maybe_unused flexcan_runtime_resum=
e(struct device *device)
>  	return 0;
>  }
> =20
> +static int __maybe_unused flexcan_noirq_resume(struct device *device)
> +{
> +	struct net_device *dev =3D dev_get_drvdata(device);
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +
> +	/* exit stop mode during noirq stage avoid continuously entering
> +	 * wakeup ISR before CAN resume back.
> +	 */
> +	if (netif_running(dev) && device_may_wakeup(device)) {
> +		disable_irq_wake(dev->irq);
> +		flexcan_exit_stop_mode(priv);
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct dev_pm_ops flexcan_pm_ops =3D {
>  	SET_SYSTEM_SLEEP_PM_OPS(flexcan_suspend, flexcan_resume)
>  	SET_RUNTIME_PM_OPS(flexcan_runtime_suspend, flexcan_runtime_resume,
>  						NULL)
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, flexcan_noirq_resume)
>  };
> =20
>  static struct platform_driver flexcan_driver =3D {
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--sJuwh9D2cdwW2SVRTx6CKeLEAPTEcw3C4--

--YkG2zGMbIh1v6OzZoI17gLKdRglWKyPjq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlvYYE0ACgkQk9IU1zQo
ZfEbLAgAlXK7bMDCQX0TBaWReJR+ACwfqt+Qijih6qMMGmjoT8VpB9gLQJ21i+9+
mEdze1lVXqVIsjGxAEtkDBDwDtZ6r2l5b517tC0RG+UD2g3QVkfxv/WmlWAA3GWX
aQd65nfkr3LppCk4I75rk6Zey8o/XD6KdTRbuRLoPb85jf/jvrCLLX+nIqZQ663K
iXFJErceVhNmktjXdtpFDeyUhqxy1Ee81hDJjr2FiBnzxcHpEjutZc6pMazzUS1l
FOYNJV7vWek9aub1/SfkX/mKhjtKyCwsL0zy5NvLYfDJlCBl3DQIhvjgkgwn/zRp
jkKYV9Bu25yQjZbJpz+eWMin1777kg==
=zHc/
-----END PGP SIGNATURE-----

--YkG2zGMbIh1v6OzZoI17gLKdRglWKyPjq--
