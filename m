From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v41 2/3] dt-binding: can: mcp25xxfd: document device tree
 bindings
Date: Tue, 23 Jun 2020 11:42:44 +0530
Message-ID: <20200623061244.GA13669@Mani-XPS-13-9360>
References: <20200622114603.965371-1-mkl@pengutronix.de>
 <20200622114603.965371-3-mkl@pengutronix.de>
 <20200622165325.GA23113@Mani-XPS-13-9360>
 <89ebabc5-dd88-32ed-65b3-911d3d80237b@pengutronix.de>
 <20200623032635.GG11093@Mani-XPS-13-9360>
 <20200623060201.ms2brvzk7s6arnjf@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbgFWGMv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Jun 2020 02:12:51 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49376C061573
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 23:12:51 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a127so9578999pfa.12
        for <linux-can@vger.kernel.org>; Mon, 22 Jun 2020 23:12:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200623060201.ms2brvzk7s6arnjf@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, dev.kurt@vandijck-laurijssen.be

On Tue, Jun 23, 2020 at 08:02:01AM +0200, Oleksij Rempel wrote:
> On Tue, Jun 23, 2020 at 08:56:35AM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jun 22, 2020 at 08:12:58PM +0200, Marc Kleine-Budde wrote:
> > > On 6/22/20 6:53 PM, Manivannan Sadhasivam wrote:
> > > > Hi,
> > > > 
> > > > On Mon, Jun 22, 2020 at 01:46:02PM +0200, Marc Kleine-Budde wrote:
> > > >> From: Oleksij Rempel <o.rempel@pengutronix.de>
> > > >>
> > > >> This patch adds the device-tree binding documentation for the Microchip
> > > >> MCP25xxFD SPI CAN controller family.
> > > >>
> > > >> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > >> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > > > 
> > > > You need to CC Rob and devicetree list to get a review for this patch.
> > > 
> > > Will do for next round.
> > > 
> > > > 
> > > >> ---
> > > >>  .../bindings/net/can/microchip,mcp25xxfd.yaml | 77 +++++++++++++++++++
> > > >>  1 file changed, 77 insertions(+)
> > > >>  create mode 100644 Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> > > >>
> > > >> diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> > > >> new file mode 100644
> > > >> index 000000000000..4993dd49181c
> > > >> --- /dev/null
> > > >> +++ b/Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
> > > >> @@ -0,0 +1,77 @@
> > > >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > >> +%YAML 1.2
> > > >> +---
> > > >> +$id: http://devicetree.org/schemas/net/can/microchip,mcp25xxfd.yaml#
> > > >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > >> +
> > > >> +title: Microchip MCP2517/18FD stand-alone CAN controller device tree bindings
> > > >> +

[...]

> > > >> +required:
> > > >> +  - compatible
> > > >> +  - reg
> > > >> +  - interrupts-extended
> > > >> +  - clocks
> > > >> +
> > > > 
> > > > The controller is capable of generating clocks and also able to control few
> > > > GPIOs. So eventually you need to document those properties in bindings even
> > > > your driver is not supporting all of them atm.
> > > 
> > > I'd like to add support for clocks and GPIOs as soon as someone needs them. DT
> > > bindings will go along with that. So far I have no customer that needs support
> > > for that, do you?
> > > 
> > 
> > DT binding should describe what the controller is capable of and not the
> > capability of the driver. You can always add functionality to driver but binding
> > should stay as it is (although there are exceptions...).
> 
> Adding binding for not implemented functionality adds more confusion:
> - without implementing it, you do not know, how exactly should it be
>   done. Should we request gpio as gpio or as irq? This will affect
>   actual bindings.
> - we need to care about backwards compatibility, implementing binding
>   before knowing what they will do, will make driver development even harder.
>   You need to care about quirks for bogus binding which was actually
>   never used.
> - Extending a binding can be always done if needed. Making things "just
>   in case" will increase development overhead by reducing quality.
> 

This is not my call. Rob asked me to document all device specific properties
in binding before for some other controller. Let's see his response in next
iteration (we need to ask this question though).

Thanks,
Mani

> Regards,
> Oleksij
> 
> -- 
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
