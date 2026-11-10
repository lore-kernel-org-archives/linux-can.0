Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349207;
	b=36NTPiT9QolaWN+AaMymVpeOaL82Q7r2dPeH3HFF37icvQ5UbRXobxtQpNVaJuOvznta
	 fMqF26oD67IeB2B0POoFNaJKMUunN9D3QaIbVvgHSrM5H0tdkzhdaFvZutUkfS73q5XUa
	 qruWaIlF6Q/z58VnjhXb8f4dGTs6xryxUYVZBeYX5Ce3r/3hQmvTi6LGpbbZRTS+jvDza
	 Cfm5jxtU8UeekH7KE/gPvqhNJ+RmB9Oa0rCOwsWtZLSO5pU9s0/l7nlNQHNdmFsSg2dYP
	 aHW5vTLouevbQBz1jfeuxanLHevaqe+TUwv/x0VVnornFGTHEcYjlxWkKmTGwubka5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349207;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6UNSwMYAye3pva/O8ElubViRi86TOVB5rx07mvOC2Eg=;
	b=39SHCOvH9V56TCDXQXP4TpBPZtBhLwkuXpv4vdVHXIEOTiQ5kVQxT6WdcT2o55C3hkag
	 9AKKClIymsHNbybFkqjJRE7LXvLY76pat4RZhpfWNTUXGbeV2CO4vqcXMFtIiEkvYjvBr
	 HRE7moUmq5EQ/INpjeZj9LTml28Cw/MbG+v8/7xpt1SffqBaVYng2UDKQm5L3JHQsSPd5
	 ZwxakRjRlR/KUTXO3JpvszFPB549rdz8zcChVaQFshIecR5qek6EkjEaMzReZ82SPi4F0
	 73K3fjRXAHSF+pXmrowDixhizfDHpKOktO87Xb03KathIFkB6JNj/NILX1vBZ670hyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z79ysiIr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B62C606A32E;
	Tue, 10 Nov 2026 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z79ysiIr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC041F008A2;
	Tue, 10 Nov 2026 22:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349206;
	bh=6UNSwMYAye3pva/O8ElubViRi86TOVB5rx07mvOC2Eg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z79ysiIrVkA1H2eJKe8y4U7YxORVhl3Vh7IcPPSIcAdIPvO47WqRPpu4a95LcoZEE
	 9o3JZRpNzPJj+LEZZu2nI99mxX2JbHFANMjeJFfcbWZc7k3C5AW0h0er4T4oCNxdXl
	 ShlM8rOARiIc9nLQgh0DBj2kWWXs5yx/KIpzOafTrIV/fE7+s3AvPwuHnMxh3FIboD
	 bOMz/W1u4QhPnV4FyFsT/y33T9+lAge4tebd38gOY5kmHp8EcshffmXb9UMhpHm2o3
	 bKW2t3uBOMTDOKd2vaTlpMlwpaHWCPDxkN799veeQPE4hBMJuoxfCGH5Q4dkeURkDz
	 bRTi5CfRAlmFQ==
Subject: Re: [PATCH v9 1/2] can: Add Loongson CAN-FD controller driver
From: netdev-bot+sashiko@kernel.org
To: zhoubinbin@loongson.cn
Cc: zhoubb.aaron@gmail.com, chenhuacai@loongson.cn, mkl@pengutronix.de,
 mailhol@kernel.org, libingxiong@loongson.cn, chenhuacai@kernel.org,
 kernel@xen0n.name, loongarch@lists.linux.dev, linux-can@vger.kernel.org,
 jeffbai@aosc.io, kuba@kernel.org
Date: Tue, 10 Nov 2026 22:20:04 +0000
Message-ID: <179434920488.488853.9133751637375007655@kernel.org>
In-Reply-To: <a8291518fe60279a18c15393daf3ed3660bcfa5c.1794213427.git.zhoubinbin@loongson.cn>
References: <a8291518fe60279a18c15393daf3ed3660bcfa5c.1794213427.git.zhoubinbin@loongson.cn>
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

Thank you for your contribution! Sashiko AI review found 28 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 18 · Low: 9

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Use-after-free in loongson_canfd_start_xmit()
  (drivers/net/can/loongson_canfd.c:2077-2080).
- [Medium] loongson_canfd_rx_deliver() (line 1397) sets `cfd->flags = 0;`
  after alloc_canfd_skb() has set `(*cfd)->flags = CANFD_FDF`, and only…
- [Medium] In loongson_canfd_report_state_change(), the
  CAN_STATE_ERROR_ACTIVE case (line ~1705) sets only CAN_ERR_CNT in…
- [Medium] loongson_canfd_set_btr() (line 750) only moves the excess when
  phase_seg1 > 63 (REG_BTR_PH1).
- [Medium] Teardown ordering in loongson_canfd_close() (line 2152) leaves
  a window.
- [Medium] Bus-off restart races with the TX IRQ on echo_skb[].
- [Medium] Bus-off recovery leaves the netdev in a stale state.
- [Medium] The TX path does not reject CAN XL skbs, so it reads past the
  packet data.
- [Medium] The hardirq handler loongson_canfd_interrupt() loops while
  INT_STAT != 0 for up to 10000 iterations.
- [Medium] ndev->stats is updated with inconsistent locking.
- [Medium] Several statistics are counted in the wrong place.
- [Medium] Flow control and buffer allocation disagree on what 'free'
  means.
- [Medium] Echoes can be delivered out of order.
- [Medium] Normal mode has a retransmission limit.
- [Medium] RX resynchronisation ignores the hardware's frame boundaries.
- [Medium] TXBHCI handling can lose a completion.
- [Medium] The 'lost interrupt' force-free in tx_interrupt() relies on a
  non-atomic status view.
- [Medium] The 'hardware' TX timestamps are not hardware-latched, and the
  timebase is steered toward CLOCK_REALTIME.
- [Medium] can: loongson_canfd: broken REGCACHE_MAPLE config on banked TX
  and FIFO registers
- [Low] loongson_canfd_report_state_change() increments
  can_stats.error_warning/error_passive/bus_off on every transition into…
- [Low] In loongson_canfd_tx_interrupt(), a declaration comes directly
  after a case label: `case TX_BS_VALID:` is immediately followed by…
- [Low] Hardware-timestamping state is reported inconsistently.
- [Low] loongson_canfd_hwts_setup() rewrites
  hwts->cc.read/mask/mult/shift (two separate stores in…
- [Low] loongson_canfd_tx_interrupt() decides `wake =
  loongson_canfd_txbuf_freed(priv)` under tx_lock but calls…
- [Low] loongson_canfd_set_secondary_sample_point() has a
  CAN_CTRLMODE_TDC_MANUAL branch that can never run.
- [Low] In loongson_canfd_reset() (line 727), the kernel-doc says 'The
  reset bit does not self-clear on this silicon', but the code still…
- [Low] Two comments do not match the code.
- [Low] can: loongson_canfd: tautological SFF ID check in
  loongson_canfd_hdr_plausible()

--

can: Add Loongson CAN-FD controller driver

This commit adds a driver for the CAN-FD controller in Loongson-2K SoCs.
It supports CAN 2.0B and CAN FD with NAPI RX, TX echo, error reporting
and the usual ctrlmodes. It also exposes a 16-bit free-running counter
as hardware RX/TX timestamps.

> diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_canfd.c
> new file mode 100644
> index 0000000000000..7a4d8df7815ac
> --- /dev/null
> +++ b/drivers/net/can/loongson_canfd.c
> @@ -0,0 +1,2414 @@

[ ... ]

> +	/* Whole windows lost: re-lock, do not slew (stamps must stay monotonic) */
> +	if (dev >= (s64)hwts->window_ns / 2 ||
> +	    dev <= -(s64)hwts->window_ns / 2) {
> +		timecounter_init(&hwts->tc, &hwts->cc, ktime_get_real_ns());
> +		return;
> +	}
> +
> +	if (dev > -LOONGSON_CANFD_HWTS_SLEW_BAND_NS &&
> +	    dev < LOONGSON_CANFD_HWTS_SLEW_BAND_NS)
> +		return;
> +
> +	timecounter_adjtime(&hwts->tc, dev >> LOONGSON_CANFD_HWTS_SLEW_SHIFT);
> +}

[ ... ]

> +static ktime_t loongson_canfd_hwts_now(struct loongson_canfd_priv *priv)
> +{
> +	struct loongson_canfd_hwts *hwts = &priv->hwts;
> +
> +	/* Sample first: the counter is the earlier of the two instants */
> +	return loongson_canfd_hwts_ts(priv, (u32)hwts->cc.read(&hwts->cc));
> +}

[Severity: Medium]
The commit message says the driver "exposes the counter as hardware RX/TX
timestamps". loongson_canfd_get_ts_info() also advertises
SOF_TIMESTAMPING_TX_HARDWARE and SOF_TIMESTAMPING_RAW_HARDWARE.

Is that accurate for TX? loongson_canfd_tx_interrupt() takes its stamp
from loongson_canfd_hwts_now(), which reads the free-running counter live
at whatever moment the ISR reaches the buffer. That reading includes IRQ
latency and the time spent scanning the other buffers. The comment in
tx_interrupt() itself says the controller latches no per-frame TX stamp.

Also, loongson_canfd_hwts_anchor() slews tc.nsec by a signed dev >> 3 and
re-initializes it from ktime_get_real_ns() on a half-window deviation.
Can the reported raw hardware timebase step backwards here, even though
the comment above says stamps must stay monotonic?

Should the commit message mention these limitations?

> +	hwts->cc.read = loongson_canfd_hwts_read_cycles;
> +	hwts->cc.mask = CYCLECOUNTER_MASK(LOONGSON_CANFD_HWTS_COUNTER_BITS);
> +	clocks_calc_mult_shift(&hwts->cc.mult, &hwts->cc.shift,
> +			       tick_hz, NSEC_PER_SEC, 60);
> +
> +	hwts->window_ns = cyclecounter_cyc2ns(&hwts->cc,
> +					      hwts->cc.mask + 1, 0, &frac);

[Severity: Low]
These fields, along with tick_ns and psc above, are written outside
hwts->lock. Only timecounter_init() runs under the lock.

On the bus-off restart path, can_restart()->do_set_mode()->chip_start()->
hwts_setup(), NAPI or the TX IRQ may already have passed the
READ_ONCE(hwts.ready) check. They can then be inside
loongson_canfd_hwts_ts() reading tc.cc->mult, shift and window_ns under
the lock.

Is this a data race on state that is documented as protected by
hwts->lock? On restart the values are usually rewritten with the same
numbers, so in practice this would mostly show up under KCSAN.

> +/**
> + * loongson_canfd_reset() - Issue soft reset to controller
> + * @ndev: Network device
> + *
> + * The reset bit does not self-clear on this silicon; the mode write
> + * below re-programs the register, so a timeout is only logged.
> + */

[ ... ]

> +	ret = regmap_read_poll_timeout(priv->regmap, LOONGSON_CANFD_MODE,
> +				       val, !(val & REG_MODE_RST),
> +				       10, 10 * USEC_PER_MSEC);

[Severity: Low]
The kernel-doc says the reset bit does not self-clear, but this still
polls for up to 10ms waiting for it to clear.

If the comment is right, doesn't every open() and every CAN_MODE_START
restart busy-wait the full 10ms? If the bit does clear, should the
comment be updated?

[ ... ]

> +	/* PROP is 7 bits but PH1 only 6; move the excess into PROP */
> +	if (phase1 > ph1_max) {
> +		prop += phase1 - ph1_max;
> +		phase1 = ph1_max;
> +	}
> +
> +	if (nominal) {
> +		btr = FIELD_PREP(REG_BTR_PROP, prop) |

[Severity: Medium]
What happens when prop_seg alone is larger than REG_BTR_PROP
(GENMASK(6, 0), so at most 127)?

Both bittiming_const tables use tseg1_max = 190. can_fixup_bittiming()
only checks prop_seg + phase_seg1 against tseg1_max. A manual setting
such as "prop-seg 150 phase-seg1 10" is therefore accepted, and
FIELD_PREP(REG_BTR_PROP, 150) masks it to 22 at runtime.

Would the controller then run with a different bit timing than the one
reported to userspace? can_calc_bittiming() never produces these values,
so this needs a manual setting.

[ ... ]

> +	if (ctrlmode & CAN_CTRLMODE_TDC_MANUAL)
> +		/* Manual TDC: 2'd2, delay = SSP_OFF */
> +		ssp_cfg = FIELD_PREP(REG_SSP_CFG_SRC, 2) |
> +			  FIELD_PREP(REG_SSP_CFG_OFF, priv->can.fd.tdc.tdco);

[Severity: Low]
This isn't a bug, but can this branch ever run?

ctrlmode_supported in loongson_canfd_setup_can_priv() includes only
CAN_CTRLMODE_TDC_AUTO, and the netlink code rejects unsupported ctrlmode
bits. In addition, can_calc_tdco() only ever sets TDC_AUTO, and tdc_const
has tdcv_min = tdcv_max = 0.

[ ... ]

> +/**
> + * loongson_canfd_get_auto_tdcv() - Get transmitter delay compensation value
> + * @ndev: Network device
> + * @tdcv: Pointer to store TDCV value
> + *
> + * Return: 0 on success, -EOPNOTSUPP on CAN_CTRLMODE_TDC_AUTO is not set.
> + */

[ ... ]

> +	/* Hardware measurement is complete only when TRV_DLY is not 0 */
> +	if (!*tdcv)
> +		return -EAGAIN;

[Severity: Low]
This isn't a bug, but the kernel-doc does not list the -EAGAIN return.

The TXBHCI comment in loongson_canfd_interrupt() has a similar mismatch.
It refers to "the W1C in tx_interrupt()", but the INT_STAT write is in
the ISR right before the call, not in loongson_canfd_tx_interrupt().

In the final patch of the series, the kernel-doc added to tx_interrupt()
also says "DMADI is never enabled", but chip_start() enables DMADI when
rx_ch exists.

[ ... ]

> +	/* RTRLE always on; ONE_SHOT only decides RTRTH */
> +	conf |= REG_CONF_RTRLE;
> +	conf |= LOONGSON_CANFD_FIELD_IF(ctrlmode & CAN_CTRLMODE_LOOPBACK,
> +					REG_CONF_ILBP);
> +	conf |= LOONGSON_CANFD_FIELD_IF(ctrlmode & CAN_CTRLMODE_FD_NON_ISO,
> +					REG_CONF_NISOFD);
> +	conf |= LOONGSON_CANFD_FIELD_IF(!(ctrlmode & CAN_CTRLMODE_ONE_SHOT),
> +					FIELD_PREP(REG_CONF_RTRTH,
> +						   LOONGSON_CANFD_MAX_RTXTH));

[Severity: Medium]
With the retransmission limit always enabled, doesn't normal (not
one-shot) mode give up after about 16 attempts and mark the buffer
TX_BS_FAIL? loongson_canfd_tx_interrupt() then frees the echo skb and
counts it in tx_dropped.

Without CAN_CTRLMODE_ONE_SHOT, the expected behaviour is unlimited
retransmission until success or bus-off. ctucanfd clears RTRLE in that
case.

A node with no ACK partner would silently lose frames well before it
reaches bus-off. So would a low-priority frame on a busy bus, if
arbitration loss counts as an attempt.

[ ... ]

> +	/* Need both BRP clear and BS idle; skip slots still echoing */
> +	for_each_clear_bit(i, &tx_brp, LOONGSON_CANFD_TXBUF_NUM) {
> +		u32 mask = 0x3 << (i * 2);
> +
> +		if (!(tx_bs & mask)) {
> +			if (priv->can.echo_skb[i])
> +				continue;
> +			return i;
> +		}
> +	}

[Severity: Medium]
Can frames be echoed, or even sent, in a different order from the one
they were submitted in?

This always picks the lowest-index free buffer, and
loongson_canfd_tx_interrupt() handles completions in index order 0..7.
Suppose frame A is in buffer 5 and a later frame B goes into buffer 0. If
both complete before one ISR pass, B is echoed before A.

The driver also programs no TX priority or ordering control (only BUFM at
reset), so the order on the wire may differ too.

The CAN stack expects in-order TX and echo; RECV_OWN_MSGS users such as
ISO-TP depend on it. ctucanfd rotates buffer priorities and tracks
head/tail indices for this reason.

[ ... ]

> +	words = rwcnt > 2 ?
> +		min_t(u32, rwcnt - 2,
> +		      CANFD_MAX_DLEN / LOONGSON_CANFD_DW_BYTE) : 0;
> +	while (words--)
> +		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);

[Severity: Medium]
Does this drain stay inside the rejected frame?

When loongson_canfd_rx_hdr_valid() sees RWCNT < 2, it substitutes the
worst-case length of 2 + 16. This loop then reads 16 words no matter what
the 80-byte FIFO actually holds. With RXBAM auto-advance, these reads
could run into the next frames and leave the cursor in the middle of a
frame.

After that, every later "header" would really be payload. Each one would
be rejected and trigger another fixed drain. A payload word pair that
happens to pass loongson_canfd_hdr_plausible() would be delivered as a
bogus frame.

REG_RX_STAT_RXMOF and REG_CMD_RRB are defined but never used. Would a
FIFO flush be a safer way to resync?

Also, loongson_canfd_rx_is_empty_fifo() treats RXFRC == 0 with RXE == 0
as non-empty. That means reading can start before any complete frame has
been committed. Is that intended? The FIFO mode code is unchanged in the
final patch of the series.

[ ... ]

