Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B72D1AAE17
	for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787669127; cv=none; b=I5gdiksy6Uok+tvvvXq4U4UufknEilO/vbv1GJhVuEDOjsQZ1qhaFzDcrUBMnwlfgtyJmwJ9ZlCOAvPyK+0v/9mLnRRTWhsc3DvcgZwsybSIhdjfh6LkfCz2JsAT/B++0LUwGTUPJ3MmmAaRww1wpy5yznrW9ETwtAk61auHtxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787669127; c=relaxed/simple;
	bh=eQ34DPym1g3yHftFYjOe7131ncl6EEw6TRurmNjX1u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U00nj3l0cXsAxo2SNrKtltAwPG3kNa2MikvqyuL+/mFhUgY8sC+SrDdtayJMkHcKF+D4ZW9B74Vk7niyaj383aqQ1OoYTZGV3ds7nzsswjmN5hs0ohAYg0hWGe9BydQSGTvR7bABf5f/OuLR5A5dA9OTQ/AbhIbnXHJsb3y51vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66c71239c48so6671121d50.2
        for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 07:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787669123; x=1788273923;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jyAeQiEiW4UAm/NK4AK+DyXXQ3APXDKQszoA62dY7gk=;
        b=DxTxY1XsKuNwRxnxxMxGfifZVcbLr8bgr12YDUJNvCYydEaGMOatM0QHHo8AjFZrwS
         xa77GVVUIB01QKenri8OJLFALRdbKnyuEb33Z6iqlrBBCI/I7XBflDxbu22ZAMVqljpP
         Z0zneds520v+X1D+C/LI8S15AQCESssTvX55u71yS5TfdUcQci0UvBib2Lg35muTG3YW
         LHN1hSkfTmMkafR4k5Brvpc9AVWW+Yj0+clGBubCxQjPSLP4WY5x/iZqagw5NwgDJKWh
         /Ca/e5p0qv1vwI0UnQ6bvf9eLLieku/3iYcfYcLs7oCgodsKeC9OJK+KHoDol3zdvXHi
         nMlg==
X-Forwarded-Encrypted: i=1; AHgh+RqSeCURQ632F/5Fj8Jos31tYAija7ec94JDxNox7lgXA08GL4tjG6p4w5lCAY9C/Gycikgl2O81nW4=@vger.kernel.org
X-Gm-Message-State: AFuF++kisjqGhEu38H8TZ1E43y6FaoXf3Zk5PU1LKpQrP8WfFiHWjaox
	2RYtHeM5x3iWOt4nMp8+CadYfFLNXlzkVs9HfPgNBebTD4vYYaZY57x+SJnbOPXfVJA=
X-Gm-Gg: AR+sD10HNfsOJq95w4fEhFNGKZkrJRcOahdlZIONTCP7s6RD+Fn9X30qSTUqmpocxpd
	gQgXCFZfy20yoaAcORO7xHrL37bOldDrGrwGEf66CovNR9wGZBg1jRRIdPyBI1VqMH2RB7h2gSZ
	+f6zfoktHdzg0wE8uaksZpyUKdOzqaryjVrhfHT78eUpkrQi0tzX3RyGtwMfCVKU2XKnu35gijb
	DDqYQoKuLKallsyryXlHIsG8HUnE5TbKOGlSlzgLiqAf2yhU/10qKv/O+D2B9QHvXEiVrfyItxo
	nmAUD+4THuhBO/l3sIXDN4jWMWvrEfu2+FE3l3+itobhoSlQmS8VLAQq5/ByF6URnQOMDRoqjex
	TugISu//zE8CI5XDZxlYV8U+qN+Ps+9Pq+3F6/hXbDlI4So3lREKz9322t9da/IGERl4nfUmLB/
	s3/9RrRP02DAq7EOpe2zLoRvGDFGRTgU8nOaVa3uST6cTcuygZ3gTHdHNVlNcCuEpMi44sBc07L
	Q4sS+FysjM/ICyqzG3/PxCbzHnNIBupaq0n
X-Received: by 2002:a05:690e:1756:b0:66b:35d2:b512 with SMTP id 956f58d0204a3-66ce4b54df3mr9584357d50.48.1787669123136;
        Tue, 25 Aug 2026 07:45:23 -0700 (PDT)
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com. [74.125.224.48])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d24722290sm41742d50.10.2026.08.25.07.45.21
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 07:45:21 -0700 (PDT)
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66d1bd30d27so1007551d50.0
        for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 07:45:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpq2G1qyq9WnVstIxMn65F1H6yLvr9M12OQf0ZX3o2aAj2460usbB2vamfBjyIHjzxFLMs4YadVM2s=@vger.kernel.org
X-Received: by 2002:a05:6102:26c5:b0:772:5acc:b848 with SMTP id
 ada2fe7eead31-77a62c46273mr10559459137.6.1787668683910; Tue, 25 Aug 2026
 07:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev> <20260714173315.1981708-6-claudiu.beznea+renesas@tuxon.dev>
In-Reply-To: <20260714173315.1981708-6-claudiu.beznea+renesas@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2026 16:37:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUZUZgtpnEEHEP+nHJHXLQOWJbk3Pf4fzyviMB0q3wuag@mail.gmail.com>
X-Gm-Features: AcwNN1VJh8QhgMVTLLPaW32CuNebN4Cwri3VhB7TN8P_9_MXNNGof6glaJNaOtY
Message-ID: <CAMuHMdUZUZgtpnEEHEP+nHJHXLQOWJbk3Pf4fzyviMB0q3wuag@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] can: rcar_canfd: Do not set registers selecting
 the CAN mode
To: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Cc: mkl@pengutronix.de, mailhol@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	mturquette@baylibre.com, sboyd@kernel.org, bmasney@redhat.com, 
	biju.das.jz@bp.renesas.com, fabrizio.castro.jz@renesas.com, 
	claudiu.beznea@tuxon.dev, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Tue, 14 Jul 2026 at 19:33, Claudiu Beznea
<claudiu.beznea+renesas@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The bits 30 (classical CAN-only mode) and 28 (FD-only enable) of the
> Channel n CAN-FD Configuration Register of the Renesas RZ/G3S SoC are not
> available. The IP supports only CAN-FD mode. RZ/G3S HW manual (revision
> 1.30) specify the bits are read as zero and the write value should always
> be zero.
>
> Add the mode_select_na flag in struct rcar_canfd_hw_info to cover RZ/G3S
> and avoid writing to unavailable bits.
>
> The existing struct rcar_canfd_hw_info instances were updated to address
> the request in the Link discussion.
>
> Commit prepares for the addition of the Renesas RZ/G3S SoC.
>
> Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@wanadoo.fr
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -445,6 +445,7 @@ struct rcar_canfd_hw_info {
>         unsigned shared_can_regs:1;     /* Has shared classical can registers */
>         unsigned external_clk:1;        /* Has external clock */
>         unsigned fcan_pclk:1;           /* Has fcan sourced from pclk. */
> +       unsigned mode_select_na:1;      /* Has no bits for selecting the mode. */

As negative flags are harder to read, perhaps "fixed_canfd"?

>  };
>
>  /* Channel priv data */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
