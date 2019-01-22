From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 02/11] dt-bindings: arm: renesas: Add si-linux cat87[45]
 boards
Date: Tue, 22 Jan 2019 15:49:53 +0100
Message-ID: <20190122144953.sevb3flzky6ja23r@verge.net.au>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <20190117105107.dtuttem7x7ovaey2@verge.net.au>
 <TYAPR01MB2285EAE232CCADD7FB95E712B7830@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20190117125912.y77powezi74rjtf7@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190117125912.y77powezi74rjtf7@verge.net.au>
Sender: netdev-owner@vger.kernel.org
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, Martin
List-Id: linux-can.vger.kernel.org

On Thu, Jan 17, 2019 at 01:59:12PM +0100, Simon Horman wrote:
> On Thu, Jan 17, 2019 at 12:32:37PM +0000, Chris Paterson wrote:
> > Hello Simon,
> > 
> > > From: Simon Horman <horms@verge.net.au>
> > > Sent: 17 January 2019 10:51
> > > 
> > > On Wed, Jan 16, 2019 at 06:37:45PM +0000, Fabrizio Castro wrote:
> > > > This patch adds board cat874 (powered by the RZ/G2E) and board
> > > > cat875 (that sits on top of cat874). Both boards are made by
> > > > Silicon Linux.
> > > >
> > > > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > > Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/renesas.yaml | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml
> > > b/Documentation/devicetree/bindings/arm/renesas.yaml
> > > > index 5e9d486..9e1e07b 100644
> > > > --- a/Documentation/devicetree/bindings/arm/renesas.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/renesas.yaml
> > > > @@ -108,6 +108,14 @@ properties:
> > > >
> > > >        - description: RZ/G2E (R8A774C0)
> > > >          items:
> > > > +          - enum:
> > > > +              - si-linux,cat874 # Silicon Linux RZ/G2E 96board platform (CAT874)
> > > 
> > > Can I confirm that "96board platform" is correct for this board - I don't
> > > see it in the documentation I have, but that may not mean much.
> > 
> > The board follows the extended version of the Linaro 96board consumer edition (CE) specification [1].
> > 
> > You can see a pretty picture of the board on the CIP Blog [2].
> > 
> > [1] https://www.96boards.org/specifications/
> > [2] https://www.cip-project.org/blog/2018/10/23/renesas-rz-g2m-96ce-board-adopted-as-arm64-reference-board-for-the-next-cip-slts-kernel
> 
> Thanks Chris, in that case I am fine with this patch.
> 
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> 
> > > That aside, I'd like to wait for Rob to indicate if he will accept
> > > patch 1, which adds si-linux as a vendor, before I apply this patch.

It appears that the use of si-linux as a vendor name.
Accordingly I have applied this patch for v5.1.

...
