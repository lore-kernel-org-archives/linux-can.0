From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] Allwinner SoC CAN controller Support
Date: Tue, 8 Sep 2015 12:57:21 +0200
Message-ID: <55EEBF11.4020301@pengutronix.de>
References: <1441274970-5632-1-git-send-email-info@gerhard-bertelsmann.de>
 <1441274970-5632-2-git-send-email-info@gerhard-bertelsmann.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="PKjKfrR0nT4OIMnpngX7P3OJPSdRdkwe9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46502 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbbIHK53 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Sep 2015 06:57:29 -0400
In-Reply-To: <1441274970-5632-2-git-send-email-info@gerhard-bertelsmann.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PKjKfrR0nT4OIMnpngX7P3OJPSdRdkwe9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/03/2015 12:09 PM, Gerhard Bertelsmann wrote:
> Devicetree Bindings documentation
>=20
> Signed-off-by: Gerhard Bertelsmann < info@gerhard-bertelsmann.de >
                                      ^                           ^
nitpick: no space here.

Please format your subject like: "can: add Allwinner SoC CAN controller
Devicetree Bindings documentation".

>=20
>=20
> .../devicetree/bindings/net/can/sunxi_can.txt      |  42 ++
>  1 files changed, 42 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/sunxi_can.txt b/=
Documentation/devicetree/bindings/net/can/sunxi_can.txt
> new file mode 100644
> index 0000000..454e92f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/sunxi_can.txt
> @@ -0,0 +1,42 @@
> +Allwinner A10/A20 CAN controller Device Tree Bindings
> +-----------------------------------------------------
> +
> +Required properties:
> +- compatible: "allwinner,sunxican"
> +- reg: physical base address and size of the Allwinner A10/A20 CAN reg=
ister map.
> +- interrupts: interrupt specifier for the sole interrupt.
> +- clocks: phandle and clock specifier.
> +- pinctrl-0: pin control group to be used for this controller.
> +- pinctrl-names: must be "default".
> +
> +
> +Example
> +-------
> +
> +SoC common .dtsi file:
> +
> +	can0_pins_a: can0@0 {
> +		allwinner,pins =3D "PH20","PH21";
> +		allwinner,function =3D "can";
> +		allwinner,drive =3D <0>;
> +		allwinner,pull =3D <0>;
> +	};
> +	can0: can@01c2bc00 {
> +		compatible =3D "allwinner,sunxican";
> +		reg =3D <0x01c2bc00 0x400>;
> +		interrupts =3D <0 26 4>;
> +		clocks =3D <&apb1_gates 4>;
> +		status =3D "disabled";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;

Why address and size cells?

> +	};
> +
> +Board specific .dts file:
> +
> +	can0: can@01c2bc00 {
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&can0_pins_a>;
> +		status =3D "okay";
> +	};
> +
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |



--PKjKfrR0nT4OIMnpngX7P3OJPSdRdkwe9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV7r8RAAoJEP5prqPJtc/H2aQIAJoawVHtPiK7iFluGJXgY7FF
RHrwkW7T0oItwqQIibk4bBm89HyCKcHMYE5m2UkVd/2dsofUOHJpyX1iSN3/O6Dy
/zNEdgVjgpcoD6UHlsOSGrMvJp2+Ljbp2PW7Z8ItFh0zQGyGZciVkoJELcUGeK4O
XL0g+iJWTTZDsj98lVM5hj5/AuxKcY5nW54lm0eTAdAbdQGXb85FSthdQCfGX4pC
tOowHxZPvAasI52BwMBb4hMzR1bLAAQbWwVUGxuTs9j0wRlfHEEs2emV5PBGB3j4
H3FpRBQvrX3geMhJ0JX9HZvbm6AOOAGPIEvDO8ObcPUZdf/2EB0qmxHgiHgkDVc=
=c3p9
-----END PGP SIGNATURE-----

--PKjKfrR0nT4OIMnpngX7P3OJPSdRdkwe9--
