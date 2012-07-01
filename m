From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH RESEND 3/5] can: flexcan: adopt pinctrl support
Date: Mon, 02 Jul 2012 00:49:37 +0200
Message-ID: <4FF0D401.4050101@pengutronix.de>
References: <1336352040-28447-1-git-send-email-shawn.guo@linaro.org> <1336352040-28447-4-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB7934B685E75744CD28C402F"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55966 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327Ab2GAWuB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 1 Jul 2012 18:50:01 -0400
In-Reply-To: <1336352040-28447-4-git-send-email-shawn.guo@linaro.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sascha Hauer <s.hauer@pengutronix.de>, Dong Aisheng <dong.aisheng@linaro.org>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB7934B685E75744CD28C402F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/07/2012 02:53 AM, Shawn Guo wrote:
> Cc: linux-can@vger.kernel.org
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/net/can/flexcan.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 1efb083..38c0690 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -35,6 +35,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pinctrl/consumer.h>
> =20
>  #define DRV_NAME			"flexcan"
> =20
> @@ -927,11 +928,16 @@ static int __devinit flexcan_probe(struct platfor=
m_device *pdev)
>  	struct flexcan_priv *priv;
>  	struct resource *mem;
>  	struct clk *clk =3D NULL;
> +	struct pinctrl *pinctrl;
>  	void __iomem *base;
>  	resource_size_t mem_size;
>  	int err, irq;
>  	u32 clock_freq =3D 0;
> =20
> +	pinctrl =3D devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl))
> +		return PTR_ERR(pinctrl);
> +
>  	if (pdev->dev.of_node) {
>  		const u32 *clock_freq_p;

I'm on mx28 and trying to load the flexcan driver via DT, but
devm_pinctrl_get_select_default fails with -19.

What am I doing wrong? Will this fail with the same error on non DT
platforms?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigB7934B685E75744CD28C402F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/w1A4ACgkQjTAFq1RaXHN0LQCfefU0cWd7Bd/pn3ltE75BX0fb
WU4An12jHe+hvLHZ5WJ7VimLOndv2X5y
=yZjB
-----END PGP SIGNATURE-----

--------------enigB7934B685E75744CD28C402F--
