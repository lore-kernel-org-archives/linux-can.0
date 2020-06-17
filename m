From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH 1/6] dt-bindings: can: Document devicetree
 bindings for MCP25XXFD
Date: Wed, 17 Jun 2020 16:16:56 -0600
Message-ID: <20200617221656.GA2927781@bogus>
References: <20200610074711.10969-1-manivannan.sadhasivam@linaro.org>
 <20200610074711.10969-2-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200610074711.10969-2-manivannan.sadhasivam-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Manivannan Sadhasivam <manivannan.sadhasivam-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

On Wed, Jun 10, 2020 at 01:17:06PM +0530, Manivannan Sadhasivam wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> 
> Add devicetree YAML bindings for Microchip MCP25XXFD CAN controller.
> 
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> [mani: converted to YAML binding]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  .../bindings/net/can/microchip,mcp25xxfd.yaml | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> new file mode 100644
> index 000000000000..7b87ec328515
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/can/microchip,mcp25xxfd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP25XXFD stand-alone CAN controller binding
> +
> +maintainers:
> +  -  Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> +  -  Manivannan Sadhasivam <manivannan.sadhasivam-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> +
> +properties:
> +  compatible:
> +    const: microchip,mcp2517fd
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  vdd-supply:
> +    description: Regulator that powers the CAN controller
> +
> +  xceiver-supply:
> +    description: Regulator that powers the CAN transceiver
> +
> +  microchip,clock-out-div:
> +    description: Clock output pin divider
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32

You can drop the 'allOf' now.

> +    enum: [0, 1, 2, 4, 10]
> +    default: 10
> +
> +  microchip,clock-div2:
> +    description: Divide the internal clock by 2
> +    type: boolean
> +
> +  microchip,gpio-open-drain:
> +    description: Enable open-drain for all pins
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +  - gpio-controller

And '#gpio-cells'?

> +  - vdd-supply
> +  - xceiver-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +           #address-cells = <1>;
> +           #size-cells = <0>;
> +
> +           can0: can@1 {
> +                   compatible = "microchip,mcp2517fd";
> +                   reg = <1>;
> +                   clocks = <&clk24m>;
> +                   interrupt-parent = <&gpio4>;
> +                   interrupts = <13 0x8>;
> +                   vdd-supply = <&reg5v0>;
> +                   xceiver-supply = <&reg5v0>;
> +                   gpio-controller;
> +                   #gpio-cells = <2>;
> +           };
> +    };
> +
> +...
> -- 
> 2.17.1
> 
