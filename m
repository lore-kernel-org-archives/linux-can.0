Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256871F2B88
	for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666334; cv=none; b=uPbS9dVu8C/P1iageQWuOpjMYdmtKCruKdsU8Dtx9mvoNT8oclFsWoFBMoXswgXdW3168hFHfbAPz320bfncaSsNmRcdxqbVOmJ6ToEvxAKdVvJXTsAX2z1km0vvRWQTBxiUc1vmdojQJ7viH9QuZLhO5EF3bY8OeCg6N9GvNYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666334; c=relaxed/simple;
	bh=4Nhf7wYr5y5kOmehF2+mwwOUzZfIYgBl4L8KXVm9JcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcZXZfYRNxOwzh779Y1T5rWbe7qPKfhMCUTJU2IwwFUh7L0t5V5eEZ/SxgMTSTyS79zKv9oT3zyupd6x6x9MkWrjb7ciagtounuf8U/bw58vJW9TpCV7VjZJ8Scaa9qzJ7VTdPcpeEcFQS9pHf5WUQttTlKsJWkktSAu+ZXFqI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66d1082054fso2139918d50.3
        for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 06:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787666332; x=1788271132;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r3HqpL4LRyR8Q1Zvn+1cvkTShpZ++E7BIg5onQopH7Y=;
        b=nmlNVNRcqQ456qnphS+WM6go/mwPmYYOOrO7nFugAMJCCYosh0s2beEUHGJ9iqyNvr
         B1NsnWW1YSgSm0cB6V86puqGZWYPVYJgLHNdl/U3OijlmMdMwTMEHv08/viNXY1IXDTK
         eXo0EEXW2KAKxXVf1Njp5fN6cfWXmWTNhoQm9XaNgpNYcMftKQqJgW3pJSCAAieBGfs5
         v97JsuOhRAEP/Kc0QrsHBs5fr/TfHKLwi6fNdqGhJd80gg8QDu9XJVgzpkMjD61z60HF
         mFjykunLNkch4HUUvL08Wo3Bvs3g/XdDOnphOvbGvsLhiyaTy2O0iUVHUTpxI5CfEQpR
         WltA==
X-Forwarded-Encrypted: i=1; AHgh+Rr9J+aDA+8nQLsYtUYKs0HeFWmJHYAT3/WUEqYXmA4c/2cjcYcVrMJ+1ycfgXAKnV2mnQXhB/hIRko=@vger.kernel.org
X-Gm-Message-State: AFuF++m68duJrVptbr23n/AmC9MXUq5LXDvnXA1+5/l4NQEy8PlSweI0
	COQWURCfbl5YRvv81oyDdZimyN1OERCMsWTch5xdxdl5GXkwEKEfDIMqwReUZkpNPyM=
X-Gm-Gg: AR+sD10XsVobHHvuukK4PAgupUFrVZ3Dirfq0XM5ozXdb3TdySYiU6Rg+GcZ7YsIl+1
	PfLKWVwgzf4AU/cYf4xjxj8oVjEnZD2ycc/6T0DRXnmrOXK1LDFOCnTFBNvvr43rvlj4ioMRif9
	0DXzquXyQDl1pVEV3J9kJtONT04Chn9Xx4GDXHNSVJ1g5nFxyCT1x4dBh9Ms3pBTCjbBjpqJIvt
	aiASx/SrUkYafL76FTofs44KCFrU7V8F1JGbr8IR3WbSnuuE49jb3jZEB171Bl0YVeXuTlKDsvl
	nFPlgxlOFEj+xlsdwtcivxaiWj7kUHpKIg6h/YdMPlSG5zQ+/CzBAiYH4Z1XjqBaJfkbWhyVMQ1
	S1TmTXkzZHBK4dX7fTC5vwg4373k9HloSp7LusF+DACSEQxLE6Q9P97Eg8J64GsmiWvPAD6AMtz
	+T/HUMGBZTrpBE7KTlvty7+/Yb3OSWKjjhSZ5PGiZGHCpMz7FwNS1znMRiVFI6VaUFiI6/CLdzr
	/d1lDhku/FwjIGOyy0gYcOuSi42bA==
X-Received: by 2002:a05:690e:4849:b0:668:db:8c35 with SMTP id 956f58d0204a3-66ce4a326c5mr10123326d50.20.1787666332080;
        Tue, 25 Aug 2026 06:58:52 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cf4665056sm5582651d50.8.2026.08.25.06.58.51
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 06:58:51 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-836ce6cbe1eso69379297b3.1
        for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 06:58:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpQUKWb43f/YFry9dBjZBk6Wr79iMdl2f6aHcb7HUQMGo6/r1j4b66vohWhJmeMbC187uO5OVtlUmg=@vger.kernel.org
X-Received: by 2002:a05:6102:3ecd:b0:74a:b1ee:e034 with SMTP id
 ada2fe7eead31-77a63f3f870mr10636886137.8.1787665871110; Tue, 25 Aug 2026
 06:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev> <20260714173315.1981708-4-claudiu.beznea+renesas@tuxon.dev>
In-Reply-To: <20260714173315.1981708-4-claudiu.beznea+renesas@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2026 15:50:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVBL30LN-+9e5LAVFCaK1y2BEr+VBs=sDgjLCgpc=kgyg@mail.gmail.com>
X-Gm-Features: AcwNN1VGPHnBk0TXWTegWV3RPljNeX5vHxO1DRox-RPTqr-v1ZX5lP4j3I-XFNY
Message-ID: <CAMuHMdVBL30LN-+9e5LAVFCaK1y2BEr+VBs=sDgjLCgpc=kgyg@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] can: rcar_canfd: Fix typos in macro names
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

On Tue, 14 Jul 2026 at 19:33, Claudiu Beznea
<claudiu.beznea+renesas@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The bits 1..0 of the Channel n Control Register are named CHMDC (Channel
> Mode select). Fix typos in macro names by replacing DMC with MDC.
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
