Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793106501;
	b=pHDVKyqIt3o06YXwn6tXnZFhRGnz9YKXHvrheYp7riqmi664l0ukj6PR3ugw5KLzSO1H
	 REs74HWCCwOy/5iNFIqwtemT/OHHDtbex4IGxaBSI/ZGscowAr+U6wZp1zRHXrS3aIeAt
	 hkSmR5BeAqa8UO6ApVaE31dFa1PZFor5H/J7sI/C0/jc8esQ7YNheOzKOS3huER+VYPoc
	 jISpSleFrNlpjSD9A7JHkci3j5P5LHV6RtSXrR6sE3rR8UWzHwP4Sj6kaWB2Dm8yWeO5G
	 lONeSuwgyGXhA/eb6UoyS7bdZp+IzVSto4EhHEsNmNm9fZ+z2trcmZXiwlU+OnC4xoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106501;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=U7ew36HJM6zDx5mHnsffxLmpBzrWBOm6UtQ1gw6Z4X8=;
	b=G2mQ36vjj/l60kSzGdbkQUFz15L7uvMHarvgHcKlootOcAo5Olvf9W1bVG3brxfRSsXS
	 0Twc3sh+IpOmkplkN/co9C9BvEbkpkCPNj8MwUJboO/Encv/ptf6viFP12rogAuWi/51P
	 QshBV4rphTL47+TmZpGhz7Xq+i/Ga9MezJBHxKYI6WL54PA6oRviqYg5SbmFXYxGbp9UO
	 vxGakSgKZZNAoInhGtjhBbtDIxdDJIRJuqJhX56FLXLSSLkY9E7/WdgZh/HpCZJoa5qEn
	 U4I0ac0L/Q20Yw4ihLMhlgufNC+C7Zy6UilfpUMFItecPpbEf45E+FGIpIvXXDq4IqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=VqVUGL14;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE031606A320
	for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 13:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE031606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=VqVUGL14
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3a98fc80925so43126161fa.0
        for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 06:08:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793106499; cv=none;
        d=google.com; s=arc-20260327;
        b=o/eIYJye7o56SXOysc5NUXsVGNo8Y4QHFhhP6ZK32HYtUfIk6jALCjmuTaYgGdiyjl
         w/pw35avg77iGKqjdTjIA6rGyVKxsMwTXdhV1DTXkhycwLtQoZ+mW2EgKV6mYRy/ivQv
         XqC8P32NvIjv1OSbbnIFuoMty0NSZ06GO1ulowBPJ+xp35+zZ64gP5WN5SFKSSpH+Zxy
         UEQCvoi7xLm6D3+YweDpFBD8bLq5+z+S0zrum+mJ9tJU+V0xopYIPT2p4AfxNaU6hyze
         KVINQungmaxMqxuSTeu7yF3jq5ustNAtPXB5UEU0XzGQEJm56smxsnGT4fHtR3OhCHc/
         lFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U7ew36HJM6zDx5mHnsffxLmpBzrWBOm6UtQ1gw6Z4X8=;
        fh=UDmiFjDUsl58/oI1pbxKLXmAuoEiB7qNSJQzd9c7Gr0=;
        b=XvbxZPNpS2kInHnv7DywBfDNXsAZ6y0+VItmiXOsIHT2OfxnYc96hXOpdH/rQgTFwA
         x7d+h9BUUFwxYa17OO4Ic79nNtavikNkxRH9pn+u6MlJQTzEK0imjtg7LLR4u9kxhBgi
         rkyz4AOJIT35eJ2pD3uwmhKcgCLrijQWCeKZLXkjydMYPQmMNHK/Giwj/ddYihlbZFV5
         SSJP534THpLKIu3dl8c2KJ2XpblAyAePwar5gYgaFQ6GpmA53TpM1laZ/IX5YuwHkRdE
         28acjW92s0t7ykAdygdtjafY4YVhfAibGKEBNraWlfLeV3u8Y+RoeZCJvt+/yKoSGTPL
         1bMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793106499; x=1793711299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U7ew36HJM6zDx5mHnsffxLmpBzrWBOm6UtQ1gw6Z4X8=;
        b=VqVUGL14khAihKsj0bwgdaSWQz8h78TJDitcJbduU1Vilf4JmeCJJuZ1TZvq5/VzE3
         EP9YJY2JW7yhoBPZ5QT8P8Y2tUUxgbvCt5VCp+pImadZvC3cwXjGcl/15tS5hSU3YzdO
         kLcxnR46xb5V3hcHrALUS2teOfLmAmITXzORRMx/kiOijauxqnNcknqgGaqIiIetdESF
         a/hsNO7QYc9bCYnWRL9jAOnriWeVzSikHhEBUraiNddZTSjvsZQzdzFhCVMYwW8tMhXX
         WsnHYX3ifY5Ja7eBCcHTeAIK08/BfvQ1sivg6ilVih7/ybrJz1SVN6vNIrOucM8jGaqy
         MX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793106499; x=1793711299;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U7ew36HJM6zDx5mHnsffxLmpBzrWBOm6UtQ1gw6Z4X8=;
        b=OXCx4C6KbrIN+lmEuiUOW0/vKhLKIHztgJ2L33/d+z/2LWLzX2XpHdNRh4bv6MEoz5
         epbvVE5Pe9Bezlu6GI6zvAFj5AAqtfAd5NRcxJLAdYx7VhOAN0AygQAFTjR2lqKT+xZ0
         PUkI8QkSK2EmuwOkjeazFZYjj8d1cEwSB7Hxwhtqb+oDLxv6tPF0ecZK9gYsQL6tnRG0
         y9chOxe3qnLSwWyAwCjnOtRP+eWEd2MmBsPRt0K5hDMsu5tpiv3SYNsGXDykYFuUW9Fx
         m9uiWZERLuTachu0Wa3aO802JI9YBkgODW/x2LUyFMsJxeFuY+bYxNnjhY3sHSijuKT5
         1SDg==
