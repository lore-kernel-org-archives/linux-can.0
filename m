From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH repost 0/5] Repost CAN and CANFD dt-bindings
Date: Fri, 7 Jun 2019 10:02:13 +0000
Message-ID: <TY1PR01MB1770D2AAF2ED748575CA4CBFC0100@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1557429622-31676-1-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1557429622-31676-1-git-send-email-fabrizio.castro@bp.renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: "David S. Miller" <davem@davemloft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Dear All,

These patches have been around for a very long time now, is anybody willing=
 to take them?

Cheers,
Fab

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 09 May 2019 20:20
> Subject: [PATCH repost 0/5] Repost CAN and CANFD dt-bindings
>=20
> Dear All,
>=20
> I am reposting some CAN and CANFD related dt-bindings changes for
> Renesas' R-Car and RZ/G devices that have been originally sent
> end of last year and beginning of this year.
>=20
> Thanks,
> Fab
>=20
> Fabrizio Castro (3):
>   dt-bindings: can: rcar_can: Fix RZ/G2 CAN clocks
>   dt-bindings: can: rcar_can: Add r8a774c0 support
>   dt-bindings: can: rcar_canfd: document r8a774c0 support
>=20
> Marek Vasut (2):
>   dt-bindings: can: rcar_canfd: document r8a77965 support
>   dt-bindings: can: rcar_canfd: document r8a77990 support
>=20
>  Documentation/devicetree/bindings/net/can/rcar_can.txt   | 13 ++++------=
---
>  Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 16 ++++++++++=
------
>  2 files changed, 14 insertions(+), 15 deletions(-)
>=20
> --
> 2.7.4
