From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 09/11] dt-bindings: can: rcar_can: Fix RZ/G2 CAN clocks
Date: Thu, 17 Jan 2019 13:01:29 +0100
Message-ID: <20190117120128.arjdug2mhqyuvq3k@verge.net.au>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-10-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547663874-29411-10-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ben
List-Id: linux-can.vger.kernel.org

On Wed, Jan 16, 2019 at 06:37:52PM +0000, Fabrizio Castro wrote:
> According to the latest information, the clock options for CAN on RZ/G2
> are the same as the ones available on R-Car Gen3

I'm taking your word for the above.
As the patch matches the description:

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> Fixes: 868b7c0f43e6 ("dt-bindings: can: rcar_can: Add r8a774a1 support")
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
>  Documentation/devicetree/bindings/net/can/rcar_can.txt | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> index 7fcf501..b463e12 100644
> --- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> @@ -28,13 +28,8 @@ Required properties:
>  
>  - reg: physical base address and size of the R-Car CAN register map.
>  - interrupts: interrupt specifier for the sole interrupt.
> -- clocks: phandles and clock specifiers for 2 CAN clock inputs for RZ/G2
> -	  devices.
> -	  phandles and clock specifiers for 3 CAN clock inputs for every other
> -	  SoC.
> -- clock-names: 2 clock input name strings for RZ/G2: "clkp1", "can_clk".
> -	       3 clock input name strings for every other SoC: "clkp1", "clkp2",
> -	       "can_clk".
> +- clocks: phandles and clock specifiers for 3 CAN clock inputs.
> +- clock-names: 3 clock input name strings: "clkp1", "clkp2", and "can_clk".
>  - pinctrl-0: pin control group to be used for this controller.
>  - pinctrl-names: must be "default".
>  
> @@ -50,8 +45,7 @@ using the below properties:
>  Optional properties:
>  - renesas,can-clock-select: R-Car CAN Clock Source Select. Valid values are:
>  			    <0x0> (default) : Peripheral clock (clkp1)
> -			    <0x1> : Peripheral clock (clkp2) (not supported by
> -				    RZ/G2 devices)
> +			    <0x1> : Peripheral clock (clkp2)
>  			    <0x3> : External input clock
>  
>  Example
> -- 
> 2.7.4
> 
