Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E1330CD81
	for <linux-can@vger.kernel.org>; Sat,  5 Sep 2026 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788617070; cv=none; b=e529bTNhP6cy0dkiwoxLc7slwEXg4ojD+AE7gngCT6BTNyAPqb0F3YvMQEVm2XJgZzrpJg/cE9bDSZr2/VHVSZARJYnPJLKxPM7SeTDztWnL6uXZX6mDijJhXJ+KEjdCv6IQs7aN/MmI3WAoCrmL5sNSCnFtblgVwuodMV8VM7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788617070; c=relaxed/simple;
	bh=2EF8hQX2715PddwJ9oCsxzncsn7a4W2DF/R/kkGyUeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9EsDzCT1vbGr7DkoLLKr+yA3EbaudsM/CjOzAAppeGMiSL6d1OgCj1qM0Vnz/CgUw2GsNNUtsy31VjS14LGzL9h11XLAXBq8vabQ35LafbIfgJ3hh2xgqzvYoGSBAf0df3XXnVyYkEH6Fm2dVvSj1oIM4+FVeF9hHSBCfAjDGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5c6559620e3so869970e0c.1
        for <linux-can@vger.kernel.org>; Sat, 05 Sep 2026 07:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788617067; x=1789221867;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mmU5FMAneHXfUtApnTl4gKdMaEZfbVGE87dIbOYTEoc=;
        b=EPpYi+sbTpkunSNs9hIghcoZYROh4EwTO0RfiUd8GvKecHj30whU+er1/iEXXo6iOt
         AxGKFfwn2lEizkbY6PaeDFw8jRG0xbMWWFQ9wTK2AKE43aKxpeSaUIRUG4ZRF9pCmFEF
         R2DDzs2vqr0mZXNH1m6V5f+TdCOQfjNIAytsikIY2aK7vwm9hals1I4uTgeONTQ1FnD9
         fknb4J7l0KACFAItNUYjUMYMCtg3LZQ7NT267QJi/4Y0U5lp988Z6v8lQDwfhRdmbugF
         LtMPT7vwwVXR57aeXCw4mpqkiwsz+/jYq5M01pvgDXVUUwccmdgGPJmXX+dEjURB7U78
         4OGg==
X-Gm-Message-State: AFuF++k9ess0JkVYRcKbKhKQVzFApFzFWxbnEIMTbplgMec/iiO27AbX
	jJrFSvr46790RGzkCBmGqn+DKNPbMKHk4wvz/vy2cM2TysS2JF+ZtgmoXk+lCxUX
X-Gm-Gg: AYBFou2pO/S0XC+kv5aKYIixG/wIxs3ICbhy9Ar9VyR+9ZkXrf29Poj9XWkYoAJyG8n
	1+Tb2r8wI3PxLidM5TIu/aO/36WL+B5sD5cfY7dS+o3kafecmJu0AYVW1/GLA+MWDWfBySVYrZB
	g8H7DyLk0Y9Zd2Tc4ThIpM/FfWmVPhwvvK3RbszJ3qF1CCD52F0ncqA9qZRU3qRsuNfORq5Bac+
	4SBSo465ZlU6LZ2ggJeDZWtdsnwlIz+tUex+J4FO23Lh65B3XckWPOTrL9gqNCwawzp0JXjfyWj
	iNxNJGM8r0IAtCmw0SFxWYWrZTW93XQBpDbsUfhj8ddL5ui6AvoTQmsRTB9oMQcB6xI3hLc8vSV
	z8Cucd9xDCZJ2147a91409HIx68t7NBb9eg1M9MPzADSZmMdPCPkdgzxUpshGkm88Kb3N/04t55
	lVdRM1FqTk92oSxRgd0o83nyLuSsurbByopCCkrKgfLJafVjMRWj9JYXuT8Im7+JJw2cfq347uW
	GYbRLt9w985lBa9zuL/I2QY+FDsDRAP9aSr
X-Received: by 2002:a05:6122:4f83:b0:5a1:fbbd:6bd0 with SMTP id 71dfb90a1353d-5c7ed45ea59mr5265555e0c.5.1788617067143;
        Sat, 05 Sep 2026 07:04:27 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ec3b36cbsm4281891e0c.17.2026.09.05.07.04.21
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 07:04:22 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-765c077b5c1so675624137.3
        for <linux-can@vger.kernel.org>; Sat, 05 Sep 2026 07:04:21 -0700 (PDT)
X-Received: by 2002:a05:6102:6d6:b0:737:783d:1916 with SMTP id
 ada2fe7eead31-78a4aa56803mr4238100137.11.1788617060541; Sat, 05 Sep 2026
 07:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <upsCxxaJjg2FJWhfCx6KjFXLlh8o4IhaHKJi@bugs.sh>
In-Reply-To: <upsCxxaJjg2FJWhfCx6KjFXLlh8o4IhaHKJi@bugs.sh>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 5 Sep 2026 16:04:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVVqfqvueX-jk_XfM5tE9XScZPe1OLqGw1MUC=Kd2reBQ@mail.gmail.com>
X-Gm-Features: AcwNN1Vfd3xEhZZ7PrZAi9kkNEISK6U0ldP6Y81De9Zfs-x-Bx4rSr-QXAnQulU
Message-ID: <CAMuHMdVVqfqvueX-jk_XfM5tE9XScZPe1OLqGw1MUC=Kd2reBQ@mail.gmail.com>
Subject: Re: [BUG] drivers/net: out-of-bounds in pcan_usb_decode_buf()
To: co <co+5e2bcf11e7027510@bugs.sh>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, =?UTF-8?Q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
	Oleg Nesterov <oleg@redhat.com>, Biju Das <biju.das.jz@bp.renesas.com>, Song Liu <song@kernel.org>, 
	linux-kernel@vger.kernel.org, cedalion@bugs.sh
Content-Type: text/plain; charset="UTF-8"

Hi Co,

On Fri, 4 Sept 2026 at 23:17, co <co+5e2bcf11e7027510@bugs.sh> wrote:
> We found a bug reachable in:
>
>     path    drivers/net/can/usb/peak_usb
>     crash   out-of-bounds in pcan_usb_decode_buf()
>     commit  2f1baf1fc892 ("Merge tag 'trace-v7.2-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace")
>
> Config, environment, the sanitizer report and a C reproducer follow.
>
> == Notes ===============================================================
>     If you patch the bug based on our artifacts, a tag would be
>     appreciated:
>
> Reported-by: co+5e2bcf11e7027510@bugs.sh
>
>     Everything in this mail is validated by the reproducer below.
>
>     We also hold an LLM-generated root-cause analysis and a candidate
>     patch. The patch passes an A/B test: the same reproducer panics the
>     unpatched kernel and runs clean on the patched one. Neither has had
>     human review, so both still require validation before you send or
>     apply them. Available on:
>
>         patch.diff  https://bugs.sh/b/5e2bcf11e7027510/patch.diff
>         report.md   https://bugs.sh/b/5e2bcf11e7027510/report.md
>
>     This is an open science project. The code and the full set of PoCs
>     are not public at this moment, as we intend to disclose our findings
>     in an ethical way.
>
>     Happy to test patches. Complaints and suggestions about our work
>     are welcome at:
>
>         cedalion@bugs.sh

Please read Documentation/process/submitting-patches.rst, especially
https://elixir.bootlin.com/linux/v7.2.2/source/Documentation/process/submitting-patches.rst#L928

Thanks a lot!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
