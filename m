From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH 3/3] dt-bindings: can: rcar_canfd: Document r8a774a1
 support
Date: Fri, 1 Mar 2019 12:06:26 +0000
Message-ID: <TYXPR01MB1775BCD55E8E4A66D1EBCADDC0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <1547736856-16539-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547736856-16539-4-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1547736856-16539-4-git-send-email-fabrizio.castro@bp.renesas.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Wolfgang Grandegger <wg@grandegger.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-can.vger.kernel.org

Hello Marc,

I am sorry to bother you.
Do you think you can take this patch?

Thanks,
Fab

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 17 January 2019 14:54
> Subject: [PATCH 3/3] dt-bindings: can: rcar_canfd: Document r8a774a1 supp=
ort
>=20
> Document support for rcar_canfd on R8A774A1 SoC devices.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
> This patch depends on:
> https://patchwork.kernel.org/patch/10766781/
>=20
>  Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 15 ++++++++--=
-----
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> index 32f051f..fd353a9 100644
> --- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> @@ -4,6 +4,7 @@ Renesas R-Car CAN FD controller Device Tree Bindings
>  Required properties:
>  - compatible: Must contain one or more of the following:
>    - "renesas,rcar-gen3-canfd" for R-Car Gen3 and RZ/G2 compatible contro=
llers.
> +  - "renesas,r8a774a1-canfd" for R8A774A1 (RZ/G2M) compatible controller=
.
>    - "renesas,r8a774c0-canfd" for R8A774C0 (RZ/G2E) compatible controller=
.
>    - "renesas,r8a7795-canfd" for R8A7795 (R-Car H3) compatible controller=
.
>    - "renesas,r8a7796-canfd" for R8A7796 (R-Car M3-W) compatible controll=
er.
> @@ -29,13 +30,13 @@ The name of the child nodes are "channel0" and "chann=
el1" respectively. Each
>  child node supports the "status" property only, which is used to
>  enable/disable the respective channel.
>=20
> -Required properties for "renesas,r8a774c0-canfd", "renesas,r8a7795-canfd=
",
> -"renesas,r8a7796-canfd", "renesas,r8a77965-canfd", and "renesas,r8a77990=
-canfd"
> -compatible:
> -In R8A774C0, R8A7795, R8A7796, R8A77965, and R8A77990 SoCs, canfd clock =
is a
> -div6 clock and can be used by both CAN and CAN FD controller at the same=
 time.
> -It needs to be scaled to maximum frequency if any of these controllers u=
se it.
> -This is done using the below properties:
> +Required properties for "renesas,r8a774a1-canfd", "renesas,r8a774c0-canf=
d",
> +"renesas,r8a7795-canfd", "renesas,r8a7796-canfd", "renesas,r8a77965-canf=
d", and
> +"renesas,r8a77990-canfd" compatible:
> +In R8A774A1, R8A774C0, R8A7795, R8A7796, R8A77965, and R8A77990 SoCs, ca=
nfd
> +clock is a div6 clock and can be used by both CAN and CAN FD controller =
at the
> +same time. It needs to be scaled to maximum frequency if any of these
> +controllers use it. This is done using the below properties:
>=20
>  - assigned-clocks: phandle of canfd clock.
>  - assigned-clock-rates: maximum frequency of this clock.
> --
> 2.7.4
