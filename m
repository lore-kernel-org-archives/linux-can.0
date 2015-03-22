From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: Deferred on Regulator return EPROBE_DEFER
Date: Sun, 22 Mar 2015 18:23:16 +0100
Message-ID: <550EFA84.7010409@pengutronix.de>
References: <CAB4L-ghK_dzo-G_81LwjLh8oJxm6pzWkO4_8fZ6auUbycXF_4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="h7dGki8J0k3v2bmRaaGf3FDbQO3rLq7aD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49534 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbbCVRXo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 22 Mar 2015 13:23:44 -0400
In-Reply-To: <CAB4L-ghK_dzo-G_81LwjLh8oJxm6pzWkO4_8fZ6auUbycXF_4A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Werner <kernel@andy89.org>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h7dGki8J0k3v2bmRaaGf3FDbQO3rLq7aD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/22/2015 05:35 PM, Andreas Werner wrote:
> Return EPROBE_DEFER if Regulator returns EPROBE_DEFER
>=20
> If the Flexcan driver is built into kernel and a regulator is used to
> enable the CAN transceiver, the Flexcan driver may not use the regulato=
r.
>=20
> When initializing the Flexcan device with a regulator defined in the de=
vice
> tree, but not initialized, the regulator subsystem returns EPROBE_DEFER=
, hence
> the Flexcan init fails.
>=20
> The solution for this is to return EPROBE_DEFER if regulator is not ini=
tialized
> and wait until the regulator is initialized.
>=20
> Signed-off-by: Andreas Werner <kernel@andy89.org>

Applied to can, with some minor changes.

> ---
> I tested this Patch on a self made Freescale Vybrid VF610 board we deve=
loped in
> the Formula Student Team of the UaS RheinMain. I think this Patch is wo=
rking on
> all other SoC with a Flexcan Controller. I tested it with the head rev =
of
> linux-can and linux 3.19.2.
>=20
> Since this is my first patch for the Linux Kernel, please tell me if
> there are formal
> failures.

No failures, but you can improve things. Please use git send-email to
post your patches, as your MUA, which is probably google, converts the
tabs into spaces, so that the patch doesn't apply anymore.

> ---
>  drivers/net/can/flexcan.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index b1d583b..c575163 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -1164,11 +1164,19 @@ static int flexcan_probe(struct platform_device=
 *pdev)
>      void __iomem *base;
>      int err, irq;
>      u32 clock_freq =3D 0;
> +    struct regulator *reg_xceiver =3D NULL;
>=20
>      if (pdev->dev.of_node)
>          of_property_read_u32(pdev->dev.of_node,
>                          "clock-frequency", &clock_freq);
>=20
> +    reg_xceiver =3D devm_regulator_get(&pdev->dev, "xceiver");
> +    if (PTR_ERR(reg_xceiver) =3D=3D -EPROBE_DEFER) {
> +        return -EPROBE_DEFER;
> +    } else if (IS_ERR(reg_xceiver)) {
> +        reg_xceiver =3D NULL;
> +    }

I've moved this in front of the of_property_read_u32, as I don't want to
tear the clock handling apart. Further I've removed the curly braces.

> +
>      if (!clock_freq) {
>          clk_ipg =3D devm_clk_get(&pdev->dev, "ipg");
>          if (IS_ERR(clk_ipg)) {
> @@ -1225,10 +1233,7 @@ static int flexcan_probe(struct platform_device =
*pdev)
>      priv->clk_per =3D clk_per;
>      priv->pdata =3D dev_get_platdata(&pdev->dev);
>      priv->devtype_data =3D devtype_data;
> -
> -    priv->reg_xceiver =3D devm_regulator_get(&pdev->dev, "xceiver");
> -    if (IS_ERR(priv->reg_xceiver))
> -        priv->reg_xceiver =3D NULL;
> +    priv->reg_xceiver =3D reg_xceiver;
>=20
>      netif_napi_add(dev, &priv->napi, flexcan_poll, FLEXCAN_NAPI_WEIGHT=
);
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--h7dGki8J0k3v2bmRaaGf3FDbQO3rLq7aD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVDvqIAAoJECte4hHFiupU3tUP/iNutvgAHqBThsB5Zh15rUzq
IKhon8lofl60fxVd6ZDD6/+nMxvV2JAOVi4FzWs/j+RViR77FzvFxy/LV9gpOQJ9
YRM6HYTULwrccuvyPrdu2PTEvyDbECo2LrHWTHRfUhBJICZRH9YKzznLztGfQ1xA
FxKoNXNiCz3Vzk/CNQiuSw7oBiSgEmkB3CunEoRF+LWwWaNj5VFcPr31jGsXAg7Y
yT0wmy/lyxS1AdGuFAJtcG4YF8BJHOKe99hABwpbuywP8vWmEPp5NeZOKThwfsNa
XyzhH2ZxAYx7Vy64577ZXM3XNgBdIObhmBX66sCV3CLQrWbKhAJUx3xhq8P5wJdF
wqY6bKTohesjQScIxwVAUOHbrjcEA91pX6qvaTBIID9D8lopj91ZKgCCAeE7qbU8
tquvsCBx/vUqN4LlVAPk9M/A1RnhiSvWoSdz3uXSw+OX4plszdSxQJqn9CSVKeQD
o6e2+JlA7VUYvVoKFUDMlXMPoLc/9Jl7hRZwjOWCV65ghiEgngPtph7oXxE64kYH
Qv89enfqlzTeR+Ld79OayIhbHkqjbWjsEAof4h7yC1DQIWQqglByc9KwMF7tR+KK
JRIznc8MHTF0klIoCU26mT4lEkJBdZa2VrsKk/SXSQzuX/MehojEiyKQgwoMM0Zm
T9QLPkIooF+C+lR+rDai
=QHK2
-----END PGP SIGNATURE-----

--h7dGki8J0k3v2bmRaaGf3FDbQO3rLq7aD--
