From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V3 1/1] can: flexcan: Add self wakeup support
Date: Thu, 22 Nov 2018 10:48:43 +0100
Message-ID: <af4e2030-c54d-d613-972a-25769bdff199@pengutronix.de>
References: <20181112015047.4252-1-qiangqing.zhang@nxp.com>
 <20181112015047.4252-2-qiangqing.zhang@nxp.com>
 <AM0PR04MB4211BE08EADBACBEC809067E80DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="G0kngbWH7G2O2MlycfNMuLUIXASNLH0P7"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM0PR04MB4211BE08EADBACBEC809067E80DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aisheng DONG <aisheng.dong@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G0kngbWH7G2O2MlycfNMuLUIXASNLH0P7
Content-Type: multipart/mixed; boundary="JVY2nIkGkeQm1dy3xSsTS4CdweqetRit1";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Aisheng DONG <aisheng.dong@nxp.com>,
 Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>
Message-ID: <af4e2030-c54d-d613-972a-25769bdff199@pengutronix.de>
Subject: Re: [PATCH V3 1/1] can: flexcan: Add self wakeup support
References: <20181112015047.4252-1-qiangqing.zhang@nxp.com>
 <20181112015047.4252-2-qiangqing.zhang@nxp.com>
 <AM0PR04MB4211BE08EADBACBEC809067E80DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4211BE08EADBACBEC809067E80DA0@AM0PR04MB4211.eurprd04.prod.outlook.com>

--JVY2nIkGkeQm1dy3xSsTS4CdweqetRit1
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/21/18 4:34 AM, Aisheng DONG wrote:
>> -----Original Message-----
>> From: Joakim Zhang
> [...]
>>
>> If wakeup is enabled, enter stop mode, else enter disabled mode.Self w=
ake can
>> only work on stop mode.
>>
>> Starting from IMX6, the flexcan stop mode control bits is SoC specific=
, move it
>> out of IP driver and parse it from devicetree.
>>
>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
>> ---
>>  drivers/net/can/flexcan.c | 175
>> +++++++++++++++++++++++++++++++++++---
>>  1 file changed, 163 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c ind=
ex
>> 3813f6708201..d21d0db8c83e 100644
>> --- a/drivers/net/can/flexcan.c
>> +++ b/drivers/net/can/flexcan.c
>> @@ -19,12 +19,17 @@
>>  #include <linux/delay.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/list.h>
>=20
> This two lines seems not neccesary
>=20
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/regulator/consumer.h>
>> +#include <linux/regmap.h>
>>
>>  #define DRV_NAME			"flexcan"
>>
>> @@ -132,7 +137,8 @@
>>  	(FLEXCAN_ESR_ERR_BUS | FLEXCAN_ESR_ERR_STATE)  #define
>> FLEXCAN_ESR_ALL_INT \
>>  	(FLEXCAN_ESR_TWRN_INT | FLEXCAN_ESR_RWRN_INT | \
>> -	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
>> +	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT | \
>> +	 FLEXCAN_ESR_WAK_INT)
>>
>>  /* FLEXCAN interrupt flag register (IFLAG) bits */
>>  /* Errata ERR005829 step7: Reserve first valid MB */ @@ -191,6 +197,7=
 @@
