Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349208;
	b=rDD7YMCXICK7yAZPecdSXQr/50cYYno4nQFBrosSzcmPvcabBnJeHLYELU7Y8YjjdR9u
	 3JkEtWVWfAcyxH7raAHWdyR3AVjgstccHejFHpcAisWvXIQEWvOzDnMXeNezffc5V/mN1
	 2MmZD8vAzkOvreLow6muJE4ov8BOGPVAUz0mEKmCutsY8z+IuNO7jkUNZ9ENw20qKMVz+
	 EFb91Kg0y0sn7Ksoy6Tda6brIIC49EYnKjzeayCD9dJ22RGntx1T8eGMuDjNN9zzZtxkQ
	 6ct5Pemn7XJgDtX3YN9Bn7Jv1QIkcF5Syj4Chn6KPOOK1Y3ybMLdtYREsRws5WHDqMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349208;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WHUhu5CrTPS3k+DY1mA8grJeMiSQif97LjnO3u8quvU=;
	b=mk1pio7X1a9Tt7jFkZMBrC1kDAu5w9xql2P15YnnUrazfS926CpPaGvKyWs8SNdAvhy5
	 HwgtlKx5BAuPtg/mQIEbxCIMaLfQ5zmnqXg4gmFchIpro3tUBBVEGCgAXtAor2YesCUt/
	 Uk4XJ+3hPesEIx4MLzxV7QpdVqOtGlZojWbx70xF5Y8EkmPsExWJKmxCGLoMBvwM+EoWf
	 L6Sn1zQPyPeOM3aXeQGY1izCciR7Zd9QgPuYc4wcQ9TOwmaSIi5954l/cHohKqV/Uunol
	 scBqDcN0IkdOYfKUJHtp6aJEPxXXxaey2KWKdiRyMSZB9eokmk849JiWK/vKHsKpwkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZurL4o4u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5A606A321;
	Tue, 10 Nov 2026 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZurL4o4u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA91C1F008A3;
	Tue, 10 Nov 2026 22:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349207;
	bh=WHUhu5CrTPS3k+DY1mA8grJeMiSQif97LjnO3u8quvU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZurL4o4uTzvOfcydUraop4vAudOrGPVB5BitHMf787lWpxOD+qpw5nFs2b84kFWsT
	 DzE/1MKLM9MvYC1dJ5NHIM/H9ZJWLRfDreFD3smGSLa8nDFyAHvPkn++uF9l0k/ZPD
	 5F7/gunf32IOgrHfxT524tqmBKz/KC2msHmQ8nSv+3KKYwKpz7B57jsxlTbC4Gb2mG
	 8JeXwaVPeKNOFCm1DRS6RsxAoSgaQBDz+ATb+2DjSPjIa8X0gJFGSgyJOHssgXvMrg
	 /0lefUbtNSdU5DqLP5ruE5Vst/kPFZHah8CNB1Hbvl25iBCQDllHQxGCAW2hF2iv6o
	 Mx/wT9b0RxBFQ==
Subject: Re: [PATCH v9 2/2] can: loongson_canfd: Add RXDMA support
From: netdev-bot+sashiko@kernel.org
To: zhoubinbin@loongson.cn
Cc: zhoubb.aaron@gmail.com, chenhuacai@loongson.cn, mkl@pengutronix.de,
 mailhol@kernel.org, libingxiong@loongson.cn, chenhuacai@kernel.org,
 kernel@xen0n.name, loongarch@lists.linux.dev, linux-can@vger.kernel.org,
 jeffbai@aosc.io, kuba@kernel.org
Date: Tue, 10 Nov 2026 22:20:06 +0000
Message-ID: <179434920628.488853.259047582521353870@kernel.org>
In-Reply-To: <64b77b0ec6ba0c3f747d9ed73bd75e80502b2339.1794213427.git.zhoubinbin@loongson.cn>
References: <64b77b0ec6ba0c3f747d9ed73bd75e80502b2339.1794213427.git.zhoubinbin@loongson.cn>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 24 potential
issue(s) to consider.

Critical: 0 · High: 5 · Medium: 10 · Low: 9

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In DMA mode, the skb-allocation-failure path of
  loongson_canfd_rx_one_frame_dma() sets rx_rd_pos = saved_rd_pos + 1.
- [High] loongson_canfd_rxdma_start() only checks the result of
  dmaengine_prep_dma_cyclic() for NULL.
- [High] loongson_canfd_rx_is_empty_dma() never returns true in the
  normal drained state (rx_wr_pos == rx_rd_pos, FIFO idle), because…
- [High] loongson_canfd_rx_napi_done() now updates the DMA ring
  bookkeeping after napi_complete_done() has released NAPI ownership.
