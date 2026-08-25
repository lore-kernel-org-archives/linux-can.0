Received: from mail-vs2-f0.google.com (mail-vs2-f0.google.com [74.125.227.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB381440A15
	for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668567; cv=none; b=CmWMTndqIMLKe4QHr1Eq4toyTBd9hx9aY0aAeR9TFeWZS8RyaQ0oA+EyabA38+liVP+ISq346K6otddXpms3DQhAlJyDnBAy+slt0NPjVzhNrYbUIhuweKsi0Tshgdk9Ac4HHWaRQXfvIzmNvXOjGZcPjMIb6892HP4d8V6UjvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668567; c=relaxed/simple;
	bh=SCzinYuXLvjSrigmXaPRDipldJ+Qb902vZtP+PB/9Ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0DWE9iJTHs9Uxb1xedEmv6ZBFZdU0BJshtUrTKIbJ4654Cpi/svhbrhdheZadPG1VtnOr8pgZ5+2vlJ3XRNuJkOq7aBo1dBFNHgYy3aKlvSQN9DtFaeAOoUKmn9NqrJVshyOl09oqL4Tn0yYkxfc/WWLIg3Zfy26En+WATcfmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f0.google.com with SMTP id ada2fe7eead31-7399f6d443eso987673137.1
        for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 07:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787668561; x=1788273361;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S/BSqxIsytWuTzQX94wx9xNgvPdt0/g546s6RHG6Obs=;
        b=lenPbnm4b3pti2h5iI9qldX/wXi9B+pxUAwTi2pS+ADUARtaHlQZO2y7LTfet5Zcic
         fJymGOuBO5gEbBOB9MfDluoWF1U2flDGwh8UxdKFfmLv+gJomj0D/G5x5FgHhlh4hr7a
         0J23pomn4cohmedUOdXdY3klOMkJqYeu0BUmZ8rZz8Ltk1+l3uT1hp6MavF3DunSXFyN
         S6h6cDqBMUAEXGf+mhXxxaYyBCbxrgzt6mImgLDE7NI/3qgDETqB1vbhj1JTVsjoAEtD
         NqgXQYucsVLDIrDb64026sIDpUGUT1aY4pYElIR4agcjKxqRFH6VSw5G16bmJGdBcIE7
         JDtg==
X-Forwarded-Encrypted: i=1; AHgh+RoWEvOQQVvjpVmAWFEpcYSC7XbbCl1wgdaNQVLRilXHnP8YIzJ3KVIITgU57Trqk1J0wXR95i9iJKQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k+hpLaTqap1DU1d8hj3V39RmAqaIth5BjtSNV6R2Wzf4PkogL2
	CsDDQnCKSeF2HtieNqfEgV9Tt7jeU7MSDOqsWFur1vQ4FrTNX19T0VMuZJCCzfxy/fBw1Q==
X-Gm-Gg: AR+sD11KyCjsEzC+o1DDit9eWPbGUALWzzz3cPrqIDkPQuxaQfBupmi0o3IHO6DcEaq
	3zh9D82VdFNLk1To9XEgXp11XWmnIs2xxPhkf8U7FnfjCBpPvGeAun/ITn3ioa39bzndFVYeAYs
	5koxCE8ru0rObjJZFFp415zbUpm0aK4hYpeA6y6Zy2xuTgFKXxOF9bfuOwoYX44cV84mHwC06ml
	uRmnPfZkEElIT4b0dPTcG6004vA3EKutQT8pn5cMF25UT1e9aX+xKqmviIiD7lCKkj0q2UHygT3
	a5g8QOyduSxfMepwTiQx/FPRf8td5APFsQtAob/6q8EHd3WfRNx3VKnhlOSeUfe4l0SB1una03M
	mD2VH2DlUFn3xAaBqf5ENwn6b8s8FKYGVZwmoETBDIkkeo9p0vjWZ1cmA1up9L+5JSqohiz0YL/
	858lAn6Z6MSLQOwM4c6DvByt1LhORqKBXMMoXy7itKRcm34kyUTUT3LsHCWJ3m2VXatyGveX5mQ
	TYpe7IMJifAQghd5avFYiLxSg==
X-Received: by 2002:a05:6122:1799:b0:5c0:fb8d:9993 with SMTP id 71dfb90a1353d-5c5ff0d32d4mr11971672e0c.0.1787668561325;
        Tue, 25 Aug 2026 07:36:01 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c623ee51d2sm6261623e0c.13.2026.08.25.07.36.00
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 07:36:01 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-9696319e14dso1607471241.3
        for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 07:36:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrvo79K1H7VrAGnvU4YKL4S14BQuIGEGBbtYrY62SW7fwdSE97ZS/kvzY26Laj4usK4Bypey95UgMA=@vger.kernel.org
X-Received: by 2002:a05:6102:2b88:b0:77a:3431:669f with SMTP id
 ada2fe7eead31-77a63f32c5dmr11778556137.7.1787668560584; Tue, 25 Aug 2026
 07:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev> <20260714173315.1981708-3-claudiu.beznea+renesas@tuxon.dev>
In-Reply-To: <20260714173315.1981708-3-claudiu.beznea+renesas@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2026 16:35:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXc_0Gc0-m1RytTSv9w_B4uMjPe87WQHg0QFP8LamD0yA@mail.gmail.com>
X-Gm-Features: AcwNN1Ukmh5UKBc2zk9wzu2Sw0eK218Xlo9LtqimuxAbEuTVVRxy77cCcK4Llmw
Message-ID: <CAMuHMdXc_0Gc0-m1RytTSv9w_B4uMjPe87WQHg0QFP8LamD0yA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3S SoC
To: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Cc: mkl@pengutronix.de, mailhol@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	bmasney@redhat.com, biju.das.jz@bp.renesas.com, 
	fabrizio.castro.jz@renesas.com, claudiu.beznea@tuxon.dev, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Jul 2026 at 19:33, Claudiu Beznea
<claudiu.beznea+renesas@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The CAN FD controller found on the Renesas RZ/G3S SoC is largely compatible
> with the variant present on the RZ/G3E SoC. The main differences are:
> - the RZ/G3S provides only two CAN FD channels
> - the RZ/G3S supports only CAN FD operation; the Channel n CAN FD
>   Configuration Register does not implement the bits used to select
>   classical CAN-only mode (bit 30) or CAN FD-only mode (bit 28);
>   consequently, bit 31 (CAN FD Frame Distinction Enable) of the same
>   register is also not implemented
> - some bits in several registers (mainly reserved or status bits) are
>   read-write on the RZ/G3S but read-only on the RZ/G3E; their behavior is
>   otherwise identical: the bits read back as 0 on both SoCs and software
>   is allowed to write only 0 to them on the RZ/G3S
> - the RZ/G3S provides 256 acceptance filters, compared to 768 on the
>   RZ/G3E
> - the RZ/G3S can use PCLK clock as the CAN FD clock source through an
>   internal clock divider, while also supporting an external CAN FD clock
>   source
>
> Since:
> - the SoC clock generator provides to the CAN IP only the peripheral and
>   the RAM clocks
> - when sourced from the peripheral clock, the CAN-FD clock is obtained
>   inside the IP itself by dividing the peripheral clock
> - the assigned-clocks and assigned-clock-rates properties are specific to
>   the CAN-FD clock
> the assigned-clocks and assigned-clock-rates properties were dropped from
> the required properties list of the Renesas RZ/G3S SoC.
>
> Add documentation for the Renesas RZ/G3S SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