>>  #define FLEXCAN_QUIRK_USE_OFF_TIMESTAMP	BIT(5) /* Use timestamp
>> based offloading */
>>  #define FLEXCAN_QUIRK_BROKEN_PERR_STATE	BIT(6) /* No interrupt for
>> error passive */
>>  #define FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN	BIT(7) /* default to BE
>> register access */
>> +#define FLEXCAN_QUIRK_SETUP_STOP_MODE	BIT(8) /* Setup stop mode to
>> support wakeup */
>>
>>  /* Structure of the message buffer */
>>  struct flexcan_mb {
>> @@ -255,6 +262,14 @@ struct flexcan_devtype_data {
>>  	u32 quirks;		/* quirks needed for different IP cores */
>>  };
>>
>> +struct flexcan_stop_mode {
>> +	struct regmap *gpr;
>> +	u8 req_gpr;
>> +	u8 req_bit;
>> +	u8 ack_gpr;
>> +	u8 ack_bit;
>> +};
>> +
>>  struct flexcan_priv {
>>  	struct can_priv can;
>>  	struct can_rx_offload offload;
>> @@ -272,6 +287,7 @@ struct flexcan_priv {
>>  	struct clk *clk_per;
>>  	const struct flexcan_devtype_data *devtype_data;
>>  	struct regulator *reg_xceiver;
>> +	struct flexcan_stop_mode stm;
>>
>>  	/* Read and Write APIs */
>>  	u32 (*read)(void __iomem *addr);
>> @@ -295,7 +311,8 @@ static const struct flexcan_devtype_data
>> fsl_imx28_devtype_data =3D {
>>
>>  static const struct flexcan_devtype_data fsl_imx6q_devtype_data =3D {=

>>  	.quirks =3D FLEXCAN_QUIRK_DISABLE_RXFG |
>> FLEXCAN_QUIRK_ENABLE_EACEN_RRS |
>> -		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
>> FLEXCAN_QUIRK_BROKEN_PERR_STATE,
>> +		FLEXCAN_QUIRK_USE_OFF_TIMESTAMP |
>> FLEXCAN_QUIRK_BROKEN_PERR_STATE |
>> +		FLEXCAN_QUIRK_SETUP_STOP_MODE,
>>  };
>>
>>  static const struct flexcan_devtype_data fsl_vf610_devtype_data =3D {=
 @@
>> -392,6 +409,40 @@ static void flexcan_clks_disable(const struct flexca=
n_priv
>> *priv)
>>  	clk_disable_unprepare(priv->clk_per);
>>  }
>>
>> +static void flexcan_wake_mask_enable(struct flexcan_priv *priv) {
>> +	struct flexcan_regs __iomem *regs =3D priv->regs;
>> +	u32 reg_mcr;
>> +
>> +	reg_mcr =3D priv->read(&regs->mcr);
>> +	reg_mcr |=3D FLEXCAN_MCR_WAK_MSK;
>> +	priv->write(reg_mcr, &regs->mcr);
>> +}
>> +
>> +static void flexcan_wake_mask_disable(struct flexcan_priv *priv) {
>> +	struct flexcan_regs __iomem *regs =3D priv->regs;
>> +	u32 reg_mcr;
>> +
>> +	reg_mcr =3D priv->read(&regs->mcr);
>> +	reg_mcr &=3D ~FLEXCAN_MCR_WAK_MSK;
>> +	priv->write(reg_mcr, &regs->mcr);
>> +}
>> +
>=20
> Please combine those two functions into one, also improve the name a bi=
t.
> e.g.
> flexcan_enable_wakeup_irq(struct flexcan_priv *priv, bool enable)
>=20
>> +static inline void flexcan_enter_stop_mode(struct flexcan_priv *priv)=
 {
>> +	/* enable stop request */
>> +	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
>> +						1 << priv->stm.req_bit, 1 << priv->stm.req_bit); }
>> +
>> +static inline void flexcan_exit_stop_mode(struct flexcan_priv *priv) =
{
>> +	/* remove stop request */
>> +	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
>> +						1 << priv->stm.req_bit, 0);
>> +}
>> +
>>  static inline int flexcan_transceiver_enable(const struct flexcan_pri=
v *priv)  {
>>  	if (!priv->reg_xceiver)
>> @@ -955,6 +1006,10 @@ static int flexcan_chip_start(struct net_device =
*dev)
>>  		reg_mcr |=3D FLEXCAN_MCR_FEN |
>>  			FLEXCAN_MCR_MAXMB(priv->tx_mb_idx);
>>  	}
>> +
>> +	/* enable self wakeup */
>> +	reg_mcr |=3D FLEXCAN_MCR_SLF_WAK;
>> +
>=20
> Should we check before setting as we already have a SETUP_STOP_MODE qui=
rk?
>=20
>>  	netdev_dbg(dev, "%s: writing mcr=3D0x%08x", __func__, reg_mcr);
>>  	priv->write(reg_mcr, &regs->mcr);
>>
>> @@ -1240,6 +1295,60 @@ static void unregister_flexcandev(struct net_de=
vice
>> *dev)
>>  	unregister_candev(dev);
>>  }
>>
>> +static int flexcan_setup_stop_mode(struct platform_device *pdev) {
>> +	struct net_device *dev =3D platform_get_drvdata(pdev);
>> +	struct device_node *np =3D pdev->dev.of_node;
>> +	struct device_node *node;
>=20
> Probably gpr_np is better.
>=20
>> +	struct flexcan_priv *priv;
>> +	bool wakeup =3D true;
>> +	phandle phandle;
>> +	u32 out_val[5];
>> +	int ret;
>> +
>> +	if (!np)
>> +		return -EINVAL;
>> +
>> +	/* stop mode property format is:
>> +	 * <&gpr req_gpr req_bit ack_gpr ack_bit>.
>> +	 */
>> +	ret =3D of_property_read_u32_array(np, "fsl,stop-mode", out_val, 5);=

>> +	if (ret) {
>> +		dev_dbg(&pdev->dev, "no stop-mode property\n");
>> +		return ret;
>> +	}
>> +	phandle =3D *out_val;
>> +
>> +	node =3D of_find_node_by_phandle(phandle);
>> +	if (!node) {
>> +		dev_dbg(&pdev->dev, "could not find gpr node by phandle\n");
>> +		return PTR_ERR(node);
>> +	}
>> +
>> +	priv =3D netdev_priv(dev);
>> +	priv->stm.gpr =3D syscon_node_to_regmap(node);
>> +	if (IS_ERR(priv->stm.gpr)) {
>> +		dev_dbg(&pdev->dev, "could not find gpr regmap\n");
>> +		return PTR_ERR(priv->stm.gpr);
>> +	}
>> +
>> +	of_node_put(node);
>> +
>> +	priv->stm.req_gpr =3D out_val[1];
>> +	priv->stm.req_bit =3D out_val[2];
>> +	priv->stm.ack_gpr =3D out_val[3];
>> +	priv->stm.ack_bit =3D out_val[4];
>> +
>> +	dev_dbg(&pdev->dev, "gpr %s req_gpr 0x%x req_bit %u ack_gpr 0x%x
>> ack_bit %u\n",
>> +			node->full_name, priv->stm.req_gpr,
>> +			priv->stm.req_bit, priv->stm.ack_gpr,
>> +			priv->stm.ack_bit);
>> +
>> +	device_set_wakeup_capable(&pdev->dev, wakeup);
>=20
> If 'wakeup' variable is not changeable, then not need use it.
>=20
>> +
>> +	return 0;
>> +}
>> +
>>  static const struct of_device_id flexcan_of_match[] =3D {
>>  	{ .compatible =3D "fsl,imx6q-flexcan", .data =3D &fsl_imx6q_devtype_=
data, },
>>  	{ .compatible =3D "fsl,imx28-flexcan", .data =3D &fsl_imx28_devtype_=
data, },
>> @@ -1400,6 +1509,12 @@ static int flexcan_probe(struct platform_device=

>> *pdev)
>>
>>  	devm_can_led_init(dev);
>>
>> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE) {
>> +		err =3D flexcan_setup_stop_mode(pdev);
>> +		if (err)
>> +			dev_dbg(&pdev->dev, "failed to setup stop-mode\n");
>> +	}
>> +
>>  	pm_runtime_put(&pdev->dev);
>>
>>  	dev_info(&pdev->dev, "device registered (reg_base=3D%p, irq=3D%d)\n"=
, @@
>> -1437,10 +1552,18 @@ static int __maybe_unused flexcan_suspend(struct
>> device *device)
>>  	int err =3D 0;
>>
>>  	if (netif_running(dev)) {
>> -		err =3D flexcan_chip_disable(priv);
>> -		if (err)
>> -			return err;
>> -		err =3D pm_runtime_force_suspend(device);
>> +		/* if wakeup is enabled, enter stop mode
>> +		 * else enter disabled mode.
>> +		 */
>> +		if (device_may_wakeup(device)) {
>> +			enable_irq_wake(dev->irq);
>> +			flexcan_enter_stop_mode(priv);
>> +		} else {
>> +			err =3D flexcan_chip_disable(priv);
>> +			if (err)
>> +				return err;
>> +			err =3D pm_runtime_force_suspend(device);
>=20
> This is mixed with runtime pm.
> I would suggestion you first upstream wakeup support.
> Then runtime pm later separately.

In fact this patch is based on the patch "can: flexcan: Implement CAN
Runtime PM", which is still under review, too.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--JVY2nIkGkeQm1dy3xSsTS4CdweqetRit1--

--G0kngbWH7G2O2MlycfNMuLUIXASNLH0P7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlv2e3sACgkQk9IU1zQo
ZfEDqQf9F/M5v2BLffCu4Lydka09jXYOPmTcwrHeHxSZcmrKQazOQ3pmdiBDVBaS
rrNmjnlod4OlPo5BNDXJ5zpFk6So+MJKDG1Je3gWs7uAGlK6IoKLeC1gaw+gaBOS
0JexweSB0KkNKLLYlGuGLO6OmnXEPA2ALgG7S3ulVvfETZKueMg24OUTSIcRTp/X
Z08FKydIPCbs3s/zdayAJidJBaKc5ZGVGDW/yaDKDtESuKZj37YgC14MjePKHL79
Vp0GPwxhkBx4I9qHB3ff8DuLQiXDFnsvX2Kar3iysGY73hGjUhaQT6qOeI+dX7V+
BRoRH/J2y9AGqExcQPtrNzxXzht/9Q==
=sAZZ
-----END PGP SIGNATURE-----

--G0kngbWH7G2O2MlycfNMuLUIXASNLH0P7--
