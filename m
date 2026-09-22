Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FF451588A
	for <linux-can@vger.kernel.org>; Tue, 22 Sep 2026 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090064; cv=none; b=bCVQwuAGzS7boeBqatIwpoQddncptUQSMvbXvPP863wdj6fW1GhVJ8AUiv79XGkM7HUGFO/wr9ilJQursYkIFbIrdLr5pQDB8DRL6qi+/o6+UwWVaFlh51RQbrbxzXwgnPBPoq16GlHSPfI+uIQoxOP06zTEzonG7IzlEqI3El8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090064; c=relaxed/simple;
	bh=mKPAm9lSrRcV08N0bMDOn/x6I0AzKpQyWCO4ViNMFDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSdWlo+0x0Ms30VIIQQUbcCLUgA/TL52WHHdExisBF18zvvtFfTUP0FD4BA1q9j7HPXTKeRBAPxaQFZsgIiOb1jIPuHhO3qIwMTREUwhrj86sb7qiDafcLNTz23ucI+2leG2UhgGIJCyhHMpYYQAcI4w3KdNBARbxWV5emXWHfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c72bfe7so1230746241.0
        for <linux-can@vger.kernel.org>; Tue, 22 Sep 2026 08:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790090062; x=1790694862;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xGvRLKavNp07IDObK0x4MyNXPYCHC6J8E0NCLAikfuA=;
        b=ELA3AIkiQRdqSQWOupSY2sWQJubf/6XE11znf2YKrkii13I46J14+iFyUsZnzYqz/+
         gt0FbtPtt4LAdyoo7YVaf/FBVcMqt5QrvydPCuaShE+eLzd4Es0Ts+FM9T3HVnTMgR+1
         JyuYrMN0SRQy0iW4aEL6Yzs1dPBMld3wKBMqaN7U+gCzKUJLT468bPvF78jxlS9uc7wf
         zGM2OPUeq3fjDua1lJkjY/6VeGoilCSsg91fPghhHCZ0PNOTKqjYYoQAyOLipTMpPhvm
         44KN+0Nb3M6MFl8BJ+t2L3/0c7vw3DlNozEUxablk2pLuSYiOGo2z/ZssWYrJ0Yr5YTK
         YTTw==
X-Forwarded-Encrypted: i=1; AKwUvBwadGv8nR6WHIplrI0nYyaVOAv9EJCs/Lv6cxqf4qTLABEV2qZ7Lv53A+7rPBG2FUtJ3VmQKTDQfms=@vger.kernel.org
X-Gm-Message-State: AFuF++mSibPyYIvgqx1ygcSDqjK7plhAC9DlKducmddPD3GLQ3yhmV7E
	nGoOyHuZlXn6wc7umOrGPi5Pz6vI1MY1TjkQ22YuCmIFBlkw87ISaB4uYgvEHnqP
X-Gm-Gg: AYBFou1CdwALMFnrGdIVJp48rHHZGDNskPuFPugVcEW2x13h4eUmbiI+zbvJp/gAzy0
	nQiXfcS9oXL6zQrGCJEVV7zi8nk5eTM2YzgmvvateLNOLIQ3aBze0XWO1u9mH2TyOqAa/hH/34s
	gcbjtdAc9EIwH415Vd0/KxKW4uuWBI+JFXrriDO/pAL23ZNkCRpiGbDtuRFouSq8DNucH1whveN
	H+X7AQGVsi8Of7+/0yK0GPCSYKdl74SJhSGWzdFUurUU/oLwm4w7AIn3mBw9MVtdhEt3GcinLtd
	HV8lsXuNy1C4O/ag1yPc69k6FiXWpnZaJgqzLvFPrrXEp/o4qM+E/lokYlOzJ6tnxsNj877ypaO
	G9ghQo1999/d4xLr0VcDqDqUvAdxEEjqEHNI0nyxi8MiWtm14ideSkLXVVpGr39LxcxShIZAegq
	fMYmSDCD5ciPaS9Va1SPOWThFPKnuAigw8cQhKoaodp3H9/T5ekjNnQ03NIHrgvSDyndjkovK3x
	xRChC3uG9jkhhtf03EFshlHkec++2cmpdLG
