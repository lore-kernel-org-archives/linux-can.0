From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V2 4/4] can: flexcan: add LPSR mode support
Date: Wed, 4 Dec 2019 10:20:48 +0100
Message-ID: <31323458-7807-3e7c-7689-19cb38a23647@pengutronix.de>
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-5-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="PRA8ZkKg6F55VabPrUOVJ2U2Z1bz6urPZ"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191127055334.1476-5-qiangqing.zhang@nxp.com>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com" <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PRA8ZkKg6F55VabPrUOVJ2U2Z1bz6urPZ
Content-Type: multipart/mixed; boundary="3Yw3h1SthmN1G4RDLVxweoiEw4YwermQL";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com"
 <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <31323458-7807-3e7c-7689-19cb38a23647@pengutronix.de>
Subject: Re: [PATCH V2 4/4] can: flexcan: add LPSR mode support
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-5-qiangqing.zhang@nxp.com>
In-Reply-To: <20191127055334.1476-5-qiangqing.zhang@nxp.com>

--3Yw3h1SthmN1G4RDLVxweoiEw4YwermQL
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

chip_stop calls chip_disable, but doesn't propagate the error value.
Please create a seperate patch to propagate the error value of chip_stop(=
).

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--3Yw3h1SthmN1G4RDLVxweoiEw4YwermQL--

--PRA8ZkKg6F55VabPrUOVJ2U2Z1bz6urPZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3nenAACgkQWsYho5Hk
nSCGOQf+M1wxA/XcsWP/GrINFbFzCrJECkp9AA/lPfxO27RLUq7eiC5iLEqw44QM
Vt7BHH3200lRgbaiCvBbZAefBPju2PKAnN3xITYaNz4iyXT+zrga+HX01toYsWVp
/kv8w9huCnfI1c1IfkK+44r1XxTEXl3FQqg6rc/TG7rgvs0BeuG0uXiLKaZyKpNT
ys+11R4ZZAetOjMP9ub4OFUF1l0OM5xcNfWLC+t/SnW4A3rVE7PZ4B7w53VrmWAg
AcZU2S5cLeGrGgS1GD54YHtP6+tRkdaBcsVepc+aeK6C67A3aAnQS/mYoicHajuq
oSPdRR2JB16z2JFrLD+fhCoGjAcQsQ==
=Hd3Y
-----END PGP SIGNATURE-----

--PRA8ZkKg6F55VabPrUOVJ2U2Z1bz6urPZ--
