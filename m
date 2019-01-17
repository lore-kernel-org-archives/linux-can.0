From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH 07/11] arm64: dts: renesas: cat875: Add ethernet support
Date: Thu, 17 Jan 2019 13:27:51 +0000
Message-ID: <TY1PR01MB1770241D7A553184ABB589DAC0830@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-8-git-send-email-fabrizio.castro@bp.renesas.com>
 <20190117115945.bmlaoeoqvsmdqqot@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190117115945.bmlaoeoqvsmdqqot@verge.net.au>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Biju Das <biju.das@bp.renesas.com>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, =?iso-8859-2?Q?Andreas_F=E4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, =?iso-8859-2?Q?Michal_Vok=E1=E8?= <michal.vokac@ysoft.com>Martin Blumenstingl <mar>
List-Id: linux-can.vger.kernel.org

Hello Simon,

Thank you for your feedback!

> From: Simon Horman <horms@verge.net.au>
> Sent: 17 January 2019 12:00
> Subject: Re: [PATCH 07/11] arm64: dts: renesas: cat875: Add ethernet supp=
ort
>
> On Wed, Jan 16, 2019 at 06:37:50PM +0000, Fabrizio Castro wrote:
> > From: Biju Das <biju.das@bp.renesas.com>
> >
> > This patch adds ethernet support to the sub board.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> > ---
> >  arch/arm64/boot/dts/renesas/cat875.dtsi | 30 +++++++++++++++++++++++++=
+++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/cat875.dtsi b/arch/arm64/boot/=
dts/renesas/cat875.dtsi
> > index a41d0d8..805ffa7 100644
> > --- a/arch/arm64/boot/dts/renesas/cat875.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/cat875.dtsi
> > @@ -7,4 +7,34 @@
> >
> >  / {
> >  model =3D "Silicon Linux sub board for CAT874 (CAT875)";
> > +
> > +aliases {
> > +ethernet0 =3D &avb;
> > +};
> > +};
> > +
> > +&avb {
> > +pinctrl-0 =3D <&avb_pins>;
> > +pinctrl-names =3D "default";
> > +renesas,no-ether-link;
>
> Is the renesas,no-ether-link required?

The AVB_LINK pin from the SoC is connected to the PMEB (Power Management Ev=
ent, B stands for
active low) pin on the  PHY, which means it is not a link signal. The PMEB =
signal is active when a magic
packet or a wake up frame are detected. As a result, we need renesas,no-eth=
er-link and we can't
specify avb_link with avb_pin either.

Thanks,
Fab

>
> My understanding is that "the property should only be used when a
> board does not provide a proper AVB_LINK signal". And from my reading
> of the schematic it looks like that signal may be provided on this board.
>
> That said, I have an outstanding patch for this for E3/Ebisu which
> I have not applied because I am unsure of its correctness.
>
> [PATCH] arm64: dts: renesas: ebisu: Remove renesas, no-ether-link propert=
y
> https://patchwork.kernel.org/patch/10692755/
>
> Similar patches have been applied for other boards.
> f.e:
>
> [PATCH] arm64: dts: renesas: salvator-x: Remove renesas, no-ether-link pr=
operty
> https://git.kernel.org/torvalds/c/87c059e9c39d
>
> > +phy-handle =3D <&phy0>;
> > +phy-mode =3D "rgmii";
> > +status =3D "okay";
> > +
> > +phy0: ethernet-phy@0 {
> > +rxc-skew-ps =3D <1500>;
> > +reg =3D <0>;
> > +interrupt-parent =3D <&gpio2>;
> > +interrupts =3D <21 IRQ_TYPE_LEVEL_LOW>;
> > +reset-gpios =3D <&gpio1 20 GPIO_ACTIVE_LOW>;
> > +};
> > +};
> > +
> > +&pfc {
> > +avb_pins: avb {
> > +mux {
> > +groups =3D "avb_mii";
> > +function =3D "avb";
> > +};
> > +};
> >  };
> > --
> > 2.7.4
> >



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