X-Received: by 2002:a05:6122:8d4:b0:5c9:ef0d:9fa7 with SMTP id 71dfb90a1353d-5c9ef0db434mr1058564e0c.15.1790090061705;
        Tue, 22 Sep 2026 08:14:21 -0700 (PDT)
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com. [74.125.227.12])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9851691693asm47555241.2.2026.09.22.08.14.18
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 08:14:19 -0700 (PDT)
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e512ee5so1583080e0c.2
        for <linux-can@vger.kernel.org>; Tue, 22 Sep 2026 08:14:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzEdw2VeX91C+vGN25Sqt0XpT9MBrWk6qE423cU6fuWgKHsXWy6o6EolaUUGlzE1vYiFxz/6eooQmQ=@vger.kernel.org
X-Received: by 2002:a05:6122:6b0d:b0:5c9:c60a:e9b7 with SMTP id
 71dfb90a1353d-5c9c60af4fbmr7493050e0c.23.1790090058750; Tue, 22 Sep 2026
 08:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921131951.187981-1-biju.das.jz@bp.renesas.com> <20260921131951.187981-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260921131951.187981-3-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Sep 2026 17:14:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUx5-P97CFEH3Dif1g4K=NPfkDkE=3vrzjZB-TsyxqO8Q@mail.gmail.com>
X-Gm-Features: AclHuK-rCbm16AlWI6NRQzJvntZXC9gv_oZQlkAlsfHFavMScH5L1qYsY-ROQQE
Message-ID: <CAMuHMdUx5-P97CFEH3Dif1g4K=NPfkDkE=3vrzjZB-TsyxqO8Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Mon, 21 Sept 2026 at 15:20, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Document the RZ/G3L (R9A08G046) SoC support, which reuses the
> RZ/G3S (R9A08G045) CANFD bindings as a fallback compatible.
>
> RZ/G3L has 11 interrupts and 3 CANFD channels compared to 8 interrupts
> and 2 CANFD channels on RZ/G3S.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> +++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
> @@ -47,6 +47,10 @@ properties:
>                - renesas,r9a07g054-canfd    # RZ/V2L
>            - const: renesas,rzg2l-canfd     # RZ/G2L family
>
> +      - items:
> +          - const: renesas,r9a08g046-canfd  # RZ/G3L
> +          - const: renesas,r9a08g045-canfd

I am not sure it is a good idea to use RZ/G3S as a fallback

RZ/G3S:
  - Selects receive message according to 128 receive rules,
  - Sets the number of receive rules (0 to 128) for each channel.
RZ/G3L;
  - Selects receive message according to 384 receive rules,
  - Sets the number of receive rules (0 to 256) for each channel.
These differences are not explained just by the different number
of channels.  However, it's not clear to me what is the real impact.

> @@ -270,6 +283,11 @@ allOf:
>                - renesas,r9a09g077-canfd
>                - renesas,rcar-gen3-canfd
>                - renesas,rzg2l-canfd
> +      not:

Can you really stick a "not" here? Yes, apparently you can.
Still, I find this hard to read.

> +        properties:
> +          compatible:
> +            contains:
> +              const: renesas,r9a08g046-canfd
>      then:
>        patternProperties:
>          "^channel[2-7]$": false
> @@ -292,6 +310,46 @@ allOf:
>        patternProperties:
>          "^channel[6-7]$": false
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a08g045-canfd
> +      not:

Likewise.
This one can easily be restructured like

    if: ... renesas,r9a08g046-canfd
        ...
    else: if: ... renesas,r9a08g046-canfd
        ...

to improve readability.

> +        properties:
> +          compatible:
> +            contains:
> +              const: renesas,r9a08g046-canfd
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 8
> +          maxItems: 8
> +
> +        interrupt-names:
> +          minItems: 8
> +          maxItems: 8
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a08g046-canfd
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 11
> +          maxItems: 11
> +
> +        interrupt-names:
> +          minItems: 11
> +          maxItems: 11
> +
> +      required:
> +        - channel2
> +      patternProperties:
> +        "^channel[3-7]$": false
> +
>    - if:
>        properties:
>          compatible:

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
