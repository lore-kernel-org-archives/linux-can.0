Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82CF3F327F
	for <linux-can@vger.kernel.org>; Wed,  5 Aug 2026 09:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920797; cv=none; b=N8abTkdmykBQLJrU22dT2gO/lEBSvDzOM5MdQJauiD6rMIV6ydyXDnRk+7edT789JeCjo8loWK5cCG0bUnYVGIvhPSw1RbemsVviA52q9yf3WrqZ4vaUFVTBses19bz3OWr8JiIaV/5zh7LPXvmH8uLUjWa0fi/2ESZEiQ3eB2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920797; c=relaxed/simple;
	bh=/1H1nvy+eiiznKItjFGQ8Cdl2h0POQmFBup9+t+McEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lrd7wufnQKPNs6qC1+gWyMoGjWUwWULAL3k3b2esU4ZIrRgnZKM9aEjq4cgIfUkq5omVDSHSP7MgDm03h/0AO8LZGYWBnmV8vL4HQ/g6IT2NwbIKVCvJxKkcVL1NhLdT4EtwpeeOMV+MtjbU3Zo8ZZ2iW+oE2P1VRvqWy1IJtkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2guD5YP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2guD5YP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90B71F00A3D;
	Wed,  5 Aug 2026 09:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785920792;
	bh=6vlaO0EomwXGjyh2cdzY/7KFrHgT4wfFbtxap18WiDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o2guD5YPMrXr2lYefj5EL+N3jbeXk+DS1k8Nrx1E5nvEIsFd7qTabFXpxu5f8aMHJ
	 pzLYJL5H+gG0uah+cjRDUb+/8CNYhpjnWyR98eDBH5yhdN7n9inXrdJZclJ+PtEHob
	 cZIGO0ZmuN83c16TtT6DitpCsXBTjW8CqnUtwUz5u7WEKLphLK9OGWHQIjBz064LWh
	 YMct2HzTDmU9eC2XkMz1WiTdjSJbpDX3peK0VyaS86kCXe4vS4ZQiHV4ghVPMFjSkZ
	 tFFUJU/Wq+ls2OrLxUMhU+2TKt0Scq87DyiV0jLGNu5TemIHwudO4wLswg/RjLFs+2
	 YElGYUDTB4U3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2] can: loongson_canfd: Add RXDMA support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Zhou" <zhoubinbin@loongson.cn>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <965b460722a9256fc045a69ddac049fb40b2cba1.1785898181.git.zhoubinbin@loongson.cn>
References: <cover.1785898181.git.zhoubinbin@loongson.cn>
 <965b460722a9256fc045a69ddac049fb40b2cba1.1785898181.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 09:06:31 +0000
Message-Id: <20260805090631.E90B71F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] NAPI RX polling races with DMA engine word-by-word transfers, caus=
ing frame corruption and permanent stream desynchronization.
- [High] Spurious reads and desynchronization due to logic flaw when DMA re=
sidue reaches zero.
- [Medium] Silent data loss and misalignment due to lack of RX DMA cyclic b=
uffer overflow detection.
- [Medium] Missing dma_rmb() causes reads of stale coherent DMA memory.

Pre-existing issues:
- [Critical] Heap buffer overflow when receiving Classical CAN frames due t=
o missing length validation.
- [High] Incomplete consumption of invalid frames leads to permanent RX str=
eam desynchronization.
--

--- Patch [2]: [PATCH v7 2/2] can: loongson_canfd: Add RXDMA support ---
commit c004fc59a1568e0e67b052c8c64387941f3c4086
Author: Binbin Zhou <zhoubinbin@loongson.cn>

can: loongson_canfd: Add RXDMA support

Extend the driver with an optional DMA engine support for the receive
path. When a DMA channel named rx is available, the RX buffer is
mapped to a cyclic DMA transfer that continuously fills a ring buffer.

> diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_=
canfd.c
> index dbb8bd434080a..714c7706f3551 100644
> --- a/drivers/net/can/loongson_canfd.c
> +++ b/drivers/net/can/loongson_canfd.c

