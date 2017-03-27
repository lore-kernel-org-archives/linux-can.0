From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: sun7i: Add CAN node and can0_pins_a
 pinctrl settings
Date: Mon, 27 Mar 2017 08:46:25 +0200
Message-ID: <20170327064625.we7ydn2oapwizncb@lukather>
References: <1490392339-23565-1-git-send-email-menschel.p@posteo.de>
 <1490392339-23565-3-git-send-email-menschel.p@posteo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8107342982921785068=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1490392339-23565-3-git-send-email-menschel.p@posteo.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Patrick Menschel <menschel.p@posteo.de>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, wens@csie.org, robh+dt@kernel.org, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-can.vger.kernel.org


--===============8107342982921785068==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mzddxfrgk3es52ce"
Content-Disposition: inline


--mzddxfrgk3es52ce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Fri, Mar 24, 2017 at 10:52:19PM +0100, Patrick Menschel wrote:
> The A20 SoC has an on-board CAN controller. This patch adds the device no=
de
> and the corresponding pinctrl settings for pins PH20 and PH21.
>=20
> The CAN controller is inherited from the A10 SoC and uses the same driver.
>=20
> This patch is adapted from the description in
> Documentation/devicetree/bindings/net/can/sun4i_can.txt
>=20
> Signed-off-by: Patrick Menschel <menschel.p@posteo.de>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a=
20.dtsi
> index 2db97fc..25af586 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -1096,6 +1096,11 @@
>  			#interrupt-cells =3D <3>;
>  			#gpio-cells =3D <3>;
> =20
> +			can0_pins_a: can0@0 {
> +				pins =3D "PH20","PH21";
> +				function =3D "can";
> +			};
> +
>  			clk_out_a_pins_a: clk_out_a@0 {
>  				pins =3D "PI12";
>  				function =3D "clk_out_a";
> @@ -1582,6 +1587,14 @@
>  			#size-cells =3D <0>;
>  		};
> =20
> +		can0: can@01c2bc00 {
> +			compatible =3D "allwinner,sun4i-a10-can";

Sorry for not spotting this earlier, but this would need an A20
compatible too, to deal with the case where it turns out not to be
compatible.

you can do something like this:
compatible =3D "allwinner,sun7i-a20-can", "allwinner,sun4i-a10-can";

Ideally the pinctrl groups addition should be split out in a separate
patch too.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--mzddxfrgk3es52ce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY2LU9AAoJEBx+YmzsjxAgxnkP/3eCpzS2BMEhdTRVQ792kWix
vAcCnNHB/BMKWS4px1UlHr4KCOqg/9sKA3DiC/w+UFgMGLieEhp+YPGFDYCIVnOs
UMxzLCcjfYElg52Qpya3Y/67fuThRil0joOQif/q6AfpTgfHdUQo2Dy1jYoxipIS
UxnsPc4UVkejpGueI3vBLbgu0x1tcMyc/04z60pAB7TjKuBSEFEQCRTfSoYOXNrN
jYAwQxpidqns3mRIQGkJbNCbiUQsRtkCPNWW5JcldMy+/83J6B9uk4qxN9mJS2BM
hHRZXo1E+UfWtcv1U/WMeGr19qWwo37SNlzSvSb6T+h+EHrLP3m7ro1udF4saxY+
XxZ2nbYQcsaXzq1qdg0svtYmdqwvXMbzCIn2GgdTkBZqAaXxga4oKLfs3gMcTZLu
TPT4aIU18wI1+8MwhDd2J/Y9oWIDFUanOwZfYl5svdfOuDQAjRqenv8PXFOEa5fn
HEz0A2wQdUO9tkprFJrXW4CH+3po36CVuwrbRvXP9xB8RAsc7h0orsCxvXim0KVO
1VNpjf313fcnm3LddH/Gil/zj4v4+JhoFKPWgpdv7DBOfyYtBWZiMC7yRZvzRpe1
kWB4jYcjkfI1HLz6/ycMn2elkvPeIZdOtkeRoRPlH5VT1y6L/A5VxKnGxnZfw5Kk
RXGO5IEKC1sJjlIDk7Qa
=LXxa
-----END PGP SIGNATURE-----

--mzddxfrgk3es52ce--


--===============8107342982921785068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8107342982921785068==--
