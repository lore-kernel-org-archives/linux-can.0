Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7753B332638
	for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668589; cv=none; b=oCc7A0Zg+NgfQN82E0ZxpdH/xzUKGIZM+riV3uX+b53kZv+ElxXnwowSFLzhviIAXepPuFn5OgZV8iRdDvrlsoK9EbH4i6/JrJSNqV7tZiCCrfwiSLecEUBeUVB2LKNIhzMHAGvEqJ8hRVqhD/bldXH8fbWX1y0rD5xqBKMmntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668589; c=relaxed/simple;
	bh=NtDNnAxS9JCqoYNY9CXizA3YxkktQlBKy/wbas23ZKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjjcqFEP4nSvGO+x+odnn3uWuakdCdAuAU1YjZXbZFRSz0pew35YXXYpMyWb+w1UcyIiiNvrgLdzu5o5n09UglxiX7ohwLRINuLqvoflzHYqNcjAfdK+EGkt6zM7Slz75LzkJ58IsmeI4AkUf9DcmhAcv5HuZOTKoCEAUyuM35Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5c5a818a3d6so3691360e0c.1
        for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 07:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787668587; x=1788273387;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ScdPB/HWXKyLnSzbxD6GH9YFmqF5SuqSigLbQv0OKqA=;
        b=f9xEYsBEWsAKeI6i+IYYzlxgMfQqlAMhGZeGuiCejX6qLb0DrUWAicLLDCRtoXoQ3Z
         c4Ss/TdQ/1EHAMJsbtAGyrMupeYs2tobAM5bDRJa21I8R932USIA7TWIoUdwY8DxMM9m
         QVLNTPn05Zexm4gppfQik8iuWcNBExH06ghhjC4+mWwN/NtA+Vqw3jjf1O08qYLR2Iu1
         T4rDqMSDy2W/wzE9gu4gljvOFQVy/VswL6zi7jrmQmyBtsQEdXFtM/UTE8ZYmbue/ZQE
         aCsETKHGe0GuU2hKuDyQqyjcHBdx14d4ui36Y+K3LZFzmeQqLnmwV0jqRO5sp1OfOhwW
         yobQ==
X-Forwarded-Encrypted: i=1; AHgh+Roo0sqbMuf/vu1FUKIoD78xOZ1Yv6K4qgeY08WwnvgRXNeEDfCsy7DGwU/hMtF/8Ax4WEyq+1nEBog=@vger.kernel.org
X-Gm-Message-State: AFuF++lQB8OMzeMDR5Xxo05+4SCTsYOCQhPimvBmnsFpPE40N7mSICpS
	De3qOLWKUzKvTS7TEuOaWkzh0tEpA+9vLfvJ6s0O9BQwLfZcE5+ho5OtX9sYeRKEeVY=
X-Gm-Gg: AR+sD13tNewPPHF3Ztrgz1KqycuLggYAWeJhLLABNkBhgfN8a2QYRoEy/cDHLW/qzDB
	XxToENf4J7r/6O7HCodF+osdjOih8Rzmjs6uBQ7o/v8LI+yEP3dPUxPC6hQLZ0wnFH/g2Tci10W
	k/2+grVht2PKOL4HVL8c2ZpDAN+TR/wXmMfnjjvGlqMxZ0YaFEj70VQEDNEW0GZ2Vhr06goa8O8
	gr9TB5LMNzDDk4Cpi7XZXmXC8+SbS6/tXb6AOjsM78nOhiPIsaiil7t/VwkxJRe3H3nY6dKWxmw
	yHDLCjLQZOQ4TpSGJmtuAyLbBYhASIo9ajw2ERldttn1dNO9qfRIGEUJHpwd/dHHtaJDD4fUa8k
	X2FJxeIBGyyVHwS2fQdMg/TMCkt9iNl8dyxqVI47w1G6JhgW0EDdo7WVUbCtgqi5jMSgQY7O3AN
	JFMCbdQJjq3z1Q0jy2wA2GjzTwPD7thMqYjyLx2eWf8GRMlFPLHHE9cSnefUkThTfHx+offRBPV
	8w7+2ieTQKCNoVsIfZ9L7WxHA==
X-Received: by 2002:a05:6122:3309:b0:5bd:a5e1:c7c7 with SMTP id 71dfb90a1353d-5c642c10b46mr3349050e0c.1.1787668587193;
        Tue, 25 Aug 2026 07:36:27 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c623d30586sm6325672e0c.6.2026.08.25.07.36.25
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 07:36:26 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9693bbb962eso3040227241.2
        for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 07:36:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RplrhgasdBfxNbJjCh6SN7h1astf3o4+nGKeYpCVQujfVh/Q12C1KJzYLU3azL4+36p5BcQ7vhp2sY=@vger.kernel.org
X-Received: by 2002:a05:6102:148f:b0:77b:4bee:6a8f with SMTP id
 ada2fe7eead31-77fe84dcf5dmr2940768137.9.1787668585576; Tue, 25 Aug 2026
 07:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev> <20260714173315.1981708-5-claudiu.beznea+renesas@tuxon.dev>
In-Reply-To: <20260714173315.1981708-5-claudiu.beznea+renesas@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2026 16:36:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXQ2MsMKQj6gA_4pPwdn2VmyGgzTUXHF02=3hVCdRWC+g@mail.gmail.com>
X-Gm-Features: AcwNN1W_bbmZVeZ40Fyz6-5WTX8tm1gBDARO4xiKfvf6z8u1u_UqEYooprtkdMM
Message-ID: <CAMuHMdXQ2MsMKQj6gA_4pPwdn2VmyGgzTUXHF02=3hVCdRWC+g@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] can: rcar_canfd: Allow the CAN FD clock to be
 sourced from fck
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
> On the Renesas RZ/G3S, the CAN FD clock can be sourced either from fck
> (the peripheral clock) or from an external clock (can_clk). When fck is
> used, it is divided internally by the CAN FD controller.
>
> Adjust the existing canfd clock handling code to support the RZ/G3S CAN.
>
> The existing struct rcar_canfd_hw_info instances were updated to address
> the request in the Link discussion.
>
> Link: https://lore.kernel.org/all/1d9719e3-10ff-4cd8-b729-55fea93c37ce@wanadoo.fr
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
