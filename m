Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217869;
	b=3xF55OMEDPnK2ONXC98f8uTqImgrToJ7IkZ4z+7iaaZAB59b7b4WmqOEC3FJ4iyjAI+V
	 olu7QzISlQArqTqhup5fPmW+3XXHwAzmtnlxqfwwLpYBV/dt82ShSJHV2Lh+tPeToOdc5
	 jsEaWvaXMbE9Y6cxtT5HnrtmwLTTPYZp+hGSNL9O7C4ID12WU4cHxnzoaadShFwHcKIqU
	 NL3QBCzWTGOA34pWqOZlW4t4xts+SS+rbeTlhNLB1ArCA2uBhXm86W9WIQRdaYz+Hy6OW
	 /PjoMm0T0tOUclVHphrBToGSwOsjPQ/qTlPbgIc08N6V1KL2/4Ba0oAQ0C6sAhwXArA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217869;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Pw1nEuRFk1bYZvjZQeybSvmyQM8F5AFGTEuuCjDWmuw=;
	b=zPjLoP9Aep6M7Q6rnk4h9MkPt8MAbgY/ZI/+YgrbtN2P7j+ODP9c6x6iU+TPW6vRQEF/
	 ZfuuKp4IHKo90nB7UF1YkL6VPPhiYPoDPp0060na17LxDmjnGlcpKbcSrNUCEcmuiVpSP
	 OMBqfQf7Ok3ypJK3U9rObAb2oz4OaNjIk6JfCdG1U4reo753AG97YN4j3CpqtJyPxBPWy
	 CAUUAtQNeV8B4uWkr0NYnSrOrppo76EmkJXXDe4TGOCmdclqtmSY21RMcdga2Zqqn1Jvi
	 gi88Xsopj5zTOT1hLFnZIbMyN4Ni7uKLwAPamlRkboZ+2LIIkkpkbGS4+BoUyx/QQsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b0QYV+FB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0039C606A31C
	for <linux-can@vger.kernel.org>; Mon,  9 Nov 2026 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b0QYV+FB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C881F008A1;
	Mon,  9 Nov 2026 09:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794217868;
	bh=Pw1nEuRFk1bYZvjZQeybSvmyQM8F5AFGTEuuCjDWmuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b0QYV+FBcoipisePHcjkh3ry6tj7frYjKHyzf4751RMWsHxMAWYiZ9Qk9Ui/C2vOQ
	 HqSTSnSWu0drfGLoQlVzrAUVA5rvhDt2oeb1Pj4WqfYHZIbSzqrx6jvDzFeKsuJLOC
	 UovseXd8Ln4fPCcJMSUzjZPVCP0VYny8cXtQyIW9dT1a0Xj2U7WQWdulWBJM3wcWqd
	 ybRNQ7/Z153YzVrmhaTiqAg/SnxpB0P8g38uQrwpOfcAM7Rg2mnm5aP3K9dpL5m5pp
	 Gcuk8GsVad2iu00QUeps8ywmrXeHxG/OyGhQY6K0USxu09iFzYpKOz4jQsOggVNkkX
	 GequdeOqxAQ9w==
Message-ID: <sashiko-outbox-204753@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/2] can: loongson_canfd: Add RXDMA support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Zhou" <zhoubinbin@loongson.cn>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <64b77b0ec6ba0c3f747d9ed73bd75e80502b2339.1794213427.git.zhoubinbin@loongson.cn>
References: <cover.1794213427.git.zhoubinbin@loongson.cn>
 <64b77b0ec6ba0c3f747d9ed73bd75e80502b2339.1794213427.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 09:51:08 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 11 potential
issues to consider:
- [High] can: loongson_canfd: broken empty check in
  loongson_canfd_rx_is_empty_dma()
- [High] can: loongson_canfd: full-ring discard in
  loongson_canfd_rx_is_empty_dma()
- [High] can: loongson_canfd: -ENOMEM ring desync in
  loongson_canfd_rx_one_frame_dma()
- [High] can: loongson_canfd: unchecked ERR_PTR in
  loongson_canfd_rxdma_start()
