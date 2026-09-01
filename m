Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9816C4749E9;
	Tue,  1 Sep 2026 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252992; cv=none; b=aidXZYbgJ4Jr4EmZAZvMw1WyCRnztruNs3LWmw5vExqiGp81HL6YnyxxsBHyxWMddb4XfSPZ/BqFjgZgyt1peHfZJ4BuFgV/dn+kqa+amkJ7EgfI0YXqP3LlKj+9KqYaosrrVWmXM5zLvsj/5bYtHzg5azDxxnRZIKROw5MZnaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252992; c=relaxed/simple;
	bh=OuIUGY75OApIKQfIjHZ/PUCVyK4fQk7nYNKRx2B/66o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mtpo4i3YiDRlV3jsSdcGohIJbdY9UWqK4VRoFrVOK2xBvkrOhlmV4DCS/sHYib1FxqzuDB2xn30cK3sof55jwAeNm+/y0WlBWEbcJ1mi55prfIvQJyOF3wHcdjQY3tFgI6FaixeczruuRFKNOykG/XNuKKNCMePhwJTu5976fOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIIOxh5U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIIOxh5U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F2B1F000E9;
	Tue,  1 Sep 2026 08:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788252990;
	bh=t2guQPw3hnUsc8Uns/0gSmAitpqoVRH+IpdpmGkUBkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VIIOxh5UYlBixKwV2pdMhxb1lg2/ZMiAGm4Rm4DPF8bqxJNnKqbwONoOVscpDGCBc
	 SAaqnow11EyY8uvZglfHy3LrKtRs+TJ/iAtEbrCttUfQ/q+kKFJgMvjM0CIfzyvapT
	 DVkXMRamMxDZqXEGZCCXS3fFGfPlLRKx71vi8/IxvYZVahOnezi8DpuXvLrJq5/fmX
	 V3JpddcphQ+3ZcGMUZXPxqxQUc0hoC+PO9tjkE+10mRq10WXkvepgzGIIhl4YXi9EH
	 Byn8hDz0lOjdgYzdMPKg4+xLSsE+1jpH+84inYsDhDbPsnM8jPhN02n3/csIl+/kl4
	 dpyn9Vp0PNDvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] can: rx-offload: make skb_irq_queue per-CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciprian Costea" <ciprianmarian.costea@oss.nxp.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, imx@lists.linux.dev, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, Frank.Li@kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260901083927.316283-2-ciprianmarian.costea@oss.nxp.com>
References: <20260901083927.316283-1-ciprianmarian.costea@oss.nxp.com>
 <20260901083927.316283-2-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:56:29 +0000
Message-Id: <20260901085630.09F2B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Thread migration during threaded IRQ handling and sequential per-C=
PU queue splicing destroys global CAN frame chronological ordering.
--

commit d1de02ef27f2f1f783bb25ca00d6ff687c0ada66
Author: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

can: rx-offload: make skb_irq_queue per-CPU

This commit allocates skb_irq_queue per-CPU to prevent lockless queue
corruption when multiple mailbox IRQ lines are affined to different CPUs.
It removes cross-CPU timestamp sorting, instead sorting frames only within
each per-CPU queue and appending them across CPUs on splice.

> diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-of=
fload.c
> index 46e7b6db4a1ef..649bfda08b654 100644
> --- a/drivers/net/can/dev/rx-offload.c
> +++ b/drivers/net/can/dev/rx-offload.c

[ ... ]

> @@ -330,15 +354,29 @@ void can_rx_offload_threaded_irq_finish(struct can_=
rx_offload *offload)
>  {
>  	unsigned long flags;
>  	int queue_len;
> -
> -	if (skb_queue_empty_lockless(&offload->skb_irq_queue))
> -		return;
> -
> +	int cpu;
> +
> +	/*
> +	 * Splice every CPU's queue: unlike the non-threaded
> +	 * can_rx_offload_irq_finish(), a threaded handler may be migrated
> +	 * between the enqueue and this splice, so the frames may sit on a
> +	 * different CPU's queue. This is only safe because a given per-CPU
> +	 * queue has a single producer (the enqueue on that CPU is
> +	 * non-preemptible), so no producer can race this splice.
> +	 */
>  	spin_lock_irqsave(&offload->skb_queue.lock, flags);
> -	skb_queue_splice_tail_init(&offload->skb_irq_queue, &offload->skb_queue=
);
> +	for_each_possible_cpu(cpu) {
> +		struct sk_buff_head *irq_queue;
> +
> +		irq_queue =3D per_cpu_ptr(offload->skb_irq_queue, cpu);
> +		skb_queue_splice_tail_init(irq_queue, &offload->skb_queue);
> +	}
        ^^^^

[Severity: High]
Does splicing the per-CPU queues in fixed numerical order destroy the
chronological ordering of CAN frames if the threaded IRQ handler migrates?

In CAN drivers using threaded IRQ handlers (like mcp251xfd), bursts of
frames are processed in a loop. Because can_rx_offload_queue_timestamp()
and can_rx_offload_queue_tail() only disable preemption locally during the
actual enqueue operation, the kernel thread can be preempted and migrated
to a different CPU between processing frames.

This distributes sequential frames from the exact same CAN interface across
multiple per-CPU queues. By blindly splicing them into the global skb_queue
in strict numerical CPU order, if the thread migrated from a higher CPU
(e.g., CPU 1) to a lower CPU (e.g., CPU 0), the later frames on CPU 0 are
spliced before the earlier frames on CPU 1.=20

Could this permanently invert their order and violate the strict FIFO
chronological ordering required by CAN bus protocols?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901083927.3162=
83-1-ciprianmarian.costea@oss.nxp.com?part=3D1
