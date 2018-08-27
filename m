From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/3] dt-bindings: can: rcar_can: Add r8a774a1 support
Date: Mon, 27 Aug 2018 14:40:37 +0200
Message-ID: <CAMuHMdWPuqfXOgh_-qp8q6wATU3Lj_WpX0bAOxPBX76SKvyXCQ@mail.gmail.com>
References: <1535029653-7418-1-git-send-email-fabrizio.castro@bp.renesas.com> <1535029653-7418-4-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535029653-7418-4-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev <netdev@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Hi Fabrizio,

On Thu, Aug 23, 2018 at 3:08 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:>
> Document RZ/G2M (r8a774a1) SoC specific bindings and RZ/G2
> generic bindings.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Chris Paterson <Chris.Paterson2@renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> @@ -4,6 +4,7 @@ Renesas R-Car CAN controller Device Tree Bindings
>  Required properties:
>  - compatible: "renesas,can-r8a7743" if CAN controller is a part of R8A7743 SoC.
>               "renesas,can-r8a7745" if CAN controller is a part of R8A7745 SoC.
> +             "renesas,can-r8a774a1" if CAN controller is a part of R8A774A1 SoC.

Looks good to me.

>               "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC.
>               "renesas,can-r8a7779" if CAN controller is a part of R8A7779 SoC.
>               "renesas,can-r8a7790" if CAN controller is a part of R8A7790 SoC.
> @@ -17,6 +18,7 @@ Required properties:
>               "renesas,rcar-gen2-can" for a generic R-Car Gen2 or RZ/G1
>               compatible device.
>               "renesas,rcar-gen3-can" for a generic R-Car Gen3 compatible device.
> +             "renesas,rzg-gen2-can" for a generic RZ/G2 compatible device.

AFAIK, the actual CAN module in RZ/G2M is fully compatible with the CAN
module in R-Car Gen3 SoCs. The lack of clkp2 is merely an integration
difference: as RZ/G2 SoCs do not have the CANFD module, and their CPG block
doesn't provide the CANFD clock (so the CAN device node in DT cannot refer
to that clock anyway).

Hence I don't think there's a need to introduce a "renesas,rzg-gen2-can"
compatible value.

>               When compatible with the generic version, nodes must list the
>               SoC-specific version corresponding to the platform first
>               followed by the generic version.
> @@ -24,7 +26,9 @@ Required properties:
>  - reg: physical base address and size of the R-Car CAN register map.
>  - interrupts: interrupt specifier for the sole interrupt.
>  - clocks: phandles and clock specifiers for 3 CAN clock inputs.

You still have "3" here. Perhaps
"Must contain a phandle and clock-specifier pair for each entry in
clock-names."?

> -- clock-names: 3 clock input name strings: "clkp1", "clkp2", "can_clk".
> +- clock-names: 2 clock input name strings for RZ/G2: "clkp1", "can_clk".
> +              3 clock input name strings for every other SoC: "clkp1", "clkp2",
> +              "can_clk".

OK.

> @@ -41,8 +45,9 @@ using the below properties:
>  Optional properties:
>  - renesas,can-clock-select: R-Car CAN Clock Source Select. Valid values are:
>                             <0x0> (default) : Peripheral clock (clkp1)
> -                           <0x1> : Peripheral clock (clkp2)
> -                           <0x3> : Externally input clock
> +                           <0x1> : Peripheral clock (clkp2) (not supported by
> +                                   RZ/G2 devices)
> +                           <0x3> : External input clock

I already expressed my feelings about this property in my reply to the first
patch ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
