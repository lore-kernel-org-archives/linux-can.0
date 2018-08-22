From: Chris Paterson <Chris.Paterson2@renesas.com>
Subject: RE: [PATCH] dt-bindings: can: rcar_can: Add r8a774a1 support
Date: Wed, 22 Aug 2018 15:12:26 +0000
Message-ID: <TYAPR01MB2285834E95AB0D0D3E2C5B72B7300@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <1534516703-11448-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180822104856.34nusjd4ajtwb4ef@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180822104856.34nusjd4ajtwb4ef@verge.net.au>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "David S. Miller" <davem@davemloft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Biju Das <biju.das@bp.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Hello Simon,

> From: Simon Horman <horms@verge.net.au>
> Sent: 22 August 2018 11:49
>=20
> On Fri, Aug 17, 2018 at 03:38:23PM +0100, Fabrizio Castro wrote:
> > Document RZ/G2M (r8a774a1) SoC bindings.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
>=20
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Thank you.

>=20
> > ---
> > This patch applies on top of next-20180817
> >
> >  Documentation/devicetree/bindings/net/can/rcar_can.txt | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> > b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> > index 94a7f33..84afc78 100644
> > --- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> > +++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> > @@ -4,6 +4,7 @@ Renesas R-Car CAN controller Device Tree Bindings
> > Required properties:
> >  - compatible: "renesas,can-r8a7743" if CAN controller is a part of R8A=
7743
> SoC.
> >  	      "renesas,can-r8a7745" if CAN controller is a part of R8A7745 So=
C.
> > +	      "renesas,can-r8a774a1" if CAN controller is a part of R8A774A1 =
SoC.
> >  	      "renesas,can-r8a7778" if CAN controller is a part of R8A7778 So=
C.
> >  	      "renesas,can-r8a7779" if CAN controller is a part of R8A7779 So=
C.
> >  	      "renesas,can-r8a7790" if CAN controller is a part of R8A7790 So=
C.
> > @@ -16,7 +17,8 @@ Required properties:
> >  	      "renesas,rcar-gen1-can" for a generic R-Car Gen1 compatible dev=
ice.
> >  	      "renesas,rcar-gen2-can" for a generic R-Car Gen2 or RZ/G1
> >  	      compatible device.
> > -	      "renesas,rcar-gen3-can" for a generic R-Car Gen3 compatible dev=
ice.
> > +	      "renesas,rcar-gen3-can" for a generic R-Car Gen3 or RZ/G2
> > +	      compatible device.
> >  	      When compatible with the generic version, nodes must list the
> >  	      SoC-specific version corresponding to the platform first
> >  	      followed by the generic version.
> > @@ -24,7 +26,9 @@ Required properties:
> >  - reg: physical base address and size of the R-Car CAN register map.
> >  - interrupts: interrupt specifier for the sole interrupt.
> >  - clocks: phandles and clock specifiers for 3 CAN clock inputs.
> > -- clock-names: 3 clock input name strings: "clkp1", "clkp2", "can_clk"=
.
> > +- clock-names: 2 clock input name strings for RZ/G2: "clkp1",
> > +"can_clk", and
>=20
> Minor comment: Personally I would start a new sentence at "and".
>=20
> Question: Is a driver update required so support 2-clock SoCs?

The driver will work okay as-is.

In theory CAN could be broken if renesas,can-clock-select is set to 0x1 (cl=
kp2) in the DT, as this value will be written to the CAN Clock Select Regis=
ter. However if the documentation is followed there will be no problems.

We should probably update the driver to fix this though, which will be a ch=
ange specific to all RZ/G2 devices, so perhaps we should also be adding a "=
renesas,rzg-gen2-can" family compatible string as well? (to driver and docu=
mentation)

Kind regards, Chris

>=20
> > +	       3 clock input name strings for every other SoC: "clkp1", "clkp=
2",
> > +	       "can_clk".
> >  - pinctrl-0: pin control group to be used for this controller.
> >  - pinctrl-names: must be "default".
> >
> > --
> > 2.7.4
> >
