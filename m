From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH] dt-bindings: can: rcar_can: Add r8a774c0 support
Date: Fri, 1 Mar 2019 11:32:45 +0000
Message-ID: <TYXPR01MB177531C9737F7001F03D7CC7C0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <1544732378-6268-1-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544732378-6268-1-git-send-email-fabrizio.castro@bp.renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Wolfgang Grandegger <wg@grandegger.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-can.vger.kernel.org

Hello Mark,

I am sorry to bother you.
Do you think you can take this patch?

Thanks,
Fab

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 13 December 2018 20:20
> Subject: [PATCH] dt-bindings: can: rcar_can: Add r8a774c0 support
>=20
> Document RZ/G2E (r8a774c0) SoC specific bindings.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/net/can/rcar_can.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Doc=
umentation/devicetree/bindings/net/can/rcar_can.txt
> index 9936b9e..7fcf501 100644
> --- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> @@ -6,6 +6,7 @@ Required properties:
>  	      "renesas,can-r8a7744" if CAN controller is a part of R8A7744 SoC.
>  	      "renesas,can-r8a7745" if CAN controller is a part of R8A7745 SoC.
>  	      "renesas,can-r8a774a1" if CAN controller is a part of R8A774A1 So=
C.
> +	      "renesas,can-r8a774c0" if CAN controller is a part of R8A774C0 So=
C.
>  	      "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC.
>  	      "renesas,can-r8a7779" if CAN controller is a part of R8A7779 SoC.
>  	      "renesas,can-r8a7790" if CAN controller is a part of R8A7790 SoC.
> --
> 2.7.4
