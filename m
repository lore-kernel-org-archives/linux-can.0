From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/3] dt-bindings: can: rcar_can: Add r8a774a1 support
Date: Fri, 24 Aug 2018 11:17:06 +0200
Message-ID: <20180824091706.pcxymf7suyxcdprz@verge.net.au>
References: <1535029653-7418-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1535029653-7418-4-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1535029653-7418-4-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Thu, Aug 23, 2018 at 02:07:33PM +0100, Fabrizio Castro wrote:
> Document RZ/G2M (r8a774a1) SoC specific bindings and RZ/G2
> generic bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Chris Paterson <Chris.Paterson2@renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>

Are we sure these clocks are for all RZ/G2 SoCs?
If so:

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> 
> This patch applies on next-20180823
> 
>  Documentation/devicetree/bindings/net/can/rcar_can.txt | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> index 94a7f33..ae8fccc 100644
> --- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> @@ -4,6 +4,7 @@ Renesas R-Car CAN controller Device Tree Bindings
>  Required properties:
>  - compatible: "renesas,can-r8a7743" if CAN controller is a part of R8A7743 SoC.
>  	      "renesas,can-r8a7745" if CAN controller is a part of R8A7745 SoC.
> +	      "renesas,can-r8a774a1" if CAN controller is a part of R8A774A1 SoC.
>  	      "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC.
>  	      "renesas,can-r8a7779" if CAN controller is a part of R8A7779 SoC.
>  	      "renesas,can-r8a7790" if CAN controller is a part of R8A7790 SoC.
> @@ -17,6 +18,7 @@ Required properties:
>  	      "renesas,rcar-gen2-can" for a generic R-Car Gen2 or RZ/G1
>  	      compatible device.
>  	      "renesas,rcar-gen3-can" for a generic R-Car Gen3 compatible device.
> +	      "renesas,rzg-gen2-can" for a generic RZ/G2 compatible device.
>  	      When compatible with the generic version, nodes must list the
>  	      SoC-specific version corresponding to the platform first
>  	      followed by the generic version.
> @@ -24,7 +26,9 @@ Required properties:
>  - reg: physical base address and size of the R-Car CAN register map.
>  - interrupts: interrupt specifier for the sole interrupt.
>  - clocks: phandles and clock specifiers for 3 CAN clock inputs.
> -- clock-names: 3 clock input name strings: "clkp1", "clkp2", "can_clk".
> +- clock-names: 2 clock input name strings for RZ/G2: "clkp1", "can_clk".
> +	       3 clock input name strings for every other SoC: "clkp1", "clkp2",
> +	       "can_clk".
>  - pinctrl-0: pin control group to be used for this controller.
>  - pinctrl-names: must be "default".
>  
> @@ -41,8 +45,9 @@ using the below properties:
>  Optional properties:
>  - renesas,can-clock-select: R-Car CAN Clock Source Select. Valid values are:
>  			    <0x0> (default) : Peripheral clock (clkp1)
> -			    <0x1> : Peripheral clock (clkp2)
> -			    <0x3> : Externally input clock
> +			    <0x1> : Peripheral clock (clkp2) (not supported by
> +				    RZ/G2 devices)
> +			    <0x3> : External input clock
>  
>  Example
>  -------
> -- 
> 2.7.4
> 