- [High] can: loongson_canfd: full-ring discard in
  loongson_canfd_rx_is_empty_dma()
- [Medium] loongson_canfd_dma_sync_wr() derives progress from the residue
  modulo the ring size.
- [Medium] The DMA RX path relies on dmaengine_tx_status() returning an
  exact, burst-granular, monotonic in-flight residue for the cyclic…
- [Medium] Nothing recovers RX if the DMA channel stops moving data.
- [Medium] loongson_canfd_do_set_mode(CAN_MODE_START) is reached from
  can_restart() via the restart work or a netlink restart.
- [Medium] When the reader loses frame alignment, the resync heuristics
  accept any word pair that passes loongson_canfd_hdr_plausible() as a…
- [Medium] The cyclic RX descriptor uses buf_len 32 KiB and period_len 4
  KiB.
- [Medium] The start and restart sequences do not match the driver's own
  DMA model.
- [Medium] REG_INT_STAT_DMADI is defined as 'Message DMA Transfer
  Complete Interrupt', a per-message CAN-controller event.
- [Medium] The RX ring is allocated with dma_alloc_coherent() on the CAN
  client device (ndev->dev.parent).
- [Medium] can: loongson_canfd: wrong check order in
  loongson_canfd_rx_napi_done()
- [Low] loongson_canfd_rx_overrun_event() now has a second caller,
  rx_napi_done(), which runs in softirq after napi_complete_done(), in…
- [Low] The patch is inconsistent about locking ndev->stats.rx_dropped.
- [Low] Several new comments contradict the code or each other: - The
  kernel-doc added to loongson_canfd_tx_interrupt() says 'RBNEI is…
- [Low] The commit message presents RX DMA as optional and says the
  driver falls back to FIFO polling, which implies FIFO mode is…
- [Low] The commit message claims DMA mode reduces MMIO accesses and
  improves RX throughput, with no measurements.
- [Low] Documentation does not match the code for rx_bad_cnt and
  -ENODATA.
- [Low] loongson_canfd_rx_one_frame_dma_overrun() documents an @avail
  parameter that it never uses.
- [Low] The new DMA RX path logs 'RX DMA overrun, resyncing'
  (rx_one_frame_dma_overrun()) and 'RX pointer inversion'…
- [Low] FIFO mode reads RX words through regmap-mmio, which by default
  uses readl() and converts from little-endian.

--

can: loongson_canfd: Add RXDMA support

This patch adds optional RX DMA support to the Loongson CAN-FD driver.
When an "rx" DMA channel is present, a cyclic DMA transfer moves frames
into a 32 KiB coherent ring, and the driver parses them from there
through new per-mode callbacks. Otherwise it uses the existing FIFO poll
path. The patch also reworks NAPI completion and adds handling for the
DMADI interrupt.

> When an "rx" DMA channel is available, incoming frames are moved into
> a ring buffer by a cyclic DMA transfer and read directly from there,
> reducing MMIO accesses and improving RX throughput under high traffic.

[Severity: Low]
Is the "reducing MMIO accesses" claim accurate for classic CAN frames?
Counting per frame in DMA mode:

loongson_canfd_rx_napi()
  loongson_canfd_rx_is_empty_dma()
    loongson_canfd_dma_sync_wr() -> dmaengine_tx_status()
        (provider spinlock, CCR and CNDTR reads)
    regmap_read(RX_STAT)
  loongson_canfd_rx_one_frame_dma()
    loongson_canfd_dma_sync_wr() -> dmaengine_tx_status()
        (spinlock, two more MMIO reads)

That comes to about five MMIO reads and two spinlock round trips per
frame. An 8-byte classic frame in FIFO mode costs about the same: RX_STAT,
two header words and two payload words. DMADI also adds a per-message
interrupt.

Are there measurements that could go into the commit message?

> The DMA path is fully transparent to the networking stack; the driver
> falls back to FIFO polling when no DMA channel is present.

[Severity: Low]
This reads as if FIFO mode is unchanged. However,
loongson_canfd_rx_napi_done() is rewritten for both modes.

With rx_ch == NULL it now calls loongson_canfd_rx_overrun_event() from
NAPI context and does an extra RX_STAT read. When RXFRC != 0 or RXE is
clear, it calls napi_schedule() instead of unmasking RBNEI. Before this
patch it only unmasked RBNEI.

Could the commit message mention this change to the FIFO path?

> diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_canfd.c
> index 7a4d8df7815ac..b5a5917bc7738 100644
> --- a/drivers/net/can/loongson_canfd.c
> +++ b/drivers/net/can/loongson_canfd.c

[ ... ]

