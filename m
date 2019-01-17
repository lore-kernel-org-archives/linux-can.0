From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 11/11] dt-bindings: can: rcar_canfd: document r8a774c0
 support
Date: Thu, 17 Jan 2019 13:11:37 +0100
Message-ID: <20190117121137.riri7nzwegkocnxc@verge.net.au>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-12-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1547663874-29411-12-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ben
List-Id: linux-can.vger.kernel.org

On Wed, Jan 16, 2019 at 06:37:54PM +0000, Fabrizio Castro wrote:
> Document the support for rcar_canfd on R8A774C0 SoC devices.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
> This patch depends on:
> https://patchwork.kernel.org/patch/10687999/
> https://patchwork.kernel.org/patch/10688001/
> 
>  Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 16 +++++++++-------

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> index 41049fe..32f051f 100644
> --- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> @@ -3,7 +3,8 @@ Renesas R-Car CAN FD controller Device Tree Bindings
>  
>  Required properties:
>  - compatible: Must contain one or more of the following:
> -  - "renesas,rcar-gen3-canfd" for R-Car Gen3 compatible controller.
> +  - "renesas,rcar-gen3-canfd" for R-Car Gen3 and RZ/G2 compatible controllers.
> +  - "renesas,r8a774c0-canfd" for R8A774C0 (RZ/G2E) compatible controller.
>    - "renesas,r8a7795-canfd" for R8A7795 (R-Car H3) compatible controller.
>    - "renesas,r8a7796-canfd" for R8A7796 (R-Car M3-W) compatible controller.
>    - "renesas,r8a77965-canfd" for R8A77965 (R-Car M3-N) compatible controller.
> @@ -28,12 +29,13 @@ The name of the child nodes are "channel0" and "channel1" respectively. Each
>  child node supports the "status" property only, which is used to
>  enable/disable the respective channel.
>  
> -Required properties for "renesas,r8a7795-canfd", "renesas,r8a7796-canfd",
> -"renesas,r8a77965-canfd" and "renesas,r8a77990-canfd" compatible:
> -In R8A7795, R8A7796, R8A77965 and R8A77990 SoCs, canfd clock is a div6 clock
> -and can be used by both CAN and CAN FD controller at the same time. It needs
> -to be scaled to maximum frequency if any of these controllers use it. This is
> -done using the below properties:
> +Required properties for "renesas,r8a774c0-canfd", "renesas,r8a7795-canfd",
> +"renesas,r8a7796-canfd", "renesas,r8a77965-canfd", and "renesas,r8a77990-canfd"
> +compatible:
> +In R8A774C0, R8A7795, R8A7796, R8A77965, and R8A77990 SoCs, canfd clock is a
> +div6 clock and can be used by both CAN and CAN FD controller at the same time.
> +It needs to be scaled to maximum frequency if any of these controllers use it.
> +This is done using the below properties:
>  
>  - assigned-clocks: phandle of canfd clock.
>  - assigned-clock-rates: maximum frequency of this clock.
> -- 
> 2.7.4
> 
