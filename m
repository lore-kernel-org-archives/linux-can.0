Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793196864;
	b=WyhhVf/uDFgNL3yz6XbFc7uXTRm1JsYzLqxR6S1r6msJ19EbFuiocrPce/xY1GhzPyYL
	 cK5seVZ9XUOq7UZleg/YIy6y6I+MDSzY1b5JewsR4NGUo78DEq/HQ3Cd/4uIAHU/8ZBTu
	 BqMbwHIPWE+3nWa1yJVjS9MbkN0dbt2JeSGvhhHQm6XgKMdyJtSan7/AcVhmPefE8b3EV
	 upS1zg/pmm57ms49be73EoZqp2QlZFblxQ95OTVTqpHtTOV2nrWycfJusTf+iAxCWKxx6
	 rmwmiJJr25YPh382goL28XRzW0jJ0uMT5uQARdXcPXaaBOeNMlrAYaVz4JknuShTbgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=m6JPg6P2lQiXZAVVAvuoBXsXsYZGvkI8+hMDRwhaEtw=;
	b=qB3uzfg2QglAgHDSojiuoQeVeI749ouqODYxD1M0dJ8CWpxWsFeH751v3IctlUBL95gy
	 MHzundfN3X2TnQfj4JD+bQRYLrhZ0aC0FlOkC8EOh11r2XutvKaEWPbbdvjg9pwPqtJwb
	 k7roxfznfKKq/ZmxO2boC/D7KaaRnj+w8txQPFRzpQqaS0HpvfD3t6+/+87zgalg1zwE4
	 lJQWbZoMklVq23GXY24tFi9f+AXAjtItGaQtzeyst68dTPlpJQZg4WVsgnTmgLaUQnFgH
	 T6UDw67CJaTey6lw1KqxOuZm7GnwIbaSaQ3MjMD1psw1UjW7BqYXxsIXre5LDPaco1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=OwZ7iUXs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.170
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B85606A31D
	for <linux-can@vger.kernel.org>; Wed, 28 Oct 2026 14:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38B85606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=OwZ7iUXs
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a98f260f85so9021111fa.0
        for <linux-can@vger.kernel.org>; Wed, 28 Oct 2026 07:14:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793196862; cv=none;
        d=google.com; s=arc-20260327;
        b=ePUYxyOGybSXjs1clwMZ3fz60YrVDa0zB4rawWdwE1fQGpJ2ZmxQHWENmp6iXUFYqD
         ZVm1+MJlF0FUw24D0RMdGKsF4lCjwPKJt0Ja4WgN8tRcc7Jv1/tBOY84gbo+QsRqhDcH
         BSygrbVAmXnVTOBVPQClGKLKROAyPM5fbjYYRxtSco9m5gh3qnKCIc4VD2V8zwkc0set
         JOWAEbvgS5ay3TITOBlCQzXeXfIiuNgH1PSg+jxNupxDR5Qdr0rSJbjim9iGJ5uHBS14
         Q/VAZSbthK90jR7eIAxNrNjfyEnAT2lP2L8lgVewLBysTtcdxR0u9N6mBjuPPmI7xcxd
         D9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m6JPg6P2lQiXZAVVAvuoBXsXsYZGvkI8+hMDRwhaEtw=;
        fh=UDmiFjDUsl58/oI1pbxKLXmAuoEiB7qNSJQzd9c7Gr0=;
        b=QdrpamQrIgq36NfWzwssaOam54eOd0pXC9U/94bkJko94no7clKDymgtV986W8pvw2
         vWVv7FG7g2Iuplu85Y65vWcfm3coQDOLHAnIf9BSDEQjLMB7dsFE6h33wBk7fsD87Onj
         tnFOpYWzHeExBwI3wOKYdgo1DFgiin/+UAbUHwXI3NXm41pWnFmnoQG8BI/zLoRrJioB
         bawT7l9pNZu6sEXOhNPCtO2uwmKxDnU5TCpzt4cNov8KXZv8Fyhv3ZPdCL9rJaH5S0/8
         gxS8Tfu5V0R2gbyNu9dGIxsV5et5+irNXPHWaD9ME+PR3mrPLtGAtjHw0fHuWY2FZwAr
         ZK8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793196862; x=1793801662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m6JPg6P2lQiXZAVVAvuoBXsXsYZGvkI8+hMDRwhaEtw=;
        b=OwZ7iUXsxz77YdQnZe8lkPO2Wq19mpu+lF5NjOTViqZMGjE1N9x4HjKddvPXKZiUwE
         RTubEXhe5Uo28VDtHINhFHxtAxNMRl62++8zzBuXELrX/6f1P6OL8Zsuw1oz7TiVoQkB
         saORAMpUpmgq0BmtTlDNcsifXwKjL5SXUoNJ+MKImF8nXKABeeOEoDSwVbptBsubd3lz
         q7x9UvDl0sam9HriO8kJ30NXo/rj7x/p5mHz2uE/vGmcXZr1ViC2g3omCsv/R3GP7d7G
         ut/UUBxRlZdFu0aTAGo9MmFi7GCAG5iT8FJm62sI4hRv6fPXpEE8g1UCE8O37mT8t8Zz
         0i3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793196862; x=1793801662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m6JPg6P2lQiXZAVVAvuoBXsXsYZGvkI8+hMDRwhaEtw=;
        b=ApwD+d5xHt3GPORuAUH7wAWYZk6xBzuFFhyLCDpdUNf+UkjwlURVwkac1kn8zcMleE
         5X+1UV+SIrhz0mYI5FWyeZpG+2wo0pbrIbPY0nn5JwEwqLfQ6CQ9RLRSDTB7NLVtw+Ms
         M1mM3XSbtav/zJ8HaLnBZFPaMywWcp1fzkSWQszzVws/5kNYs3bBQv+113p2Cfk9Rd0a
         uVa6jjF16vQoCgl5MFX0AT8pFsON5bRQ2NA7Ks+hgSOIcMGEPhX+MnpguRfSInPAp9WE
         0311wDLyBpFUlyxnFuP+rNpnKQsp+7n00hCXg6VQs5DYtToG7Hbepq2s3j7DJaqMytMc
         t+LA==
