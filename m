Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CF2443A89
	for <linux-can@vger.kernel.org>; Thu, 24 Sep 2026 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255518; cv=none; b=AuQPINHBiS3lluTQvtNHEPgFb01XnzTeWNW8G6bNz4CAAuzWITaL1PI6xqdtXbNNFaBs8nS77iLOr2wZbIMX2QoNHw4ykIe3+VXU2Kn80jX6pLIa5SssZzOMmTjFKzLQphT5XTZ9lefhqKA3nmkI4YMjndqim5vQbn5+we1Ps00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255518; c=relaxed/simple;
	bh=1TSXneoOU1Yt/tUGyZxYUZ+hB0ehAvjQVuOKhXr/ZFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HC/3x2VDZ5Qioaf3BHaugipiLfQGFhki/C6ApraiN7ixipSZZIPB2fsQcu1pQDtNH4vX46Q+tavAj0I0uam7/j/AChcI+U8bHwm/EFn4pr4WP6Dj4MF9EIzDkLMF0lzrWXNc4vPGlWUEfdhy40S3agxswF21RF5GKC9MehWIAxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-78a338fe106so845640137.0
        for <linux-can@vger.kernel.org>; Thu, 24 Sep 2026 06:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790255513; x=1790860313;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/FyztXa1+P8ok6tdKKVDIJtTBDV2aFviJNLJni/q+qo=;
        b=SbyMQm6TuA1v9VMfTIGObwB5GfeOkBcq6BFG9PZ9lb7YJc6gyFN/5fUKK9uqvi24ep
         QjPpNq7fxiYLSUeASsyX9NH1K9bWhs1URpCtkMqhZVmhei6qLpqALeY+VUix6kyC6UKt
         HlR4v702P71naYbCN1136W8AuDDz5bn7ojbrCJkY3AsRTbrM2VBLrtOB90lhXluqMRVB
         lmjXPD14OufBmkOTl6bRZI96TTqHzXDKc6PLz/TtvdLIE+5MuGrbIQOHpy44hAmCh+hg
         iXu1LwzPZ8N7K8sd6GUYHfpRsSNk5ZSLHOmK6LlXHsd1tJUJbUduRNtl44KpMMkMDcXV
         3BlQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwBeH+Z0KfzXSVqgjKACOoIxU3HQUFu5qmKIPhLg9otxjCjWaBx00k3QvJNw0O7gdJlSlMCKD0ZFs=@vger.kernel.org
X-Gm-Message-State: AFuF++ny0bTt5GjeI4lq6pMHOTmf+jKd/vFVsy69JWVZQeCk09Pc+6kU
	rMCOR3i9QtlyIFOSXnnPakzJ1yC2yo0dkY4CBiiIsu3pPo2RqWcjpKzWrWYsF9mA
X-Gm-Gg: AYBFou1hcEbFnLMNpP0G+oa2axglVmzh8d/ESFdap57W698cRc4sptv5Jxb70CzYl0e
	v6Gv1bmsQY2dRJjbt+v7pfrI7W//9R/FCsKZBGY3QqC5u+uB4W/hG/r7z43AvGIhkX3oqAuZLe2
	PS9kEFl86rwgTdg2Iwb6GuqI712hIsUUWXPX8jYqDIP1UmHUfLDnxM4h6e18sSkQkrVjSXVVQUo
	mBPHvhUL9aEg64K3AAGJm0EDxDr0JAM10+TnNtzafCLyEk/YIw8b0r48nzCff8C7JaaKihAJeeZ
	VUEbjN4Q2jYbqJFJ6Yr8WUrAi/NKBcGttdEulfUDtZ3gm+4YxFsQqKazjw98cf1wSaVtAdkowWy
	vw5BhL75cByjTn13zwBdCR8921faS6lMeUJJPwsG3gHvykPIAsEHeB3RIWGyYcPn76KscAObHb7
	oigzhI93gSMl34Iwd0kR/4p/9cLAciF+95ozoaOtj+ign9QngASOPeOkJRAqE3lj30lQjDiNtsC
	moInwUOSY7oz0NLJQyb5IOlOdtjHKG9XcWoU0NMrCLew5I=
X-Received: by 2002:a05:6102:2849:b0:7a1:f2b5:6460 with SMTP id ada2fe7eead31-7af1eff6b0emr852457137.29.1790255513031;
        Thu, 24 Sep 2026 06:11:53 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9852407d1f2sm3299292241.6.2026.09.24.06.11.51
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 06:11:51 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-982838c4cccso643256241.0
        for <linux-can@vger.kernel.org>; Thu, 24 Sep 2026 06:11:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBykEZ4QhPCVcb1icx9s/I0uNJgvod7JpK+VlWuIM2lxBvJQgSpsAtVyVcECY8eWJPeaGHL1/5T5Vy4=@vger.kernel.org
X-Received: by 2002:a05:6102:a19a:10b0:78a:4dff:7b3e with SMTP id
 ada2fe7eead31-7af1d0a179emr770655137.15.1790255510966; Thu, 24 Sep 2026
 06:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924052741.130658-1-biju.das.jz@bp.renesas.com> <20260924052741.130658-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260924052741.130658-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 24 Sep 2026 15:11:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV4dgpQ9R7StQaz9C=iA9+obiioyU7jgOkkTM4Tz9XoyQ@mail.gmail.com>
X-Gm-Features: AclHuK9Buv8gyRA5u_mR1kAGkw730VchazHFf46HOsFhnVFa58qOMppMCJ7zadw
Message-ID: <CAMuHMdV4dgpQ9R7StQaz9C=iA9+obiioyU7jgOkkTM4Tz9XoyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3L SoC
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Sept 2026 at 07:28, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Document the RZ/G3L (R9A08G046) SoC support.
>
> RZ/G3L has 11 interrupts and 3 CANFD channels compared to 8 interrupts
> and 2 CANFD channels on RZ/G3S. RZ/G3L has 288 buffers in total
> compared to 192 buffers in RZ/G3S.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Updated commit description
>  * Dropped RZ/G3S fallback as there are lot of differences.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
