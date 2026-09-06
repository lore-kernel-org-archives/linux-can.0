Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D472621
	for <linux-can@vger.kernel.org>; Sun,  6 Sep 2026 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788733182; cv=pass; b=hDNZ+NxQOCUsnXOm9a1wSCR5W5d6HYhgMGbLk132gu+b5J3iTyh2Ygz5pWNhFZ15xcSfJWiTN04vLtjDIYdQ1/DZCD8r2fdedmVchA52CJhW0Fc39fXGdebdfMdwd+/D9hGSN9nygIcsGB3iYDOrhtjGDuUC6d6MFImyU+XqvyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788733182; c=relaxed/simple;
	bh=TYQn8U4IyeaYeTAKZpJ29Jiy5z5Xq4OGVqWutqQzq/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrDxgUerjXVqtdaFdC+p2fusz0u+80w7kpo+yHe85nX9KWcBi5MVoN89r2ZTJZQ0LRDSFL9VxQwy6emTdRXP/+VLaySCpC5I8ByrDiAWMF4qBqeZ484MOMBrJy8annHsBmfU1Z9Lziz4pMKm3N+B7llcX07XHhly4lQtUe6FaCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=EGy5YOJS; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="EGy5YOJS"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d6f9e2f681so31825705ad.3
        for <linux-can@vger.kernel.org>; Sun, 06 Sep 2026 15:19:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788733180; cv=none;
        d=google.com; s=arc-20260327;
        b=NC8jEZJ+2aTFqkIPLSHeXd6tqlna/9PUjyql3PEX7g22KMsXlrmetqmas2Sz7HKGAl
         NpUAoP7jtfO6VhEkVwjjmBgjJHTBk/bJ9/3H8t7rfAsVHJ9SZWvJH+W4sF6D98Fn5YQu
         nqw+ECWbFzws+G8qa0LFYmq6wSAJJgliCZJlDlXwi0cDvmNnAsfMICEuJ+hEKbsOOUii
         NaNh66cEXBTiwtHvyn7PcvGofHYwKGsIANXBhbSXOiU5SmOkqlguwuy+tOnvkv39BW6H
         QWxQBP6XCos25C6pdln39b75edfiTR4BmCtSMR24OjEYTN3Z/LdcZKxpUZmD1fjhIMkc
         a6aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j5H7v1iDtpUxbbmGGJnlO1vSD1KFA2YvCAej4f/7MTs=;
        fh=CKdXdwa06jGGGPA38e+IvEfgEvjHlSPJ8fLBZMcAjK4=;
        b=HslyboC17Hh3V2hSjGclG7VPiYNE7psrxIdfUgaAb/LY7sQ519w/jIuZI0QiAya2BC
         agiVUAugG5wYPJ3tf2/pG9Otz3JNJW4OYG8WB3FMEYFfXfSz58TNqP7E2TNXQsx32/B5
         axDOYDRtRB6/l9S/RdcC8WmQiwqbnUfCcu8UwQRM0Fo40s4b1LXQTq2MOjpzvXKUfGq5
         QGmdbmHLEsMLnWurFjAwNLlat4WFfckciecI0wq7bYl+ZcivZP4FHOb/VnlRzqPmCWUA
         rpDkd8tv0lxSXQ7ZbCWZjUhPefKgnmGZzccgkkz7fKOQxgt5OmpOAKj+jj13j6EXmP5c
         s4tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1788733180; x=1789337980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j5H7v1iDtpUxbbmGGJnlO1vSD1KFA2YvCAej4f/7MTs=;
        b=EGy5YOJSvuFB8jyT6w92SG5LSKLR5woX2n8cO/0tAdxRYC9J2UivdFLyA+VN1ixp17
         gq9XGar5jgGIvMJKjAmd8DISkg0nQDO6jyO0i6N63cWrQIVALSKmtp+BVeIDNrnKD9AY
         2md+AoQxJOG9ghsP8+/FGwWBslsNkoj6hzVjT+QQEubtIGJL7xN1v1VBbIdVvRWjGR7q
         rXBxftr/ArIUkx++E7LlIqOstoDt3DbbWVQmePtGgAJWeJh1DhABtDrzs225q2pBbsBP
         DKY1QZ9/jXhQeCHI1Rk75L7x5v9mtgrfL1rqiDVgz8iTK3nI1moppHmclk46XCRRZNJM
         DwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788733180; x=1789337980;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j5H7v1iDtpUxbbmGGJnlO1vSD1KFA2YvCAej4f/7MTs=;
        b=igpq8uqYa2QtdlZzmKARSgkBPI22HevyXbTusQB8jfd3WprNc9qY4Gru2fnLcDVRWK
         NA4ZxxHA3gBWU/G6xUYrlW1YuKef+1CqLg2gn7cWconNcMCWKgXArcOvCTYicQZN1+a6
         T2hGlyvFeSEkuAQvNWN1g15cmzkS5GKsJ2FGm628/WJ42k1KooycZqdv/hvF9+VY+tPf
         i1PmbsJejsSw70sRKM4I14hjQEaKwAFh7v768YI2m+SZepr/vMFDsq8QiTxvdCFwvvVY
         XP52GWMh/Mm3Zh4McixuFtxwzM/vbxaoKv/+29nx93mzIA9kUFQBQA5ty8TKft6ZYPN4
         l1Xg==