- [High] can: loongson_canfd: racy RX DMA restart in
  loongson_canfd_do_set_mode()
- [High] can: loongson_canfd: softirq loop in
  loongson_canfd_rx_one_frame_dma_overrun()
- [Medium] can: loongson_canfd: wrong check order in
  loongson_canfd_rx_napi_done()
- [Medium] can: loongson_canfd: race in
  loongson_canfd_rx_overrun_event() with hard IRQ
- [Low] can: loongson_canfd: inconsistent stats_lock usage on RX
  net_device_stats
- [Low] can: loongson_canfd: dead MMIO and DMA status reads in RX DMA
  recovery helpers
- [Low] can: loongson_canfd: stale RX DMA comment on
  loongson_canfd_tx_interrupt()
--

commit 163f344c5c06e5b35fc3c10b21a31b54fe6b6332
Author: Binbin Zhou <zhoubinbin@loongson.cn>

can: loongson_canfd: Add RXDMA support

This commit adds optional cyclic RX DMA support to the Loongson CAN-FD
driver, falling back to FIFO polling when no RX DMA channel is present.

> diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_=
canfd.c
> index 7a4d8df7815ac..b5a5917bc7738 100644
> --- a/drivers/net/can/loongson_canfd.c
> +++ b/drivers/net/can/loongson_canfd.c

[ ... ]

