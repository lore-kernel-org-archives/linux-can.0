From: Aisheng DONG <aisheng.dong@nxp.com>
Subject: RE: [PATCH V3 1/1] can: flexcan: Add self wakeup support
Date: Wed, 21 Nov 2018 03:34:28 +0000
Message-ID: <AM0PR04MB4211BE08EADBACBEC809067E80DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20181112015047.4252-1-qiangqing.zhang@nxp.com>
 <20181112015047.4252-2-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181112015047.4252-2-qiangqing.zhang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "mkl@pengutronix.de" <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-can.vger.kernel.org

> -----Original Message-----
> From: Joakim Zhang
[...]
>=20
> If wakeup is enabled, enter stop mode, else enter disabled mode.Self wake=
 can
> only work on stop mode.
>=20
> Starting from IMX6, the flexcan stop mode control bits is SoC specific, m=
ove it
> out of IP driver and parse it from devicetree.
>=20
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  drivers/net/can/flexcan.c | 175
> +++++++++++++++++++++++++++++++++++---
>  1 file changed, 163 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c index
> 3813f6708201..d21d0db8c83e 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -19,12 +19,17 @@
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>

This two lines seems not neccesary

> +#include <linux/mfd/syscon.h>
> +#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/regmap.h>
>=20
>  #define DRV_NAME			"flexcan"
>=20
> @@ -132,7 +137,8 @@
>  	(FLEXCAN_ESR_ERR_BUS | FLEXCAN_ESR_ERR_STATE)  #define
> FLEXCAN_ESR_ALL_INT \
>  	(FLEXCAN_ESR_TWRN_INT | FLEXCAN_ESR_RWRN_INT | \
> -	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
> +	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
> +	 FLEXCAN_ESR_WAK_INT)
>=20
>  /* FLEXCAN interrupt flag register (IFLAG) bits */
>  /* Errata ERR005829 step7: Reserve first valid MB */ @@ -191,6 +197,7 @@
>  #define FLEXCAN_QUIRK_USE_OFF_TIMESTAMP	BIT(5) /* Use timestamp
> based offloading */
>  #define FLEXCAN_QUIRK_BROKEN_PERR_STATE	BIT(6) /* No interrupt for
> error passive */
>  #define FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN	BIT(7) /* default to BE
> register access */
> +#define FLEXCAN_QUIRK_SETUP_STOP_MODE	BIT(8) /* Setup stop mode to
> support wakeup */
>=20
>  /* Structure of the message buffer */
>  struct flexcan_mb {
> @@ -255,6 +262,14 @@ struct flexcan_devtype_data {
>  	u32 quirks;		/* quirks needed for different IP cores */
>  };
>=20
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
> @@ -272,6 +287,7 @@ struct flexcan_priv {
>  	struct clk *clk_per;
>  	const struct flexcan_devtype_data *devtype_data;
>  	struct regulator *reg_xceiver;
> +	struct flexcan_stop_mode stm;
>=20
>  	/* Read and Write APIs */
>  	u32 (*read)(void __iomem *addr);
> @@ -295,7 +311,8 @@ static const struct flexcan_devtype_data
> fsl_imx28_devtype_data =3D {
>=20
>  static const struct flexcan_devtype_data fsl_imx6q_devtype_data =3D {
>  	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG |
> FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
> -		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
> FLEXCAN_QUIRK_BROKEN_PERR_STATE,
> +		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
> FLEXCAN_QUIRK_BROKEN_PERR_STATE |
> +		FLEXCAN_QUIRK_SETUP_STOP_MODE,
>  };
>=20
>  static const struct flexcan_devtype_data fsl_vf610_devtype_data =3D { @@
> -392,6 +409,40 @@ static void flexcan_clks_disable(const struct flexcan_p=
riv
> *priv)
>  	clk_disable_unprepare(priv->clk_per);
>  }
>=20
> +static void flexcan_wake_mask_enable(struct flexcan_priv *priv) {
> +	struct flexcan_regs __iomem *regs =3D priv->regs;
> +	u32 reg_mcr;
> +
> +	reg_mcr =3D priv->read(&regs->mcr);
> +	reg_mcr |=3D FLEXCAN_MCR_WAK_MSK;
> +	priv->write(reg_mcr, &regs->mcr);
> +}
> +
> +static void flexcan_wake_mask_disable(struct flexcan_priv *priv) {
> +	struct flexcan_regs __iomem *regs =3D priv->regs;
> +	u32 reg_mcr;
> +
> +	reg_mcr =3D priv->read(&regs->mcr);
> +	reg_mcr &=3D ~FLEXCAN_MCR_WAK_MSK;
> +	priv->write(reg_mcr, &regs->mcr);
> +}
> +

Please combine those two functions into one, also improve the name a bit.
e.g.
flexcan_enable_wakeup_irq(struct flexcan_priv *priv, bool enable)

> +static inline void flexcan_enter_stop_mode(struct flexcan_priv *priv) {
> +	/* enable stop request */
> +	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
> +						1 << priv->stm.req_bit, 1 << priv->stm.req_bit); }
> +
> +static inline void flexcan_exit_stop_mode(struct flexcan_priv *priv) {
> +	/* remove stop request */
> +	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
> +						1 << priv->stm.req_bit, 0);
> +}
> +
>  static inline int flexcan_transceiver_enable(const struct flexcan_priv *=
priv)  {
>  	if (!priv->reg_xceiver)
> @@ -955,6 +1006,10 @@ static int flexcan_chip_start(struct net_device *de=
v)
>  		reg_mcr |=3D FLEXCAN_MCR_FEN |
>  			FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
>  	}
> +
> +	/* enable self wakeup */
> +	reg_mcr |=3D FLEXCAN_MCR_SLF_WAK;
> +

Should we check before setting as we already have a SETUP_STOP_MODE quirk?

>  	netdev_dbg(dev, "%s: writing mcr=3D0x%08x", __func__, reg_mcr);
>  	priv->write(reg_mcr, &regs->mcr);
>=20
> @@ -1240,6 +1295,60 @@ static void unregister_flexcandev(struct net_devic=
e
> *dev)
>  	unregister_candev(dev);
>  }
>=20
> +static int flexcan_setup_stop_mode(struct platform_device *pdev) {
> +	struct net_device *dev =3D platform_get_drvdata(pdev);
> +	struct device_node *np =3D pdev->dev.of_node;
> +	struct device_node *node;

Probably gpr_np is better.

> +	struct flexcan_priv *priv;
> +	bool wakeup =3D true;
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
> +	dev_dbg(&pdev->dev, "gpr %s req_gpr 0x%x req_bit %u ack_gpr 0x%x
> ack_bit %u\n",
> +			node->full_name, priv->stm.req_gpr,
> +			priv->stm.req_bit, priv->stm.ack_gpr,
> +			priv->stm.ack_bit);
> +
> +	device_set_wakeup_capable(&pdev->dev, wakeup);

If 'wakeup' variable is not changeable, then not need use it.

> +
> +	return 0;
> +}
> +
>  static const struct of_device_id flexcan_of_match[] =3D {
>  	{ .compatible =3D "fsl,imx6q-flexcan", .data =3D &fsl_imx6q_devtype_dat=
a, },
>  	{ .compatible =3D "fsl,imx28-flexcan", .data =3D &fsl_imx28_devtype_dat=
a, },
> @@ -1400,6 +1509,12 @@ static int flexcan_probe(struct platform_device
> *pdev)
>=20
>  	devm_can_led_init(dev);
>=20
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE) {
> +		err =3D flexcan_setup_stop_mode(pdev);
> +		if (err)
> +			dev_dbg(&pdev->dev, "failed to setup stop-mode\n");
> +	}
> +
>  	pm_runtime_put(&pdev->dev);
>=20
>  	dev_info(&pdev->dev, "device registered (reg_base=3D%p, irq=3D%d)\n", @=
@
> -1437,10 +1552,18 @@ static int __maybe_unused flexcan_suspend(struct
> device *device)
>  	int err =3D 0;
>=20
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

This is mixed with runtime pm.
I would suggestion you first upstream wakeup support.
Then runtime pm later separately.

Regards
Dong Aisheng

> +		}
>=20
>  		netif_stop_queue(dev);
>  		netif_device_detach(dev);
> @@ -1461,10 +1584,14 @@ static int __maybe_unused
> flexcan_resume(struct device *device)
>  		netif_device_attach(dev);
>  		netif_start_queue(dev);
>=20
> -		err =3D pm_runtime_force_resume(device);
> -		if (err)
> -			return err;
> -		err =3D flexcan_chip_enable(priv);
> +		if (device_may_wakeup(device)) {
> +			flexcan_wake_mask_disable(priv);
> +		} else {
> +			err =3D pm_runtime_force_resume(device);
> +			if (err)
> +				return err;
> +			err =3D flexcan_chip_enable(priv);
> +		}
>  	}
>  	return err;
>  }
> @@ -1489,10 +1616,34 @@ static int __maybe_unused
> flexcan_runtime_resume(struct device *device)
>  	return 0;
>  }
>=20
> +static int __maybe_unused flexcan_noirq_suspend(struct device *device)
> +{
> +	struct net_device *dev =3D dev_get_drvdata(device);
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +
> +	if (netif_running(dev) && device_may_wakeup(device))
> +		flexcan_wake_mask_enable(priv);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused flexcan_noirq_resume(struct device *device) {
> +	struct net_device *dev =3D dev_get_drvdata(device);
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +
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
> -	SET_RUNTIME_PM_OPS(flexcan_runtime_suspend,
> flexcan_runtime_resume,
> -						NULL)
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(flexcan_noirq_suspend,
> flexcan_noirq_resume)
> +	SET_RUNTIME_PM_OPS(flexcan_runtime_suspend,
> flexcan_runtime_resume,
> +NULL)
>  };
>=20
>  static struct platform_driver flexcan_driver =3D {
> --
> 2.17.1
