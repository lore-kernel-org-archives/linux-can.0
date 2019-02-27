From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V4] can: flexcan: implement can Runtime PM
Date: Wed, 27 Feb 2019 11:35:16 +0100
Message-ID: <433080fe-4266-c140-1a1f-078480b8bf7b@pengutronix.de>
References: <20181130085119.7948-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="LucLFBBEh0yyiadEaVzkNGtzk8ZvF9HYd"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181130085119.7948-1-qiangqing.zhang@nxp.com>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Aisheng DONG <aisheng.dong@nxp.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LucLFBBEh0yyiadEaVzkNGtzk8ZvF9HYd
Content-Type: multipart/mixed; boundary="dO1zM7kpYBVUYxlJzM6hyzrGfWmF8vsRr";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Aisheng DONG <aisheng.dong@nxp.com>
Message-ID: <433080fe-4266-c140-1a1f-078480b8bf7b@pengutronix.de>
Subject: Re: [PATCH V4] can: flexcan: implement can Runtime PM
References: <20181130085119.7948-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181130085119.7948-1-qiangqing.zhang@nxp.com>

--dO1zM7kpYBVUYxlJzM6hyzrGfWmF8vsRr
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/30/18 9:53 AM, Joakim Zhang wrote:
> From: Aisheng Dong <aisheng.dong@nxp.com>
>=20
> Flexcan will be disabled during suspend if no wakeup function required =
and
> enabled after resume accordingly. During this period, we could explicit=
ly
> disable clocks.
> Since PM is optional, the clock is enabled at probe to guarante the
> clock is running when PM is not enabled in the kernel.
>=20
> Implement Runtime PM which will:
> 1) Without CONFIG_PM, clock is running whether Flexcan up or down.
> 2) With CONFIG_PM, clock enabled while Flexcan up and disabled when
>    Flexcan down.
> 3) Disable clock when do system suspend and enable clock while system
>    resume.
> 4) Make Power Domain framework be able to shutdown the corresponding
>    power domain of this device.
>=20
> Signed-off-by: Aisheng Dong <aisheng.dong@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
> ChangeLog:
> V1->V2:
> 	*rebased on patch "can: flexcan: add self wakeup support".
> V2->V3:
> 	*fix device fails to probe without CONFIG_PM.
> V3->V4:
> 	*runtime pm enable should ahead of registering device.
> 	*disable device even if keeping the clocks on.
> ---
>  drivers/net/can/flexcan.c | 111 +++++++++++++++++++++++++-------------=

>  1 file changed, 73 insertions(+), 38 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 0f36eafe3ac1..cad42f20cfe5 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -24,6 +24,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/regmap.h>
> =20
> @@ -277,6 +278,7 @@ struct flexcan_priv {
>  	u32 reg_imask1_default;
>  	u32 reg_imask2_default;
> =20
> +	struct device *dev;
>  	struct clk *clk_ipg;
>  	struct clk *clk_per;
>  	const struct flexcan_devtype_data *devtype_data;
> @@ -444,6 +446,27 @@ static inline void flexcan_error_irq_disable(const=
 struct flexcan_priv *priv)
>  	priv->write(reg_ctrl, &regs->ctrl);
>  }
> =20
> +static int flexcan_clks_enable(const struct flexcan_priv *priv)
> +{
> +	int err;
> +
> +	err =3D clk_prepare_enable(priv->clk_ipg);
> +	if (err)
> +		return err;
> +
> +	err =3D clk_prepare_enable(priv->clk_per);
> +	if (err)
> +		clk_disable_unprepare(priv->clk_ipg);
> +
> +	return err;
> +}
> +
> +static void flexcan_clks_disable(const struct flexcan_priv *priv)
> +{
> +	clk_disable_unprepare(priv->clk_ipg);
> +	clk_disable_unprepare(priv->clk_per);

The original code first disabled the per then the ipg.

> +}
> +
>  static inline int flexcan_transceiver_enable(const struct flexcan_priv=
 *priv)
