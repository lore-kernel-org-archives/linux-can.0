Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2674A3783AE
	for <linux-can@vger.kernel.org>; Tue, 21 Jul 2026 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635002; cv=none; b=nY8yHPKkBW80l83HF4d74fPOPWB0c7IgXyV08Woqlk2Opwfzq9lwlEbWg0+kP7ONVVH+9ybvxwLTEVk1tEXfprCLbRi37+iCsSzHiJDIzE1qX8I2sopajEvbTbsHaRmFX4kucOgSgD1P2kRBKFZkqTxKxU73fVMF1RarfGUUauI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635002; c=relaxed/simple;
	bh=OaUy4jdMwqzuEwt9ahhZhWJmeFpAW4cCWVU9IhuwB0Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n/8v4oBNIqMHrKG8136CS5ofLhSeowz76SAnKB1g1YGaZ1iVKq7rXxM5ffj5xq1yVkELrvq/q2v2W488lDOgeg/7oyrwegRnWHW9stjxB3GgII2legRBOkVSEiFbUJrxDKjeCiEgAFLazNtu2WlkqU55azl09s6lEgn/XX/aYEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eq+BbElL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eq+BbElL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710E51F000E9;
	Tue, 21 Jul 2026 11:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784635000;
	bh=ZaioCJuNy8qYawuhiyqthZnWO1+TwgWLBsDwB+8Ws7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eq+BbElLMFs+dPeo1rjuNy4o7Wvnf6M212kxuAHRAu7dL7B0QRrqn1OkIL1ADFQqO
	 UPHjDQbo4oUsC3U4qMAsPyTdmc6XVgvPznptLj9tsyd7W2L4dXrtRAZH6HFMUfUcY9
	 ObqsnZh79zO0IAeglR440FltDlr2JH1DLwkzurE/c77IdhVLKbfOUxeFBcqehNUssu
	 2i/XbTIOWClRfM9Sl6sm4tmMClp8NecUwPapC9dI/1Vj8Rir1RKM7WVXSoMDV0Q2Bb
	 iHJG94J3M78JfSIpOfbvXZAZJq93z5fX7Oe3PenuP9d6j9Z0+x4QYbZuIxivMzE95Z
	 e/Nd1hn2uAnfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] can: loongson_canfd: Add RXDMA support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Zhou" <zhoubinbin@loongson.cn>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <0a0b43993195b2199df538d9386c4b0022cfbd99.1784597142.git.zhoubinbin@loongson.cn>
References: <cover.1784597141.git.zhoubinbin@loongson.cn>
 <0a0b43993195b2199df538d9386c4b0022cfbd99.1784597142.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 11:56:39 +0000
Message-Id: <20260721115640.710E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] NAPI reads ahead of the DMA write pointer, leading to stale da=
ta reads and permanent ring buffer desynchronization.
- [High] The DMA receive buffer is freed before the DMA engine is terminate=
d, causing hardware writes to freed memory.
- [High] Clearing the DMADI interrupt status at the end of NAPI causes lost=
 wakeups for newly arrived frames.

Pre-existing issues:
- [Critical] Missing bounds check and integer underflow on `rwcnt` leads to=
 a massive kernel heap buffer overflow.
--

--- Patch [2]: [PATCH v6 2/2] can: loongson_canfd: Add RXDMA support ---
commit e9fb5c097416d3376c7ac83b960fa3ca5f984b78
Author: Binbin Zhou <zhoubinbin@loongson.cn>

can: loongson_canfd: Add RXDMA support
   =20
Extend the driver with an optional DMA engine support for the receive
path. When a DMA channel named rx is available (e.g., from the
loongson2-apb-cmc-dma driver), the RX buffer is mapped to a cyclic DMA
transfer that continuously fills a pre-allocated ring buffer. The driver
then readds incoming CAN frames directly from the DMA buffer, reducing
the number of MMIO accesses and improving performance under high
traffic.

> diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_=
canfd.c
> index 211133258b083..d32c834a11264 100644
> --- a/drivers/net/can/loongson_canfd.c
> +++ b/drivers/net/can/loongson_canfd.c

[ ... ]

