From: Chris Paterson <Chris.Paterson2@renesas.com>
Subject: RE: [PATCH 02/11] dt-bindings: arm: renesas: Add si-linux cat87[45]
 boards
Date: Thu, 17 Jan 2019 12:32:37 +0000
Message-ID: <TYAPR01MB2285EAE232CCADD7FB95E712B7830@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <20190117105107.dtuttem7x7ovaey2@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190117105107.dtuttem7x7ovaey2@verge.net.au>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, =?iso-8859-2?Q?Andreas_F=E4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, =?iso-8859-2?Q?Michal_Vok=E1=E8?= <michal.vokac@ysoft.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>Be
List-Id: linux-can.vger.kernel.org

Hello Simon,

> From: Simon Horman <horms@verge.net.au>
> Sent: 17 January 2019 10:51
>=20
> On Wed, Jan 16, 2019 at 06:37:45PM +0000, Fabrizio Castro wrote:
> > This patch adds board cat874 (powered by the RZ/G2E) and board
> > cat875 (that sits on top of cat874). Both boards are made by
> > Silicon Linux.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> > ---
> >  Documentation/devicetree/bindings/arm/renesas.yaml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml
> b/Documentation/devicetree/bindings/arm/renesas.yaml
> > index 5e9d486..9e1e07b 100644
> > --- a/Documentation/devicetree/bindings/arm/renesas.yaml
> > +++ b/Documentation/devicetree/bindings/arm/renesas.yaml
> > @@ -108,6 +108,14 @@ properties:
> >
> >        - description: RZ/G2E (R8A774C0)
> >          items:
> > +          - enum:
> > +              - si-linux,cat874 # Silicon Linux RZ/G2E 96board platfor=
m (CAT874)
>=20
> Can I confirm that "96board platform" is correct for this board - I don't
> see it in the documentation I have, but that may not mean much.

The board follows the extended version of the Linaro 96board consumer editi=
on (CE) specification [1].

You can see a pretty picture of the board on the CIP Blog [2].

[1] https://www.96boards.org/specifications/
[2] https://www.cip-project.org/blog/2018/10/23/renesas-rz-g2m-96ce-board-a=
dopted-as-arm64-reference-board-for-the-next-cip-slts-kernel

Kind regards, Chris

>=20
>=20
> That aside, I'd like to wait for Rob to indicate if he will accept
> patch 1, which adds si-linux as a vendor, before I apply this patch.
>=20
> > +          - const: renesas,r8a774c0
> > +
> > +      - items:
> > +          - enum:
> > +              - si-linux,cat875 # Silicon Linux sub board for CAT874 (=
CAT875)
> > +          - const: si-linux,cat874
> >            - const: renesas,r8a774c0
> >
> >        - description: R-Car M1A (R8A77781)
> > --
> > 2.7.4
> >
