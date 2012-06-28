From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Thu, 28 Jun 2012 12:31:56 +0200
Message-ID: <4FEC329C.7070004@pengutronix.de>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org> <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2DBC99A66C381A519E0889D8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:32851 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932898Ab2F1KcQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 06:32:16 -0400
In-Reply-To: <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Hui Wang <jason77.wang@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2DBC99A66C381A519E0889D8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/28/2012 05:21 AM, Shawn Guo wrote:
> The flexcan driver has function pointer transceiver_switch defined in
> flexcan_platform_data for platform codes to hook up their transceiver
> switch implementation.  However this does not cope with device tree
> probe.
>=20
> It's been observed that platforms mostly use gpios to control the
> switch of flexcan transceiver, like enable and standby.  The patch
> adds transceiver switch gpios support into flexcan driver, so that
> platforms booting from device tree can just define properties
> phy-enable-gpios and phy-standby-gpios to have flexcan driver control
> the gpios.

Hmm I'm wondering if transceiver or phy is the correct name here. In
platform_data it's called transceiver_switch.

>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../devicetree/bindings/net/can/fsl-flexcan.txt    |    2 +
>  drivers/net/can/flexcan.c                          |   62 ++++++++++++=
++++++++
>  2 files changed, 64 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt =
b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> index 8ff324e..e0dbac7 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> @@ -15,6 +15,8 @@ Required properties:
>  Optional properties:
> =20
>  - clock-frequency : The oscillator frequency driving the flexcan devic=
e
> +- phy-enable-gpios : Specify the gpio used to enable phy
> +- phy-standby-gpios : Specify the gpio used to put phy into STANDBY mo=
de
> =20
>  Example:
> =20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 38c0690..1ce3f9e 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -26,6 +26,7 @@
>  #include <linux/can/platform/flexcan.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/gpio.h>
>  #include <linux/if_arp.h>
>  #include <linux/if_ether.h>
>  #include <linux/interrupt.h>
> @@ -34,6 +35,7 @@
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_gpio.h>
>  #include <linux/platform_device.h>
>  #include <linux/pinctrl/consumer.h>
> =20
> @@ -180,6 +182,11 @@ struct flexcan_priv {
> =20
>  	struct clk *clk;
>  	struct flexcan_platform_data *pdata;
> +
> +	int phy_en_gpio;
> +	int phy_stby_gpio;
> +	bool phy_en_high;
> +	bool phy_stby_high;
>  };
> =20
>  static struct can_bittiming_const flexcan_bittiming_const =3D {
> @@ -224,6 +231,17 @@ static inline void flexcan_write(u32 val, void __i=
omem *addr)
>   */
>  static void flexcan_transceiver_switch(const struct flexcan_priv *priv=
, int on)
>  {
> +	/*
> +	 * on =3D=3D 1: enable phy and exit standby
> +	 * on =3D=3D 0: disable phy and enter standby
> +	 */
> +	if (gpio_is_valid(priv->phy_en_gpio))
> +		gpio_set_value(priv->phy_en_gpio,
> +			       priv->phy_en_high ? on : !on);
> +	if (gpio_is_valid(priv->phy_stby_gpio))
> +		gpio_set_value(priv->phy_stby_gpio,
> +			       priv->phy_stby_high ? !on : on);
> +
>  	if (priv->pdata && priv->pdata->transceiver_switch)
>  		priv->pdata->transceiver_switch(on);
>  }
> @@ -933,6 +951,10 @@ static int __devinit flexcan_probe(struct platform=
_device *pdev)
>  	resource_size_t mem_size;
>  	int err, irq;
>  	u32 clock_freq =3D 0;
> +	int phy_en_gpio =3D -EINVAL;
> +	int phy_stby_gpio =3D -EINVAL;
> +	bool phy_en_high =3D true;
> +	bool phy_stby_high =3D true;
> =20
>  	pinctrl =3D devm_pinctrl_get_select_default(&pdev->dev);
>  	if (IS_ERR(pinctrl))
> @@ -940,11 +962,46 @@ static int __devinit flexcan_probe(struct platfor=
m_device *pdev)
> =20
>  	if (pdev->dev.of_node) {
>  		const u32 *clock_freq_p;
> +		enum of_gpio_flags flags;
> =20
>  		clock_freq_p =3D of_get_property(pdev->dev.of_node,
>  						"clock-frequency", NULL);
>  		if (clock_freq_p)
>  			clock_freq =3D *clock_freq_p;
> +
> +		phy_en_gpio =3D of_get_named_gpio_flags(pdev->dev.of_node,
> +						      "phy-enable-gpios",
> +						       0, &flags);
> +		if (gpio_is_valid(phy_en_gpio)) {
> +			if (flags =3D=3D OF_GPIO_ACTIVE_LOW)
> +				phy_en_high =3D false;

I really like the "flags" solution, much better than a DT property. What
about keeping the term active_low instead of en_high? From my limited
knowledge about electronic I say, that active low is a standard term.

> +			err =3D devm_gpio_request_one(&pdev->dev, phy_en_gpio,
> +						    GPIOF_DIR_OUT,
> +						    "phy-enable");
> +			if (err) {
> +				dev_err(&pdev->dev,
> +					"failed to request gpio %d: %d\n",
> +					phy_en_gpio, err);
> +				goto failed_gpio;
> +			}
> +		}
> +
> +		phy_stby_gpio =3D of_get_named_gpio_flags(pdev->dev.of_node,
> +							"phy-standby-gpios",
> +							0, &flags);
> +		if (gpio_is_valid(phy_stby_gpio)) {
> +			if (flags =3D=3D OF_GPIO_ACTIVE_LOW)
> +				phy_stby_high =3D false;
> +			err =3D devm_gpio_request_one(&pdev->dev, phy_stby_gpio,
> +						    GPIOF_DIR_OUT,
> +						    "phy-standby");
> +			if (err) {
> +				dev_err(&pdev->dev,
> +					"failed to request gpio %d: %d\n",
> +					phy_stby_gpio, err);
> +				goto failed_gpio;
> +			}
> +		}
>  	}
> =20
>  	if (!clock_freq) {
> @@ -997,6 +1054,10 @@ static int __devinit flexcan_probe(struct platfor=
m_device *pdev)
>  	priv->base =3D base;
>  	priv->dev =3D dev;
>  	priv->clk =3D clk;
> +	priv->phy_en_gpio =3D phy_en_gpio;
> +	priv->phy_en_high =3D phy_en_high;
> +	priv->phy_stby_gpio =3D phy_stby_gpio;
> +	priv->phy_stby_high =3D phy_stby_high;
>  	priv->pdata =3D pdev->dev.platform_data;
> =20
>  	netif_napi_add(dev, &priv->napi, flexcan_poll, FLEXCAN_NAPI_WEIGHT);
> @@ -1025,6 +1086,7 @@ static int __devinit flexcan_probe(struct platfor=
m_device *pdev)
>  	if (clk)
>  		clk_put(clk);
>   failed_clock:
> + failed_gpio:
>  	return err;
>  }
> =20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig2DBC99A66C381A519E0889D8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/sMqAACgkQjTAFq1RaXHOJZgCfREqpoGF+sCLQslaqFNfNhdAr
8HEAmgJrb05Efx/y08cXcuYYjEy0yYbz
=yb2J
-----END PGP SIGNATURE-----

--------------enig2DBC99A66C381A519E0889D8--