X-Gm-Message-State: AFq9FYKjj0VTegHpacc1akA2N8mEqEwRlG4yzFCYg2Dbaxw+jFRKCzAt
	CqdBqxKCGz7L7wf/OENsONw4khuXqmePqpbmo2AIxl7m122cqwj79mba2znrJvh1nJjzmv/9aC0
	lx03hHFhoQNwieH+VcWKZPgIHPZ/0Ce8nCtBJwsIRDvw=
X-Gm-Gg: AYBFou1sn0apruIfvQL2f5sEGN+YotI6bl2QDGGuJ0dY8X4DVCk84qaW/sdy6W5YpP2
	xN/CHC5UedTf+dWOJXq0GXLBsPtdczQYYOs/mGQECrrd2Z2bnQrbLUgDDbCsKJzTg2hV3wpoX2/
	r+jfsVrzy/H2uH1VUfoaNAOUbBaeojwwVcfeTQWzCcJ2avaYYgG6BnGyBQhxZ6blJ0DPH/2hBSx
	NIC3O2qse1k4ljGVZY0TPplKcOhTvfCp4PBfhmHqM2uMhdBwLlzLvn2+oaLLnRTFUM8Yq6+OfHl
	NzpH9wzQz4d9dadidtl3yU5vRVx3S4ySnVRam7zgNUFWF38QbbfhAqRUynp6MB1OLNZeDzKde5I
	ky5EOecQm9qshhSMVkPNmN/SyC8dQBBU+ZeukRHB7Z87fTKePCZJVSC+dcFc7qwafKnY=
X-Received: by 2002:a05:651c:1612:b0:3a9:9b74:1ba1 with SMTP id
 38308e7fff4ca-3ac6fd15170mr26419661fa.8.1793106498024; Tue, 27 Oct 2026
 06:08:18 -0700 (PDT)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793089479.git.zihanx@nebusec.ai> <92fe9d7fe3a7daa2cc7de740b15ec7eaa0638b98.1793089479.git.zihanx@nebusec.ai>
 <sashiko-outbox-186443@kernel.org>
