From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V2 4/4] can: flexcan: add LPSR mode support
Date: Wed, 4 Dec 2019 09:59:47 +0100
Message-ID: <28bce2f5-8d49-d803-60c7-a8dec87a4fa6@pengutronix.de>
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-5-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2XN7p9j71DSfZTsmLheCRczCVheTB7GqJ"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191127055334.1476-5-qiangqing.zhang@nxp.com>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com" <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2XN7p9j71DSfZTsmLheCRczCVheTB7GqJ
Content-Type: multipart/mixed; boundary="NnMIR6Dd7WD9g2IYaDxYlHl9Y0q0ZZSJ4";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com"
 <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <28bce2f5-8d49-d803-60c7-a8dec87a4fa6@pengutronix.de>
Subject: Re: [PATCH V2 4/4] can: flexcan: add LPSR mode support
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-5-qiangqing.zhang@nxp.com>
In-Reply-To: <20191127055334.1476-5-qiangqing.zhang@nxp.com>

--NnMIR6Dd7WD9g2IYaDxYlHl9Y0q0ZZSJ4
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/27/19 6:56 AM, Joakim Zhang wrote:
> For i.MX7D LPSR mode, the controller will lost power and got the
> configuration state lost after system resume back. (coming i.MX8QM/QXP
> will also completely power off the domain, the controller state will be=

> lost and needs restore).
> So we need to set pinctrl state again and re-start chip to do
> re-configuration after resume.
>=20
> For wakeup case, it should not set pinctrl to sleep state by
> pinctrl_pm_select_sleep_state.
> For interface is not up before suspend case, we don't need
> re-configure as it will be configured by user later by interface up.
>=20
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ------
> ChangeLog:
> 	V1->V2: no change.
> ---
>  drivers/net/can/flexcan.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index d178146b3da5..d1509cffdd24 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -26,6 +26,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/regmap.h>
> =20
>  #define DRV_NAME			"flexcan"
> @@ -1707,7 +1708,7 @@ static int __maybe_unused flexcan_suspend(struct =
device *device)
>  {
>  	struct net_device *dev =3D dev_get_drvdata(device);
>  	struct flexcan_priv *priv =3D netdev_priv(dev);
> -	int err =3D 0;
> +	int err;
> =20
>  	if (netif_running(dev)) {
>  		/* if wakeup is enabled, enter stop mode
> @@ -1719,25 +1720,27 @@ static int __maybe_unused flexcan_suspend(struc=
t device *device)
>  			if (err)
>  				return err;
>  		} else {
> -			err =3D flexcan_chip_disable(priv);
> +			flexcan_chip_stop(dev);
> +
> +			err =3D pm_runtime_force_suspend(device);
>  			if (err)
>  				return err;
> =20
> -			err =3D pm_runtime_force_suspend(device);
> +			pinctrl_pm_select_sleep_state(device);

Please add error handling for pinctrl_pm_select_sleep_state().

>  		}
>  		netif_stop_queue(dev);
>  		netif_device_detach(dev);
>  	}
>  	priv->can.state =3D CAN_STATE_SLEEPING;
> =20
> -	return err;
> +	return 0;
>  }
> =20
>  static int __maybe_unused flexcan_resume(struct device *device)
>  {
>  	struct net_device *dev =3D dev_get_drvdata(device);
>  	struct flexcan_priv *priv =3D netdev_priv(dev);
> -	int err =3D 0;
> +	int err;
> =20
>  	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
>  	if (netif_running(dev)) {
> @@ -1749,15 +1752,19 @@ static int __maybe_unused flexcan_resume(struct=
 device *device)
>  			if (err)
>  				return err;
>  		} else {
> +			pinctrl_pm_select_default_state(device);

same here

> +
>  			err =3D pm_runtime_force_resume(device);
>  			if (err)
>  				return err;
> =20
> -			err =3D flexcan_chip_enable(priv);
> +			err =3D flexcan_chip_start(dev);
> +			if (err)
> +				return err;
>  		}
>  	}
> =20
> -	return err;
> +	return 0;
>  }
> =20
>  static int __maybe_unused flexcan_runtime_suspend(struct device *devic=
e)
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--NnMIR6Dd7WD9g2IYaDxYlHl9Y0q0ZZSJ4--

--2XN7p9j71DSfZTsmLheCRczCVheTB7GqJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3ndYMACgkQWsYho5Hk
nSCb2gf+MoTZgmlx34RO9exffzTEtK/zhDd42ftubN7UwqHW+Tb/VWdHEEyU+4ko
kFLF862M1m0nIdLeHrCSxZMRXK6Fesa9RjhFXTCib8RTBpEMez3fbUN1bhAe/VAm
9R6fCYZQJGX0gmvZWmBEkHR92DdLZcMw0Q/Aomy+MBP/NvUVFLp1o7Nqj6uv4sOZ
azKuEyWgplU14Wr3VNSrHqee3BnCP/MQIwDUcE0CTxHwS+8aqq6Of51CQlUGuhf1
8/sBWdn/tMermH5tsKvdyNHbdTMtBW0F5YUUlFNNBKcM/+rgx+B6/M3hUsUuNFp5
SNOxYlrZU6Yg6LuZGh7g4/k3aIZYEA==
=v/Df
-----END PGP SIGNATURE-----

--2XN7p9j71DSfZTsmLheCRczCVheTB7GqJ--
