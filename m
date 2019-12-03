From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH V2 2/4] can: flexcan: try to exit stop mode during probe
 stage
Date: Tue, 3 Dec 2019 19:14:43 +0100
Message-ID: <ad7e7b15-26f3-daa1-02d2-782ff548756d@pengutronix.de>
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-3-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="VrN6U5vdUimsFlJbMXEBNc31sgUCZSRzq"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191127055334.1476-3-qiangqing.zhang@nxp.com>
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com" <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VrN6U5vdUimsFlJbMXEBNc31sgUCZSRzq
Content-Type: multipart/mixed; boundary="1F5tyDKUqYTdgbJ3Qoh3wjMf89MtzP1T3";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "sean@geanix.com"
 <sean@geanix.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <ad7e7b15-26f3-daa1-02d2-782ff548756d@pengutronix.de>
Subject: Re: [PATCH V2 2/4] can: flexcan: try to exit stop mode during probe
 stage
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-3-qiangqing.zhang@nxp.com>
In-Reply-To: <20191127055334.1476-3-qiangqing.zhang@nxp.com>

--1F5tyDKUqYTdgbJ3Qoh3wjMf89MtzP1T3
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/27/19 6:56 AM, Joakim Zhang wrote:
> CAN controller could be stucked in stop mode once it enters stop mode
                          ^^^^^^^ stuck
> when suspend, and then it fails to exit stop mode when resume.

How can this happen?

> Only code reset can get CAN out of stop mode,

What is "code reset"?

> so add stop mode remove request during probe stage for other
> methods(soft reset from chip level, unbind/bind driver, etc) to let
        ^^^ please add a space
> CAN active again.

Can you rephrase the sentence after "so add stop mode remove request
during probe stage". I'm not completely sure what you want to tell.

> MCR[LPMACK] will be checked when enable CAN in=20
> register_flexcandev().
>=20
> Suggested-by: Sean Nyekjaer <sean@geanix.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ------
> ChangeLog:
> 	V1->V2: new add.
> ---
>  drivers/net/can/flexcan.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 2297663cacb2..5d5ed28d3005 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -449,6 +449,13 @@ static inline int flexcan_exit_stop_mode(struct fl=
excan_priv *priv)
>  	return 0;
>  }
> =20
> +static void flexcan_try_exit_stop_mode(struct flexcan_priv *priv)
> +{
> +	/* remove stop request */
> +	regmap_update_bits(priv->stm.gpr, priv->stm.req_gpr,
> +			   1 << priv->stm.req_bit, 0);
> +}
> +
>  static inline void flexcan_error_irq_enable(const struct flexcan_priv =
*priv)
>  {
>  	struct flexcan_regs __iomem *regs =3D priv->regs;
> @@ -1649,6 +1656,21 @@ static int flexcan_probe(struct platform_device =
*pdev)
>  	priv->devtype_data =3D devtype_data;
>  	priv->reg_xceiver =3D reg_xceiver;
> =20
> +	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE) {
> +		err =3D flexcan_setup_stop_mode(pdev);
> +		if (err)
> +			dev_dbg(&pdev->dev, "failed to setup stop-mode\n");
> +
> +		/* CAN controller could be stucked in stop mode once it enters
> +		 * stop mode when suspend, and then it fails to exit stop
> +		 * mode when resume. Only code reset can get CAN out of stop
> +		 * mode, so add stop mode remove request here for other methods
> +		 * (soft reset, bind, etc) to let CAN active again. MCR[LPMACK]
> +		 * will be checked when enable CAN in register_flexcandev().
> +		 */
> +		flexcan_try_exit_stop_mode(priv);
> +	}
> +
>  	pm_runtime_get_noresume(&pdev->dev);
>  	pm_runtime_set_active(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
> @@ -1661,12 +1683,6 @@ static int flexcan_probe(struct platform_device =
*pdev)
> =20
>  	devm_can_led_init(dev);
> =20
> -	if (priv->devtype_data->quirks & FLEXCAN_QUIRK_SETUP_STOP_MODE) {
> -		err =3D flexcan_setup_stop_mode(pdev);
> -		if (err)
> -			dev_dbg(&pdev->dev, "failed to setup stop-mode\n");
> -	}
> -
>  	return 0;
> =20
>   failed_register:
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--1F5tyDKUqYTdgbJ3Qoh3wjMf89MtzP1T3--

--VrN6U5vdUimsFlJbMXEBNc31sgUCZSRzq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3mphMACgkQWsYho5Hk
nSCg4gf+Kbn7Hg/oriUAAWf5Rn7kNzxRMupwOWre8I/hWOazqQ094ZegCQhKNejM
poABLlu7UIeyAyAzAGuTH17mM+ZtJVj9DseGMeg3EdL5wQ9izHmLLt8GAZMv0AZg
iiW6LLVAnhm4IAG9MOC9cXIa/IZYIpXjeq1wG7z03MpkYZV9HzPWNoaOe6he1iBm
bsdQj3a3H0FgJs9ap+3Qm0jOs0kF+nmLqfuw/nqxPlCIHC34nR6Piyqc5Z1qCEJS
OfPMVBNBEq828eOi/jLXDxY+Z+tcxD6TuRMkKj9KMunneVx1fblKv1NVtLMKb/NU
UYqdw/Q8Sr/0zz2lXl5i7YwESYQ6MA==
=zlog
-----END PGP SIGNATURE-----

--VrN6U5vdUimsFlJbMXEBNc31sgUCZSRzq--
