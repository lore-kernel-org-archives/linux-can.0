Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8D833AD88;
	Sat,  3 Oct 2026 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791063388; cv=none; b=rLjglL3lwpQg0FHqRiOymvCIhwy9/Bgl6zbHu71v/0wfvVRcMWFecKJFsDcit3Od7RzYCAdp2D/NeqqKLpXlSh66101H1UfcQRziyeVp3EEoIk4xH5WZGvaZzzNzg55s0n9v8q6jMfGptshixBnlgQBir2i0Qeud0Yi2WVqf49A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791063388; c=relaxed/simple;
	bh=y3gwCaXkzHFF6dv0Bl/98bdu5mQY0MXw+44JNmN0inM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GPEi8KyG8QcLvwmAc+lbf8DQzWRHqIEnxsVUrvk4C5Dk7aaGGkuxsLEOuQAzwVN76apWdZu3MqOxOHouFhlXuBRta1nIRsp7eTckcDtVbVmMlwU9yFfiME2r1AeXIdU7gw/BSbuF7NYsVmpboFOhAaTab3dGq1afNcxCovBvogk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gvcb6y8l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gvcb6y8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553FE1F0089B;
	Sat,  3 Oct 2026 21:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791063387;
	bh=+2Zfs3PcsP+d5BdM1qvovFHJjOfUJVTAnK9KsR5VRvQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Gvcb6y8l0nJy4nDvsFrpg8JkXEMdaTMDxhauZHiWn+Gi33KSpgAwcURUv5acAc649
	 K4k4Kry3ip1wY/NNqQOIM1XdnV4u+HBhU5NMjtTrfw+NsFvYrQ4QAgNz+ofCQzas1H
	 CuhcF3uzzQIImy/C1p4IE2nSt0rRLRo/omT/PJ3dSV2fVTq+vp+4a1/NYPLRbVGtEm
	 OPyxkoFc1u5Q+pd8tt0AQmf4IfcLWT4V5va9uJGomYzJScd/mUOBIpZghJlgFw274V
	 MVLNWgg5wZvTaDqF1Wd88FydVpd+jJ8sjH7MW+xquA5OHPVkphI7CXmWN7hKUoHM4K
	 r4AgnrvVerWJg==
Subject:
 Re: [PATCH v7 3/4] can: rx-offload: allow more than one receive source
From: netdev-bot+sashiko@kernel.org
To: ciprianmarian.costea@oss.nxp.com
Cc: mkl@pengutronix.de, mailhol@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, haibo.chen@nxp.com,
 linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, s32@nxp.com, imx@lists.linux.dev,
 eballetb@redhat.com, kuba@kernel.org
Date: Sat, 03 Oct 2026 21:36:25 +0000
Message-ID: <179106338585.1406898.13675590689657020972@kernel.org>
In-Reply-To: <20261002071203.1287650-4-ciprianmarian.costea@oss.nxp.com>
References: <20261002071203.1287650-4-ciprianmarian.costea@oss.nxp.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 4 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In can_rx_offload_move_to_skb_queue() the comment says the
  sorted merge will 'keep the timestamp order over all sources', but it…
- [Low] Concern: the commit message describes a live S32G2 flexcan bug,
  but the patch only adds can_rx_offload_add_source() and nothing calls…
- [Low] can_rx_offload_add_source() calls
  can_rx_offload_init_mb_range(source, &weight), then never uses the…
- [Low] queue->sort is set only by can_rx_offload_add_timestamp(), so
  with several FIFO-mode or manual-mode sources each source's…
- [Low] can_rx_offload_add_source() does not check whether @source is
  already linked.

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but
  can_rx_offload_init_mb_range() (previously inline in…
- [Low] This problem wasn't introduced by this patch, but several sources
  share dev->stats, and can_rx_offload_offload_one(),…

--

can: rx-offload: allow more than one receive source

This commit lets a CAN device have several rx-offload sources, one per
producer such as an IRQ line. All of them share one can_rx_offload_queue,
which the primary source owns. A new can_rx_offload_add_source() attaches
extra sources, and the IRQ finish helpers move each source's skb_irq_queue
into the shared skb_queue under skb_queue.lock, sorting by timestamp when
several sources run in timestamp mode.

> diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
> index 92309ed47bac5..5352d70b6e93c 100644
> --- a/drivers/net/can/dev/rx-offload.c
> +++ b/drivers/net/can/dev/rx-offload.c
> @@ -304,18 +304,40 @@ can_rx_offload_get_echo_skb_queue_tail(struct can_rx_offload *offload,
>  }
>  EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb_queue_tail);
>  
> -void can_rx_offload_irq_finish(struct can_rx_offload *offload)
> +/* Sources may run on different CPUs at the same time, skb_queue.lock
> + * serializes them.
> + */