>  {
>  	if (!priv->reg_xceiver)
> @@ -570,19 +593,13 @@ static int flexcan_get_berr_counter(const struct =
net_device *dev,
>  	const struct flexcan_priv *priv =3D netdev_priv(dev);
>  	int err;
> =20
> -	err =3D clk_prepare_enable(priv->clk_ipg);
> -	if (err)
> +	err =3D pm_runtime_get_sync(priv->dev);
> +	if (err < 0)
>  		return err;
> =20
> -	err =3D clk_prepare_enable(priv->clk_per);
> -	if (err)
> -		goto out_disable_ipg;
> -
>  	err =3D __flexcan_get_berr_counter(dev, bec);
> =20
> -	clk_disable_unprepare(priv->clk_per);
> - out_disable_ipg:
> -	clk_disable_unprepare(priv->clk_ipg);
> +	pm_runtime_put(priv->dev);
> =20
>  	return err;
>  }
> @@ -1215,17 +1232,13 @@ static int flexcan_open(struct net_device *dev)=

>  	struct flexcan_priv *priv =3D netdev_priv(dev);
>  	int err;
> =20
> -	err =3D clk_prepare_enable(priv->clk_ipg);
> -	if (err)
> +	err =3D pm_runtime_get_sync(priv->dev);
> +	if (err < 0)
>  		return err;
> =20
> -	err =3D clk_prepare_enable(priv->clk_per);
> -	if (err)
> -		goto out_disable_ipg;
> -
>  	err =3D open_candev(dev);
>  	if (err)
> -		goto out_disable_per;
> +		goto out_disable_clks;

nitpick: you do a pm_runtime_put, so rename the label...

> =20
>  	err =3D request_irq(dev->irq, flexcan_irq, IRQF_SHARED, dev->name, de=
v);
>  	if (err)
> @@ -1288,10 +1301,8 @@ static int flexcan_open(struct net_device *dev)
>  	free_irq(dev->irq, dev);
>   out_close:
>  	close_candev(dev);
> - out_disable_per:
> -	clk_disable_unprepare(priv->clk_per);
> - out_disable_ipg:
> -	clk_disable_unprepare(priv->clk_ipg);
> + out_disable_clks:
> +	pm_runtime_put(priv->dev);

=2E..to out_runtime_put

> =20
>  	return err;
>  }
> @@ -1306,10 +1317,9 @@ static int flexcan_close(struct net_device *dev)=

> =20
>  	can_rx_offload_del(&priv->offload);
>  	free_irq(dev->irq, dev);
> -	clk_disable_unprepare(priv->clk_per);
> -	clk_disable_unprepare(priv->clk_ipg);
> =20
>  	close_candev(dev);
> +	pm_runtime_put(priv->dev);
> =20
>  	can_led_event(dev, CAN_LED_EVENT_STOP);
> =20
> @@ -1349,18 +1359,14 @@ static int register_flexcandev(struct net_devic=
e *dev)
>  	struct flexcan_regs __iomem *regs =3D priv->regs;
>  	u32 reg, err;
> =20
> -	err =3D clk_prepare_enable(priv->clk_ipg);
> +	err =3D flexcan_clks_enable(priv);
>  	if (err)
>  		return err;
> =20
> -	err =3D clk_prepare_enable(priv->clk_per);
> -	if (err)
> -		goto out_disable_ipg;
> -
>  	/* select "bus clock", chip must be disabled */
>  	err =3D flexcan_chip_disable(priv);
>  	if (err)
> -		goto out_disable_per;
> +		goto out_disable_clks;

nitpick: The function is called lexcan_clks_disable(), so let's rename
the label accordingly.

>  	reg =3D priv->read(&regs->ctrl);
>  	reg |=3D FLEXCAN_CTRL_CLK_SRC;
>  	priv->write(reg, &regs->ctrl);
> @@ -1389,14 +1395,13 @@ static int register_flexcandev(struct net_devic=
e *dev)
> =20
>  	err =3D register_candev(dev);

No error handling?

> =20
> -	/* disable core and turn off clocks */

Better move the pm_runtime_put() here and adjust the comment.

