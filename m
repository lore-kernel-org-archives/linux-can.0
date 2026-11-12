Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794467913;
	b=xoxmZumsqcYOd0st0ZSTiiflFsmYL/Cn4v4M7e0P0LFhGVccAsmgy/ioEqrQJe/yCkcD
	 ZSufux/vFL5S+FxaTfMO9bx0a4xHRPhMrfM8trxiEwF4BOPEfCzGM/NPKoz2MqmqE9x9y
	 tpSoN/B6PyNk2zRcG7+tnB82+6rNWwmDX932L9vV8muOQaxxb60kSyLozCdOAA6ng0ERA
	 MPQ1CmHue3PGI35zcNmi+ggLHf8ZjrLNQu27IOJj50gR88B77piGGKVC3Tsz6okOq07fK
	 p9v1SQYcOr4/Wi0/znXzR+Hmf4KZ2X4JFUGZ8UxcnPRPNdJZjOfdcPvti9kN3+DZkZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467913;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=REChCuy6FdBNhfnjUQfWWgT6NMEdKOk89wFXRsMuVnw=;
	b=gRBv+AF0WGfjgc/h6mgAeeLVPN9xpZyqfdmgDli/JnnW92jPxDAL6UXsX+TBJqRueUtX
	 wVSaM8q9b4AhXgZvustpoZwX0v1YnWfVH6r2yV9GAmuvOT0kwy+Jmw3tvLLA1V3Zz7NLF
	 C2jMLr4bcqILZKK6NQWehQ+7mn/ublHkmt8YJNl0NBLfKbo062q5Od5hng5MEYka/75Ti
	 Cvb5I8pP2w9Xi2xR5jJ9B6f8vdOCV9xTABSfxwq8AvEElrJvU32MQEaEodK7ibJTc3SRB
	 PxjHv2Lf7mrKOSrgFT8Cf7lWQS4r5lgVm1b5CqD2/7DGJZO+RbinSchcxiSWEAiIUuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=g7PD3rtz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E9460A382C
	for <linux-can@vger.kernel.org>; Thu, 12 Nov 2026 07:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2E9460A382C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=g7PD3rtz
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3adfc004920so32229561fa.3
        for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 23:18:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794467911; cv=none;
        d=google.com; s=arc-20260327;
        b=fH+oAmkA6+uo7SJvNwqglFMkvkMMJy/tnP6P+5er1YiW/DhpMrnNHy277yZVrJeI6u
         XNY2nyuA2yqrJnME0ZVNIrlkgxlNlhsQz91JIHFSnCtih2F6hSzkP1VErCzpJ3gGgNxd
         9CF54dq620vCXEGvwDoBOZf9CIWO9BSAcsfb1bnYTG6rrx8YCiMRbKPftR4kEELE2UYd
         K+Phn3ZGftbpt5oZvdAJv82reWrLZS8fBubhgyv2z837mYfNPwepfvaVEToZEoUpMpwr
         zSHRSsWWCOKzaoP8O4pXt7KvTk8dw8TFrnjPMhhc57AkQQyXB86/hqGvt4LkQ40tV5PZ
         NrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=REChCuy6FdBNhfnjUQfWWgT6NMEdKOk89wFXRsMuVnw=;
        fh=uPqm4MlwCauKHF6PbY6Pl3/Db9FuGK3NY0aLh/sxkww=;
        b=ME/lmqW7uMlMXVX76CcUZsA+V65g7Nv2GAgtVJQSxUiwUcM2t/todNRiopAeWDT2Wa
         g/YBUUBNMdlxwxoZVENH270c4LgxJEDw4s2udmJAQccmr45GbUdZdnIZ1jxB4/SHT3P3
         sYzLywubvUoKZ2gDSyr/R0LFi891a0rEqpuBB5uaTEBKeEAjTLqevrGDFRQ15mb51Vdx
         m2ei7BgImyqAVv/bvmS1viDcEiWg6Ma7O4asg72IJZA8lEritSoB7MBimr7AX0JRFCdk
         ezAqY805EkLHSdMr33iN4nqDRUwd7LN3jON2O0zvrhBCcEmkEnOZ9C+Wai0UAfoJuncw
         55tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1794467911; x=1795072711; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=REChCuy6FdBNhfnjUQfWWgT6NMEdKOk89wFXRsMuVnw=;
        b=g7PD3rtz1cGpwmnGuR4xHeHp1G3sYARi73LG5l1w43EBy3FYi6RttNF8rtyjNLlymU
         EQcpOXW4asfw1TIVZHzxSjdhBtEOvrsdvOAEl/+CefHgKnzRI90evR76ICx3YfQK9uKl
         f0XoSSGw7HTNu5QFztXAARd2s/fD7vBQUDT2js6C/SgQr6Kt6XB09kCvmi0ADY9rvtIU
         XHJvDpWDhgM6bmHQsLfdLg1V+xQp/UjNAzlqidujdbsM1NRm2LY2aRx3tpYFXuJhvW/I
         ubXbLDJLm2aASsfkhYQ3UgP6NZf4EiHjbB3Bi3/01p+xtpqNtH6Aih+Qa44eAY1ql4QJ
         f0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794467911; x=1795072711;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=REChCuy6FdBNhfnjUQfWWgT6NMEdKOk89wFXRsMuVnw=;
        b=NKmStwPf3dOXiAvJQCATw96UQE3/dZHz8UODuYDYaxIpLkZ7Cz9GqYgIkTBwLTlBAU
         +LrsxXZTL0RQxsGphmtQJGthoKsNex8sKfwXh8wWXexJsdp6rCadY67JkCXUaDUuRZ35
         gtjbYnVrL+O1wOCztgEiVTJYuNG5kCnhy0+7uVIPKCFw3OXdR7gu1L+ikgg/cW90gYvw
         xIEZwxF4zhNPOu4FnUg8Isq8NSYe4iAHG1YVtmq5dQZu7jrWXSwKEn+z1lcpIGrofzoh
         ALkklaApYahDkO473OHnjE9hvQHpw2+qBuBhxKHFWyyXGP24eO2r7/bE65Q3/bmyrQ/J
         QvlQ==
