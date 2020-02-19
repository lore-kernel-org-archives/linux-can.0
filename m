From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: m_can: Add Documentation for
 transceiver regulator
Date: Wed, 19 Feb 2020 14:35:29 -0600
Message-ID: <20200219203529.GA21085@bogus>
References: <20200217142836.23702-1-faiz_abbas@ti.com>
 <20200217142836.23702-2-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200217142836.23702-2-faiz_abbas-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, sriram.dash-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, dmurphy-l0cyMroinI0@public.gmane.org
List-Id: linux-can.vger.kernel.org

On Mon, Feb 17, 2020 at 07:58:34PM +0530, Faiz Abbas wrote:
> Some CAN transceivers have a standby line that needs to be asserted
> before they can be used. Model this GPIO lines as an optional
> fixed-regulator node. Document bindings for the same.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/net/can/m_can.txt | 3 +++
>  1 file changed, 3 insertions(+)

This has moved to DT schema in my tree, so please adjust it and resend.

> diff --git a/Documentation/devicetree/bindings/net/can/m_can.txt b/Documentation/devicetree/bindings/net/can/m_can.txt
> index ed614383af9c..f17e2a5207dc 100644
> --- a/Documentation/devicetree/bindings/net/can/m_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/m_can.txt
> @@ -48,6 +48,9 @@ Optional Subnode:
>  			  that can be used for CAN/CAN-FD modes. See
>  			  Documentation/devicetree/bindings/net/can/can-transceiver.txt
>  			  for details.
> +
> +- xceiver-supply: Regulator that powers the CAN transceiver.

The supply for a transceiver should go in the transceiver node.

> +
>  Example:
>  SoC dtsi:
>  m_can1: can@20e8000 {
> -- 
> 2.19.2
> 
