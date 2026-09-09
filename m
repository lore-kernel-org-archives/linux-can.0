Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400BC3F8234
	for <linux-can@vger.kernel.org>; Wed,  9 Sep 2026 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948222; cv=none; b=OWmS9WXyvE7/tUBMyO2y7IUYTrN22ekrT5VdH1F4GtC7BcaYJ1DxKgtGKGgQDMOGzE/7ZaHL/zXb81xzLiobkjZeICj+vfi7z5TWOzf4vwUgXkac87KXFPw3iwXhkJqHPK4gCdQ1bNvLHguNtppriRSBRM6/aM5wlPn3PEjxD1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948222; c=relaxed/simple;
	bh=GPIlCfIl82koxQK4RTYde+PEXRVBuqmiYXZDkYTTqJY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qsk3dr6jIkvKU5fqXrIHcnlzA1w3amqT8BfSt3UqkHLL89nVWeVScQEaNro7uXg7BRsjuuyUuRFsvs4onBVAHggWA4d3L327/4haIOzu9mChqztWGh/DfwAPjHbgkXMkCF/mKlRnS5HUKWYEHuOKeZCK9LalAFxIsyZnFo/XvQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNW3NW0K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNW3NW0K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63E41F00A3A;
	Wed,  9 Sep 2026 10:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788948221;
	bh=VJZ1O2vd8SEvfmvD7BTfTcRaN5bwBbsYqXjMtidM/kc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oNW3NW0KLS2m9gKPEsBzDIf8D4rVplyE1yIxoZaNtJj8F8cdb5+nGnbmzGpLK73kA
	 qdGgoQLxST9ASP6xpfBHHJy6yp1XjHfNOSfRTe3IQ9mTucOPb4TFSBjxiYAr0NrcMf
	 ZW+bAD5SyXD5bjdT7lcN2+tqtwsRzZhOWepn6PmtkF173IIBV+6kFX5ajDfV1hMGzd
	 qufAvdP8cvEe5LNDjQu5ykXZLeRBbRqmjt0hOcfGpiWPWJotYkJJ4KdaPXxrbHIGLp
	 s+kZGWbGk0dUs0xayz6/pxgD4onP/1scJAPinL152B9KYEVMVHBQZ6VFZ2u28ibX2t
	 D67yYcETcM+DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/2] can: Add Loongson CAN-FD controller driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Zhou" <zhoubinbin@loongson.cn>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <b0eb7b00fe242808280531cbbd7cb197a9a2591e.1788945497.git.zhoubinbin@loongson.cn>
References: <cover.1788945497.git.zhoubinbin@loongson.cn>
 <b0eb7b00fe242808280531cbbd7cb197a9a2591e.1788945497.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 10:03:40 +0000
Message-Id: <20260909100340.C63E41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] Returning -EAGAIN on format error desynchronizes the RX FIFO and c=
auses an infinite interrupt storm.
- [High] Out-of-bounds write in the RX path when receiving Classical CAN fr=
ames with anomalous payload lengths.
- [High] TOCTOU races and incorrect clearing of Write-1-to-Clear (W1C) inte=
rrupt status bits cause permanent loss of interrupts.
- [Medium] Failure to use the correct DLC mapping for Classic CAN frames wi=
th DLC > 8.
- [Medium] Queue handling race in ndo_start_xmit causes false NETDEV_TX_BUS=
Y returns and severe console spam.
- [Medium] Bit timing logic fails to redistribute oversized prop_seg, silen=
tly misconfiguring hardware timings.
- [Medium] Incorrect initial operational state set in loongson_canfd_chip_s=
tart.
- [Low] Unreachable dead code loop intended to drain the RX FIFO.
--

commit e517c4643a4070a6b8fcde3c6d3ac1988016c84b
Author: Binbin Zhou <zhoubinbin@loongson.cn>

can: Add Loongson CAN-FD controller driver

This commit adds a new driver for the Loongson CAN-FD controller.
It supports both CAN 2.0 and CAN-FD protocols, implements NAPI-based
receive paths, TX echo support, error reporting, and various common CAN
controller modes.

> diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_=
canfd.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/net/can/loongson_canfd.c
> @@ -0,0 +1,1623 @@
[ ... ]
> +static void loongson_canfd_set_btr(struct net_device *ndev, struct can_b=
ittiming *bt, bool nominal)
> +{
> +	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> +	u32 ph1_max =3D FIELD_MAX(REG_BTR_PH1);
> +	u32 prop =3D bt->prop_seg, phase1 =3D bt->phase_seg1;
> +	u32 btr =3D 0;
> +
> +	/* Hardware PROP is 7 bits, PH1 is 6 bits; redistribute if PH1 exceeds =
max */
> +	if (phase1 > ph1_max) {
> +		prop +=3D phase1 - ph1_max;
> +		phase1 =3D ph1_max;
> +	}
> +
> +	if (nominal) {
> +		btr =3D FIELD_PREP(REG_BTR_PROP, prop) |

[Severity: Medium]
Does this logic fail to redistribute the values if prop exceeds its 7-bit
maximum?

If the user specifies prop_seg =3D 180 and phase_seg1 =3D 10, prop will exc=
eed
the maximum and its upper bits will be silently bitwise-truncated by the
FIELD_PREP(REG_BTR_PROP, prop) macro, resulting in invalid hardware timings.
Should it also shift the excess from prop to phase1?

[ ... ]
> +static int loongson_canfd_chip_start(struct net_device *ndev)
> +{
[ ... ]
> +	int_msk =3D FIELD_GET(REG_INT_MASK_SET, ~int_ena);
> +
> +	regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, int_msk);
> +	regmap_write(priv->regmap, LOONGSON_CANFD_INT_ENA, int_ena);
> +
> +	priv->can.state =3D CAN_STATE_STOPPED;

[Severity: Medium]
Should the initial CAN state be set to CAN_STATE_ERROR_ACTIVE here instead =
of
CAN_STATE_STOPPED?

The CAN subsystem conventions typically require transitioning the state to
CAN_STATE_ERROR_ACTIVE when the hardware is enabled and traffic can flow.

> +
> +	regmap_update_bits(priv->regmap, LOONGSON_CANFD_CONF, REG_CONF_ENA, REG=
_CONF_ENA);
> +
> +	return 0;
> +}

[ ... ]
> +static bool loongson_canfd_insert_frame(struct loongson_canfd_priv *priv,
> +					const struct canfd_frame *cf, u8 buf, bool isfdf)
> +{
[ ... ]
> +	if (isfdf) {
> +		frame_hdr1 =3D REG_FRAME_META1_FDF;
> +		if (cf->flags & CANFD_BRS)
> +			frame_hdr1 |=3D REG_FRAME_META1_BRS;
> +	}
> +
> +	frame_hdr1 |=3D FIELD_PREP(REG_FRAME_META1_DLC, can_fd_len2dlc(cf->len)=
);

[Severity: Medium]
For Classic CAN frames requesting a DLC greater than 8, will
can_fd_len2dlc(cf->len) result in an incorrect clamped DLC being transmitte=
d?

The driver advertises CAN_CTRLMODE_CC_LEN8_DLC support, meaning a Classic C=
AN
frame may have cf->len =3D 8 but a user-requested cf->len8_dlc > 8.
Should can_get_cc_dlc() be used here for Classic CAN frames?

[ ... ]
> +static netdev_tx_t loongson_canfd_start_xmit(struct sk_buff *skb, struct=
 net_device *ndev)
> +{
[ ... ]
> +	for_each_clear_bit(i, &tx_brp, LOONGSON_CANFD_TXBUF_NUM) {
> +		u32 transmission_complete_mask =3D 0x3 << (i * 2);
> +
> +		if (!(tx_bs & transmission_complete_mask)) {
> +			buf_id =3D i;
> +			break;
> +		}
> +	}
> +
> +	if (buf_id =3D=3D LOONGSON_CANFD_TXBUF_NUM) {
> +		netif_stop_queue(ndev);
> +		netdev_err(ndev, "No writable TX buffer, stopping queue\n");
> +		return NETDEV_TX_BUSY;
> +	}

[Severity: Medium]
Could this condition trigger erroneously during a normal transient race win=
dow?

A buffer whose pending bit REG_TX_STAT_BRP is 0 might have its software
status BS set to TX_BS_VALID if the hardware completed transmission but the
ISR hasn't cleaned it yet. In that case, no buf_id will be found, resulting
in console spam and a false queue stoppage.

[ ... ]
> +static int loongson_canfd_rx(struct net_device *ndev)
> +{
[ ... ]
> +	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &frame_hdr0);
> +	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &frame_hdr1);
> +
> +	rwcnt =3D FIELD_GET(REG_FRAME_META1_RWCNT, frame_hdr1);
> +	if (rwcnt < 2)
> +		return -EAGAIN;
> +
> +	dbcnt =3D (rwcnt - 2) * LOONGSON_CANFD_DW_BYTE;
> +	if (dbcnt > CANFD_MAX_DLEN)
> +		return -EAGAIN;

[Severity: High]
By returning -EAGAIN early here without draining the remaining unread paylo=
ad
words from the hardware FIFO, will this permanently desynchronize the RX pa=
th?

It appears this would abort the NAPI poll while leaving data in the buffer.
When NAPI completes, the RX Not Empty interrupt is unmasked and immediately
fires again, causing an infinite interrupt storm.

> +
> +	is_can_fd =3D !!(frame_hdr1 & REG_FRAME_META1_FDF);
> +	if (is_can_fd) {
> +		skb =3D alloc_canfd_skb(ndev, &cfd);
> +	} else {
> +		skb =3D alloc_can_skb(ndev, &ccf);
> +		cfd =3D (struct canfd_frame *)ccf;
> +	}
[ ... ]
> +	for (i =3D 0; i < dbcnt; i +=3D LOONGSON_CANFD_DW_BYTE) {
> +		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
> +		put_unaligned_le32(data, cfd->data + i);
> +	}

[Severity: High]
Does this loop allow out-of-bounds writes if a Classical CAN frame has an
anomalous payload length?

If the hardware returns a frame where FDF=3D0 but with rwcnt up
to 18 (dbcnt =3D 64 bytes), the length check dbcnt > CANFD_MAX_DLEN allows =
it.
The alloc_can_skb() function only provides an 8-byte data array for Classic
CAN frames, so this loop would write up to 64 bytes, overflowing the buffer
and corrupting the skb_shared_info structure.

> +
> +	while (unlikely(i < dbcnt)) {
> +		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &data);
> +		i +=3D LOONGSON_CANFD_DW_BYTE;
> +	}

[Severity: Low]
Is this loop unreachable dead code?

Since dbcnt is mathematically guaranteed to be a multiple of 4, the prior
for loop exactly terminates when i =3D=3D dbcnt, making the i < dbcnt condi=
tion
strictly false here.

[ ... ]
> +static void loongson_canfd_err_interrupt(struct net_device *ndev, u32 is=
r)
> +{
[ ... ]
> +	if (skb)
> +		netif_rx(skb);
> +
> +	regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, mask);

[Severity: High]
Does double-clearing the Write-1-to-Clear (W1C) error interrupt bits here
cause a TOCTOU race?

The main ISR loongson_canfd_interrupt() appears to have already cleared the=
se
bits, so writing to them again could wipe out newly arrived interrupts.

> +	regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, mask << 16);
> +}
> +
> +static int loongson_canfd_rx_napi(struct napi_struct *napi, int quota)
> +{
[ ... ]
> +	if (no_more_data) {
> +		if (napi_complete_done(napi, work_done)) {
> +			regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, REG_INT_STAT_RBNE=
I);

[Severity: High]
Is it safe to clear the REG_INT_STAT_RBNEI interrupt flag at the end of the
NAPI poll?

This could create a race condition where any RX interrupts that arrived aft=
er
the empty check are dropped.

> +			regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK,
> +				     REG_INT_STAT_RBNEI << 16);
> +		}
> +	}
> +
> +	return work_done;
> +}
> +
> +static void loongson_canfd_tx_interrupt(struct net_device *ndev)
> +{
[ ... ]
> +		loongson_canfd_set_txbuf_cmd(ndev, TXT_CMD_SR_CLEAN, buf_id);
> +	}
> +
> +	regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, REG_INT_STAT_TXBHCI=
);

[Severity: High]
Similar to the above, does clearing the aggregate TX completion interrupt f=
lag
after checking the queues create a race window where missed completions cou=
ld
stall the TX queue?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788945497.gi=
t.zhoubinbin@loongson.cn?part=3D1
