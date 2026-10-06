Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770D938759C;
	Tue,  6 Oct 2026 23:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330754; cv=none; b=qQ+H9PEox368XJ9qmwnBUfSXSlWZnEJ3vTiZ95WkTkoj+64v0UoXEDIAlIRTXIphAbzo6ckPtGuo3KLpuDncDGRj1LsZOAJwfRsw1HVzV7V4uzXjrcD2nhqTX1H8RaxM5nB/+BqE9AseYxIplvC++Oq5QdbWF4a6/4PTtJDO10s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330754; c=relaxed/simple;
	bh=kYaJffDJSL6bZqHpdRnq76CSoS1L0JWPoKE5+np6XRE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R0PFqnObuK9dPDZ1zkB3tA2cDfkmOTuuDVDo2avvqFAgzifb3y2QgzCZRz0JT+LJ6g3llI/oqir8cPicSt7jxhAgJj9amAOx1jMxi6vNAr/ZAlGPdZB8YDQGXzibxT4ej+W/5AD0qTmdGw3YurjKdDtpUS8WYGQnPw+d9hkWPRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5nZbeSR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5nZbeSR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C141F0089B;
	Tue,  6 Oct 2026 23:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791330753;
	bh=VVVTL9TnjojHdLNO45G7TSwXPo64BAyexoRfRfxBu5Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l5nZbeSRezoFGkMjGpuUQ4N5OoZqfl7QB4Ul6dTisRuZqdtjhUjG6+EeoZ72Vpvql
	 FI8Z86604pZXV+1jHrTul6zDcLj5C7X/S/7OtqT6aeq+wNg/6OafdDQEB5oi9w1iiu
	 Fl3ybB/bhUFowDMxYvwwu0CIBgBOAg6UO/yGx5/ttBgpBf9i8HXomdLboTrmLyKqdi
	 DXTvI144ZzGGWCgNJzO7nEl1WYKTC7t2If7ESIpDrMaEBI0tetJvPnn00/r5f+Dof4
	 bxqfCNhPTK0wdNamAy/qGHiM/MqpLhfretCqlAi5R1J9Ls61k/OXmDadn7L3OPhuCb
	 COIkSpxmueenw==
Subject: Re: [PATCH RFC 1/2] can: rx-offload:
 can_rx_offload_threaded_irq_flush(): add newfunction to be called from within
 loop of threaded interrupt handlers
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: ciprianmarian.costea@oss.nxp.com, mailhol@kernel.org, mani@kernel.org,
 thomas.kopp@microchip.com, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 06 Oct 2026 23:52:32 +0000
Message-ID: <179133075200.1406898.16219878816979050518@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261005-upstream-can-rx-offload-batching-alternat?=
 =?utf-8?q?ive-v1-1-4c08ccb516ec=40pengutronix=2Ede=3E?=
References: =?utf-8?q?=3C20261005-upstream-can-rx-offload-batching-alternati?=
 =?utf-8?q?ve-v1-1-4c08ccb516ec=40pengutronix=2Ede=3E?=
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The unbounded skb_irq_queue growth that this commit sets out to
  stop can still happen at the end of the series, so the fix is…
- [High] can_rx_offload_threaded_irq_flush() corrupts the qlen counters
  when frames are sorted in ahead of the saved marker.
- [Medium] The kernel-doc for can_rx_offload_threaded_irq_flush() says
  that when skb_irq_queue 'exceeds 3/4' of the max, the function will…
- [Low] The kernel-doc for the new static helper __skb_cut_position() in
  drivers/net/can/dev/rx-offload.c says '@entry: an entry within head,…
- [Low] In can_rx_offload_threaded_irq_flush(), queue_len is declared as
  u32 (line 404) but printed with "%s: queue_len=%d\n" in netdev_dbg()…

--

can: rx-offload: can_rx_offload_threaded_irq_flush(): add newfunction to be called from within loop of threaded interrupt handlers

This adds can_rx_offload_threaded_irq_flush(), which is meant to be called
from inside the loop of a threaded IRQ handler. When skb_irq_queue reaches
1/2 of skb_queue_len_max, it saves the current tail. When the queue reaches
3/4, it moves everything up to that saved skb into skb_queue and schedules
NAPI, so the newest entries stay behind for later reordering.

> diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
> index 46e7b6db4a1ef..9f494ab7561ef 100644
> --- a/drivers/net/can/dev/rx-offload.c
> +++ b/drivers/net/can/dev/rx-offload.c

[ ... ]

