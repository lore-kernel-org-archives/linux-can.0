Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46085426D12
	for <linux-can@vger.kernel.org>; Mon, 29 Jun 2026 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744270; cv=none; b=sj7LFwpyZquNON24oweG7KeUMRSiYANmVK2H6HF6JbuW7Z0cW8zQ+B03vsaalwuI0dgZaDkO63fR7y06Bk26BTRmX/I3gma5+oRYeefZ2j+t9Eqc8XcpxplliKIrrt5HGdt40UZwB1kIfUTNDtajY9girwDPWSIvNBLvHVHJFTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744270; c=relaxed/simple;
	bh=kVTh23sJez09owmKcyEw5w2806Rb9SC0opFLcX1IrTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBkWDyhrr1PLhlo7m12xzvedYoyzKLpq0z+kEJE4Ju7D+uGycJ4hDwovG8EQi+2miBgF0IUj8WkU3U99kT/1ws6FVT7kd8U3mT+W+HIztD1/hGXop3UJyWDJO6mv+FbUrsLLMfZi61qmygPG8GF90i30H30vENhHex1k0dO0rlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-59f8a140a51so2550028e0c.3
        for <linux-can@vger.kernel.org>; Mon, 29 Jun 2026 07:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782744265; x=1783349065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msXjx8KznxQkzXcrCPFA3zsW20N5m9gILYTYEJqxx1E=;
        b=COKUqJHFaOcBaDrT3F/VcIBFKUnYNjAFkjEKvsffY3gFM8+WIgvkTeQFXYYehr9h57
         vlGPezALO7zaXIqk4ImmMEPM/61OEJQMtbkf8kWdfMyxJdM25BDGo4vdDskDpwCN5MlR
         y6HuE7QTA0G6vVf4/0orNDDB5NIJWg3QMuCZSxmrW86YVaQzcy3n2M3jAaW8fZOkJDaz
         hHN0MOJ3tvUmLTNHOPb4HeOM/34ynDFtjj0gs/ENg6C0sSQBSsT0T6C72SZq/N5/wA32
         +DAUtmTSgedgmTvojQZ/fJDA7C1ICCBQcjwLhcPZO6GnR1pbBZjjShZNcNEUc+Lny8lK
         PGYQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+oPbVatIoEubzAuivm1Z9/7dMRSQATEXijqro6DFr2C8PIO4SDXRHu8Pbtg+DceLpnCNSDjzul+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx7wO1oGeHzPH6rUUt5btv46hZ5L81NHPbYBo/HmBvXXcTmhVi
	M7fEXYNMqehsjdbcto7VZbXbhG43o38iRsQ4KAtIT5EcOqppbnuIbNnKxvw/HlTQ
X-Gm-Gg: AfdE7ckQKbYpXU3GrxjsydqtlCcjdzVwidsobuowoNHul7pJMbBMK91gdar5tpVyozk
	9fnXP46SlmGMcNjCHShm99qu8tYPdkz5yimJBj89D2LfQYYG4aKo5m4PkLn6Ko7zf2NJCAvhsWy
	zQBrZUW087zlXbeRvcBMl3BnwFCfccM3lKWFjouv2hZCHAzrKC2evSa6FTYOYC4k19uv6IB4vy5
	vfdI6xokZcf6WbnUJfQ1735qYaIXiOylmEKOACgVvYyOpnWRlLzTlXd2dtApN6Le2VFLrRfzSWy
	/CyelYQQZEoLVSBEQsUgc6DE8ByY71h2nnWaT+50XhnlForJsKDH/ineJ9ScfUrT69fErFZ1qmD
	U4ckMLjrtMWxmnLqMVazXOkqmLq5RApt0ZdGeVVaQuGJHJV2raXRML8lXBR/sRcSqvi5cI/lfss
	ija3NKB12DCDyQllik4qHcJq6CF6xGJbd41kJ7i5vtPOlVkPjl4w==
X-Received: by 2002:a05:6122:1d0e:b0:575:56fe:574d with SMTP id 71dfb90a1353d-5bd69e10162mr8125733e0c.12.1782744264990;
        Mon, 29 Jun 2026 07:44:24 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bd9aed14d2sm2971741e0c.18.2026.06.29.07.44.23
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 07:44:23 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-966d7738c3bso2371124241.0
        for <linux-can@vger.kernel.org>; Mon, 29 Jun 2026 07:44:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RplqqpYeP9waVd9W66OZKYz1zk5XNy1pqlOZpRESxRE62tcdm9Q0bIBhLQuqUu4rbscQPiPxvmzjhc=@vger.kernel.org
X-Received: by 2002:a05:6102:41ab:b0:737:8ff4:147f with SMTP id
 ada2fe7eead31-7378ff41b94mr3107111137.17.1782744263174; Mon, 29 Jun 2026
 07:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625135216.130450-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260625135216.130450-1-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jun 2026 16:44:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXF_2HiWosZfsm=wVUN7C0ow5eFtOczQAoTzsNKDw_+Dg@mail.gmail.com>
X-Gm-Features: AVVi8CeObIM6aaBJ-mhYyAFRlYPaZfnGXmLPaP4HjXsOdJzbgQQdrv_VqcGn0JQ
Message-ID: <CAMuHMdXF_2HiWosZfsm=wVUN7C0ow5eFtOczQAoTzsNKDw_+Dg@mail.gmail.com>
Subject: Re: [PATCH] can: rcar_canfd: Change the initializing flow for clocks
 and resets
To: Biju <biju.das.au@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Tu Nguyen <tu.nguyen.xg@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-can@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jun 2026 at 15:52, Biju <biju.das.au@gmail.com> wrote:
> From: Tu Nguyen <tu.nguyen.xg@renesas.com>
>
> Testing CANFD on RZ/G3E shows that many registers do not reset to their
> initial values with the current flow of deasserting resets first and then
> enabling clocks.
>
> Based on the HW manual, clocks should be supplied first and the
> resets deasserted afterward.
>
>  section 7.4.3 Procedure for Activating Modules: RZ/G2L
>  section 4.4.9.3 Procedure for Starting up Units: RZ/G3E
>
> So, update the order of the initializing flow for resets and clocks
> to match the hardware manual, resetting all CANFD registers to their
> initial values. Also update rcar_canfd_global_deinit() to assert
> resets before disabling clocks, so the teardown path mirrors the new
> init ordering.
>
> Fixes: 76e9353a80e9 ("can: rcar_canfd: Add support for RZ/G2L family")
> Signed-off-by: Tu Nguyen <tu.nguyen.xg@renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

As CAN-FD on R-Car does not have rst[pc]_n, this patch has no impact
on R-Car, and I don't have to provide my Tested-by :-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
