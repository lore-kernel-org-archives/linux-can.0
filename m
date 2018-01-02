From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v6 3/6] can: m_can: Add PM Runtime
Date: Tue, 2 Jan 2018 17:07:00 +0100
Message-ID: <aea8638a-c847-b55e-ff2d-37999980ba7b@pengutronix.de>
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
 <1513949488-13026-4-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="nX9QgqsFdnpBYYnKoj1lIz7By4119uO9i"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56473 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751022AbeABQHZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Jan 2018 11:07:25 -0500
In-Reply-To: <1513949488-13026-4-git-send-email-faiz_abbas@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Faiz Abbas <faiz_abbas@ti.com>, wg@grandegger.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nX9QgqsFdnpBYYnKoj1lIz7By4119uO9i
Content-Type: multipart/mixed; boundary="vb5R6ssIZzboorG9Vz0DBzeuwvvWMABt3";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Faiz Abbas <faiz_abbas@ti.com>, wg@grandegger.com, robh+dt@kernel.org,
 mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com,
 fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com,
 sergei.shtylyov@cogentembedded.com
Message-ID: <aea8638a-c847-b55e-ff2d-37999980ba7b@pengutronix.de>
Subject: Re: [PATCH v6 3/6] can: m_can: Add PM Runtime
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
 <1513949488-13026-4-git-send-email-faiz_abbas@ti.com>
In-Reply-To: <1513949488-13026-4-git-send-email-faiz_abbas@ti.com>

--vb5R6ssIZzboorG9Vz0DBzeuwvvWMABt3
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 12/22/2017 02:31 PM, Faiz Abbas wrote:
> From: Franklin S Cooper Jr <fcooper@ti.com>
>=20
> Add support for PM Runtime which is the new way to handle managing cloc=
ks.
> However, to avoid breaking SoCs not using PM_RUNTIME leave the old clk
> management approach in place.

There is no PM_RUNTIME anymore since 464ed18ebdb6 ("PM: Eliminate
CONFIG_PM_RUNTIME")

Have a look at the discussion: https://patchwork.kernel.org/patch/9436507=
/ :

>> Well, I admit it would be nicer if drivers didn't have to worry about =

>> whether or not CONFIG_PM was enabled.  A slightly cleaner approach=20
>> from the one outlined above would have the probe routine do this:
>>=20
>> 	my_power_up(dev);
>> 	pm_runtime_set_active(dev);
>> 	pm_runtime_get_noresume(dev);
>> 	pm_runtime_enable(dev);

> PM_RUNTIME is required by OMAP based devices to handle clock management=
=2E
> Therefore, this allows future Texas Instruments SoCs that have the MCAN=
 IP
> to work with this driver.

Who will set the SET_RUNTIME_PM_OPS in this case?

> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> [nsekhar@ti.com: handle pm_runtime_get_sync() failure, fix some bugs]
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/net/can/m_can/m_can.c | 38 ++++++++++++++++++++++++++++++++++-=
---
>  1 file changed, 34 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> index f72116e..53e764f 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -23,6 +23,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/iopoll.h>
>  #include <linux/can/dev.h>
> =20
> @@ -625,19 +626,33 @@ static int m_can_clk_start(struct m_can_priv *pri=
v)
>  {
>  	int err;
> =20
> +	err =3D pm_runtime_get_sync(priv->device);
> +	if (err) {
> +		pm_runtime_put_noidle(priv->device);

Why do you call this in case of an error?

> +		return err;
> +	}
> +
>  	err =3D clk_prepare_enable(priv->hclk);
>  	if (err)
> -		return err;
> +		goto pm_runtime_put;
> =20
>  	err =3D clk_prepare_enable(priv->cclk);
>  	if (err)
> -		clk_disable_unprepare(priv->hclk);
> +		goto disable_hclk;
> =20
>  	return err;
> +
> +disable_hclk:
> +	clk_disable_unprepare(priv->hclk);
> +pm_runtime_put:
> +	pm_runtime_put_sync(priv->device);
> +	return err;
>  }
> =20
>  static void m_can_clk_stop(struct m_can_priv *priv)
>  {
> +	pm_runtime_put_sync(priv->device);
> +
>  	clk_disable_unprepare(priv->cclk);
>  	clk_disable_unprepare(priv->hclk);
>  }
> @@ -1577,13 +1592,20 @@ static int m_can_plat_probe(struct platform_dev=
ice *pdev)
>  	/* Enable clocks. Necessary to read Core Release in order to determin=
e
>  	 * M_CAN version
>  	 */
> +	pm_runtime_enable(&pdev->dev);
> +	ret =3D pm_runtime_get_sync(&pdev->dev);
> +	if (ret)  {
> +		pm_runtime_put_noidle(&pdev->dev);

Why do you call this in case of error?

> +		goto pm_runtime_fail;
> +	}
> +
>  	ret =3D clk_prepare_enable(hclk);
>  	if (ret)
> -		goto disable_hclk_ret;
> +		goto pm_runtime_put;
> =20
>  	ret =3D clk_prepare_enable(cclk);
>  	if (ret)
> -		goto disable_cclk_ret;
> +		goto disable_hclk_ret;
> =20
>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "m_can");
>  	addr =3D devm_ioremap_resource(&pdev->dev, res);
> @@ -1666,6 +1688,11 @@ static int m_can_plat_probe(struct platform_devi=
ce *pdev)
>  	clk_disable_unprepare(cclk);
>  disable_hclk_ret:
>  	clk_disable_unprepare(hclk);
> +pm_runtime_put:
> +	pm_runtime_put_sync(&pdev->dev);
> +pm_runtime_fail:
> +	if (ret)
> +		pm_runtime_disable(&pdev->dev);
>  failed_ret:
>  	return ret;
>  }
> @@ -1723,6 +1750,9 @@ static int m_can_plat_remove(struct platform_devi=
ce *pdev)
>  	struct net_device *dev =3D platform_get_drvdata(pdev);
> =20
>  	unregister_m_can_dev(dev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +
>  	platform_set_drvdata(pdev, NULL);
> =20
>  	free_m_can_dev(dev);
>=20

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--vb5R6ssIZzboorG9Vz0DBzeuwvvWMABt3--

--nX9QgqsFdnpBYYnKoj1lIz7By4119uO9i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpLriUACgkQHv7KIOw4
HPZmbAgAwXEeTVol5rI7d3ZC03OyzX1cHDgIwkhi8lqF+MVxgCo3Lschd1YEye9w
bgWamrI0AGEn6yTPps30Lz1CqC+JEdHtvs8UslSuLzsLDRHrdQQZjZkOojXnGVB+
FhkV2xTzjs8E9xQJQU4F+sj/g6N8WOJclpY8tiE8se+CIbhjOUbqL9CagRgLBLLM
L7gs1B8n1aCIXNQM7eJZHcYif4p/L0jdleeJ2s4wwLdv29Yp/YMtAltcnOxLjuZb
qp5sqk/HB9AOG3BsMXwThAH2LhRw6U+PMTD0i+156J9CbWUsPhDoplQkkqr0TOJb
kNgMFJ3g0koU7EzKyTa9LI0E2D7fpQ==
=EIKu
-----END PGP SIGNATURE-----

--nX9QgqsFdnpBYYnKoj1lIz7By4119uO9i--