X-Gm-Message-State: APuU4Z8/B3Evs7mHBMR6S3mcTOGQu7dGCXIcMmOMCvUulSkCAdagjgXJ
	S1jKdpd5AcPePORuMagu/q42rhBJHudTesHCZw/RJ9KjQ9R6AB5/vwoHrwRYOq3w4kPOKdLVHFb
	8bYIuQ8s7EnQVeKeqNqTNoMhK5LQuF4wJhRri61qJpeE=
X-Gm-Gg: AYBFou0y0v52VpAqs2OEnUKZkO8RQlVf6z5HRfVlSxjcbE/MTWGTAsmsd/gcGeQeL3g
	h2bmW0uMwZbHs3Y+UnDn367ultpTvmirfFn6YXL2WdsYaJKXsQwoQxCDZvmEbTn+Q+VjcNAoDgY
	cfUVQZsSO+wpIDRn8oy7kY7YLN9UyddwY68LuLhRkWKBxi5J0xo2k1/30IIC0+7sXkMDgurXtta
	3MUZUGKcCplcQHFLLle9vOpGZzYrKLZPD7CqxbF/WAyssb9gspBD/dFCWBm1NfjSUSDc9J3r7AZ
	CW4c0zjtuB4cGTRghLUZErQcYmW4FmUGm/ZqjHUljZ2rByaHQvi5NkF00iN5mK1QoBlsZTGFYZ8
	+68rjs79csnsqSDIxBbY/ruHJkfWKPAOhA3DNL5hF099kHk6nJtfDrSyDEDm+JL+o+GeFhY9iun
	6AW4je2hs3Mx1pcwaqe0nwVYy3J4XX2yz12pjG6TpnM3+LB4VUNw==
X-Received: by 2002:a2e:bd08:0:b0:3ac:e26b:d9cc with SMTP id
 38308e7fff4ca-3ae126ced96mr9601081fa.23.1794467911016; Wed, 11 Nov 2026
 23:18:31 -0800 (PST)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109131624.276943-1-zihanx@nebusec.ai> <20261109131624.276943-2-zihanx@nebusec.ai>
 <avQCxNIDeBaTsX2c@pengutronix.de>
