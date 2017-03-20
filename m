From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: sun4i: Add CAN node and can0_pins_a
 pinctrl settings
Date: Mon, 20 Mar 2017 08:49:26 +0100
Message-ID: <20170320074926.fo6jgjv3qerkz2cu@lukather>
References: <1489325291-6298-1-git-send-email-menschel.p@posteo.de>
 <1489325291-6298-2-git-send-email-menschel.p@posteo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="adentilxijw3nukl"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1489325291-6298-2-git-send-email-menschel.p-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Patrick Menschel <menschel.p-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org


--adentilxijw3nukl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Sun, Mar 12, 2017 at 02:28:10PM +0100, Patrick Menschel wrote:
> The A10 SoC has an on-board CAN controller. This patch adds the device no=
de
> and the corresponding pinctrl settings for pins PH20 and PH21.
>=20
> This patch is adapted from the description in
> Documentation/devicetree/bindings/net/can/sun4i_can.txt
>=20
> Signed-off-by: Patrick Menschel <menschel.p-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a=
10.dtsi
> index b14a428..210b616 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -1160,6 +1160,13 @@
>  				allwinner,drive =3D <SUN4I_PINCTRL_10_MA>;
>  				allwinner,pull =3D <SUN4I_PINCTRL_NO_PULL>;
>  			};
> +
> +			can0_pins_a: can0@0 {

That should be ordered by alphabetical order.

> +				allwinner,pins =3D "PH20","PH21";
> +				allwinner,function =3D "can";
> +				allwinner,drive =3D <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull =3D <SUN4I_PINCTRL_NO_PULL>;

We've switched to a new, generic, binding recently for the pinctrl
nodes.

In your case, that would mean dropping "allwinner," from the pins and
functions properties, and droping the last two properties entirely.

> +			};
>  		};
> =20
>  		timer@01c20c00 {
> @@ -1376,5 +1383,13 @@
>  			clocks =3D <&apb1_gates 7>;
>  			status =3D "disabled";
>  		};
> +
> +		can0: can@01c2bc00 {

And this one should be ordered by rising physical addresses.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--adentilxijw3nukl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYz4mCAAoJEBx+YmzsjxAgCksQAJUt44AoNmMsFTg55iw4j5YZ
t7mMBsIgmj7X/JP5SKojS830XhMamr+2C8UIXx3V8dtxLQvfeFleY5Kn/ZcZEaAe
FVo7gF7pcb2ICj8c6OnJIdzd1hsGwdntWltdNhwnXwIfVXVfTl3+3+Qm1a4OlU7R
WxzNn26wKO2kIZu+ypv8+Na3RM/lk/T4hHK1aQibMF8GQ03jFiMT50FeY2nRCEca
LupBydxQB/DLAht80Sb5HKsdnrO3nL+ruNzabgWJ7/U0hg1iZcAUiXq4Mg85TEUq
HMN+d/qKXddHeQoiVnGaoSEO6jGPVKP2AoAleTBwt0GxjWMaBfpZy5KA0VuZO7km
HRZ7mV7k3j4G2EIWh7JkKZtue85pc/4Nr2ACqfy7S+YGMAcpoH+9aikF+e3HOqBR
pwrFqA8ZtYobUESbsVoCtbkffaKOWTg66UNN3a62yyS9fCD6kOcpyWXtvGUc6/6z
D+BX4VoBC1SXxfEAd+gcoWUJONJHoqqR7PwS/5huXsLZXwccQ8PmsWAoO1N9ZWUo
fnxE+l71bw0OabOm6nSuG7NCLSpGFVTgQtBO6LKG6c/9qrPzAsjHIEzEc6dLT3vm
FmRoVNSfYXWnz/4B4E0Iww9mAPvSNj9HhamnMStnjyMSq5kT+NklMikqWvBWdOQy
z9ArFXK/Ro8Az3fECzwN
=wZ1L
-----END PGP SIGNATURE-----

--adentilxijw3nukl--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