X-Forwarded-Encrypted: i=1; AKwUvBww7JL9R5+gKhgypPAF6Vuz+SPI6rfYM4okPFw4tciQnBbQ2N+TU2pSTb6bA6qbF3URMRT0xm3Le8U=@vger.kernel.org
X-Gm-Message-State: AFuF++kan02Cc3NMGrLfRus5DdgiP0lpyCgiQbZcfpIW+Gd7yk+QSoDN
	QSR2PI8w5j/GcssxG3EKAEKdG9XDVuB8knlHTBTFHXp88LW8pLC++I5JMp4DwgA+yjHdJAQKlUq
	fz7e87OM8x5o2427dAXOwG4Ejk2fe7gMxYwDEJNAv
X-Gm-Gg: AYBFou0Z3B2aAl468fYeqp2JRolSJ3pTXK7+qnZHmA6wB2CsPDVoReyoS3JSUKTpApC
	7HfZkOIyyw/wBrW2RQrYVXwbwnpOrISCSEtHZ1ntlZ5Sce/T/fm1/IML9J4huVSP5tV9wd7pR99
	G7BMMJTTpyAx0K4aqTMcuj73Bf0oF6UF+oPQf2zk801yy7bsCU5/uFq7wLoK5GuvjrKIvruy6a+
	0xUX3rPbn89MDE2O4Yssp2o9KDh8jj36A3uLfBv2FXE+in4tAdna289tPo0gzleP4V5jF3OQNPs
	bSBmHgh4elPcQurYNXN/C8pie1d0DtH44BGuE4HZVNVEufVUkQ6BeOp9lUtpgfl0FRUy5dccIcs
	=
X-Received: by 2002:a17:902:930a:b0:2d6:e074:9cad with SMTP id
 d9443c01a7336-2db1236f4femr196043825ad.6.1788733179884; Sun, 06 Sep 2026
 15:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <upsCxxaJjg2FJWhfCx6KjFXLlh8o4IhaHKJi@bugs.sh> <CAMuHMdVVqfqvueX-jk_XfM5tE9XScZPe1OLqGw1MUC=Kd2reBQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVVqfqvueX-jk_XfM5tE9XScZPe1OLqGw1MUC=Kd2reBQ@mail.gmail.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Sun, 6 Sep 2026 15:19:28 -0700
X-Gm-Features: AcwNN1Vz2MmGcMLkBJ7T2ybLOOTijDZznSrnrJaeR0QSfMiYaCeeiqBLLSIaztw
Message-ID: <CAPpSM+TXw-BGgpdZtx-bH5GEQvzYHxj_wDkdPfUT3Tcn=mtmEw@mail.gmail.com>
Subject: Re: [BUG] drivers/net: out-of-bounds in pcan_usb_decode_buf()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: co <co+5e2bcf11e7027510@bugs.sh>, Vincent Mailhol <mailhol@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	=?UTF-8?Q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
	Oleg Nesterov <oleg@redhat.com>, Biju Das <biju.das.jz@bp.renesas.com>, Song Liu <song@kernel.org>, 
	linux-kernel@vger.kernel.org, cedalion@bugs.sh, linux-can@vger.kernel.org, 
	Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 7:04=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
>
> Hi Co,
>
> On Fri, 4 Sept 2026 at 23:17, co <co+5e2bcf11e7027510@bugs.sh> wrote:
> > We found a bug reachable in:
> >
> >     path    drivers/net/can/usb/peak_usb
> >     crash   out-of-bounds in pcan_usb_decode_buf()
> >     commit  2f1baf1fc892 ("Merge tag 'trace-v7.2-rc7' of git://git.kern=
el.org/pub/scm/linux/kernel/git/trace/linux-trace")
> >
> > Config, environment, the sanitizer report and a C reproducer follow.
> >
> > =3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >     If you patch the bug based on our artifacts, a tag would be
> >     appreciated:
> >
> > Reported-by: co+5e2bcf11e7027510@bugs.sh
> >
> >     Everything in this mail is validated by the reproducer below.
> >
> >     We also hold an LLM-generated root-cause analysis and a candidate
> >     patch. The patch passes an A/B test: the same reproducer panics the
> >     unpatched kernel and runs clean on the patched one. Neither has had
> >     human review, so both still require validation before you send or
> >     apply them. Available on:
> >
> >         patch.diff  https://bugs.sh/b/5e2bcf11e7027510/patch.diff
> >         report.md   https://bugs.sh/b/5e2bcf11e7027510/report.md
> >
> >     This is an open science project. The code and the full set of PoCs
> >     are not public at this moment, as we intend to disclose our finding=
s
> >     in an ethical way.
> >
> >     Happy to test patches. Complaints and suggestions about our work
> >     are welcome at:
> >
> >         cedalion@bugs.sh
>
> Please read Documentation/process/submitting-patches.rst, especially
> https://elixir.bootlin.com/linux/v7.2.2/source/Documentation/process/subm=
itting-patches.rst#L928
>
> Thanks a lot!
>
Hi Geert,

I checked the document and the related files, and I apologize for our
mistake. This email should not have been sent to you, as our system
failed to identify the correct maintainers for this submodule.

We have fixed the issue. Thank you for bringing it to our attention.
If you meant other issues, please let us know.

Thanks,
Xiang

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
>
