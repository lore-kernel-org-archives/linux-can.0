From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v41 2/3] dt-binding: can: mcp25xxfd: document device tree
 bindings
Date: Tue, 23 Jun 2020 08:56:35 +0530
Message-ID: <20200623032635.GG11093@Mani-XPS-13-9360>
References: <20200622114603.965371-1-mkl@pengutronix.de>
 <20200622114603.965371-3-mkl@pengutronix.de>
 <20200622165325.GA23113@Mani-XPS-13-9360>
 <89ebabc5-dd88-32ed-65b3-911d3d80237b@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730129AbgFWD0m (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Jun 2020 23:26:42 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7A9C061573
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 20:26:41 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id q22so6371606pgk.2
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 20:26:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <89ebabc5-dd88-32ed-65b3-911d3d80237b@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be, Oleksij Rempel <o.rempel@pengutronix.de>

On Mon, Jun 22, 2020 at 08:12:58PM +0200, Marc Kleine-Budde wrote:
> On 6/22/20 6:53 PM, Manivannan Sadhasivam wrote:
> > Hi,
> > 
> > On Mon, Jun 22, 2020 at 01:46:02PM +0200, Marc Kleine-Budde wrote:
> >> From: Oleksij Rempel <o.rempel@pengutronix.de>
> >>
> >> This patch adds the device-tree binding documentation for the Microchip
> >> MCP25xxFD SPI CAN controller family.
> >>
> >> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > 
> > You need to CC Rob and devicetree list to get a review for this patch.
> 
> Will do for next round.
> 
> > 
> >> ---
> >>  .../bindings/net/can/microchip,mcp25xxfd.yaml | 77 +++++++++++++++++++
> >>  1 file changed, 77 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> >> new file mode 100644
> >> index 000000000000..4993dd49181c
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> >> @@ -0,0 +1,77 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/net/can/microchip,mcp25xxfd.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Microchip MCP2517/18FD stand-alone CAN controller device tree bindings
> >> +
> > 
> > MCP251{7/8}FD?
> 
> Which expansion rules should be use for the title? In sh-like shells it would be
> MCP251{7,8}FD.
> 

Either one. I was just concerned about the original one which might create
ambiguity.

> > 
> >> +maintainers:
> >> +  - Marc Kleine-Budde <mkl@pengutronix.de>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    oneOf:
> >> +      - const: microchip,mcp2517fd
> >> +        description: for MCP2517FD
> >> +      - const: microchip,mcp2518fd
> >> +        description: for MCP2518FD
> >> +      - const: microchip,mcp25xxfd
> >> +        description: to autodetect chip variant
> >> +
> > 
> > Actually what benefit this generic compatible provides? User who is integrating
> > this driver should know the exact controller instance he is playing with, isn't
> > it?
> 
> As the chip variant can be autodetected why not do it? It makes device tree
> overlays (e.g. for the rpi much simpler), as you don't have to specify the exact
> chip variant.
> 
> Testing is much easier, as I don't have to change the overlays if swapping the
> CAN hat.
> 

Okay.

> > 
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  interrupts-extended:
> >> +    maxItems: 1
> >> +
> > 
> > Document this just above 'interrupts' property.
> 
> Do you mean I should change the order?
> - reg:
> - clocks:
> - interrupts-extended:
> 

Sorry, please ignore this comment. You can keep the order as it is.

> > 
> >> +  clocks:
> >> +    maxItems: 1
> >> +
> >> +  vdd-supply:
> >> +    description: Regulator that powers the CAN controller.
> >> +    maxItems: 1
> >> +
> >> +  xceiver-supply:
> >> +    description: Regulator that powers the CAN transceiver.
> >> +    maxItems: 1
> >> +
> >> +  rx-int-gpios:

This doesn't look like a standard property. So I think you need to add
'microchip' prefix to make it as vendor specific.

> >> +    description:
> >> +      GPIO phandle of GPIO connected to to INT1 pin of the MCP25XXFD, which
> >> +      signals a pending RX interrupt.
> >> +    maxItems: 1
> >> +
> >> +  spi-max-frequency:
> >> +    description:
> >> +      Must be half or less of "clocks" frequency.
> >> +    maximum: 20000000
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - interrupts-extended
> >> +  - clocks
> >> +
> > 
> > The controller is capable of generating clocks and also able to control few
> > GPIOs. So eventually you need to document those properties in bindings even
> > your driver is not supporting all of them atm.
> 
> I'd like to add support for clocks and GPIOs as soon as someone needs them. DT
> bindings will go along with that. So far I have no customer that needs support
> for that, do you?
> 

DT binding should describe what the controller is capable of and not the
capability of the driver. You can always add functionality to driver but binding
should stay as it is (although there are exceptions...).

Thanks,
Mani

> > If you want you can take a look at the bindings patch I posted earlier:
> > 
> > dt-bindings: can: Document devicetree bindings for MCP25XXFD
> 
> regards,
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
