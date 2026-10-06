Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BF6381E92;
	Tue,  6 Oct 2026 23:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330755; cv=none; b=g7XMAB5CX3695cfGmfOuMYVDBceK+qbOK97J57A6ZOO0UY69Myn7sk0N/52FX1SbX77uyWVnpi+gkgdGkhScDcNUFiX2mX4bTFs4pK/NnQLlUJmq9hXgYKAYEh/VQGtM0y4bQnHS3TErrPhukW5T87P2TS7cAQD2CHOkzb+MgY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330755; c=relaxed/simple;
	bh=bagGNJDCMi2lj5pkMFgWwfbItScCQcAO4V8tv93nSdo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b/HDZnbtd/8qUYwMTIKxk0bIQuRXtwfUy93XbBRGUOF2RAMvKvLZLqNYbGdKE/dJUIBFws4AGIf5EAS+Zft7rlmfAS43yxXJWYTpEF32zgLyfyUqWt8i96cVqSDlK7+0dd3gLaUjvsqHEdJHIadC8OBx6Bl65XUH8UETerxbRBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrE4j/rr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrE4j/rr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E491F0089C;
	Tue,  6 Oct 2026 23:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791330754;
	bh=uRYyWJzC9kDxB04vAfaScQPuymABU053QnX0SMRlcIM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IrE4j/rrtW6TOvK/LGxyIBqmrTgkvhf+CtNOCxa9y7MrMKq3b5WuIqwIQwOsJwRj7
	 itik1qf7K+YFv/v4WnAtyu1LZBu0HrmaBiYxbx+Fcw7RJQ/EVZnkIaMFVIlgu6TtAD
	 EMFzoUkbx0lwujFQTea+E0Z0Y1A94cdmrKLccwHQsdc1cGoT6YaEy2F673q7FVBqa/
	 PJdBn7IC16biHsBaIxk4zWCa+tSrHNRJ/9YjJZp+gRsgCqFwrO4cps/uIM1nXILAUt
	 Ns1rFOHd8qPlmFG1pecnS0g2+aTeuaxCHoP/FV2Ql5T/1XtvkOnldi4O8wT9JircH7
	 VCOS2L6r299VA==
Subject: Re: [PATCH RFC 2/2] can: mcp251xfd: mcp251xfd_irq(): add call to
 can_rx_offload_threaded_irq_flush()
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: ciprianmarian.costea@oss.nxp.com, mailhol@kernel.org, mani@kernel.org,
 thomas.kopp@microchip.com, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 06 Oct 2026 23:52:33 +0000
Message-ID: <179133075328.1406898.10468739053467692064@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261005-upstream-can-rx-offload-batching-alternat?=
 =?utf-8?q?ive-v1-2-4c08ccb516ec=40pengutronix=2Ede=3E?=
References: =?utf-8?q?=3C20261005-upstream-can-rx-offload-batching-alternati?=
 =?utf-8?q?ve-v1-2-4c08ccb516ec=40pengutronix=2Ede=3E?=
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

Critical: 0 · High: 2 · Medium: 0 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [High] This patch adds the first and only caller of
  can_rx_offload_threaded_irq_flush(), in a driver whose producers all…
- [Low] The commit fixes a user-visible defect (unbounded growth of
  offload->skb_irq_queue in the mcp251xfd threaded IRQ handler under bus…
- [Low] The kernel-doc of the new __skb_cut_position()
  (drivers/net/can/dev/rx-offload.c:354-368, added in the preceding…
- [Low] The kernel-doc of can_rx_offload_threaded_irq_flush() (rx-
  offload.c:388-399) says that once skb_irq_queue exceeds 3/4 of…

--

can: mcp251xfd: mcp251xfd_irq(): add call to can_rx_offload_threaded_irq_flush()

This patch adds a call to can_rx_offload_threaded_irq_flush() at the end
of each pass through the main status-register loop in mcp251xfd_irq().
The goal is to stop offload->skb_irq_queue from growing without bound when
the threaded IRQ handler never leaves its loop under load.

> Under certain load situations, the threaded IRQ handler will not exit
> the while loop, resulting in unlimited growth of the
> offload->skb_irq_queue.

[ ... ]

> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

[Severity: Low]
This fixes a user-visible problem, so should it carry a Fixes: tag and
possibly a stable annotation?

The skb_irq_queue design and the threaded finish call in mcp251xfd_irq()
come from these commits:

c757096ea103 ("can: rx-offload: add skb queue for use during ISR")
30bfec4fec59 ("can: rx-offload: can_rx_offload_threaded_irq_finish(): add new function to be called from threaded interrupt")

Either one looks like a reasonable Fixes: target.

This patch also depends on the preceding commit, which adds
can_rx_offload_threaded_irq_flush() and the flush_skb/flush_len fields.
Neither commit records that dependency, and this patch will not build if
it is backported on its own.

> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> index f441f2265299e..208595c0cc469 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -1615,6 +1615,7 @@ static irqreturn_t mcp251xfd_irq(int irq, void *dev_id)
>  			}
>  		}
>  
> +		can_rx_offload_threaded_irq_flush(&priv->offload);

[Severity: High]
Does this also cover the RX-INT loop at the top of mcp251xfd_irq()?

The new flush runs only in the second loop, the one that reads the
status registers. When the microchip,rx-int GPIO is present and
rx_ring_num == 1, the first loop keeps running for as long as the RX-INT
pin is asserted:

mcp251xfd_irq() {
	if (priv->rx_int)
		do {
			rx_pending = gpiod_get_value_cansleep(priv->rx_int);
			if (!rx_pending)
				break;
			...
			err = mcp251xfd_handle(priv, rxif);
			...
		} while (priv->rx_ring_num == 1);
	...
}

