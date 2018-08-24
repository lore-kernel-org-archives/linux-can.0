From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH] dt-bindings: can: rcar_can: Add r8a774a1 support
Date: Fri, 24 Aug 2018 08:31:42 +0000
Message-ID: <TY1PR01MB177055864EEAD487C2917860C0360@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1534516703-11448-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180822104856.34nusjd4ajtwb4ef@verge.net.au>
 <TYAPR01MB2285834E95AB0D0D3E2C5B72B7300@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20180824082643.7eapxf72iuvkdw3j@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824082643.7eapxf72iuvkdw3j@verge.net.au>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Chris Paterson <Chris.Paterson2@renesas.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "David S. Miller" <davem@davemloft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Biju Das <biju.das@bp.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Hello Simon,

Thank you for the feedback!

> >
> > In theory CAN could be broken if renesas,can-clock-select is set to 0x1
> > (clkp2) in the DT, as this value will be written to the CAN Clock Selec=
t
> > Register. However if the documentation is followed there will be no
> > problems.
> >
> > We should probably update the driver to fix this though, which will be =
a
> > change specific to all RZ/G2 devices, so perhaps we should also be addi=
ng
> > a "renesas,rzg-gen2-can" family compatible string as well? (to driver a=
nd
> > documentation)
>
> Yes, I think that sounds reasonable.
>
> But in that case we should pre-emptively not use renesas,rcar-gen3-can fo=
r
> RZ/G2.

What do you think about the following:
https://patchwork.kernel.org/patch/10573795/
https://patchwork.kernel.org/patch/10573791/
https://patchwork.kernel.org/patch/10573805/

Thanks,
Fab




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
