From: Aisheng DONG <aisheng.dong@nxp.com>
Subject: RE: [PATCH V4 1/1] can: flexcan: add self wakeup support
Date: Thu, 22 Nov 2018 02:30:46 +0000
Message-ID: <AM0PR04MB4211B8283948F8DB63115DD580DB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20181121122957.2684-1-qiangqing.zhang@nxp.com>
 <20181121122957.2684-2-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121122957.2684-2-qiangqing.zhang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "mkl@pengutronix.de" <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-can.vger.kernel.org

[...]

> +
> +static int __maybe_unused flexcan_noirq_suspend(struct device *device)
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
> +static int __maybe_unused flexcan_noirq_resume(struct device *device) {
> +	struct net_device *dev =3D dev_get_drvdata(device);
> +	struct flexcan_priv *priv =3D netdev_priv(dev);
> +
> +	if (netif_running(dev) && device_may_wakeup(device)) {
> +		disable_irq_wake(dev->irq);

A bit more thinking:
Can we put flexcan_enable_wakeup_irq(priv, false) here and move disable_irq=
_wake
to resume function?
Then it looks better on pairs for those functions.

I'm not sure if irq will be lost or we may even not need wakeup irq.
Please help check it.

Regards
Dong Aisheng

> +		flexcan_exit_stop_mode(priv);
>  	}
> +
>  	return 0;
>  }
>=20
> -static SIMPLE_DEV_PM_OPS(flexcan_pm_ops, flexcan_suspend,
> flexcan_resume);
> +static const struct dev_pm_ops flexcan_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(flexcan_suspend, flexcan_resume)
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(flexcan_noirq_suspend,
> +flexcan_noirq_resume) };
>=20
>  static struct platform_driver flexcan_driver =3D {
>  	.driver =3D {
> --
> 2.17.1
