Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309392;
	b=f52LBzTFGp0IzXM9ixiiDnDRKS13eJsvBUWV0oc7iX5wpd6rr959a5Uqufs3fKe6Wxqv
	 27OdHcv6rjlLC27rr1ZGlNJk6352lQaB7qyoNorW0BdMl+OnPlRXRDlI5LLuzUIp/TrcH
	 s+2o4H/FGydt8qsDq6ZShYWlpPK9/R7kxpzSozeNhDsy/1qmE1nXeLaA7z4jxqquixZqb
	 1Jpwqyj8KoFBTNLNstiPgYh+rADpfioV33kxKmHM7XOWEuEDO0Qg0HPBFe9bMOXCkMMTE
	 gASEA+M3YwoWfXL4Ykp73G9L+IGcjJEP9AQ7jPAodLw2Vy9MfgwyogXqluYLhy9PZ/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309392;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=auzMHF9mizeGPb4pIAKNV1dcFrP9ke4ZkvXnr9sGJcA=;
	b=MlhVVaoZS6syQ/Tdvznqae7tH/D0HWssAk7IHBKZAz/gYuXqvrXdcum6/MDn4ab5OzdB
	 LCg3QCtuUcjn4USJDegavopDP5XfgCEYz2iWOBUJn1dfNAY09RozrL++wZQTvJNXnWqTd
	 KzsbrJ1J/iRbrghAKgnVDnBcoi1CBI5Z2oEHwh5TCkr85P0D+/7p10Rkuv/p77KvKQYca
	 djnCcj2VsHs80XL0/9pvQHYf5/7mV6paTF+VcekUiYAHvY0Gs2B+lVaFURAiL/5/g/0Jl
	 DaOABxekroSeRJifad4f5npf19H251CGAUuyRh3b7uO8/lAvzPqt5SQ99cJSzTAhmbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F0D606A31C
	for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 11:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8F0D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so1247537a91.3
        for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 03:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309391; x=1794914191;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=auzMHF9mizeGPb4pIAKNV1dcFrP9ke4ZkvXnr9sGJcA=;
        b=hbSDYPkebxG4itmVFAi1xX1R7sXZ9LG+hFVpwvMrQvF3i4bZgwiIgrUKtswQbM0/m3
         qw2e/8b5SAd8+Lwk94tX7hK8uxQhHDWQP3yRxxXNAHpFn6xIWA1tzOLkoL7wruocuz02
         kCa239ONgayXtskVZxTADASpiqlArSpyj9eOSBZgrZta0bLNAN4oGuESgAKcnTi9GD1i
         Aq27esMqy6eDGqch9Be6gGUfjgELxFIN1ffzL7bDnsA51wdItul1Q02iCN3cSD5EJ2yX
         7gwXSpzYBNJG7V9fsjMdj1PBMBjGOhf8faHO1obmpTEOKB0iKCnUSzIl4z81zY5jz+hX
         86tw==
X-Forwarded-Encrypted: i=1; AL+hErFjaAenT2tXRCiWrIPalsUFRlnp7Nmu9bLoGunOe4C8j+PIqQa/pDi46IwjIEmRfKTfjqXY1XxtC04=@vger.kernel.org
X-Gm-Message-State: APuU4Z/g3+QvOB17QvKxPRMq0VQacVpNNMIOmqaCY7RMISNdW/YgPagp
	iBnbJ8KBDsepNQ/wsOImZzcBOQ1lMZE4R1fFs6Wal0DNLJoxQELfoL46gL/rx7cF/tE=
X-Gm-Gg: AYBFou3jDr1bq6Chnsiazw1DPUrbCCVotGQ79+Z8vUPShVyF0j3VREiRbHba/s2ZJaA
	GvLAjGAOiM4/ZElBoCLpaqv5UW4bib80liZUBOm880EZrK7+qKszFHeZfsuQz7639+PUyryYUo/
	M1XEF7Nna8NunK43uomJVC5F5qcubBtvWlq7RufCnMGFD7IUUDOSnquju8prtcLej1lYY6jd7Pz
	UElk6Lyepgg6YcDcLECyUf/Do4gzoSp7DUkfagva0Mgk7K0Hs9rB7AkxC1oXrwJPIviNO3McSQI
	W6sOF4X3ebtYg6RYhi+3TOxz+bz+8IF0rSnuRg7aNUbuDDI3CAYmRO1PAOEeTQaqRcxlFPyya00
	0OsP5kXTQ75UtcyqevUHM59XMHGQfLxTQWlCwTmDxLCzzDiqXAD/OhQZ4IXcyNEOY8oLp57wUk6
	3Z7W1JDTYOo/8qADLCrN37cKOhKT02Fo9GrC6xj3r9VnVyO9U2CgymyAd+qL0cuZtfpyDWMZ6QU
	Zydh/r6Wvom/I67ONDeRdtLODXsdllY7uoq0Zrcn/uTDt5SIUcjSTsJEmLud6YGte88321ICfpC
	qjWSFX6bJ1y+Xh1X2uLdN0l64EIp3yB39lYj1+8U1Q0lfwcQZ9c0C11DnAS17bGNPKakob5E
X-Received: by 2002:a17:90b:3b44:b0:3ae:2969:9031 with SMTP id 98e67ed59e1d1-3b166ce0088mr2633658a91.54.1794309390503;
        Tue, 10 Nov 2026 03:16:30 -0800 (PST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com. [209.85.215.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16779d5c8sm3549177a91.2.2026.11.10.03.16.29
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 03:16:30 -0800 (PST)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso1276349a12.3
        for <linux-can@vger.kernel.org>; Tue, 10 Nov 2026 03:16:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGq4mtAHlgACYwONSfYarjLRkaq/gSlygY8ZjJxidVdRwLTP3nwiMvRDXJpIxohmZZ1p+sy3B5iGww=@vger.kernel.org
X-Received: by 2002:a05:6102:688e:b0:7d2:d65f:b479 with SMTP id
 ada2fe7eead31-7d301c226cfmr561698137.28.1794308940907; Tue, 10 Nov 2026
 03:09:00 -0800 (PST)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev> <20260929-loon-of-remarkable-romance-197df6-mkl@pengutronix.de>
In-Reply-To: <20260929-loon-of-remarkable-romance-197df6-mkl@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Nov 2026 12:08:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUE1Jh605kgj4ADU7p1UjE-0u3ydBehL_5wsQPbe1EPMw@mail.gmail.com>
X-Gm-Features: AclHuK8XmPD0hM0Yy0td_5BzKaCizARWIEsuGHtnTdehhY19YbtXTFG2NJSt-Nk
Message-ID: <CAMuHMdUE1Jh605kgj4ADU7p1UjE-0u3ydBehL_5wsQPbe1EPMw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] can: rcar_canfd: Add support for Renesas RZ/G3S
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>, mailhol@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, fabrizio.castro.jz@renesas.com, 
	claudiu.beznea@tuxon.dev, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Tue, 29 Sept 2026 at 16:19, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 02.09.2026 17:15:37, Claudiu Beznea wrote:
> > Series adds CAN support for the Renesas RZ/G3S SoC. Along with it a typo
> > fix patch was added on the CAN driver.
> >
> > Merge strategy:
> > - patches 1-5/7 should go though the CAN tree
>
> Applied 1...5 to the linux-can-next tree.

Thanks, but six weeks later they are still not visible?
Same for " [PATCH] dt-bindings: can: renesas,rcar-canfd: Restrict
resets in top-level"
https://lore.kernel.org/20261009-holistic-warping-puffin-3b92fe-mkl@pengutronix.de

Am I looking at the wrong tree?
Thanks again!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