X-Gm-Message-State: AFq9FYIokt3goEhkq0PYMGiTJTuauCLfYknBx8yzMR7QFoA5WE+8e6O+
	PfF6nx0mujapELWJsLfAjiQCJO1tyk4xKR/b/O0bHA7A/2vcHW8WiZe/f8ijw8DSmPI1HFmeBnD
	fR/X1NIyWY27yVCPC+BKRzW0ShfezdYVUnPugo8QqegTJF+VHklw4szpkVLBRQA==
X-Gm-Gg: AYBFou3TNjndPNrTN1LwrXDGWpoTThbJ8O9XIDRe7qgIvMpeiXEWWkYNk7H1rOa2svj
	KY3c1RN7y7sO7zvtcTKhSjnUQK/ZSRiXR3r7DyWv1yVDkP0fBtxEJ+/WSszHRtmK4W3tg2yl9eJ
	q9vnQ3tLwUUkevazzWQIM2LwzVbFZNiMHOXJp2Dbic6EkSi/VR67+Lp6V39pwu4gAYYoBlPQ0AG
	k3rQmQZGSshJtVqBJc1SrsKgsOs6RGIx/Eewr+b2nDTrk0FA5nWMnI/qJJRNhX4OBpqU2oChb93
	WfFr+to15DB14nDcHUoBBEJbxbxzTW1EuyugXI3MPh7VAK/c4cb+2Zsz6lknqge2+J3Nzr/OV8M
	LbUrjfEuVrRVvA5Xb5BdWXLLhwf1Qi2o2FK+a+IPkg/bQWQDVX8I450WzpzyjRXDPi1k=
