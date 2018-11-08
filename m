From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH v2 2/3] dt-bindings: can: rcar_can: Add r8a774a1 support
Date: Thu, 8 Nov 2018 11:25:23 +0000
Message-ID: <TY1PR01MB17709C158FEAC53383231CB7C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1536576195-11520-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1536576195-11520-3-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1536576195-11520-3-git-send-email-fabrizio.castro@bp.renesas.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: "David S. Miller" <davem@davemloft.net>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Dear All,

Who is the best person to take this patch?

Thanks,
Fab

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 10 September 2018 11:43
> Subject: [PATCH v2 2/3] dt-bindings: can: rcar_can: Add r8a774a1 support
>
> Document RZ/G2M (r8a774a1) SoC specific bindings.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Chris Paterson <Chris.Paterson2@renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
> v1->v2:
> * dropped "renesas,rzg-gen2-can" and fixed "clocks" property description
>   as per Geert's comments.
>
> This patch applies on top of next-20180910.
>
>  Documentation/devicetree/bindings/net/can/rcar_can.txt | 18 ++++++++++++=
+-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Doc=
umentation/devicetree/bindings/net/can/rcar_can.txt
> index 94a7f33..f3b160c 100644
> --- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> @@ -4,6 +4,7 @@ Renesas R-Car CAN controller Device Tree Bindings
>  Required properties:
>  - compatible: "renesas,can-r8a7743" if CAN controller is a part of R8A77=
43 SoC.
>        "renesas,can-r8a7745" if CAN controller is a part of R8A7745 SoC.
> +      "renesas,can-r8a774a1" if CAN controller is a part of R8A774A1 SoC=
.
>        "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC.
>        "renesas,can-r8a7779" if CAN controller is a part of R8A7779 SoC.
>        "renesas,can-r8a7790" if CAN controller is a part of R8A7790 SoC.
> @@ -16,15 +17,21 @@ Required properties:
>        "renesas,rcar-gen1-can" for a generic R-Car Gen1 compatible device=
.
>        "renesas,rcar-gen2-can" for a generic R-Car Gen2 or RZ/G1
>        compatible device.
> -      "renesas,rcar-gen3-can" for a generic R-Car Gen3 compatible device=
.
> +      "renesas,rcar-gen3-can" for a generic R-Car Gen3 or RZ/G2
> +      compatible device.
>        When compatible with the generic version, nodes must list the
>        SoC-specific version corresponding to the platform first
>        followed by the generic version.
>
>  - reg: physical base address and size of the R-Car CAN register map.
>  - interrupts: interrupt specifier for the sole interrupt.
> -- clocks: phandles and clock specifiers for 3 CAN clock inputs.
> -- clock-names: 3 clock input name strings: "clkp1", "clkp2", "can_clk".
> +- clocks: phandles and clock specifiers for 2 CAN clock inputs for RZ/G2
> +  devices.
> +  phandles and clock specifiers for 3 CAN clock inputs for every other
> +  SoC.
> +- clock-names: 2 clock input name strings for RZ/G2: "clkp1", "can_clk".
> +       3 clock input name strings for every other SoC: "clkp1", "clkp2",
> +       "can_clk".
>  - pinctrl-0: pin control group to be used for this controller.
>  - pinctrl-names: must be "default".
>
> @@ -41,8 +48,9 @@ using the below properties:
>  Optional properties:
>  - renesas,can-clock-select: R-Car CAN Clock Source Select. Valid values =
are:
>      <0x0> (default) : Peripheral clock (clkp1)
> -    <0x1> : Peripheral clock (clkp2)
> -    <0x3> : Externally input clock
> +    <0x1> : Peripheral clock (clkp2) (not supported by
> +    RZ/G2 devices)
> +    <0x3> : External input clock
>
>  Example
>  -------
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
