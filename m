From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 7/7] can: rcar_canfd: document r8a77995 (R-Car D3)
 compatibility strings
Date: Wed, 22 Nov 2017 14:20:35 +0100
Message-ID: <CAMuHMdWOMaPamsYjNx0nyG+ppEJDE8RY=NKjJDSzZZpPQwdtCg@mail.gmail.com>
References: <1510915289-15059-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1510915289-15059-8-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510915289-15059-8-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-can@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
List-Id: linux-can.vger.kernel.org

Hi Ulrich,

On Fri, Nov 17, 2017 at 11:41 AM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Thanks for your patch!

With the below fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt

> @@ -24,12 +25,12 @@ The name of the child nodes are "channel0" and "channel1" respectively. Each
>  child node supports the "status" property only, which is used to
>  enable/disable the respective channel.
>
> -Required properties for "renesas,r8a7795-canfd" and "renesas,r8a7796-canfd"
> -compatible:
> -In R8A7795 and R8A7796 SoCs, canfd clock is a div6 clock and can be used by both
> -CAN and CAN FD controller at the same time. It needs to be scaled to maximum
> -frequency if any of these controllers use it. This is done using the below
> -properties:
> +Required properties for "renesas,r8a7795-canfd", "renesas,r8a7796-canfd" and
> +"renesas,r8a77995" compatible:

"renesas,r8a77995-canfd"

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
