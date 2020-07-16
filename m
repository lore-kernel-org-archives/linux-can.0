From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 06/20] arm64: dts: renesas: r8a774e1: Add CMT device nodes
Date: Thu, 16 Jul 2020 17:38:51 +0200
Message-ID: <CAMuHMdX0iXv5=Po1d2LwJFo7ezOnfYi9vjf=wFe9YFY0xyLCWg@mail.gmail.com>
References: <1594811350-14066-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594811350-14066-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-oo1-f68.google.com ([209.85.161.68]:37090 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbgGPPjF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Jul 2020 11:39:05 -0400
In-Reply-To: <1594811350-14066-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Rob Herring <robh+dt@kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>, Niklas <niklas.soderlund@ragnatech.se>, Zhang Rui <rui.zhang@intel.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Magnus Damm <magnus.damm@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@verdurent.com>, Thomas Gleixner <tglx@linutronix.de>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, open

On Wed, Jul 15, 2020 at 1:09 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
>
> This patch adds the CMT[0123] device tree nodes to the
> r8a774e1 SoC specific DT.
>
> Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.9.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