> @@ -521,13 +541,150 @@ static void loongson_canfd_set_txbuf_cmd(struct ne=
t_device *ndev,
> +static bool loongson_canfd_get_rxbuf_empty_in_dma(struct loongson_canfd_=
priv *priv)
> +{
> +	struct dma_tx_state state;
> +	enum dma_status status;
> +
> +	status =3D dmaengine_tx_status(priv->rx_ch, priv->rx_cookie, &state);
> +	if (status !=3D DMA_IN_PROGRESS)
> +		return true;
> +
> +	return priv->last_res =3D=3D (state.residue / DMA_SLAVE_BUSWIDTH_4_BYTE=
S);

[Severity: Critical]
Will this residue check allow NAPI to read ahead of the DMA write pointer?

Since the residue changes as soon as a single word is written, the CPU will
detect data is ready before a complete frame has been transferred. When
loongson_canfd_rx() is called, it will decrement priv->last_res to
unconditionally read multiple words (meta0, meta1, and payload), which might
result in fetching unwritten or stale memory for length fields and payload.

> +}
> +
> +static void loongson_canfd_rxdma_free(struct loongson_canfd_priv *priv, =
struct device *dev)
> +{
> +	if (!priv->rx_buf)
> +		return;
> +
> +	dma_free_coherent(dev, LOONGSON_CANFD_RXBUF_SZ, priv->rx_buf, priv->rx_=
dma_buf);
> +	priv->rx_buf =3D NULL;
> +}
> +
> +static void loongson_canfd_rxdma_remove(struct loongson_canfd_priv *priv=
, struct device *dev)
> +{
> +	if (!priv->rx_ch)
> +		return;
> +
> +	loongson_canfd_rxdma_free(priv, dev);
> +	dmaengine_terminate_sync(priv->rx_ch);

[Severity: High]
Does this free the DMA buffer while the cyclic DMA channel is still active?

Calling loongson_canfd_rxdma_free() before dmaengine_terminate_sync() could
allow the DMA controller to continue writing to pages that have been freed
and potentially reallocated to other kernel structures, which might cause
memory corruption during module unload or if probe fails.

[ ... ]

> @@ -949,14 +1109,14 @@ static int loongson_canfd_rx(struct net_device *nd=
ev)
>  {
>  	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
>  	struct net_device_stats *stats =3D &ndev->stats;
> -	u32 meta0, meta1, dlc, rwcnt, dbcnt, i, data;
> +	u32 meta0, meta1, dlc, rwcnt, dbcnt, i;
>  	struct canfd_frame *cfd;
>  	struct can_frame *ccf;
>  	struct sk_buff *skb;
>  	bool is_can_fd;
> =20
> -	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta0);
> -	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta1);
> +	meta0 =3D priv->get_rx_data(priv);
> +	meta1 =3D priv->get_rx_data(priv);
> =20
>  	/* Number of characters received */
>  	rwcnt =3D FIELD_GET(REG_FRAME_META1_RWCNT, meta1);
>  	if (!rwcnt)
>  		return -EAGAIN;
>  	dbcnt =3D (rwcnt - 2) * LOONGSON_CANFD_DW_BYTE;

[Severity: Critical]
This is a pre-existing issue, but does this calculation need bounds checking
or underflow protection?

If rwcnt is parsed from stale memory as 1 (which might happen due to the DMA
read-ahead behavior mentioned above), rwcnt - 2 will underflow, resulting in
a very large dbcnt.

[ ... ]

> @@ -1008,11 +1168,11 @@ static int loongson_canfd_rx(struct net_device *n=
dev)
> =20
>  	/* Copy payload */
>  	for (i =3D 0; i < dbcnt; i +=3D LOONGSON_CANFD_DW_BYTE)
> -		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, (u32 *)(cfd->data + =
i));
> +		*(u32 *)(cfd->data + i) =3D priv->get_rx_data(priv);

[Severity: Critical]
This is also a pre-existing issue, but if dbcnt is huge due to the integer
underflow mentioned above, will this loop cause a heap buffer overflow by
copying gigabytes of data into cfd->data?

[ ... ]

> @@ -1259,13 +1419,18 @@ static int loongson_canfd_rx_napi(struct napi_str=
uct *napi, int quota)
> =20
>  	if (rxbuf_is_empty) {
>  		if (napi_complete_done(napi, work_done)) {
> +			int int_ena;
>  			/*
> -			 * Clear and enable RBNEI. It is level-triggered,
> +			 * Clear and enable RBNEI/DMADI. It is level-triggered, so
>  			 * so there is no race condition.
>  			 */
> -			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, REG_INT_STAT_RBNE=
I);
> -			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK,
> -				     (REG_INT_STAT_RBNEI << 16));
> +			if (priv->rx_ch)
> +				int_ena =3D REG_INT_STAT_DMADI;
> +			else
> +				int_ena =3D REG_INT_STAT_RBNEI;
> +
> +			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, int_ena);
> +			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, (int_ena << 16));

[Severity: High]
Does unconditionally clearing the DMADI interrupt flag here cause a lost
wakeup?

If a frame finishes its DMA transfer after the rxbuf_is_empty check but
before this write to LOONGSON_CANFD_INT_STAT, the hardware sets the DMADI
flag, which will then be cleared immediately. Because it is cleared before
unmasking, the interrupt for the new frame could be lost, potentially
stalling incoming CAN frames.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784597141.gi=
t.zhoubinbin@loongson.cn?part=3D2
