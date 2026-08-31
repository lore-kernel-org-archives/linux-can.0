Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BE241F5D9;
	Mon, 31 Aug 2026 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199084; cv=none; b=Sy++WJH+Qt5eHssV6FATSxNAWs8F/BRTJkDF3TA3jSBeUgSTxMPD+ZZ6Pz5+E2WQqfFsO70o0wDfqZQ1DMXb1e6ShVAbr9NgSmFa9xz30QmSfnXCNGtoH1xmLaGfTUaIG81+758D9Ofs2ZybguVwvbTgESfWlKEBx7MCdfklV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199084; c=relaxed/simple;
	bh=/Y2n3BF0mOBytbHdJryS/662lu5vzofjZT6SYTOYcH8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O3PWl0C5aa45NCSAZb0lRH4E3d+TL2pgMWmeiRvGSU/SZs64/oe2R9f7c8kvrsfFdbZPraLtPP+CuA25SIOEsQRvF7BKMfk9+5U7EWY+9ptRvRbkFGbR0qwQzSDIiC2BgJ6y8L7ErJhJQrmO6Ci1vlKQ7xKUmQ7gI7vcRtMAtNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajTbcuSl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajTbcuSl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90141F000E9;
	Mon, 31 Aug 2026 17:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788199082;
	bh=88kBmAOeeg69hB70VjiQEpUA+4zzV72009nelF6Fqu0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ajTbcuSlC0vnRHETCu/+ZVUrrNRcMtGf/yCwmSlpIRZgDbEblTmcYFhoRyv3XsAFe
	 I59j1L5ol87/yNoqe0WKG2l3mNsZ6J4Z6VbZseePROAqwjW00rapkfQIlMwQIf7d/L
	 pJwiCY/xNVWnbktZstygkdi4yulWjTmyW8cCi8kULWBAP0bEWL4FXHJMvqvgBkyPG2
	 vycmId2anXpNTqoinP1hGIfVkq9B+baUHr9xYAseltG4Mw7X0qt1AYiDEsx55xJy3M
	 mtAKrMT5EVKpx61Iri40VbEOAkY0Qt7gM1F2+sP0TdWup19sgM50QKDgSRE1EQCUQx
	 iA+lSu4COfVxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: rx-offload: make skb_irq_queue per-CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciprian Costea" <ciprianmarian.costea@oss.nxp.com>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, imx@lists.linux.dev, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, Frank.Li@kernel.org
In-Reply-To: <20260831142819.9318-1-ciprianmarian.costea@oss.nxp.com>
References: <20260831142819.9318-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 17:58:00 +0000
Message-Id: <20260831175801.C90141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Per-CPU splicing destroys strict CAN frame timestamp ordering, cau=
sing out-of-order delivery.
- [High] Unsafe use of this_cpu_ptr() in preemptible threaded IRQ context t=
riggers smp_processor_id() warnings.
- [High] Crash in can_rx_offload_del() due to unchecked dynamic per-CPU all=
ocation failure.
- [High] Lockless cross-CPU list manipulation in can_rx_offload_threaded_ir=
q_finish() races with hard IRQ handlers.
- [Medium] Memory leak in at91_can driver due to missing can_rx_offload_del=
() call.
--

commit 65bff5b50e9fe16e30c0b8850186d29135b0b545
Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: can: rx-offload: make skb_irq_queue per-CPU

This patch changes the skb_irq_queue from a single lockless list to a
per-CPU list to avoid corruption when multiple mailbox IRQ lines are affined
to different CPUs. The queues are now enqueued via this_cpu_ptr() and
spliced together in the IRQ finish handlers.

> diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-of=
fload.c
> index 46e7b6db4a1ef..48d814664b3d1 100644
> --- a/drivers/net/can/dev/rx-offload.c
> +++ b/drivers/net/can/dev/rx-offload.c
[ ... ]
> @@ -222,6 +225,7 @@ EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_fifo);
>  int can_rx_offload_queue_timestamp(struct can_rx_offload *offload,
>  				   struct sk_buff *skb, u32 timestamp)
>  {
> +	struct sk_buff_head *irq_queue =3D this_cpu_ptr(offload->skb_irq_queue);

[Severity: High]
Is it safe to use this_cpu_ptr() here?

If a driver utilizes threaded IRQs (such as mcp251xfd), it can invoke offlo=
ad
enqueue helpers from a preemptible context. Wouldn't obtaining a per-CPU
pointer without first disabling preemption trigger a
BUG: using smp_processor_id() in preemptible warning?

Could this also cause lockless list corruption if the kernel thread migrates
to another CPU mid-enqueue?

[ ... ]
> @@ -268,13 +272,15 @@ EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb_queue=
_timestamp);
>  int can_rx_offload_queue_tail(struct can_rx_offload *offload,
>  			      struct sk_buff *skb)
>  {
> +	struct sk_buff_head *irq_queue =3D this_cpu_ptr(offload->skb_irq_queue);

[Severity: High]
This appears to be another helper used by drivers from potentially preempti=
ble
contexts, and it might have the same this_cpu_ptr() issue as above.

[ ... ]
> @@ -330,15 +337,21 @@ void can_rx_offload_threaded_irq_finish(struct can_=
rx_offload *offload)
>  {
>  	unsigned long flags;
>  	int queue_len;
> -
> -	if (skb_queue_empty_lockless(&offload->skb_irq_queue))
> -		return;
> +	int cpu;
> =20
>  	spin_lock_irqsave(&offload->skb_queue.lock, flags);
> -	skb_queue_splice_tail_init(&offload->skb_irq_queue, &offload->skb_queue=
);
> +	for_each_possible_cpu(cpu) {
> +		struct sk_buff_head *irq_queue;
> +
> +		irq_queue =3D per_cpu_ptr(offload->skb_irq_queue, cpu);
> +		skb_queue_splice_tail_init(irq_queue, &offload->skb_queue);

[Severity: High]
Does this per-CPU splicing destroy strict CAN frame timestamp ordering?

The commit message states "Cross-line frames are now sorted by timestamp on=
ly
within a CPU's queue and appended across CPUs on splice". By blindly
concatenating per-CPU queues in numerical CPU order without merging by
timestamp, doesn't this result in out-of-order delivery of CAN frames to the
network stack for devices receiving frames concurrently on different CPUs?

Could this break chronological CAN bus protocol guarantees?

[Severity: High]
Additionally, can this cross-CPU list manipulation race with hard IRQ handl=
ers?

Here, the threaded IRQ handler iterates over all CPUs and accesses another
CPU's lockless list (irq_queue) without cross-CPU synchronization. If a dev=
ice
has multiple IRQ lines affined to different CPUs, a hard IRQ handler on
another CPU could concurrently locklessly enqueue into its list via
__skb_queue_add_sort().=20

Couldn't this concurrent modification cause severe list corruption?

[ ... ]
> @@ -353,13 +366,21 @@ static int can_rx_offload_init_queue(struct net_dev=
ice *dev,
>  				     struct can_rx_offload *offload,
>  				     unsigned int weight)
>  {
> +	int cpu;
> +
>  	offload->dev =3D dev;
> =20
>  	/* Limit queue len to 4x the weight (rounded to next power of two) */
>  	offload->skb_queue_len_max =3D 2 << fls(weight);
>  	offload->skb_queue_len_max *=3D 4;
>  	skb_queue_head_init(&offload->skb_queue);
> -	__skb_queue_head_init(&offload->skb_irq_queue);
> +
> +	offload->skb_irq_queue =3D alloc_percpu(struct sk_buff_head);
> +	if (!offload->skb_irq_queue)
> +		return -ENOMEM;

[Severity: Medium]
Will this new dynamic allocation cause memory leaks in drivers that don't c=
all
can_rx_offload_del()?

For example, the at91_can driver calls can_rx_offload_add_timestamp() during
probe but misses the matching can_rx_offload_del() call in its teardown path
(at91_can_remove). Before this patch, the omission was benign, but won't th=
is
now unconditionally leak per-CPU memory upon device unbind, module removal,=
 or
probe failure?

[ ... ]
> @@ -420,8 +441,14 @@ EXPORT_SYMBOL_GPL(can_rx_offload_enable);
> =20
>  void can_rx_offload_del(struct can_rx_offload *offload)
>  {
> +	int cpu;
> +
>  	netif_napi_del(&offload->napi);
>  	skb_queue_purge(&offload->skb_queue);
> -	__skb_queue_purge(&offload->skb_irq_queue);
> +
> +	for_each_possible_cpu(cpu)
> +		__skb_queue_purge(per_cpu_ptr(offload->skb_irq_queue, cpu));

[Severity: High]
Can this cause a kernel panic if the dynamic allocation fails?

If alloc_percpu() fails in can_rx_offload_init_queue(), offload->skb_irq_qu=
eue
will be NULL. If a driver ignores the return value (like gs_usb), or during=
 a
probe failure rollback, can_rx_offload_del() will unconditionally call
per_cpu_ptr(NULL, cpu).=20

Wouldn't passing this pointer to __skb_queue_purge() blindly overwrite
unrelated per-CPU memory?

> +
> +	free_percpu(offload->skb_irq_queue);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831142819.9318=
-1-ciprianmarian.costea@oss.nxp.com?part=3D1