> @@ -409,6 +418,17 @@ struct loongson_canfd_rx_desc {
>   * @tx_lock: Lock for synchronizing TX interrupt handling
>   * @stats_lock: Lock for protecting netdev statistics
>   * @hwts: Hardware timestamp state
> + * @rx_ch: DMA receive channel, NULL in poll mode
> + * @rx_cookie: DMA receive cookie
> + * @rx_dma_addr: DMA RX buffer bus address
> + * @rx_cpu_buf: DMA RX buffer CPU address
> + * @rx_rd_pos: Software read position, 64-bit monotonic, in 32-bit words
> + * @rx_wr_pos: DMA write position, 64-bit monotonic, wrap-extended
> + * @rx_wr_off: Last raw residue-derived ring offset, 0..RXDMA_NUM-1
> + * @rx_bad_cnt: Consecutive invalid RX headers seen in DMA mode

[Severity: Low]
This isn't a bug, but the description doesn't match the code.
rx_bad_cnt is only incremented after loongson_canfd_rx_deliver() returns
-ENOMEM, and every invalid-header path resets it to 0.

The same goes for loongson_canfd_rx_one_frame_dma(). Its kernel-doc says
-ENODATA means "a run of malformed frames was detected", but it is
returned for a single zero or unresolvable header. Its -ENOMEM path also
returns 1 ("one frame consumed") while advancing only one word.

Could the documentation be updated to match?

[ ... ]

> @@ -504,6 +539,213 @@ static void loongson_canfd_disable_interrupts(struct loongson_canfd_priv *priv)
>  	regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, REG_INT_MASK_SET);
>  }
>
> +/**
> + * loongson_canfd_dma_sync_wr() - Refresh the 64-bit DMA write position

[ ... ]

> +static void loongson_canfd_dma_sync_wr(struct loongson_canfd_priv *priv)
> +{
> +	struct dma_tx_state state;
> +	u32 off;
> +
> +	if (!priv->rx_ch)
> +		return;
> +
> +	if (dmaengine_tx_status(priv->rx_ch, priv->rx_cookie, &state) !=
> +	    DMA_IN_PROGRESS)
> +		return;

[Severity: Medium]
Any status other than DMA_IN_PROGRESS returns silently, so a channel
fault looks the same as "no progress yet". For example, the CMC provider
only logs a TEI with dev_err() and never completes the cookie.

If the channel stops moving data, nothing reads RX_DATA over MMIO in DMA
mode. The FIFO then stays non-empty while rx_wr_pos stays frozen:

loongson_canfd_rx_is_empty_dma()    returns false (RXFRC > 0)
loongson_canfd_rx_one_frame_dma()   returns -EAGAIN
loongson_canfd_rx_napi_done()
	/* FIFO still holds data: keep NAPI scheduled, RBNEI stays masked */
	napi_schedule(napi);

Is there a way to recover RX in this state? As written, NAPI seems to
reschedule itself forever on one CPU.

> +
> +	if (state.residue > LOONGSON_CANFD_RXBUF_SZ)
> +		state.residue = LOONGSON_CANFD_RXBUF_SZ;
> +
> +	off = (LOONGSON_CANFD_RXBUF_SZ - state.residue) /
> +	      DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	off %= LOONGSON_CANFD_RXDMA_NUM;

[Severity: Medium]
Each sample can only add between 0 and RXDMA_NUM - 1 words. Suppose the
cyclic DMA writes RXDMA_NUM words or more between two samples, for
example because NAPI was delayed by about 32 KiB of bus traffic. Then
rx_wr_pos is undercounted by a multiple of the ring size, and exactly one
lap looks like no progress at all.

In that case, can the avail > LOONGSON_CANFD_RXDMA_NUM overrun check in
loongson_canfd_rx_one_frame_dma() ever fire? Without it, overwritten slots
get parsed with the wrong frame alignment.

When an overrun is detected, loongson_canfd_rx_one_frame_dma_overrun()
does:

	priv->rx_rd_pos = priv->rx_wr_pos - LOONGSON_CANFD_RXDMA_NUM + 2;

That puts the reader only two words ahead of the next DMA write slot, and
not on a frame boundary.

> +
> +	if (off < priv->rx_wr_off)
> +		/* The DMA engine wrapped around the end of the ring. */
> +		priv->rx_wr_pos += LOONGSON_CANFD_RXDMA_NUM -
> +				   priv->rx_wr_off + off;
> +	else
> +		priv->rx_wr_pos += off - priv->rx_wr_off;
> +
> +	priv->rx_wr_off = off;
> +}

[Severity: Medium]
This treats any backward step of off as a full wrap, which assumes the
residue is exact and monotonic.

