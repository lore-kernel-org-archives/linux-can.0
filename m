From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/3][can-next] can: rcar_can: Fix erroneous registration
Date: Mon, 27 Aug 2018 14:28:46 +0200
Message-ID: <CAMuHMdWrfuLF7h_-yYnCsUBryJUody_WuhqN_2jEQZu-V8khJw@mail.gmail.com>
References: <1535029653-7418-1-git-send-email-fabrizio.castro@bp.renesas.com> <1535029653-7418-2-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1535029653-7418-2-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: netdev-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev <netdev@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Hi Fabrizio,

On Thu, Aug 23, 2018 at 3:08 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Assigning 2 to "renesas,can-clock-select" tricks the driver into
> registering the CAN interface, even though we don't want that.
> This patch fixes this problem and also allows for architectures
> missing some of the clocks (e.g. RZ/G2) to behave as expected.

I think the fix for the second issue is not needed (see my reply to the other
patch).

> Fixes: 862e2b6af9413b43 ("can: rcar_can: support all input clocks")
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
>
> This patch applies on linux-can-next-for-4.19-20180727
>
>  drivers/net/can/rcar/rcar_can.c | 43 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 35 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
> index 11662f4..fbd9284 100644
> --- a/drivers/net/can/rcar/rcar_can.c
> +++ b/drivers/net/can/rcar/rcar_can.c
> @@ -21,9 +21,13 @@
>  #include <linux/clk.h>
>  #include <linux/can/platform/rcar_can.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>
>  #define RCAR_CAN_DRV_NAME      "rcar_can"
>
> +#define RCAR_SUPPORTED_CLOCKS  (BIT(CLKR_CLKP1) | BIT(CLKR_CLKP2) | \
> +                                BIT(CLKR_CLKEXT))
> +
>  /* Mailbox configuration:
>   * mailbox 60 - 63 - Rx FIFO mailboxes
>   * mailbox 56 - 59 - Tx FIFO mailboxes
> @@ -745,10 +749,12 @@ static int rcar_can_probe(struct platform_device *pdev)
>         u32 clock_select = CLKR_CLKP1;
>         int err = -ENODEV;
>         int irq;
> +       uintptr_t allowed_clks = RCAR_SUPPORTED_CLOCKS;
>
>         if (pdev->dev.of_node) {
>                 of_property_read_u32(pdev->dev.of_node,
>                                      "renesas,can-clock-select", &clock_select);


> +               allowed_clks = (uintptr_t)of_device_get_match_data(&pdev->dev);
>         } else {
>                 pdata = dev_get_platdata(&pdev->dev);
>                 if (!pdata) {
> @@ -789,7 +795,7 @@ static int rcar_can_probe(struct platform_device *pdev)
>                 goto fail_clk;
>         }
>
> -       if (clock_select >= ARRAY_SIZE(clock_names)) {
> +       if (!(BIT(clock_select) & allowed_clks)) {

Hence you can just use RCAR_SUPPORTED_CLOCKS directly,
or better, just check clock_names[clock_select] != NULL, ...

>                 err = -EINVAL;
>                 dev_err(&pdev->dev, "invalid CAN clock selected\n");
>                 goto fail_clk;
> @@ -899,13 +905,34 @@ static int __maybe_unused rcar_can_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(rcar_can_pm_ops, rcar_can_suspend, rcar_can_resume);
>
>  static const struct of_device_id rcar_can_of_table[] __maybe_unused = {
> -       { .compatible = "renesas,can-r8a7778" },
> -       { .compatible = "renesas,can-r8a7779" },
> -       { .compatible = "renesas,can-r8a7790" },
> -       { .compatible = "renesas,can-r8a7791" },
> -       { .compatible = "renesas,rcar-gen1-can" },
> -       { .compatible = "renesas,rcar-gen2-can" },
> -       { .compatible = "renesas,rcar-gen3-can" },
> +       {
> +               .compatible = "renesas,can-r8a7778",
> +               .data = (void *)RCAR_SUPPORTED_CLOCKS,
> +       },
> +       {
> +               .compatible = "renesas,can-r8a7779",
> +               .data = (void *)RCAR_SUPPORTED_CLOCKS,
> +       },
> +       {
> +               .compatible = "renesas,can-r8a7790",
> +               .data = (void *)RCAR_SUPPORTED_CLOCKS,
> +       },
> +       {
> +               .compatible = "renesas,can-r8a7791",
> +               .data = (void *)RCAR_SUPPORTED_CLOCKS,
> +       },
> +       {
> +               .compatible = "renesas,rcar-gen1-can",
> +               .data = (void *)RCAR_SUPPORTED_CLOCKS,
> +       },
> +       {
> +               .compatible = "renesas,rcar-gen2-can",
> +               .data = (void *)RCAR_SUPPORTED_CLOCKS,
> +       },
> +       {
> +               .compatible = "renesas,rcar-gen3-can",
> +               .data = (void *)RCAR_SUPPORTED_CLOCKS,
> +       },
>         { }

... and all of the above can dropped.

>  };
>  MODULE_DEVICE_TABLE(of, rcar_can_of_table);

BTW, why does the custom "renesas,can-clock-select" exist?
If guess the standard "assigned-clock-parents" wasn't suitable because there's
no actual defined clock for which you can change the parent?

Why do you need manual selection? Can't the driver just pick the most suitable
available clock, like other drivers (e.g. sh-sci) do?

Gr{oetje,eeting}s,

                        Geert
