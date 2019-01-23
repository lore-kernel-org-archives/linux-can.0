From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH 2/3] arm64: dts: renesas: r8a774a1: Add clkp2 clock to CAN
 nodes
Date: Wed, 23 Jan 2019 12:00:54 +0000
Message-ID: <TYXPR01MB1775ABDCFD939F91F1053534C0990@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <1547736856-16539-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547736856-16539-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <20190118121353.3mb44a7rmmp2ru5d@verge.net.au>
 <20190123095122.l3engeuwx6qr5lzc@verge.net.au>
 <20190123113812.e3nojtxjxywmg4gn@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190123113812.e3nojtxjxywmg4gn@verge.net.au>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "David S. Miller" <davem@davemloft.net>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Hello Simon,

Thank you for your feedback!

> From: Simon Horman <horms@verge.net.au>
> Sent: 23 January 2019 11:38
> Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a774a1: Add clkp2 clock t=
o CAN nodes
>
> On Wed, Jan 23, 2019 at 10:51:23AM +0100, Simon Horman wrote:
> > On Fri, Jan 18, 2019 at 01:13:53PM +0100, Simon Horman wrote:
> > > On Thu, Jan 17, 2019 at 02:54:15PM +0000, Fabrizio Castro wrote:
> > > > According to the latest information, clkp2 is available on RZ/G2.
> > > > Modify CAN0 and CAN1 nodes accordingly.
> > > >
> > > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > > Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> > >
> > > Thanks,
> > >
> > > This looks fine to me but I will wait to see if there are other revie=
ws
> > > before applying.
> > >
> > > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> >
> > Thanks again, applied for v5.1.
>
> Sorry, I was a little hasty there.
>
> This patch depends on the presence of R8A774A1_CLK_CANFD which
> (rightly) is added in a different patch in this series which is to
> go upstream via a different tree.
>
> I have dropped this patch for now. I think there are two solution to this
> problem.
>
> 1. Provide a version of this patch which uses a numeric index instead of
>    R8A774A1_CLK_CANFD. And then, once R8A774A1_CLK_CANFD is present in an
>    RC release provide a patch to switch to using R8A774A1_CLK_CANFD.
>
> 2. Defer this patch until R8A774A1_CLK_CANFD is present in an RC release.
>

Yeah, my personal preference is solution 2.

Thanks,
Fab



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
