From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/6] dt-bindings: can: rcar_canfd: document r8a774a1 support
Date: Mon, 8 Jul 2019 14:55:35 +0200
Message-ID: <CAMuHMdVdKVMiOZJVPyM_Y6YNvDsdTwf+EhmS3VJPUb_zOrf7Yw@mail.gmail.com>
References: <1560513214-28031-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1560513214-28031-2-git-send-email-fabrizio.castro@bp.renesas.com> <20190617093023.nhvrvujg52gcglko@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190617093023.nhvrvujg52gcglko@verge.net.au>
Sender: netdev-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-can@vger.kernel.org, netdev <netdev@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On Mon, Jun 17, 2019 at 11:30 AM Simon Horman <horms@verge.net.au> wrote:
> On Fri, Jun 14, 2019 at 12:53:29PM +0100, Fabrizio Castro wrote:
> > Document the support for rcar_canfd on R8A774A1 SoC devices.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > ---
> > Hello Simon,
> >
> > I think it would make more sense if this patch went through you as it
> > sits on series:
> > https://lkml.org/lkml/2019/5/9/941
> >
> > Do you think that's doable?
>
> That seems reasonable to me.
>
> Dave are you happy with me taking this, and 2/6, through
> the renesas tree?

As the previous change to this file was acked by Dave, and went in through
the Renesas tree, have I applied this patch and patch 2/6, and queued
it for v5.4.

Thanks!

> >  Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> > index 32f051f..00afaff 100644
> > --- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> > +++ b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> > @@ -4,6 +4,7 @@ Renesas R-Car CAN FD controller Device Tree Bindings
> >  Required properties:
> >  - compatible: Must contain one or more of the following:
> >    - "renesas,rcar-gen3-canfd" for R-Car Gen3 and RZ/G2 compatible controllers.
> > +  - "renesas,r8a774a1-canfd" for R8A774A1 (RZ/G2M) compatible controller.
> >    - "renesas,r8a774c0-canfd" for R8A774C0 (RZ/G2E) compatible controller.
> >    - "renesas,r8a7795-canfd" for R8A7795 (R-Car H3) compatible controller.
> >    - "renesas,r8a7796-canfd" for R8A7796 (R-Car M3-W) compatible controller.
> > @@ -32,10 +33,10 @@ enable/disable the respective channel.
> >  Required properties for "renesas,r8a774c0-canfd", "renesas,r8a7795-canfd",
> >  "renesas,r8a7796-canfd", "renesas,r8a77965-canfd", and "renesas,r8a77990-canfd"
> >  compatible:
> > -In R8A774C0, R8A7795, R8A7796, R8A77965, and R8A77990 SoCs, canfd clock is a
> > -div6 clock and can be used by both CAN and CAN FD controller at the same time.
> > -It needs to be scaled to maximum frequency if any of these controllers use it.
> > -This is done using the below properties:
> > +In R8A774A1, R8A774C0, R8A7795, R8A7796, R8A77965, and R8A77990 SoCs, canfd
> > +clock is a div6 clock and can be used by both CAN and CAN FD controller at the
> > +same time. It needs to be scaled to maximum frequency if any of these
> > +controllers use it. This is done using the below properties:
> >
> >  - assigned-clocks: phandle of canfd clock.
> >  - assigned-clock-rates: maximum frequency of this clock.

Gr{oetje,eeting}s,

                        Geert
