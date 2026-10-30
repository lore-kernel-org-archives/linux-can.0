Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355570;
	b=2HMFMlDhJ1raJ1Tom0bePff40vgD8QZ91T5gY+WcxwPMoB/eALVSafE5Tw2nAUXCEMje
	 gPhKjHKp5rXld3hZ68T+WevIXvPIRWHL+mk8uUXW8bpHpEryhgCIUSbHB/Gx81Y+tSpzX
	 mSmpjE6EyH8PoWAgmeqD1jhwME3h0FCajOlaZLZMQtC0PIm2Y6w41qPtB+Vnuyo7IY4Sf
	 7EWkzuO0OwNRPfxAHAgPCv85A5SXUZ8XnQPeJBhwqgkUv0eiuJjwCjQDMMmUYu2GhSFvl
	 pyat4GSOU4pLKzG36UAC8xUoqC0Tq/vjxtjWIxIZ3EXUeYg2PPre3sRk3+zwuse4GVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355570;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=N/lKB/c9Lq//6NoMXUd+nQ4qRj1zdlYJ2/JdgAh063M=;
	b=3aGNIQCEcFw11xiPDrn43OoKfYSzbcZZ4bGk8hlF1ZJoaV6mkYML+qQXsbh5l74yD6zU
	 oP/AR0LKeBZgzdycMASpggwb3G2fuq4/MP+jdpmjCpjMWXoLDo8sFa9c0ks//P+2E8bKW
	 pTZizRwK3CdIbfCAsYTLHj1VCqUviq8ZQxP1xPASTCrk53WdpZvgN8EJWFUtDqx1WQAdl
	 Bi9pq8NJWV5r23xkdZ92YJ4FS3VjhYfkiadO//aPBwBEs8O7ddh//BVQyyp7EV5OMv3eg
	 aTOX87iGq4NSNtZVvnePYi0NkSVNMwduA5PyytWcoNomfPZEMktRZtn9wKbGk4eImVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3980606A31D
	for <linux-can@vger.kernel.org>; Fri, 30 Oct 2026 10:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3980606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-98c7798ce74so130077241.1
        for <linux-can@vger.kernel.org>; Fri, 30 Oct 2026 03:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793355569; x=1793960369;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N/lKB/c9Lq//6NoMXUd+nQ4qRj1zdlYJ2/JdgAh063M=;
        b=MM/48QmEDlmMAwQesXDxmq0PgPV5v+Y9BmczZod7hY9KNHdMVMuvv28cnY5Zn9g4so
         fyXxyqyuOEP5JDSZWqtHMHEWuyhOALvas8zzh+HD7KFCU4XX/m86JwTDpJzTo7sFrMDx
         Z/cMyzH47R/QhLi6isP0XbaIDmX2XJ94W84VaB/zQ9wiOJbzmfa+219SSYtia5ZxIinF
         8lXFoUsfLy6duvaMeVjfNoS4bnBypxt5dHqPW6zpMNfF42LpmPfJ9wFyyJGeEQrTdXKQ
         cDv7TIB51dpDM76Tc1ixqoBSbgPjAO/yHnKw2b8f6jCySZy4gtq6AvydJIHvDbL5YU/0
         6Otg==
X-Forwarded-Encrypted: i=1; AKwUvBwIf5b0/9FAWBGiwCc0gSBF/IllFXBIKi61rWj30v30zM/b9PZNryHSyYB1FUSBbwsxWa78YfJCsrI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdxNPUGBAat6ivuOsePH/q/+T5jCFYbzAWyrNsYx011+DljrMs
	ryuIgACkPB2bljTWfgGFPwv2IRuBa4BwASgdww4Sf7RBaJtmzdAIget+88HDdLQu
