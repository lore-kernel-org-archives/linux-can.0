Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216714;
	b=c3eqF0Oz8hE2DGZ0nxi7SaGxvb8Qzf6OuH9d7QjZH6uNAd1Nuwva84gTqY4tagPWcBXC
	 XxVHU2kxqIG42uiBAYZ0DgrLn5f8hXTjdS+juOvBHqG6CCNxzGICCn+imBMqFKxbgCFbP
	 PcIXw45YbBuR3ly3pTFDGMJKtELaTt1Q7ezwCh7o8Lx3sDnxACDn7RCDYxegYqAr9+wCK
	 lP0ZICAgpWWgE1RQsP3nTu7Ee7QJtPwH6+BRplIXbcdx2GbORej/7jamjwTm4D1jsQg3C
	 ov88q3KvNHaOnWj2Csh3wIOL4sQ1acx9i5YqS6C4DAQbW6VpLeECkZBcg+9xLkFJTSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216714;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iEXbf3fM0mgIRaFsPJD6XpdB8OSxS3T29wU97rtf7KA=;
	b=KKkb7DVRimrfGObsLQJGIv7rdGdnkCMxWUopbdqC8fjT2ekUugkfFN9rY2RUMq16nIbz
	 4kivpY4MekbCD38E1ePbR40KFsXyxdA6ir4HpbHVrKKFUwtuwEuTeVCNIg8M4uyvWltlD
	 SqXv+YfvSyfEtT5mo+UalQr9iopCl6gKGr+ZUhgRReDskIenBsVx+JJh49mJsVpPsla8j
	 4Ph5A4RS7XT/jjuN8WFyoMFiBXKpWkI09QX6rLojLZmjbcEWAnK/0Ke2tvw+hzsVSiy6j
	 Dxags/Yp4+fQ/v6xgefDj7QgTw+7LYG2R+xThMMuwTJPsjI9Yd512ZSvnMN0cs3Otkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qa2buI1E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62448606A339
	for <linux-can@vger.kernel.org>; Mon,  9 Nov 2026 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qa2buI1E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3671F0089F;
	Mon,  9 Nov 2026 09:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216714;
	bh=iEXbf3fM0mgIRaFsPJD6XpdB8OSxS3T29wU97rtf7KA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qa2buI1ElsqFshszeRDxgFj0O6jQci4bsvyfBi9LG2h4+vfRo0rrpbNRDUeoN52AX
	 mOPX3hRhUVNMJ7rFmmS6IzsQ0/WZLOmAYUv1fXEvym5Q4TfVzT15pZ+RXvVe+ehida
	 KPcQ/MFmmoHXR/0k1IMAex/G+oHHPHJVIZ7jxZdFBQfCbJbIhpV/CfIjs9k/C3v+If
	 CMA+33TgEIj6U024yc+9JtVR8556Kc/bGfwcdIKwA34NGvNfHt6qRekE+F0P/h+R9A
	 K+4qC4ewUrJaNDcFYIgohclF4rgg/oeGO+ptNes/uTCGlk/4UZ+F4csVF+P3lQf31P
	 5el7GwRUBxphg==
Message-ID: <sashiko-outbox-204707@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/2] can: Add Loongson CAN-FD controller driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Zhou" <zhoubinbin@loongson.cn>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <a8291518fe60279a18c15393daf3ed3660bcfa5c.1794213427.git.zhoubinbin@loongson.cn>
References: <cover.1794213427.git.zhoubinbin@loongson.cn>
 <a8291518fe60279a18c15393daf3ed3660bcfa5c.1794213427.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 09:31:53 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 16 potential
issues to consider:
- [High] can: loongson_canfd: use-after-free in
  loongson_canfd_start_xmit() after echo
- [Medium] can: loongson_canfd: use of can_dropped_invalid_skb() in
  start_xmit()
- [Medium] can: loongson_canfd: CANFD_FDF cleared in
  loongson_canfd_rx_deliver()
- [Medium] can: loongson_canfd: incomplete free check in
  loongson_canfd_txbuf_freed()
- [Medium] can: loongson_canfd: TOCTOU race waking TX queue outside
  priv->tx_lock
- [Medium] can: loongson_canfd: broken error frame flags and stats in
  state/overrun paths
- [Medium] can: loongson_canfd: missing TX queue and chip stop on
  CAN_STATE_BUS_OFF
