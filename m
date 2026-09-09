Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298513DBD76
	for <linux-can@vger.kernel.org>; Wed,  9 Sep 2026 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948080; cv=none; b=RawNLxRV7gw+098SYvvbHTWsZ6L67n2hf/dNvvVtiQzMOOvWmbmRCJ9j4Yl3C+kgptyMKPiwwAYF2naxsvyvYWfnRi0UmJY+fVvQMR3D51CLS1lHjhw5WDY+RcfkkA0kfdkypijN08Xd7CXrfa0d+42Ls1S5WszhZsAW+IzdxoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948080; c=relaxed/simple;
	bh=7VJO11BeXrYyzDnyvrcwe0oMa9qR+DAFNLRGM9GowtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qj9xyVwRCc/7Svf+9Isb339jkSZeSqu37LpCotp9kSxnu8UlzXfReZ0c0vfcXNkMAylLQ7YXIbP6AfIV/frSTCSj6J0tMHf0xTEWyi1EpcBOvyNCMfZGRt9R5wPUpRzDQK8+P1F+xj3y+8dagkKD0n1+e3VJo72xaZsxvicp58o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVghWduU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVghWduU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2723D1F00A3F;
	Wed,  9 Sep 2026 10:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788948074;
	bh=xka0DEeU7tD/bjW5h2cVr5i8xdTRLHsapU393YT9kJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NVghWduUnLEJm1IwXg41hUtxywrrBVFM+107gjYrqDD7cA+VGxF8gP7uFiN9hqUq0
	 7+fKvkyOX6A2Rem9Q+s7UXQAtecsOf3vpdeuY11RSkIK5zLJZrhIl2IKCVSvkvbK5Q
	 RDFPwvilLAxX1tn1xPBXVArVnZPV9XWI90g9tsQVTT+hl7ymecE14mpvzz4pPYpY70
	 Fu2UUugohVV255jskP2tQNoI3Meqclfi7PGmEOsORXhdZMO+Ji7Jz21eVHG9dWSmbV
	 imz+W++qY/bB78ztfrrQce6ffw3ZUgVRygAbHQ0OO6RvR1q09EYAleSg/9+eE1lJzX
	 XeBDHHzhDebcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/2] can: loongson_canfd: Add RXDMA support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Zhou" <zhoubinbin@loongson.cn>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <ff4ef5ee62146dc40c1bcaa4db9e8b31467219ad.1788945497.git.zhoubinbin@loongson.cn>
References: <cover.1788945497.git.zhoubinbin@loongson.cn>
 <ff4ef5ee62146dc40c1bcaa4db9e8b31467219ad.1788945497.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 10:01:13 +0000
Message-Id: <20260909100114.2723D1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The cyclic DMA buffer wrap detection logic incorrectly interprets =
a normal buffer wrap as an overflow, silently discarding valid unread CAN f=
rames.
- [High] The lockless NAPI DMA ring buffer logic reads variable-length CAN =
frames without verifying that the DMA engine has transferred the entire fra=
me, leading to CPU over-reads of uninitialized or stale memory.
- [High] The cyclic DMA transfer is started during driver probe and runs co=
ntinuously, leading to stream corruption across interface resets.

Pre-existing issues:
- [Critical] Missing payload length constraint for classic CAN frames leads=
 to a heap buffer overflow in the SKB linear data area.
- [High] Malformed or invalid CAN frames cause permanent FIFO/DMA buffer de=
synchronization and an infinite NAPI polling loop by returning early withou=
t draining the invalid frame payload.
--

commit 27376fa7494d4080cdce1ee73b4800fd7a987b82
Author: Binbin Zhou <zhoubinbin@loongson.cn>

can: loongson_canfd: Add RXDMA support

Extend the driver with an optional DMA engine support for the receive path.
When a DMA channel is available, the RX buffer is mapped to a cyclic DMA
transfer that continuously fills a pre-allocated ring buffer. The driver
then reads incoming CAN frames directly from the DMA buffer, improving
performance under high traffic.

> diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_=
canfd.c
> index 6c983987a1208..7fb28bd00c14c 100644
> --- a/drivers/net/can/loongson_canfd.c
> +++ b/drivers/net/can/loongson_canfd.c
> @@ -523,12 +543,166 @@ static void loongson_canfd_set_txbuf_cmd(struct ne=
t_device *ndev,

[ ... ]

> +static bool loongson_canfd_rxbuf_empty_dma(struct loongson_canfd_priv *p=
riv)
> +{
> +	struct dma_tx_state state;
> +	enum dma_status status;
> +	u32 wptr_dist;
> +
> +	status =3D dmaengine_tx_status(priv->rx_ch, priv->rx_cookie, &state);
> +	if (status !=3D DMA_IN_PROGRESS)
> +		return true;
> +
> +	/* Convert residue from bytes to number of 32-bit words */
> +	wptr_dist =3D state.residue / DMA_SLAVE_BUSWIDTH_4_BYTES;
> +
> +	/*
> +	 * wptr_dist is the write pointer's distance from the buffer end.
> +	 * It starts at BUFFER_SIZE (when write pointer is at start) and
> +	 * decreases to 0 (when write pointer reaches end), then wraps back.
> +	 * priv->rx_rd_ptr_dist is the read pointer's distance from the end.
> +	 * If write pointer wraps past read pointer, wptr_dist becomes larger,
> +	 * indicating data loss, so we advance read pointer to write position.
> +	 */
> +	if (priv->rx_rd_ptr_dist < wptr_dist)
> +		priv->rx_rd_ptr_dist =3D wptr_dist;

[Severity: High]
Does this logic mistakenly trigger on every normal buffer wrap-around?

Both wptr_dist and rx_rd_ptr_dist track the pointer's distance from the end
of the buffer, decreasing towards 0. When the DMA write pointer completes a
cycle and wraps back to the beginning, wptr_dist resets to its maximum valu=
e.

If the read pointer has not yet wrapped, the condition
priv->rx_rd_ptr_dist < wptr_dist unexpectedly evaluates to true during a
normal wrap-around.

The driver misinterprets this as the write pointer overtaking the read
pointer and forcefully sets priv->rx_rd_ptr_dist =3D wptr_dist, which will
erroneously skip all unread valid data remaining at the end of the buffer.

Conversely, if a true overflow occurs, wptr_dist is smaller, evaluating to
false and failing to detect the overflow.

> +
> +	return priv->rx_rd_ptr_dist =3D=3D wptr_dist;

[Severity: High]
Could this cause the CPU to over-read uninitialized or stale memory?

This function returns false as soon as the DMA engine writes a single 32-bit
word. Because the DMA engine transfers data asynchronously and word-by-word
(or in small bursts), it may not have finished writing the full variable-le=
ngth
CAN frame when this function signals that data is ready.

The CPU will read ahead of the DMA write pointer in loongson_canfd_rx(),
fetching stale memory, reading garbage payload or frame lengths, and
permanently corrupting the stream pointer.

> +}

[ ... ]

> +static int loongson_canfd_rxdma_init(struct net_device *ndev)
> +{
> +	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +	struct dma_async_tx_descriptor *desc =3D NULL;
> +	struct device *dev =3D ndev->dev.parent;
> +	struct dma_slave_config config;
> +	int ret;
> +
> +	if (!priv->rx_ch)
> +		return -EINVAL;
> +
> +	priv->rx_buf =3D dma_alloc_coherent(dev, LOONGSON_CANFD_RXBUF_SZ,
> +					  &priv->rx_dma_buf, GFP_KERNEL);
> +	if (!priv->rx_buf) {
> +		dma_release_channel(priv->rx_ch);
> +		priv->rx_ch =3D NULL;
> +		return -ENOMEM;
> +	}
> +
> +	memset(&config, 0, sizeof(config));
> +	config.src_addr =3D priv->res->start + LOONGSON_CANFD_RX_DATA;
> +	config.src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> +
> +	ret =3D dmaengine_slave_config(priv->rx_ch, &config);
> +	if (ret < 0) {
> +		netdev_err(ndev, "RX DMA channel config failed\n");
> +		goto err_config;
> +	}
> +
> +	desc =3D dmaengine_prep_dma_cyclic(priv->rx_ch, priv->rx_dma_buf,
> +					 LOONGSON_CANFD_RXBUF_SZ, LOONGSON_CANFD_RXBUF_SZ,
> +					 DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
> +	if (!desc) {
> +		netdev_err(ndev, "RX DMA cyclic transaction preparation failed\n");
> +		ret =3D -EBUSY;
> +		goto err_config;
> +	}
> +
> +	priv->rx_cookie =3D dmaengine_submit(desc);

[Severity: High]
Could starting the DMA engine here during probe and running it continuously
lead to stream corruption across interface resets?

When the interface is brought down via loongson_canfd_chip_stop(), the CAN
controller stops and resets, but the DMA engine remains active with its
current pointers.

When brought back up, the CAN controller is reset, but the DMA pointers and
CPU read pointers are not reset. Because the hardware FIFO was flushed but
the DMA buffer was not, the newly received CAN frames are appended to
whatever partial frame was left in the DMA buffer before the reset.

Will this splice frames together and cause permanent stream desynchronizati=
on
the first time the interface recovers from a bus-off condition or is manual=
ly
reset?

> +	ret =3D dma_submit_error(priv->rx_cookie);

[ ... ]

> @@ -929,14 +1106,14 @@ static int loongson_canfd_rx(struct net_device *nd=
ev)
>  {
>  	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
>  	struct net_device_stats *stats =3D &ndev->stats;
> -	u32 frame_hdr0, frame_hdr1, dlc, rwcnt, dbcnt, i, data;
> +	u32 frame_hdr0, frame_hdr1, dlc, rwcnt, dbcnt, i;
>  	struct canfd_frame *cfd;
>  	struct can_frame *ccf;
>  	struct sk_buff *skb;
>  	bool is_can_fd;
> =20
> -	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &frame_hdr0);
> -	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &frame_hdr1);
> +	frame_hdr0 =3D priv->get_rx_data(priv);
> +	frame_hdr1 =3D priv->get_rx_data(priv);
> =20
>  	rwcnt =3D FIELD_GET(REG_FRAME_META1_RWCNT, frame_hdr1);
>  	if (rwcnt < 2)
>  		return -EAGAIN;

[Severity: High]
This is a pre-existing issue, but does this early return cause permanent
FIFO or DMA buffer desynchronization?

If the parsed header yields rwcnt < 2, the function returns -EAGAIN early.
This aborts processing but leaves the read pointer (either the hardware FIFO
pop count or the DMA read index) partially advanced by only 2 words.

The remaining payload words of the invalid frame are left in the buffer or
FIFO. On the next NAPI poll, the driver will mistakenly read these leftover
payload words as if they were a new header, resulting in permanent stream
desynchronization.

Because the unread payload remains in the buffer, the empty check
continuously returns true, triggering an interrupt storm and an infinite NA=
PI
loop that hangs the CPU.

> =20
>  	dbcnt =3D (rwcnt - 2) * LOONGSON_CANFD_DW_BYTE;
>  	if (dbcnt > CANFD_MAX_DLEN)
>  		return -EAGAIN;

[Severity: High]
This is a pre-existing issue, but could this early return also cause perman=
ent
buffer desynchronization and NAPI loops, just like the rwcnt < 2 case above,
because it fails to drain the remainder of the malformed frame?

> =20
>  	is_can_fd =3D !!(frame_hdr1 & REG_FRAME_META1_FDF);
>  	if (is_can_fd) {

[ ... ]

> @@ -983,13 +1160,11 @@ static int loongson_canfd_rx(struct net_device *nd=
ev)
>  	else
>  		can_frame_set_cc_len(ccf, dlc, priv->can.ctrlmode);
> =20
> -	for (i =3D 0; i < dbcnt; i +=3D LOONGSON_CANFD_DW_BYTE) {
> -		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
> -		put_unaligned_le32(data, cfd->data + i);
> -	}
> +	for (i =3D 0; i < dbcnt; i +=3D LOONGSON_CANFD_DW_BYTE)
> +		put_unaligned_le32(priv->get_rx_data(priv), cfd->data + i);

[Severity: Critical]
This is a pre-existing issue, but does this loop cause a heap buffer overfl=
ow
in cfd->data for classic CAN frames?

The code checks if dbcnt > CANFD_MAX_DLEN (64 bytes), but fails to ensure
dbcnt <=3D CAN_MAX_DLEN (8 bytes) when processing a classic CAN frame.

For classic CAN frames, alloc_can_skb() allocates an SKB containing exactly
a 16-byte struct can_frame.

If dbcnt exceeds 8 (which happens when the parser is desynchronized by the
DMA race conditions or corrupted hardware state), this loop copies up to 64
bytes into cfd->data. This writes up to 56 bytes past the end of the alloca=
ted
16-byte buffer, triggering an overflow in the SKB's linear data area.

[Severity: High]
Could this unconditional read of the payload read ahead of the DMA write
pointer?

Because loongson_canfd_rxbuf_empty_dma() signals data ready when the first
word is written, the DMA engine may not have transferred these payload words
yet. This will read garbage payload data and corrupt the stream state.

> =20
>  	while (unlikely(i < dbcnt)) {
> -		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
> +		priv->get_rx_data(priv);
>  		i +=3D LOONGSON_CANFD_DW_BYTE;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788945497.gi=
t.zhoubinbin@loongson.cn?part=3D2