> - out_chip_disable:
>  	flexcan_chip_disable(priv);
> - out_disable_per:
> -	clk_disable_unprepare(priv->clk_per);
> - out_disable_ipg:
> -	clk_disable_unprepare(priv->clk_ipg);
> +	return 0;
> =20
> + out_chip_disable:
> +	flexcan_chip_disable(priv);
> + out_disable_clks:
> +	flexcan_clks_disable(priv);
>  	return err;
>  }
> =20
> @@ -1556,6 +1561,7 @@ static int flexcan_probe(struct platform_device *=
pdev)
>  		priv->write =3D flexcan_write_le;
>  	}
> =20
> +	priv->dev =3D &pdev->dev;
>  	priv->can.clock.freq =3D clock_freq;
>  	priv->can.bittiming_const =3D &flexcan_bittiming_const;
>  	priv->can.do_set_mode =3D flexcan_set_mode;
> @@ -1569,6 +1575,10 @@ static int flexcan_probe(struct platform_device =
*pdev)
>  	priv->devtype_data =3D devtype_data;
>  	priv->reg_xceiver =3D reg_xceiver;
> =20
> +	pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +
>  	err =3D register_flexcandev(dev);
>  	if (err) {
>  		dev_err(&pdev->dev, "registering netdev failed\n");
> @@ -1586,6 +1596,7 @@ static int flexcan_probe(struct platform_device *=
pdev)
>  	dev_info(&pdev->dev, "device registered (reg_base=3D%p, irq=3D%d)\n",=

>  		 priv->regs, dev->irq);
> =20
> +	pm_runtime_put(&pdev->dev);
>  	return 0;
> =20
>   failed_register:
> @@ -1598,6 +1609,7 @@ static int flexcan_remove(struct platform_device =
*pdev)
>  	struct net_device *dev =3D platform_get_drvdata(pdev);
> =20
>  	unregister_flexcandev(dev);
> +	pm_runtime_disable(&pdev->dev);
>  	free_candev(dev);
> =20
>  	return 0;
> @@ -1607,7 +1619,7 @@ static int __maybe_unused flexcan_suspend(struct =
device *device)
>  {
>  	struct net_device *dev =3D dev_get_drvdata(device);
>  	struct flexcan_priv *priv =3D netdev_priv(dev);
> -	int err;
> +	int err =3D 0;
> =20
>  	if (netif_running(dev)) {
>  		/* if wakeup is enabled, enter stop mode
> @@ -1620,20 +1632,22 @@ static int __maybe_unused flexcan_suspend(struc=
t device *device)
>  			err =3D flexcan_chip_disable(priv);
>  			if (err)
>  				return err;
> +
> +			err =3D pm_runtime_force_suspend(device);
>  		}
>  		netif_stop_queue(dev);
>  		netif_device_detach(dev);
>  	}
>  	priv->can.state =3D CAN_STATE_SLEEPING;
> =20
> -	return 0;
> +	return err;
>  }
> =20
>  static int __maybe_unused flexcan_resume(struct device *device)
>  {
>  	struct net_device *dev =3D dev_get_drvdata(device);
>  	struct flexcan_priv *priv =3D netdev_priv(dev);
> -	int err;
> +	int err =3D 0;
> =20
>  	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
>  	if (netif_running(dev)) {
> @@ -1642,14 +1656,34 @@ static int __maybe_unused flexcan_resume(struct=
 device *device)
>  		if (device_may_wakeup(device)) {
>  			disable_irq_wake(dev->irq);
>  		} else {
> -			err =3D flexcan_chip_enable(priv);
> +			err =3D pm_runtime_force_resume(device);
>  			if (err)
>  				return err;
> +
> +			err =3D flexcan_chip_enable(priv);
>  		}
>  	}
> +	return err;
> +}
> +
> +static int __maybe_unused flexcan_runtime_suspend(struct device *devic=
e)
> +{
> +	struct net_device *dev =3D dev_get_drvdata(device);
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +
> +	flexcan_clks_disable(priv);
> +
>  	return 0;
>  }
> =20
> +static int __maybe_unused flexcan_runtime_resume(struct device *device=
)
> +{
> +	struct net_device *dev =3D dev_get_drvdata(device);
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +
> +	return flexcan_clks_enable(priv);
> +}
> +
>  static int __maybe_unused flexcan_noirq_suspend(struct device *device)=

>  {
>  	struct net_device *dev =3D dev_get_drvdata(device);
> @@ -1676,6 +1710,7 @@ static int __maybe_unused flexcan_noirq_resume(st=
ruct device *device)
> =20
>  static const struct dev_pm_ops flexcan_pm_ops =3D {
>  	SET_SYSTEM_SLEEP_PM_OPS(flexcan_suspend, flexcan_resume)
> +	SET_RUNTIME_PM_OPS(flexcan_runtime_suspend, flexcan_runtime_resume, N=
ULL)
>  	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(flexcan_noirq_suspend, flexcan_noirq_re=
sume)
>  };
> =20
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--dO1zM7kpYBVUYxlJzM6hyzrGfWmF8vsRr--

--LucLFBBEh0yyiadEaVzkNGtzk8ZvF9HYd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlx2Z+QACgkQWsYho5Hk
nSBa8wgAgaakeXyJ4+SfYMRKR37iNb2mMGZPj545mI66fqFo+TzZDxvaG0QHFTha
jO9HReg9Y+8v186vWtFzsNxuQ3ZJQFFqoC0KiPciD2kYJpjfK5lbxMuvA7MMadod
Xrqn2NLrwSpdm4OYH4ocu/AC/wqBhD0+IO+jvr1y0zJRjoMRxidkOo54tp74Z0Fd
P+G5mdM7+SwfKdgT1WbV2bVlPnS/Z8TGfPMP572kwnvXV+L3/13mRdSw5ofXA9I4
IjXkHhdoVd/Add8aV74V4lX/hFmymdDLvyC4nmtLdoGmWQbRDrPeO/pZxW3z7QSd
EwSj6dTpWdJ6cGRuktRmPIdM4ACZSQ==
=OAgi
-----END PGP SIGNATURE-----

--LucLFBBEh0yyiadEaVzkNGtzk8ZvF9HYd--
