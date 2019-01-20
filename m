From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 07/11] arm64: dts: renesas: cat875: Add ethernet support
Date: Sun, 20 Jan 2019 09:28:45 +0100
Message-ID: <20190120082845.4apq3ylk4i6zbhlx@verge.net.au>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-8-git-send-email-fabrizio.castro@bp.renesas.com>
 <20190117115945.bmlaoeoqvsmdqqot@verge.net.au>
 <TY1PR01MB1770241D7A553184ABB589DAC0830@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <TY1PR01MB1770241D7A553184ABB589DAC0830@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Sender: netdev-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Biju Das <biju.das@bp.renesas.com>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, Martin Blumenstingl <martin.>
List-Id: linux-can.vger.kernel.org

On Thu, Jan 17, 2019 at 01:27:51PM +0000, Fabrizio Castro wrote:
> Hello Simon,
> 
> Thank you for your feedback!
> 
> > From: Simon Horman <horms@verge.net.au>
> > Sent: 17 January 2019 12:00
> > Subject: Re: [PATCH 07/11] arm64: dts: renesas: cat875: Add ethernet support
> >
> > On Wed, Jan 16, 2019 at 06:37:50PM +0000, Fabrizio Castro wrote:
> > > From: Biju Das <biju.das@bp.renesas.com>
> > >
> > > This patch adds ethernet support to the sub board.
> > >
> > > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> > > ---
> > >  arch/arm64/boot/dts/renesas/cat875.dtsi | 30 ++++++++++++++++++++++++++++++
> > >  1 file changed, 30 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/renesas/cat875.dtsi b/arch/arm64/boot/dts/renesas/cat875.dtsi
> > > index a41d0d8..805ffa7 100644
> > > --- a/arch/arm64/boot/dts/renesas/cat875.dtsi
> > > +++ b/arch/arm64/boot/dts/renesas/cat875.dtsi
> > > @@ -7,4 +7,34 @@
> > >
> > >  / {
> > >  model = "Silicon Linux sub board for CAT874 (CAT875)";
> > > +
> > > +aliases {
> > > +ethernet0 = &avb;
> > > +};
> > > +};
> > > +
> > > +&avb {
> > > +pinctrl-0 = <&avb_pins>;
> > > +pinctrl-names = "default";
> > > +renesas,no-ether-link;
> >
> > Is the renesas,no-ether-link required?
> 
> The AVB_LINK pin from the SoC is connected to the PMEB (Power Management Event, B stands for
> active low) pin on the  PHY, which means it is not a link signal. The PMEB signal is active when a magic
> packet or a wake up frame are detected. As a result, we need renesas,no-ether-link and we can't
> specify avb_link with avb_pin either.

Thanks for following-up. In that case I am fine with this patch.
