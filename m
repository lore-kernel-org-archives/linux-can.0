Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793953299;
	b=Baq/eSECgyiEQZshAFwN9fd6ynBtRJ6kbZErO/CiCGo/Zt1noxnbFuoYXIgRo4Bt95H7
	 ic7FcVxdQ5MIOX5zkVmHJV84+md+Ngmtx78H0jDLjcxL1mKlJP+bcBtzary1PkURRdLCu
	 gx0GXcJkCEJu4vKM5pFFgCWBe7DFa6P7cEIsOwuX2HgGmuvLvPPhdgVagjoz2jlK+tlqB
	 D2PlFDbx7JnBbTlGdquiooizV6VPJX5WpdrE6OTXzHK45+0ga2AnXz7wwKCi6dORYPzJk
	 gBxXeymMWuujvBxCdq5DDF8sqWH0L9M4S+0uprhE6NWVIJ3qCpxJpuLyN9RI3b5+Wyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793953299;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=B5U6R28eASu1V9FcblqPPOgTL19VFOQ1nMFsFJSdCXU=;
	b=xSN+rJpaEV/fQy08pgHXVRNOu4a7Rl4bB0B5Z3rXNkJX4nmEQn2Wbb6gJWcOZuRrefJ8
	 1Sfy9J7+X+6nHyw7v2ext5sZDwi+lS7w5slhQez9YoAN/mhMmTwZacNtvKsmqTIJ5DJrE
	 sU6h5OwiSQQEDyT5+u0UiJhOzZ3QMPM/EAmf19+8f86GghdNNXXxdbkCvZF+I1qyhRvs0
	 Fi8m0m8V4DYqwY+rAAiyDN9+d5KgddY2mGCOT7W4NUtos0bfH9iEab72m5/8lfh8UBerN
	 sLQ4iquAEML03ETiULauJZmgvwMbNa66gGBzGb01cDqNOWb5yerPBGhz/gWThk1ahug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E08A606A333
	for <linux-can@vger.kernel.org>; Fri,  6 Nov 2026 08:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E08A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5ead32bc7d8so303039e0c.1
        for <linux-can@vger.kernel.org>; Fri, 06 Nov 2026 00:21:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793953298; x=1794558098;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B5U6R28eASu1V9FcblqPPOgTL19VFOQ1nMFsFJSdCXU=;
        b=tkOBmxB3JxxKNK0JaclY5YBCOI9vJJF8JwY/KXgQTOiWEptTcI89Io/Dv1s7QnyCeN
         0U05BpN0cK4Pswy8KlONb6OcjIe0LCEuu49oYEGDsq6mmQP9hJi1w9yOMTn45hXxqGxa
         IPUKSsB8zg9L4FEVNCNnHH8MlM4K8qJPJn3F4XN7r4U858LXNaikziqbdkqACclFNfyG
         CTY1t95wvVzdNrLqOCm1BVa6j7K4S4ctAN/18f6q2nW7dGk+MzHfZYOI/F6EQfFbqAWt
         05gzceCe6LPTWBCTBLWjzGA41vP2nvaQeDuEGo3CVxYVrw7AFCcZ7ezjKf0+6oaq9e7S
         Wz7Q==
X-Forwarded-Encrypted: i=1; AKwUvBw12+3ZlbwJ1A7xO1vqbunf91lgMuUlHTKQAkhcudJDtAnBPZWKlPwWBX9mWp4CEHqkauAW4d+KT64=@vger.kernel.org
X-Gm-Message-State: APuU4Z88gtOPCwxnhteCh3PE8xHeTbpr11lk43vN65QBoKY0SeMP8rLU
	ItbNe7cf077qX5Lfz/RGRNt/YaRxKmYcjA6xTi2lxlZipnMPxNTOsPuf5Sj2oQ3pbJE=