loongson2-apb-cmc-dma never sets ddev->residue_granularity, so it reports
DMA_RESIDUE_GRANULARITY_DESCRIPTOR. loongson_canfd_rxdma_setup() doesn't
check dma_get_slave_caps() before choosing DMA mode.

The provider's residue also mixes the live CNDTR with the software
next_sg, and next_sg only advances in its IRQ handler:

	ndtr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CNDTR, lchan->id);
	residue = ndtr << width;
	...
	for (i = next_sg; i < desc->num_sgs; i++)
		residue += desc->sg_req[i].len;

If CNDTR reloads at terminal count, a sample taken between TC and the IRQ
comes out one period too large. Would that be treated as a wrap here,
pushing rx_wr_pos ahead by about 7168 words?

> +
> +/**
> + * loongson_canfd_read_rx_word_dma() - Read one word from the DMA buffer
> + * @priv: Driver private data
> + *
> + * Consumes the next word from the cyclic ring and advances rx_rd_pos.
> + *
> + * Return: The next 32-bit data word.
> + */
> +static u32 loongson_canfd_read_rx_word_dma(struct loongson_canfd_priv *priv)
> +{
> +	u32 idx = priv->rx_rd_pos % LOONGSON_CANFD_RXDMA_NUM;
> +
> +	priv->rx_rd_pos++;
> +	return priv->rx_cpu_buf[idx];
> +}

[Severity: Low]
FIFO mode reads RX_DATA through regmap-mmio, which uses readl() and
converts from little-endian. Here the same words come from the ring as a
native unsigned int, with no le32_to_cpu().

On a big-endian kernel, would the DMA path see byte-swapped headers and
payload compared with the FIFO path? CAN_LOONGSON_CANFD only depends on
HAS_IOMEM.

The same applies to loongson_canfd_ring_peek() and the direct
rx_cpu_buf[] reads in loongson_canfd_rx_is_empty_dma().

[ ... ]

