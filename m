Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D2476CCE
	for <linux-can@vger.kernel.org>; Thu, 24 Sep 2026 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255363; cv=none; b=OhZvdAPF7KfkNxTJusbnjUvBNHCNf3/rnR3MuheqpF1qprM/ujGpobnFA9ZPFktm4PgXY10dS4X/kzfG6cGp4xutpFvGMBUO5CDlG1wA1vOCpsynPKAakfeD1htwSIKmREBt3eLPvLJDtz77GMeUlUANvcFYJbgNU1QFzDbK4xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255363; c=relaxed/simple;
	bh=Rw7n8PAoUz541AnGpQ4DaMj5urjCrlERBFASJKmrTpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K72pUI+q758QRyJJsCRjWZVPLBVlxDwvp1UGddVyjvYP7hObbxf5svPhAl+E/zcDWdZUOp0qzD2xQruzQWs+Gk9jvVaPLx6GABfoKgUsY9jh9RqazlUtlNC0hpmJCkQ1ADHHeVV3SwDsBcKH05MD2L9xNhnerCrIiSCO1NIg7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e5292faso902062e0c.1
        for <linux-can@vger.kernel.org>; Thu, 24 Sep 2026 06:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790255358; x=1790860158;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iG1Qpl4QN7ROIqBz9RYanLV8CcyoC4MV5Wut2AruDjg=;
        b=NatBfLkJ8WgyUG+QvQ+DVS2d4T6leqz9lgYHc9HrNxmf2zy8mAw/fvv0B34Z2KIttv
         tQLhZvsh7FGV5WgE0rqbOi+vG/coy3hYDSDMzbZ+kam+vMOoSgqgmKsuDDGEd4KDO6vm
         btFsuZGb49zsi5Q6/BBKQ6J/wxtx1aRer+V5vxTKPKVB72Lf4iAgEBycLpqiSKbOjzgu
         CQkoZiQflOkJLC0I+u7T4+lPHeZAExfz9kq4SOq0BC6pglnKouDtaSPzOhcdwdCfCHA6
         m0lnGgA1vDdSBBvprFq4yRnXx7k9LPfwlqSieRJyF6Wkpg27ovAeQy/tdamaMU4InKZE
         ijWA==
X-Forwarded-Encrypted: i=1; AKwUvBx4Lc2zanbU99xDWroRLA8IFZzT1Uwk3fXGfVbNYbLP0Q3qRsN2zY3MGuXKBCtB1pkb/wA6MlaAtIA=@vger.kernel.org
X-Gm-Message-State: AFuF++lQ38SUdowBzEYSPOWN7jqRA8X5dOUP5Zs9nuFhJJiroR5Zcr9b
	TIFnWH4RsRxseRIlDeZ92ierQ901bQgDjx5hujQusAsKBVL6WDphE3A5jvt2AaQv
X-Gm-Gg: AYBFou0VBGrlPVpzGoI7VHCLbHni6lR2OGk3ZE5RAkzUJazq6+tn+Q801wZcX6ktjrY
	cDGG6vwXJOlXzTv7mfxnYD/oku//sUZJ1xYWJsDE0XTxs9dJ0o67nUjY/8Y6EXzTZvDj8JIdZMb
	A4Nvmd+Fk5fOvOvhQfymut4dH26tVAs/GI0xE6KBbIMcUmR9rj5aoL8JZCGZSZi+f3kbCy067+c
	+NhDUwcrTAR6Numv/8h3a31jZOO6P7QtMmvlBOXGP03ekuIAK0uJvonyYQJIN6s/3JM2fkL/mII
	E0Lr9ieASdWfxtNeO6s7b4y9fS7ma3On6jY7qpHCSdwHQpaRY6ikRM5fizr6a40RBeEmYnvCXOq
	IpuRgn3jdeSxkKrDvLrErG1pke3HbeMm8cOPtOhrioe9rk6HBvuZ6sNzwDoB1+fZ5nCvol22Bde
	cXvSChGVW54lIjJe5Ct8ngSEN1JLGgQqVDbVMnNDd79QpiPsrIyrfaC2L4i4lNyg1J05Dmc8/df
	kyVqP6/EuvPyx2hC1YFJfwtFHXYvUbUEuIR
X-Received: by 2002:a05:6122:1349:b0:5c9:a60b:e5d9 with SMTP id 71dfb90a1353d-5cb0bc61aeamr1448161e0c.19.1790255358466;
        Thu, 24 Sep 2026 06:09:18 -0700 (PDT)
Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com. [74.125.227.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ca4604daf9sm4602903e0c.17.2026.09.24.06.09.18
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 06:09:18 -0700 (PDT)
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c67e5292faso902051e0c.1
        for <linux-can@vger.kernel.org>; Thu, 24 Sep 2026 06:09:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxCKzUGEu9z5T2VcQWuHIZ8hjF5h75P0tC1H7kF9aPBKfhcQ00Lr+DyqzIWJasK0vnYLXRmLLD3dwA=@vger.kernel.org
X-Received: by 2002:a05:6102:291e:b0:7af:51a:de01 with SMTP id
 ada2fe7eead31-7af1d4bd641mr1095503137.19.1790255357883; Thu, 24 Sep 2026
 06:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924052741.130658-1-biju.das.jz@bp.renesas.com> <20260924052741.130658-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260924052741.130658-3-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 24 Sep 2026 15:09:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUd7=y6H+GP_7eOHSc0Ye0ZB6CgKUvmFrWMsVAK2SW6RQ@mail.gmail.com>
X-Gm-Features: AclHuK9dW-prLzuGnv2Aohs4SaGLbmejrymX0wYt9Hgm6hDrfeTdOyUn1vibBgc
Message-ID: <CAMuHMdUd7=y6H+GP_7eOHSc0Ye0ZB6CgKUvmFrWMsVAK2SW6RQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] can: rcar_canfd: Derive max_channels from the
 device tree
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Tu Nguyen <tu.nguyen.xg@renesas.com>, linux-can@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Thu, 24 Sept 2026 at 07:28, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> The maximum number of channels is currently hardcoded per SoC in
> struct rcar_canfd_hw_info. Since the DT describes the channels as
> child nodes of the controller, the count can be obtained at probe time
> with of_get_child_count() instead.
>
> Drop max_channels from struct rcar_canfd_hw_info and store the value
> in struct rcar_canfd_global, so it no longer needs to be maintained
> for each SoC variant. Update all for_each_set_bit() users over
> channels_mask to use gpriv->max_channels.
>
> No functional change.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -2145,14 +2139,16 @@ static int rcar_canfd_probe(struct platform_device *pdev)
>         bool fdmode = true;                     /* CAN FD only mode - default */
>         char name[9] = "channelX";
>         u32 ch, fcan_freq;
> +       u8 max_channels;
>         int i;
>
>         info = of_device_get_match_data(dev);
> +       max_channels = of_get_child_count(dev->of_node);

This value really needs to be checked against or capped at
RCANFD_NUM_CHANNELS, to avoid overrunning the fixed-size
rcar_canfd_global.ch[] and transceivers[] arrays.

>
>         if (of_property_read_bool(dev->of_node, "renesas,no-can-fd"))
>                 fdmode = false;                 /* Classical CAN only mode */
>
> -       for (i = 0; i < info->max_channels; ++i) {
> +       for (i = 0; i < max_channels; ++i) {
>                 name[7] = '0' + i;
>                 of_child = of_get_available_child_by_name(dev->of_node, name);
>                 if (of_child) {

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
