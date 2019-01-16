From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 08/11] clk: renesas: r8a774c0: Add missing CANFD clock
Date: Wed, 16 Jan 2019 20:05:31 +0100
Message-ID: <CAMuHMdWG6m11eAjvPeFXjsu3jhYnfsxN-EUXw5_SQZ6qMrebYw@mail.gmail.com>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com> <1547663874-29411-9-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1547663874-29411-9-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: netdev-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>, Martin Blumenstingl <martin.>
List-Id: linux-can.vger.kernel.org

Hi Fabrizio,

Thanks for your patch!

On Wed, Jan 16, 2019 at 7:39 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> This patch adds the missing CANFD clock to the r8a774c0 specific
> clock driver.

Are you sure the CANFD clock exists on RZ/G2E?

> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>

> --- a/drivers/clk/renesas/r8a774c0-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a774c0-cpg-mssr.c

> --- a/include/dt-bindings/clock/r8a774c0-cpg-mssr.h
> +++ b/include/dt-bindings/clock/r8a774c0-cpg-mssr.h
> @@ -48,13 +48,14 @@
>  #define R8A774C0_CLK_ZA2               37
>  #define R8A774C0_CLK_ZA8               38
>  #define R8A774C0_CLK_Z2D               39
> -#define R8A774C0_CLK_MSO               40
> -#define R8A774C0_CLK_R                 41
> -#define R8A774C0_CLK_OSC               42
> -#define R8A774C0_CLK_LV0               43
> -#define R8A774C0_CLK_LV1               44
> -#define R8A774C0_CLK_CSI0              45
> -#define R8A774C0_CLK_CP                        46
> -#define R8A774C0_CLK_CPEX              47
> +#define R8A774C0_CLK_CANFD             40
> +#define R8A774C0_CLK_MSO               41
> +#define R8A774C0_CLK_R                 42
> +#define R8A774C0_CLK_OSC               43
> +#define R8A774C0_CLK_LV0               44
> +#define R8A774C0_CLK_LV1               45
> +#define R8A774C0_CLK_CSI0              46
> +#define R8A774C0_CLK_CP                        47
> +#define R8A774C0_CLK_CPEX              48

This file is part of the DT ABI, hence list of definitions is append-only.

Please add R8A774C0_CLK_CANFD at the end, i.e.

    #define R8A774C0_CLK_CANFD              48

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
