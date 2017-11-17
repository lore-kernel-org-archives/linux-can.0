From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/7] pinctrl: sh-pfc: r8a77995: Add CAN support
Date: Fri, 17 Nov 2017 14:30:32 +0100
Message-ID: <CAMuHMdUJ1P3wmjXrSAAF6AC1Ft_qQK8DB6w6XTbg1zkKC5DTpg@mail.gmail.com>
References: <1510915289-15059-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1510915289-15059-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42275 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbdKQNad (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Nov 2017 08:30:33 -0500
In-Reply-To: <1510915289-15059-2-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-can@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

On Fri, Nov 17, 2017 at 11:41 AM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> This patch adds CAN[0-1] pinmux support to the r8a77995 SoC.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in sh-pfc-for-v4.16.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
