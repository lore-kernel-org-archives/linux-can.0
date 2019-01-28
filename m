From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 10/11] arm64: dts: renesas: r8a774c0: Add clkp2 clock to
 CAN nodes
Date: Mon, 28 Jan 2019 14:02:38 +0100
Message-ID: <20190128130238.gork4cep3qonghwz@verge.net.au>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-11-git-send-email-fabrizio.castro@bp.renesas.com>
 <20190117120541.slymsz47fjkzz3kg@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190117120541.slymsz47fjkzz3kg@verge.net.au>
Sender: netdev-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ben
List-Id: linux-can.vger.kernel.org

On Thu, Jan 17, 2019 at 01:05:42PM +0100, Simon Horman wrote:
> On Wed, Jan 16, 2019 at 06:37:53PM +0000, Fabrizio Castro wrote:
> > According to the latest information, clkp2 is available on RZ/G2.
> > Modify CAN0 and CAN1 nodes accordingly.
> > 
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> 
> Taking your word for the motivation for this change,
> this patch seems fine to me but I would like to wait for review
> from others.
> 
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

I am marking this as deferred until R8A774C0_CLK_CANFD
shows up in an rc release.

Alternatively I'd be happy to take a version that uses
numeric values, followed up by a patch to switching to R8A774C0_CLK_CANFD
once it is available in an rc release.

Please repost or otherwise ping me as appropriate.

> 
> > ---
> >  arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
> > index 3970aaf..326ab3a 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
> > @@ -809,8 +809,10 @@
> >  				     "renesas,rcar-gen3-can";
> >  			reg = <0 0xe6c30000 0 0x1000>;
> >  			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
> > -			clocks = <&cpg CPG_MOD 916>, <&can_clk>;
> > -			clock-names = "clkp1", "can_clk";
> > +			clocks = <&cpg CPG_MOD 916>,
> > +				 <&cpg CPG_CORE R8A774C0_CLK_CANFD>,
> > +				 <&can_clk>;
> > +			clock-names = "clkp1", "clkp2", "can_clk";
> >  			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
> >  			resets = <&cpg 916>;
> >  			status = "disabled";
> > @@ -821,8 +823,10 @@
> >  				     "renesas,rcar-gen3-can";
> >  			reg = <0 0xe6c38000 0 0x1000>;
> >  			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
> > -			clocks = <&cpg CPG_MOD 915>, <&can_clk>;
> > -			clock-names = "clkp1", "can_clk";
> > +			clocks = <&cpg CPG_MOD 915>,
> > +				 <&cpg CPG_CORE R8A774C0_CLK_CANFD>,
> > +				 <&can_clk>;
> > +			clock-names = "clkp1", "clkp2", "can_clk";
> >  			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
> >  			resets = <&cpg 915>;
> >  			status = "disabled";
> > -- 
> > 2.7.4
> > 
> 
