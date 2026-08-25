Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB7D47A0B8
	for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787669378; cv=none; b=rZKNsXZ2MmbejhVWKmA2p0BZguACp0B5xKqop0WxgDW41m1MHbIIY8tz9me3PbtKg2YS6wurbUfbmmXap9AvxWFJhJxUthWOfYdIcqfZ47zHMZUAVY98XwZfm5K3zxnj6ddt+5YAmmMPoBPaYGqhevOvdqQJ/ga7HeZPftgmF6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787669378; c=relaxed/simple;
	bh=nPKshbbUtBrFg12ZGrFb6hUqHzYltdvYyLHCNt5+v8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGISaddS5wD8TqoIurz07f4HHzvilKuEzVjQ9aRHWsnoNT1uQlUy+DokH3R0Z91sj66YfFheVybd6GUQ9CdNCtNjvzVymaHlcDf0SxVPs0LAdcR+DDSnrA4gC+6ZORjurgDOtTcbN/SQyEZN5KrwlrgU25uE8NwcOJjDyqxjwjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-97cb5850a93so166385241.0
        for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 07:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787669375; x=1788274175;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w6P/zDMrNIG/rjy54fcEEocHk6BsN+YxdD3SIYMCYNM=;
        b=hsoVJZYanSYugIxc9V0yx6HuWZjRL10VRiHVw5NmD6ebMnn33eOY/aM5MSYHtPaDRu
         vL9FO3vbiq7m/+wDfO4bPFvLCEwxCYmBpFH5Bq0YYvw7qmm5tssCb9Ef9p1s9kPubL6f
         W5mpqmQZ9d77d6uSz1Ak/uz5XSxqoeSwEgI3ehba2BXjy/uaAktU9Pb6NZbF3J5wsn6l
         qtrt0Kkc+w33XZGb1O9IEyRUdygnU08llqKkYH8We0gNfbZAYJWSVZQ32qBBtPJ1zzcH
         XlzTizr+p9PpkLjFx+i9y605fe1nAIr39oIGiQhG4BmwENKNl8s8VcFicA9/GrnXF0l/
         +CfA==
X-Forwarded-Encrypted: i=1; AHgh+Rod6GIJv41abzMBy33GO00hyTeQ4HFMSCzYRfOGWArv94ts8dw4+pq284qCRR7Wv6eCjCiD/hSv1Jo=@vger.kernel.org
X-Gm-Message-State: AFuF++k4fYS+yx8H+znSuUiCV+8BTJVee8/mmodjP/4A181sxGMZntvB
	mdTQmYBz8hDXo38UHAzH3N+D/y6C0Bl6r28bvaa5V4W2bg2hSCDLRVB9He4IgDECYPM=
X-Gm-Gg: AR+sD10K6PPJu/jz9JyXiXWuIbhPyd0cheO9S8RSuqr9Cp27lX/9qu9+aTHGYLIsNKT
	pwszlp6oxQlbfCVfBZhVUtErAsgVoUxQl2XaYAKeoDWGzhy70H9cGbHzKqhFjjgsuPqrv0IknOy
	X8CFd0wxoaMMrepVpvL6CsiDE75EQ5E3Rofgyw49fp9aNwG6xxzhADy+m85MI+otsMX2UU+EqId
	4LKc2+9oyhqh8Is157iHYlXewrsyPxSA1ZySl4Kv7G1nyYFVgQDodZ5YiCxqypL5hWVi/WmIjO4
	lko+ACUghNpIyjS114mCsN+jD5CsvEJRsDW9EqUvx7RowUt77UxhMYIoh1xTYHA73UW2T1kS7C6
	wHuep+UASXRCMGztTCCTFdLWFYTEp8YARvoTzqkZSawcunfjxqp1NeHqFMIgPRP13oa1O5MEUQM
	CtZRKHkFsaS/zDfi0aL8usyi3eX5l/9Ba7fU3HodIg7zVzWyUyTfLyJHWVBi97bOIrOn4x+7HIJ
	nZvEs1HzF7cMEirwVLN0UAnqA==
X-Received: by 2002:a05:6102:3f9f:b0:778:9429:d51f with SMTP id ada2fe7eead31-77a64a6ab62mr13003422137.14.1787669374643;
        Tue, 25 Aug 2026 07:49:34 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-77d85beba4esm5587510137.10.2026.08.25.07.49.34
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 07:49:34 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-97caa212bf3so563249241.1
        for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 07:49:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoyBbt9yIaO8SS8ZumSa9nIK1uti/DyowROc7Rj1/W5Ri/84KrEXgXaA5Ls4OiLH0LdLqZ8QmaRh04=@vger.kernel.org
X-Received: by 2002:a05:6102:8682:20b0:77b:b38:6f44 with SMTP id
 ada2fe7eead31-77b0b3874afmr7018842137.5.1787668934683; Tue, 25 Aug 2026
 07:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev> <20260714173315.1981708-8-claudiu.beznea+renesas@tuxon.dev>
In-Reply-To: <20260714173315.1981708-8-claudiu.beznea+renesas@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2026 16:42:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW2BBChjGXf1LqR68EE6LfJXv+uwPm1AhB=NaasL17-WA@mail.gmail.com>
X-Gm-Features: AcwNN1XNGYc2CQ2kaWgxF0GmyyU43AxSZu87qBHq6lGDVbEDpy4b3DvqBrFpSMs
Message-ID: <CAMuHMdW2BBChjGXf1LqR68EE6LfJXv+uwPm1AhB=NaasL17-WA@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] arm64: dts: renesas: r9a08g045: Add CAN-FD node
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

On Tue, 14 Jul 2026 at 19:34, Claudiu Beznea
<claudiu.beznea+renesas@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The Renesas RZ/G3S SoC includes a CAN-FD controller with two channels.
> Add the corresponding device tree node.
>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel, pending acceptance of the bindings.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
