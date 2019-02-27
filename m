From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] dt-bindings: net: can: binding for CTU CAN FD open-source
 IP core.
Date: Wed, 27 Feb 2019 15:47:03 +0100
Message-ID: <b8a48659-6b82-87e4-08cb-1420463dbded@pengutronix.de>
References: <201902221420.05267.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="zXEJeE1ITuIOqdCWX0TUTCelucyuEsGc3"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <201902221420.05267.pisa@cmp.felk.cvut.cz>
Sender: netdev-owner@vger.kernel.org
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>, devicetree@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Jerabek <martin.jerabek01@gmail.com>, Ondrej Ille <ondrej.ille@gmail.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zXEJeE1ITuIOqdCWX0TUTCelucyuEsGc3
Content-Type: multipart/mixed; boundary="QnSscz5Zs0qqsxAkkiEaKOvhQZGotQDuG";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>, devicetree@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Martin Jerabek <martin.jerabek01@gmail.com>,
 Ondrej Ille <ondrej.ille@gmail.com>
Message-ID: <b8a48659-6b82-87e4-08cb-1420463dbded@pengutronix.de>
Subject: Re: [PATCH] dt-bindings: net: can: binding for CTU CAN FD open-source
 IP core.
References: <201902221420.05267.pisa@cmp.felk.cvut.cz>
In-Reply-To: <201902221420.05267.pisa@cmp.felk.cvut.cz>

--QnSscz5Zs0qqsxAkkiEaKOvhQZGotQDuG
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 2/22/19 2:20 PM, Pavel Pisa wrote:
> From 3e19a7f5c33e5fb50f52c9df05bf00022e3f3dd5 Mon Sep 17 00:00:00 2001
> From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> Date: Fri, 22 Feb 2019 14:11:11 +0100
> Subject: [PATCH] dt-bindings: net: can: binding for CTU CAN FD open-sou=
rce IP
>  core.

Nice! I appreciate open-source hardware!

Please send the patch via git send-email, it's a bit broken:

Applying: dt-bindings: net: can: binding for CTU CAN FD open-source IP co=
re.
=2Egit/rebase-apply/patch:29: trailing whitespace.

error: corrupt patch at line 30
Patch failed at 0001 dt-bindings: net: can: binding for CTU CAN FD
open-source IP core.
hint: Use 'git am --show-current-patch' to see the failed patch


> Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> ---
>  .../devicetree/bindings/net/can/ctu,ctucanfd.txt   | 102 +++++++++++++=
++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/ctu,ctuca=
nfd.txt
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt=
=20
> b/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt
> new file mode 100644
> index 000000000000..6c75e5850904
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/ctu,ctucanfd.txt
> @@ -0,0 +1,102 @@
> +Memory mapped CTU CAN FD open-source IP core
> +
> +The core sources and documentation on project page
> +
> +  https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core
> +  http://canbus.pages.fel.cvut.cz/ctucanfd_ip_core/Progdokum.pdf
> +
> +Integration in Xilinx Zynq SoC based system together with
> +OpenCores SJA1000 compatible controllers
> +
> +  https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top
> +
> +Martin Jerabek's dimploma thesis with integration and testing
> +framework description
> +
> +=20
> https://dspace.cvut.cz/bitstream/handle/10467/80366/F3-DP-2019-Jerabek-=
Martin-Jerabek-thesis-2019-canfd.pdf
> +
> +Required properties:
> +
> +- compatible : should be one of "ctu,ctucanfd", "ctu,canfd-2".
> +
> +- reg =3D <(baseaddr) (size)> : specify mapping into physical address
> +      space of the processor system.
> +
> +- interrupts : property with a value describing the interrupt source
> +      required for the CTU CAN FD. For Zynq SoC system format is
> +      <(is_spi) (number) (type)> where is_spi defines if it is SPI
> +      (shared peripheral) interrupt, the second number is translated
> +      to the vector by addition of 32 on Zynq-7000 systems and type
> +      is IRQ_TYPE_LEVEL_HIGH (4) for Zynq.
> +
> +- interrupt-parent =3D <&interrupt-controller-phandle> :
> +      is required for Zynq SoC to find map interrupt
> +      to the correct controller
> +
> +- clocks: phandle of reference clock (100 MHz is appropriate
> +      for FPGA implementation on Zynq-7000 system).
> +
> +Example when integrated to Zynq-7000 system DTS:
> +
> +        / {
> +            /* ... */
> +            amba: amba {
> +                #address-cells =3D <1>;
> +                #size-cells =3D <1>;
> +                compatible =3D "simple-bus";
> +
> +                CTU_CAN_FD_0: CTU_CAN_FD@43c30000 {

It's unusual to have uppercase letters here.

> +                    compatible =3D "ctu,ctucanfd";

Is ctu already registered in
Documentation/devicetree/bindings/vendor-prefixes.txt ?

> +                    interrupt-parent =3D <&intc>;
> +                    interrupts =3D <0 30 4>;
> +                    clocks =3D <&clkc 15>;
> +                    reg =3D <0x43c30000 0x10000>;
> +                };
> +            };
> +        };
> +
> +
> +Example when used as DTS overlay on Zynq-7000 system:
> +
> +
> +// Device Tree Example: Full Reconfiguration without Bridges
> +/dts-v1/;
> +/plugin/;
> +
> +/ {
> +    fragment@0 {
> +        target-path =3D "/fpga-full";
> +
> +        __overlay__ {
> +            #address-cells =3D <1>;
> +            #size-cells =3D <1>;
> +
> +            firmware-name =3D "system.bit.bin";
> +        };
> +    };
> +
> +    fragment@1 {
> +        target-path =3D "/amba";
> +        __overlay__ {
> +            #address-cells =3D <1>;
> +            #size-cells =3D <1>;
> +
> +            CTU_CAN_FD_0: CTU_CAN_FD@43c30000 {
> +                compatible =3D "ctu,ctucanfd";
> +                interrupt-parent =3D <&intc>;
> +                interrupts =3D <0 30 4>;
> +                clocks =3D <&clkc 15>;
> +                //clock-names =3D "can_clk";

Is this needed or not?

> +                reg =3D <0x43c30000 0x10000>;
> +            };
> +            CTU_CAN_FD_1: CTU_CAN_FD@43c70000 {
> +                compatible =3D "ctu,ctucanfd";
> +                interrupt-parent =3D <&intc>;
> +                interrupts =3D <0 31 4>;
> +                clocks =3D <&clkc 15>;
> +                //clock-names =3D "can_clk";

Is this needed or not?

> +                reg =3D <0x43c70000 0x10000>;
> +            };
> +        };
> +    };
> +};
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--QnSscz5Zs0qqsxAkkiEaKOvhQZGotQDuG--

--zXEJeE1ITuIOqdCWX0TUTCelucyuEsGc3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlx2oucACgkQWsYho5Hk
nSCZyggAmrE02FBYWH32e+Zyq4jzyQDmdlA1USNSxc6FgBIwTbeJKEnTTyYccuXt
9UVc7bmeqReE09pUALucpwb0icP7fTETNl7CIVivh+DF4IHkOLcu1qmf42DuLEwf
RNoAfOXB/70XbuN1TDffI97YtAMxfxBDE0ZRSv1MnFL2Pb+oO7EvX852bLt7PO54
yIMQU6PzeM11W1SXAJnoDGDYU5Clo5SD+p35bcSFzui+h8fdh7Sr3Kc+HmDZ6iZ9
5v3jMhTi710D6LxrRttQ4DshX5zxH4Uqk2Y6Cttdh/UYXMfQUwRroBjSeBclxVs3
pSv/37EWnlKSlmuGTnXDQKKE8Awsyw==
=fyDO
-----END PGP SIGNATURE-----

--zXEJeE1ITuIOqdCWX0TUTCelucyuEsGc3--