Each pass goes through
mcp251xfd_handle_rxif_one()->can_rx_offload_queue_timestamp(), which adds
the skb to offload->skb_irq_queue. The only admission check there looks
at skb_queue, not at skb_irq_queue:

can_rx_offload_queue_timestamp() {
	if (skb_queue_len(&offload->skb_queue) >
	    offload->skb_queue_len_max) {
		dev_kfree_skb_any(skb);
		return -ENOBUFS;
	}
	...
	__skb_queue_add_sort(&offload->skb_irq_queue, skb,
			     can_rx_offload_compare);
}

Nothing in this loop moves skbs to skb_queue or schedules NAPI, so the
check never fires.

rx_ring_num is 1 whenever rx_obj_num <= MCP251XFD_FIFO_DEPTH, for example
after "ethtool -G rx 32". If back-to-back frames on the bus keep the RX
FIFO non-empty, can skb_irq_queue still grow without bound here? That is
the problem the commit message describes.

Would it make sense to call can_rx_offload_threaded_irq_flush() inside
the RX-INT loop as well, or to count skb_irq_queue in the admission check?

[Severity: High]
This is the first caller of can_rx_offload_threaded_irq_flush(), and every
producer in this driver inserts into skb_irq_queue in timestamp order.
Can the saved flush_skb/flush_len pair go stale between the 1/2 call and
the 3/4 call?

can_rx_offload_threaded_irq_flush() {
	...
	if (!offload->flush_skb) {
		offload->flush_skb = skb_peek_tail(&offload->skb_irq_queue);
		offload->flush_len = irq_queue_len;
	}
	...
	__skb_cut_position(&tmp_queue, &offload->skb_irq_queue,
			   offload->flush_skb, offload->flush_len);
	...
}

__skb_cut_position() cuts by pointer, but it takes both qlen values from
the caller and never counts the list:

	list->qlen = qlen;
	...
	head->qlen -= qlen;

Between the two calls, __skb_queue_add_sort() puts a new skb in front of
flush_skb whenever its timestamp is older. In mcp251xfd this seems to
happen routinely:

- mcp251xfd_handle_rxovif() queues an error skb stamped with a live TBC
  read from mcp251xfd_alloc_can_err_skb(). On the next pass, the frames
  still in the full RX FIFO sort in front of it.
- With TX IRQ coalescing, TEF echo skbs from mcp251xfd_handle_tefif_one()
  carry older TX timestamps.
- With multiple RX FIFOs, frames from another ring can be older than the
  saved tail.

The preceding commit's own description expects older frames to be "added
to the queue at the correct position in the next loop".

If k skbs land in front of flush_skb, the cut moves flush_len + k skbs
but counts only flush_len. skb_irq_queue.qlen ends up k too high and
skb_queue.qlen k too low. Once NAPI drains skb_queue with skb_dequeue(),
skb_queue.qlen wraps to about 2^32 - k.

>From then on, can_rx_offload_queue_timestamp() sees
skb_queue_len(&offload->skb_queue) > skb_queue_len_max and frees every new
RX, TEF echo and error skb, even though skb_queue is actually empty.

If the cut left the skb_irq_queue list empty,
can_rx_offload_threaded_irq_finish() returns early:

	if (skb_queue_empty_lockless(&offload->skb_irq_queue))
		return;

skb_queue_empty_lockless() checks only the pointers, so the wrong qlen is
never handed back. Nothing else resets qlen, because
can_rx_offload_enable() only calls napi_enable().

Would this leave the interface unable to receive until the driver is
unbound?

There is also a possible NULL dereference. If a stale skb_irq_queue.qlen
on an empty list ever reached 3/4 of the max, skb_peek_tail() would
return NULL and __skb_cut_position() would dereference entry->next. That
needs k >= 384, which the FIFO depths make unlikely.

[Severity: Low]
This isn't a bug, but the kernel-doc of __skb_cut_position(), added in
the preceding commit, doesn't match the function body:

 * @entry: an entry within head, could be the head itself
 *	and if so we won't cut the list

The body has no entry == head check. If entry == (struct sk_buff *)head,
@list is left with list->next pointing at the first element and
list->prev pointing at head, while list->qlen is 0. skb_queue_empty(list)
then returns false for a list that isn't valid. list_cut_position(), where
this comment was copied from, handles that case with INIT_LIST_HEAD(list).

The only caller passes skb_peek_tail(), so this can't happen today. Could
the comment be corrected, or the check added?

[Severity: Low]
The kernel-doc of can_rx_offload_threaded_irq_flush() says that once
skb_irq_queue exceeds 3/4 of the maximum it will "flush about 1/2 of the
maximal queue length". The code instead flushes whatever was queued when
flush_skb was first saved:

	if (!offload->flush_skb) {
		offload->flush_skb = skb_peek_tail(&offload->skb_irq_queue);
		offload->flush_len = irq_queue_len;
	}

	if (irq_queue_len < offload->skb_queue_len_max * 3 / 4)
		return;

If the first call with qlen >= 1/2 max already sees qlen >= 3/4 max,
flush_skb is the current tail and the whole queue goes to NAPI.

One pass of the main loop can't cross both thresholds. It adds at most
about 112 skbs, and the gap between 256 and 384 is 128.

The RX-INT loop with rx_ring_num == 1, however, can queue any number of
skbs without flushing. The first flush from this call site in
mcp251xfd_irq() can then send everything to NAPI.

Would older TEF echo or error frames handled after that point then be
delivered after newer RX frames?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005-upstream-can-rx-offload-batching-alternative-v1-0-4c08ccb516ec%40pengutronix.de
