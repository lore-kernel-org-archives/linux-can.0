Received: from mail-vs2-f29.google.com (mail-vs2-f29.google.com [74.125.227.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27632481FDD
	for <linux-can@vger.kernel.org>; Thu, 24 Sep 2026 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255735; cv=none; b=FsLLoRdj2b5nkakcDNf4ujjmfNcoJKkHKgQfZmfWRji6+6Q38KgehBZJ9mo2OkOxsJO6C5VK0vFfJp8EA4G1iqCRJMl/bevydW86wpj4l/jaxTJQflYgQ2ySTXORZM/WDS8ygHb9Qgipa6gCxmwPLgIT3bim2SYSnk4F1ZEwaR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255735; c=relaxed/simple;
	bh=D0eyAI1h/KCZFa6u0AMYu6XePMsP2evqWeGFla/gyQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9D5EWRtclZbG77TxDuLlT10rLR435sp6l29SkuIJzf2AMpWcYwiJv98c9hCwTUAp8wWDosxyZJ4F2l1kBEF1/udXTNOeJYBfhBH1u7i1OuxJwOsdqi/EsO9O9MIbC5cOpVH8zAMMLPzn8avGIuigAkAXgxjkNTKKrnM9Hc+AGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f29.google.com with SMTP id 71dfb90a1353d-5c67e5059f9so1215245e0c.2
        for <linux-can@vger.kernel.org>; Thu, 24 Sep 2026 06:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790255732; x=1790860532;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tsNuAVXeEfNNT1x1uW7zJgmNQEg5oMhegMPjI9srO0I=;
        b=qDcI7CpmPv6f1VUNbJv4rwvb3LKOgJSnFszdEh5A1K6YXMURUC72C4fZsmYiZ7LJiF
         POUpC45+djYEOHm8j7qIiJqyiOBAk/ymTSgGwdO4eVMIg7ZYj7f9WNDkCiOv9SNxgsGn
         xWyzWl56ztJcsZ1PIevL5X1m8z9ERKWXLOCuDuQPizOjJx0tLlod3IUdiC8tidiHcfSq
         TkbNWC3oROY7pSjZn0EYJSH7QxwTPV8ohdZlWu3n0aYlsF1ktaKiB3MRCFhLNF8/PCTV
         yJpxlVm2YWgowRdZGYetsRPmKXLMibXzAeTSBDXFoEcCPX3Z78EX8l9PegvxDYZ1Lw96
         asEQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJ2r0mqN8nkDvZgwo7cYrmSpb11ApxxVZ3oPqiOM9i+KKb6AoNjUZqZ+GtpusQwo7v7oKPzhdKkMo=@vger.kernel.org
X-Gm-Message-State: AFuF++nyqOupo/UMYRHANzRkPCeiL0ITdyZLU+MOQ5jFT2FuOLvbaWGX
	9O4p4DGfwO/UU/+/zYDScVSzwFip/Y/D8g+bwTC3IIWlWBLfH2VjIeauL8RrjRRT
X-Gm-Gg: AYBFou0fKW67JBfYZKchT1DkKZRUTU1eV9e39fWXuauZ9EpFAxMNESIJ49UJuRRJWwg
	zTqi7PlsWxD4pnUKrAEYlcjy4N57QlSJ7S42Uj4P9ZsNfcEEEQR9fjX4ZSj7+iJL3B455z7TVMf
	RENdc6O2yk1brDetthk0H1Mv89HQ7Qh1RdR+rcDKeEyMCWgzgZVQLhlgRRzwS3MvgMPAdlLIt29
	gSrUBg3R+APzOYhV/cfl5MRUcJdrH9B6l+nST27CBbWWr5n5ak3equsGh8Wew726rSpgTx1CJF/
	+bg+LkGMChgV+dLfBG2KaWBSg+9ewxT6lptk5hRCNU0Ond4x3P4+lIle1GkVisvH12WoIIqcGEu
	lxcwcZIfsF632WxYFw4+dumLyubYzqzpwwBo3l0zqzePfvtYHRcWSV1dwfEjsNaXRo/mt/72aH7
	Lqsv0NSNvtwPUgFyDZsPhP2rhD8+E/jF7OMWjvFMxGPpUE83HTpjB7Y21rTz82HC9oAbXeyyvc8
	hDiGwHMbWUjF6MdGOeyeIpaYwCDlHYADI+t
X-Received: by 2002:a05:6122:6d0c:b0:5cb:26f9:7a89 with SMTP id 71dfb90a1353d-5cb26f97b9emr973678e0c.0.1790255731816;
        Thu, 24 Sep 2026 06:15:31 -0700 (PDT)
Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com. [74.125.227.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9f324fd53sm5531292e0c.16.2026.09.24.06.15.30
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 06:15:30 -0700 (PDT)
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-78564313adaso721304137.3
        for <linux-can@vger.kernel.org>; Thu, 24 Sep 2026 06:15:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxGS7e17b7QAVpWo6UkYd8GktGt6AggMOKVvd7J/bO5K/mYN1UINfKlEYk7VeFjFLDGrVNo3E1IZNU=@vger.kernel.org
X-Received: by 2002:a05:6102:f12:b0:7ab:d3f6:6225 with SMTP id
 ada2fe7eead31-7af19738629mr1145532137.0.1790255730386; Thu, 24 Sep 2026
 06:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924052741.130658-1-biju.das.jz@bp.renesas.com> <20260924052741.130658-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260924052741.130658-4-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 24 Sep 2026 15:15:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXVTyEROEciPgNuEjbnwEmm2+ah69x-aXEuhJxyn7Aq5Q@mail.gmail.com>
X-Gm-Features: AclHuK8LkE5uIDnRd3MFvv2wYdee95ICGlRvA17-gHv48WB3QWtPRG0tGQvnK-4
Message-ID: <CAMuHMdXVTyEROEciPgNuEjbnwEmm2+ah69x-aXEuhJxyn7Aq5Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] can: rcar_canfd: Add support for Renesas RZ/G3L
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Tu Nguyen <tu.nguyen.xg@renesas.com>, linux-can@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Thu, 24 Sept 2026 at 07:28, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Add support for Renesas RZ/G3L CANFD IP. RZ/G3L has 3 channels and
> 11 interrupts, compared 2 channels and 8 interrupts on RZ/G3S.
> RZ/G3L has 288 buffers compared to 198 buffers on RZ/G3S.

Where do I find this "198"?
Table 30.1 "CAN-FD Specifications (1/2)":

    Total 192 buffers (when frame size is 76 bytes)

192 / 2 channels = 288 / 3 channels.

> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Updated commit description
>  * Dropped RZ/G3S fallback

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
