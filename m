Received: from mail-vs2-f39.google.com (mail-vs2-f39.google.com [74.125.227.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A523D9DC0
	for <linux-can@vger.kernel.org>; Fri, 25 Sep 2026 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790325562; cv=none; b=I5G1/B+J7IvoSiQ0oBT17nFbR/8BBcgEG4WAfl9DsBKl28AvSKHdr5EVbKdPMrMGzDKWDB3EKtQ35SwLiiMU9Yq2zC26uB0uF/MBBQ9a4J/MUVOujv5I+clGDunGdIlZX3/rZBWPXe1CDiozhMaRufj+byhdws8+72O12XKpnH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790325562; c=relaxed/simple;
	bh=sLjamdMC2r3ak5IIhBPpuYPA4pO+dRlAi55DTGWziVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0Gu4tSHQJIzJzzMAsGAZgvpV49VfhYt6rtwQ0YkCdzrdFDVf35IH8Ae190KkESmCR+6g/AbFLW94QZhKbfHwvFvnBY/xcvpgd0iqwfmDUuj2q/wrdnRN8h/6IJPiEY9svFZ3Cjma2wPV+0GNZhTawXvnpWn8unj3C1VOlg8J1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f39.google.com with SMTP id 71dfb90a1353d-5ccf4f65037so135345e0c.2
        for <linux-can@vger.kernel.org>; Fri, 25 Sep 2026 01:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790325560; x=1790930360;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sFBfiwCenTJuFLJhWULpwFEhb/dZKIf7325w6H1c1yE=;
        b=Oy3TFCzGrHP2f5z1bmdDT6TimS9t/JUp1flAr+ajMLNWzxBVCrt94Tmv/bO1hlp+MW
         hAdpRdwOlePoPkZJgKKEUBBhhkX+wgeR8cTgYTkT5BwsXpCyNbkqtjqS+jeiFMwh3fLf
         klukaUn0F5V8JCPlg2Uxvc987ilGNnGDb/gDeGz9LInjdlTo2W20aEWM5SOjyoIO35Am
         1uuTBHIZY+S6/WUpjz4h2Y7oenjIUPzeIdsqv4p5yPJoWpHHPtpGK61HCa377PWy9dmS
         Yc/0wYlJb3mlCes6CojdCeZ4JdAkzJLFOdQ+LD99j8YYWE5gfAEPWHqvH1OZrI5DG1Bi
         5ygw==
X-Forwarded-Encrypted: i=1; AKwUvBxKuZuQwhmy1OUa0KPiKqUP9UArMfBnncAy44er0SPO6HRiAkmmJ/rWfl1ZM7RbNoVTBCL+9zP9eZM=@vger.kernel.org
X-Gm-Message-State: AFuF++n8AsWuPM5Kx4yO52tTbB21R7FbRT3YPeHryezbPpoosjlTQkX4
	6X0M4jR6jJkX4AYYmOnmCWVI3CgVSbfAx4RdOrwXOfzKRbTqmtfpc4tbnYV7s2sg
X-Gm-Gg: AYBFou3VCRzK2FUGHa3asa7a3OhKHFIh9OIUnrU5ud/Rci7HFsLs9IK7gbgU/TEH14h
	6lChkfAYHwLwDSKXjWP1ce+IXkvOqJ5WChm3fBYKNGLSjZBap7eZQR3NV+9McqMliFMNb5y/Erb
	CtovHj7PTB/TBbrmBFn8ghC4La0jCAwfPBMeyohU3nXof1I6M/x+KmPrCEn0TAXqOcn0Vzai+Em
	0SbKCMNxe1dJj1aIxuzi/WX5mOok6hdstZP7p4XAM2BGqQ0Etc4xnV3zZB9USFxgbMHb2ukoaUb
	MgMfu87M4VGWsa78yYgKAXDxYDSh3ykOzQ6Bq0vM/9aPfquzXsWu5mYnXYUIuEgvzDGxVS8Tmvd
	bndjvDXicu2r+UHjKQrexsXvyURxMqzzDmU2vC95IhnqbzgvoKqpEBte2VwaXzFBJVvGUWDJLf2
	OuhlT26Bwil1o8FrKlWv7USzG51KF76oANjZxl/0QTwpcun4yYJI+wk+D0bbB1J7XsrP3hjsL/x
	iq64gyxD3sLITx83oYJQq4LP2VPh8lhAoud3QdvzpsGQnjx
X-Received: by 2002:a05:6102:4b12:b0:7a0:eb10:79b5 with SMTP id ada2fe7eead31-7af1ce99024mr2625453137.10.1790325560252;
        Fri, 25 Sep 2026 01:39:20 -0700 (PDT)
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com. [74.125.226.204])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b2588a1551sm909240137.5.2026.09.25.01.39.19
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 01:39:19 -0700 (PDT)
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c7b4ed1so358233241.1
        for <linux-can@vger.kernel.org>; Fri, 25 Sep 2026 01:39:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxJrxAvsCJ8wQOq3PVji1pJXgmsJ9FqFHMvgl7PzXQgs0BMwkXa+r3ir5xculx0a9MTfRfamak58rU=@vger.kernel.org
X-Received: by 2002:a05:6102:441e:b0:7a6:a24e:811f with SMTP id
 ada2fe7eead31-7af1c79966cmr2662746137.7.1790325559708; Fri, 25 Sep 2026
 01:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925082134.146015-1-biju.das.jz@bp.renesas.com> <20260925082134.146015-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260925082134.146015-3-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 25 Sep 2026 10:39:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXxtw5-AEMfGxMLVAL7RPY5Gy6VQC-3TdD3Ydr=oc6n+w@mail.gmail.com>
X-Gm-Features: AclHuK_EqT9YgEVg0rKL_WGjxUVTb3OgvMn1hx32s9Yf0cSbz6LpWhtNAKIKLCY
Message-ID: <CAMuHMdXxtw5-AEMfGxMLVAL7RPY5Gy6VQC-3TdD3Ydr=oc6n+w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] can: rcar_canfd: Derive max_channels from the
 device tree
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Tu Nguyen <tu.nguyen.xg@renesas.com>, linux-can@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Sept 2026 at 10:22, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> The maximum number of channels is currently hardcoded per SoC in
> struct rcar_canfd_hw_info. Since the DT describes the channels as
> child nodes of the controller, the count can be obtained at probe time
> with of_get_child_count() instead.
>
> Drop max_channels from struct rcar_canfd_hw_info and store the value
> in struct rcar_canfd_global, so it no longer needs to be maintained
> for each SoC variant. Update all for_each_set_bit() users over
> channels_mask to use gpriv->max_channels.
>
> No functional change.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * Added check against RCANFD_NUM_CHANNELS, to avoid overrunning the
>    fixed-size rcar_canfd_global.ch[] and transceivers[] arrays.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
