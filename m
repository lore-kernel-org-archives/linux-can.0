From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v12 3/5] dt-bindings: can: tcan4x5x: Add DT bindings for
 TCAN4x5X driver
Date: Fri, 16 Aug 2019 11:38:30 +0200
Message-ID: <bdf06ead-a2e8-09a9-8cdd-49b54ec9da72@pengutronix.de>
References: <20190509161109.10499-1-dmurphy@ti.com>
 <20190509161109.10499-3-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="aBUzk5kBxcksCMQiGzZKo8fIFHJb9btJx"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190509161109.10499-3-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, wg@grandegger.com, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aBUzk5kBxcksCMQiGzZKo8fIFHJb9btJx
Content-Type: multipart/mixed; boundary="q6QniM5YBwprqSKHFOCHjmzVW0QcEIZcF";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Dan Murphy <dmurphy@ti.com>, wg@grandegger.com, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <bdf06ead-a2e8-09a9-8cdd-49b54ec9da72@pengutronix.de>
Subject: Re: [PATCH v12 3/5] dt-bindings: can: tcan4x5x: Add DT bindings for
 TCAN4x5X driver
References: <20190509161109.10499-1-dmurphy@ti.com>
 <20190509161109.10499-3-dmurphy@ti.com>
In-Reply-To: <20190509161109.10499-3-dmurphy@ti.com>

--q6QniM5YBwprqSKHFOCHjmzVW0QcEIZcF
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 5/9/19 6:11 PM, Dan Murphy wrote:
> DT binding documentation for TI TCAN4x5x driver.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>=20
> v12 - No changes - https://lore.kernel.org/patchwork/patch/1052300/
>=20
> v11 - No changes - https://lore.kernel.org/patchwork/patch/1051178/
> v10 - No changes - https://lore.kernel.org/patchwork/patch/1050488/
> v9 - No Changes - https://lore.kernel.org/patchwork/patch/1050118/
> v8 - No Changes - https://lore.kernel.org/patchwork/patch/1047981/
> v7 - Made device state optional - https://lore.kernel.org/patchwork/pat=
ch/1047218/
> v6 - No changes - https://lore.kernel.org/patchwork/patch/1042445/
>=20
>  .../devicetree/bindings/net/can/tcan4x5x.txt  | 37 +++++++++++++++++++=

>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.=
txt
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/D=
ocumentation/devicetree/bindings/net/can/tcan4x5x.txt
> new file mode 100644
> index 000000000000..c388f7d9feb1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> @@ -0,0 +1,37 @@
> +Texas Instruments TCAN4x5x CAN Controller
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This file provides device node information for the TCAN4x5x interface =
contains.
> +
> +Required properties:
> +	- compatible: "ti,tcan4x5x"
> +	- reg: 0
> +	- #address-cells: 1
> +	- #size-cells: 0
> +	- spi-max-frequency: Maximum frequency of the SPI bus the chip can
> +			     operate at should be less than or equal to 18 MHz.
> +	- data-ready-gpios: Interrupt GPIO for data and error reporting.
> +	- device-wake-gpios: Wake up GPIO to wake up the TCAN device.
> +
> +See Documentation/devicetree/bindings/net/can/m_can.txt for additional=

> +required property details.
> +
> +Optional properties:
> +	- reset-gpios: Hardwired output GPIO. If not defined then software
> +		       reset.
> +	- device-state-gpios: Input GPIO that indicates if the device is in
> +			      a sleep state or if the device is active.
> +
> +Example:
> +tcan4x5x: tcan4x5x@0 {
> +		compatible =3D "ti,tcan4x5x";
> +		reg =3D <0>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		spi-max-frequency =3D <10000000>;
> +		bosch,mram-cfg =3D <0x0 0 0 32 0 0 1 1>;
> +		data-ready-gpios =3D <&gpio1 14 GPIO_ACTIVE_LOW>;

Can you convert this into a proper interrupt property? E.g.:

>                 interrupt-parent =3D <&gpio4>;
>                 interrupts =3D <13 0x2>;

See:
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/b=
indings/net/can/microchip,mcp251x.txt#L21
https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/tr=
ee/drivers/net/can/spi/mcp251x.c?h=3Dmcp251x#n945

> +		device-state-gpios =3D <&gpio3 21 GPIO_ACTIVE_HIGH>;
> +		device-wake-gpios =3D <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +		reset-gpios =3D <&gpio1 27 GPIO_ACTIVE_LOW>;
> +};

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--q6QniM5YBwprqSKHFOCHjmzVW0QcEIZcF--

--aBUzk5kBxcksCMQiGzZKo8fIFHJb9btJx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1WeZYACgkQWsYho5Hk
nSBTlwf/UKOIilK+QTWjdNPICt6931qej73qUpCyoXPrpGem3p9JQ75TWAnwtpoH
JrzeqtaAkV2BuGWkF22JtdALqQWlLXniKBBr8jvYK7oVBP51eFm1Yu70ta5lztOo
Pr8SsTNW0/ey/4b8hygkpmQnuQIlOYWo1v+YK4IccEz9EbkyOVrg2aj/dvGzaVga
TMWmmKtpAjB8Cy0Rn1Ygf/zxs8AvCKFhMRnz2jabe/dxUAsxw3lKiW3fiJ8I6OMv
6Ra0kKf9nlZibQ70TUu/LX6X4rAf7U+SZ/IWAk1LoOtiySC6hn0r4pn9Oxvary2i
AVXO0fgo63K2OiIFDldCsTiyluylJA==
=0DaQ
-----END PGP SIGNATURE-----

--aBUzk5kBxcksCMQiGzZKo8fIFHJb9btJx--