In-Reply-To: <sashiko-outbox-186443@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Tue, 27 Oct 2026 21:08:04 +0800
X-Gm-Features: AclHuK_ELhzBMIBLExUxogl5p-CJCzI9z5rBHeQ0PDed3j7Q617lXXHvExqpqzA
Message-ID: <CAANe3eSqwdmMb43pK4cBx7syOrQkqUZSJo-WnW9iZx2Qg6BdSg@mail.gmail.com>
Subject: Re: [PATCH net 1/1] can: bcm: limit RX operation resource usage per socket
To: sashiko-reviews@lists.linux.dev
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Vincent Mailhol <mailhol@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 7:29=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] can: bcm: bcm_rx_setup() returns 0 on frame array allocation f=
ailure
> --
>
> commit 3aff0eb4ba8d41c989dbd64aa48ab75c3eecec89
> Author: Zihan Xi <zihanx@nebusec.ai>
>
> can: bcm: limit RX operation resource usage per socket
>
> This commit bounds the per-socket number and total memory allocation size=
 of
> CAN BCM RX operations, as well as the number of pending RCU receiver
> callbacks. When a socket reaches either limit, creating a new RX operatio=
n
> fails with -ENOBUFS.
>
> Link: https://bugtracker.nebusec.ai/f/11134
>
> > diff --git a/net/can/bcm.c b/net/can/bcm.c
> > index 3d637a1e0ac1a..96d3f050dec54 100644
> > --- a/net/can/bcm.c
> > +++ b/net/can/bcm.c
>
> [ ... ]
>
> > @@ -1425,26 +1518,22 @@ static int bcm_rx_setup(struct bcm_msg_head *ms=
g_head, struct msghdr *msg,
> >               op->nframes =3D msg_head->nframes;
> >               op->cfsiz =3D CFSIZ(msg_head->flags);
> >               op->flags =3D msg_head->flags;
> > +             op->rx_mem =3D rx_mem;
> >
> >               if (msg_head->nframes > 1) {
> >                       /* create array for CAN frames and copy the data =
*/
> >                       op->frames =3D kmalloc_array(msg_head->nframes,
> >                                                  op->cfsiz,
> >                                                  GFP_KERNEL);
> > -                     if (!op->frames) {
> > -                             kfree(op);
> > -                             return -ENOMEM;
> > -                     }
> > +                     if (!op->frames)
> > +                             goto free_op;
> >
> >                       /* create and init array for received CAN frames =
*/
> >                       op->last_frames =3D kcalloc(msg_head->nframes,
> >                                                 op->cfsiz,
> >                                                 GFP_KERNEL);
> > -                     if (!op->last_frames) {
> > -                             kfree(op->frames);
> > -                             kfree(op);
> > -                             return -ENOMEM;
> > -                     }
> > +                     if (!op->last_frames)
> > +                             goto free_op;
>
> [Severity: Medium]
> In net/can/bcm.c:bcm_rx_setup(), when creating a new RX operation with
> msg_head->nframes > 1, err is initialized to 0 at the start of the functi=
on:
>
>         int new_op =3D 0;
>         int err =3D 0;
>
> If kmalloc_array() for op->frames or kcalloc() for op->last_frames fails,
> jumping to free_op without setting err =3D -ENOMEM executes:
>
> free_op:
>         if (op->frames !=3D &op->sframe)
>                 kfree(op->frames);
>         if (op->last_frames !=3D &op->last_sframe)
>                 kfree(op->last_frames);
>         kfree(op);
>         bcm_rx_op_uncharge(bo, rx_mem);
>         return err;
>
> Doesn't this cause bcm_rx_setup() (and bcm_sendmsg()) to return 0 to
> userspace instead of -ENOMEM when either frame array allocation fails?

valid: failures of kmalloc_array()
or kcalloc() reach free_op with err =3D=3D 0, causing RX_SETUP to report
success. I=E2=80=99ll fix both paths to return -ENOMEM and re-review the cl=
eanup and
error-propagation paths before resubmitting.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793089479.=
git.zihanx@nebusec.ai?part=3D1
