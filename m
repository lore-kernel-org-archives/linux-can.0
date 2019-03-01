From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH 11/11] dt-bindings: can: rcar_canfd: document r8a774c0
 support
Date: Fri, 1 Mar 2019 11:56:32 +0000
Message-ID: <TYXPR01MB1775D48B2053F31EC501C154C0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-12-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1547663874-29411-12-git-send-email-fabrizio.castro@bp.renesas.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, =?iso-8859-2?Q?Andreas_F=E4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, =?iso-8859-2?Q?Michal_Vok=E1=E8?= <michal.vokac@ysoft.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ben Whitten <ben.whitten@gmail.com>, Chris Paterson <Chris.Paterson2@renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.ke>
List-Id: linux-can.vger.kernel.org

Hello Marc,

I am sorry to bother you.
Do you think you can take this patch?

Thanks,
Fab

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 16 January 2019 18:38
> Subject: [PATCH 11/11] dt-bindings: can: rcar_canfd: document r8a774c0 su=
pport
>=20
> Document the support for rcar_canfd on R8A774C0 SoC devices.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
> This patch depends on:
> https://patchwork.kernel.org/patch/10687999/
> https://patchwork.kernel.org/patch/10688001/
>=20
>  Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 16 +++++++++-=
------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> index 41049fe..32f051f 100644
> --- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> @@ -3,7 +3,8 @@ Renesas R-Car CAN FD controller Device Tree Bindings
>=20
>  Required properties:
>  - compatible: Must contain one or more of the following:
> -  - "renesas,rcar-gen3-canfd" for R-Car Gen3 compatible controller.
> +  - "renesas,rcar-gen3-canfd" for R-Car Gen3 and RZ/G2 compatible contro=
llers.
> +  - "renesas,r8a774c0-canfd" for R8A774C0 (RZ/G2E) compatible controller=
.
>    - "renesas,r8a7795-canfd" for R8A7795 (R-Car H3) compatible controller=
.
>    - "renesas,r8a7796-canfd" for R8A7796 (R-Car M3-W) compatible controll=
er.
>    - "renesas,r8a77965-canfd" for R8A77965 (R-Car M3-N) compatible contro=
ller.
> @@ -28,12 +29,13 @@ The name of the child nodes are "channel0" and "chann=
el1" respectively. Each
>  child node supports the "status" property only, which is used to
>  enable/disable the respective channel.
>=20
> -Required properties for "renesas,r8a7795-canfd", "renesas,r8a7796-canfd"=
,
> -"renesas,r8a77965-canfd" and "renesas,r8a77990-canfd" compatible:
> -In R8A7795, R8A7796, R8A77965 and R8A77990 SoCs, canfd clock is a div6 c=
lock
> -and can be used by both CAN and CAN FD controller at the same time. It n=
eeds
> -to be scaled to maximum frequency if any of these controllers use it. Th=
is is
> -done using the below properties:
> +Required properties for "renesas,r8a774c0-canfd", "renesas,r8a7795-canfd=
",
> +"renesas,r8a7796-canfd", "renesas,r8a77965-canfd", and "renesas,r8a77990=
-canfd"
> +compatible:
> +In R8A774C0, R8A7795, R8A7796, R8A77965, and R8A77990 SoCs, canfd clock =
is a
> +div6 clock and can be used by both CAN and CAN FD controller at the same=
 time.
> +It needs to be scaled to maximum frequency if any of these controllers u=
se it.
> +This is done using the below properties:
>=20
>  - assigned-clocks: phandle of canfd clock.
>  - assigned-clock-rates: maximum frequency of this clock.
> --
> 2.7.4