> +static int loongson_canfd_rxdma_init(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	struct device *dev = ndev->dev.parent;
> +	struct dma_slave_config config;
> +	int ret;
> +
> +	if (!priv->rx_ch)
> +		return -ENODEV;
> +
> +	priv->rx_cpu_buf = dma_alloc_coherent(dev, LOONGSON_CANFD_RXBUF_SZ,
> +					      &priv->rx_dma_addr, GFP_KERNEL);

[Severity: Medium]
Should this buffer be allocated against the DMA controller, using
dmaengine_get_dma_device(priv->rx_ch), rather than ndev->dev.parent?

The CMC engine is the device that writes the ring, and its CMAR/CPAR
registers are only 32 bits wide. The driver never limits the DMA mask to
match. If the CAN node's DMA mask, dma-ranges or IOMMU setup differs from
the controller's, could the engine write to a truncated or wrong address?

loongson_canfd_rxdma_free() would need the same change.

[ ... ]

> +static int loongson_canfd_rxdma_start(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	struct dma_async_tx_descriptor *desc;
> +
> +	if (!priv->rx_ch)
> +		return 0;
> +
> +	priv->rx_rd_pos = 0;
> +	priv->rx_wr_pos = 0;
> +	priv->rx_wr_off = 0;
> +	priv->rx_bad_cnt = 0;
> +
> +	desc = dmaengine_prep_dma_cyclic(priv->rx_ch, priv->rx_dma_addr,
> +					 LOONGSON_CANFD_RXBUF_SZ,
> +					 LOONGSON_CANFD_RXDMA_PERIOD,
> +					 DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);

[Severity: Medium]
With buf_len at 32 KiB and period_len at 4 KiB, loongson2-apb-cmc-dma
doesn't use hardware circular mode, because it only sets CCR_CIRC when
buf_len == period_len. Instead it builds 8 sg entries and advances them
from its channel IRQ handler: it clears CCR_EN, writes CMAR, then sets
CCR_EN again.

So at every 4 KiB boundary, for the whole TC-to-IRQ latency, the channel
either isn't servicing the CAN DMA request or is still writing to the old
CMAR. The RX FIFO is only 80 bytes. Can one FD frame arriving in that gap
overflow it?

No callback is installed, so the per-period DMA_PREP_INTERRUPT doesn't
seem to be needed. Would a single 8192-item period, which is under the
64K item limit, select true circular mode instead?

> +	if (!desc) {
> +		netdev_err(ndev, "RX DMA cyclic prep failed\n");
> +		return -EBUSY;
> +	}
> +
> +	priv->rx_cookie = dmaengine_submit(desc);

[Severity: High]
Can desc be an ERR_PTR here? loongson2_cmc_dma_prep_dma_cyclic() is the
provider named in MODULE_SOFTDEP, and it returns ERR_PTR on failure:

	desc = kzalloc_flex(*desc, sg_req, num_periods, GFP_NOWAIT);
	if (!desc)
		return ERR_PTR(-ENOMEM);

An ERR_PTR passes the !desc check, and dmaengine_submit() then
dereferences desc->tx_submit. This path runs from ndo_open, and from
do_set_mode(CAN_MODE_START) in the bus-off restart work.

Would IS_ERR_OR_NULL() be the right check here?

> +	if (dma_submit_error(priv->rx_cookie)) {
> +		netdev_err(ndev, "RX DMA submit failed\n");
> +		return -EIO;
> +	}
> +
> +	dma_async_issue_pending(priv->rx_ch);
> +
> +	/* Skip zero-fill produced before the controller is enabled */
> +	loongson_canfd_dma_sync_wr(priv);
> +	priv->rx_rd_pos = priv->rx_wr_pos;

[Severity: Medium]
This comment implies the engine can produce zero-fill while the
controller is disabled. If so, only the zeros written before this one
sync are skipped. Zeros written between here and chip_start() setting
REG_CONF_ENA would stay in the ring.

The first real frame would then land behind those zeros.
loongson_canfd_rx_is_empty_dma() or loongson_canfd_rx_one_frame_dma_bad_hdr()
would see a zero header and do:

	priv->rx_rd_pos = priv->rx_wr_pos;

Could that silently drop the first frames after an open or a restart?

Also, loongson_canfd_do_set_mode() calls loongson_canfd_reset() before
loongson_canfd_rxdma_stop(). That soft-resets the controller while its
DMA is still reading RX_DATA. Is that ordering intended?

[ ... ]

> @@ -995,15 +1245,29 @@ static void loongson_canfd_chip_stop(struct net_device *ndev)
>   */
>  static int loongson_canfd_do_set_mode(struct net_device *ndev, enum can_mode mode)
>  {
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
>  	int ret;
>
>  	switch (mode) {
>  	case CAN_MODE_START:
>  		loongson_canfd_reset(ndev);
>
> +		/*
> +		 * The FIFO starts from scratch; DMA and CPU read pointer
> +		 * must be realigned with the new FIFO start.
> +		 */
> +		loongson_canfd_rxdma_stop(priv);
> +
> +		ret = loongson_canfd_rxdma_start(ndev);

[Severity: Medium]
do_set_mode(CAN_MODE_START) is reached from can_restart(), through either
the restart work or a netlink restart. At that point NAPI is still
enabled and may be polling. What serializes this against
loongson_canfd_rx_napi()?

loongson_canfd_rxdma_start() resets rx_rd_pos, rx_wr_pos, rx_wr_off and
rx_cookie with plain stores. Meanwhile the poll may be inside
loongson_canfd_dma_sync_wr(), or rolling rx_rd_pos back to a saved_rd_pos
taken before the restart. Between terminate and resubmit, the old cookie
can also report residue 0, which loongson_canfd_dma_sync_wr() reads as a
wrap.

can_restart() assumes nothing is in flight during bus-off. Here, though,
err_state_change() neither stops the chip nor disables NAPI, and NAPI may
still be rescheduling itself. Could either interleaving leave rx_wr_pos
permanently offset from the real DMA position?

[ ... ]

> @@ -1435,6 +1698,247 @@ static int loongson_canfd_rx_deliver(struct net_device *ndev,
>  	}
>
>  	netif_receive_skb(skb);
> +	return 0;
> +}

[ ... ]

> +static bool loongson_canfd_rx_is_empty_dma(struct loongson_canfd_priv *priv)
> +{
> +	u32 rx_stat;
> +	u32 idx, h0, h1;
> +
> +	loongson_canfd_dma_sync_wr(priv);
> +
> +	if (priv->rx_wr_pos < priv->rx_rd_pos)
> +		goto discard;
> +
> +	regmap_read(priv->regmap, LOONGSON_CANFD_RX_STAT, &rx_stat);
> +
> +	/* A complete frame is waiting in the FIFO */
> +	if (FIELD_GET(REG_RX_STAT_RXFRC, rx_stat))
> +		return false;
> +
> +	/* FIFO holds a partial frame the DMA engine is still moving */
> +	if (!(rx_stat & REG_RX_STAT_RXE))
> +		return false;
> +
> +	/* Header pair not yet fully resident: let NAPI retry */
> +	if (priv->rx_wr_pos < priv->rx_rd_pos + 2)
> +		return false;

[Severity: High]
loongson_canfd_rx_is_empty_dma() runs before process_rx() on every
iteration of loongson_canfd_rx_napi(). Once the FIFO has drained
(RXFRC == 0, RXE set), any zero or implausible word pair at rx_rd_pos
makes it set rx_rd_pos = rx_wr_pos and return true. That discards
every unread word in the ring, up to the full 32 KiB, and no counter
is updated.

This seems to defeat the recovery paths in
loongson_canfd_rx_one_frame_dma().
loongson_canfd_rx_one_frame_dma_overrun() moves rx_rd_pos to
rx_wr_pos - RXDMA_NUM + 2 and returns 0, expecting the next iteration
to resync through loongson_canfd_rx_one_frame_dma_bad_hdr(). That
position is almost never a frame boundary.

If the FIFO is empty on the next iteration, the implausible pair is
seen here first and the whole ring is dropped. The forward scan in
loongson_canfd_rx_one_frame_dma_bad_hdr() never gets to run.

This function also never checks whether rx_wr_pos - rx_rd_pos exceeds
RXDMA_NUM. An overrun that is first noticed here is therefore dropped
silently, and rx_over_errors and rx_errors are never incremented.

Zero words sitting ahead of real frames behave the same way. This path
and both zero-header branches in
loongson_canfd_rx_one_frame_dma_bad_hdr() realign on rx_wr_pos. Any
valid frames the DMA has already written behind the zeros are lost as
well.

Should loongson_canfd_rx_is_empty_dma() only report emptiness and
leave resynchronization to process_rx()? And should these discards be
counted somewhere, for example in rx_dropped?

[Severity: High]
Doesn't this also return false in the normal drained state, where
wr == rd and the FIFO is idle? No path returns true for wr == rd.

If so, every NAPI poll ends by running LOONGSON_CANFD_DMA_WAIT_RETRY_MAX
(100) -EAGAIN iterations in loongson_canfd_rx_napi(). Each iteration does
a dmaengine_tx_status() call and an RX_STAT read.

The same check also makes NAPI reschedule forever on a quiet bus when the
tail of the ring can't be consumed:

- wr - rd == 1, for example after the -ENOMEM path below.

- A resync lands on a plausible header whose payload never arrives, so
  loongson_canfd_rx_one_frame_dma() keeps rolling back:

	if (priv->rx_wr_pos - priv->rx_rd_pos < d.rwcnt - 2) {
		priv->rx_rd_pos = saved_rd_pos;
		return -EAGAIN;
	}

In both cases loongson_canfd_rx_napi_done() sees wr > rd and calls
napi_schedule() with no limit. Is there a timeout or fallback meant to
stop this?

[ ... ]

> +static int loongson_canfd_rx_one_frame_dma_overrun(struct net_device *ndev,
> +						   u64 avail)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	struct net_device_stats *stats = &ndev->stats;
> +	struct dma_tx_state dbg_state;
> +	u32 dbg_rx_stat = 0;
> +
> +	dmaengine_tx_status(priv->rx_ch, priv->rx_cookie, &dbg_state);
> +	regmap_read(priv->regmap, LOONGSON_CANFD_RX_STAT, &dbg_rx_stat);

[Severity: Low]
This isn't a bug, but dbg_state and dbg_rx_stat are read here and never
used, and the avail parameter is unused too. Can these be dropped?

The kernel-doc also says this resyncs "on the oldest still-valid word".
However, rx_wr_pos - RXDMA_NUM + 2 isn't a frame boundary, so the next
parse goes through the bad-header scan.

> +
> +	netdev_warn(ndev, "RX DMA overrun, resyncing\n");

[Severity: Low]
Neither this warning nor the "RX pointer inversion" warning in
loongson_canfd_rx_one_frame_dma() is rate limited. Both run from NAPI,
and bus flooding can trigger them. Should they use net_ratelimit(), as
the existing hardware overrun handler does?

[ ... ]

> +	/* Non-zero implausible header: scan forward for a plausible one */
> +	stats->rx_dropped++;

[Severity: Low]
This rx_dropped++ doesn't take stats_lock. Neither does the -ENOMEM path
in loongson_canfd_rx_one_frame_dma(), nor loongson_canfd_rx_note_bad().
On the other hand, loongson_canfd_rx_one_frame_dma_overrun() and the
pointer-inversion branch take stats_lock for the same counter.

All of these run in NAPI context. The unlocked updates only lose
increments if two polls overlap, which the rx_napi_done() window
described below makes possible. Could one scheme be used consistently?

> +
> +	for (tries = 0, pos = saved_pos + 1;
> +	     tries < 32 && pos + 1 < priv->rx_wr_pos;
> +	     tries++, pos++) {
> +		u32 h0 = loongson_canfd_ring_peek(priv, pos);
> +		u32 h1 = loongson_canfd_ring_peek(priv, pos + 1);
> +
> +		/* Zero-fill tail */
> +		if (h0 == 0 && h1 == 0) {
> +			loongson_canfd_dma_sync_wr(priv);
> +			priv->rx_rd_pos = priv->rx_wr_pos;
> +			priv->rx_bad_cnt = 0;
> +			return -ENODATA;
> +		}
> +
> +		if (loongson_canfd_hdr_plausible(h0, h1)) {
> +			priv->rx_rd_pos = pos;
> +			priv->rx_bad_cnt = 0;
> +			return 1;
> +		}
> +	}

[Severity: Medium]
The words scanned here are usually payload bytes sent by a remote node.
Once the reader has lost alignment, any word pair that passes
loongson_canfd_hdr_plausible() is accepted as a header. Alignment can be
lost through the -ENOMEM path's saved_rd_pos + 1, an overrun resync, or
the pointer races.

Could a remote node embed a plausible header in a frame's data? Once the
reader is desynchronized, the host would deliver a frame with an ID and
data that were never sent on the bus. That could get around ID-based
filtering done upstream, for example at a gateway.

[ ... ]

> +	ret = loongson_canfd_rx_deliver(ndev, &d);
> +	if (ret != -ENOMEM)
> +		return 1;
> +
> +	stats->rx_dropped++;
> +	priv->rx_rd_pos = saved_rd_pos + 1;
> +	if (++priv->rx_bad_cnt >= 64) {
> +		priv->rx_rd_pos = priv->rx_wr_pos;
> +		priv->rx_bad_cnt = 0;
> +		return -ENODATA;
> +	}
>  	return 1;
>  }

[Severity: High]
loongson_canfd_rx_deliver() returns -ENOMEM before reading any payload,
so rx_rd_pos is saved_rd_pos + 2 at this point. Setting it to
saved_rd_pos + 1 leaves the reader on hdr1 of a frame that was already
validated.

Should this skip the whole frame instead? The FIFO path does that with
loongson_canfd_rx_note_bad(ndev, d.rwcnt).

Take a 2-word frame (RTR, or classic with DLC=0) at the tail of the ring.
After this path rd = saved + 1 and wr = saved + 2:

loongson_canfd_rx_is_empty_dma()
	if (priv->rx_wr_pos < priv->rx_rd_pos + 2)
		return false;
loongson_canfd_rx_one_frame_dma()
	if (avail < 2)
		return -EAGAIN;
loongson_canfd_rx_napi()
	100 cpu_relax() retries, then completes
loongson_canfd_rx_napi_done()
	if (priv->rx_wr_pos > priv->rx_rd_pos) {
		napi_schedule(napi);

Can this keep one CPU spinning in softirq, with RBNEI still masked, until
another frame arrives?

For longer frames, (hdr1, payload0) gets parsed as the next header.
Depending on FIFO state, that either discards the whole ring in
loongson_canfd_rx_is_empty_dma() or sends the reader into the payload
scan in loongson_canfd_rx_one_frame_dma_bad_hdr().

Also, rx_bad_cnt is reset to 0 on the valid-header path just above. Can
the ++priv->rx_bad_cnt >= 64 bail-out ever fire?

[ ... ]

> @@ -1532,20 +2036,52 @@ static bool loongson_canfd_rx_overrun_event(struct net_device *ndev)

[ ... ]

>  	if (!can_complete || !napi_complete_done(napi, work_done))
>  		return;
>
> -	regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK,
> -		     FIELD_PREP(REG_INT_MASK_CLR, REG_INT_STAT_RBNEI));
> +	/*
> +	 * Catch a DMADI that was swallowed while SCHED was still set,
> +	 * and a stale partial header that rx_is_empty_dma() skipped.
> +	 */
> +	if (priv->rx_ch) {
> +		loongson_canfd_dma_sync_wr(priv);
> +		if (priv->rx_wr_pos > priv->rx_rd_pos) {
> +			napi_schedule(napi);
> +			return;
> +		}
> +	}

[Severity: High]
NAPI ownership has already been released by napi_complete_done() at this
point. DMADI is never masked and fires for every message. Can an
interrupt on another CPU, or preemption on PREEMPT_RT, start a second
poll in this window? That poll would run
loongson_canfd_rx_is_empty_dma() -> loongson_canfd_dma_sync_wr() at the
same time as this code.

loongson_canfd_dma_sync_wr() does an unlocked read-modify-write:

	if (off < priv->rx_wr_off)
		priv->rx_wr_pos += LOONGSON_CANFD_RXDMA_NUM -
				   priv->rx_wr_off + off;
	else
		priv->rx_wr_pos += off - priv->rx_wr_off;

	priv->rx_wr_off = off;

If both contexts compute the delta from the same old rx_wr_off, the delta
gets added twice. rx_wr_pos would then stay ahead of the real DMA
position. Would stale ring contents from the previous lap be parsed as
new frames until the next restart?

> +
> +	/*
> +	 * Flush an overrun latched while DOI was masked (e.g. during
> +	 * NAPI). DOR is sticky and the handler is idempotent, so this
> +	 * costs one regmap_read in the common case.
> +	 */
> +	loongson_canfd_rx_overrun_event(ndev);

[Severity: Medium]
The order of these checks seems to leave a window. The ring is sampled
first through loongson_canfd_dma_sync_wr(). Then
loongson_canfd_rx_overrun_event() and the RX_STAT read run, and only
after that is RBNEI unmasked.

Suppose a frame is still in the hardware FIFO when
loongson_canfd_dma_sync_wr() runs, so rx_wr_pos == rx_rd_pos. The DMA
engine keeps running and can move that frame into the ring before
RX_STAT is read. RX_STAT then shows RXFRC == 0 with RXE set, so RBNEI
is unmasked and the function returns.

The FIFO is already empty by then, so no empty -> non-empty edge will
follow. rx_wr_pos is not sampled again after the unmask.

A frame of 8 to 72 bytes doesn't cross a 4 KiB period boundary. If
DMADI only fires once per period, as the new chip_start() comment
says, nothing reschedules NAPI. Wouldn't that frame sit unread in the
ring until the next frame arrives on the bus?

Would it work to read RX_STAT and unmask RBNEI first, and only then
re-sync rx_wr_pos and reschedule if rx_wr_pos > rx_rd_pos? Or does
DMADI really fire for every message, which would cover this case?

[Severity: Low]
loongson_canfd_rx_overrun_event() now also runs here in softirq, as well
as from the hardirq DOI handler. The ISR masks DOI around its own call,
but that doesn't exclude this caller.

If both read the sticky DOR bit before either one writes REG_CMD_CDO,
would a single overrun be counted twice in rx_over_errors and rx_errors,
and produce two CAN_ERR_CRTL_RX_OVERFLOW frames? The handler is only
idempotent for sequential calls.

[ ... ]

> @@ -1847,6 +2410,10 @@ static void loongson_canfd_err_interrupt(struct net_device *ndev, u32 isr)
>   * optional HW TX timestamp) and counts it sent; TX_BS_FAIL and
>   * TX_BS_CANCEL free the skb as dropped. Clears the completion record
>   * per slot and wakes the queue if a buffer became free.
> + *
> + * RBNEI is serviced by masking it, resuming the paused RX DMA channel
> + * (no-op in poll mode) and scheduling NAPI. DMADI is never enabled, so
> + * no DMA completion IRQ is expected in the RX path.
>   */

[Severity: Low]
This isn't a bug, but this comment doesn't match the code.
loongson_canfd_tx_interrupt() doesn't touch RBNEI or the DMA channel.
chip_start() enables DMADI, the ISR handles DMADI, and there is no
pause/resume.

A few other comments also disagree with the code or with each other:

- loongson_canfd_rxdma_start() and loongson_canfd_rx_is_empty_dma() say
  the engine stalls on an empty RX_DATA. Yet there are several "DMA
  zero-fill" recovery paths, and rxdma_start() skips zero-fill.

- The kernel-doc of loongson_canfd_rx_overrun_event() and its "Hard IRQ:
  use netif_rx()" comment still describe a hard-IRQ-only caller.
  loongson_canfd_rx_napi_done() now also calls it from NAPI.

[ ... ]

> @@ -1977,6 +2549,13 @@ static irqreturn_t loongson_canfd_interrupt(int irq, void *dev_id)
>  			napi_schedule(&priv->napi);
>  		}
>
> +		if (isr & REG_INT_STAT_DMADI) {
> +			/* W1C: fresh data in the ring, schedule NAPI */
> +			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT,
> +				     REG_INT_STAT_DMADI);
> +			napi_schedule(&priv->napi);
> +		}

[Severity: Medium]
REG_INT_STAT_DMADI is described as the "Message DMA Transfer Complete
Interrupt", so it looks like a per-message event. Unlike RBNEI, it is
never masked while NAPI is running.

Under high traffic, does this raise a hardware IRQ for every received
frame even while NAPI is polling? That would work against NAPI interrupt
mitigation.

The comment added to loongson_canfd_chip_start() says DMADI fires "once
per cyclic period", which doesn't seem to match.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794213427.git.zhoubinbin%40loongson.cn
