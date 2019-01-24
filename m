From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a774a1: Add clkp2 clock to
 CAN nodes
Date: Thu, 24 Jan 2019 11:01:23 +0100
Message-ID: <20190124100123.a2gvucnnwrxibulf@verge.net.au>
References: <1547736856-16539-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547736856-16539-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <20190118121353.3mb44a7rmmp2ru5d@verge.net.au>
 <20190123095122.l3engeuwx6qr5lzc@verge.net.au>
 <20190123113812.e3nojtxjxywmg4gn@verge.net.au>
 <TYXPR01MB1775ABDCFD939F91F1053534C0990@TYXPR01MB1775.jpnprd01.prod.outlook.com>
 <CAMuHMdVkFJ7Cy-+tNHsOcYaxDj82WjMynuFuPRXa4k=DH2fGCQ@mail.gmail.com>
 <TYXPR01MB1775B75CED683E38B9171EA8C0990@TYXPR01MB1775.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <TYXPR01MB1775B75CED683E38B9171EA8C0990@TYXPR01MB1775.jpnprd01.prod.outlook.com>
Sender: netdev-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "David S. Miller" <davem@davemloft.net>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@v>
List-Id: linux-can.vger.kernel.org

On Wed, Jan 23, 2019 at 12:18:45PM +0000, Fabrizio Castro wrote:
> Hello Geert,
> 
> Thank you for your feedback!
> 
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Sent: 23 January 2019 12:08
> > Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a774a1: Add clkp2 clock to CAN nodes
> >
> > Hi Fabrizio,
> >
> > On Wed, Jan 23, 2019 at 1:01 PM Fabrizio Castro
> > <fabrizio.castro@bp.renesas.com> wrote:
> > > > From: Simon Horman <horms@verge.net.au>
> > > > Sent: 23 January 2019 11:38
> > > > Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a774a1: Add clkp2 clock to CAN nodes
> > > >
> > > > On Wed, Jan 23, 2019 at 10:51:23AM +0100, Simon Horman wrote:
> > > > > On Fri, Jan 18, 2019 at 01:13:53PM +0100, Simon Horman wrote:
> > > > > > On Thu, Jan 17, 2019 at 02:54:15PM +0000, Fabrizio Castro wrote:
> > > > > > > According to the latest information, clkp2 is available on RZ/G2.
> > > > > > > Modify CAN0 and CAN1 nodes accordingly.
> > > > > > >
> > > > > > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > > > > > Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> >
> > > > > Thanks again, applied for v5.1.
> > > >
> > > > Sorry, I was a little hasty there.
> > > >
> > > > This patch depends on the presence of R8A774A1_CLK_CANFD which
> > > > (rightly) is added in a different patch in this series which is to
> > > > go upstream via a different tree.
> > > >
> > > > I have dropped this patch for now. I think there are two solution to this
> > > > problem.
> > > >
> > > > 1. Provide a version of this patch which uses a numeric index instead of
> > > >    R8A774A1_CLK_CANFD. And then, once R8A774A1_CLK_CANFD is present in an
> > > >    RC release provide a patch to switch to using R8A774A1_CLK_CANFD.
> > > >
> > > > 2. Defer this patch until R8A774A1_CLK_CANFD is present in an RC release.
> > >
> > > Yeah, my personal preference is solution 2.
> >
> > Note that solution 2 will probably defer the DT patch to v5.2.
> 
> Yeah, my understanding is that even if we chose solution 1 we would still
> need to be waiting for v5.2 for the patch to switch to using
> R8A774A1_CLK_CANFD to appear in a rc, therefore I think solution 2 is
> fine.

Your understanding is the same as mine.

I do seem some slight value in option 1 in terms of getting the change,
less the minor issue of using an index rather than a symbol, upstream
earlier. But I do not feel strongly about this.

I am marking this patch as deferred. Please repost or otherwise ping me
when you would like to revisit this topic.
