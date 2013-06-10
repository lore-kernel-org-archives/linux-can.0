From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] flexcan: Use a regulator to control the CAN transceiver
Date: Mon, 10 Jun 2013 18:59:19 +0200
Message-ID: <51B605E7.6080903@pengutronix.de>
References: <1370460445-15386-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2TSNMMNCVIXGKCNVIMPAU"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33958 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab3FJQ72 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 12:59:28 -0400
In-Reply-To: <1370460445-15386-1-git-send-email-festevam@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: shawn.guo@linaro.org, linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2TSNMMNCVIXGKCNVIMPAU
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 06/05/2013 09:27 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Instead of using a GPIO to turn on/off the CAN transceiver, it is bette=
r to
> use a regulator as some systems may use a PMIC to power the CAN transce=
iver.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

I'm preparing a patch to remove the usage of flexcan_platform_data from
the imx tree. Can you add that patch to your series and remove
"linux/can/platform/flexcan.h" from the source tree in this patch?

> ---
>  .../devicetree/bindings/net/can/fsl-flexcan.txt    |  2 +
>  arch/arm/boot/dts/imx28-evk.dts                    | 11 +++++
>  arch/arm/mach-mxs/mach-mxs.c                       | 54 ++------------=
--------
>  drivers/net/can/flexcan.c                          | 24 +++++-----
>  4 files changed, 29 insertions(+), 62 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt =
b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> index 8ff324e..56d6cc3 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> @@ -16,6 +16,8 @@ Optional properties:
> =20
>  - clock-frequency : The oscillator frequency driving the flexcan devic=
e
> =20
> +- xceiver-supply: Regulator that powers the CAN transceiver
> +
>  Example:
> =20
>  	can@1c000 {
> diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-=
evk.dts
> index 3637bf3..dff42b3 100644
> --- a/arch/arm/boot/dts/imx28-evk.dts
> +++ b/arch/arm/boot/dts/imx28-evk.dts
> @@ -155,6 +155,7 @@
>  			can0: can@80032000 {
>  				pinctrl-names =3D "default";
>  				pinctrl-0 =3D <&can0_pins_a>;
> +				xceiver-supply =3D <&reg_can_3v3>;
>  				status =3D "okay";
>  			};
> =20
> @@ -319,6 +320,16 @@
>  			gpio =3D <&gpio3 30 0>;
>  			enable-active-high;
>  		};
> +
> +		reg_can_3v3: can-3v3 {
> +			compatible =3D "regulator-fixed";
> +			regulator-name =3D "can-3v3";
> +			regulator-min-microvolt =3D <3300000>;
> +			regulator-max-microvolt =3D <3300000>;
> +			gpio =3D <&gpio2 13 0>;

Can you convert GPIO2_13 from a hog gpio to a normal pinctl gpio?

Looks good otherwise.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2TSNMMNCVIXGKCNVIMPAU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlG2BeoACgkQjTAFq1RaXHOqLQCeNLFeLARluAMgx1Fa8uycUllo
YnkAnAs3EX7c8Qu6tAZgG/8mEUsB3hk8
=d4n5
-----END PGP SIGNATURE-----

------enig2TSNMMNCVIXGKCNVIMPAU--
