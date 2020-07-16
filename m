From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 19/20] dt-bindings: can: rcar_canfd: Document r8a774e1 support
Date: Thu, 16 Jul 2020 16:35:46 +0200
Message-ID: <CAMuHMdXLMwDNp=cAmFbv-+uwKLBL7na5yDdyoePuoGOi8L9yFQ@mail.gmail.com>
References: <1594811350-14066-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594811350-14066-20-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1594811350-14066-20-git-send-email-prabhakar.mahadev-lad.rj-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lad Prabhakar <prabhakar.mahadev-lad.rj-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Jakub Kicinski <kuba-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Niklas <niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Amit Kucheria <amit.kucheria-LY4KaoCqKrnby3iVrkZq2A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>Linux
List-Id: linux-can.vger.kernel.org

Hi Prabhakar,

On Wed, Jul 15, 2020 at 1:11 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org> wrote:
> Document the support for rcar_canfd on R8A774E1 SoC devices.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> @@ -7,6 +7,7 @@ Required properties:
>    - "renesas,r8a774a1-canfd" for R8A774A1 (RZ/G2M) compatible controller.
>    - "renesas,r8a774b1-canfd" for R8A774B1 (RZ/G2N) compatible controller.
>    - "renesas,r8a774c0-canfd" for R8A774C0 (RZ/G2E) compatible controller.
> +  - "renesas,r8a774e1-canfd" for R8A774E1 (RZ/G2H) compatible controller.
>    - "renesas,r8a7795-canfd" for R8A7795 (R-Car H3) compatible controller.
>    - "renesas,r8a7796-canfd" for R8A7796 (R-Car M3-W) compatible controller.
>    - "renesas,r8a77965-canfd" for R8A77965 (R-Car M3-N) compatible controller.

Please also add R8A774E1 to the list of SoCs that can use the CANFD clock.

With that fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
