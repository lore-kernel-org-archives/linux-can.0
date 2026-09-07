Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B98030EF86;
	Mon,  7 Sep 2026 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779550; cv=none; b=aKTcXJLDXGwQZY3u9bO17kZPontte7rv9CL6exNa8yv+t0pL7PNes7d7EbHIZW+gPjaeEgr118azT8o0v7i/o2WsgjJXYs0NGd9rMKrTAysyoQffETXrceyT+SMFE8l/neGtchQJZrN1peDzmibwdD3S8yRqA38Gkl6WHQBgAYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779550; c=relaxed/simple;
	bh=HKdGpnjcyVFx1eIyBBWJUxYCcuUgcCy3lhn954sxLtU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FGUcid/z2oWEn4q4TJgt4M93nK9+18vCr79IEa7wImlL0ycTpkU/lVVwwDdVfT5gFXdkJOZJoq3jzXNxY+wWIdyAFEefJCygJJMsLH1yi0iS1dwrRdUSGrF5PjFA8kOy71Vqb8NF7E4XvoFljRb+mmG7kmFw7c+3gfoR/GyvPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8vVD8qw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8vVD8qw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3869A1F00A3A;
	Mon,  7 Sep 2026 11:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788779548;
	bh=5kMrR+DS9Nc+fvCfgREgxa7TTi7Li+qtIpT2ogMDQf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K8vVD8qwDfIESg6qknLQ0C4SFG2Hjr59xh12161pCZ2HxDLwojcONNG2ATbaS6YF0
	 v1/qMAgMaGq6YkEXRfeFXd9ITIYvY5J8/dqozrbrQCF3FZhy3gTrwvFHAj9/K/iPak
	 ySvL7MC8lbTHMpr7UxUSSS6a5VxiY7efJRHuEHYnlL5lmDa2XyJzuZBI68ZlFDwnw6
	 hGboLpRKxOzmBS7Ed0n+xbIf+XqiuAs1St6ZynVNNTYB1BcbECnLDj+O+F2HRCvegT
	 quNwJef64Ua/CTfqZSHyFo1CRBVGl8D/g3eWzWrrcG5/rt3lcLseRFqq6wmUjC28A4
	 FsNVG0SDG6g5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] can: rx-offload: make skb_irq_queue per-CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciprian Costea" <ciprianmarian.costea@oss.nxp.com>
Cc: Frank.Li@kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, imx@lists.linux.dev
In-Reply-To: <20260907104942.17089-2-ciprianmarian.costea@oss.nxp.com>
References: <20260907104942.17089-1-ciprianmarian.costea@oss.nxp.com>
 <20260907104942.17089-2-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 11:12:27 +0000
Message-Id: <20260907111228.3869A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Scheduling while atomic BUG on PREEMPT_RT and high preemption late=
ncy due to wrapping hardware drain loop in get_cpu_ptr().
- [High] Lockless list corruption and smp_processor_id() BUG on PREEMPT_RT =
due to preemptible use of this_cpu_ptr() and splice in can_rx_offload_irq_f=
inish().
--

commit c8905dbba299961e2728d05040d60499542251c0
Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

can: rx-offload: make skb_irq_queue per-CPU

This commit makes skb_irq_queue per-CPU to prevent concurrent list
corruption when multiple IRQ lines are affined to different CPUs. It
uses get_cpu_ptr() during enqueue to disable preemption, and splices
the queues in the IRQ finish handlers.

> diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-of=
fload.c
> index 46e7b6db4a1ef..7616a16d90497 100644
> --- a/drivers/net/can/dev/rx-offload.c
> +++ b/drivers/net/can/dev/rx-offload.c
[ ... ]
> @@ -175,9 +176,18 @@ can_rx_offload_offload_one(struct can_rx_offload *of=
fload, unsigned int n)
>  int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload,
>  					 u64 pending)
>  {
> +	struct sk_buff_head *irq_queue;
>  	unsigned int i;
>  	int received =3D 0;
> =20
> +	/*
> +	 * get_cpu_ptr() disables preemption so that the lockless
> +	 * __skb_queue_*() below operate on the current CPU's queue without
> +	 * racing a migration. This also keeps this_cpu_ptr() valid when a
> +	 * driver enqueues from a preemptible (threaded IRQ) context.
> +	 */
> +	irq_queue =3D get_cpu_ptr(offload->skb_irq_queue);
> +
>  	for (i =3D offload->mb_first;
>  	     can_rx_offload_le(offload, i, offload->mb_last);
>  	     can_rx_offload_inc(offload, &i)) {
> @@ -190,20 +200,25 @@ int can_rx_offload_irq_offload_timestamp(struct can=
_rx_offload *offload,
>  		if (IS_ERR_OR_NULL(skb))
>  			continue;
> =20

[Severity: High]
Does wrapping this entire hardware drain loop in get_cpu_ptr() cause a
"scheduling while atomic" BUG on PREEMPT_RT?

Inside the loop in drivers/net/can/dev/rx-offload.c,
can_rx_offload_offload_one() allocates memory. On PREEMPT_RT, GFP_ATOMIC
allocations acquire a local_lock, which maps to an rt_mutex and can sleep.
Acquiring a sleeping lock while preemption is explicitly disabled by
get_cpu_ptr() triggers the BUG splat, and can also cause significant preemp=
tion
latency spikes on non-RT systems.

Could get_cpu_ptr() be pushed down into the loop to strictly guard only the
lockless __skb_queue_add_sort() operation, similar to how it was correctly
done in can_rx_offload_queue_timestamp()?

> -		__skb_queue_add_sort(&offload->skb_irq_queue, skb,
> +		__skb_queue_add_sort(irq_queue, skb,
>  				     can_rx_offload_compare);
>  		received++;
>  	}
> =20
> +	put_cpu_ptr(offload->skb_irq_queue);
> +
>  	return received;
>  }
>  EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_timestamp);
> =20
>  int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload)
>  {
> +	struct sk_buff_head *irq_queue;
>  	struct sk_buff *skb;
>  	int received =3D 0;
> =20
> +	irq_queue =3D get_cpu_ptr(offload->skb_irq_queue);
> +
>  	while (1) {
>  		skb =3D can_rx_offload_offload_one(offload, 0);

[Severity: High]
Does this unbounded read loop have the same "scheduling while atomic" issue
on PREEMPT_RT as in can_rx_offload_irq_offload_timestamp()?

By calling get_cpu_ptr() outside the while loop, preemption is disabled acr=
oss
all memory allocations in can_rx_offload_offload_one() here as well.

[ ... ]
> @@ -307,14 +330,15 @@ EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb_queue=
_tail);
> =20
>  void can_rx_offload_irq_finish(struct can_rx_offload *offload)
>  {
> +	struct sk_buff_head *irq_queue =3D this_cpu_ptr(offload->skb_irq_queue);

[Severity: High]
Does calling this_cpu_ptr() here in a preemptible context trigger a
"using smp_processor_id() in preemptible" BUG on PREEMPT_RT?

On PREEMPT_RT, standard hardware IRQ handlers like flexcan_irq execute as
preemptible IRQ threads. Because preemption is not disabled here, calling
this_cpu_ptr() is unsafe.

>  	unsigned long flags;
>  	int queue_len;
> =20
> -	if (skb_queue_empty_lockless(&offload->skb_irq_queue))
> +	if (skb_queue_empty_lockless(irq_queue))
>  		return;
> =20
>  	spin_lock_irqsave(&offload->skb_queue.lock, flags);
> -	skb_queue_splice_tail_init(&offload->skb_irq_queue, &offload->skb_queue=
);
> +	skb_queue_splice_tail_init(irq_queue, &offload->skb_queue);

[Severity: High]
Can another IRQ thread preempt this list splice and corrupt the list?

Since preemption is not disabled in this function (and spin_lock_irqsave
only disables migration on RT, not preemption), a higher-priority IRQ
thread on a multi-IRQ controller (like FlexCAN on S32G2) could preempt
the lower-priority one during this skb_queue_splice_tail_init() splice.

If the preempting thread then calls can_rx_offload_irq_offload_timestamp(),
it will explicitly disable preemption and push to the exact same CPU's
irq_queue, concurrently modifying the lockless list.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907104942.1708=
9-1-ciprianmarian.costea@oss.nxp.com?part=3D1
