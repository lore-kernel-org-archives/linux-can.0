Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7B84078E8
	for <linux-can@vger.kernel.org>; Mon,  5 Oct 2026 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197590; cv=none; b=uj76tY2xh0C+5IOehulbJcKDLfISdcL6oBfFPIylmVcxQ/QsNn+4uGxMY1h87nEuud0FegvfDYu7lx7r5sWmIxZmy5Oi6/b8KLB0fpm4NrzZ/PyCvSqUrEt+xYLHVY03UKPVKOJhJU7SLdjYT8NmEyj2bPFfnwHNgrHSUJPpmmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197590; c=relaxed/simple;
	bh=+2AZV5eqNe+CELWCkuSSO3OM/t7t8ia3HN0Qk+V+tWY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XRV/mh5G+3Jp+s2iaROG0/bEiOfSuumsYybzv45cOsZbywJ9J305AY4RXs6DDk3HgPay5rO6SHsiW2IRsZO1Rxe4zBorcYaPpPgMbFnmYfKRvulLntxeGm8Hi4nzvFKYQ1hx8UrqiJlwzCJ3LzyLzjY4mKLjUThOvaD/LXhnE0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guk/uhUB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guk/uhUB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878221F000FF;
	Mon,  5 Oct 2026 10:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791197588;
	bh=wvetuNgAAitShDtKmRX6XV/Kh6jP/iDX11K/f0mq658=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=guk/uhUBvpasAR3Voeikkxs6nlLbDcY3PyWIfUvLCQVZLAj3/CIWb3QeJVqKNNhwP
	 4ovV+nMBkiiOYEAAil+wnTdmw2KXGJflJRW5Zy/smE1MzYaql1ZtHpJsy1dJqI/xaD
	 uJhXU4/p6pBwCEwmOQwfgLGyKbESZyc5I8BTsSObO279jb2xXwQWz6FGfY8DKzlHhE
	 P8arboaOrdADtzE0OLIB1EQEc+7eTjBM8pHgoFTY5+Bj1/yQ8J6kTpWsBegeThSf7F
	 StF5u0oF3cS6tilKKz8NeAl6MzBJZrIhkx+bv4KTr10QTGqdIZMLdKSbmvDQ+CDwtm
	 EPhgyQ/3TCtgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/2] can: rx-offload:
 can_rx_offload_threaded_irq_flush(): add newfunction to be called from
 within loop of threaded interrupt handlers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20261005-upstream-can-rx-offload-batching-alternative-v1-1-4c08ccb516ec@pengutronix.de>
References: <20261005-upstream-can-rx-offload-batching-alternative-v1-0-4c08ccb516ec@pengutronix.de>
 <20261005-upstream-can-rx-offload-batching-alternative-v1-1-4c08ccb516ec@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 10:53:08 +0000
Message-Id: <20261005105308.878221F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: stale flush_len causes skb_queue.qlen underflow and permanent=
 packet drops
--

commit eec89aef49a7f405effd6fda359db0f458f6f4df
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: rx-offload: can_rx_offload_threaded_irq_flush(): add newfunction to be=
 called from within loop of threaded interrupt handlers

This commit introduces can_rx_offload_threaded_irq_flush() to prevent
unlimited growth of the IRQ skb queue during heavy load. It partially flush=
es
skb_irq_queue to the NAPI skb_queue when it reaches 3/4 of its maximum
capacity. A portion of the elements are left behind to accommodate older
out-of-order CAN frames.

> diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-of=
fload.c
> index 46e7b6db4a1ef..9f494ab7561ef 100644
> --- a/drivers/net/can/dev/rx-offload.c
> +++ b/drivers/net/can/dev/rx-offload.c
[ ... ]
> @@ -349,6 +351,90 @@ void can_rx_offload_threaded_irq_finish(struct can_r=
x_offload *offload)
>  }
>  EXPORT_SYMBOL_GPL(can_rx_offload_threaded_irq_finish);
> =20
> +/**
> + * __skb_cut_position - cut a skb list into two
[ ... ]
> + */
> +static inline void __skb_cut_position(struct sk_buff_head *list,
> +				      struct sk_buff_head *head,
> +				      struct sk_buff *entry,
> +				      __u32 qlen)
> +{
> +	struct sk_buff *new_first =3D entry->next;
> +	struct sk_buff *first =3D head->next;
> +
> +	WRITE_ONCE(list->next, first);
> +	WRITE_ONCE(list->next->prev, (struct sk_buff *)list);
> +	WRITE_ONCE(list->prev, entry);
> +	WRITE_ONCE(entry->next, (struct sk_buff *)list);
> +	list->qlen =3D qlen;
> +
> +	WRITE_ONCE(head->next, new_first);
> +	WRITE_ONCE(new_first->prev, (struct sk_buff *)head);
> +	head->qlen -=3D qlen;

[Severity: High]
Could this lead to list->qlen undercounting the elements passed to NAPI?

If an older out-of-order CAN frame is inserted into skb_irq_queue before
offload->flush_skb after flush_len has been cached, the physical list
splice moves more than qlen elements up to entry. Statically updating the
length counters using the stale qlen will cause an eventual underflow in NA=
PI
dequeue.

> +}
> +
> +/**
> + * can_rx_offload_threaded_irq_flush() - partially flush the rx_offload =
queue
[ ... ]
> + */
> +void can_rx_offload_threaded_irq_flush(struct can_rx_offload *offload)
> +{
> +	struct sk_buff_head tmp_queue;
> +	unsigned long flags;
> +	u32 irq_queue_len, queue_len;
> +
> +	irq_queue_len =3D skb_queue_len(&offload->skb_irq_queue);
> +	if (irq_queue_len < offload->skb_queue_len_max / 2)
> +		return;
> +
> +	if (!offload->flush_skb) {
> +		offload->flush_skb =3D skb_peek_tail(&offload->skb_irq_queue);
> +		offload->flush_len =3D irq_queue_len;

[Severity: High]
Is it possible for the number of elements preceding the tail to change after
being cached here?

The commit message mentions that older out-of-order CAN frames may arrive f=
rom
independent mailboxes and be sorted into skb_irq_queue. If an older frame is
subsequently received, it would be inserted before flush_skb, physically
increasing the number of elements before flush_skb to flush_len + 1.

> +	}
> +
> +	if (irq_queue_len < offload->skb_queue_len_max * 3 / 4)
> +		return;
> +
> +	__skb_cut_position(&tmp_queue, &offload->skb_irq_queue,
> +			   offload->flush_skb, offload->flush_len);

[Severity: High]
Does passing the stale flush_len to the slice operation hide out-of-order
inserted frames from queue length accounting?

When __skb_cut_position is called, it physically moves flush_len + 1
elements into tmp_queue, but assigns tmp_queue.qlen the stale flush_len.
After splicing, skb_queue receives flush_len + 1 elements but its qlen
only increases by flush_len.

When NAPI dequeue consumes all elements, skb_queue.qlen would drop below 0
and underflow to 0xFFFFFFFF. Since this exceeds skb_queue_len_max, would all
future frames be permanently rejected with -ENOBUFS?

> +
> +	spin_lock_irqsave(&offload->skb_queue.lock, flags);
> +	skb_queue_splice_tail_init(&tmp_queue, &offload->skb_queue);
> +	spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
> +
> +	offload->flush_skb =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-upstream-c=
an-rx-offload-batching-alternative-v1-0-4c08ccb516ec@pengutronix.de?part=3D1
