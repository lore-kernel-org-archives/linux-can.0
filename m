From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH 2/3][can-next] can: rcar_can: Add RZ/G2 support
Date: Fri, 24 Aug 2018 09:22:01 +0000
Message-ID: <TY1PR01MB1770D9C711DECB0A87AEBC34C0360@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1535029653-7418-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1535029653-7418-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180824091648.nishwazvmyolmeae@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180824091648.nishwazvmyolmeae@verge.net.au>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "David S. Miller" <davem@davemloft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Hello Simon,

Thank you for your feedback!

> Subject: Re: [PATCH 2/3][can-next] can: rcar_can: Add RZ/G2 support
>
> On Thu, Aug 23, 2018 at 02:07:32PM +0100, Fabrizio Castro wrote:
> > RZ/G2 devices don't have clkp2, therefore this commit adds a
> > generic compatible string for them to allow for proper checking
> > during probe.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Chris Paterson <Chris.Paterson2@renesas.com>
>
>
> Are we sure these clocks are for all RZ/G2 SoCs?

Section 52.1.1 of the HW manual and Figure 52.1 state this.

Thanks,
Fab

>
> If so
>
>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
>
>
> > ---
> >
> > This patch applies on linux-can-next-for-4.19-20180727
> >
> >  drivers/net/can/rcar/rcar_can.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rca=
r_can.c
> > index fbd9284..397208e 100644
> > --- a/drivers/net/can/rcar/rcar_can.c
> > +++ b/drivers/net/can/rcar/rcar_can.c
> > @@ -27,6 +27,7 @@
> >
> >  #define RCAR_SUPPORTED_CLOCKS(BIT(CLKR_CLKP1) | BIT(CLKR_CLKP2) | \
> >   BIT(CLKR_CLKEXT))
> > +#define RZG2_SUPPORTED_CLOCKS(BIT(CLKR_CLKP1) | BIT(CLKR_CLKEXT))
> >
> >  /* Mailbox configuration:
> >   * mailbox 60 - 63 - Rx FIFO mailboxes
> > @@ -933,6 +934,10 @@ static const struct of_device_id rcar_can_of_table=
[] __maybe_unused =3D {
> >  .compatible =3D "renesas,rcar-gen3-can",
> >  .data =3D (void *)RCAR_SUPPORTED_CLOCKS,
> >  },
> > +{
> > +.compatible =3D "renesas,rzg-gen2-can",
> > +.data =3D (void *)RZG2_SUPPORTED_CLOCKS,
> > +},
> >  { }
> >  };
> >  MODULE_DEVICE_TABLE(of, rcar_can_of_table);
> > --
> > 2.7.4
> >



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