- [Medium] can: loongson_canfd: bogus error skb stats and race on
  ndev->stats
- [Medium] can: loongson_canfd: race enabling IRQs before state init in
  loongson_canfd_chip_start()
- [Medium] can: loongson_canfd: teardown race with IRQ and restart_work
  in loongson_canfd_close()
- [Medium] can: loongson_canfd: hwts capabilities hidden when down in
  loongson_canfd_get_ts_info()
- [Medium] can: loongson_canfd: broken REGCACHE_MAPLE config on banked
  TX and FIFO registers
- [Medium] can: loongson_canfd: prop_seg > 127 truncated in
  loongson_canfd_set_btr()
- [Medium] can: loongson_canfd: RX FIFO desync and tautological check in
  rx_hdr_valid()
- [Medium] can: loongson_canfd: missing mode checks in
  loongson_canfd_start_xmit()
- [Low] can: loongson_canfd: tautological SFF ID check in
  loongson_canfd_hdr_plausible()
--

commit 081a5a8aea730be1bb8b197fafbcd027960619e3
Author: Binbin Zhou <zhoubinbin@loongson.cn>

can: Add Loongson CAN-FD controller driver

This commit adds a driver for the CAN-FD controller integrated in the
Loongson-2K series SoCs, supporting CAN 2.0B, CAN FD, NAPI RX, TX echo,
error reporting, and hardware timestamps.

> diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_=
canfd.c
> new file mode 100644
> index 0000000000000..7a4d8df7815ac
> --- /dev/null
> +++ b/drivers/net/can/loongson_canfd.c

[ ... ]