> +	cfd->flags = 0;
> +
> +	if (d->is_can_fd) {
> +		if (d->hdr1 & REG_FRAME_META1_BRS)
> +			cfd->flags |= CANFD_BRS;
> +		if (d->hdr0 & REG_FRAME_META0_ESI)
> +			cfd->flags |= CANFD_ESI;

[Severity: Medium]
Doesn't this clear the CANFD_FDF flag that alloc_canfd_skb() sets?

include/uapi/linux/can.h says CANFD_FDF is set in all CAN FD frame
structures provided by the CAN subsystem. With this assignment, every FD
frame received through this driver reaches userspace without it.

[ ... ]

> +	if (!d->is_rtr)
> +		stats->rx_bytes += cfd->len;
> +	stats->rx_packets++;

[Severity: Medium]
stats_lock is documented as protecting ndev->stats.
loongson_canfd_rx_overrun_event() (hardirq) and
loongson_canfd_report_bus_error() update rx_packets, rx_bytes, rx_errors
and rx_over_errors under it.

Here in NAPI, the same counters are updated without the lock and with
IRQs enabled. loongson_canfd_rx_note_bad() does the same for rx_dropped,
and so does rx_one_frame_dma*() in the final patch.

Can a DOI interrupt that lands in the middle of this read-modify-write
lose increments? As written, the lock does not seem to protect anything.

[ ... ]

> +	priv->can.state = new_state;
> +
> +	/* Stats and BUS_OFF handling must not depend on skb allocation */
> +	switch (new_state) {
> +	case CAN_STATE_BUS_OFF:
> +		priv->can.can_stats.bus_off++;
> +		can_bus_off(ndev);
> +		break;

[Severity: Medium]
Can the bus-off restart race with the TX IRQ on echo_skb[]?

On bus-off only can_bus_off() is called. CONF_ENA, INT_ENA, NAPI and the
IRQ all stay active, and armed TX buffers are not cancelled.

When restart_ms is set, can_restart() calls can_flush_echo_skb() without
tx_lock. It relies on this comment in drivers/net/can/dev/dev.c:

	/* No synchronization needed because the device is bus-off and
	 * no messages can come in or go out.
	 */

The controller might report TX completions at that moment: FAIL or
CANCEL, or VALID after automatic recovery. In that case
loongson_canfd_tx_interrupt() on another CPU can call can_get_echo_skb()
or can_free_echo_skb() on the same slot.

Could that free an echo skb twice, or pass an already freed skb to
netif_rx()?

do_set_mode()->reset()/chip_start() also rewrites the MODE, CONF and INT
registers and can.state without tx_lock. xmit, NAPI or err_interrupt may
be running at the same time. Whether TXBHCI fires while bus-off depends
on the hardware.

> +	case CAN_STATE_ERROR_PASSIVE:
> +		priv->can.can_stats.error_passive++;
> +		break;
> +	case CAN_STATE_ERROR_WARNING:
> +		priv->can.can_stats.error_warning++;
> +		break;

[Severity: Low]
These counters are incremented on every transition into the state,
including improvements such as error-passive to error-warning. The
core's can_update_state_error_stats() counts only escalations:

	if (new_state <= priv->state)
		return;

Should this driver use the same semantics, for example by using
can_change_state()? As written, the IFLA_INFO_XSTATS counters mean
something different for this driver than for others.

[ ... ]

> +	case CAN_STATE_ERROR_ACTIVE:
> +		cf->can_id |= CAN_ERR_CNT;
> +		cf->data[1] = CAN_ERR_CRTL_ACTIVE;
> +		break;

[Severity: Medium]
data[1] only carries meaning when CAN_ERR_CRTL is set in can_id. Should
this be CAN_ERR_CRTL | CAN_ERR_CNT, the way can_change_state() does it?
Without the class bit, decoders that check it never see the return to
error-active.

The same function also counts transitions into warning, passive and
bus-off that are improvements, as described in the previous comment.

[ ... ]

> +	if (isr & (REG_INT_STAT_FCSI | REG_INT_STAT_EWLI)) {
> +		mask |= REG_INT_STAT_FCSI | REG_INT_STAT_EWLI;
> +		state = loongson_canfd_get_fault_state(ndev);
> +
> +		/*
> +		 * FCSI is latched on reset -> Error Active, but that is
> +		 * not a protocol-visible transition: filter it out.
> +		 */
> +		if (priv->can.state != state)
> +			loongson_canfd_report_state_change(ndev, state, &bec);
> +	}

[Severity: Medium]
What happens on the transition out of BUS_OFF?

Suppose the controller recovers automatically and raises FCSI.
loongson_canfd_report_state_change() then overwrites priv->can.state with
ACTIVE, WARNING or PASSIVE. However, carrier is never turned back on and
the queue is not woken; the driver has no netif_carrier_on() anywhere.

With restart-ms=0, the hardware may be back on the bus sending
still-armed buffers while the interface keeps carrier off. A manual
restart would then fail with -EBUSY, because can_restart_now() checks:

	if (priv->state != CAN_STATE_BUS_OFF)
		return -EBUSY;

Is down/up the only way to recover here?

[ ... ]

> +	scoped_guard(spinlock_irqsave, &priv->tx_lock) {
> +		regmap_read(priv->regmap, LOONGSON_CANFD_TX_STAT, &tx_stat);
> +
> +		for (unsigned int buf_id = 0; buf_id < LOONGSON_CANFD_TXBUF_NUM; buf_id++) {
> +			sts = loongson_canfd_get_txbuf_sts(priv, buf_id);
> +
> +			if (sts == TX_BS_IDLE) {
> +				/* BRP set: hardware still queued/arbitrating */
> +				if (tx_stat & BIT(buf_id))
> +					continue;
> +
> +				/*
> +				 * Hardware is idle but echo_skb is occupied
> +				 * (lost interrupt). Free it, but do not issue
> +				 * SR_CLEAN on an idle slot: it can fake a
> +				 * command interrupt and cause a storm.
> +				 */
> +				if (priv->can.echo_skb[buf_id]) {
> +					netdev_warn(ndev,
> +						    "TX buf %u idle but echo_skb occupied, force free\n",
> +						    buf_id);
> +					can_free_echo_skb(ndev, buf_id, NULL);
> +					stats->tx_dropped++;
> +				}
> +				continue;
> +			}

[Severity: Medium]
BRP comes from the tx_stat snapshot taken before the loop. BS comes from
a separate TX_STAT read inside loongson_canfd_get_txbuf_sts().

The hardware may clear BRP once arbitration is won and update BS only at
the end of the frame. Could a scan during that frame then see BRP clear
and BS idle, and free the echo of a frame that is still on the wire? Such
a scan could be triggered by the previous buffer's completion in a
back-to-back burst.

loongson_canfd_find_free_txbuf() would then hand out the slot.
loongson_canfd_start_xmit() could rewrite that buffer through TX_SEL and
TX_DATA while it is still being transmitted.

> +
> +			processed = true;
> +			switch (sts) {
> +			case TX_BS_VALID:
> +				u32 dummy_len;

[Severity: Low]
Does this build with older compilers? GCC before 11 rejects a
declaration directly after a case label:

  a label can only be part of a statement and a declaration is not a
  statement

Documentation/process/changes.rst lists GCC 8.1 as the minimum, and
CONFIG_CAN_LOONGSON_CANFD depends only on HAS_IOMEM. An allmodconfig
build with GCC 8 to 10 on any architecture would fail here. The final
patch in the series does not change this code. Adding braces around the
case body, or moving the declaration up, would avoid the error.

[ ... ]

> +				dummy_len = can_get_echo_skb(ndev, buf_id, NULL);
> +				(void)dummy_len;
> +				stats->tx_packets++;
> +				break;

[ ... ]

> +		wake = loongson_canfd_txbuf_freed(priv);
> +	}
> +
> +	if (wake)
> +		netif_wake_queue(ndev);
> +}

[Severity: Low]
wake is decided under tx_lock but acted on after the lock is dropped.

In between, loongson_canfd_start_xmit() on another CPU can fill the last
free buffer and call netif_stop_queue(). This would then wake a full
queue, and the next xmit would hit the "No free TX buffer while queue
was awake!" NETDEV_TX_BUSY path. The next completion recovers the queue.

[ ... ]

> +		if (isr & REG_INT_STAT_TXBHCI) {
> +			/*
> +			 * Mask-clear-handle-unmask: a TX completing during
> +			 * handling re-latches TXBHCI and fires a fresh IRQ
> +			 * after the unmask, instead of being wiped by the
> +			 * W1C in tx_interrupt().
> +			 */
> +			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK,
> +				     REG_INT_STAT_TXBHCI);
> +			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT,
> +				     REG_INT_STAT_TXBHCI);
> +			loongson_canfd_tx_interrupt(ndev);
> +			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK,
> +				     FIELD_PREP(REG_INT_MASK_CLR, REG_INT_STAT_TXBHCI));
> +		}

[Severity: Medium]
Does a masked source still latch into INT_STAT on this controller? The
comment depends on that. On CTU CAN FD style IP, which this register
layout resembles, masked interrupts are not captured.

If the same is true here, consider a buffer that completes after
tx_interrupt() has read its BS field but before the unmask. It would
raise no new interrupt. Its echo_skb would stay allocated, and
loongson_canfd_find_free_txbuf() would skip the slot until some unrelated
completion triggers another scan.

If that buffer held the last frame of a burst, could the echo and the
slot stay stuck indefinitely? The DOI path below has the same window.

[ ... ]

> +	netdev_err(ndev, "Interrupt loop timeout, state: 0x%x\n", isr);
> +
> +	if (isr & REG_INT_STAT_TXBHCI) {

[ ... ]

> +	loongson_canfd_disable_interrupts(priv);
> +
> +	return IRQ_HANDLED;
> +}

[Severity: Medium]
The loop in loongson_canfd_interrupt() keeps going while INT_STAT is
non-zero, for up to 10000 iterations. Each iteration does many MMIO
accesses and may allocate error skbs.

loongson_canfd_err_interrupt() unmasks BEI and ALI again on every pass.
With berr-reporting enabled, could a steady stream of bus errors keep
this hardirq loop running up to the limit?

Only RBNEI, TXBHCI, DOI and ERRORI are acknowledged (plus DMADI in the
final patch), so any other INT_STAT bit that is set would also spin to
the limit. loongson_canfd_chip_start() briefly unmasks every source with
REG_INT_MASK_CLR and never W1C-clears stale INT_STAT bits.

On timeout, only the interrupts are disabled. CONF_ENA stays set,
can.state, carrier and the queue are unchanged, and no recovery is
scheduled. Doesn't that leave the controller on the bus with RX and TX
completions never serviced again until ifdown/ifup?

[ ... ]

> +	if (can_dropped_invalid_skb(ndev, skb))
> +		return NETDEV_TX_OK;

[Severity: Medium]
Should this be can_dev_dropped_skb()? can_dropped_invalid_skb() accepts
valid ETH_P_CANXL skbs, and it does not enforce listen-only mode.

