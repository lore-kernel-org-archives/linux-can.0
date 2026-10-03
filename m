Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48E154785;
	Sat,  3 Oct 2026 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791063390; cv=none; b=UvOhbOtIAuUuBGe7hkrb/ULIzGyhLeWU3HKLY41w3cx8exIAdrNCUz8uSn1nD2acmuJ1AzfZIp+0ySuoobgDGrIVgMkD3NLW2yD5ATiP1Zs1nmEl+7SG6N/UDUE8M1UX8A2W8UFpVFaAvOV8NXTj6sf8bSGQ94o7yhBF3ONcsW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791063390; c=relaxed/simple;
	bh=oeADwhY+ha3t1xIOj5Oi2fdV6c1SmsdT3fXI1k6tsx0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nbXzkeUScV78pt9VWPI3BlnlhjfL8mOr2ULLQYdjmxm3OH2a5CsV2rh293ERBrs10cd/CIGomdTHQS8tK+Bhqmqg/Vc53ORbaFkiPXSek9Oc9Ak0+JJNSQ/USdEaWDeWPK9AWvAWB7T8nb2U+lgK9jZ/kVLgMwigmKrkwkPi+m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baP4vsup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baP4vsup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB071F0089C;
	Sat,  3 Oct 2026 21:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791063388;
	bh=VPw9IUST4MTI4NDpxhmLwBIOZI2fEhJtaK02pXVE9+c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=baP4vsupBvKIxNxg0+cnwTt45K/cw8YIYShfomiDt5Q6hJeDI9W24iNBd2sgZhYqc
	 wHZ/tl9h8AL8PtIGs2naElgaAKFKZWM8iRmPN6Q/rt4nTA87NmfbzviTrdFGxIXRHI
	 +JdAHGZJ0FCObNIJIfhdxKruscmwGjOkZw3j+GXhk9/rzmPTrj5/5wUOKaKXHruLXW
	 +nguRx+Ze2Kpp6TMv9x6pdIfW7/n/syvnDdbyvRO4A4FTVYckFMUUQx9/jRfbNyNL8
	 eGfxsl4sSNYyXJzYA9RyA0FU/3Y2zYKxnqBa8fg3IHU5CXaYQiovmDQNRnmJN1KeP7
	 2bODg3M90dE1A==
Subject:
 Re: [PATCH v7 4/4] can: flexcan: use one rx-offload source per IRQ line
From: netdev-bot+sashiko@kernel.org
To: ciprianmarian.costea@oss.nxp.com
Cc: mkl@pengutronix.de, mailhol@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, haibo.chen@nxp.com,
 linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, s32@nxp.com, imx@lists.linux.dev,
 eballetb@redhat.com, kuba@kernel.org
Date: Sat, 03 Oct 2026 21:36:27 +0000
Message-ID: <179106338718.1406898.9181099617806406362@kernel.org>
In-Reply-To: <20261002071203.1287650-5-ciprianmarian.costea@oss.nxp.com>
References: <20261002071203.1287650-5-ciprianmarian.costea@oss.nxp.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Concurrent handlers can still corrupt the shared rx-offload
  queue through the TX-completion path, which is the bug class the…
- [Medium] In flexcan_irq() (drivers/net/can/flexcan/flexcan-core.c), the
  per-line source's skb_irq_queue is only flushed when `handled` is set…
- [Low] The patch has `Fixes: 8503a4b1a24d ("can: flexcan: add NXP
  S32G2/S32G3 SoC support")`, so stable trees that carry S32G2 support…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it remains
  after it.
- [Medium] This problem wasn't introduced by this patch, but concurrent
  S32G2 handlers still race on shared CAN state and statistics.

--

can: flexcan: use one rx-offload source per IRQ line

This patch adds an rx-offload source with can_rx_offload_add_source() for
each extra FlexCAN IRQ line: bus off, error and the secondary mailbox line.
flexcan_irq() picks the source from the IRQ number and passes it to the
functions that queue skbs, so concurrent handlers on S32G2 no longer corrupt
the shared rx-offload queue. flexcan_mailbox_read() now gets the private
data through netdev_priv() instead of container_of().

> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
> index f5d22c61503fa..2ef06ed0c7449 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c

[ ... ]