> @@ -504,6 +539,213 @@ static void loongson_canfd_disable_interrupts(struc=
t loongson_canfd_priv *priv)
> +static int loongson_canfd_rxdma_start(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +	struct dma_async_tx_descriptor *desc;
> +
> +	if (!priv->rx_ch)
> +		return 0;
> +
> +	priv->rx_rd_pos =3D 0;
> +	priv->rx_wr_pos =3D 0;
> +	priv->rx_wr_off =3D 0;
> +	priv->rx_bad_cnt =3D 0;
> +
> +	desc =3D dmaengine_prep_dma_cyclic(priv->rx_ch, priv->rx_dma_addr,
> +					 LOONGSON_CANFD_RXBUF_SZ,
> +					 LOONGSON_CANFD_RXDMA_PERIOD,
> +					 DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
> +	if (!desc) {
> +		netdev_err(ndev, "RX DMA cyclic prep failed\n");
> +		return -EBUSY;
> +	}
> +
> +	priv->rx_cookie =3D dmaengine_submit(desc);
> +	if (dma_submit_error(priv->rx_cookie)) {
> +		netdev_err(ndev, "RX DMA submit failed\n");
> +		return -EIO;
> +	}

[Severity: High]
Can dmaengine_submit(desc) dereference an error pointer here?

The paired loongson2-apb-cmc-dma driver returns an ERR_PTR() from
loongson2_cmc_dma_prep_dma_cyclic() on failure (for example,
ERR_PTR(-ENOMEM) when its GFP_NOWAIT allocation fails) rather than NULL:

drivers/dma/loongson/loongson2-apb-cmc-dma.c:loongson2_cmc_dma_prep_dma_cyc=
lic() {
    ...
	desc =3D kzalloc_flex(*desc, sg_req, num_periods, GFP_NOWAIT);
	if (!desc)
		return ERR_PTR(-ENOMEM);
    ...
}

Checking only !desc lets an error pointer reach dmaengine_submit(desc) and
crash the kernel.  Also, if dma_submit_error(priv->rx_cookie) is true,
returning -EIO without freeing desc leaks the prepared descriptor.

[ ... ]

> @@ -995,15 +1245,29 @@ static void loongson_canfd_chip_stop(struct net_de=
vice *ndev)
>  static int loongson_canfd_do_set_mode(struct net_device *ndev, enum can_=
mode mode)
>  {
> +	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
>  	int ret;
> =20
>  	switch (mode) {
>  	case CAN_MODE_START:
>  		loongson_canfd_reset(ndev);
> =20
> +		/*
> +		 * The FIFO starts from scratch; DMA and CPU read pointer
> +		 * must be realigned with the new FIFO start.
> +		 */
> +		loongson_canfd_rxdma_stop(priv);
> +
> +		ret =3D loongson_canfd_rxdma_start(ndev);

[Severity: High]
Does restarting RX DMA in loongson_canfd_do_set_mode() race with concurrent
NAPI polling?

When bus-off recovery runs, priv->napi is still enabled:

CPU0                              CPU1
loongson_canfd_rx_napi()
  loongson_canfd_rx_one_frame_dma()
    saved_rd_pos =3D priv->rx_rd_pos;
                                  loongson_canfd_do_set_mode()
                                    loongson_canfd_reset(ndev)
                                    loongson_canfd_rxdma_stop(priv)
                                    loongson_canfd_rxdma_start(ndev)
                                      priv->rx_rd_pos =3D 0;
                                      priv->rx_wr_pos =3D 0;
    priv->rx_rd_pos =3D saved_rd_pos;
    <-- corrupts reset ring position

In addition, loongson_canfd_reset() resets the controller before
loongson_canfd_rxdma_stop() terminates the active DMA transfer on
LOONGSON_CANFD_RX_DATA.  In loongson_canfd_close(),
cancel_delayed_work_sync(&priv->can.restart_work) also runs before
loongson_canfd_chip_stop() disables interrupts, so a bus-off interrupt in
that window can re-queue restart_work and restart RX DMA and the chip after
they have been stopped.

[ ... ]

> @@ -1435,6 +1698,247 @@ static int loongson_canfd_rx_deliver(struct net_d=
evice *ndev,
> +static bool loongson_canfd_rx_is_empty_dma(struct loongson_canfd_priv *p=
riv)
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
Does loongson_canfd_rx_is_empty_dma() return false when both the hardware
FIFO and the DMA ring are completely empty?

When all frames have been consumed (priv->rx_wr_pos =3D=3D priv->rx_rd_pos)=
 and
the hardware FIFO is empty, priv->rx_wr_pos < priv->rx_rd_pos + 2 is true
and this function returns false.  Every NAPI poll in DMA mode then calls
loongson_canfd_rx_one_frame_dma(), gets -EAGAIN because avail < 2, and spins
through all 100 LOONGSON_CANFD_DMA_WAIT_RETRY_MAX iterations before
completing.

Worse, if the hardware FIFO is empty while a single trailing word or
incomplete frame remains in the ring (priv->rx_wr_pos > priv->rx_rd_pos),
loongson_canfd_rx_napi() exhausts those 100 -EAGAIN retries and calls
loongson_canfd_rx_napi_done() without advancing priv->rx_rd_pos.
loongson_canfd_rx_napi_done() then sees priv->rx_wr_pos > priv->rx_rd_pos
and immediately calls napi_schedule(), causing an infinite NAPI softirq
livelock.

> +
> +	idx =3D priv->rx_rd_pos % LOONGSON_CANFD_RXDMA_NUM;
> +	h0 =3D priv->rx_cpu_buf[idx];
> +	h1 =3D priv->rx_cpu_buf[(idx + 1) % LOONGSON_CANFD_RXDMA_NUM];
> +
> +	/* Zero header: DMA zero-fill. Drop silently. */
> +	if (h0 =3D=3D 0 && h1 =3D=3D 0)
> +		goto discard;
> +
> +	/* Non-zero but implausible: mid-frame garbage. Drop silently. */
> +	if (!loongson_canfd_hdr_plausible(h0, h1))
> +		goto discard;
> +
> +	return false;
> +
> +discard:
> +	priv->rx_rd_pos =3D priv->rx_wr_pos;
> +	return true;
> +}

[Severity: High]
Can jumping to discard here wipe out the entire unread DMA ring buffer?

When the hardware FIFO has finished draining into the ring (RXFRC =3D=3D 0 =
and
REG_RX_STAT_RXE set), loongson_canfd_rx_is_empty_dma() inspects the two
words at priv->rx_rd_pos before loongson_canfd_rx_one_frame_dma() can check
for a ring overrun or resynchronize across a bad header.  If the ring
overran mid-frame, or if loongson_canfd_rx_one_frame_dma_overrun() just
repositioned priv->rx_rd_pos to rx_wr_pos - LOONGSON_CANFD_RXDMA_NUM + 2
(which is usually mid-frame), !loongson_canfd_hdr_plausible(h0, h1) is true
and goto discard sets priv->rx_rd_pos =3D priv->rx_wr_pos, silently dropping
up to 32 KB of valid unread frames.  The same full-ring discard happens if
leading zero-fill words sit at priv->rx_rd_pos ahead of valid frames (both
here and in loongson_canfd_rx_one_frame_dma_bad_hdr()).

> +
> +static int loongson_canfd_rx_one_frame_dma_overrun(struct net_device *nd=
ev,
> +						   u64 avail)
> +{
> +	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +	struct net_device_stats *stats =3D &ndev->stats;
> +	struct dma_tx_state dbg_state;
> +	u32 dbg_rx_stat =3D 0;
> +
> +	dmaengine_tx_status(priv->rx_ch, priv->rx_cookie, &dbg_state);
> +	regmap_read(priv->regmap, LOONGSON_CANFD_RX_STAT, &dbg_rx_stat);
> +
> +	netdev_warn(ndev, "RX DMA overrun, resyncing\n");
> +	scoped_guard(spinlock_irqsave, &priv->stats_lock) {
> +		stats->rx_errors++;
> +		stats->rx_over_errors++;
> +		stats->rx_dropped++;
> +	}
> +
> +	/* Words older than rx_wr_pos - RXDMA_NUM are already overwritten */
> +	if (priv->rx_wr_pos > LOONGSON_CANFD_RXDMA_NUM - 2)
> +		priv->rx_rd_pos =3D priv->rx_wr_pos - LOONGSON_CANFD_RXDMA_NUM + 2;
> +	else
> +		priv->rx_rd_pos =3D 0;
> +
> +	priv->rx_bad_cnt =3D 0;
> +	return 0;
> +}

[Severity: High]
Can loongson_canfd_rx_one_frame_dma_overrun() trap NAPI in an unbounded
softirq loop under sustained bus load?

Setting priv->rx_rd_pos to priv->rx_wr_pos - LOONGSON_CANFD_RXDMA_NUM + 2
leaves only 2 words of headroom in the cyclic ring and uses the stale
priv->rx_wr_pos sampled before the unratelimited netdev_warn().  While
netdev_warn() runs, the cyclic DMA continues writing; as soon as 3 or more
words arrive, the next loop iteration in loongson_canfd_rx_napi() syncs
priv->rx_wr_pos and sees avail > LOONGSON_CANFD_RXDMA_NUM again.  Because
this function returns 0, work_done is never incremented in
loongson_canfd_rx_napi(), so the poll loop can repeat indefinitely while
flooding the kernel log.

> +
> +static int loongson_canfd_rx_one_frame_dma_bad_hdr(struct net_device *nd=
ev,
> +						   const struct loongson_canfd_rx_desc *d,
> +						   u64 saved_pos)
> +{
> +	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +	struct net_device_stats *stats =3D &ndev->stats;
> +	u32 rx_stat, tries;
> +	u64 pos;
> +
> +	regmap_read(priv->regmap, LOONGSON_CANFD_RX_STAT, &rx_stat);

[Severity: Low]
In loongson_canfd_rx_one_frame_dma_overrun(), the avail parameter,
dbg_state, and dbg_rx_stat are never used after querying DMA and MMIO
status, and in loongson_canfd_rx_one_frame_dma_bad_hdr(), rx_stat is read
from LOONGSON_CANFD_RX_STAT but never used.  Can these dead reads and
unused variables be removed?

[ ... ]

> +static int loongson_canfd_rx_one_frame_dma(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +	struct net_device_stats *stats =3D &ndev->stats;
> +	u64 avail, saved_rd_pos =3D priv->rx_rd_pos;
> +	struct loongson_canfd_rx_desc d;
> +	int ret;
> +
> +	/* Guard against unsigned underflow: rd past wr means desync */
> +	if (priv->rx_wr_pos < priv->rx_rd_pos) {
> +		netdev_warn(ndev,
> +			    "RX pointer inversion: rd=3D%llu wr=3D%llu, resync\n",
> +			    priv->rx_rd_pos, priv->rx_wr_pos);
> +
> +		scoped_guard(spinlock_irqsave, &priv->stats_lock) {
> +			stats->rx_dropped++;
> +		}
> +
> +		priv->rx_rd_pos =3D priv->rx_wr_pos;
> +		priv->rx_bad_cnt =3D 0;
> +		return 0;
> +	}
> +
> +	avail =3D priv->rx_wr_pos - priv->rx_rd_pos;
> +
> +	if (avail > LOONGSON_CANFD_RXDMA_NUM)
> +		return loongson_canfd_rx_one_frame_dma_overrun(ndev, avail);
> +
> +	if (avail < 2)
> +		return -EAGAIN;
> +
> +	if (!loongson_canfd_rx_hdr_valid(ndev, &d))
> +		return loongson_canfd_rx_one_frame_dma_bad_hdr(ndev, &d,
> +							     saved_rd_pos);
> +
> +	priv->rx_bad_cnt =3D 0;
> +
> +	/*
> +	 * Re-sample the DMA position: it may have advanced while the
> +	 * header words were being read. If the payload is not fully
> +	 * resident yet, roll the read position back and let NAPI retry.
> +	 */
> +	loongson_canfd_dma_sync_wr(priv);
> +
> +	if (priv->rx_wr_pos < priv->rx_rd_pos) {
> +		priv->rx_rd_pos =3D priv->rx_wr_pos;
> +		return 0;
> +	}
> +
> +	if (priv->rx_wr_pos - priv->rx_rd_pos < d.rwcnt - 2) {
> +		priv->rx_rd_pos =3D saved_rd_pos;
> +		return -EAGAIN;
> +	}
> +
> +	ret =3D loongson_canfd_rx_deliver(ndev, &d);
> +	if (ret !=3D -ENOMEM)
> +		return 1;
> +
> +	stats->rx_dropped++;

[Severity: Low]
priv->stats_lock is used to protect stats->rx_dropped++ in the pointer
inversion check above and in loongson_canfd_rx_one_frame_dma_overrun(), but
not here or in loongson_canfd_rx_one_frame_dma_bad_hdr() (and
loongson_canfd_rx_deliver() updates rx_bytes and rx_packets without
priv->stats_lock while loongson_canfd_rx_overrun_event() updates them under
priv->stats_lock in hard IRQ context).  Should ndev->stats updates use
priv->stats_lock consistently?

> +	priv->rx_rd_pos =3D saved_rd_pos + 1;
> +	if (++priv->rx_bad_cnt >=3D 64) {
> +		priv->rx_rd_pos =3D priv->rx_wr_pos;
> +		priv->rx_bad_cnt =3D 0;
> +		return -ENODATA;
> +	}
> +	return 1;
> +}

[Severity: High]
Why does the -ENOMEM path set priv->rx_rd_pos to saved_rd_pos + 1 instead
of saved_rd_pos + d.rwcnt?

At this point loongson_canfd_rx_hdr_valid() has already validated the frame
header and confirmed that all d.rwcnt words are present in the ring, and
loongson_canfd_rx_deliver() only failed to allocate an skb.  Rewinding
priv->rx_rd_pos to saved_rd_pos + 1 leaves the reader pointing at d.hdr1 in
the middle of the dropped frame, desynchronizing subsequent reads so that
header and payload words can be misinterpreted as new frame headers.

Also, because priv->rx_bad_cnt =3D 0 is executed unconditionally right after
loongson_canfd_rx_hdr_valid() succeeds (as well as in every other recovery
path), ++priv->rx_bad_cnt here is always 1 and the >=3D 64 check is
unreachable.

> @@ -1532,20 +2036,52 @@ static bool loongson_canfd_rx_overrun_event(struc=
t net_device *ndev)
>  static void loongson_canfd_rx_napi_done(struct napi_struct *napi,
>  					bool can_complete, int work_done)
>  {
>  	struct net_device *ndev =3D napi->dev;
>  	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +	u32 rx_stat;
> =20
>  	if (!can_complete || !napi_complete_done(napi, work_done))
>  		return;
> =20
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
> +
> +	/*
> +	 * Flush an overrun latched while DOI was masked (e.g. during
> +	 * NAPI). DOR is sticky and the handler is idempotent, so this
> +	 * costs one regmap_read in the common case.
> +	 */
> +	loongson_canfd_rx_overrun_event(ndev);

[Severity: Medium]
Can calling loongson_canfd_rx_overrun_event() from NAPI context race with
the hard IRQ handler?

REG_INT_STAT_DOI is not masked during NAPI, only briefly inside
loongson_canfd_interrupt() while servicing DOI.  If an RX overrun occurs as
NAPI completes, both loongson_canfd_rx_napi_done() and
loongson_canfd_interrupt() can read REG_STAT_DOR before either writes
REG_CMD_CDO, double-counting rx_over_errors and rx_errors and queuing
duplicate CAN_ERR_CRTL_RX_OVERFLOW error skbs.

> +
> +	regmap_read(priv->regmap, LOONGSON_CANFD_RX_STAT, &rx_stat);
> +
> +	if (FIELD_GET(REG_RX_STAT_RXFRC, rx_stat) =3D=3D 0 &&
> +	    (rx_stat & REG_RX_STAT_RXE)) {
> +		/* Quiescent: unmask RBNEI for the next empty -> non-empty edge */
> +		regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK,
> +			     FIELD_PREP(REG_INT_MASK_CLR, REG_INT_STAT_RBNEI));
> +		return;
> +	}

[Severity: Medium]
Can checking priv->rx_wr_pos before LOONGSON_CANFD_RX_STAT leave a DMA-moved
frame stranded in the ring with RBNEI unmasked?

If a frame is in the hardware FIFO when loongson_canfd_dma_sync_wr() runs
(so priv->rx_wr_pos =3D=3D priv->rx_rd_pos), and the DMA engine finishes mo=
ving
that frame into the ring before LOONGSON_CANFD_RX_STAT is read (without
crossing a 4 KB LOONGSON_CANFD_RXDMA_PERIOD boundary to fire DMADI):

CPU0                              DMA engine
loongson_canfd_rx_napi_done()
  loongson_canfd_dma_sync_wr()
  /* rx_wr_pos =3D=3D rx_rd_pos */
                                  moves frame from FIFO to ring
                                  /* FIFO is now empty */
  regmap_read(..., RX_STAT, ...)
  /* sees RXFRC =3D=3D 0 && RXE */
  unmasks RBNEI
  return;                         <-- frame sits in ring unread

Because the hardware FIFO is already empty when RBNEI is unmasked and
priv->rx_wr_pos is not re-checked afterward, no interrupt fires until new
bus traffic arrives.

[ ... ]

> @@ -1847,6 +2410,10 @@ static void loongson_canfd_err_interrupt(struct ne=
t_device *ndev, u32 isr)
>   * optional HW TX timestamp) and counts it sent; TX_BS_FAIL and
>   * TX_BS_CANCEL free the skb as dropped. Clears the completion record
>   * per slot and wakes the queue if a buffer became free.
> + *
> + * RBNEI is serviced by masking it, resuming the paused RX DMA channel
> + * (no-op in poll mode) and scheduling NAPI. DMADI is never enabled, so
> + * no DMA completion IRQ is expected in the RX path.
>   */
>  static void loongson_canfd_tx_interrupt(struct net_device *ndev)

[Severity: Low]
This comment on loongson_canfd_tx_interrupt() appears to be left over from
an earlier design: it is attached to the TX interrupt handler, and in this
patch the RX DMA channel is never paused and REG_INT_STAT_DMADI is enabled
and handled in loongson_canfd_interrupt().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794213427.gi=
t.zhoubinbin@loongson.cn?part=3D2
