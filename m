From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH 2/3] arm64: dts: renesas: r8a774a1: Add clkp2 clock to CAN
 nodes
Date: Tue, 19 Mar 2019 11:22:35 +0000
Message-ID: <TY1PR01MB1770A2ACD8287D3675270A0AC0400@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1547736856-16539-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547736856-16539-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <20190118121353.3mb44a7rmmp2ru5d@verge.net.au>
 <20190123095122.l3engeuwx6qr5lzc@verge.net.au>
 <20190123113812.e3nojtxjxywmg4gn@verge.net.au>
 <TYXPR01MB1775ABDCFD939F91F1053534C0990@TYXPR01MB1775.jpnprd01.prod.outlook.com>
 <CAMuHMdVkFJ7Cy-+tNHsOcYaxDj82WjMynuFuPRXa4k=DH2fGCQ@mail.gmail.com>
 <TYXPR01MB1775B75CED683E38B9171EA8C0990@TYXPR01MB1775.jpnprd01.prod.outlook.com>
 <20190124100123.a2gvucnnwrxibulf@verge.net.au>
 <TY1PR01MB177085C4C1DF3D9827EB769BC09B0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <20190128130111.t54jbcyx35fiymq6@verge.net.au>
 <TY1PR01MB177071330C7BD433A701F728C0960@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <TY1PR01MB177071330C7BD433A701F728C0960@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "David S. Miller" <davem@davemloft.net>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@v>
List-Id: linux-can.vger.kernel.org

Hello Simon,

> From: devicetree-owner@vger.kernel.org <devicetree-owner@vger.kernel.org>=
 On Behalf Of Fabrizio Castro
> Sent: 28 January 2019 14:49
> Subject: RE: [PATCH 2/3] arm64: dts: renesas: r8a774a1: Add clkp2 clock t=
o CAN nodes
>=20
> > From: Simon Horman <horms@verge.net.au>
> > Sent: 28 January 2019 13:01
> > Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a774a1: Add clkp2 clock=
 to CAN nodes
> >
> > On Fri, Jan 25, 2019 at 11:33:41AM +0000, Fabrizio Castro wrote:
> > > Hello Simon,
> > >
> > > Thank you for your feedback!
> > >
> > > > From: Simon Horman <horms@verge.net.au>
> > > > Sent: 24 January 2019 10:01
> > > > Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a774a1: Add clkp2 c=
lock to CAN nodes
> > > >
> > > > On Wed, Jan 23, 2019 at 12:18:45PM +0000, Fabrizio Castro wrote:
> > > > > Hello Geert,
> > > > >
> > > > > Thank you for your feedback!
> > > > >
> > > > > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > Sent: 23 January 2019 12:08
> > > > > > Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a774a1: Add clk=
p2 clock to CAN nodes
> > > > > >
> > > > > > Hi Fabrizio,
> > > > > >
> > > > > > On Wed, Jan 23, 2019 at 1:01 PM Fabrizio Castro
> > > > > > <fabrizio.castro@bp.renesas.com> wrote:
> > > > > > > > From: Simon Horman <horms@verge.net.au>
> > > > > > > > Sent: 23 January 2019 11:38
> > > > > > > > Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a774a1: Add=
 clkp2 clock to CAN nodes
> > > > > > > >
> > > > > > > > On Wed, Jan 23, 2019 at 10:51:23AM +0100, Simon Horman wrot=
e:
> > > > > > > > > On Fri, Jan 18, 2019 at 01:13:53PM +0100, Simon Horman wr=
ote:
> > > > > > > > > > On Thu, Jan 17, 2019 at 02:54:15PM +0000, Fabrizio Cast=
ro wrote:
> > > > > > > > > > > According to the latest information, clkp2 is availab=
le on RZ/G2.
> > > > > > > > > > > Modify CAN0 and CAN1 nodes accordingly.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.re=
nesas.com>
> > > > > > > > > > > Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.=
com>
> > > > > >
> > > > > > > > > Thanks again, applied for v5.1.
> > > > > > > >
> > > > > > > > Sorry, I was a little hasty there.
> > > > > > > >
> > > > > > > > This patch depends on the presence of R8A774A1_CLK_CANFD wh=
ich
> > > > > > > > (rightly) is added in a different patch in this series whic=
h is to
> > > > > > > > go upstream via a different tree.
> > > > > > > >
> > > > > > > > I have dropped this patch for now. I think there are two so=
lution to this
> > > > > > > > problem.
> > > > > > > >
> > > > > > > > 1. Provide a version of this patch which uses a numeric ind=
ex instead of
> > > > > > > >    R8A774A1_CLK_CANFD. And then, once R8A774A1_CLK_CANFD is=
 present in an
> > > > > > > >    RC release provide a patch to switch to using R8A774A1_C=
LK_CANFD.
> > > > > > > >
> > > > > > > > 2. Defer this patch until R8A774A1_CLK_CANFD is present in =
an RC release.
> > > > > > >
> > > > > > > Yeah, my personal preference is solution 2.
> > > > > >
> > > > > > Note that solution 2 will probably defer the DT patch to v5.2.
> > > > >
> > > > > Yeah, my understanding is that even if we chose solution 1 we wou=
ld still
> > > > > need to be waiting for v5.2 for the patch to switch to using
> > > > > R8A774A1_CLK_CANFD to appear in a rc, therefore I think solution =
2 is
> > > > > fine.
> > > >
> > > > Your understanding is the same as mine.
> > > >
> > > > I do seem some slight value in option 1 in terms of getting the cha=
nge,
> > > > less the minor issue of using an index rather than a symbol, upstre=
am
> > > > earlier. But I do not feel strongly about this.
> > > >
> > > > I am marking this patch as deferred. Please repost or otherwise pin=
g me
> > > > when you would like to revisit this topic.
> > >
> > > Thank you. Will do.
> >
> > Thanks.
> >
> > I believe "[10/11] arm64: dts: renesas: r8a774c0: Add clkp2 clock to CA=
N nodes"
> > falls into the same category. I have marked it as deferred accordingly.
>=20
> Ok, thank you Simon

My understanding is that this patch can now be taken, and it still applies =
neatly.

Thanks,
Fab

>=20
> Fab
>=20
>=20
>=20
>=20
> Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End,=
 Buckinghamshire, SL8 5FH, UK. Registered in England &
> Wales under Registered No. 04586709.
