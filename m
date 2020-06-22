From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v41 2/3] dt-binding: can: mcp25xxfd: document device tree
 bindings
Date: Mon, 22 Jun 2020 22:23:25 +0530
Message-ID: <20200622165325.GA23113@Mani-XPS-13-9360>
References: <20200622114603.965371-1-mkl@pengutronix.de>
 <20200622114603.965371-3-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbgFVQxb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Jun 2020 12:53:31 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC929C061573
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 09:53:31 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id jz3so101209pjb.0
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 09:53:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200622114603.965371-3-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be, Oleksij Rempel <o.rempel@pengutronix.de>

Hi,

On Mon, Jun 22, 2020 at 01:46:02PM +0200, Marc Kleine-Budde wrote:
> From: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> This patch adds the device-tree binding documentation for the Microchip
> MCP25xxFD SPI CAN controller family.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

You need to CC Rob and devicetree list to get a review for this patch.

> ---
>  .../bindings/net/can/microchip,mcp25xxfd.yaml | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> new file mode 100644
> index 000000000000..4993dd49181c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/can/microchip,mcp25xxfd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP2517/18FD stand-alone CAN controller device tree bindings
> +

MCP251{7/8}FD?

> +maintainers:
> +  - Marc Kleine-Budde <mkl@pengutronix.de>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: microchip,mcp2517fd
> +        description: for MCP2517FD
> +      - const: microchip,mcp2518fd
> +        description: for MCP2518FD
> +      - const: microchip,mcp25xxfd
> +        description: to autodetect chip variant
> +

Actually what benefit this generic compatible provides? User who is integrating
this driver should know the exact controller instance he is playing with, isn't
it?

> +  reg:
> +    maxItems: 1
> +
> +  interrupts-extended:
> +    maxItems: 1
> +

Document this just above 'interrupts' property.

> +  clocks:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator that powers the CAN controller.
> +    maxItems: 1
> +
> +  xceiver-supply:
> +    description: Regulator that powers the CAN transceiver.
> +    maxItems: 1
> +
> +  rx-int-gpios:
> +    description:
> +      GPIO phandle of GPIO connected to to INT1 pin of the MCP25XXFD, which
> +      signals a pending RX interrupt.
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    description:
> +      Must be half or less of "clocks" frequency.
> +    maximum: 20000000
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts-extended
> +  - clocks
> +

The controller is capable of generating clocks and also able to control few
GPIOs. So eventually you need to document those properties in bindings even
your driver is not supporting all of them atm.

If you want you can take a look at the bindings patch I posted earlier:

dt-bindings: can: Document devicetree bindings for MCP25XXFD

Thanks,
Mani

> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        can@0 {
> +            compatible = "microchip,mcp25xxfd";
> +            reg = <0>;
> +            clocks = <&can0_osc>;
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&can0_pins>;
> +            spi-max-frequency = <20000000>;
> +            interrupts-extended = <&gpio 13 IRQ_TYPE_LEVEL_LOW>;
> +            rx-int-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
> +            vdd-supply = <&reg5v0>;
> +            xceiver-supply = <&reg5v0>;
> +        };
> +    };
> -- 
> 2.27.0
> 