X-Gm-Gg: AYBFou3VC9nN8RUWimHUEwWGaUMFSeWmYL5sGP/cRaxaRk0z/BVlMdyqsJiQaJNmEua
	O35T3TIiJSmIXbgblmuRYge2fZn96f9Xqp+Cd3sAJCL7Coz/2gnavUOc5FnEJ5jg08rCtGR1JNy
	W1NeXOuyF5+jaDmw6VeVFuaBA17JzjnxWxJ40zYa8gz/ErdcXhCvB/VFi4xONZ7WaQb6PR164Q/
	pKE6ui/4H5zJ/GVpU7sKyPEjUs/ufCUWUSKhTQrnw8V5diLYDN2CmqaUf9ygi/aQ+d0lRpgRaV1
	OO7AzuaebjHAvKmo2Uq3HgcXjgMHMHHnGDNP1gTwe/p6jCMXRsC++3ANpm5Al0XxyLy+QjoG//i
	y7XqhpQoQ5fTy0LIJ9jCKi4+fG3W/yaZSbJ3iMGAxUSEuSosk1a+Dv3akA+iFR6lk6TbWfeM0YP
	Ns6C9zeIN4UpEveMvyBSmV1UjOHiz0XJScGGoHurvkfKEe5ABog5q/6El/5RVTGA+ZKQdcF8slM
	e0jbSXfKaPV4vLsniPcq8xUf7UjC7FRCm/PCibc+1DS0c9/l7ORR/CwVqWRvhgZQc6h67g3smXM
	f7nTO5Uq2VzWwO5R2UeYiQzWYmdkftDHiHVCO8Nv5ADABdhSzYvlp8P5xAF6f0RBopQ=
X-Received: by 2002:a05:6102:4194:b0:7c0:1d48:b2a2 with SMTP id ada2fe7eead31-7d07278d8eamr674736137.31.1793355568930;
        Fri, 30 Oct 2026 03:19:28 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d07768d366sm1635759137.10.2026.10.30.03.19.27
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 03:19:27 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7c03744ef27so137584137.1
        for <linux-can@vger.kernel.org>; Fri, 30 Oct 2026 03:19:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzuUirJsskmbMBkD+4bEbq6sPLTQkr6aFgQ1nOAOQZh+JoI1iAQ7qAPwSq88cWxD6FCfXzb56r52Vg=@vger.kernel.org
X-Received: by 2002:a05:6102:9d4:b0:7ce:5952:125d with SMTP id
 ada2fe7eead31-7d0728d38cemr726412137.36.1793355567237; Fri, 30 Oct 2026
 03:19:27 -0700 (PDT)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793278754.git.geert+renesas@glider.be> <2f986484ade3f3ab7785a088b476b4bc6f53c157.1793278754.git.geert+renesas@glider.be>
In-Reply-To: <2f986484ade3f3ab7785a088b476b4bc6f53c157.1793278754.git.geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Oct 2026 11:19:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVDs38CWQv+-1d6iMa5Et-w53iVbjSTyQS5uVcvq+E8Ag@mail.gmail.com>
X-Gm-Features: AclHuK8TLIiJXfBZEbZO-sDHcOFpgPhdmma0xCzHFZfNFDpVgGdGYD9NeIfWwIY
Message-ID: <CAMuHMdVDs38CWQv+-1d6iMa5Et-w53iVbjSTyQS5uVcvq+E8Ag@mail.gmail.com>
Subject: Re: [PATCH 4/9] can: rcar_canfd: Add support for R-Car Gen5
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Biju Das <biju.das.au@gmail.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Ulf Hansson <ulfh@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Oct 2026 at 14:11, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The CAN-FD block on R-Car Gen5 is similar to the variant on R-Car Gen4,
> but uses split global and per-channel interrupts, like on RZ/G2L.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -636,6 +636,23 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
>         .external_clk = 1,
>  };
>
> +static const struct rcar_canfd_hw_info rcar_gen5_hw_info = {
> +       .nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
> +       .data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
> +       .tdc_const = &rcar_canfd_gen4_tdc_const,
> +       .regs = &rcar_gen4_regs,
> +       .sh = &rcar_gen4_shift_data,
> +       .rnc_field_width = 16,
> +       .max_aflpn = 127,
> +       .max_cftml = 31,
> +       .max_channels = 8,
> +       .postdiv = 2,

R-Car X5H does not have the /2 postdivider, so this should be one.
Else the bitrate is twice as fast as intended when the external can_clk
is not available.

> +       .multi_channel_irqs = 1,
> +       .ch_interface_mode = 1,
> +       .shared_can_regs = 1,
> +       .external_clk = 1,
> +};
> +
>  static const struct rcar_canfd_hw_info rzg2l_hw_info = {
>         .nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
>         .data_bittiming = &rcar_canfd_gen3_data_bittiming_const,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