X-Gm-Gg: AYBFou2O/FwC+dXPvEpeoNs+mGCdlZIvFIe/cKHb7umyG+XFetjYV8rG2skKFnMVeHt
	w/AZuyeRLAQYgQ++KxOQfmcDNaz7Hjm8Me5KITnRLSyDdrObq0sas8GWPm5J3Lrso022tLy3oXu
	/YuSthi0VdzQ+gmBZ4TXgyT6iTYLgHTkPH1S5VKGAw5Q/DArr1ub7tyrjZDcqMcMgwDvsVKpHLt
	bcaTYZrT3CGatgr4krxf+1mycLUxqJwLrFz3E2Ik+vsoGkNMi+L1A2ERdBCKvxnOyOHvlnd+3gm
	XeDjM5khUe0Lu/JtrCWIUJeDbqQWqM72/xUt2rzhuV5nlCwl4e+tkGIivlv5elgL8AYSTkpoBIq
	q9S8KDNic5aA9MBd0m7++mjJetMcMzTnEDd5VuYi+otTC6UY4BciER7EuC4gvs6WhcQiNH3ZQ2R
	YM+hBRNN3UyeXCMj3lQ9u26v3UE1kBsmgKasKnFBz2ja8r6URJqMNftGWtb/VfmPhb/1dvCrI+8
	VdotK4I4tMN27RAqqiH5Y+gbVl3zLawoPilyQL1V0Gr8W1lRlmhrtjFWZDZL4Rd/koiXYvImaOC
	waexRA3KPd4ULJppKBWE8o2ctF5anafaq5EQPFPr5O5IwIACLCAQ9DpFNyvmDOlS1iPRSq11MZH
	pbZOFrT8eXfKEsws=
X-Received: by 2002:a05:6122:e247:b0:5de:ee96:75b with SMTP id 71dfb90a1353d-5ecc43e5cafmr899215e0c.12.1793953298291;
        Fri, 06 Nov 2026 00:21:38 -0800 (PST)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64cb602sm866336e0c.7.2026.11.06.00.21.36
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 00:21:37 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5ead32bc7d8so303012e0c.1
        for <linux-can@vger.kernel.org>; Fri, 06 Nov 2026 00:21:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBw2tEDLXPMP5HhAI2W8EMe7+HWQo8wlcvZzELwbg3J6IeGagm1rjscsCErIfuNAxfJyCHEY69Lsqt0=@vger.kernel.org
X-Received: by 2002:a05:6102:4188:b0:7c1:7ca9:94bf with SMTP id
 ada2fe7eead31-7d2a157ad1bmr1177241137.19.1793953296374; Fri, 06 Nov 2026
 00:21:36 -0800 (PST)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793278754.git.geert+renesas@glider.be> <415c8b26718e2e5d53f74e65daedf9986c76dcfe.1793278754.git.geert+renesas@glider.be>
 <TY3PR01MB113465CCAA88F962CA6BA2E7186762@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113465CCAA88F962CA6BA2E7186762@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 6 Nov 2026 09:21:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXObreJN74sFpqmorWFHQ+uuYQ8E8z53YLy83QWzOhSmA@mail.gmail.com>
X-Gm-Features: AclHuK-V7fgcHmuwvDEyfPRfTLsQvNGxgbL-okuZ_HotpWdWbAS1JxTmpUbfEsQ
Message-ID: <CAMuHMdXObreJN74sFpqmorWFHQ+uuYQ8E8z53YLy83QWzOhSmA@mail.gmail.com>
Subject: Re: [PATCH 3/9] can: rcar_canfd: Make clkp local
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, "biju.das.au" <biju.das.au@gmail.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf Hansson <ulfh@kernel.org>, 
	"magnus.damm" <magnus.damm@gmail.com>, 
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Fri, 6 Nov 2026 at 09:17, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Geert Uytterhoeven <geert+renesas@glider.be>
> > Sent: 29 October 2026 13:11
> > Subject: [PATCH 3/9] can: rcar_canfd: Make clkp local
> >
> > The peripheral clock is only used in rcar_canfd_probe(), so convert clkp to a local variable.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/net/can/rcar/rcar_canfd.c
> > +++ b/drivers/net/can/rcar/rcar_canfd.c
> > @@ -467,7 +467,6 @@ struct rcar_canfd_global {
> >       void __iomem *base;             /* Register base address */
> >       struct rcar_canfd_f_c __iomem *fcbase;
> >       struct platform_device *pdev;   /* Respective platform device */
> > -     struct clk *clkp;               /* Peripheral clock */
>
> Unless I am missing something, I get build error
>
> drivers/net/can/rcar/rcar_canfd.c: In function 'rcar_canfd_probe':
> drivers/net/can/rcar/rcar_canfd.c:2250:55: error: 'struct rcar_canfd_global' has no member named 'clkp'
>  2250 |                         fcan_freq = clk_get_rate(gpriv->clkp);

If your tree has Claudiu's "[PATCH v4 3/7] can: rcar_canfd: Allow the
CAN FD clock to be sourced from fck", you have to update the new user
of gpriv->clkp.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
