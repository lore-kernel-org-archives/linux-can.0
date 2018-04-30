From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] DT: net: can: rcar_canfd: document R8A77980 bindings
Date: Mon, 30 Apr 2018 09:37:22 +0200
Message-ID: <20180430073722.tbrd5y3bs5hpq724@verge.net.au>
References: <556f1f23-19bc-e7bd-47b1-f22e086e2b69@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <556f1f23-19bc-e7bd-47b1-f22e086e2b69@cogentembedded.com>
Sender: netdev-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Mark Rutland <mark.rutland@arm.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Fri, Apr 27, 2018 at 09:53:33PM +0300, Sergei Shtylyov wrote:
> Document the R-Car V3H (R8A77980) SoC support in the R-Car CAN-FD bindings.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the 'linux-can-next.git' repo plus the R8A77970 bindings
> patch posted yesterday. Although I wouldn't object if they're both merged to
> the 'linux-can.git' repo instead. :-)
> 
>  Documentation/devicetree/bindings/net/can/rcar_canfd.txt |    1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> 
> Index: linux-can-next/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> ===================================================================
> --- linux-can-next.orig/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> +++ linux-can-next/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> @@ -7,6 +7,7 @@ Required properties:
>    - "renesas,r8a7795-canfd" for R8A7795 (R-Car H3) compatible controller.
>    - "renesas,r8a7796-canfd" for R8A7796 (R-Car M3) compatible controller.
>    - "renesas,r8a77970-canfd" for R8A77970 (R-Car V3M) compatible controller.
> +  - "renesas,r8a77980-canfd" for R8A77980 (R-Car V3H) compatible controller.
>  
>    When compatible with the generic version, nodes must list the
>    SoC-specific version corresponding to the platform first, followed by the
> 