[ ... ]

> @@ -524,13 +544,150 @@ static void loongson_canfd_set_txbuf_cmd(struct ne=
t_device *ndev,
> +static u32 loongson_canfd_get_rxdata_in_dma(struct loongson_canfd_priv *=
priv)
> +{
> +	u32 data =3D 0;
> +
> +	data =3D priv->rx_buf[LOONGSON_CANFD_RXDMA_NUM - priv->last_res--];

[Severity: Medium]
Does reading from the DMA buffer in loongson_canfd_get_rxdata_in_dma()
require a read memory barrier? On weakly ordered architectures like
LoongArch, the CPU might speculatively prefetch the coherent DMA buffer
before the MMIO status check in loongson_canfd_get_rxbuf_empty_in_dma()
confirms the data is ready. Could a dma_rmb() be needed to order this
memory read after the MMIO status check?

> +	if (!priv->last_res)
> +		priv->last_res =3D LOONGSON_CANFD_RXDMA_NUM;
> +
> +	return data;
> +}
> +
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

[Severity: High]
Since priv->last_res wraps directly from 1 to LOONGSON_CANFD_RXDMA_NUM
(256) and never becomes 0, what happens when the cyclic DMA transfer
reaches the end of its period and state.residue is 0? Will this cause
the empty check to evaluate to false (since 256 !=3D 0), making the
driver incorrectly believe data is available when the buffer is actually
empty?

[Severity: High]
Does this logic assume that a full frame is available as soon as the DMA
residue differs from last_res? Because the DMA engine writes word-by-word,
the empty check will return false as soon as a single 32-bit word is
written. Will the subsequent unconditional full frame read in
loongson_canfd_rx() read ahead of the DMA controller into stale memory,
parsing incorrect lengths and permanently losing synchronization with
the cyclic buffer?

[Severity: Medium]
Is there a mechanism to detect if the DMA write pointer has lapped the
read pointer under high traffic? Since the driver only checks for exact
equality of the read and write pointers (last_res =3D=3D residue / 4), it
seems it cannot distinguish between an empty buffer and a buffer that
has been lapped by exactly 256 words. Will this lead to the CPU reading
from the middle of an overwritten frame without noticing?

[ ... ]

> @@ -957,14 +1117,14 @@ static int loongson_canfd_rx(struct net_device *nd=
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
>  	if (rwcnt < 2)
>  		return -EAGAIN;
> =20
>  	dbcnt =3D (rwcnt - 2) * LOONGSON_CANFD_DW_BYTE;
>  	if (dbcnt > CANFD_MAX_DLEN)
>  		return -EAGAIN;

[Severity: High]
This is a pre-existing issue, but by returning -EAGAIN early in
loongson_canfd_rx() when rwcnt < 2 or dbcnt > CANFD_MAX_DLEN, does the
driver fail to drain the remaining invalid payload words from the RX
source? If the payload is not consumed, will the next read attempt to
parse the leftover payload as the metadata headers for the next frame,
permanently desynchronizing the RX stream? This seems easier to trigger
now with the new DMA race conditions.

[ ... ]

>  	/* Copy payload */
>  	for (i =3D 0; i < dbcnt; i +=3D LOONGSON_CANFD_DW_BYTE)
> -		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, (u32 *)(cfd->data + =
i));
> +		*(u32 *)(cfd->data + i) =3D priv->get_rx_data(priv);

[Severity: Critical]
This is a pre-existing issue, but does this loop cause a heap buffer
overflow when receiving Classical CAN frames? In loongson_canfd_rx(),
for Classical CAN frames (is_can_fd =3D=3D false), the allocated skb only
has an 8-byte data array. However, the earlier bounds check only validates
that dbcnt <=3D CANFD_MAX_DLEN (64). Could this write up to 56 bytes past
the end of the can_frame into skb_shared_info, potentially leading to
memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785898181.gi=
t.zhoubinbin@loongson.cn?part=3D2