> @@ -349,6 +351,90 @@ void can_rx_offload_threaded_irq_finish(struct can_rx_offload *offload)
>  }
>  EXPORT_SYMBOL_GPL(can_rx_offload_threaded_irq_finish);
>  
> +/**
> + * __skb_cut_position - cut a skb list into two
> + * @list: a new list to add all removed entries
> + * @head: a list with entries
> + * @entry: an entry within head, could be the head itself
> + *	and if so we won't cut the list

[Severity: Low]
Does this helper actually handle entry == head? This text seems to be copied
from list_cut_position(), where the wrapper has the checks that make the
statement true:

include/linux/list.h:list_cut_position() {
	if (list_empty(head))
		return;
	if (list_is_singular(head) && !list_is_head(entry, head) && (entry != head->next))
		return;
	if (list_is_head(entry, head))
		INIT_LIST_HEAD(list);
	else
		__list_cut_position(list, head, entry);
}

__skb_cut_position() has none of these checks. It always does the cut and
adjusts both qlen values. If entry is the head, or head is empty, both lists
come out malformed.

The only caller passes the result of skb_peek_tail(), so this path is not
reachable today. Could the comment be corrected, though?

This isn't a bug, but the __skb_ prefix makes a private CAN helper look like
a core skbuff API, and it could clash with a future core helper of the same
name.

> + * @qlen: length up to @entry in @head
> + *
> + * This helper moves the initial part of @head, up to and including
> + * @entry, from @head to @list. You should pass on @entry an element
> + * you know is on @head and @qlen being the position of that element
> + * on @head. @list should be an empty list or a list you do not care
> + * about losing its data.
> + *
> + */
> +static inline void __skb_cut_position(struct sk_buff_head *list,
> +				      struct sk_buff_head *head,
> +				      struct sk_buff *entry,
> +				      __u32 qlen)
> +{
> +	struct sk_buff *new_first = entry->next;
> +	struct sk_buff *first = head->next;
> +
> +	WRITE_ONCE(list->next, first);
> +	WRITE_ONCE(list->next->prev, (struct sk_buff *)list);
> +	WRITE_ONCE(list->prev, entry);
> +	WRITE_ONCE(entry->next, (struct sk_buff *)list);
> +	list->qlen = qlen;
> +
> +	WRITE_ONCE(head->next, new_first);
> +	WRITE_ONCE(new_first->prev, (struct sk_buff *)head);
> +	head->qlen -= qlen;
> +}
> +
> +/**
> + * can_rx_offload_threaded_irq_flush() - partially flush the rx_offload queue
> + * @offload: pointer to rx_offload context
> + *
> + * If can_rx_offload->skb_irq_queue exceeds 3/4 of the maximal queue
> + * length (can_rx_offload->skb_queue_len_max) flush about 1/2 of the
> + * maximal queue length to NAPI.
> + *
> + * This function is intended to be called within the loop of threaded
> + * IRQ handlers, which run until all IRQs have been served.

[Severity: High]
Can skb_irq_queue still grow without bound once the series is applied?

This patch adds no caller. The follow-up commit "can: mcp251xfd:
mcp251xfd_irq(): add call to can_rx_offload_threaded_irq_flush()" adds one,
but only in the main intf loop of mcp251xfd_irq().

mcp251xfd_irq() also has an rx_int GPIO fast-path loop, and that loop never
calls the new helper:

drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:mcp251xfd_irq() {
	if (priv->rx_int)
		do {
			int rx_pending;

			rx_pending = gpiod_get_value_cansleep(priv->rx_int);
			if (!rx_pending)
				break;
			...
			err = mcp251xfd_handle(priv, rxif);
			...
		} while (priv->rx_ring_num == 1);
	...
}

Each frame read in that loop goes through can_rx_offload_queue_timestamp().
That function only compares skb_queue, not skb_irq_queue, against
skb_queue_len_max. NAPI is not scheduled until
can_rx_offload_threaded_irq_finish() runs.

With microchip,rx-int-gpios and a single RX ring, wouldn't the case the
commit message describes ("the threaded IRQ handler will not exit the while
loop") still leave skb_irq_queue growing without limit?

> + *
> + */
> +void can_rx_offload_threaded_irq_flush(struct can_rx_offload *offload)
> +{
> +	struct sk_buff_head tmp_queue;
> +	unsigned long flags;
> +	u32 irq_queue_len, queue_len;
> +
> +	irq_queue_len = skb_queue_len(&offload->skb_irq_queue);
> +	if (irq_queue_len < offload->skb_queue_len_max / 2)
> +		return;
> +
> +	if (!offload->flush_skb) {
> +		offload->flush_skb = skb_peek_tail(&offload->skb_irq_queue);
> +		offload->flush_len = irq_queue_len;
> +	}
> +
> +	if (irq_queue_len < offload->skb_queue_len_max * 3 / 4)
> +		return;

[Severity: Medium]
What happens when flush_skb is NULL and irq_queue_len is already at or above
3/4 of skb_queue_len_max on the first call?

In that case, the same call sets flush_skb to the current tail and
flush_len to the full queue length. It then skips this return and cuts the
entire skb_irq_queue.

That doesn't match the kernel-doc above ("flush about 1/2 of the maximal
queue length") or the commit message ("leave about 1/4 of the maximum queue
length in offload->skb_irq_queue").

This looks reachable in mcp251xfd. The rx_int loop in mcp251xfd_irq() fills
skb_irq_queue without calling the helper, so the first call from the main
loop can already see 384 or more entries (weight 32, max 512). Older frames
read afterwards from another RX ring or the TEF would then be delivered
after newer ones.

Should saving the marker be kept separate from making the cut?

As a minor point, the doc says "exceeds", but the early returns use <. That
means the code triggers at exactly 1/2 and exactly 3/4.

> +
> +	__skb_cut_position(&tmp_queue, &offload->skb_irq_queue,
> +			   offload->flush_skb, offload->flush_len);

[Severity: High]
Is offload->flush_len still the position of flush_skb at this point?

flush_len is saved once, when the queue reaches 1/2. After that, the IRQ
loop keeps adding frames through __skb_queue_add_sort(), which walks
backwards from the tail and inserts by timestamp:

drivers/net/can/dev/rx-offload.c:__skb_queue_add_sort() {
	skb_queue_reverse_walk(head, pos) {
		...
		if (compare(pos, new) < 0)
			continue;
		insert = pos;
		break;
	}
	...
}

Any frame older than flush_skb is therefore inserted in front of it. In
mcp251xfd, this can be a TEF echo skb queued with
can_rx_offload_get_echo_skb_queue_timestamp(), or a frame from another RX
ring. That is the late, older-frame case the commit message describes.

If N such frames were inserted, the cut moves flush_len + N skbs, but
__skb_cut_position() does:

	list->qlen = qlen;
	...
	head->qlen -= qlen;

As a result, skb_queue.qlen ends up N too low and skb_irq_queue.qlen ends up
N too high.

Once NAPI drains skb_queue, __skb_unlink() decrements qlen once per real
skb. skb_queue.qlen (a u32) then wraps to about 2^32 - N. After that, this
check always fires:

drivers/net/can/dev/rx-offload.c:can_rx_offload_queue_timestamp() {
	if (skb_queue_len(&offload->skb_queue) >
	    offload->skb_queue_len_max) {
		dev_kfree_skb_any(skb);
		return -ENOBUFS;
	}
	...
}

can_rx_offload_queue_tail() and can_rx_offload_offload_one() have the same
check. Every RX frame and every TX echo skb would then be dropped.

If no frame was queued after flush_skb, the cut leaves skb_irq_queue
physically empty with qlen == N. can_rx_offload_threaded_irq_finish() then
returns early on skb_queue_empty_lockless() and never splices the counts
back. New frames are dropped before they reach skb_irq_queue.

Could RX then stay dead until the driver is unbound? mcp251xfd only calls
can_rx_offload_del() in remove.

There may also be a NULL dereference. If skb_irq_queue is empty but its qlen
is at or above 3/4 of the max, skb_peek_tail() returns NULL, and
__skb_cut_position() would then dereference entry->next on that NULL
flush_skb.

> +
> +	spin_lock_irqsave(&offload->skb_queue.lock, flags);
> +	skb_queue_splice_tail_init(&tmp_queue, &offload->skb_queue);
> +	spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
> +
> +	offload->flush_skb = NULL;
> +
> +	queue_len = skb_queue_len(&offload->skb_queue);
> +	if (queue_len > offload->skb_queue_len_max / 8)
> +		netdev_dbg(offload->dev, "%s: queue_len=%d\n",
> +			   __func__, queue_len);

[Severity: Low]
This isn't a bug, but queue_len is a u32 here, while the copy in
can_rx_offload_threaded_irq_finish() is an int. Should this use %u?

> +
> +	local_bh_disable();
> +	napi_schedule(&offload->napi);
> +	local_bh_enable();
> +}
> +EXPORT_SYMBOL_GPL(can_rx_offload_threaded_irq_flush);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005-upstream-can-rx-offload-batching-alternative-v1-0-4c08ccb516ec%40pengutronix.de