> @@ -932,7 +934,7 @@ static void flexcan_irq_state(struct net_device *dev, u32 reg_esr)
>  	if (unlikely(new_state == CAN_STATE_BUS_OFF))
>  		can_bus_off(dev);
>  
> -	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
> +	err = can_rx_offload_queue_timestamp(offload, skb, timestamp);
>  	if (err)
>  		dev->stats.rx_fifo_errors++;
>  }

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch.
Concurrent S32G2 handlers still race on the shared CAN state here.

With FLEXCAN_QUIRK_BROKEN_PERR_STATE, flexcan_irq_state() runs on every
call on every line. It compares the new_state from its own ESR snapshot
with priv->can.state, without a lock:

	/* state hasn't changed */
	if (likely(new_state == priv->can.state))
		return;

can_change_state() then does a plain priv->state = new_state.

Can two CPUs see the same transition? If so, both would queue an error
frame, both would bump can_stats and both would call can_bus_off().

Could a handler with an older ESR snapshot replace a newer
CAN_STATE_BUS_OFF with CAN_STATE_ERROR_WARNING?

The BROKEN_PERR_STATE block at the end of flexcan_irq() has a similar
problem. It calls flexcan_error_irq_enable() or flexcan_error_irq_disable()
based on unlocked snapshots of last_state and priv->can.state. Both
functions write a full CTRL value built from reg_ctrl_default. Can the last
writer leave ERR_MSK out of step with the final state?

The dev->stats and can_stats counters (tx_bytes, tx_packets, rx_errors,
rx_fifo_errors, rx_dropped, bus_error) are also plain read-modify-write
updates from several hardirq contexts, so increments can be lost.

[ ... ]

> @@ -1120,7 +1141,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>  
>  		handled = IRQ_HANDLED;
>  		stats->tx_bytes +=
> -			can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload, 0,
> +			can_rx_offload_get_echo_skb_queue_timestamp(offload, 0,
>  								    reg_ctrl << 16, NULL);
>  		stats->tx_packets++;
>  

[Severity: High]
Can two handlers still race on the echo skb here?

flexcan_open() requests flexcan_irq() on dev->irq, irq_boff, irq_err and
irq_secondary_mb. Every call reads flexcan_read_reg_iflag_tx(). The TX
iflag is cleared only after the echo skb has been taken:

		flexcan_write64(priv, priv->tx_mask, &regs->iflag1);
		netif_wake_queue(dev);

So two handlers on different CPUs can both see the TX bit, and both go
down this path:

flexcan_irq()
  can_rx_offload_get_echo_skb_queue_timestamp(offload, 0, ...)
    __can_get_echo_skb(dev, 0, ...)

__can_get_echo_skb() checks priv->echo_skb[idx] and clears the slot only
later, with no lock or xchg. Both CPUs can therefore get the same skb.

For a PACKET_LOOPBACK skb, each CPU adds it with __skb_queue_add_sort() to
its own source's skb_irq_queue. can_rx_offload_move_to_skb_queue() later
merges both into the shared queue->skb_queue. Would that link the same skb
into one list twice, so that NAPI passes a freed skb to
netif_receive_skb()?

For an echo skb that is not PACKET_LOOPBACK, both CPUs would call
dev_consume_skb_any() on it.

There is a related interleaving. The late handler could pick up a new echo
skb that flexcan_start_xmit() queued after the first handler's
netif_wake_queue(). It would then write FLEXCAN_MB_CODE_TX_INACTIVE to
tx_mb, aborting a transmission that was already reported as sent.

The echo handling itself is older than this patch. However, the commit
message says this fixes concurrent handlers corrupting the shared
rx-offload queue. Should the TX completion handling (or the whole handler)
be serialized across lines, rather than only splitting the staging queues?

[ ... ]

> @@ -1143,12 +1164,12 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>  	if ((reg_esr & FLEXCAN_ESR_ERR_STATE) ||
>  	    (priv->devtype_data.quirks & (FLEXCAN_QUIRK_BROKEN_WERR_STATE |
>  					   FLEXCAN_QUIRK_BROKEN_PERR_STATE)))
> -		flexcan_irq_state(dev, reg_esr);
> +		flexcan_irq_state(dev, offload, reg_esr);
>  

[ ... ]

> @@ -1189,7 +1210,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev_id)
>  	}
>  
>  	if (handled)
> -		can_rx_offload_irq_finish(&priv->offload);
> +		can_rx_offload_irq_finish(offload);
>  
>  	return handled;
>  }

