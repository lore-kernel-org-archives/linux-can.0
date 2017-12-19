From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: RE: [PATCH 1/8] dt-bindings: can: rcar_can: document r8a774[35] can
 support
Date: Tue, 19 Dec 2017 10:17:53 +0000
Message-ID: <TY1PR06MB08953B33F245840430CD3DABC00F0@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1510067449-17017-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1510067449-17017-2-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:65319 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1759552AbdLSKR7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Dec 2017 05:17:59 -0500
In-Reply-To: <1510067449-17017-2-git-send-email-fabrizio.castro@bp.renesas.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Wolfgang Grandegger <wg@grandegger.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

Hello Marc,

does this patch look ok to you?

Thanks,
Fab

> Subject: [PATCH 1/8] dt-bindings: can: rcar_can: document r8a774[35] can =
support
>
> Document "renesas,can-r8a7743" and "renesas,can-r8a7745" compatible
> strings. Since the fallback compatible string ("renesas,rcar-gen2-can")
> activates the right code in the driver, no driver change is needed.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/net/can/rcar_can.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Doc=
umentation/devicetree/bindings/net/can/rcar_can.txt
> index 06bb7cc..94a7f33 100644
> --- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> @@ -2,7 +2,9 @@ Renesas R-Car CAN controller Device Tree Bindings
>  -------------------------------------------------
>
>  Required properties:
> -- compatible: "renesas,can-r8a7778" if CAN controller is a part of R8A77=
78 SoC.
> +- compatible: "renesas,can-r8a7743" if CAN controller is a part of R8A77=
43 SoC.
> +      "renesas,can-r8a7745" if CAN controller is a part of R8A7745 SoC.
> +      "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC.
>        "renesas,can-r8a7779" if CAN controller is a part of R8A7779 SoC.
>        "renesas,can-r8a7790" if CAN controller is a part of R8A7790 SoC.
>        "renesas,can-r8a7791" if CAN controller is a part of R8A7791 SoC.
> @@ -12,7 +14,8 @@ Required properties:
>        "renesas,can-r8a7795" if CAN controller is a part of R8A7795 SoC.
>        "renesas,can-r8a7796" if CAN controller is a part of R8A7796 SoC.
>        "renesas,rcar-gen1-can" for a generic R-Car Gen1 compatible device=
.
> -      "renesas,rcar-gen2-can" for a generic R-Car Gen2 compatible device=
.
> +      "renesas,rcar-gen2-can" for a generic R-Car Gen2 or RZ/G1
> +      compatible device.
>        "renesas,rcar-gen3-can" for a generic R-Car Gen3 compatible device=
.
>        When compatible with the generic version, nodes must list the
>        SoC-specific version corresponding to the platform first
> --
> 2.7.4



[https://www2.renesas.eu/media/email/unicef_2017.jpg]

This Christmas, instead of sending out cards, Renesas Electronics Europe ha=
ve decided to support Unicef with a donation. For further details click her=
e<https://www.unicef.org/> to find out about the valuable work they do, hel=
ping children all over the world.
We would like to take this opportunity to wish you a Merry Christmas and a =
prosperous New Year.



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
