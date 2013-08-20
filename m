From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/3] can: mcp251x: Replace power callbacks with regulator
 API
Date: Tue, 20 Aug 2013 10:46:36 +0200
Message-ID: <52132CEC.2030100@pengutronix.de>
References: <1376912361-22133-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7EOvN0GLfbRWe7iitr9nBaFxfHiVK3td4"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51655 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab3HTIqo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Aug 2013 04:46:44 -0400
In-Reply-To: <1376912361-22133-1-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, linux-arm-kernel@lists.infradead.org, Eric Miao <eric.y.miao@gmail.com>, Russell King <linux@arm.linux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7EOvN0GLfbRWe7iitr9nBaFxfHiVK3td4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/19/2013 01:39 PM, Alexander Shiyan wrote:
> This patch replaces power callbacks to the regulator API. To improve
> the readability of the code, helper for the regulator enable/disable
> was added.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-pxa/icontrol.c         |  3 --
>  arch/arm/mach-pxa/zeus.c             | 46 ++++++++++----------
>  drivers/net/can/mcp251x.c            | 81 +++++++++++++++++++---------=
--------
>  include/linux/can/platform/mcp251x.h | 13 +-----
>  4 files changed, 69 insertions(+), 74 deletions(-)
>=20
[...]

> diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
> index 8cda23b..3df83f8 100644
> --- a/drivers/net/can/mcp251x.c
> +++ b/drivers/net/can/mcp251x.c

[...]

> @@ -1163,15 +1170,14 @@ static int mcp251x_can_suspend(struct device *d=
ev)
>  		netif_device_detach(net);
> =20
>  		mcp251x_hw_sleep(spi);
> -		if (pdata->transceiver_enable)
> -			pdata->transceiver_enable(0);
> +		mcp251x_power_enable(priv->transceiver, 0);
>  		priv->after_suspend =3D AFTER_SUSPEND_UP;
>  	} else {
>  		priv->after_suspend =3D AFTER_SUSPEND_DOWN;
>  	}
> =20
> -	if (pdata->power_enable) {
> -		pdata->power_enable(0);
> +	if (!IS_ERR(priv->power))
                                ^^^

There's a '{' missing.

> +		regulator_disable(priv->power);
>  		priv->after_suspend |=3D AFTER_SUSPEND_POWER;
>  	}
> =20
> @@ -1185,12 +1191,11 @@ static int mcp251x_can_resume(struct device *de=
v)
>  	struct mcp251x_priv *priv =3D spi_get_drvdata(spi);
> =20
>  	if (priv->after_suspend & AFTER_SUSPEND_POWER) {
> -		pdata->power_enable(1);
> +		mcp251x_power_enable(priv->power, 1);
>  		queue_work(priv->wq, &priv->restart_work);
>  	} else {
>  		if (priv->after_suspend & AFTER_SUSPEND_UP) {
> -			if (pdata->transceiver_enable)
> -				pdata->transceiver_enable(1);
> +			mcp251x_power_enable(priv->transceiver, 1);
>  			queue_work(priv->wq, &priv->restart_work);
>  		} else {
>  			priv->after_suspend =3D 0;

And I see the following warnings:

> /home/frogger/pengutronix/socketcan/linux/drivers/net/can/mcp251x.c: In=
 function 'mcp251x_can_suspend':
> /home/frogger/pengutronix/socketcan/linux/drivers/net/can/mcp251x.c:115=
6:32: warning: unused variable 'pdata' [-Wunused-variable]
> /home/frogger/pengutronix/socketcan/linux/drivers/net/can/mcp251x.c: In=
 function 'mcp251x_can_resume':
> /home/frogger/pengutronix/socketcan/linux/drivers/net/can/mcp251x.c:118=
7:32: warning: unused variable 'pdata' [-Wunused-variable]

I've fixed the problems and applied the patch to linux-can/testing.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--7EOvN0GLfbRWe7iitr9nBaFxfHiVK3td4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlITLOwACgkQjTAFq1RaXHNUygCfUbNF7EIjTThtJfiyNYqfj+2+
9rAAoIT4CG+po4SB8JO6mnTFa9TOOwkC
=T1a9
-----END PGP SIGNATURE-----

--7EOvN0GLfbRWe7iitr9nBaFxfHiVK3td4--
