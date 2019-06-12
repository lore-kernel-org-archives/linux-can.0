From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH repost 0/5] Repost CAN and CANFD dt-bindings
Date: Wed, 12 Jun 2019 14:20:20 +0200
Message-ID: <20190612122020.sgp5q427ilh6bbbg@verge.net.au>
References: <1557429622-31676-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY1PR01MB1770D2AAF2ED748575CA4CBFC0100@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <TY1PR01MB1770D2AAF2ED748575CA4CBFC0100@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, "David S. Miller" <davem@davemloft.net>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Dave,

are you comfortable with me taking these patches
through the renesas tree? Or perhaps should they be reposted
to you for inclusion in net-next?

They have been stuck for a long time now.

On Fri, Jun 07, 2019 at 10:02:13AM +0000, Fabrizio Castro wrote:
> Dear All,
> 
> These patches have been around for a very long time now, is anybody willing to take them?
> 
> Cheers,
> Fab
> 
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Sent: 09 May 2019 20:20
> > Subject: [PATCH repost 0/5] Repost CAN and CANFD dt-bindings
> > 
> > Dear All,
> > 
> > I am reposting some CAN and CANFD related dt-bindings changes for
> > Renesas' R-Car and RZ/G devices that have been originally sent
> > end of last year and beginning of this year.
> > 
> > Thanks,
> > Fab
> > 
> > Fabrizio Castro (3):
> >   dt-bindings: can: rcar_can: Fix RZ/G2 CAN clocks
> >   dt-bindings: can: rcar_can: Add r8a774c0 support
> >   dt-bindings: can: rcar_canfd: document r8a774c0 support
> > 
> > Marek Vasut (2):
> >   dt-bindings: can: rcar_canfd: document r8a77965 support
> >   dt-bindings: can: rcar_canfd: document r8a77990 support
> > 
> >  Documentation/devicetree/bindings/net/can/rcar_can.txt   | 13 ++++---------
> >  Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 16 ++++++++++------
> >  2 files changed, 14 insertions(+), 15 deletions(-)
> > 
> > --
> > 2.7.4
> 
