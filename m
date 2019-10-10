From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH net-next 2/3] dt-bindings: can: rcar_canfd: document
 r8a774b1 support
Date: Thu, 10 Oct 2019 14:46:32 +0200
Message-ID: <CAMuHMdV5XUPSrgoDm62p0f_B1TtvhMyOX3NVho=QVqdesq31jg@mail.gmail.com>
References: <1570711049-5691-1-git-send-email-fabrizio.castro@bp.renesas.com> <1570711049-5691-3-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1570711049-5691-3-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: netdev-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-can@vger.kernel.org, netdev <netdev@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Jacopo Mondi <jacopo+renesas@jmondi.org>
List-Id: linux-can.vger.kernel.org

Hi Fabrizio,

On Thu, Oct 10, 2019 at 2:37 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Document the support for rcar_canfd on R8A774B1 SoC devices.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> @@ -5,6 +5,7 @@ Required properties:
>  - compatible: Must contain one or more of the following:
>    - "renesas,rcar-gen3-canfd" for R-Car Gen3 and RZ/G2 compatible controllers.
>    - "renesas,r8a774a1-canfd" for R8A774A1 (RZ/G2M) compatible controller.
> +  - "renesas,r8a774b1-canfd" for R8A774B1 (RZ/G2N) compatible controller.
>    - "renesas,r8a774c0-canfd" for R8A774C0 (RZ/G2E) compatible controller.
>    - "renesas,r8a7795-canfd" for R8A7795 (R-Car H3) compatible controller.
>    - "renesas,r8a7796-canfd" for R8A7796 (R-Car M3-W) compatible controller.

The above looks good, but I think you forgot to add R8A774B1 to the
paragraph talking about the CAN FD clock below.
With that fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

While at it, the example in the bindings says the CANFD clock should be
configured to 40 MHz, which matches what is used in the various DTS files.
However, the Hardware User's Manual states it should be 80 MHz, except
for R-Car D3.
Is that correct?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
