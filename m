Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172581;
	b=q6hXxYVJftSpmy73B5PkWie/HTx6iA76Xn/AcGec7oSNJIu8u+KijrnePq/qF14H11XM
	 +EItdfBEz7i2H5qkzxMXQTOatG13kLj2sbDBlYC1JsinxiuBobPu7SbP0q3Bu7Z94M5SI
	 hnVBPwKODGj9cD6aHTRUdzFd2h0JDsco6kocE1WL17reJCVqhzlgf+Nt5rGCavQ9uzL4A
	 uAVzdq4OqgVgALh+ZWIalxJe7k80YN++SJ/jCNiPSFUWPaY1joMbYJNChtr+9NEzw213X
	 ZSrhljqEKeZZyl3PNIcSTiTOw3J42Bozkrramb1w+NWxT1/72Y4iljKXs04xfYsAi1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172581;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=Dgzf7aguqheoAiwvW86CTGnaIKKdaAl+KcGgpUHUbOg=;
	b=H6HC6y3v173YyGlZHVamnpqlMWCd9S10hmApvKfMzQiij8idIZboOgv2jTmlB4KkAaqJ
	 fi8e+zzPKoU/VZERetkzGzr67CxUNoz8XBD/rrlcOIufX0p/guuWjQfKyGxI9w7tVMW4O
	 8FljD/uzEIUnEjes0pjA2X3uALBoreFoqHAFNtQaO3o1m2YuARy2ozuXO9IJ6LmRxT+6s
	 71wr40u2SgkY7QVIbb/Ct26xQ1grK2aFfnQFiXKSVm/Y2Yf6BvaRgbK2XbTSWEtUoeG/J
	 tfUGgI6X+FJOTC2L9/FbUsRvWH8tlOVAosx7SkF4OdXNigWOGEQBRTmxuKOYANaCeIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9AC606A333
	for <linux-can@vger.kernel.org>; Fri, 20 Nov 2026 11:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D9AC606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-99e0b348a05so211729241.1
        for <linux-can@vger.kernel.org>; Fri, 20 Nov 2026 03:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172580; x=1795777380;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dgzf7aguqheoAiwvW86CTGnaIKKdaAl+KcGgpUHUbOg=;
        b=z2aBIAqNI8lXOK2STMdgJ0+igOFrw984mpe9eBeUve5Ax/ENHfuzxdvVRuLgqzhSTp
         iahrj/LFxhc//DTwJQXN4OWUQ0SWkg2tPFmyrwDtTGuxxTCvyz1/j8ycZIgLeCifk52V
         Fsazz5qMqKqcXNQ1LrlPRmK38RgW9cNuOGBl37qj/I93VBGbFyRtw9lIsasyHzLN+m3N
         OUO2bh3N4qmFYZg5+8f2lpzHSmH0QOD+G/RKlp3g6P36L3kBe3NmutlYtiL7d8e5neD4
         N0VtXovxq2WYujK90YiWo9ydP1kSxoi2NTiVDxV2m/aAw1aLWZPhiMID8d7lNPMF81EN
         rUNA==
X-Forwarded-Encrypted: i=1; AL+hErEEIk8MbEizUejgeNbmGUXzN/bzkTRnUOdGwBuzlyVV/Dk8yBR7ncPSeT7GnEdhFEeihM8rXaQFPdo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sG5b9PDTk7s3HJzCMsB/mjQ0vFTcBuoI/bFpcmQJsDfXyU03m
	Cz1GEX4CZNRNixlOwD7MX0uoHbuhpuJh900PQXGZTQ9PpTUO2OW8ObA0MyYMKm7d
X-Gm-Gg: AZFdTZe0zbO+qaCy7R+ohYN6pBCxOMiks9fGrCetl1JQC34IhYIRGBbvTzIA/PXqMPv
	RWZHtImk5JAR9lj/I7mEkmU0WUxauj6tTwnL9MK2WmyLZsQtK0N/BLnSL6Rw8ARVnPGNmn7JKyH
	yOXGcIU4zEE1pKCPb7Dsfiehr/r73rSFIcT0fkOFfgABy0Ru46508Vfa4SGyBUb3CQx8i1HYovd
	hxj1iDp2hRqiaxU0KulmoW/6CiOczasrRcbY2bB/z3OeLo6w3XyT0gfAnsvg2+bBgjqIWBbO641
	6+9XhsrBSDoT476OG1mw/Em/+MO+D9/2UdhXJ1NaTLljwvI3rNqa2XG3fzvkVCuabIXyNsNJGhT
	NQFY+nvwkeXImWa04p0vWwBJcDwJ7gT/d+DUvyXbkF0ITEprio0x8Vzxts72395ouFaNTTD3ltS
	mcp20qc+2bYU487jA0EYOYyych8f9wPlF3y8i8SYd47SvIk/EoWiqRX8v39fGITF+GMa57mULCc
	tpgcPTSdfh5yMIoUGOHekBaBqcO3p2zbwVplJT7uBosFgT0d+4Y/5yFclxuo2drJo6gRj3cgCMN
	sDv/t0L2YUX1GiRB8yC51fRJTqxRkHmDYkBmdE28sNCmNaU2knhYz2p3YdDL6Yrwt00=
X-Received: by 2002:a05:6122:310f:b0:5ea:dfbe:c51c with SMTP id 71dfb90a1353d-5ee8aeb4becmr1139523e0c.6.1795172580350;
        Fri, 20 Nov 2026 03:03:00 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6e08a02asm2546753241.11.2026.11.20.03.02.59
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 03:02:59 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9905d61449cso216395241.0
        for <linux-can@vger.kernel.org>; Fri, 20 Nov 2026 03:02:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFDVuAif8m3QNwgNX2/Af0CbEDrUuc4uX6pvObYvHDJnWSNBgfcCjJ0cYaK/RgCaSb384sIdWIZGKE=@vger.kernel.org
X-Received: by 2002:a05:6122:1307:b0:5ea:94cd:c5d7 with SMTP id
 71dfb90a1353d-5ee8af38b50mr1262670e0c.16.1795172579449; Fri, 20 Nov 2026
 03:02:59 -0800 (PST)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev> <20260902141544.565763-7-claudiu.beznea+renesas@tuxon.dev>
In-Reply-To: <20260902141544.565763-7-claudiu.beznea+renesas@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Nov 2026 12:02:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUHHpawxb_bvbC6Oi9t3_5ExanfJW2zhkCOTevawtZLew@mail.gmail.com>
X-Gm-Features: Aa3M54rengaq81sGnkGug22WDB8YugYyeSQm_WaDyvyTw8kAqbaCOVfSJpyWwN0
Message-ID: <CAMuHMdUHHpawxb_bvbC6Oi9t3_5ExanfJW2zhkCOTevawtZLew@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] arm64: dts: renesas: r9a08g045: Add CAN-FD node
To: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Cc: mkl@pengutronix.de, mailhol@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, fabrizio.castro.jz@renesas.com, 
	claudiu.beznea@tuxon.dev, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Sept 2026 at 16:16, Claudiu Beznea
<claudiu.beznea+renesas@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The Renesas RZ/G3S SoC includes a CAN-FD controller with two channels.
> Add the corresponding device tree node.
>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks, will queue in renesas-devel for v7.5.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
