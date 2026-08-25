Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A402E485CDE
	for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787670530; cv=none; b=NJC7WkxRl84L7JwiKK16OeYw1tkcyeMuH27tj3shvOwyMZ8kLCSENOdmJ42O5IWjcq/L2X6jeFLrLiGwnxa/+pQVEGcWZZE006lSnM1owQyuJPBtLtPgl3ivL9ydv9+i76ETQtUC+ve7bD/vlZ4EVHS6PaQ1UTcSrOMKHQGwk6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787670530; c=relaxed/simple;
	bh=Loh7CxMJyj/c0rgZ7iXlS8miTtj/q5VnJdY302NtqGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGk1MFSTC7ZBZrafjFU8jSLfLhiwFuHrdIxe9QeKYLDchqKP+lU4hkE58VnlHKUOdaeOKHH4cDQh3BEz7589ulp8a9NG/4ix4F5aFWUtCv4OcG5IIXKD3hP+9Oul4FKLresIh4y2nYvAxJNs9sKyg6flQDUxkLSUNg6BP4YyURg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c250a2bc3b3so4904266b.2
        for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 08:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787670526; x=1788275326;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8UDG6348hQ5hCNqa39+P1Xgwy7V8Kyi97ymwy69cGkw=;
        b=jykmwAFpdyewQcu0jmbj80H7gTp+hXouNbsGxTt76NL6M68RJ1Oh0cyjmkyXq7wxvL
         s5PkLmXc8M8sAdiH1hovxQh/EJBPtCdkwALzdYMyh2sDS6ZEc+TVy80w2YAk0Gv8Wm6k
         PyWD462m/18ogKhH7BzSV9XbWvsAWJrwFUmTKPsqcJbXwP6/Azvnr+lplRUZjHi28fhI
         HV3X+xG/ZREN8lOnCiFwfoGcrYhcPxHk+CSB6vH6wzT4Riqmge+Xzkhio1CzIC8sjF7v
         TF4TGURlNqvqbRyUYQHoOd6/vdag4yKWGBRq2Xq4jLiIJDKm1WuEIhkeNZ8R/YhEvhAL
         q7ug==
X-Forwarded-Encrypted: i=1; AHgh+RqlHRNx6Yz0Diu/k4UjR5XYe6H9797xIh5fMwE4dzc2ZDmHmZihoElQtVU/q/avWYINktCVGgygu7k=@vger.kernel.org
X-Gm-Message-State: AFuF++mZaB3fDVBbwWLK1XKTA/DXdTZwQ6Pppbbv/BTM8FK4uuz1+SPE
	VWV0/7vLuTHIwCY4YsELtRVyS6V6TRzL9SDliQ3BaCexQXpn+1WngB98ZO8k5ajydRU=
X-Gm-Gg: AR+sD13rOEAktcnLiyzTQcNl9r7CaFcjoMlhY/x55J/feTuT0Z7I6xVjplAcNBTohyy
	MrN/e2fLBNqEB9Mh1x80Hl0EgACf3BmGtCWPF+MmvLGwDCbnTAhGXx7GaU+bAIpgi3vl+me7fe0
	voPDYmaCg6ZGyOYXHtDxdem/8HRBSVNSC2qUG2FndEhCVg7vxm1SASDLNyKcDGwKpriVb1LuuXX
	rUlzWb1+19qonhcpvzkXBhZLkXakucuxvZb4YuXicTnoYfTLK6VQK13EM2FyHF+xj3BIY7jSKYU
	+dAi0wVlU5DPh/6z6aCSF1IynGAt5rKohRh0MCJ1hDy2JtVbj2eN2DZaZa7DA8BNkAo6e4zVHM1
	FE5eta/4hf0Xow8UudkJagEMbbr634D4IVQIQusSUXbSOcOI8IoGu6XhtLhkYioNTuCFR0UmTIi
	f8qKuweShlIXwEm6OzognTDG/WV+EilW5qKqZPWieOoM7Fqwm6LYHUqZQtcC2SPp4eSEZrSaoD+
	A0GHhxeSO2CkjBVGkDsh3UMYKIpwxTnb3/K
