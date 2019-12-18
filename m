From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH net-next v2 2/3] dt-bindings: can: rcar_canfd: document
 r8a774b1 support
Date: Wed, 18 Dec 2019 15:16:35 +0000
Message-ID: <TY1PR01MB17703B32045654CB46C2FC8BC0530@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1570717560-7431-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1570717560-7431-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <20191014181035.GA2613@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191014181035.GA2613@bogus>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Jacopo Mondi <jacopo+renesas@jmondi.org>
List-Id: linux-can.vger.kernel.org

Hi Geert,

Do you think you can take this patch?

Thanks,
Fab

> From: linux-renesas-soc-owner@vger.kernel.org <linux-renesas-soc-owner@vg=
er.kernel.org> On Behalf Of Rob Herring
> Sent: 14 October 2019 19:11
> Subject: Re: [PATCH net-next v2 2/3] dt-bindings: can: rcar_canfd: docume=
nt r8a774b1 support
>=20
> On Thu, 10 Oct 2019 15:25:59 +0100, Fabrizio Castro wrote:
> > Document the support for rcar_canfd on R8A774B1 SoC devices.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v1->v2:
> > * Added the R8A774B1 to the clock paragraph according to Geert's commen=
t
> >
> >  Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
>=20
> Acked-by: Rob Herring <robh@kernel.org>