X-Received: by 2002:a2e:b88a:0:b0:3ab:1fc4:8eb6 with SMTP id
 38308e7fff4ca-3ac9cf05a40mr5972811fa.5.1793196862374; Wed, 28 Oct 2026
 07:14:22 -0700 (PDT)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793089479.git.zihanx@nebusec.ai> <cover.1793109154.git.zihanx@nebusec.ai>
 <50f8970ce7800947332f6203626abbe1933997eb.1793109154.git.zihanx@nebusec.ai> <sashiko-outbox-187949@kernel.org>
In-Reply-To: <sashiko-outbox-187949@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Wed, 28 Oct 2026 22:14:07 +0800
X-Gm-Features: AclHuK_JtpA67RPAe_iqQq1LpIMxrw3scYa5SbswP1AFrxd2B406TRRxC7SiLTU
Message-ID: <CAANe3eSvb040gP3PgkZ5jBj8gizfCFGuBCoCPVi59_E=T4ROPA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] can: bcm: limit RX operation resource usage
 per socket
To: sashiko-reviews@lists.linux.dev
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, Vincent Mailhol <mailhol@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 9:53=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] can: misplaced kernel-doc comment above can_rx_register_internal(=
)
> --
>
> commit 6e185f899c0a564d22495ef1e055cc4b9c9b27f0
> Author: Zihan Xi <zihanx@nebusec.ai>
>
> can: bcm: limit RX operation resource usage per socket
>
> This patch bounds the number and total allocation size of RX operations p=
er
> BCM socket to prevent kernel memory exhaustion. It also introduces
> can_rx_register_with_release() so the socket's receiver count remains
> charged until the RCU grace period completes.
>
> Link: https://bugtracker.nebusec.ai/f/11134
>
> > diff --git a/net/can/af_can.c b/net/can/af_can.c
> > index 34fe3b28d576f..a3f0ed35fbb52 100644
> > --- a/net/can/af_can.c
> > +++ b/net/can/af_can.c
> > @@ -441,15 +441,20 @@ static struct hlist_head *can_rcv_list_find(canid=
_t *can_id, canid_t *mask,
> >   *  -ENOMEM on missing cache mem to create subscription entry
> >   *  -ENODEV unknown device
> >   */
> > -int can_rx_register(struct net *net, struct net_device *dev, canid_t c=
an_id,
> > -                 canid_t mask, void (*func)(struct sk_buff *, void *),
> > -                 void *data, char *ident, struct sock *sk)
> > +static int can_rx_register_internal(struct net *net, struct net_device=
 *dev,
> > +                                 canid_t can_id, canid_t mask,
> > +                                 void (*func)(struct sk_buff *, void *=
),
> > +                                 void *data, char *ident, struct sock =
*sk,
> > +                                 void (*release)(struct sock *sk))
>
> [Severity: Low]
> When splitting can_rx_register() into can_rx_register_internal() and the
> exported wrapper in net/can/af_can.c, can_rx_register_internal() is place=
d
> directly beneath the existing kernel-doc comment for can_rx_register():
>
> /**
>  * can_rx_register - subscribe CAN frames from a specific interface
> ...
>  */
> static int can_rx_register_internal(struct net *net, struct net_device *d=
ev,
>                                     canid_t can_id, canid_t mask,
>                                     void (*func)(struct sk_buff *, void *=
),
>                                     void *data, char *ident, struct sock =
*sk,
>                                     void (*release)(struct sock *sk))
>
> Doesn't this cause scripts/kernel-doc (under W=3D1 builds) to warn that t=
he
> prototype is for can_rx_register_internal() instead of can_rx_register()
> and that the release parameter is not described?
>
> Should the kernel-doc comment be moved down to the exported
> can_rx_register() wrapper (or updated to match the function it precedes)?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793109154.=
git.zihanx@nebusec.ai?part=3D1

Thanks for the review. I=E2=80=99ll move the kernel-doc comment above the
exported can_rx_register() wrapper and verify it with a W=3D1 build and
scripts/kernel-doc.