[Severity: Medium]
Can a state-change skb get stuck in a per-line source here?

nxp_s32g2_devtype_data has FLEXCAN_QUIRK_BROKEN_PERR_STATE, so the
flexcan_irq_state() call above runs on every call, whatever ESR contains.
If new_state differs from priv->can.state, flexcan_irq_state() queues an
error skb with can_rx_offload_queue_timestamp(offload, ...). It does this
even when handled is still IRQ_NONE.

handled can stay IRQ_NONE when a handler on another line has already acked
all RX, TX and ESR interrupt bits. Two cases reach this path:

  - a passive to warning/active transition, which raises no interrupt
  - a concurrent handler that has not updated can.state yet

Before this patch, the skb sat in priv->offload.skb_irq_queue, and the next
handled interrupt on any line flushed it.

Now flexcan_get_offload() sends it to offload_boff, offload_err or
offload_secondary_mb. Only can_rx_offload_irq_finish() on that same source
drains it, or can_rx_offload_del() purges it at close.

On the bus-off or error line, could the state-change frame stay stuck for
an arbitrarily long time? When it is finally merged, its stale timestamp
would sort it against frames that were already delivered, so it would
arrive out of order.

can_rx_offload_irq_finish() already returns early when skb_irq_queue is
empty. Would calling it unconditionally avoid this?

[ ... ]

> @@ -1381,6 +1402,15 @@ static void flexcan_ram_init(struct net_device *dev)
>  	priv->write(reg_ctrl2, &regs->ctrl2);
>  }
>  
> +static int flexcan_rx_offload_add_source(struct flexcan_priv *priv,
> +					 struct can_rx_offload *source)
> +{
> +	source->mb_first = priv->offload.mb_first;
> +	source->mb_last = priv->offload.mb_last;

[Severity: High]
This isn't a bug introduced by this patch, but it remains after it. Every
extra source gets the full primary mailbox range here, and the RX loop in
flexcan_irq() runs on every line:

		while ((reg_iflag_rx = flexcan_read_reg_iflag_rx(priv))) {
			...
			ret = can_rx_offload_irq_offload_timestamp(offload,
								   reg_iflag_rx);

Nothing serializes flexcan_mailbox_read() between CPUs. The FlexCAN read
sequence assumes a single reader:

  - reading C/S locks the MB
  - the ID and data are copied
  - IFLAG is cleared
  - reading the free running timer unlocks the MB, globally

Suppose two handlers both have bit n in their IFLAG snapshot. Can both of
them read MB n? The CODE stays RX_FULL after a read, so the second reader
passes this check and delivers the frame a second time:

		if ((code != FLEXCAN_MB_CODE_RX_FULL) &&
		    (code != FLEXCAN_MB_CODE_RX_OVERRUN))
			return NULL;

Another CPU can read priv->read(&regs->timer) from flexcan_mailbox_read(),
flexcan_irq_state() or flexcan_irq_bus_err(). Could that unlock the MB
while this CPU is still copying it, so the hardware overwrites it mid-copy?

Could the second reader's late clear

	flexcan_write64(priv, FLEXCAN_IFLAG_MB(n), &regs->iflag1);

wipe the IFLAG of a newer frame that arrived after the first reader
unlocked the MB? Later scans would then miss that frame.

The commit message defers this to a follow-up series ("All handlers still
process the whole mailbox range"). Until then, the S32G2 support named in
the Fixes: tag can deliver duplicated, torn or lost CAN frames.

> +
> +	return can_rx_offload_add_source(&priv->offload, source);

[Severity: Low]
can_rx_offload_add_source() only exists once these earlier patches in the
series are applied:

  can: rx-offload: move skb_queue and napi into struct can_rx_offload_queue
  can: rx-offload: allow more than one receive source

The fix also relies on two things from those patches: the per-source
offload->queue linkage, and the locked merge in
can_rx_offload_move_to_skb_queue().

Neither of those patches has a Fixes: or Cc: stable tag. This commit has:

  Fixes: 8503a4b1a24d ("can: flexcan: add NXP S32G2/S32G3 SoC support")

If stable selects this patch only through the Fixes: tag, will the build
fail? A hand backport could also leave out the merge logic that actually
stops the corruption.

Would it help to add Cc: stable@vger.kernel.org, with dependency notes for
both rx-offload patches?

> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002071203.1287650-1-ciprianmarian.costea%40oss.nxp.com
