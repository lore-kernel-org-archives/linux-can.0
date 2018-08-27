From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/3][can-next] can: rcar_can: Add RZ/G2 support
Date: Mon, 27 Aug 2018 14:30:14 +0200
Message-ID: <CAMuHMdWEPwG6=MEtYKREfqyow=bz__p+Qj28kXufbXc37u8p9A@mail.gmail.com>
References: <1535029653-7418-1-git-send-email-fabrizio.castro@bp.renesas.com> <1535029653-7418-3-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1535029653-7418-3-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: netdev-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev <netdev@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Hi Fabrizio,

(Usually the DT patch goes before the driver patch)

On Thu, Aug 23, 2018 at 3:08 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> RZ/G2 devices don't have clkp2, therefore this commit adds a
> generic compatible string for them to allow for proper checking
> during probe.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Chris Paterson <Chris.Paterson2@renesas.com>

Thanks for your patch!

> --- a/drivers/net/can/rcar/rcar_can.c
> +++ b/drivers/net/can/rcar/rcar_can.c
> @@ -27,6 +27,7 @@
>
>  #define RCAR_SUPPORTED_CLOCKS  (BIT(CLKR_CLKP1) | BIT(CLKR_CLKP2) | \
>                                  BIT(CLKR_CLKEXT))
> +#define RZG2_SUPPORTED_CLOCKS  (BIT(CLKR_CLKP1) | BIT(CLKR_CLKEXT))
>
>  /* Mailbox configuration:
>   * mailbox 60 - 63 - Rx FIFO mailboxes
> @@ -933,6 +934,10 @@ static const struct of_device_id rcar_can_of_table[] __maybe_unused = {
>                 .compatible = "renesas,rcar-gen3-can",
>                 .data = (void *)RCAR_SUPPORTED_CLOCKS,
>         },
> +       {
> +               .compatible = "renesas,rzg-gen2-can",
> +               .data = (void *)RZG2_SUPPORTED_CLOCKS,
> +       },
>         { }

I think this patch is not needed, cfr. my reply to the
first^H^H^H^H^Hthird patch
in your series.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