In-Reply-To: <avQCxNIDeBaTsX2c@pengutronix.de>
From: zihan xi <zihanx@nebusec.ai>
Date: Thu, 12 Nov 2026 15:18:18 +0800
X-Gm-Features: AclHuK8IIoBEKAHzEp5N_p1hiYdWxp0RYHF_i1RV4mZc9CpDq1b1kOx3PVE2r4U
Message-ID: <CAANe3eQGFX2JG+KRBjW-vDBhY7gA91Fg5z19Rk-cc6_8hxT_Lg@mail.gmail.com>
Subject: Re: [PATCH net v8 1/2] can: j1939: account for timer references
 across rearm
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-can@vger.kernel.org, robin@protonic.nl, kernel@pengutronix.de, 
	socketcan@hartkopp.net, mkl@pengutronix.de, bst@pengutronix.de, lkp@intel.com, 
	maxime.jayat@mobile-devices.fr, ecathinds@gmail.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 1:53=E2=80=AFPM Oleksij Rempel <o.rempel@pengutroni=
x.de> wrote:
>
> Hi Zihan,
>
> Thank you for your work.
>
> To avoid duplicate work, please take a look at this series:
> https://lore.kernel.org/all/a1dd9760-7815-400a-a39c-a1a03cf8262e@I-love.S=
AKURA.ne.jp/
>
> and sync it with Tetsuo.
>
> On Mon, Nov 09, 2026 at 01:16:23PM +0000, Zihan Xi wrote:
> > Rearming a session timer updates the existing hrtimer rather than
> > creating another callback. Taking a session reference for every start
> > can therefore leave references behind when the timer is rearmed.
> >
> > Track one session reference across each timer's queued and running
> > lifetime. Apply the same accounting to the RX timer and synchronize
> > rearming and cancellation with terminal state changes. Arm the simple-T=
X
> > echo timeout only after a successful send, and keep terminal session
> > transitions from leaving stale timer references or changing the result.
> >
> > Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Link: https://bugtracker.nebusec.ai/f/11143
> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> > ---
> >  net/can/j1939/j1939-priv.h |  11 +
> >  net/can/j1939/transport.c  | 510 +++++++++++++++++++++++++++++++------
> >  2 files changed, 438 insertions(+), 83 deletions(-)
> >
> > diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
> > index cf26352d1d8c..123622c82a98 100644
> > --- a/net/can/j1939/j1939-priv.h
> > +++ b/net/can/j1939/j1939-priv.h
> > @@ -10,6 +10,7 @@
> >  #define _J1939_PRIV_H_
> >
> >  #include <linux/can/j1939.h>
> > +#include <linux/spinlock.h>
> >  #include <net/sock.h>
> >
> >  /* Timeout to receive the abort signal over loop back. In case CAN
> > @@ -290,6 +291,16 @@ struct j1939_session {
> >               unsigned int dpo;
> >       } pkt;
> >       struct hrtimer txtimer, rxtimer;
> > +     unsigned int txtimer_cancelers; /* block starts while a cancel wa=
its */
> > +     spinlock_t txtimer_lock; /* Protects TX timer lifetime state. */
> > +     /* One reference pins the complete queued/running timer lifetime.=
 */
> > +     bool txtimer_shutdown;
> > +     bool txtimer_ref;
> > +     spinlock_t rxtimer_lock; /* Protects RX timer lifetime state. */
> > +     unsigned int rxtimer_cancelers;
> > +     /* One reference pins the complete queued/running timer lifetime.=
 */
> > +     bool rxtimer_shutdown;
> > +     bool rxtimer_ref;
>
> If you add new variables, pleas use __guarded_by()
> https://docs.kernel.org/dev-tools/context-analysis.html
>
> Thank you!
>
> Best Regards
> Oleksij
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

Hi Oleksij,

Thanks for pointing this out.

I compared Tetsuo's v11 series with my current timer patch. They appear
to address separate paths: his series changes ECU/address-claim
lifetime handling, while mine changes session timer lifetime and TX
shutdown handling. They both touch j1939-priv.h, but in different
areas. I have not tested the patches together, so I cannot yet confirm
that they apply cleanly as a combined series.

I will hold my timer patch until Tetsuo's series is applied, then
rebase and rework mine on top of it. I will also add __guarded_by()
annotations for the new protected fields and run context analysis with
Clang before sending an updated series.

I will coordinate with Tetsuo to avoid duplicate work.

Best regards,
Zihan
