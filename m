Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AE826A0A7
	for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787669283; cv=none; b=pzxZU7pDt7ruiKjgY7a1+doxShjzkVyFkhy5pq8z/z++7FoHyTXg2JP6e9PlyL+zZeAsP3uS/Ng/GyOAr0O6CaNLhCLot9N+big64YHVLyCaw3bhqexBh9k2I6l8JaaYGrAlbgeV243cH5S+HO3A/nCUsv3jKE4stmBMPvkjIZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787669283; c=relaxed/simple;
	bh=nLpkCbwZynXDMfJEEM7Od0jmnvS7H38PKmlDset+WdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0QkV67CtQI++v1RIFq4D+g42Fz19kdq/xMNQFZYkjGdUhTdfXQ2kKkk/W/y2TAn5+Dg/nf47dPOmqH688hI+Tb6O2YUDWLOs9G+GZxaPkxsYQ4WS6kp7E427Q7bZbxZ2DCZHT+UcWnPBhnG6FPRAsbvXrXX1UkzaXqTUOkDkTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81ea0b7d137so43840987b3.2
        for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 07:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787669276; x=1788274076;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U2zVX3GQV5dux+TGrNQ7XOJ1BZI/EApCvZgLsrH7Hjs=;
        b=M0jt+OBHjqwmJ7vM5BlNWIZBG9MvFdx1Xl3L/8HVCx3RtfHzxrYco90PPZOFZhSjba
         lROE+ZfckmhYunuDIm7SabGwqTIFb3bWRKgpd4OPSbZlWBs+o/snaPxKRE4jHw4TCBXG
         nyN22k/IZVMHKAdrznrQMbgv5/D3FVy6gLWsIJxHPW/al7KIVodlPervZGkIzKHclsG+
         KGvQQ3Srmm8ZmddlsdlK6pvmW8Ao7jRvvoozk2kPAFnXXSpnPxMccPNXVwlZ9fryFOxR
         YUCyma34FDfefruDvbKrlxqN1zz3KCSmTSpkkJhb37B8OZEInvmviXLyN+rMtlbrKnmU
         TmEw==
X-Forwarded-Encrypted: i=1; AHgh+RrBE5tX3xG1FSq+tBpbFBAyDbvNGnma2scjjmtqiqkTy6TrKnKaogO27Cpb032oc8DfX7x0uMLGw5M=@vger.kernel.org
X-Gm-Message-State: AFuF++lpHc9A4WVnhuunFJW+j8/jeNyrsJrAf58tLeo+g8SavPDAm4Bc
	jfBgkL2Gf8Nbca5aaMwOCIwr0RfFRYIpjo47RFSM4rHBy2FWjnwTW27AlaxSq6ifmGk=
X-Gm-Gg: AR+sD13IbqeTW8P3D4H05M6NnCQ7MeWggmHVb+f9v716J/FfaY3vsIsIdv2efqhD0XF
	FlAQrnXZ8QeFIUKoPW4AyfIFWX5NEejlrr1+/KXR2M21VfplF/PbUKI8XVWKBhr8OShWPbYkXfz
	wkuhgnVq0W0VrS/eobxSSRMiPIdFLZRiTQmUFXrjb03YRbPTptjEtxMidutcbGKoVs+n/JBD4TS
	YKl7dZUYNBTNy0PR/1KffComAAJq1123wSP/7VgaFEPP2qCVU8pwzCUbZYW+XNkxeCEYgHG/eNZ
	FqpavS9MkZUEVUyT8nfb+thBaVqMdLKVheGI9J/IvINgx/h45I7lh3qYIeGf8/QRkGGy22DGhFT
	ZmlXK4kYh8J/mqtszu3sFx3ggHkfCrFUYHca/pi9hQKmcnE3tEiiHKwKADuyR0yTE1Ks99p/XjL
	e2xN+Pyq7ZmgymJGG14oTe9SrnUVvylFiVtQQYP13VlGFpb3SxH8noCg0CdBUzmcUzm67QkyPIT
	MG2J9gfPZTeE2Ws16pKE3hexGyabA==
X-Received: by 2002:a05:690c:6b01:b0:856:b8a6:5e79 with SMTP id 00721157ae682-856b8a67d54mr5455627b3.23.1787669276034;
        Tue, 25 Aug 2026 07:47:56 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8570dde1900sm236247b3.46.2026.08.25.07.47.55
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 07:47:55 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-836cb2fa1bcso74573547b3.1
        for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 07:47:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoM1/ptMmOIKQUkfiU1ypwSx9F9PybFjHBQ28Rqe12BgLhr1ggcvnVjm8FzXMc0l+gJrDMjxzOJJb0=@vger.kernel.org
X-Received: by 2002:a05:6102:956:b0:778:9e3c:5760 with SMTP id
 ada2fe7eead31-77bd288c901mr8711759137.11.1787668885681; Tue, 25 Aug 2026
 07:41:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev> <20260714173315.1981708-7-claudiu.beznea+renesas@tuxon.dev>
In-Reply-To: <20260714173315.1981708-7-claudiu.beznea+renesas@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2026 16:41:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXMhfr=rp9G8X-+=AR5vqW5VrJfrKwjVrHEKk_kJOh0ZQ@mail.gmail.com>
X-Gm-Features: AcwNN1XcBg5LXeoVHCFcLS1DZhjQyfJuS_scF13yf7YemR1ca_DnmJdOHtxK55I
Message-ID: <CAMuHMdXMhfr=rp9G8X-+=AR5vqW5VrJfrKwjVrHEKk_kJOh0ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] can: rcar_canfd: Add support for Renesas RZ/G3S
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
> Add support for Renesas RZ/G3S
>
> The Renesas RZ/G3S CAN-FD controller is largely compatible with the
> variant found on the Renesas RZ/G3E. The main differences are:
> - the RZ/G3S provides 16 AFL pages
> - the RZ/G3S supports only two channels
> - the RZ/G3S supports only CAN-FD operation and does not implement the
>   bits used to select between classical CAN-only and CAN FD-only modes.
> - the RZ/G3S includes an internal divider that allows the peripheral
>   clock to be used as the CAN FD clock source.
>
> Add support for the Renesas RZ/G3S.
>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
