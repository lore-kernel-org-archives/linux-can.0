From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 03/11] arm64: dts: renesas: Add Si-Linux CAT874 board support
Date: Thu, 17 Jan 2019 12:04:51 +0100
Message-ID: <CAMuHMdWhcH2=FS62jawZrMeSc_qKBS_SpDTMoVvhP2o736wtgg@mail.gmail.com>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com> <1547663874-29411-4-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1547663874-29411-4-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: netdev-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Biju Das <biju.das@bp.renesas.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysof>
List-Id: linux-can.vger.kernel.org

On Wed, Jan 16, 2019 at 7:38 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> From: Biju Das <biju.das@bp.renesas.com>
>
> Basic support for the Si-Linux board based on RZ/G2E:
>   - Memory,
>   - Main crystal,
>   - Serial console
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>

Pending acceptance of the DT bindings
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts

> +       chosen {
> +               bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";

FWIW, the root and ip parameters won't do anything, until you add network
support.

> +               stdout-path = "serial0:115200n8";
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