[Severity: Low]
This is a pre-existing issue, but the sources also share
offload->dev->stats. can_rx_offload_offload_one(),
can_rx_offload_get_echo_skb_queue_timestamp() and
can_rx_offload_get_echo_skb_queue_tail() update these counters with plain
increments from IRQ context:

drivers/net/can/dev/rx-offload.c:can_rx_offload_offload_one() {
    ...
	if (IS_ERR(skb)) {
		offload->dev->stats.rx_dropped++;
		offload->dev->stats.rx_fifo_errors++;
    ...
}

When sources run on different CPUs, can these increments get lost?

flexcan already ran these helpers from several IRQ lines at once before
this series. The only effect is slightly wrong drop and error counters.

> +static void can_rx_offload_move_to_skb_queue(struct can_rx_offload *offload)
>  {
>  	struct can_rx_offload_queue *queue = offload->queue;
>  	unsigned long flags;
> +
> +	spin_lock_irqsave(&queue->skb_queue.lock, flags);
> +
> +	if (queue->source_cnt > 1 && queue->sort) {
> +		/* keep the timestamp order over all sources */
> +		struct sk_buff *skb;
> +
> +		while ((skb = __skb_dequeue(&offload->skb_irq_queue)))
> +			__skb_queue_add_sort(&queue->skb_queue, skb,
> +					     can_rx_offload_compare);

[Severity: Medium]
Does this really keep the timestamp order over all sources?

__skb_queue_add_sort() only orders the frames that are in queue->skb_queue
at the moment of the merge. can_rx_offload_napi_poll() drains that queue
independently of the producers:

drivers/net/can/dev/rx-offload.c:can_rx_offload_napi_poll() {
    ...
	while ((work_done < quota) &&
	       (skb = skb_dequeue(&queue->skb_queue))) {
		...
		netif_receive_skb(skb);
	}
    ...
}

With two sources on different CPUs:

CPU0 (source A)                  CPU1 (source B)
                                 reads frame ts=10 into skb_irq_queue
                                 still busy in RX loop, TX complete or
                                 ESR handling
reads frame ts=20
can_rx_offload_irq_finish()
  merges ts=20, napi_schedule()
NAPI delivers ts=20
                                 can_rx_offload_irq_finish()
                                   merges ts=10
NAPI delivers ts=10

Can CAN frames reach the stack out of timestamp order this way?

With the next patch in the series, S32G2 in timestamp mode runs all four
flexcan sources through flexcan_irq() concurrently. That configuration
meets the queue->source_cnt > 1 && queue->sort condition.

skb_queue.lock only serializes the list manipulation. Nothing holds back
delivery until the other sources have merged their older frames.

If full ordering isn't achievable here, should the comment and the commit
message describe the narrower guarantee?

> +	} else {
> +		skb_queue_splice_tail_init(&offload->skb_irq_queue,
> +					   &queue->skb_queue);
> +	}

[Severity: Low]
Only can_rx_offload_add_timestamp() sets queue->sort. With several
FIFO-mode or manual-mode sources, each skb_irq_queue is therefore just
appended here. That happens even when a driver ordered its frames with
can_rx_offload_queue_timestamp().

The commit message documents this ("Otherwise they append it").

At the end of the series, the only in-tree FIFO multi-source user is
flexcan on mcf5441x (FLEXCAN_QUIRK_NR_IRQ_3). That part is uniprocessor
m68k, so its handlers never run in parallel.

Would it make sense to state in the kerneldoc of
can_rx_offload_add_source() that ordering across sources is not kept in
FIFO and manual mode, for future SMP users?

[ ... ]

> @@ -350,6 +369,16 @@ void can_rx_offload_threaded_irq_finish(struct can_rx_offload *offload)
>  }
>  EXPORT_SYMBOL_GPL(can_rx_offload_threaded_irq_finish);
>  
> +static void can_rx_offload_link_source(struct can_rx_offload_queue *queue,
> +				       struct can_rx_offload *offload)
> +{
> +	offload->queue = queue;
> +	__skb_queue_head_init(&offload->skb_irq_queue);
> +
> +	list_add_tail(&offload->node, &queue->sources);
> +	queue->source_cnt++;
> +}

[Severity: Low]
Nothing here checks whether offload is already on a sources list.

Suppose can_rx_offload_add_source() is called twice for the same source
with no can_rx_offload_del() in between. Wouldn't that reinitialize a live
skb_irq_queue, count the source twice in source_cnt, and call
list_add_tail() on a node that is already linked? The node could end up
pointing at itself, and then the list_for_each_entry_safe() loop in
can_rx_offload_del() would never finish.

No in-tree path does this. At the end of the series, flexcan calls
can_rx_offload_del(&priv->offload) in flexcan_close() and on every failure
path before flexcan_open() adds the sources again. can_rx_offload_init_queue()
also resets the list.

Would a defensive check against adding the same source twice be worth
having?

[ ... ]

> @@ -357,41 +386,65 @@ static int can_rx_offload_init_queue(struct net_device *dev,

[ ... ]

> -int can_rx_offload_add_timestamp(struct net_device *dev,
> -				 struct can_rx_offload *offload)
> +static int can_rx_offload_init_mb_range(struct can_rx_offload *offload,
> +					unsigned int *weight)
>  {
> -	unsigned int weight;
> -
>  	if (offload->mb_first > BITS_PER_LONG_LONG ||
> -	    offload->mb_last > BITS_PER_LONG_LONG || !offload->mailbox_read)
> +	    offload->mb_last > BITS_PER_LONG_LONG)
>  		return -EINVAL;

[Severity: Low]
This isn't a bug introduced by this patch, but the bound check moved here
accepts mb_first or mb_last equal to BITS_PER_LONG_LONG (64).
can_rx_offload_irq_offload_timestamp() walks the range inclusively and
does:

		if (!(pending & BIT_ULL(i)))
			continue;

so i == 64 would be an out-of-range shift. Should these checks use >=?

No in-tree driver passes 64 today. flexcan uses mb_count - 2, at91 uses
rx_last, and ti_hecc uses at most HECC_MAX_MAILBOXES - 1.

[ ... ]

> @@ -416,6 +469,46 @@ int can_rx_offload_add_manual(struct net_device *dev,
>  }
>  EXPORT_SYMBOL_GPL(can_rx_offload_add_manual);
>  
> +/**

[ ... ]

> +int can_rx_offload_add_source(struct can_rx_offload *primary,
> +			      struct can_rx_offload *source)
> +{

[Severity: Low]
This isn't a bug, but the commit message describes a live S32G2 flexcan
problem, while nothing in this commit calls can_rx_offload_add_source()
and there is no Fixes: tag.

This is resolved later in the series. The next patch, "can: flexcan: use
one rx-offload source per IRQ line", does the following:

- adds the extra sources in flexcan_rx_offload_setup()
- picks the source per IRQ via flexcan_get_offload()
- switches flexcan_mailbox_read() to netdev_priv(offload->dev)
- carries Fixes: 8503a4b1a24d ("can: flexcan: add NXP S32G2/S32G3 SoC
  support")

So adding the infrastructure first and the user next looks fine.

> +	struct can_rx_offload_queue *queue = primary->queue;
> +	unsigned int weight;
> +	int err;
> +
> +	if (queue != &primary->own_queue || !queue->source_cnt ||
> +	    source == primary)
> +		return -EINVAL;
> +
> +	if (queue->sort) {
> +		err = can_rx_offload_init_mb_range(source, &weight);
> +		if (err)
> +			return err;
> +	}
> +
> +	source->dev = primary->dev;
> +	source->mailbox_read = primary->mailbox_read;
> +	source->skb_queue_len_max = primary->skb_queue_len_max;

[Severity: Low]
The weight that can_rx_offload_init_mb_range() computes for source is
never used. skb_queue_len_max is copied from the primary, and the shared
NAPI weight is not adjusted. So the drop limit and the NAPI weight depend
only on the primary's mailbox range.

This matches the commit message ("inherits the mode, netdev, queue length
limit and mailbox_read() of the primary"). Later in the series,
flexcan_rx_offload_add_source() copies the primary's mb_first and mb_last
into every source, so the limit fits there.

A driver that split its mailboxes into a small primary range and a larger
secondary range would get an undersized shared limit, though.

Should the unused weight be dropped, or is it meant to feed into
skb_queue_len_max?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002071203.1287650-1-ciprianmarian.costea%40oss.nxp.com