loongson_canfd_insert_frame() treats every skb that is not CAN FD as
Classic CAN. For a CAN XL frame, cf->len is really canxl_frame.flags,
which is always >= 0x80 because CANXL_XLF is set. That value then bounds
this loop:

	for (unsigned int i = 0; i < cf->len; i += LOONGSON_CANFD_DW_BYTE) {

The loop reads get_unaligned_le32(cf->data + i) far past the packet data
(skb->len can be as small as 13). It stops only when the regmap write
beyond max_register fails.

That failure then hits the netdev_err() below, which is not rate-limited,
once per packet. A CAP_NET_RAW user can inject such frames through
PF_PACKET. The buffer is never armed, so nothing reaches the bus.

> +
> +	guard(spinlock_irqsave)(&priv->tx_lock);
> +
> +	if (unlikely(!loongson_canfd_txbuf_freed(priv))) {
> +		netif_stop_queue(ndev);
> +		netdev_dbg(ndev, "No free TX buffer while queue was awake!\n");
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	buf_id = loongson_canfd_find_free_txbuf(priv);
> +	if (buf_id < 0) {
> +		netif_stop_queue(ndev);
> +		netdev_dbg(ndev, "No writable TX buffer, stopping queue\n");
> +		return NETDEV_TX_BUSY;
> +	}

[Severity: Medium]
loongson_canfd_txbuf_freed() treats any buffer with BRP clear as free.
loongson_canfd_find_free_txbuf() also requires BS to be idle and
echo_skb[] to be empty. The queue is stopped here, and woken in
tx_interrupt(), based on the weaker test.

Take a buffer that has just finished: BRP is clear, BS is VALID or FAIL,
and echo_skb is still held until the ISR cleans it up. In that window,
can xmit pass the first check and then return NETDEV_TX_BUSY from the
second one?

Should both checks use the same predicate?

[ ... ]

> +	can_put_echo_skb(skb, ndev, buf_id, 0);
> +
> +	if (!(cf->can_id & CAN_RTR_FLAG))
> +		stats->tx_bytes += cf->len;

[Severity: High]
Can this read freed memory? cf points into skb->data, and
can_put_echo_skb() always consumes the skb. If skb_clone() fails in
can_create_echo_skb():

	nskb = skb_clone(skb, GFP_ATOMIC);
	if (unlikely(!nskb)) {
		kfree_skb(skb);
		return NULL;
	}

can_put_echo_skb() returns -ENOMEM, which is ignored here. cf->can_id
and cf->len are then read from the freed skb.

IFF_ECHO is always set by this driver, so every transmit goes through
the clone path. The final patch in the series does not change this code.

> +
> +	ret = loongson_canfd_set_txbuf_cmd(ndev, TXT_CMD_ADD, buf_id);
> +	if (ret) {
> +		netdev_err(ndev, "Failed to start TX buffer %d: %d\n",
> +			   buf_id, ret);
> +		can_free_echo_skb(ndev, buf_id, NULL);
> +		ndev->stats.tx_dropped++;
> +		return NETDEV_TX_OK;
> +	}

[Severity: Medium]
tx_bytes is counted at submit time but never taken back. That covers
this failure path and buffers that later end in TX_BS_FAIL or
TX_BS_CANCEL, where only tx_dropped is incremented. tx_packets, on the
other hand, is counted only on TX_BS_VALID.

The length returned by can_get_echo_skb() in
loongson_canfd_tx_interrupt() is discarded into dummy_len. Would
counting tx_bytes there keep tx_bytes and tx_packets consistent?

Separately, loongson_canfd_rx_overrun_event() counts the locally
generated CAN_ERR_CRTL error frame in rx_packets and rx_bytes. CAN
drivers no longer count error frames there.

[ ... ]

> +	netif_stop_queue(ndev);
> +	napi_disable(&priv->napi);
> +
> +	/*
> +	 * Cancel a pending bus-off restart before tearing down IRQ/DMA:
> +	 * do_set_mode() re-arms both, so a restart firing after
> +	 * free_irq() would touch released resources. close_candev()
> +	 * does the same but only after free_irq().
> +	 */
> +	cancel_delayed_work_sync(&priv->can.restart_work);
> +
> +	loongson_canfd_chip_stop(ndev);
> +	free_irq(ndev->irq, ndev);
> +	close_candev(ndev);

[Severity: Medium]
Can restart_work be armed again after this cancel? At this point the IRQ
is still registered and enabled.

A bus-off FCSI could arrive before loongson_canfd_chip_stop(). An ISR
could also still be running on another CPU, since there is no
synchronize_irq(). Either one goes through:

err_interrupt()->report_state_change()->can_bus_off()

can_bus_off() schedules restart_work when restart_ms is set.

If that work fires during chip_stop() or free_irq(), can_restart()->
loongson_canfd_do_set_mode(CAN_MODE_START) resets the chip and
re-enables INT_ENA, INT_MASK and CONF_ENA. In the final version of the
series it also restarts the RX DMA. All of this happens after ndo_stop,
with no handler on the IRQF_SHARED line. The later cancel in
close_candev() only waits for a work item that is already running.

Could the unhandled interrupts on the shared line then make the "nobody
cared" logic disable it for the other devices on that line?

[ ... ]

> +	if (READ_ONCE(priv->hwts.ready)) {
> +		info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
> +					 SOF_TIMESTAMPING_RX_HARDWARE |
> +					 SOF_TIMESTAMPING_RAW_HARDWARE;
> +		info->tx_types = BIT(HWTSTAMP_TX_ON);
> +		info->rx_filters = BIT(HWTSTAMP_FILTER_ALL);
> +	}

[Severity: Low]
Hardware timestamping is advertised here only while hwts.ready is set.
However, ndo_hwtstamp_get/set use can_hwtstamp_get() and
can_hwtstamp_set(), which always report and accept HWTSTAMP_TX_ON and
HWTSTAMP_FILTER_ALL. As a result, ethtool -T and SIOCGHWTSTAMP can
disagree.

hwts.ready is false when the interface is down or when
loongson_canfd_hwts_setup() failed. In that state, can_put_echo_skb()
still sets SKBTX_IN_PROGRESS, and __can_get_echo_skb() still calls
skb_tstamp_tx() with skb_hwtstamps(skb). Wouldn't userspace then receive
a hardware TX timestamp of zero?

[ ... ]

> @@ -0,0 +1,2414 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * LOONGSON CANFD controller driver
> + *
> + * Copyright (C) 2024-2026 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/can/dev.h>
> +#include <linux/can/error.h>
> +#include <linux/cleanup.h>
> +#include <linux/clocksource.h>
> +#include <linux/ethtool.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/net_tstamp.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/skbuff.h>
> +#include <linux/string.h>
> +#include <linux/timecounter.h>
> +#include <linux/timekeeping.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +
> +#define LOONGSON_CANFD_DEVICE_ID	0x0	/* CANFD controller ID Register */
> +#define LOONGSON_CANFD_MODE		0x4	/* Mode Configuration Register */
> +#define LOONGSON_CANFD_CONF		0x8	/* Configure Register */
> +#define LOONGSON_CANFD_STAT		0xc	/* Status Register */
> +#define LOONGSON_CANFD_CMD		0x10	/* Command Register */
> +#define LOONGSON_CANFD_INT_STAT		0x14	/* Interrupt Status Register */
> +#define LOONGSON_CANFD_INT_ENA		0x18	/* Interrupt Enable Register */
> +#define LOONGSON_CANFD_INT_MASK		0x1c	/* Interrupt Mask Register */
> +#define LOONGSON_CANFD_BTR_NORM		0x20	/* Normal Rate Configuration Register */
> +#define LOONGSON_CANFD_BTR_FD		0x24	/* FD Data Rate Configuration Register */
> +#define LOONGSON_CANFD_ERL		0x28	/* Error Threshold Configuration Register */
> +#define LOONGSON_CANFD_FSTAT		0x2c	/* Error Status Register */
> +#define LOONGSON_CANFD_ERC		0x30	/* Error Count Register */
> +#define LOONGSON_CANFD_BRE		0x34	/* Rate Error Count Register */
> +#define LOONGSON_CANFD_CTR_PRES		0x38	/* Error Count Debug Register */
> +#define LOONGSON_CANFD_ERR_CAPT		0x3c	/* Error Capture Status Register */
> +#define LOONGSON_CANFD_RETX_CNT		0x40	/* Retransmission Count Register */
> +#define LOONGSON_CANFD_ALC		0x44	/* Lost Arbitration Capture Register */
> +#define LOONGSON_CANFD_TRV_DLY		0x48	/* Transmission Delay Measurement Register */
> +#define LOONGSON_CANFD_SSP_CFG		0x4c	/* Second Sampling Point Configuration Register */
> +#define LOONGSON_CANFD_RX_FR_CNT	0x50	/* Receive Message Count Register */
> +#define LOONGSON_CANFD_TX_FR_CNT	0x54	/* Transmit Message Count Register */
> +#define LOONGSON_CANFD_DEBUG		0x58	/* Debug Register */
> +#define LOONGSON_CANFD_TS		0x5c	/* Timestamp Register */
> +#define LOONGSON_CANFD_TX_FRM_TST	0x60	/* Transmit Message Debug Register */
> +#define LOONGSON_CANFD_FRC_DIV		0x64	/* Fractional Divider Ratio Register */
> +#define LOONGSON_CANFD_FLT_A_MASK	0x68	/* Filter A Mask Register */
> +#define LOONGSON_CANFD_FLT_A_VAL	0x6c	/* Filter A value Register */
> +#define LOONGSON_CANFD_FLT_B_MASK	0x70	/* Filter B Mask Register */
> +#define LOONGSON_CANFD_FLT_B_VAL	0x74	/* Filter B value Register */
> +#define LOONGSON_CANFD_FLT_C_MASK	0x78	/* Filter C Mask Register */
> +#define LOONGSON_CANFD_FLT_C_VAL	0x7c	/* Filter C value Register */
> +#define LOONGSON_CANFD_FLT_R_LOW	0x80	/* Range Filter Low Threshold Register */
> +#define LOONGSON_CANFD_FLT_R_HI		0x84	/* Range Filter High Threshold Register */
> +#define LOONGSON_CANFD_FLT_CTRL		0x88	/* Filter Control Register */
> +#define LOONGSON_CANFD_RX_MEM_INFO	0x8c	/* Receive Buffer Information Register */
> +#define LOONGSON_CANFD_RX_PRT		0x90	/* Receive Buffer Pointer Register */
> +#define LOONGSON_CANFD_RX_STAT		0x94	/* Receive Buffer Status Register */
> +#define LOONGSON_CANFD_RX_DATA		0x98	/* Receive Data Register */
> +#define LOONGSON_CANFD_TX_STAT		0x9c	/* Transmit Buffer Status Register */
> +#define LOONGSON_CANFD_TX_CMD		0xa0	/* Transmit Command Register */
> +#define LOONGSON_CANFD_TX_SEL		0xa4	/* Transmit Buffer Selection Register */
> +#define LOONGSON_CANFD_TX_DATA_1	0xb0
> +#define LOONGSON_CANFD_TX_DATA_18	0xf4
> +
> +/* Bitfields of CANFD controller ID register */
> +#define REG_ID_MASK			GENMASK(15, 0)
> +#define REG_ID_VER_MIN			GENMASK(23, 16)
> +#define REG_ID_VER_MAJ			GENMASK(31, 24)
> +
> +/* Bitfields of Mode Configuration register */
> +#define REG_MODE_RST			BIT(0)	/* Soft Reset */
> +#define REG_MODE_BMM			BIT(1)	/* Bus Monitoring Mode */
> +#define REG_MODE_STM			BIT(2)	/* Self-Test Mode */
> +#define REG_MODE_AFM			BIT(3)	/* Receive Filter Mode */
> +#define REG_MODE_FDE			BIT(4)	/* CANFD Enabled */
> +#define REG_MODE_TTTM			BIT(5)	/* Timed Transmission Mode */
> +#define REG_MODE_ROM			BIT(6)	/* Restricted Operation Mode */
> +#define REG_MODE_ACF			BIT(7)	/* No ACK Mode*/
> +#define REG_MODE_TSTM			BIT(8)	/* Test Mode */
> +#define REG_MODE_RXBAM			BIT(9)	/* Receive Buffer Auto Mode */
> +#define REG_MODE_ITSM			BIT(10)	/* Internal Timestamp Mode */
> +#define REG_MODE_RTSOP			BIT(12)	/* Receive Buffer Timestamp Addition Mode */
> +#define REG_MODE_BUFM			BIT(13)	/* Transmit Buffer Mode */
> +
> +/* Bitfields of Configure register */
> +#define REG_CONF_RTRLE			BIT(0)	/* Retransmission Threshold Enable */
> +#define REG_CONF_RTRTH			GENMASK(4, 1)	/* Retransmission Threshold */
> +#define REG_CONF_ILBP			BIT(5)	/* Internal Loopback Mode */
> +#define REG_CONF_ENA			BIT(6)	/* Controller Enable */
> +#define REG_CONF_NISOFD			BIT(7)	/* NON-ISO CANFD Protocol Enable */
> +#define REG_CONF_PEX			BIT(8)	/* Protocol Exception Handling */
> +#define REG_CONF_FDRF			BIT(10)	/* Ignore Remote Frame Enable */
> +
> +/* Bitfields of Status register */
> +#define REG_STAT_RXNE			BIT(0)	/* Receive Buffer Not Empty Status */
> +#define REG_STAT_DOR			BIT(1)	/* Receive Data Overflow Status */
> +#define REG_STAT_EFT			BIT(3)	/* Error Frame Flag */
> +#define REG_STAT_RXS			BIT(4)	/* Receive Status Flag */
> +#define REG_STAT_TXS			BIT(5)	/* Transmission Status Flag */
> +#define REG_STAT_EWL			BIT(6)	/* Transmission Error Threshold Flag */
> +#define REG_STAT_IDLE			BIT(7)	/* Bus Idle Flag */
> +#define REG_STAT_PEXS			BIT(8)	/* Protocol Exception Status */
> +#define REG_STAT_STCNT			BIT(16)	/* Transmission Count Support */
> +
> +/* Bitfields of Command register */
> +#define REG_CMD_RXRPMV			BIT(1)	/* Receive Buffer Read-to-Move */
> +#define REG_CMD_RRB			BIT(2)	/* Receive Buffer Release */
> +#define REG_CMD_CDO			BIT(3)	/* Received Data Overflow Status Clear */
> +#define REG_CMD_ERCRST			BIT(4)	/* Error Count Clear */
> +#define REG_CMD_RXFCRST			BIT(5)	/* Receive Frame Count Clear */
> +#define REG_CMD_TXFCRST			BIT(6)	/* Transmit Frame Count Clear */
> +#define REG_CMD_CPEXS			BIT(7)	/* Exception Status Clear */
> +
> +/* Bitfields of Interrupt Status register */
> +#define REG_INT_STAT_RXI		BIT(0)	/* Message Reception Interrupt */
> +#define REG_INT_STAT_TXI		BIT(1)	/* Message Transmission Interrupt */
> +#define REG_INT_STAT_EWLI		BIT(2)	/* Error Warning Threshold Interrupt */
> +#define REG_INT_STAT_DOI		BIT(3)	/* Receive Data Overflow Interrupt */
> +#define REG_INT_STAT_FCSI		BIT(4)	/* Fault State Change Interrupt */
> +#define REG_INT_STAT_ALI		BIT(5)	/* Arbitration Loss Interrupt */
> +#define REG_INT_STAT_BEI		BIT(6)	/* Bus Error Interrupt */
> +#define REG_INT_STAT_RXFI		BIT(7)	/* Receive Buffer Full Interrupt */
> +#define REG_INT_STAT_BSI		BIT(8)	/* Rate Switching Interrupt */
> +#define REG_INT_STAT_RBNEI		BIT(9)	/* Receive Buffer Not Empty Interrupt */
> +#define REG_INT_STAT_TXBHCI		BIT(10)	/* Transmit Buffer Hardware Command Interrupt */
> +#define REG_INT_STAT_OFI		BIT(11)	/* Overload Frame Transmission Interrupt */
> +#define REG_INT_STAT_DMADI		BIT(12)	/* Message DMA Transfer Complete Interrupt */
> +
> +#define REG_INT_STAT_ERRORI		(REG_INT_STAT_EWLI | REG_INT_STAT_FCSI |\
> +					 REG_INT_STAT_ALI | REG_INT_STAT_BEI)
> +
> +/* Bitfields of Interrupt Enable register */
> +#define REG_INT_ENA_SET			GENMASK(12, 0)
> +#define REG_INT_ENA_CLR			GENMASK(28, 16)
> +
> +/* Bitfields of Interrupt Mask register */
> +#define REG_INT_MASK_SET		GENMASK(12, 0)
> +#define REG_INT_MASK_CLR		GENMASK(28, 16)
> +
> +/* Bitfields of Normal Rate Configuration register */
> +#define REG_BTR_PROP			GENMASK(6, 0)
> +#define REG_BTR_PH1			GENMASK(12, 7)
> +#define REG_BTR_PH2			GENMASK(18, 13)
> +#define REG_BTR_BRP			GENMASK(22, 19)
> +#define REG_BTR_SJW			GENMASK(31, 27)
> +
> +/* Bitfields of FD Data Rate Configuration register */
> +#define REG_BTR_FD_PROP			GENMASK(6, 0)
> +#define REG_BTR_FD_PH1			GENMASK(12, 7)
> +#define REG_BTR_FD_PH2			GENMASK(18, 13)
> +#define REG_BTR_FD_BRP			GENMASK(26, 19)
> +#define REG_BTR_FD_SJW			GENMASK(31, 27)
> +
> +/* Bitfields of Error Threshold Configuration register */
> +#define REG_ERL_ERP			GENMASK(7, 0)
> +#define REG_ERL_EW			GENMASK(23, 16)
> +
> +/* Bitfields of Error Status register */
> +#define REG_FSTAT_ERA			BIT(0)
> +#define REG_FSTAT_ERP			BIT(1)
> +#define REG_FSTAT_BOF			BIT(2)
> +
> +#define REG_FSTAT_MASK			GENMASK(2, 0)
> +
> +/* Bitfields of Error Count register */
> +#define REG_ERC_TEC			GENMASK(8, 0)
> +#define REG_ERC_REC			GENMASK(24, 16)
> +
> +/* Bitfields of Rate Error Count register */
> +#define REG_BRE_NORM			GENMASK(15, 0)
> +#define REG_BRE_FD_DATA			GENMASK(31, 16)
> +
> +/* Bitfields of Error Count Debug register */
> +#define REG_CTR_PRES_CTPV		GENMASK(8, 0)
> +#define REG_CTR_PRES_PTX		BIT(9)
> +#define REG_CTR_PRES_PRX		BIT(10)
> +
> +/* Bitfields of Error Capture Status register */
> +#define REG_ERR_CAPT_POS		GENMASK(4, 0)
> +#define REG_ERR_CAPT_TYPE		GENMASK(7, 5)
> +
> +/* Bitfields of Retransmission Count register */
> +#define REG_RETX_CNT_VAL		GENMASK(3, 0)
> +
> +/* Bitfields of Lost Arbitration Capture register */
> +#define REG_ALC_BIT_POS			GENMASK(4, 0)
> +#define REG_ALC_ID_FIELD		GENMASK(7, 5)
> +
> +/* Bitfields of Transmission Delay Measurement register */
> +#define REG_TRV_DLY_VAL			GENMASK(6, 0)
> +
> +/* Bitfields of Second Sampling Point Configuration register */
> +#define REG_SSP_CFG_OFF			GENMASK(7, 0)
> +#define REG_SSP_CFG_SRC			GENMASK(9, 8)
> +#define REG_SSP_CFG_SAT			BIT(10)
> +
> +/* Bitfields of Receive Message Count register */
> +#define REG_RX_FR_CNT_VAL		GENMASK(31, 0)
> +
> +/* Bitfields of Transmit Message Count register */
> +#define REG_TX_FR_CNT_VAL		GENMASK(31, 0)
> +
> +/* Bitfields of Debug register */
> +#define REG_DEBUG_STF_CNT		GENMASK(2, 0)
> +#define REG_DEBUG_DSTF_CNT		GENMASK(5, 3)
> +#define REG_DEBUG_PC_ARB		BIT(6)
> +#define REG_DEBUG_PC_CON		BIT(7)
> +#define REG_DEBUG_PC_DAT		BIT(8)
> +#define REG_DEBUG_PC_STC		BIT(9)
> +#define REG_DEBUG_PC_CRC		BIT(10)
> +#define REG_DEBUG_PC_CRCD		BIT(11)
> +#define REG_DEBUG_PC_ACK		BIT(12)
> +#define REG_DEBUG_PC_ACKD		BIT(13)
> +#define REG_DEBUG_PC_EOF		BIT(14)
> +#define REG_DEBUG_PC_INT		BIT(15)
> +#define REG_DEBUG_PC_SUSP		BIT(16)
> +#define REG_DEBUG_PC_OVR		BIT(17)
> +#define REG_DEBUG_PC_SOF		BIT(18)
> +
> +/* Bitfields of Timestamp register */
> +#define REG_TS_TIMESTAMP		GENMASK(15, 0)
> +#define REG_TS_PSC			GENMASK(24, 16)
> +
> +/* Bitfields of Fractional Divider Ratio register */
> +#define REG_FRC_FRC_DBT			GENMASK(15, 8)
> +#define REG_FRC_FRC_NBT			GENMASK(7, 0)
> +
> +/* Bitfields of Filter A Mask register */
> +#define REG_FIL_A_MASK			GENMASK(28, 0)
> +
> +/* Bitfields of Filter A value register */
> +#define REG_FIL_A_VAL			GENMASK(28, 0)
> +
> +/* Bitfields of Filter B Mask register */
> +#define REG_FIL_B_MASK			GENMASK(28, 0)
> +
> +/* Bitfields of Filter B value register */
> +#define REG_FIL_B_VAL			GENMASK(28, 0)
> +
> +/* Bitfields of Filter C Mask register */
> +#define REG_FIL_C_MASK			GENMASK(28, 0)
> +
> +/* Bitfields of Filter C value register */
> +#define REG_FIL_C_VAL			GENMASK(28, 0)
> +
> +/* Bitfields of Range Filter Low Threshold register */
> +#define REG_FIL_R_LOW_VAL		GENMASK(28, 0)
> +
> +/* Bitfields of Range Filter High Threshold register */
> +#define REG_FIL_R_HI_VAL		GENMASK(28, 0)
> +
> +/* Bitfields of Filter Control register */
> +#define REG_FIL_CTRL_FANB		BIT(0)
> +#define REG_FIL_CTRL_FANE		BIT(1)
> +#define REG_FIL_CTRL_FAFB		BIT(2)
> +#define REG_FIL_CTRL_FAFE		BIT(3)
> +#define REG_FIL_CTRL_FBNB		BIT(4)
> +#define REG_FIL_CTRL_FBNE		BIT(5)
> +#define REG_FIL_CTRL_FBFB		BIT(6)
> +#define REG_FIL_CTRL_FBFE		BIT(7)
> +#define REG_FIL_CTRL_FCNB		BIT(8)
> +#define REG_FIL_CTRL_FCNE		BIT(9)
> +#define REG_FIL_CTRL_FCFB		BIT(10)
> +#define REG_FIL_CTRL_FCFE		BIT(11)
> +#define REG_FIL_CTRL_FRNB		BIT(12)
> +#define REG_FIL_CTRL_FRNE		BIT(13)
> +#define REG_FIL_CTRL_FRFB		BIT(14)
> +#define REG_FIL_CTRL_FRFE		BIT(15)
> +#define REG_FIL_CTRL_SFA		BIT(16)
> +#define REG_FIL_CTRL_SFB		BIT(17)
> +#define REG_FIL_CTRL_SFC		BIT(18)
> +#define REG_FIL_CTRL_SFR		BIT(19)
> +
> +/* Bitfields of Receive Buffer Information register */
> +#define REG_RX_MEM_INFO_BUFF_SIZE	GENMASK(12, 0)
> +#define REG_RX_MEM_INFO_MEM_FREE	GENMASK(28, 16)
> +
> +/* Bitfields of Receive Buffer Pointer register */
> +#define REG_RX_PTR_WPP			GENMASK(11, 0)
> +#define REG_RX_PTR_RPP			GENMASK(27, 16)
> +
> +/* Bitfields of Receive Buffer Status register */
> +#define REG_RX_STAT_RXE			BIT(0)
> +#define REG_RX_STAT_RXF			BIT(1)
> +#define REG_RX_STAT_RXMOF		BIT(2)
> +#define REG_RX_STAT_RXFRC		GENMASK(14, 4)
> +#define REG_RX_STAT_RTSOP		BIT(16)
> +
> +/* Bitfields of Receive Data register */
> +#define REG_RX_DATA_VAL			GENMASK(31, 0)
> +
> +/* Bitfields of Transmit Buffer Status register */
> +#define REG_TX_STAT_BRP			GENMASK(7, 0)
> +#define REG_TX_STAT_TXS			GENMASK(10, 8)
> +#define REG_TX_STAT_BS			GENMASK(31, 16)
> +
> +#define REG_TX_STAT_BS_TX_MASK_BASE	GENMASK(17, 16)
> +
> +/* Bitfields of Transmit Command register */
> +#define REG_TX_CMD_BAR			GENMASK(7, 0)
> +#define REG_TX_CMD_BCR			GENMASK(15, 8)
> +#define REG_TX_CMD_BSC			GENMASK(23, 16)
> +
> +/* Bitfields of Transmit Buffer Selection register */
> +#define REG_TX_SEL_BUF_SEL		GENMASK(3, 0)
> +#define REG_TX_SEL_BUF_CNT		GENMASK(7, 4)
> +
> +/* Loongson CANFD Frame format */
> +#define LOONGSON_CANFD_FRAME_META0	0x0
> +#define LOONGSON_CANFD_FRAME_META1	0x4
> +#define LOONGSON_CANFD_FRAME_DB_1	0x8
> +
> +/* Bitfields of FRAME META0 */
> +#define REG_FRAME_META0_ID_EXT		GENMASK(17, 0)
> +#define REG_FRAME_META0_ID_BASE		GENMASK(28, 18)
> +#define REG_FRAME_META0_RTR		BIT(29)	/* Remote Transmission Request, only in CAN2.0 */
> +/* Extended Identifier Type. 1: 29 bits ID, 0: 11 bits ID. */
> +#define REG_FRAME_META0_XDT		BIT(30)
> +#define REG_FRAME_META0_ESI		BIT(31)	/* Error State Indicator, only in CAN-FD */
> +
> +/* Bitfields of FRAME META1 */
> +#define REG_FRAME_META1_TIMESTAMP	GENMASK(15, 0)
> +#define REG_FRAME_META1_DLC		GENMASK(19, 16)	/* Data Length Code */
> +#define REG_FRAME_META1_BRS		BIT(20)	/* Bit Rate Shift, Only in CANFD */
> +/* Flexible Data-rate Format. 1: CANFD, 0: CAN2.0 */
> +#define REG_FRAME_META1_FDF		BIT(21)
> +#define REG_FRAME_META1_RWCNT		GENMASK(28, 24)	/* Read Word Counter */
> +
> +/* Bitfields of FRAME TEST */
> +#define REG_FRAME_TEST_FSTC		BIT(0)
> +#define REG_FRAME_TEST_FCRC		BIT(1)
> +#define REG_FRAME_TEST_SDLC		BIT(2)
> +#define REG_FRAME_TEST_TPRM		GENMASK(12, 8)
> +
> +#define DEV_NAME			"loongson_canfd"
> +#define LOONGSON_CANFD_ID		0xBABE
> +#define LOONGSON_CANFD_DW_BYTE		4
> +#define LOONGSON_CANFD_TXBUF_NUM	8
> +#define LOONGSON_CANFD_MAX_RTXTH	0xf
> +
> +/* Upper bound on the number of ISR drain iterations */
> +#define LOONGSON_CANFD_IRQ_LOOP_MAX		10000
> +
> +/*
> + * 16-bit counter couples resolution and window length:
> + *     window = 2^16 * tick
> + *
> + * A 2 us tick yields ~131 ms, well above the worst case a frame can
> + * stay in the 32 KB RX ring before NAPI dequeues it.
> + */
> +#define LOONGSON_CANFD_HWTS_TICK_NS		2000
> +#define LOONGSON_CANFD_HWTS_COUNTER_BITS	16
> +#define LOONGSON_CANFD_HWTS_SLEW_SHIFT		3
> +#define LOONGSON_CANFD_HWTS_SLEW_BAND_NS	2000
> +
> +/**
> + * struct loongson_canfd_hwts - Hardware timestamp state
> + * @cc: Cycle counter abstracting the 16-bit timestamp counter
> + * @tc: Nanosecond time counter built on @cc, anchored to CLOCK_REALTIME
> + * @lock: Serializes access to @tc (NAPI, TX interrupt, chip start)
> + * @window_ns: Length of the unambiguous window, 2^16 tick periods
> + * @tick_ns: Achieved tick period in nanoseconds
> + * @psc: Prescaler value currently programmed into REG_TS_PSC
> + * @ready: Timestamping is configured and usable
> + */
> +struct loongson_canfd_hwts {
> +	struct cyclecounter	cc;
> +	struct timecounter	tc;
> +	spinlock_t		lock;	/* protect the tc context */
> +	u64			window_ns;
> +	u32			tick_ns;
> +	u32			psc;
> +	bool			ready;
> +};
> +
> +/**
> + * struct loongson_canfd_rx_desc - Parsed on-wire frame descriptor
> + * @hdr0: First header word: ID / RTR / XDT / ESI
> + * @hdr1: Second header word: timestamp / DLC / BRS / FDF / RWCNT
> + * @rwcnt: Total 32-bit words the frame occupies in the ring
> + * @dbcnt: Payload size in bytes, (rwcnt - 2) * 4
> + * @is_can_fd: True if the FDF bit is set
> + * @is_rtr: True if the RTR bit is set (Classic CAN only)
> + */
> +struct loongson_canfd_rx_desc {
> +	u32	hdr0;
> +	u32	hdr1;
> +	u32	rwcnt;
> +	u32	dbcnt;
> +	bool	is_can_fd;
> +	bool	is_rtr;
> +};
> +
> +/**
> + * struct loongson_canfd_priv - Driver private data
> + * @can: CAN private data structure (must be first member)
> + * @napi: NAPI structure
> + * @regmap: Regmap of the CAN device
> + * @mem_res: Pointer to the CAN device resource (MMIO region)
> + * @tx_lock: Lock for synchronizing TX interrupt handling
> + * @stats_lock: Lock for protecting netdev statistics
> + * @hwts: Hardware timestamp state
> + */
> +struct loongson_canfd_priv {
> +	struct can_priv		can;
> +	struct napi_struct	napi;
> +	struct regmap		*regmap;
> +	struct resource		*mem_res;
> +	spinlock_t		tx_lock;	/* protect the sending queue */
> +	spinlock_t		stats_lock;	/* protect the ndev->stats */
> +	struct loongson_canfd_hwts	hwts;
> +};
> +
> +/**
> + * enum loongson_canfd_txbuf_sts - Status of TX buffer
> + * @TX_BS_IDLE: No transmission or processed.
> + * @TX_BS_VALID: Transmission successful.
> + * @TX_BS_FAIL: Transmission failed (retry limit exceeded).
> + * @TX_BS_CANCEL: Transmission cancelled.
> + */
> +enum loongson_canfd_txbuf_sts {
> +	TX_BS_IDLE	= 0x0,
> +	TX_BS_VALID	= 0x1,
> +	TX_BS_FAIL	= 0x2,
> +	TX_BS_CANCEL	= 0x3
> +};
> +
> +/**
> + * enum loongson_canfd_txbuf_cmd - Commands for TX buffer
> + * @TXT_CMD_ADD: Add buffer request (start transmission)
> + * @TXT_CMD_CANCEL: Cancel buffer request
> + * @TXT_CMD_SR_CLEAN: Clear send completion record
> + */
> +enum loongson_canfd_txbuf_cmd {
> +	TXT_CMD_ADD		= 0x01,
> +	TXT_CMD_CANCEL		= 0x02,
> +	TXT_CMD_SR_CLEAN	= 0x03
> +};
> +
> +static const struct can_bittiming_const loongson_canfd_bit_timing = {
> +	.name		= DEV_NAME,
> +	.tseg1_min	= 2,
> +	.tseg1_max	= 190,
> +	.tseg2_min	= 2,
> +	.tseg2_max	= 63,
> +	.sjw_max	= 31,
> +	.brp_min	= 1,
> +	.brp_max	= 15,
> +	.brp_inc	= 1,
> +};
> +
> +static const struct can_bittiming_const loongson_canfd_bit_timing_data = {
> +	.name		= DEV_NAME,
> +	.tseg1_min	= 2,
> +	.tseg1_max	= 190,
> +	.tseg2_min	= 2,
> +	.tseg2_max	= 63,
> +	.sjw_max	= 31,
> +	.brp_min	= 1,
> +	.brp_max	= 255,
> +	.brp_inc	= 1,
> +};
> +
> +static const struct can_tdc_const loongson_canfd_tdc_data = {
> +	.tdcv_min	= 0,
> +	.tdcv_max	= 0,
> +	.tdco_min	= 0,
> +	.tdco_max	= 255,
> +	.tdcf_min	= 0,
> +	.tdcf_max	= 0,
> +};
> +
> +/* Return @field when @cond is true, 0 otherwise. */
> +#define LOONGSON_CANFD_FIELD_IF(cond, field) (-(!!(cond)) & (field))
> +
> +/**
> + * loongson_canfd_enabled() - Check if controller is enabled
> + * @priv: Driver private data
> + *
> + * Return: true if enabled, false otherwise.
> + */
> +static bool loongson_canfd_enabled(struct loongson_canfd_priv *priv)
> +{
> +	return !!regmap_test_bits(priv->regmap, LOONGSON_CANFD_CONF, REG_CONF_ENA);
> +}
> +
> +/**
> + * loongson_canfd_disable_interrupts() - Disable all interrupts
> + * @priv: Driver private data
> + */
> +static void loongson_canfd_disable_interrupts(struct loongson_canfd_priv *priv)
> +{
> +	/* Clear all ENA bits, then set all MASK bits */
> +	regmap_write(priv->regmap, LOONGSON_CANFD_INT_ENA, REG_INT_ENA_CLR);
> +	regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, REG_INT_MASK_SET);
> +}
> +
> +/**
> + * loongson_canfd_read_rx_word_fifo() - Read RX data in poll mode
> + * @priv: Driver private data
> + *
> + * Return: The next 32-bit data word from the RX data register.
> + */
> +static u32 loongson_canfd_read_rx_word_fifo(struct loongson_canfd_priv *priv)
> +{
> +	u32 data;
> +
> +	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
> +	return data;
> +}
> +
> +/**
> + * loongson_canfd_rx_is_empty_fifo() - Poll mode: hardware FIFO empty check
> + * @priv: Driver private data
> + *
> + * Uses both RXE and RXFRC so a transient RXE during FIFO refill is not
> + * mistaken for an empty FIFO.
> + *
> + * Return: true if no frame is pending and RXE is set.
> + */
> +static bool loongson_canfd_rx_is_empty_fifo(struct loongson_canfd_priv *priv)
> +{
> +	u32 rx_stat, framecnt;
> +
> +	regmap_read(priv->regmap, LOONGSON_CANFD_RX_STAT, &rx_stat);
> +	framecnt = FIELD_GET(REG_RX_STAT_RXFRC, rx_stat);
> +
> +	if (framecnt)
> +		return false;
> +
> +	/* RXE may transiently assert while the FIFO is being refilled */
> +	return !!(rx_stat & REG_RX_STAT_RXE);
> +}
> +
> +/**
> + * loongson_canfd_hwts_read_cycles() - Read the free-running timestamp counter
> + * @cc: Cycle counter whose read callback is being invoked
> + *
> + * Reads LOONGSON_CANFD_TS and extracts the 16-bit counter field (bits 15:0).
> + * The register is marked volatile in loongson_canfd_volatile_reg(), so
> + * regmap_read() bypasses the cache and returns a live value.
> + *
> + * Return: Current value of the 16-bit timestamp counter.
> + */
> +static u64 loongson_canfd_hwts_read_cycles(struct cyclecounter *cc)
> +{
> +	struct loongson_canfd_hwts *hwts =
> +		container_of(cc, struct loongson_canfd_hwts, cc);
> +	struct loongson_canfd_priv *priv =
> +		container_of(hwts, struct loongson_canfd_priv, hwts);
> +	u32 val;
> +
> +	/* REG_TS is volatile, so this returns a live counter value */
> +	regmap_read(priv->regmap, LOONGSON_CANFD_TS, &val);
> +
> +	return FIELD_GET(REG_TS_TIMESTAMP, val);
> +}
> +
> +/**
> + * loongson_canfd_hwts_anchor() - Refresh the nanosecond epoch
> + * @priv: Driver private data
> + *
> + * Calls timecounter_read() so a single wrap can be followed, then
> + * nudges the epoch toward CLOCK_REALTIME. A deviation of half a window
> + * or more means the epoch is worthless and is re-initialized instead.
> + *
> + * Caller must hold @hwts.lock.
> + */
> +static void loongson_canfd_hwts_anchor(struct loongson_canfd_priv *priv)
> +{
> +	struct loongson_canfd_hwts *hwts = &priv->hwts;
> +	s64 dev;
> +
> +	timecounter_read(&hwts->tc);
> +
> +	if (!hwts->window_ns)
> +		return;
> +
> +	dev = ktime_get_real_ns() - (s64)hwts->tc.nsec;
> +
> +	/* Whole windows lost: re-lock, do not slew (stamps must stay monotonic) */
> +	if (dev >= (s64)hwts->window_ns / 2 ||
> +	    dev <= -(s64)hwts->window_ns / 2) {
> +		timecounter_init(&hwts->tc, &hwts->cc, ktime_get_real_ns());
> +		return;
> +	}
> +
> +	if (dev > -LOONGSON_CANFD_HWTS_SLEW_BAND_NS &&
> +	    dev < LOONGSON_CANFD_HWTS_SLEW_BAND_NS)
> +		return;
> +
> +	timecounter_adjtime(&hwts->tc, dev >> LOONGSON_CANFD_HWTS_SLEW_SHIFT);
> +}
> +
> +/**
> + * loongson_canfd_hwts_ts() - Convert a raw 16-bit stamp to a ktime_t
> + * @priv: Driver private data
> + * @raw: Raw 16-bit timestamp taken from the frame
> + *
> + * Frames are always stamped before the driver reads them, so the
> + * result is folded into the most recent past window, making the
> + * reconstruction exact for any frame age below one full window.
> + *
> + * Return: ktime_t of @raw, in CLOCK_REALTIME nanoseconds.
> + */
> +static ktime_t loongson_canfd_hwts_ts(struct loongson_canfd_priv *priv, u32 raw)
> +{
> +	struct loongson_canfd_hwts *hwts = &priv->hwts;
> +	s64 age, ts;
> +
> +	guard(spinlock_irqsave)(&hwts->lock);
> +
> +	loongson_canfd_hwts_anchor(priv);
> +
> +	ts = (s64)timecounter_cyc2time(&hwts->tc, raw);
> +
> +	age = (s64)hwts->tc.nsec - ts;
> +	if (age < 0)
> +		age += (s64)hwts->window_ns;
> +
> +	return ns_to_ktime((s64)hwts->tc.nsec - age);
> +}
> +
> +/**
> + * loongson_canfd_hwts_now() - Timestamp of the current moment
> + * @priv: Driver private data
> + *
> + * Samples the counter before converting, so the result is never later
> + * than the moment of the call.
> + *
> + * Return: ktime_t of now, in CLOCK_REALTIME nanoseconds.
> + */
> +static ktime_t loongson_canfd_hwts_now(struct loongson_canfd_priv *priv)
> +{
> +	struct loongson_canfd_hwts *hwts = &priv->hwts;
> +
> +	/* Sample first: the counter is the earlier of the two instants */
> +	return loongson_canfd_hwts_ts(priv, (u32)hwts->cc.read(&hwts->cc));
> +}
> +
> +/**
> + * loongson_canfd_hwts_setup() - Program the prescaler and start the epoch
> + * @ndev: Network device
> + *
> + * The 16-bit free-running counter is extended to 64-bit nanoseconds
> + * via a cyclecounter/timecounter pair anchored to CLOCK_REALTIME. On
> + * failure @hwts.ready is left false; the controller can still run,
> + * just without timestamping.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static int loongson_canfd_hwts_setup(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	struct loongson_canfd_hwts *hwts = &priv->hwts;
> +	u32 tick_hz, clk = priv->can.clock.freq;
> +	u64 frac = 0, div;
> +	int ret;
> +
> +	/* Disable timestamping until the new setup succeeds */
> +	WRITE_ONCE(hwts->ready, false);
> +
> +	if (!clk) {
> +		netdev_warn(ndev, "Zero clock, HW timestamp unavailable\n");
> +		return -EINVAL;
> +	}
> +
> +	/* tick = (psc + 1) / clk, aim for LOONGSON_CANFD_HWTS_TICK_NS */
> +	div = DIV_ROUND_CLOSEST_ULL((u64)LOONGSON_CANFD_HWTS_TICK_NS * clk,
> +				    NSEC_PER_SEC);
> +	div = clamp_t(u64, div, 1, FIELD_MAX(REG_TS_PSC) + 1ULL);
> +
> +	hwts->psc = div - 1;
> +	hwts->tick_ns = DIV_ROUND_CLOSEST_ULL(div * NSEC_PER_SEC, clk);
> +
> +	tick_hz = clk / (u32)div;
> +	if (!tick_hz) {
> +		netdev_warn(ndev, "Clock too slow for HW timestamp (%u Hz)\n",
> +			    clk);
> +		return -EINVAL;
> +	}
> +
> +	hwts->cc.read = loongson_canfd_hwts_read_cycles;
> +	hwts->cc.mask = CYCLECOUNTER_MASK(LOONGSON_CANFD_HWTS_COUNTER_BITS);
> +	clocks_calc_mult_shift(&hwts->cc.mult, &hwts->cc.shift,
> +			       tick_hz, NSEC_PER_SEC, 60);
> +
> +	hwts->window_ns = cyclecounter_cyc2ns(&hwts->cc,
> +					      hwts->cc.mask + 1, 0, &frac);
> +
> +	/* Update only the prescaler bits, leave the counter alone */
> +	ret = regmap_update_bits(priv->regmap, LOONGSON_CANFD_TS, REG_TS_PSC,
> +				 FIELD_PREP(REG_TS_PSC, hwts->psc));
> +	if (ret) {
> +		netdev_err(ndev, "Failed to program TS prescaler: %d\n", ret);
> +		return ret;
> +	}
> +
> +	scoped_guard(spinlock_irqsave, &hwts->lock) {
> +		timecounter_init(&hwts->tc, &hwts->cc, ktime_get_real_ns());
> +	}
> +
> +	WRITE_ONCE(hwts->ready, true);
> +
> +	netdev_dbg(ndev, "HW timestamp: psc=%u, tick=%u ns, window=%llu ns\n",
> +		   hwts->psc, hwts->tick_ns, hwts->window_ns);
> +
> +	return 0;
> +}
> +
> +/**
> + * loongson_canfd_reset() - Issue soft reset to controller
> + * @ndev: Network device
> + *
> + * The reset bit does not self-clear on this silicon; the mode write
> + * below re-programs the register, so a timeout is only logged.
> + */
> +static void loongson_canfd_reset(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	int ret, val;
> +
> +	regmap_write(priv->regmap, LOONGSON_CANFD_MODE, REG_MODE_RST);
> +
> +	ret = regmap_read_poll_timeout(priv->regmap, LOONGSON_CANFD_MODE,
> +				       val, !(val & REG_MODE_RST),
> +				       10, 10 * USEC_PER_MSEC);
> +	if (ret)
> +		dev_dbg(ndev->dev.parent,
> +			"Soft reset did not self-clear: %d\n", ret);
> +
> +	regmap_write(priv->regmap, LOONGSON_CANFD_MODE, REG_MODE_RXBAM | REG_MODE_BUFM);
> +}
> +
> +/**
> + * loongson_canfd_set_btr() - Set CAN bit timing registers
> + * @ndev: Network device
> + * @bt: Bit timing structure
> + * @nominal: true for nominal timing, false for data timing
> + */
> +static void loongson_canfd_set_btr(struct net_device *ndev,
> +				   struct can_bittiming *bt, bool nominal)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	u32 prop = bt->prop_seg, phase1 = bt->phase_seg1;
> +	u32 ph1_max = FIELD_MAX(REG_BTR_PH1);
> +	u32 btr = 0;
> +
> +	/* PROP is 7 bits but PH1 only 6; move the excess into PROP */
> +	if (phase1 > ph1_max) {
> +		prop += phase1 - ph1_max;
> +		phase1 = ph1_max;
> +	}
> +
> +	if (nominal) {
> +		btr = FIELD_PREP(REG_BTR_PROP, prop) |
> +		      FIELD_PREP(REG_BTR_PH1, phase1) |
> +		      FIELD_PREP(REG_BTR_PH2, bt->phase_seg2) |
> +		      FIELD_PREP(REG_BTR_BRP, bt->brp) |
> +		      FIELD_PREP(REG_BTR_SJW, bt->sjw);
> +
> +		regmap_write(priv->regmap, LOONGSON_CANFD_BTR_NORM, btr);
> +	} else {
> +		btr = FIELD_PREP(REG_BTR_FD_PROP, prop) |
> +		      FIELD_PREP(REG_BTR_FD_PH1, phase1) |
> +		      FIELD_PREP(REG_BTR_FD_PH2, bt->phase_seg2) |
> +		      FIELD_PREP(REG_BTR_FD_BRP, bt->brp) |
> +		      FIELD_PREP(REG_BTR_FD_SJW, bt->sjw);
> +
> +		regmap_write(priv->regmap, LOONGSON_CANFD_BTR_FD, btr);
> +	}
> +}
> +
> +/**
> + * loongson_canfd_set_bittiming() - Set nominal bit timing
> + * @ndev: Network device
> + *
> + * Return: 0 on success, negative on error.
> + */
> +static int loongson_canfd_set_bittiming(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	struct can_bittiming *bt = &priv->can.bittiming;
> +
> +	loongson_canfd_set_btr(ndev, bt, true);
> +
> +	return 0;
> +}
> +
> +/**
> + * loongson_canfd_set_secondary_sample_point() - Configure secondary sample point
> + * @ndev: Network device
> + *
> + * Return: 0 on success, -EBUSY if the controller is enabled.
> + */
> +static int loongson_canfd_set_secondary_sample_point(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	u32 ctrlmode = priv->can.ctrlmode;
> +	u32 ssp_cfg;
> +
> +	if (loongson_canfd_enabled(priv)) {
> +		netdev_err(ndev, "Cannot set SSP while CAN is enabled\n");
> +		return -EBUSY;
> +	}
> +
> +	if (ctrlmode & CAN_CTRLMODE_TDC_MANUAL)
> +		/* Manual TDC: 2'd2, delay = SSP_OFF */
> +		ssp_cfg = FIELD_PREP(REG_SSP_CFG_SRC, 2) |
> +			  FIELD_PREP(REG_SSP_CFG_OFF, priv->can.fd.tdc.tdco);
> +	else if (ctrlmode & CAN_CTRLMODE_TDC_AUTO)
> +		/* Auto TDC: 2'd0, delay = TRV_DLY + SSP_OFF */
> +		ssp_cfg = FIELD_PREP(REG_SSP_CFG_SRC, 0) |
> +			  FIELD_PREP(REG_SSP_CFG_OFF, priv->can.fd.tdc.tdco);
> +	else
> +		/* TDC Disabled: 2'd1, use standard sample point */
> +		ssp_cfg = FIELD_PREP(REG_SSP_CFG_SRC, 1) |
> +			  FIELD_PREP(REG_SSP_CFG_OFF, 0);
> +
> +	return regmap_write(priv->regmap, LOONGSON_CANFD_SSP_CFG, ssp_cfg);
> +}
> +
> +/**
> + * loongson_canfd_set_data_bittiming() - Set data bit timing and SSP
> + * @ndev: Network device
> + *
> + * BTR_FD and SSP_CFG are refreshed together because the SSP position
> + * depends on the data bit time.
> + *
> + * Return: 0 on success, negative on error.
> + */
> +static int loongson_canfd_set_data_bittiming(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	struct can_bittiming *dbt = &priv->can.fd.data_bittiming;
> +	int ret;
> +
> +	loongson_canfd_set_btr(ndev, dbt, false);
> +
> +	ret = loongson_canfd_set_secondary_sample_point(ndev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/**
> + * loongson_canfd_get_auto_tdcv() - Get transmitter delay compensation value
> + * @ndev: Network device
> + * @tdcv: Pointer to store TDCV value
> + *
> + * Return: 0 on success, -EOPNOTSUPP on CAN_CTRLMODE_TDC_AUTO is not set.
> + */
> +static int loongson_canfd_get_auto_tdcv(const struct net_device *ndev, u32 *tdcv)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	u32 val;
> +
> +	if (!(priv->can.ctrlmode & CAN_CTRLMODE_TDC_AUTO))
> +		return -EOPNOTSUPP;
> +
> +	regmap_read(priv->regmap, LOONGSON_CANFD_TRV_DLY, &val);
> +	*tdcv = FIELD_GET(REG_TRV_DLY_VAL, val);
> +
> +	/* Hardware measurement is complete only when TRV_DLY is not 0 */
> +	if (!*tdcv)
> +		return -EAGAIN;
> +
> +	return 0;
> +}
> +
> +/**
> + * loongson_canfd_apply_ctrlmode() - Apply CAN ctrlmode to MODE/CONF
> + * @priv: Driver private data
> + */
> +static void loongson_canfd_apply_ctrlmode(struct loongson_canfd_priv *priv)
> +{
> +	u32 ctrlmode = priv->can.ctrlmode;
> +	u32 mode, conf;
> +
> +	regmap_read(priv->regmap, LOONGSON_CANFD_MODE, &mode);
> +
> +	mode &= ~(REG_MODE_BMM | REG_MODE_FDE | REG_MODE_ACF | REG_MODE_TSTM);
> +	mode |= REG_MODE_ITSM | REG_MODE_RTSOP;
> +	mode |= LOONGSON_CANFD_FIELD_IF(ctrlmode & CAN_CTRLMODE_LISTENONLY,
> +					REG_MODE_BMM);
> +	mode |= LOONGSON_CANFD_FIELD_IF(ctrlmode & CAN_CTRLMODE_FD,
> +					REG_MODE_FDE);
> +	mode |= LOONGSON_CANFD_FIELD_IF(ctrlmode & CAN_CTRLMODE_PRESUME_ACK,
> +					REG_MODE_ACF);
> +
> +	regmap_write(priv->regmap, LOONGSON_CANFD_MODE, mode);
> +
> +	regmap_read(priv->regmap, LOONGSON_CANFD_CONF, &conf);
> +
> +	conf &= ~(REG_CONF_ILBP | REG_CONF_NISOFD |
> +		  REG_CONF_RTRLE | REG_CONF_RTRTH);
> +
> +	/* RTRLE always on; ONE_SHOT only decides RTRTH */
> +	conf |= REG_CONF_RTRLE;
> +	conf |= LOONGSON_CANFD_FIELD_IF(ctrlmode & CAN_CTRLMODE_LOOPBACK,
> +					REG_CONF_ILBP);
> +	conf |= LOONGSON_CANFD_FIELD_IF(ctrlmode & CAN_CTRLMODE_FD_NON_ISO,
> +					REG_CONF_NISOFD);
> +	conf |= LOONGSON_CANFD_FIELD_IF(!(ctrlmode & CAN_CTRLMODE_ONE_SHOT),
> +					FIELD_PREP(REG_CONF_RTRTH,
> +						   LOONGSON_CANFD_MAX_RTXTH));
> +
> +	regmap_write(priv->regmap, LOONGSON_CANFD_CONF, conf);
> +}
> +
> +/**
> + * loongson_canfd_chip_start() - Start the CAN controller
> + * @ndev: Network device
> + *
> + * Configures bit timing, SSP, interrupt enables, and enables the controller.
> + *
> + * Return: 0 on success, negative error on failure.
> + */
> +static int loongson_canfd_chip_start(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	u32 int_ena, int_msk;
> +	int ret;
> +
> +	ret = loongson_canfd_set_bittiming(ndev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Programs BTR_FD and SSP_CFG together */
> +	ret = loongson_canfd_set_data_bittiming(ndev);
> +	if (ret < 0)
> +		return ret;
> +
> +	loongson_canfd_apply_ctrlmode(priv);
> +
> +	int_ena = REG_INT_STAT_RBNEI | REG_INT_STAT_TXBHCI |
> +		  REG_INT_STAT_EWLI  | REG_INT_STAT_FCSI   |
> +		  REG_INT_STAT_DOI;
> +
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> +		int_ena |= REG_INT_STAT_ALI | REG_INT_STAT_BEI;
> +
> +	int_msk = REG_INT_MASK_SET & ~int_ena;
> +
> +	/* Clear stale mask/ena bits left by disable_interrupts() */
> +	regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, REG_INT_MASK_CLR);
> +	regmap_write(priv->regmap, LOONGSON_CANFD_INT_ENA, REG_INT_ENA_CLR);
> +
> +	regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, int_msk);
> +	regmap_write(priv->regmap, LOONGSON_CANFD_INT_ENA, int_ena);
> +
> +	loongson_canfd_hwts_setup(ndev);
> +
> +	priv->can.state = CAN_STATE_ERROR_ACTIVE;
> +
> +	regmap_update_bits(priv->regmap, LOONGSON_CANFD_CONF, REG_CONF_ENA,
> +			   REG_CONF_ENA);
> +
> +	return 0;
> +}
> +
> +/**
> + * loongson_canfd_chip_stop() - Stop the controller
> + * @ndev: Network device
> + */
> +static void loongson_canfd_chip_stop(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +
> +	loongson_canfd_disable_interrupts(priv);
> +	regmap_update_bits(priv->regmap, LOONGSON_CANFD_CONF, REG_CONF_ENA, 0);
> +
> +	priv->can.state = CAN_STATE_STOPPED;
> +
> +	/* The timestamp counter only runs while the controller is enabled */
> +	WRITE_ONCE(priv->hwts.ready, false);
> +}
> +
> +/**
> + * loongson_canfd_do_set_mode() - Change operation mode
> + * @ndev: Network device
> + * @mode: Mode to set
> + *
> + * Return: 0 on success, negative error on failure.
> + */
> +static int loongson_canfd_do_set_mode(struct net_device *ndev, enum can_mode mode)
> +{
> +	int ret;
> +
> +	switch (mode) {
> +	case CAN_MODE_START:
> +		loongson_canfd_reset(ndev);
> +
> +		ret = loongson_canfd_chip_start(ndev);
> +		if (ret < 0) {
> +			netdev_err(ndev, "Failed to start chip\n");
> +			return ret;
> +		}
> +
> +		netif_wake_queue(ndev);
> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * loongson_canfd_txbuf_freed() - Check if at least one TX buffer is free
> + * @priv: Driver private data
> + *
> + * Examines the TX buffer pending status (BRP bits). If any of the 8 buffers
> + * is not pending, it indicates a free buffer.
> + *
> + * Return: true if at least one TX buffer is free, false if all pending.
> + */
> +static bool loongson_canfd_txbuf_freed(struct loongson_canfd_priv *priv)
> +{
> +	return !regmap_test_bits(priv->regmap, LOONGSON_CANFD_TX_STAT, REG_TX_STAT_BRP);
> +}
> +
> +/**
> + * loongson_canfd_get_txbuf_sts() - Get status of a TX buffer
> + * @priv: Driver private data
> + * @buf_id: Buffer index (0-based, 0..7)
> + *
> + * Reads the 2-bit BS field for @buf_id from TX_STAT. The field is located
> + * at bits (16 + 2 * buf_id) .. (17 + 2 * buf_id).
> + *
> + * Return: Status of the specified TX buffer as an enum value.
> + */
> +static enum loongson_canfd_txbuf_sts
> +loongson_canfd_get_txbuf_sts(struct loongson_canfd_priv *priv, u8 buf_id)
> +{
> +	u32 sts, mask;
> +
> +	/* BS field for buf_id lives at bits (16 + 2*buf_id):(17 + 2*buf_id) */
> +	mask = REG_TX_STAT_BS_TX_MASK_BASE << (2 * buf_id);
> +	regmap_read(priv->regmap, LOONGSON_CANFD_TX_STAT, &sts);
> +
> +	return field_get(mask, sts);
> +}
> +
> +/**
> + * loongson_canfd_txbuf_is_writable() - Check if a TX buffer is writable
> + * @priv: Driver private data
> + * @buf_id: Buffer index (0-based)
> + *
> + * A buffer accepts a new frame only if:
> + *   - its BRP bit is clear (not pending), and
> + *   - its 2-bit BS field is TX_BS_IDLE (previous frame finished).
> + *
> + * Return: true if the buffer is in a writable state, false otherwise.
> + */
> +static bool loongson_canfd_txbuf_is_writable(struct loongson_canfd_priv *priv, u8 buf_id)
> +{
> +	enum loongson_canfd_txbuf_sts bs;
> +
> +	/* Writable only if BS is idle and BRP bit is clear */
> +	bs = loongson_canfd_get_txbuf_sts(priv, buf_id);
> +	if (bs)
> +		return false;
> +
> +	return !regmap_test_bits(priv->regmap, LOONGSON_CANFD_TX_STAT, BIT(buf_id));
> +}
> +
> +/**
> + * loongson_canfd_set_txbuf_cmd() - Apply command on TX buffer
> + * @ndev: Network device
> + * @cmd: Command to apply (TXT_CMD_ADD, TXT_CMD_CANCEL, TXT_CMD_SR_CLEAN)
> + * @buf_id: Buffer index (0-based)
> + *
> + * Writes the appropriate command bit (BAR, BCR, or BSC) for @buf_id into
> + * the TX_CMD register. Each command field is 8 bits wide, so the buffer
> + * index is encoded as BIT(buf_id).
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static int loongson_canfd_set_txbuf_cmd(struct net_device *ndev,
> +					enum loongson_canfd_txbuf_cmd cmd, u8 buf_id)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	u32 mask;
> +
> +	switch (cmd) {
> +	case TXT_CMD_ADD:
> +		mask = REG_TX_CMD_BAR;
> +		break;
> +	case TXT_CMD_CANCEL:
> +		mask = REG_TX_CMD_BCR;
> +		break;
> +	case TXT_CMD_SR_CLEAN:
> +		mask = REG_TX_CMD_BSC;
> +		break;
> +	default:
> +		netdev_err(ndev, "Unknown command id: %x\n", cmd);
> +		return -EINVAL;
> +	}
> +
> +	/* Each command field is 8 bits wide: buffer index is BIT(buf_id) */
> +	return regmap_write(priv->regmap, LOONGSON_CANFD_TX_CMD,
> +			    field_prep(mask, BIT(buf_id)));
> +}
> +
> +/**
> + * loongson_canfd_insert_frame() - Insert a frame into TX buffer
> + * @priv: Driver private data
> + * @cf: CAN frame to transmit
> + * @buf: Buffer index (0-based)
> + * @isfdf: true for CAN FD frame, false for CAN 2.0
> + *
> + * Writes the frame header (META0, META1) and payload into the selected
> + * TX buffer. For RTR frames, no payload is written.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static int loongson_canfd_insert_frame(struct loongson_canfd_priv *priv,
> +				       const struct canfd_frame *cf, u8 buf,
> +				       bool isfdf)
> +{
> +	u32 frame_hdr0, frame_hdr1 = 0;
> +	int ret;
> +
> +	if (buf >= LOONGSON_CANFD_TXBUF_NUM)
> +		return -EINVAL;
> +
> +	if (!loongson_canfd_txbuf_is_writable(priv, buf))
> +		return -EBUSY;
> +
> +	if (cf->can_id & CAN_EFF_FLAG) {
> +		frame_hdr0 = cf->can_id & CAN_EFF_MASK;
> +		frame_hdr0 |= REG_FRAME_META0_XDT;
> +	} else {
> +		frame_hdr0 = FIELD_PREP(REG_FRAME_META0_ID_BASE,
> +					cf->can_id & CAN_SFF_MASK);
> +	}
> +
> +	if (cf->can_id & CAN_RTR_FLAG)
> +		frame_hdr0 |= REG_FRAME_META0_RTR;
> +
> +	if (isfdf) {
> +		frame_hdr1 = REG_FRAME_META1_FDF;
> +		if (cf->flags & CANFD_BRS)
> +			frame_hdr1 |= REG_FRAME_META1_BRS;
> +		frame_hdr1 |= FIELD_PREP(REG_FRAME_META1_DLC,
> +					 can_fd_len2dlc(cf->len));
> +	} else {
> +		/*
> +		 * Classic CAN: can_get_cc_dlc() honours CC_LEN8_DLC so
> +		 * len8_dlc can request DLC 9..15 for len == 8.
> +		 */
> +		struct can_frame *ccf = (struct can_frame *)cf;
> +
> +		frame_hdr1 |= FIELD_PREP(REG_FRAME_META1_DLC,
> +					 can_get_cc_dlc(ccf, priv->can.ctrlmode));
> +	}
> +
> +	ret = regmap_write(priv->regmap, LOONGSON_CANFD_TX_SEL, buf);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap,
> +			   LOONGSON_CANFD_TX_DATA_1 + LOONGSON_CANFD_FRAME_META0,
> +			   frame_hdr0);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap,
> +			   LOONGSON_CANFD_TX_DATA_1 + LOONGSON_CANFD_FRAME_META1,
> +			   frame_hdr1);
> +	if (ret)
> +		return ret;
> +
> +	/* RTR frames carry no payload */
> +	if (cf->can_id & CAN_RTR_FLAG)
> +		return 0;
> +
> +	for (unsigned int i = 0; i < cf->len; i += LOONGSON_CANFD_DW_BYTE) {
> +		unsigned int remain = cf->len - i;
> +		u32 word;
> +
> +		if (remain >= LOONGSON_CANFD_DW_BYTE) {
> +			word = get_unaligned_le32(cf->data + i);
> +		} else {
> +			u8 buf[LOONGSON_CANFD_DW_BYTE] = { 0 };
> +
> +			memcpy(buf, cf->data + i, remain);
> +			word = get_unaligned_le32(buf);
> +		}
> +
> +		ret = regmap_write(priv->regmap,
> +				   LOONGSON_CANFD_TX_DATA_1 +
> +				   LOONGSON_CANFD_FRAME_DB_1 + i,
> +				   word);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * loongson_canfd_find_free_txbuf() - Find a TX buffer ready for immediate write
> + * @priv: Driver private data
> + *
> + * The hardware requires both conditions to be met for a buffer to accept
> + * a new frame:
> + *   - its BRP bit indicates the buffer is not pending (tx_brp bit clear)
> + *   - its 2-bit BS field indicates the previous frame finished (tx_bs bits clear)
> + *
> + * Return: buffer index 0..LOONGSON_CANFD_TXBUF_NUM-1, or -1 if none free.
> + */
> +static int loongson_canfd_find_free_txbuf(struct loongson_canfd_priv *priv)
> +{
> +	unsigned long tx_brp;
> +	u32 tx_stat, i;
> +	u16 tx_bs;
> +
> +	regmap_read(priv->regmap, LOONGSON_CANFD_TX_STAT, &tx_stat);
> +	tx_brp = FIELD_GET(REG_TX_STAT_BRP, tx_stat);
> +	tx_bs  = FIELD_GET(REG_TX_STAT_BS, tx_stat);
> +
> +	/* Need both BRP clear and BS idle; skip slots still echoing */
> +	for_each_clear_bit(i, &tx_brp, LOONGSON_CANFD_TXBUF_NUM) {
> +		u32 mask = 0x3 << (i * 2);
> +
> +		if (!(tx_bs & mask)) {
> +			if (priv->can.echo_skb[i])
> +				continue;
> +			return i;
> +		}
> +	}
> +
> +	return -1;
> +}
> +
> +/**
> + * loongson_canfd_hdr_plausible() - Decide whether a header pair is real
> + * @hdr0: META0 word
> + * @hdr1: META1 word
> + *
> + * Cross-checks META0/META1 field widths against protocol limits and
> + * validates RWCNT against the frame type. The RTR check must stay
> + * here: this is also used as a DMA resync probe and needs the full
> + * discriminator to avoid mistaking a payload word for a header.
> + *
> + * Return: true if the pair is consistent with a real frame header.
> + */
> +static bool loongson_canfd_hdr_plausible(u32 hdr0, u32 hdr1)
> +{
> +	u32 rwcnt  = FIELD_GET(REG_FRAME_META1_RWCNT, hdr1);
> +	u32 dlc    = FIELD_GET(REG_FRAME_META1_DLC,   hdr1);
> +	bool isfd  = !!(hdr1 & REG_FRAME_META1_FDF);
> +	bool isrtr = !!(hdr0 & REG_FRAME_META0_RTR);
> +	u32 payload_len, expected_rwcnt;
> +
> +	/* 2 header words + payload, within CAN FD limits */
> +	if (rwcnt < 2 || rwcnt > 2 + CANFD_MAX_DLEN / LOONGSON_CANFD_DW_BYTE)
> +		return false;
> +
> +	/* RTR is a Classic CAN concept */
> +	if (isfd && isrtr)
> +		return false;
> +
> +	/* Standard ID fits in 11 bits */
> +	if (!(hdr0 & REG_FRAME_META0_XDT) &&
> +	    FIELD_GET(REG_FRAME_META0_ID_BASE, hdr0) > CAN_SFF_MASK)

[Severity: Low]
Can this check ever reject anything?

REG_FRAME_META0_ID_BASE is GENMASK(28, 18), an 11-bit field. FIELD_GET()
on it returns at most 0x7ff, which equals CAN_SFF_MASK, so the
comparison is always false. Standard-ID headers are never filtered
here.

The kernel-doc describes loongson_canfd_hdr_plausible() as the full
discriminator that stops payload words from being taken as a header.
A dead test weakens that.

Was the intent to require REG_FRAME_META0_ID_EXT (bits 17:0) to be
zero when XDT is clear? If the controller does not guarantee that, the
check should probably be dropped instead.

The & CAN_SFF_MASK applied after the same FIELD_GET() in
loongson_canfd_rx_deliver() is also a no-op.

> +		return false;
> +
> +	/* RTR frames carry no payload */
> +	if (isrtr)
> +		return rwcnt == 2;
> +
> +	/*
> +	 * RWCNT and DLC are independent fields; a real data frame always
> +	 * satisfies rwcnt == 2 + DIV_ROUND_UP(payload_len, 4).
> +	 */
> +	if (isfd)
> +		payload_len = can_fd_dlc2len(dlc);
> +	else
> +		payload_len = min_t(u32, dlc, CAN_MAX_DLEN);
> +
> +	expected_rwcnt = 2 + DIV_ROUND_UP(payload_len, LOONGSON_CANFD_DW_BYTE);
> +	return rwcnt == expected_rwcnt;
> +}
> +
> +/**
> + * loongson_canfd_rx_note_bad() - Account a malformed frame and resync the FIFO
> + * @ndev: Network device
> + * @rwcnt: Raw RWCNT field from the rejected frame's META1 word
> + *
> + * @rwcnt may be a sentinel from rx_hdr_valid(), so the payload drain
> + * is clamped to the maximum legal CAN FD size.
> + */
> +static void loongson_canfd_rx_note_bad(struct net_device *ndev, u32 rwcnt)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	u32 words, data;
> +
> +	ndev->stats.rx_dropped++;
> +
> +	words = rwcnt > 2 ?
> +		min_t(u32, rwcnt - 2,
> +		      CANFD_MAX_DLEN / LOONGSON_CANFD_DW_BYTE) : 0;
> +	while (words--)
> +		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
> +}
> +
> +/**
> + * loongson_canfd_rx_hdr_valid() - Validate a frame header pair
> + * @ndev: Network device
> + * @d: Output descriptor, filled with all parsed fields
> + *
> + * Reads and sanity-checks the two header words. The caller must drain
> + * the remaining payload words when false is returned.
> + *
> + * Return: true if the header is valid, false otherwise.
> + */
> +static bool loongson_canfd_rx_hdr_valid(struct net_device *ndev,
> +					struct loongson_canfd_rx_desc *d)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +
> +	d->hdr0 = loongson_canfd_read_rx_word_fifo(priv);
> +	d->hdr1 = loongson_canfd_read_rx_word_fifo(priv);
> +
> +	d->rwcnt = FIELD_GET(REG_FRAME_META1_RWCNT, d->hdr1);
> +	if (d->rwcnt < 2) {
> +		/* Hand the caller a worst-case drain length */
> +		d->rwcnt = 2 + CANFD_MAX_DLEN / LOONGSON_CANFD_DW_BYTE;
> +		return false;
> +	}
> +
> +	d->dbcnt = (d->rwcnt - 2) * LOONGSON_CANFD_DW_BYTE;
> +	if (d->dbcnt > CANFD_MAX_DLEN)
> +		return false;
> +
> +	d->is_can_fd = !!(d->hdr1 & REG_FRAME_META1_FDF);
> +	d->is_rtr    = !!(d->hdr0 & REG_FRAME_META0_RTR);
> +
> +	/* Classic CAN cannot exceed 8 bytes; oversized dbcnt would overflow */
> +	if (!d->is_can_fd && d->dbcnt > CAN_MAX_DLEN)
> +		return false;
> +
> +	/* Reject payload words that happen to sit at a header boundary */
> +	if (!loongson_canfd_hdr_plausible(d->hdr0, d->hdr1))
> +		return false;
> +
> +	return true;
> +}
> +
> +/**
> + * loongson_canfd_rx_deliver() - Build and deliver the skb for one frame
> + * @ndev: Network device
> + * @d: Validated frame descriptor
> + *
> + * Return: 1 on success, -ENOMEM if skb allocation failed.
> + */
> +static int loongson_canfd_rx_deliver(struct net_device *ndev,
> +				     const struct loongson_canfd_rx_desc *d)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	struct net_device_stats *stats = &ndev->stats;
> +	struct canfd_frame *cfd;
> +	struct can_frame *ccf;
> +	struct sk_buff *skb;
> +	u32 dlc, i;
> +
> +	if (d->is_can_fd) {
> +		skb = alloc_canfd_skb(ndev, &cfd);
> +	} else {
> +		skb = alloc_can_skb(ndev, &ccf);
> +		cfd = (struct canfd_frame *)ccf;
> +	}
> +
> +	if (unlikely(!skb))
> +		return -ENOMEM;
> +
> +	if (d->hdr0 & REG_FRAME_META0_XDT)
> +		cfd->can_id = (d->hdr0 & CAN_EFF_MASK) | CAN_EFF_FLAG;
> +	else
> +		cfd->can_id = FIELD_GET(REG_FRAME_META0_ID_BASE, d->hdr0) &
> +			      CAN_SFF_MASK;
> +
> +	cfd->flags = 0;
> +
> +	if (d->is_can_fd) {
> +		if (d->hdr1 & REG_FRAME_META1_BRS)
> +			cfd->flags |= CANFD_BRS;
> +		if (d->hdr0 & REG_FRAME_META0_ESI)
> +			cfd->flags |= CANFD_ESI;
> +	} else if (d->is_rtr) {
> +		cfd->can_id |= CAN_RTR_FLAG;
> +	}
> +
> +	dlc = FIELD_GET(REG_FRAME_META1_DLC, d->hdr1);
> +	if (d->is_can_fd)
> +		cfd->len = can_fd_dlc2len(dlc);
> +	else
> +		can_frame_set_cc_len(ccf, dlc, priv->can.ctrlmode);
> +
> +	/*
> +	 * dbcnt is authoritative. Clamp len to it so uninitialized skb
> +	 * bytes are never exposed; RTR frames carry no payload and are
> +	 * the exception.
> +	 */
> +	if (!d->is_rtr && unlikely(cfd->len > d->dbcnt))
> +		cfd->len = d->dbcnt;
> +
> +	for (i = 0; i < d->dbcnt; i += LOONGSON_CANFD_DW_BYTE)
> +		put_unaligned_le32(loongson_canfd_read_rx_word_fifo(priv),
> +				   cfd->data + i);
> +
> +	if (!d->is_rtr)
> +		stats->rx_bytes += cfd->len;
> +	stats->rx_packets++;
> +
> +	/* Raw 0 is a legal counter sample on the wrap boundary */
> +	if (READ_ONCE(priv->hwts.ready)) {
> +		u32 raw = FIELD_GET(REG_FRAME_META1_TIMESTAMP, d->hdr1);
> +
> +		skb_hwtstamps(skb)->hwtstamp = loongson_canfd_hwts_ts(priv, raw);
> +	}
> +
> +	netif_receive_skb(skb);
> +	return 1;
> +}
> +
> +/**
> + * loongson_canfd_rx_one_frame_fifo() - Process one RX step in FIFO mode
> + * @ndev: Network device
> + *
> + * Reads one frame header, validates it, and delivers the frame.
> + * Malformed frames are dropped and accounted internally.
> + *
> + * Return: 1 - one frame consumed (delivered or dropped on purpose)
> + */
> +static int loongson_canfd_rx_one_frame_fifo(struct net_device *ndev)
> +{
> +	struct loongson_canfd_rx_desc d;
> +	int ret;
> +
> +	if (!loongson_canfd_rx_hdr_valid(ndev, &d)) {
> +		loongson_canfd_rx_note_bad(ndev, d.rwcnt);
> +		return 1;
> +	}
> +
> +	ret = loongson_canfd_rx_deliver(ndev, &d);
> +	if (ret == -ENOMEM)
> +		loongson_canfd_rx_note_bad(ndev, d.rwcnt);
> +
> +	return 1;
> +}
> +
> +/**
> + * loongson_canfd_rx_overrun_event() - Account and clear a hardware RX overrun
> + * @ndev: Network device
> + *
> + * Called from hard IRQ context on INT_STAT.DOI, so the error frame is
> + * queued via netif_rx() and logging is rate-limited. DOR is cleared
> + * with REG_CMD_CDO; if the FIFO is still full it re-latches and DOI
> + * fires again.
> + *
> + * Return: true if DOR was latched and has been cleared, false if
> + *         this was a stale DOI (no live DOR).
> + */
> +static bool loongson_canfd_rx_overrun_event(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	struct net_device_stats *stats = &ndev->stats;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +	u32 stat;
> +
> +	/* DOR is the authoritative sticky flag, DOI is only a hint */
> +	regmap_read(priv->regmap, LOONGSON_CANFD_STAT, &stat);
> +	if (!(stat & REG_STAT_DOR))
> +		return false;
> +
> +	scoped_guard(spinlock_irqsave, &priv->stats_lock) {
> +		stats->rx_over_errors++;
> +		stats->rx_errors++;
> +	}
> +
> +	if (net_ratelimit())
> +		netdev_err(ndev, "Rx Overflow\n");
> +
> +	/*
> +	 * Overrun is a controller condition, not a bus error: report it
> +	 * as CAN_ERR_CRTL/CAN_ERR_CRTL_RX_OVERFLOW. A failed allocation
> +	 * only loses the notification.
> +	 */
> +	skb = alloc_can_err_skb(ndev, &cf);
> +	if (skb) {
> +		cf->can_id |= CAN_ERR_CRTL;
> +		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
> +
> +		scoped_guard(spinlock_irqsave, &priv->stats_lock) {
> +			stats->rx_packets++;
> +			stats->rx_bytes += cf->len;
> +		}
> +
> +		/* Hard IRQ: use netif_rx(), not netif_receive_skb() */
> +		netif_rx(skb);
> +	}
> +
> +	/*
> +	 * Clear the sticky DOR first. The caller clears DOI right after
> +	 * this returns; if DOR were still latched at that point, the
> +	 * hardware would immediately re-raise DOI.
> +	 */
> +	regmap_write(priv->regmap, LOONGSON_CANFD_CMD, REG_CMD_CDO);
> +
> +	return true;
> +}
> +
> +/**
> + * loongson_canfd_rx_napi_done() - Complete NAPI and re-arm the RX interrupt
> + * @napi: NAPI instance
> + * @can_complete: True if the poll loop saw an empty hardware FIFO
> + * @work_done: Frames processed during this poll
> + *
> + * The RX interrupt is re-armed only after the loop actually quiesced;
> + * a quota-limited exit keeps NAPI scheduled to poll again.
> + */
> +static void loongson_canfd_rx_napi_done(struct napi_struct *napi,
> +					bool can_complete, int work_done)
> +{
> +	struct net_device *ndev = napi->dev;
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +
> +	if (!can_complete || !napi_complete_done(napi, work_done))
> +		return;
> +
> +	regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK,
> +		     FIELD_PREP(REG_INT_MASK_CLR, REG_INT_STAT_RBNEI));
> +}
> +
> +/**
> + * loongson_canfd_rx_napi() - NAPI poll routine for RX
> + * @napi: NAPI structure
> + * @quota: Maximum number of frames to process
> + *
> + * Return: Number of frames processed.
> + */
> +static int loongson_canfd_rx_napi(struct napi_struct *napi, int quota)
> +{
> +	struct net_device *ndev = napi->dev;
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	bool can_complete = false;
> +	int work_done = 0;
> +	int ret;
> +
> +	while (work_done < quota) {
> +		/* FIFO empty: nothing left to consume */
> +		if (loongson_canfd_rx_is_empty_fifo(priv)) {
> +			can_complete = true;
> +			break;
> +		}
> +
> +		ret = loongson_canfd_rx_one_frame_fifo(ndev);
> +		if (ret == 1)
> +			work_done++;
> +	}
> +
> +	loongson_canfd_rx_napi_done(napi, can_complete, work_done);
> +
> +	return work_done;
> +}
> +
> +/**
> + * loongson_canfd_get_bec() - Read error counters
> + * @priv: Driver private data
> + * @bec: Structure to fill with TX/RX error counts
> + */
> +static void loongson_canfd_get_bec(struct loongson_canfd_priv *priv,
> +				   struct can_berr_counter *bec)
> +{
> +	u32 erc;
> +
> +	regmap_read(priv->regmap, LOONGSON_CANFD_ERC, &erc);
> +	bec->rxerr = FIELD_GET(REG_ERC_REC, erc);
> +	bec->txerr = FIELD_GET(REG_ERC_TEC, erc);
> +}
> +
> +/**
> + * loongson_canfd_get_berr_counter() - Get error counter (callback)
> + * @ndev: Network device
> + * @bec: Structure to fill
> + *
> + * Return: 0 always.
> + */
> +static int loongson_canfd_get_berr_counter(const struct net_device *ndev,
> +					   struct can_berr_counter *bec)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +
> +	loongson_canfd_get_bec(priv, bec);
> +	return 0;
> +}
> +
> +/**
> + * loongson_canfd_get_fault_state() - Read fault confinement state
> + * @ndev: Network device
> + *
> + * Return: Current CAN state (ACTIVE, WARNING, PASSIVE, BUS_OFF).
> + */
> +static enum can_state loongson_canfd_get_fault_state(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	enum can_state sts = CAN_STATE_ERROR_PASSIVE;
> +	u32 fstat, ewl, erl, rec_tec, max_tec;
> +
> +	regmap_read(priv->regmap, LOONGSON_CANFD_FSTAT, &fstat);
> +
> +	switch (FIELD_GET(REG_FSTAT_MASK, fstat)) {
> +	case REG_FSTAT_ERA:
> +		regmap_read(priv->regmap, LOONGSON_CANFD_ERL, &erl);
> +		regmap_read(priv->regmap, LOONGSON_CANFD_ERC, &rec_tec);
> +
> +		ewl = FIELD_GET(REG_ERL_EW, erl);
> +		max_tec = max(FIELD_GET(REG_ERC_REC, rec_tec),
> +			      FIELD_GET(REG_ERC_TEC, rec_tec));
> +
> +		if (ewl > max_tec)
> +			sts = CAN_STATE_ERROR_ACTIVE;
> +		else
> +			sts = CAN_STATE_ERROR_WARNING;
> +		break;
> +	case REG_FSTAT_ERP:
> +		sts = CAN_STATE_ERROR_PASSIVE;
> +		break;
> +	case REG_FSTAT_BOF:
> +		sts = CAN_STATE_BUS_OFF;
> +		break;
> +	default:
> +		netdev_err(ndev, "Invalid error state\n");
> +		break;
> +	}
> +
> +	return sts;
> +}
> +
> +/**
> + * loongson_canfd_report_state_change() - Report a CAN state transition
> + * @ndev: Network device
> + * @new_state: New CAN state reported by the controller
> + * @bec: Current error counters (used to fill the error frame)
> + *
> + * Called only when the protocol state actually moved: the controller
> + * latches FCSI on reset-to-Error-Active even without a visible
> + * transition, and the caller filters that case.
> + */
> +static void loongson_canfd_report_state_change(struct net_device *ndev,
> +					       enum can_state new_state,
> +					       const struct can_berr_counter *bec)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +
> +	netdev_info(ndev, "state changes from %s to %s\n",
> +		    can_get_state_str(priv->can.state),
> +		    can_get_state_str(new_state));
> +
> +	priv->can.state = new_state;
> +
> +	/* Stats and BUS_OFF handling must not depend on skb allocation */
> +	switch (new_state) {
> +	case CAN_STATE_BUS_OFF:
> +		priv->can.can_stats.bus_off++;
> +		can_bus_off(ndev);
> +		break;
> +	case CAN_STATE_ERROR_PASSIVE:
> +		priv->can.can_stats.error_passive++;
> +		break;
> +	case CAN_STATE_ERROR_WARNING:
> +		priv->can.can_stats.error_warning++;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	skb = alloc_can_err_skb(ndev, &cf);
> +	if (!skb)
> +		return;
> +
> +	switch (new_state) {
> +	case CAN_STATE_BUS_OFF:
> +		cf->can_id |= CAN_ERR_BUSOFF;
> +		goto send;
> +	case CAN_STATE_ERROR_ACTIVE:
> +		cf->can_id |= CAN_ERR_CNT;
> +		cf->data[1] = CAN_ERR_CRTL_ACTIVE;
> +		break;
> +	case CAN_STATE_ERROR_PASSIVE:
> +		cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
> +		if (bec->rxerr >= CAN_ERROR_PASSIVE_THRESHOLD)
> +			cf->data[1] = CAN_ERR_CRTL_RX_PASSIVE;
> +		else
> +			cf->data[1] = CAN_ERR_CRTL_TX_PASSIVE;
> +		break;
> +	case CAN_STATE_ERROR_WARNING:
> +		cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
> +		if (bec->txerr > bec->rxerr)
> +			cf->data[1] |= CAN_ERR_CRTL_TX_WARNING;
> +		else
> +			cf->data[1] |= CAN_ERR_CRTL_RX_WARNING;
> +		break;
> +	default:
> +		netdev_err(ndev, "Unexpected state: %d\n", new_state);
> +		kfree_skb(skb);
> +		return;
> +	}
> +
> +	cf->data[6] = bec->txerr;
> +	cf->data[7] = bec->rxerr;
> +send:
> +	netif_rx(skb);
> +}
> +
> +/**
> + * loongson_canfd_report_arb_lost() - Report an arbitration lost event
> + * @ndev: Network device
> + *
> + * Accounts the event and emits the corresponding CAN error frame.
> + */
> +static void loongson_canfd_report_arb_lost(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +
> +	priv->can.can_stats.arbitration_lost++;
> +
> +	skb = alloc_can_err_skb(ndev, &cf);
> +	if (!skb)
> +		return;
> +
> +	cf->can_id |= CAN_ERR_LOSTARB;
> +	cf->data[0] = CAN_ERR_LOSTARB_UNSPEC;
> +
> +	netif_rx(skb);
> +}
> +
> +/**
> + * loongson_canfd_report_bus_error() - Report a bus error event
> + * @ndev: Network device
> + *
> + * Accounts the event and emits the corresponding CAN error frame.
> + */
> +static void loongson_canfd_report_bus_error(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	struct net_device_stats *stats = &ndev->stats;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +
> +	priv->can.can_stats.bus_error++;
> +	scoped_guard(spinlock_irqsave, &priv->stats_lock) {
> +		stats->rx_errors++;
> +	}
> +
> +	skb = alloc_can_err_skb(ndev, &cf);
> +	if (!skb)
> +		return;
> +
> +	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
> +	cf->data[2] = CAN_ERR_PROT_UNSPEC;
> +	cf->data[3] = CAN_ERR_PROT_LOC_UNSPEC;
> +
> +	netif_rx(skb);
> +}
> +
> +/**
> + * loongson_canfd_err_interrupt() - Handle error interrupts
> + * @ndev: Network device
> + * @isr: Interrupt status register value
> + *
> + * Dispatches error events to their respective handlers and re-enables
> + * the serviced interrupt sources.
> + */
> +static void loongson_canfd_err_interrupt(struct net_device *ndev, u32 isr)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	struct can_berr_counter bec;
> +	u32 capt, alc, mask = 0;
> +	enum can_state state;
> +
> +	loongson_canfd_get_bec(priv, &bec);
> +	regmap_read(priv->regmap, LOONGSON_CANFD_ERR_CAPT, &capt);
> +	regmap_read(priv->regmap, LOONGSON_CANFD_ALC, &alc);
> +
> +	if (net_ratelimit())
> +		netdev_info(ndev, "%s: ISR 0x%08x, rxerr %d, txerr %d, error type %lu, pos %lu, ALC id_field %lu, bit %lu\n",
> +			    __func__, isr, bec.rxerr, bec.txerr,
> +			    FIELD_GET(REG_ERR_CAPT_TYPE, capt),
> +			    FIELD_GET(REG_ERR_CAPT_POS, capt),
> +			    FIELD_GET(REG_ALC_ID_FIELD, alc),
> +			    FIELD_GET(REG_ALC_BIT_POS, alc));
> +
> +	if (isr & (REG_INT_STAT_FCSI | REG_INT_STAT_EWLI)) {
> +		mask |= REG_INT_STAT_FCSI | REG_INT_STAT_EWLI;
> +		state = loongson_canfd_get_fault_state(ndev);
> +
> +		/*
> +		 * FCSI is latched on reset -> Error Active, but that is
> +		 * not a protocol-visible transition: filter it out.
> +		 */
> +		if (priv->can.state != state)
> +			loongson_canfd_report_state_change(ndev, state, &bec);
> +	}
> +
> +	if (isr & REG_INT_STAT_ALI) {
> +		mask |= REG_INT_STAT_ALI;
> +		netdev_dbg(ndev, "Arbitration lost interrupt\n");
> +		loongson_canfd_report_arb_lost(ndev);
> +	}
> +
> +	if (isr & REG_INT_STAT_BEI) {
> +		mask |= REG_INT_STAT_BEI;
> +		netdev_dbg(ndev, "Bus error interrupt\n");
> +		loongson_canfd_report_bus_error(ndev);
> +	}
> +
> +	regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK,
> +		     FIELD_PREP(REG_INT_MASK_CLR, mask));
> +}
> +
> +/**
> + * loongson_canfd_tx_interrupt() - Handle TX completion interrupt
> + * @ndev: Network device
> + *
> + * For each completed TX buffer: TX_BS_VALID echoes the skb (with an
> + * optional HW TX timestamp) and counts it sent; TX_BS_FAIL and
> + * TX_BS_CANCEL free the skb as dropped. Clears the completion record
> + * per slot and wakes the queue if a buffer became free.
> + */
> +static void loongson_canfd_tx_interrupt(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	struct net_device_stats *stats = &ndev->stats;
> +	enum loongson_canfd_txbuf_sts sts;
> +	u32 tx_frame_cnt, tx_stat;
> +	bool processed = false;
> +	struct sk_buff *skb;
> +	bool wake;
> +
> +	/*
> +	 * Hold tx_lock only for the buffer scan and bookkeeping;
> +	 * netif_wake_queue() is called outside so a re-entrant
> +	 * loongson_canfd_start_xmit() on another CPU is not blocked
> +	 * on this lock.
> +	 */
> +	scoped_guard(spinlock_irqsave, &priv->tx_lock) {
> +		regmap_read(priv->regmap, LOONGSON_CANFD_TX_STAT, &tx_stat);
> +
> +		for (unsigned int buf_id = 0; buf_id < LOONGSON_CANFD_TXBUF_NUM; buf_id++) {
> +			sts = loongson_canfd_get_txbuf_sts(priv, buf_id);
> +
> +			if (sts == TX_BS_IDLE) {
> +				/* BRP set: hardware still queued/arbitrating */
> +				if (tx_stat & BIT(buf_id))
> +					continue;
> +
> +				/*
> +				 * Hardware is idle but echo_skb is occupied
> +				 * (lost interrupt). Free it, but do not issue
> +				 * SR_CLEAN on an idle slot: it can fake a
> +				 * command interrupt and cause a storm.
> +				 */
> +				if (priv->can.echo_skb[buf_id]) {
> +					netdev_warn(ndev,
> +						    "TX buf %u idle but echo_skb occupied, force free\n",
> +						    buf_id);
> +					can_free_echo_skb(ndev, buf_id, NULL);
> +					stats->tx_dropped++;
> +				}
> +				continue;
> +			}
> +
> +			processed = true;
> +			switch (sts) {
> +			case TX_BS_VALID:
> +				u32 dummy_len;
> +
> +				/*
> +				 * The controller does not latch a per-frame
> +				 * TX stamp, so the instant the handler reads
> +				 * the counter is the best estimate of the
> +				 * end of the frame.
> +				 */
> +				skb = priv->can.echo_skb[buf_id];
> +				if (skb &&
> +				    (skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS) &&
> +				    READ_ONCE(priv->hwts.ready))
> +					skb_hwtstamps(skb)->hwtstamp =
> +							loongson_canfd_hwts_now(priv);
> +
> +				dummy_len = can_get_echo_skb(ndev, buf_id, NULL);
> +				(void)dummy_len;
> +				stats->tx_packets++;
> +				break;
> +			case TX_BS_FAIL:
> +				regmap_read(priv->regmap, LOONGSON_CANFD_TX_FR_CNT,
> +					    &tx_frame_cnt);
> +				netdev_dbg(ndev, "TX buffer in FAIL state, TX frame count: %d\n",
> +					   tx_frame_cnt);
> +				can_free_echo_skb(ndev, buf_id, NULL);
> +				stats->tx_dropped++;
> +				break;
> +			case TX_BS_CANCEL:
> +				netdev_dbg(ndev, "TX buffer in CANCEL state\n");
> +				can_free_echo_skb(ndev, buf_id, NULL);
> +				stats->tx_dropped++;
> +				break;
> +			default:
> +				netdev_dbg(ndev, "Unexpected TX status: %d\n", sts);
> +				break;
> +			}
> +
> +			/* Clear the completion record only for finished slots */
> +			if (loongson_canfd_set_txbuf_cmd(ndev, TXT_CMD_SR_CLEAN, buf_id))
> +				netdev_warn(ndev, "Failed to clear TX buffer %u status\n", buf_id);
> +		}
> +
> +		if (!processed)
> +			netdev_warn_once(ndev, "Spurious TX interrupt\n");
> +
> +		wake = loongson_canfd_txbuf_freed(priv);
> +	}
> +
> +	if (wake)
> +		netif_wake_queue(ndev);
> +}
> +
> +/**
> + * loongson_canfd_interrupt() - Main interrupt handler
> + * @irq: IRQ number
> + * @dev_id: Device identifier (net_device)
> + *
> + * Return: IRQ_HANDLED if interrupt was handled, IRQ_NONE otherwise.
> + */
> +static irqreturn_t loongson_canfd_interrupt(int irq, void *dev_id)
> +{
> +	struct net_device *ndev = (struct net_device *)dev_id;
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	u32 isr, imask;
> +
> +	for (unsigned int loops = 0; loops < LOONGSON_CANFD_IRQ_LOOP_MAX; loops++) {
> +		regmap_read(priv->regmap, LOONGSON_CANFD_INT_STAT, &isr);
> +		if (!isr) {
> +			if (loops)
> +				return IRQ_HANDLED;
> +			else
> +				return IRQ_NONE;
> +		}
> +
> +		if (isr & REG_INT_STAT_RBNEI) {
> +			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK,
> +				     REG_INT_STAT_RBNEI);
> +			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT,
> +				     REG_INT_STAT_RBNEI);
> +
> +			napi_schedule(&priv->napi);
> +		}
> +
> +		if (isr & REG_INT_STAT_TXBHCI) {
> +			/*
> +			 * Mask-clear-handle-unmask: a TX completing during
> +			 * handling re-latches TXBHCI and fires a fresh IRQ
> +			 * after the unmask, instead of being wiped by the
> +			 * W1C in tx_interrupt().
> +			 */
> +			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK,
> +				     REG_INT_STAT_TXBHCI);
> +			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT,
> +				     REG_INT_STAT_TXBHCI);
> +			loongson_canfd_tx_interrupt(ndev);
> +			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK,
> +				     FIELD_PREP(REG_INT_MASK_CLR, REG_INT_STAT_TXBHCI));
> +		}
> +
> +		if (isr & REG_INT_STAT_DOI) {
> +			/* Same discipline as TXBHCI, so an overrun during
> +			 * handling is counted rather than absorbed by the
> +			 * W1C below.
> +			 */
> +			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK,
> +				     REG_INT_STAT_DOI);
> +
> +			loongson_canfd_rx_overrun_event(ndev);
> +
> +			/* DOR is clear now: acknowledge DOI safely */
> +			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT,
> +				     REG_INT_STAT_DOI);
> +
> +			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK,
> +				     FIELD_PREP(REG_INT_MASK_CLR, REG_INT_STAT_DOI));
> +		}
> +
> +		imask = isr & REG_INT_STAT_ERRORI;
> +		if (imask) {
> +			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, imask);
> +			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, imask);
> +			loongson_canfd_err_interrupt(ndev, isr);
> +		}
> +	}
> +
> +	netdev_err(ndev, "Interrupt loop timeout, state: 0x%x\n", isr);
> +
> +	if (isr & REG_INT_STAT_TXBHCI) {
> +		for (unsigned int i = 0; i < LOONGSON_CANFD_TXBUF_NUM; i++) {
> +			u32 sts = loongson_canfd_get_txbuf_sts(priv, i);
> +
> +			netdev_err(ndev, "TX buf %d status: 0x%x\n", i, sts);
> +		}
> +	}
> +
> +	loongson_canfd_disable_interrupts(priv);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * loongson_canfd_start_xmit() - Transmit a CAN frame
> + * @skb: Socket buffer
> + * @ndev: Network device
> + *
> + * Return: NETDEV_TX_OK on success, NETDEV_TX_BUSY if queue full.
> + */
> +static netdev_tx_t loongson_canfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	struct net_device_stats *stats = &ndev->stats;
> +	int buf_id, ret;
> +
> +	if (can_dropped_invalid_skb(ndev, skb))
> +		return NETDEV_TX_OK;
> +
> +	guard(spinlock_irqsave)(&priv->tx_lock);
> +
> +	if (unlikely(!loongson_canfd_txbuf_freed(priv))) {
> +		netif_stop_queue(ndev);
> +		netdev_dbg(ndev, "No free TX buffer while queue was awake!\n");
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	buf_id = loongson_canfd_find_free_txbuf(priv);
> +	if (buf_id < 0) {
> +		netif_stop_queue(ndev);
> +		netdev_dbg(ndev, "No writable TX buffer, stopping queue\n");
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	ret = loongson_canfd_insert_frame(priv, cf, buf_id, can_is_canfd_skb(skb));
> +	if (ret) {
> +		netdev_err(ndev, "Failed to insert frame into TX buffer: %d\n", ret);
> +		dev_kfree_skb_any(skb);
> +		ndev->stats.tx_dropped++;
> +		return NETDEV_TX_OK;
> +	}
> +
> +	can_put_echo_skb(skb, ndev, buf_id, 0);
> +
> +	if (!(cf->can_id & CAN_RTR_FLAG))
> +		stats->tx_bytes += cf->len;
> +
> +	ret = loongson_canfd_set_txbuf_cmd(ndev, TXT_CMD_ADD, buf_id);
> +	if (ret) {
> +		netdev_err(ndev, "Failed to start TX buffer %d: %d\n",
> +			   buf_id, ret);
> +		can_free_echo_skb(ndev, buf_id, NULL);
> +		ndev->stats.tx_dropped++;
> +		return NETDEV_TX_OK;
> +	}
> +
> +	if (!loongson_canfd_txbuf_freed(priv))
> +		netif_stop_queue(ndev);
> +
> +	return NETDEV_TX_OK;
> +}
> +
> +/**
> + * loongson_canfd_open() - Open the network device
> + * @ndev: Network device
> + *
> + * Return: 0 on success, negative error on failure.
> + */
> +static int loongson_canfd_open(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +	int ret;
> +
> +	loongson_canfd_reset(ndev);
> +
> +	ret = open_candev(ndev);
> +	if (ret) {
> +		netdev_warn(ndev, "open_candev failed\n");
> +		return ret;
> +	}
> +
> +	napi_enable(&priv->napi);
> +	ret = request_irq(ndev->irq, loongson_canfd_interrupt,
> +			  IRQF_SHARED, ndev->name, ndev);
> +	if (ret < 0) {
> +		netdev_err(ndev, "IRQ request failed\n");
> +		goto exit_napi_disable;
> +	}
> +
> +	ret = loongson_canfd_chip_start(ndev);
> +	if (ret < 0) {
> +		netdev_err(ndev, "Chip start failed\n");
> +		goto exit_free_irq;
> +	}
> +
> +	netdev_info(ndev, "Loongson CANFD device registered\n");
> +	netif_start_queue(ndev);
> +
> +	return 0;
> +
> +exit_free_irq:
> +	free_irq(ndev->irq, ndev);
> +exit_napi_disable:
> +	napi_disable(&priv->napi);
> +	close_candev(ndev);
> +	return ret;
> +}
> +
> +/**
> + * loongson_canfd_close() - Close the network device
> + * @ndev: Network device
> + *
> + * Cancels a pending bus-off restart before tearing down IRQ/DMA, since
> + * loongson_canfd_do_set_mode() re-arms both.
> + *
> + * Return: 0 always.
> + */
> +static int loongson_canfd_close(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +
> +	netif_stop_queue(ndev);
> +	napi_disable(&priv->napi);
> +
> +	/*
> +	 * Cancel a pending bus-off restart before tearing down IRQ/DMA:
> +	 * do_set_mode() re-arms both, so a restart firing after
> +	 * free_irq() would touch released resources. close_candev()
> +	 * does the same but only after free_irq().
> +	 */
> +	cancel_delayed_work_sync(&priv->can.restart_work);
> +
> +	loongson_canfd_chip_stop(ndev);
> +	free_irq(ndev->irq, ndev);
> +	close_candev(ndev);
> +
> +	return 0;
> +}
> +
> +static const struct net_device_ops loongson_canfd_netdev_ops = {
> +	.ndo_open           = loongson_canfd_open,
> +	.ndo_stop           = loongson_canfd_close,
> +	.ndo_start_xmit     = loongson_canfd_start_xmit,
> +	.ndo_hwtstamp_get   = can_hwtstamp_get,
> +	.ndo_hwtstamp_set   = can_hwtstamp_set,
> +};
> +
> +/**
> + * loongson_canfd_get_ts_info() - Report timestamping capabilities
> + * @ndev: Network device
> + * @info: ethtool timestamping info to fill
> + *
> + * Hardware timestamping is advertised only while @hwts.ready is set,
> + * so the reported capabilities match the driver's actual state.
> + *
> + * Return: 0 always.
> + */
> +static int loongson_canfd_get_ts_info(struct net_device *ndev,
> +				      struct kernel_ethtool_ts_info *info)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +
> +	info->so_timestamping = SOF_TIMESTAMPING_SOFTWARE |
> +				SOF_TIMESTAMPING_TX_SOFTWARE |
> +				SOF_TIMESTAMPING_RX_SOFTWARE;
> +
> +	info->phc_index = -1;
> +
> +	if (READ_ONCE(priv->hwts.ready)) {
> +		info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
> +					 SOF_TIMESTAMPING_RX_HARDWARE |
> +					 SOF_TIMESTAMPING_RAW_HARDWARE;
> +		info->tx_types = BIT(HWTSTAMP_TX_ON);
> +		info->rx_filters = BIT(HWTSTAMP_FILTER_ALL);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct ethtool_ops loongson_canfd_ethtool_ops = {
> +	.get_ts_info = loongson_canfd_get_ts_info,
> +};
> +
> +static const struct regmap_range loongson_canfd_reg_table_wr_range[] = {
> +	regmap_reg_range(LOONGSON_CANFD_DEVICE_ID, LOONGSON_CANFD_CONF),
> +	regmap_reg_range(LOONGSON_CANFD_CMD, LOONGSON_CANFD_CMD),
> +	regmap_reg_range(LOONGSON_CANFD_INT_STAT, LOONGSON_CANFD_ERL),
> +	regmap_reg_range(LOONGSON_CANFD_CTR_PRES, LOONGSON_CANFD_CTR_PRES),
> +	regmap_reg_range(LOONGSON_CANFD_SSP_CFG, LOONGSON_CANFD_SSP_CFG),
> +	regmap_reg_range(LOONGSON_CANFD_TS, LOONGSON_CANFD_FLT_CTRL),
> +	regmap_reg_range(LOONGSON_CANFD_TX_CMD, LOONGSON_CANFD_TX_DATA_18),
> +};
> +
> +static const struct regmap_range loongson_canfd_reg_table_rd_range[] = {
> +	regmap_reg_range(LOONGSON_CANFD_DEVICE_ID, LOONGSON_CANFD_STAT),
> +	regmap_reg_range(LOONGSON_CANFD_INT_STAT, LOONGSON_CANFD_BRE),
> +	regmap_reg_range(LOONGSON_CANFD_ERR_CAPT, LOONGSON_CANFD_TX_STAT),
> +	regmap_reg_range(LOONGSON_CANFD_TX_SEL, LOONGSON_CANFD_TX_DATA_18),
> +};
> +
> +static const struct regmap_access_table loongson_canfd_reg_table_wr = {
> +	.yes_ranges = loongson_canfd_reg_table_wr_range,
> +	.n_yes_ranges = ARRAY_SIZE(loongson_canfd_reg_table_wr_range),
> +};
> +
> +static const struct regmap_access_table loongson_canfd_reg_table_rd = {
> +	.yes_ranges = loongson_canfd_reg_table_rd_range,
> +	.n_yes_ranges = ARRAY_SIZE(loongson_canfd_reg_table_rd_range),
> +};
> +
> +static bool loongson_canfd_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case LOONGSON_CANFD_MODE:
> +	case LOONGSON_CANFD_CONF:
> +	case LOONGSON_CANFD_STAT:
> +	case LOONGSON_CANFD_CMD:
> +	case LOONGSON_CANFD_INT_STAT:
> +	case LOONGSON_CANFD_INT_ENA:
> +	case LOONGSON_CANFD_INT_MASK:
> +	case LOONGSON_CANFD_ERL:
> +	case LOONGSON_CANFD_FSTAT:
> +	case LOONGSON_CANFD_ERC:
> +	case LOONGSON_CANFD_ERR_CAPT:
> +	case LOONGSON_CANFD_ALC:
> +	case LOONGSON_CANFD_TRV_DLY:
> +	case LOONGSON_CANFD_TX_FR_CNT:
> +	case LOONGSON_CANFD_TS:
> +	case LOONGSON_CANFD_RX_STAT:
> +	case LOONGSON_CANFD_RX_DATA:
> +	case LOONGSON_CANFD_TX_STAT:
> +	case LOONGSON_CANFD_TX_CMD:
> +	case LOONGSON_CANFD_TX_SEL:
> +		return true;
> +	default:
> +		return false;
> +	};
> +}
> +
> +static const struct regmap_config loongson_canfd_regmap = {
> +	.reg_bits	= 32,
> +	.reg_stride	= 4,
> +	.val_bits	= 32,
> +	.wr_table	= &loongson_canfd_reg_table_wr,
> +	.rd_table	= &loongson_canfd_reg_table_rd,
> +	.volatile_reg	= loongson_canfd_volatile_reg,
> +	.max_register	= LOONGSON_CANFD_TX_DATA_18,
> +	.cache_type	= REGCACHE_MAPLE,
> +};
> +
> +/**
> + * loongson_canfd_setup_can_priv() - Fill in can_priv static configuration
> + * @ndev: Network device
> + * @clk_rate: Controller input clock, in Hz
> + *
> + * The whole can_priv configuration is data-only; keeping it out of
> + * probe() makes the resource-acquisition flow easier to follow.
> + */
> +static void loongson_canfd_setup_can_priv(struct net_device *ndev, u32 clk_rate)
> +{
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +
> +	priv->can.clock.freq = clk_rate;
> +	priv->can.bittiming_const = &loongson_canfd_bit_timing;
> +	priv->can.fd.data_bittiming_const = &loongson_canfd_bit_timing_data;
> +	priv->can.fd.tdc_const = &loongson_canfd_tdc_data;
> +
> +	priv->can.fd.do_set_data_bittiming = loongson_canfd_set_data_bittiming;
> +	priv->can.fd.do_get_auto_tdcv = loongson_canfd_get_auto_tdcv;
> +	priv->can.do_set_mode = loongson_canfd_do_set_mode;
> +	priv->can.do_set_bittiming = loongson_canfd_set_bittiming;
> +	priv->can.do_get_berr_counter = loongson_canfd_get_berr_counter;
> +
> +	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
> +				       CAN_CTRLMODE_LISTENONLY |
> +				       CAN_CTRLMODE_ONE_SHOT |
> +				       CAN_CTRLMODE_BERR_REPORTING |
> +				       CAN_CTRLMODE_FD |
> +				       CAN_CTRLMODE_PRESUME_ACK |
> +				       CAN_CTRLMODE_FD_NON_ISO |
> +				       CAN_CTRLMODE_TDC_AUTO |
> +				       CAN_CTRLMODE_CC_LEN8_DLC;
> +}
> +
> +static int loongson_canfd_probe(struct platform_device *pdev)
> +{
> +	struct loongson_canfd_priv *priv;
> +	struct device *dev = &pdev->dev;
> +	struct resource *mem_res;
> +	struct net_device *ndev;
> +	struct regmap *regmap;
> +	void __iomem *base;
> +	int ret, irq;
> +	u32 clk_rate;
> +
> +	base = devm_platform_get_and_ioremap_resource(pdev, 0, &mem_res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	regmap = devm_regmap_init_mmio(dev, base, &loongson_canfd_regmap);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	ret = device_property_read_u32(dev, "clock-frequency", &clk_rate);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Missing clock-frequency property");
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq, "Failed to get IRQ");
> +
> +	ndev = alloc_candev(sizeof(*priv), LOONGSON_CANFD_TXBUF_NUM);
> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	priv = netdev_priv(ndev);
> +	spin_lock_init(&priv->tx_lock);
> +	spin_lock_init(&priv->stats_lock);
> +	spin_lock_init(&priv->hwts.lock);
> +	priv->regmap = regmap;
> +	priv->mem_res = mem_res;
> +
> +	loongson_canfd_setup_can_priv(ndev, clk_rate);
> +
> +	ndev->irq = irq;
> +	ndev->flags |= IFF_ECHO;
> +	platform_set_drvdata(pdev, ndev);
> +	ndev->netdev_ops = &loongson_canfd_netdev_ops;
> +	ndev->ethtool_ops = &loongson_canfd_ethtool_ops;
> +	SET_NETDEV_DEV(ndev, dev);
> +
> +	netif_napi_add(ndev, &priv->napi, loongson_canfd_rx_napi);
> +
> +	ret = register_candev(ndev);
> +	if (ret) {
> +		dev_err(dev, "register_candev failed with %d", ret);
> +		goto err_candev_free;
> +	}
> +
> +	return 0;
> +
> +err_candev_free:
> +	netif_napi_del(&priv->napi);
> +	free_candev(ndev);
> +	return ret;
> +}
> +
> +/**
> + * loongson_canfd_remove() - Remove the device
> + * @pdev: Platform device
> + */
> +static void loongson_canfd_remove(struct platform_device *pdev)
> +{
> +	struct net_device *ndev = platform_get_drvdata(pdev);
> +	struct loongson_canfd_priv *priv = netdev_priv(ndev);
> +
> +	unregister_candev(ndev);
> +	netif_napi_del(&priv->napi);
> +	free_candev(ndev);
> +}
> +
> +static const struct acpi_device_id loongson_canfd_acpi_match[] = {
> +	{ .id = "LOON0015" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, loongson_canfd_acpi_match);
> +
> +static struct platform_driver loongson_canfd_driver = {
> +	.probe  = loongson_canfd_probe,
> +	.remove = loongson_canfd_remove,
> +	.driver = {
> +		.name = DEV_NAME,
> +		.acpi_match_table = loongson_canfd_acpi_match,
> +	},
> +};
> +module_platform_driver(loongson_canfd_driver);
> +
> +MODULE_AUTHOR("Loongson Technology Corporation Limited");
> +MODULE_DESCRIPTION("Loongson CAN-FD Controller driver");
> +MODULE_LICENSE("GPL");

[Severity: Medium]
The regmap uses REGCACHE_MAPLE, but every register the driver reads
back is listed in loongson_canfd_volatile_reg(), and the cache is
never synced or invalidated. What does the cache provide here?

As configured, it has side effects. The TX buffer window
LOONGSON_CANFD_TX_DATA_1..LOONGSON_CANFD_TX_DATA_18 is writable and
readable but not volatile. Each regmap_write() from
loongson_canfd_insert_frame() therefore goes through
regcache_maple_write() before the MMIO write.

That code runs in loongson_canfd_start_xmit() under tx_lock. The
first write to each offset allocates maple nodes and an entry array
with GFP_ATOMIC, because the MMIO regmap is fast_io. If either
allocation fails, regmap_write() returns -ENOMEM without touching the
hardware, and the frame is dropped with a netdev_err() that is not
rate-limited.

The window is also banked through LOONGSON_CANFD_TX_SEL, so the cache
folds the eight hardware TX buffers into one set of cached values. The
driver never reads them back today. Any later read or
regmap_update_bits() on that range would return another buffer's data.

Several readable counter and status registers are not volatile either:
LOONGSON_CANFD_BRE, LOONGSON_CANFD_RETX_CNT, LOONGSON_CANFD_RX_FR_CNT,
LOONGSON_CANFD_DEBUG, LOONGSON_CANFD_RX_MEM_INFO and
LOONGSON_CANFD_RX_PRT. After the first read they are served from the
cache, so the regmap debugfs registers file shows frozen values.

LOONGSON_CANFD_RX_DATA is readable but has no precious_reg callback.
Reading the debugfs registers file therefore pops a word from the live
RX FIFO. That desynchronizes the header parsing in
loongson_canfd_rx_hdr_valid() for the frame being received.

Would REGCACHE_NONE be simpler here? If the cache is wanted, the TX
window and the counters should be volatile, and RX_DATA should be
marked precious.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794213427.git.zhoubinbin%40loongson.cn