> +static void loongson_canfd_set_btr(struct net_device *ndev,
> +				   struct can_bittiming *bt, bool nominal)
> +{
> +	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +	u32 prop =3D bt->prop_seg, phase1 =3D bt->phase_seg1;
> +	u32 ph1_max =3D FIELD_MAX(REG_BTR_PH1);
> +	u32 btr =3D 0;
> +
> +	/* PROP is 7 bits but PH1 only 6; move the excess into PROP */
> +	if (phase1 > ph1_max) {
> +		prop +=3D phase1 - ph1_max;
> +		phase1 =3D ph1_max;
> +	}
> +
> +	if (nominal) {
> +		btr =3D FIELD_PREP(REG_BTR_PROP, prop) |

[Severity: Medium]
Can FIELD_PREP(REG_BTR_PROP, prop) and FIELD_PREP(REG_BTR_FD_PROP, prop)
truncate prop when manual bit-timing parameters specify prop_seg > 127?

loongson_canfd_bit_timing and loongson_canfd_bit_timing_data advertise
tseg1_max =3D 190, and can_fixup_bittiming() only enforces
prop_seg + phase_seg1 <=3D tseg1_max.  If userspace sets prop_seg in
128..189, the excess above FIELD_MAX(REG_BTR_PROP) (127) is not moved
into phase1 and is masked off by FIELD_PREP(), programming the wrong bit
rate and sample point.

[ ... ]

> +static int loongson_canfd_chip_start(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +	u32 int_ena, int_msk;
> +	int ret;
> +
> +	ret =3D loongson_canfd_set_bittiming(ndev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Programs BTR_FD and SSP_CFG together */
> +	ret =3D loongson_canfd_set_data_bittiming(ndev);
> +	if (ret < 0)
> +		return ret;
> +
> +	loongson_canfd_apply_ctrlmode(priv);
> +
> +	int_ena =3D REG_INT_STAT_RBNEI | REG_INT_STAT_TXBHCI |
> +		  REG_INT_STAT_EWLI  | REG_INT_STAT_FCSI   |
> +		  REG_INT_STAT_DOI;
> +
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> +		int_ena |=3D REG_INT_STAT_ALI | REG_INT_STAT_BEI;
> +
> +	int_msk =3D REG_INT_MASK_SET & ~int_ena;
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
> +	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +
> +	regmap_update_bits(priv->regmap, LOONGSON_CANFD_CONF, REG_CONF_ENA,
> +			   REG_CONF_ENA);
> +
> +	return 0;
> +}

[Severity: Medium]
Can enabling LOONGSON_CANFD_INT_ENA before setting priv->can.state =3D
CAN_STATE_ERROR_ACTIVE trigger a spurious state change report?

CPU0                              <hardirq>
loongson_canfd_chip_start()
  regmap_write(..., INT_MASK, int_msk)
  regmap_write(..., INT_ENA, int_ena)
                                  loongson_canfd_interrupt()
                                    loongson_canfd_err_interrupt()
                                      priv->can.state !=3D state
                                      loongson_canfd_report_state_change()
  loongson_canfd_hwts_setup()
  priv->can.state =3D CAN_STATE_ERROR_ACTIVE;

loongson_canfd_reset() latches REG_INT_STAT_FCSI on reset to Error Active,
and loongson_canfd_err_interrupt() relies on priv->can.state =3D=3D
CAN_STATE_ERROR_ACTIVE to ignore that initial interrupt.  Because the IRQ
is already registered in loongson_canfd_open() and
loongson_canfd_do_set_mode(), FCSI can fire while priv->can.state is still
CAN_STATE_STOPPED or CAN_STATE_BUS_OFF and before hwts is initialized.

[ ... ]

> +static bool loongson_canfd_txbuf_freed(struct loongson_canfd_priv *priv)
> +{
> +	return !regmap_test_bits(priv->regmap, LOONGSON_CANFD_TX_STAT, REG_TX_S=
TAT_BRP);
> +}

[Severity: Medium]
Does loongson_canfd_txbuf_freed() return true even when no TX buffer is
writable?

loongson_canfd_find_free_txbuf() requires a slot's BRP bit to be clear,
its 2-bit BS field to be TX_BS_IDLE, and priv->can.echo_skb[i] to be NULL.
When a frame finishes on the wire, hardware clears its BRP bit and sets BS
to TX_BS_VALID or TX_BS_FAIL until loongson_canfd_tx_interrupt() runs
TXT_CMD_SR_CLEAN.  Checking only REG_TX_STAT_BRP leaves the queue awake in
loongson_canfd_start_xmit() when the last writable slot is used while
another slot awaits ISR cleanup, causing the next start_xmit() call to
return NETDEV_TX_BUSY.

[ ... ]

> +	for (unsigned int i =3D 0; i < cf->len; i +=3D LOONGSON_CANFD_DW_BYTE) {
> +		unsigned int remain =3D cf->len - i;
> +		u32 word;
> +
> +		if (remain >=3D LOONGSON_CANFD_DW_BYTE) {
> +			word =3D get_unaligned_le32(cf->data + i);

[Severity: Medium]
Can an ETH_P_CANXL skb cause loongson_canfd_insert_frame() to read past
skb->data and write past LOONGSON_CANFD_TX_DATA_18?

loongson_canfd_start_xmit() validates frames with
can_dropped_invalid_skb() instead of can_dev_dropped_skb().  That skips
the CAN_CTRLMODE_LISTENONLY and CAN_CTRLMODE_FD checks, allowing frames
from non-RAW sockets (such as can-bcm or can-isotp) to fill the hardware
TX buffers while in listen-only mode.  In addition, if an ETH_P_CANXL skb
is sent via AF_PACKET, cf->len aliases canxl_frame::flags (which has
CANXL_XLF =3D 0x80 set), so this loop reads out-of-bounds past small CAN XL
skbs and writes registers past LOONGSON_CANFD_TX_DATA_18.

[ ... ]

> +static bool loongson_canfd_hdr_plausible(u32 hdr0, u32 hdr1)
> +{
> +	u32 rwcnt  =3D FIELD_GET(REG_FRAME_META1_RWCNT, hdr1);
> +	u32 dlc    =3D FIELD_GET(REG_FRAME_META1_DLC,   hdr1);
> +	bool isfd  =3D !!(hdr1 & REG_FRAME_META1_FDF);
> +	bool isrtr =3D !!(hdr0 & REG_FRAME_META0_RTR);
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
> +		return false;

[Severity: Low]
Can FIELD_GET(REG_FRAME_META0_ID_BASE, hdr0) ever exceed CAN_SFF_MASK?
REG_FRAME_META0_ID_BASE is GENMASK(28, 18), an 11-bit field whose maximum
value is already CAN_SFF_MASK (0x7ff), whereas REG_FRAME_META0_ID_EXT
(GENMASK(17, 0)) is not checked when REG_FRAME_META0_XDT is clear.

[ ... ]

> +static void loongson_canfd_rx_note_bad(struct net_device *ndev, u32 rwcn=
t)
> +{
> +	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +	u32 words, data;
> +
> +	ndev->stats.rx_dropped++;
> +
> +	words =3D rwcnt > 2 ?
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
> +	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +
> +	d->hdr0 =3D loongson_canfd_read_rx_word_fifo(priv);
> +	d->hdr1 =3D loongson_canfd_read_rx_word_fifo(priv);
> +
> +	d->rwcnt =3D FIELD_GET(REG_FRAME_META1_RWCNT, d->hdr1);
> +	if (d->rwcnt < 2) {
> +		/* Hand the caller a worst-case drain length */
> +		d->rwcnt =3D 2 + CANFD_MAX_DLEN / LOONGSON_CANFD_DW_BYTE;
> +		return false;
> +	}

[Severity: Medium]
Does setting d->rwcnt to 18 when d->rwcnt < 2 desynchronize the 80-byte
hardware RX FIFO?

When d->rwcnt < 2, loongson_canfd_rx_note_bad() unconditionally reads 16
words from LOONGSON_CANFD_RX_DATA without checking
loongson_canfd_rx_is_empty_fifo(), which consumes following valid frames in
the FIFO and leaves the next read mid-frame.  Also, the standard-ID check
in loongson_canfd_hdr_plausible() compares the 11-bit
REG_FRAME_META0_ID_BASE field against 0x7ff instead of checking whether
REG_FRAME_META0_ID_EXT is non-zero.

[ ... ]

> +	cfd->flags =3D 0;
> +
> +	if (d->is_can_fd) {
> +		if (d->hdr1 & REG_FRAME_META1_BRS)
> +			cfd->flags |=3D CANFD_BRS;
> +		if (d->hdr0 & REG_FRAME_META0_ESI)
> +			cfd->flags |=3D CANFD_ESI;
> +	} else if (d->is_rtr) {
> +		cfd->can_id |=3D CAN_RTR_FLAG;
> +	}

[Severity: Medium]
Does setting cfd->flags =3D 0 clear the mandatory CANFD_FDF flag that
alloc_canfd_skb() initialized on received CAN FD frames?

[ ... ]

> +	skb =3D alloc_can_err_skb(ndev, &cf);
> +	if (skb) {
> +		cf->can_id |=3D CAN_ERR_CRTL;
> +		cf->data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
> +
> +		scoped_guard(spinlock_irqsave, &priv->stats_lock) {
> +			stats->rx_packets++;
> +			stats->rx_bytes +=3D cf->len;
> +		}
> +
> +		/* Hard IRQ: use netif_rx(), not netif_receive_skb() */
> +		netif_rx(skb);
> +	}

[Severity: Medium]
As reported by Vincent Mailhol on v2 [1], should synthetic SocketCAN error
frames be excluded from stats->rx_packets and stats->rx_bytes here?  Also,
updating stats->rx_packets and stats->rx_bytes under priv->stats_lock in
hardirq context races with the unlocked updates to the same counters in
loongson_canfd_rx_deliver() during NAPI polling.

[ ... ]

> +	/* Stats and BUS_OFF handling must not depend on skb allocation */
> +	switch (new_state) {
> +	case CAN_STATE_BUS_OFF:
> +		priv->can.can_stats.bus_off++;
> +		can_bus_off(ndev);
> +		break;

[Severity: Medium]
Does entering CAN_STATE_BUS_OFF without stopping the TX queue and
controller allow loongson_canfd_start_xmit() and
loongson_canfd_tx_interrupt() to race with bus-off recovery?

CPU0                              CPU1
can_restart_work()
  can_restart()
    can_flush_echo_skb()
      kfree_skb(priv->echo_skb[i])
                                  loongson_canfd_tx_interrupt()
                                    can_free_echo_skb()  <-- double free
    netif_carrier_on()
    loongson_canfd_do_set_mode()
      loongson_canfd_reset()
                                  loongson_canfd_start_xmit()

can_bus_off() only calls netif_carrier_off(), which defers qdisc
deactivation to linkwatch_work, and can_restart() flushes echo_skb[]
without holding priv->tx_lock before calling netif_carrier_on() and
do_set_mode(CAN_MODE_START).

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
> +	skb =3D alloc_can_err_skb(ndev, &cf);
> +	if (!skb)
> +		return;
> +
> +	switch (new_state) {
> +	case CAN_STATE_BUS_OFF:
> +		cf->can_id |=3D CAN_ERR_BUSOFF;
> +		goto send;
> +	case CAN_STATE_ERROR_ACTIVE:
> +		cf->can_id |=3D CAN_ERR_CNT;
> +		cf->data[1] =3D CAN_ERR_CRTL_ACTIVE;
> +		break;

[Severity: Medium]
Should CAN_STATE_ERROR_ACTIVE also set CAN_ERR_CRTL in cf->can_id when
reporting CAN_ERR_CRTL_ACTIVE in cf->data[1], and should error_passive and
error_warning only be incremented when transitioning to a worse state?

Overwriting priv->can.state before checking the transition direction
counts recoveries (such as CAN_STATE_ERROR_PASSIVE down to
CAN_STATE_ERROR_WARNING) as new error events.  In addition,
loongson_canfd_rx_overrun_event() adds cf->len of an error skb to
stats->rx_bytes under priv->stats_lock while loongson_canfd_rx_deliver()
updates rx_packets and rx_bytes without priv->stats_lock.

[ ... ]

> +			case TX_BS_VALID:
> +				u32 dummy_len;
> +
> +				/*
> +				 * The controller does not latch a per-frame
> +				 * TX stamp, so the instant the handler reads
> +				 * the counter is the best estimate of the
> +				 * end of the frame.
> +				 */
> +				skb =3D priv->can.echo_skb[buf_id];
> +				if (skb &&
> +				    (skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS) &&
> +				    READ_ONCE(priv->hwts.ready))
> +					skb_hwtstamps(skb)->hwtstamp =3D
> +							loongson_canfd_hwts_now(priv);
> +
> +				dummy_len =3D can_get_echo_skb(ndev, buf_id, NULL);
> +				(void)dummy_len;
> +				stats->tx_packets++;
> +				break;

[ ... ]

> +		if (!processed)
> +			netdev_warn_once(ndev, "Spurious TX interrupt\n");
> +
> +		wake =3D loongson_canfd_txbuf_freed(priv);
> +	}
> +
> +	if (wake)
> +		netif_wake_queue(ndev);
> +}

[Severity: Medium]
Can calling netif_wake_queue() after dropping priv->tx_lock re-wake the TX
queue after loongson_canfd_start_xmit() has just filled the last buffer
and stopped it?

CPU0                              CPU1
loongson_canfd_tx_interrupt()
  lock(&priv->tx_lock)
  wake =3D loongson_canfd_txbuf_freed()
  unlock(&priv->tx_lock)
                                  loongson_canfd_start_xmit()
                                    lock(&priv->tx_lock)
                                    /* consumes last free TX buffer */
                                    netif_stop_queue(ndev)
                                    unlock(&priv->tx_lock)
  netif_wake_queue(ndev)  <-- wakes full queue

[ ... ]

> +static netdev_tx_t loongson_canfd_start_xmit(struct sk_buff *skb, struct=
 net_device *ndev)
> +{
> +	struct canfd_frame *cf =3D (struct canfd_frame *)skb->data;
> +	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +	struct net_device_stats *stats =3D &ndev->stats;
> +	int buf_id, ret;
> +
> +	if (can_dropped_invalid_skb(ndev, skb))
> +		return NETDEV_TX_OK;

[Severity: Medium]
Should loongson_canfd_start_xmit() call can_dev_dropped_skb() instead of
can_dropped_invalid_skb()?

can_dropped_invalid_skb() is for virtual CAN drivers and does not check
CAN_CTRLMODE_LISTENONLY or CAN_CTRLMODE_FD, allowing frames sent via
non-RAW sockets in listen-only mode or CAN FD/XL frames sent via AF_PACKET
to reach loongson_canfd_insert_frame().

[ ... ]

> +	can_put_echo_skb(skb, ndev, buf_id, 0);
> +
> +	if (!(cf->can_id & CAN_RTR_FLAG))
> +		stats->tx_bytes +=3D cf->len;

[Severity: High]
Does reading cf->can_id and cf->len after can_put_echo_skb() cause a
use-after-free of skb?

can_put_echo_skb() consumes or frees skb (for example via kfree_skb() when
IFF_ECHO is cleared or when skb_clone() fails in can_create_echo_skb()),
and cf points into skb->data.  Also, incrementing stats->tx_bytes here
instead of adding the length returned by can_get_echo_skb() in
loongson_canfd_tx_interrupt() counts bytes for frames that later fail, are
cancelled, or are flushed.

[ ... ]

> +static int loongson_canfd_close(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +
> +	netif_stop_queue(ndev);
> +	napi_disable(&priv->napi);
> +
> +	/*
> +	 * Cancel a pending bus-off restart before tearing down IRQ/DMA:
> +	 * do_set_mode() re-arms both, so a restart firing after
> +	 * free_irq() would touch released resources. close_candev()\
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

[Severity: Medium]
Can an interrupt firing before loongson_canfd_chip_stop() and free_irq()
re-schedule restart_work or schedule NAPI after napi_disable()?

CPU0                              <hardirq>
loongson_canfd_close()
  napi_disable(&priv->napi)
  cancel_delayed_work_sync(&restart_work)
                                  loongson_canfd_interrupt()
                                    loongson_canfd_err_interrupt()
                                      can_bus_off()
                                        schedule_delayed_work(&restart_work)
  loongson_canfd_chip_stop()
                                  can_restart_work()
                                    loongson_canfd_do_set_mode(CAN_MODE_STA=
RT)
                                      loongson_canfd_chip_start()  <-- rest=
arts stopped chip
  free_irq()

Stopping the chip and freeing the IRQ before cancelling restart_work and
disabling NAPI avoids the ISR re-arming either during teardown.

[ ... ]

> +static int loongson_canfd_get_ts_info(struct net_device *ndev,
> +				      struct kernel_ethtool_ts_info *info)
> +{
> +	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +
> +	info->so_timestamping =3D SOF_TIMESTAMPING_SOFTWARE |
> +				SOF_TIMESTAMPING_TX_SOFTWARE |
> +				SOF_TIMESTAMPING_RX_SOFTWARE;
> +
> +	info->phc_index =3D -1;
> +
> +	if (READ_ONCE(priv->hwts.ready)) {
> +		info->so_timestamping |=3D SOF_TIMESTAMPING_TX_HARDWARE |
> +					 SOF_TIMESTAMPING_RX_HARDWARE |
> +					 SOF_TIMESTAMPING_RAW_HARDWARE;
> +		info->tx_types =3D BIT(HWTSTAMP_TX_ON);
> +		info->rx_filters =3D BIT(HWTSTAMP_FILTER_ALL);
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Does checking priv->hwts.ready in loongson_canfd_get_ts_info() hide the
device's hardware timestamping capabilities whenever the interface is down?

priv->hwts.ready is only true between loongson_canfd_chip_start() and
loongson_canfd_chip_stop(), so querying ethtool timestamping info while the
interface is down omits the hardware timestamping flags and filters even
though can_hwtstamp_get() and can_hwtstamp_set() are unconditionally wired
up (see can_ethtool_op_get_ts_info_hwts()).

[ ... ]

> +static bool loongson_canfd_volatile_reg(struct device *dev, unsigned int=
 reg)
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
> +static const struct regmap_config loongson_canfd_regmap =3D {
> +	.reg_bits	=3D 32,
> +	.reg_stride	=3D 4,
> +	.val_bits	=3D 32,
> +	.wr_table	=3D &loongson_canfd_reg_table_wr,
> +	.rd_table	=3D &loongson_canfd_reg_table_rd,
> +	.volatile_reg	=3D loongson_canfd_volatile_reg,
> +	.max_register	=3D LOONGSON_CANFD_TX_DATA_18,
> +	.cache_type	=3D REGCACHE_MAPLE,
> +};

[Severity: Medium]
Why does loongson_canfd_regmap enable REGCACHE_MAPLE when the banked TX
data registers (LOONGSON_CANFD_TX_DATA_1..LOONGSON_CANFD_TX_DATA_18) are
not marked volatile?

Those offsets are a banked window into 8 TX buffers selected by
LOONGSON_CANFD_TX_SEL, and caching them with REGCACHE_MAPLE causes
regmap_write() in loongson_canfd_insert_frame() to perform GFP_ATOMIC
maple-tree allocations under priv->tx_lock (dropping the frame if an
allocation fails).  Also, LOONGSON_CANFD_RX_DATA has no precious_reg
callback, so reading regmap debugfs pops words from the live RX FIFO.

[1] https://lore.kernel.org/r/c9598f85-5b17-4d38-855e-c3840a01452f@kernel.o=
rg

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794213427.gi=
t.zhoubinbin@loongson.cn?part=3D1
