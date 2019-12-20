From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: can: rcar_can: Add r8a774b1 support
Date: Fri, 20 Dec 2019 16:01:20 +0100
Message-ID: <CAMuHMdV+1g9Oh9YPSsRQYO0=k8DYoaBhthY0HxSUVW9=L5jeFA@mail.gmail.com>
References: <1570717560-7431-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1570717560-7431-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <20191014181016.GA1927@bogus> <TY1PR01MB17708F6646BD736C52A22BFCC0530@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <TY1PR01MB17708F6646BD736C52A22BFCC0530@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Sender: netdev-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Jacopo Mondi <jac>
List-Id: linux-can.vger.kernel.org

Hi Fabrizio,

On Wed, Dec 18, 2019 at 4:15 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Do you think you can take this patch?

Sure, queuing in renesas-dt-bindings-for-v5.6.

> > From: Rob Herring <robh@kernel.org>
> > Sent: 14 October 2019 19:10
> > Subject: Re: [PATCH net-next v2 1/3] dt-bindings: can: rcar_can: Add r8a774b1 support
> >
> > On Thu, 10 Oct 2019 15:25:58 +0100, Fabrizio Castro wrote:
> > > Document RZ/G2N (r8a774b1) SoC specific bindings.
> > >
> > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > v1->v2:
> > > * No change
> > >
> > >  Documentation/devicetree/bindings/net/can/rcar_can.txt | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> >
> > Acked-by: Rob Herring <robh@kernel.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
