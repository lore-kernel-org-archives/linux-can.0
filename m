From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 18/20] dt-bindings: can: rcar_can: Document r8a774e1 support
Date: Thu, 16 Jul 2020 16:34:06 +0200
Message-ID: <CAMuHMdXN17TsuMEKh=a7vQeCXMJiq0EANOQqQo_Ykn_4r5NaZA@mail.gmail.com>
References: <1594811350-14066-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594811350-14066-19-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1594811350-14066-19-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Rob Herring <robh+dt@kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>, Niklas <niklas.soderlund@ragnatech.se>, Zhang Rui <rui.zhang@intel.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Magnus Damm <magnus.damm@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@verdurent.com>, Thomas Gleixner <tglx@linutronix.de>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, open
List-Id: linux-can.vger.kernel.org

Hi Prabhakar,

On Wed, Jul 15, 2020 at 1:11 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document SoC specific bindings for RZ/G2H (R8A774E1) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> @@ -9,6 +9,7 @@ Required properties:
>               "renesas,can-r8a774a1" if CAN controller is a part of R8A774A1 SoC.
>               "renesas,can-r8a774b1" if CAN controller is a part of R8A774B1 SoC.
>               "renesas,can-r8a774c0" if CAN controller is a part of R8A774C0 SoC.
> +             "renesas,can-r8a774e1" if CAN controller is a part of R8A774E1 SoC.
>               "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC.
>               "renesas,can-r8a7779" if CAN controller is a part of R8A7779 SoC.
>               "renesas,can-r8a7790" if CAN controller is a part of R8A7790 SoC.

Please also add R8A774E1 to the list of SoCs that can use CANFD through "clkp2".

With that fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
