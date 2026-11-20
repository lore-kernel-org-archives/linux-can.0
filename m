Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172735;
	b=RN1cW+t9JR7Mx7Mfl6RkulZpjDSBDajjpWGj8fagofA6W9zsHMwsVO+UUfAqDscoQPBP
	 79bu94FAsAQa9eoDRuglvQk1eHcMiom+pDqP8PR2KqzMW64im3kd5NtawF7ryTMK1b195
	 aibBoj35ttwd7zPo3p841wVoYIHqjIorzG340bFqU9o3qFnKcJCvZsRGQhtCb0YHcKvm6
	 6FMopznsshjqGH3i805rObpc55VUndf2BvUVxW/s5Q1gX2OHc1XX0hZLL2m2KcVW/cpeo
	 BuP/1Es7VhyZpUN9IXISdJgHGS2ZZoqgTQroMrORW4gQo1YiamC31SksjbOXibz9pgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172735;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=7Fsqs1iX5umt9C6HSg0iQYMwk7igmLmbTGhkL3PvPnc=;
	b=mmPL8h4rAaBJ2U9twZgx5mqw9QLDFHPZTOcxmDMmR4TeSx1WI3C9MSxfGT+wZx+jvZZI
	 65W3wfwUx27X8c4BBYHMC+eMhFXdwJylEH1eq1A2DHNL0s29hPWcZTLPs9DnyYiCHMWIH
	 WdcAQumX81z3LerJ9e+zJlu1z3eWfgm2fhNBnVB/jCdfQYNfUoFMzVYImXBefG9hohkQV
	 IWW+a/okGjvxocw+du6ajXyfppAL2/tKJAIlvC7anREa91L4lwiwfkiEeLK6uCwVMhfpO
	 svkfBAlmX7RDKhsKPDffXsSNbqRC2y/I7lHDavl5OJB6y0tUvSlaOvVwakx5nv++Pfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF951606A325
	for <linux-can@vger.kernel.org>; Fri, 20 Nov 2026 11:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF951606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5eaf169fe3dso230220e0c.3
        for <linux-can@vger.kernel.org>; Fri, 20 Nov 2026 03:05:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172734; x=1795777534;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7Fsqs1iX5umt9C6HSg0iQYMwk7igmLmbTGhkL3PvPnc=;
        b=KTF+2oiQB1S7jLQ4D7aG+nvrWpCoz+TihlHUxRnghJ1+0UbpixT/qJXByz2i3jLKOa
         U36lBLBDy32b0CfEEeghhZiwmSKXoq1/MlWaIi1tCPkLGcP9Khb9jFk0K3jpVuLbS2cF
         qWvDmzALevfSsUXNkvS5MVtjziHTGq2tS8NUK/5H33CD2KVBHEUZNGo6clD+nQWGtsU1
         OH0B7SJ7HK+H+SZGTPikqho3CzbzEf7v5qRT/UXW3UQM4b5uzgWmfQ4mLnqLPo3yrpUh
         IH8Se0pDb0P7vfeoxXAX7tY4ngC5dFdd+hjVsNOQNKXhrOsUJz+CBB/u6D5HB+BGZdEl
         G1sQ==
X-Forwarded-Encrypted: i=1; AL+hErGm8nlkj2opD6LDS95hgmFwq6EUa0hP3WHbcAmgPq7Ms7kj/dBNjZYcBlsAKrzFd2YF9YHp/iE1Pr4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RWJvN3pAR+tYNxrTHBIMBE0M4UocdRzU827qW0B9JuKFkqv0t
	fyECCAvvxfQeqMKoXQGFu+mFVwQKsU6SqeP6FKv/BPRF62hQjOd3qyYi6KouOHre
X-Gm-Gg: AZFdTZcbCwDkKkHj+wv40xyh2LCsP4bNPgBkJWjDb6uph0sNYeHuACUwJCzs0vB9aDx
	0QwOXWhzWHEaF49cBjzYFah6km8+piIkOHzhNaRE8lSyLUxjSpxyNqm3zioe2e+cP7W0EKtxKJY
	+w1eQhBn7heF7+MMzLql0dEPQDqTamAF/gfr+AG7Bzztyip8lMw++mVAPqo9reVwY+4yW7sly3H
	WF0GMVVmHxS2fn5vw7VrpT/GTnZilG58f56PN/NZSF7KgUdcm3VizjDrr8TeYyJWGUVSKbNePdN
	0CKMvQgB2CfR0XqI62SvMT8PfP7INr+DZMGuXuK7XdZ6i1F0x/6Q9IOhYI8atDNzH/GcPnYIoCs
	CbA5LsxeS07MMRPl+isXfhrNf8hV4k5A/WjFAbXStq3XRl3GANwMbK2Hoh8RdiA9HVTOvDg94Pn
	JqhNMTFCmYLxJU7xHJDAm23+wnE7JTHVdne/98UUixMEsFeh2Ebo4uzpko58d/4eyJWZc6M6JQY
	CbY2rObkfQvQEiurwVr6vEzuw3ShRtKcGpbUV/CxtDUn9WUeKH0SfuUPf8ZnSUvHuhzgbe5/pne
	Jglhw54PAqTN2XcEN/4YeCysLMb8Q2SHRGRDZje8SB8HAdM3gLG+jxEcBxE5DPXQjyw7
X-Received: by 2002:a05:6122:552:b0:5ce:d56f:efac with SMTP id 71dfb90a1353d-5ee8af6ef4bmr1298742e0c.21.1795172733718;
        Fri, 20 Nov 2026 03:05:33 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b635d0fsm2161798e0c.15.2026.11.20.03.05.33
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 03:05:33 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso269359137.3
        for <linux-can@vger.kernel.org>; Fri, 20 Nov 2026 03:05:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGkGj4ZBPqPyQt/oJIrSClZM4JyoJnDg2cx+ZOuEXS4rAoVsdcxuoTKbItP/cCYP0glMNnJ2+JiDSI=@vger.kernel.org
X-Received: by 2002:a05:6102:2926:b0:7cc:9d47:9c9 with SMTP id
 ada2fe7eead31-7d73963f00dmr849125137.35.1795172732962; Fri, 20 Nov 2026
 03:05:32 -0800 (PST)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260902141544.565763-1-claudiu.beznea+renesas@tuxon.dev> <20260902141544.565763-8-claudiu.beznea+renesas@tuxon.dev>
In-Reply-To: <20260902141544.565763-8-claudiu.beznea+renesas@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Nov 2026 12:05:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXhBKV8zoi_95WsB3qSC2tm-nX9opurqFPO8n3mn3L=UA@mail.gmail.com>
X-Gm-Features: Aa3M54qJy6m08CrK20MF4Bh-SEahYYaIemU7d5t_ENxV4MsT0OIrWbFwbx-tam8
Message-ID: <CAMuHMdXhBKV8zoi_95WsB3qSC2tm-nX9opurqFPO8n3mn3L=UA@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] arm64: dts: renesas: rzg3s-smarc: Enable CAN-FD
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
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v4:
> - collected tags
> - used ti,tcan1046 compatible
> - adjusted the standby-gpio property along with CAN PHY node name and label
> - adjusted the CAN channels phy phandles

Thanks, will queue in renesas-devel for v7.5.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