X-Received: by 2002:a17:907:d0c:b0:c20:53c7:488d with SMTP id a640c23a62f3a-c24e5ade3a4mr838491166b.14.1787670525274;
        Tue, 25 Aug 2026 08:08:45 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24967459aesm1746952766b.48.2026.08.25.08.08.44
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 08:08:44 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so39605705e9.1
        for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 08:08:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpctBCAobzWvHnrRS5U9ksmn26NfW+GdL6B2/xVLHRmvAFiXXvgvbJCd+vEgRiKZLIduWpw4IerVqI=@vger.kernel.org
X-Received: by 2002:a05:6402:2490:b0:6a1:f93c:f0a6 with SMTP id
 4fb4d7f45d1cf-6a5c4157aa7mr9125375a12.12.1787670181340; Tue, 25 Aug 2026
 08:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev> <20260714173315.1981708-9-claudiu.beznea+renesas@tuxon.dev>
In-Reply-To: <20260714173315.1981708-9-claudiu.beznea+renesas@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2026 17:02:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWYyGci_NNG8u+erL+vGeL+8vUXBsZ+1gcaBq-QYFWV2g@mail.gmail.com>
X-Gm-Features: AcwNN1XuzkfLnm_UPDcmDBLz-Zu37ChvVAcOyLsURutDp-p8VMVRi7QPa69l3QY
Message-ID: <CAMuHMdWYyGci_NNG8u+erL+vGeL+8vUXBsZ+1gcaBq-QYFWV2g@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] arm64: dts: renesas: rzg3s-smarc: Enable CAN-FD
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

On Tue, 14 Jul 2026 at 19:34, Claudiu Beznea
<claudiu.beznea+renesas@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The two CAN FD channels available on the Renesas RZ/G3S SoC are routed
> through the Renesas SMARC Carrier II board when used with the Renesas
> RZ/G3S SMARC Module.
>
> The CAN transceiver on the Carrier II board has its standby pins connected
> to GPIOs that are selected through the SW_GPIO_CAN_PMOD switches. By
> default, these switches route the GPIOs to the PMOD interfaces.
>
> Enable the CAN FD controller and its two available channels.
>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
> @@ -68,6 +68,24 @@ codec_dai: simple-audio-card,codec {
>                 };
>         };
>
> +       can_transceiver0: can-phy0 {
> +               compatible = "ti,tcan1042";
> +               #phy-cells = <0>;
> +               max-bitrate = <8000000>;
> +#if SW_GPIO_CAN_PMOD1 == SW_OFF
> +               standby-gpios = <&pinctrl RZG2L_GPIO(13, 0) GPIO_ACTIVE_HIGH>;
> +#endif
> +       };
> +
> +       can_transceiver1: can-phy1 {
> +               compatible = "ti,tcan1042";
> +               #phy-cells = <0>;
> +               max-bitrate = <8000000>;
> +#if SW_GPIO_CAN_PMOD2 == SW_OFF
> +               standby-gpios = <&pinctrl RZG2L_GPIO(13, 1) GPIO_ACTIVE_HIGH>;
> +#endif
> +       };

Actually this is a single dual-channel TI TCAN1046V, which is modelled
here as two TCAN1042 instances.

Recently, we got real support for TCAN1046V, so this should probably be\
rewritten, cfr. "[PATCH/RFT] arm64: dts: renesas: r9a09g047e57-smarc:
Update CAN transceivers"[1] (which I wrote a while ago, but never
submitted before)

> +
>         vcc_sdhi1: regulator-vcc-sdhi1 {
>                 compatible = "regulator-fixed";
>                 regulator-name = "SDHI1 Vcc";

[1] https://lore.kernel.org/2a759a486337e4cc8156bc94079471a6552faefc.1787669487.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
