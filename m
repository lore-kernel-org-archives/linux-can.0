Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE793537F5
	for <linux-can@vger.kernel.org>; Fri,  4 Sep 2026 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510044; cv=none; b=Oe3sB+MCOLH8TY4tIhzIcCjaAmHcyXWbjE11xBpUaukZC6rrpOOUUwmTpiVedOkvhxdetXx2wmw/7rbL8Nd0TGNeHH6+OU3juxLy001EcKZMz9Xf00bR2f5XyMdpCh4ZjjpsAmX14ixj95AIh7XFYrtjscdYS02PkQvUtMFgmfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510044; c=relaxed/simple;
	bh=oyDxmpF/0rXv8EzH2b2HV9ktlFAjPfgd1vY1EFEf3Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+lwMv5++krrhW0MClIuCiSRbDOSk+e2In5RlL93qnsmAn4JPGZSURx5sml0QKiLeTUwfHnzPy/bI8ONrnb9OeMC8x+aCLuoOTI9cYrAu4f4PAvJB+MOB0S9h3hhvy82oywB20ZKHspkhPBLlYLpACi84S6Lxg88Y4LDPzlJC2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7ee4399c3abso688238a34.2
        for <linux-can@vger.kernel.org>; Fri, 04 Sep 2026 01:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788510042; x=1789114842;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8Hg5enr8UVGmoY4IFaKJm1CFD+8hJCgKWPLT+95rrjA=;
        b=G7C/Unn5E8+W5tQ3GAaXanTx2wJWKwQ03FPrZSDgg1zazB4Sc3um1SqAdGhTfV6t7T
         hTF4qVrHbt+Yaxdrdb2567vtSQoZbnqtFA09IaHsyiyuyOQj/fYAwHQbDd1ZEF9d0Xol
         XfcCObz6qK+7NsMUf0wuATeWbkyLNKX3E7/hz5Vns2WPmlh2U1eZU28D4Pts/8u0ir/D
         12fvnWzoEOorK+6vBqfKbeln0/unrmpgii2thi4s0KhR3+KHOgJ6TgeI+M1sLgwniPTx
         3bHwB5dwjtan1V5vYkUPTljxPKRUZMV0KVyb+AapsegFuEbLjQes8DCYq/hTH4KS6pfi
         nbSw==
X-Forwarded-Encrypted: i=1; AKwUvByaRLGSlgJ30OOyNJZFRPM3EMU7b50t3QPHTwpWFWfa8Pz7lrTOCNINmeBbA3tGojZ2aPEwFMQ0DMo=@vger.kernel.org
X-Gm-Message-State: AFuF++mU7gV0QShI0Iz/yIufFD9sQC+AtROfcXEzTKTeSe94rJbmbvHo
	qvQ9l9nNwNeoKqA1lt1JdtR4gRLUjOFjfkzdM9Kw0ngubIKiklIbtIXuLZrcK0JVL/g=
X-Gm-Gg: AYBFou3Nhsg51jciNnfuYxXIm081Wa9mfnM/LYplTIU/JZuZSxh6DQpUN+4G4V94c3R
	Tlc/1UQSagFVBu7Hki27EJggU0SoqGteqzrfV4zoOjCItZUvf04Fk7muTZrCNIbu2OrcZdKEJe5
	ZRYEV2Or2mfJ1yXLnFW6VsgrfODB6dMr5MoHnXQhZGm9PV4/pw1gk/ka3WxHlI4Cvs+v8u9/2QZ
	Y7frnlhTf5z7EGtxGUvTR4qcY5w5K5nhLqD96CwL+uVFM0csJ3Lm+JStV5sAvuZogSendUjCsmV
	RMZeIJlIb3VulrgtQL522uU6drcoaS7H7kzsHfUAWgDjQz1R8djcQATavncxBjkq5wqpaf7fp1n
	RVEKe+Oihd27Vql28SZ0vzz0M1GxP7OhcpYtxR3/xluU84VIx5EL0VhSe7XPAVjorpnkzQhU7J9
	LbaRhWksnD6776RwokOH8ZGd+zOSA4//HUrV/LOR0PO4fH+iLQCtWlchxRiEcazzHIQ5Qs/7p6S
	RnDLsw2u7NFe435rJuMlFQSdA==
X-Received: by 2002:a05:6830:378a:b0:7f8:4a36:5eb9 with SMTP id 46e09a7af769-7fa2038ae17mr4296392a34.12.1788510042118;
        Fri, 04 Sep 2026 01:20:42 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f6da949asm2209286a34.12.2026.09.04.01.20.41
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 01:20:41 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7f4f53975e6so621351a34.3
        for <linux-can@vger.kernel.org>; Fri, 04 Sep 2026 01:20:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwa+TG85nmCdlY1UWDxwMrXLPLxjWa+5x6waPVP0JnUmQkDyQ4sYaMhuq+/i8RE5WdFimKnDR6uKeU=@vger.kernel.org
X-Received: by 2002:a05:6102:534e:b0:77f:fb50:8822 with SMTP id
 ada2fe7eead31-78a4a9106f4mr984477137.7.1788509665014; Fri, 04 Sep 2026
 01:14:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904043724.2955444-1-s-vadapalli@ti.com> <20260904043724.2955444-23-s-vadapalli@ti.com>
In-Reply-To: <20260904043724.2955444-23-s-vadapalli@ti.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 4 Sep 2026 10:14:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVXHwWKu_oqNQBR=hytL0JQVzMsnVWyBueds5PHDJWmWg@mail.gmail.com>
X-Gm-Features: AcwNN1UYeUOEoTpTj0vmkU4IKRIpHFGa-g95RrL_FdgZr5R39yo0yU6G4UOZ8vE
Message-ID: <CAMuHMdVXHwWKu_oqNQBR=hytL0JQVzMsnVWyBueds5PHDJWmWg@mail.gmail.com>
Subject: Re: [PATCH net-next 22/33] net: dsa: rzn1_a5psw: Remove comma after
 sentinel-entry in match-table
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: dario.binacchi@amarulasolutions.com, mkl@pengutronix.de, 
	mailhol@kernel.org, msp@baylibre.com, florian.fainelli@broadcom.com, 
	jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	kurt@linutronix.de, hauke@hauke-m.de, chester.a.unal@arinc9.com, 
	daniel@makrotopia.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, ansuelsmth@gmail.com, 
	linusw@kernel.org, luizluca@gmail.com, alvin.sipraga@analog.com, 
	clement.leger@bootlin.com, justin.chen@broadcom.com, dlan@kernel.org, 
	rogerq@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	rjui@broadcom.com, sbranden@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com, 
	andrei.botila@oss.nxp.com, wangruikang@iscas.ac.cn, amadeus@jmu.edu.cn, 
	kees@kernel.org, tmshlvck@gmail.com, c-vankar@ti.com, horms@kernel.org, 
	vadim.fedorenko@linux.dev, daniel.zahka@gmail.com, 
	nora.schiffer@ew.tq-group.com, v-singh1@ti.com, oss@vassilevski.com, 
	haokexin@gmail.com, alex@sverdlin.org, aleksandr.loktionov@intel.com, 
	lgs201920130244@gmail.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Sept 2026 at 06:41, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
> Since sentinel is the last entry and we do not expect further entries
> following it, remove the comma.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
