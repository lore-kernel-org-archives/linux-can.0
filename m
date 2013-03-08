From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/3] can: at91_can: add pinctrl support
Date: Fri, 08 Mar 2013 18:37:40 +0100
Message-ID: <513A21E4.6000801@pengutronix.de>
References: <1362763842-14924-1-git-send-email-ludovic.desroches@atmel.com> <1362763842-14924-3-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2SNRSIDQMHJQUUXDTBPFM"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47528 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756129Ab3CHRh6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 8 Mar 2013 12:37:58 -0500
In-Reply-To: <1362763842-14924-3-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: ludovic.desroches@atmel.com
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2SNRSIDQMHJQUUXDTBPFM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/08/2013 06:30 PM, ludovic.desroches@atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>=20
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  drivers/net/can/at91_can.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> index c7f70d4..56fb2aa 100644
> --- a/drivers/net/can/at91_can.c
> +++ b/drivers/net/can/at91_can.c
> @@ -28,6 +28,7 @@
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
>  #include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/rtnetlink.h>
>  #include <linux/skbuff.h>
> @@ -1292,6 +1293,7 @@ static int at91_can_probe(struct platform_device =
*pdev)
>  	struct clk *clk;
>  	void __iomem *addr;
>  	int err, irq;
> +	struct pinctrl *pinctrl;
> =20
>  	devtype_data =3D at91_can_get_driver_data(pdev);
>  	if (!devtype_data) {
> @@ -1314,6 +1316,13 @@ static int at91_can_probe(struct platform_device=
 *pdev)
>  		goto exit_put;
>  	}
> =20
> +	pinctrl =3D devm_pinctrl_get_select_default(&pdev->dev);

Is this still needed? I think the pinctrl framework automatically
enables the default pinctrl for a device if available.

Marc

> +	if (IS_ERR(pinctrl)) {
> +		dev_err(&pdev->dev, "Failed to request pinctrl\n");
> +		err =3D PTR_ERR(pinctrl);
> +		goto exit_put;
> +	}
> +
>  	if (!request_mem_region(res->start,
>  				resource_size(res),
>  				pdev->name)) {
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2SNRSIDQMHJQUUXDTBPFM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE6IegACgkQjTAFq1RaXHOx6wCgjbxmep0N0Fx4ALoBBnLMF34+
EL4AoJRjf21A4vfJ9p1xLPL+yR6wjqgR
=/wX6
-----END PGP SIGNATURE-----

------enig2SNRSIDQMHJQUUXDTBPFM--
