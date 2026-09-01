Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2AB38A717;
	Tue,  1 Sep 2026 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260245; cv=none; b=liLB1xN8+xv2Hr52tiyWIYF3wB8pgcwe5/HfNRkwWKDbr0x+V6LwKsraGSRjK7oRRXtKgR6wKxMfPlD2CLQKHJKBzOXaiW8uMqst2q0ZeU66ipE3RgiXGbYjvnlylKoZ1Kb+q+EgnLvrHhgYGA33Ut2pGVPxfeYSi/WJXogy9Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260245; c=relaxed/simple;
	bh=CGhQw4Z3L6+PSEYmqJgIbo5zyuH9K1HfRAYqXAadgl0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MdVOeX673Qnf984854QnTJC3+WxuzrKs1TDe924wPqiowJ0ebsrMQSUxe+7sTVgBpUYmckWLnQKVIrh3nInH4eF21KCfWxmBPS0Ebtku5nYVIWMslwEr5Pu9BtJvuDgkm3eeh7fQM7+AwuTxyE5YOT3S8wYk0cKwzGdAa8SPTio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bp4pyLqA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bp4pyLqA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EBD1F000E9;
	Tue,  1 Sep 2026 10:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788260241;
	bh=YF6Y/CwLjtKrkEfm3/MGJZRazaPYWMYNTs6t6naHcHY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bp4pyLqATHRmCkcKzw4C5AgVzzIn46TvV8d+5FSXApiiJuR7dHUl60Jte/kR4R7RM
	 C6AZdQ8aM6sGUD0NP+TKmQNgHrvt65ihGCy+F5/bB1NoNWKT1IFL6fMRTdK4P0XQ3w
	 oC8RKypJDJRWc3FEyM1AiBpJUBqZcO6KlHppx+AfxQXKRI5LMpAxWqdAyOFcin3TRa
	 OjcdcnVe2TEaRYY3+Hi2dsvhWRlJre9Zh12PSPWCURlmO3KwsVYP7nO/usq4OvNgV2
	 DQeC9ubnYY5UTc7RUPJyU5sEYwLEjIz+zgiMEZ2kgILrWhQInbDE2W6e8RLp6Bxkep
	 1sTkyqhJM2Biw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] can: rx-offload: make skb_irq_queue per-CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciprian Costea" <ciprianmarian.costea@oss.nxp.com>
Cc: linux-can@vger.kernel.org, imx@lists.linux.dev, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, Frank.Li@kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260901104103.458619-2-ciprianmarian.costea@oss.nxp.com>
References: <20260901104103.458619-1-ciprianmarian.costea@oss.nxp.com>
 <20260901104103.458619-2-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 10:57:20 +0000
Message-Id: <20260901105721.18EBD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Ignoring the return value of can_rx_offload_add_manual() leads to =
a kernel panic in gs_usb if per-CPU allocation fails.
--

commit d8e59325c82aef9b3489bcce81a1a5ee64835783
Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

can: rx-offload: make skb_irq_queue per-CPU

This patch converts skb_irq_queue to a per-CPU allocation to fix concurrent
list enqueueing issues on platforms with multiple mailboxes affined to
different CPUs.

> diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-of=
fload.c
> index 46e7b6db4a1ef..649bfda08b654 100644
> --- a/drivers/net/can/dev/rx-offload.c
> +++ b/drivers/net/can/dev/rx-offload.c
[ ... ]
> @@ -353,13 +391,21 @@ static int can_rx_offload_init_queue(struct net_dev=
ice *dev,
>  				     struct can_rx_offload *offload,
>  				     unsigned int weight)
>  {
[ ... ]
> -	__skb_queue_head_init(&offload->skb_irq_queue);
> +
> +	offload->skb_irq_queue =3D alloc_percpu(struct sk_buff_head);
> +	if (!offload->skb_irq_queue)
> +		return -ENOMEM;
> +

[Severity: High]
Does this new error path cause a kernel panic in drivers that ignore the
return value of can_rx_offload_add_manual()?

Looking at gs_make_candev() in drivers/net/can/usb/gs_usb.c, it does not
check the return value of can_rx_offload_add_manual(). If alloc_percpu()
fails here, the gs_usb driver proceeds with registration.

When a frame is later received, can_rx_offload_queue_tail() uses
get_cpu_ptr(offload->skb_irq_queue). Passing a NULL pointer to get_cpu_ptr()
results in an invalid pointer (0 + per-CPU offset), leading to a crash when
it is unconditionally dereferenced by __skb_queue_tail().

I note an identical issue in at91_can.c was addressed in a subsequent patch
("can: at91_can: fix rx-offload cleanup on unbind and probe errors"), but it
appears gs_usb.c was missed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901104103.4586=
19-1-ciprianmarian.costea@oss.nxp.com?part=3D1
