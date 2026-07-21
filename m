Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7E5481FDF
	for <linux-can@vger.kernel.org>; Tue, 21 Jul 2026 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635018; cv=none; b=OQm3qa/kcFRCQcvhA/ocUYaaGOsJ27E+TWqnWns1igUW3JnmMeXa5ei8HnORNSkkM05BBTB3ku9Yql98EEammTaLwl/w3lCEKk6gFfUmLgs5ZeNmb3tBv5e/IlgE4ehLqdbFYJye8uWL+jFin3YOzEA+drEyuzHjQBTWcg5eSI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635018; c=relaxed/simple;
	bh=fk0dfaJ4RRB61rkxpXjRFJIrvR6hKAYqI66jJwYuDpA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HAR1MpdUS3KMdMjyXJuj0uV90D4xgbU+b8qk65k2c4cLbwEvyK2Uz3zAEqw3NfB1QsiHGgE+x1cXnnU0FSQazyIU8SD8JBogNJQdi1PBeiPRi965dCdWONGmfSSdJju0wnayEFFrbeJ3ajeYOsTfuM02k6aEPZEdrKc8vzvSHGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5lsAQEn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5lsAQEn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86251F000E9;
	Tue, 21 Jul 2026 11:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784635017;
	bh=NXlzwq5p13gO69cKd1U0KRr0rYz3gpG34cSZGMFLP4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U5lsAQEnFnp1oVKHOeR2k2BfjGt87DczSLjfCz3dthNjNMMWfBaIkR88GBsrWpD03
	 58yPWu/VhTbgtl6XotHZJVXr7bUOPxxGJT6JfxnjMgFNZsmhQ90QjzJ3fc9NFP+utz
	 9DNPtEbRxqA6jc3KVHqF/iRdDg3EMtie3uV8XQ2j5XMcx8Cl8KaGMPd5zmuyLVgOtV
	 fuXNKHpxt4qYEsLjBdJNQXNK9D0d4oVTnlHZH2A/ZQv/IaFquozgTkmFDw+7JzaBx8
	 eIPFx8lPpoWAUHmOLRlGIHrdHZHU58ZXBliWfT+kqjmRBQ3QOXtQX3rUrWt2besuSR
	 qrHuCJ779tY9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] can: Add Loongson CAN-FD controller driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Zhou" <zhoubinbin@loongson.cn>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <5896e9ebf39e4796a6e1d9f587f876e106094969.1784597142.git.zhoubinbin@loongson.cn>
References: <cover.1784597141.git.zhoubinbin@loongson.cn>
 <5896e9ebf39e4796a6e1d9f587f876e106094969.1784597142.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 11:56:56 +0000
Message-Id: <20260721115656.B86251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Integer underflow and missing bounds check in the RX path allows o=
ut-of-bounds heap writes.
- [High] NAPI poll routine violates NAPI protocol on early exit, stranding =
the polling state machine.
- [High] Clearing the TX interrupt status after checking TX buffers causes =
a TOCTOU race condition that permanently loses completions.
- [High] Unhandled hardware interrupts and missing status clears trap the d=
river in an infinite ISR loop.
- [Medium] `loongson_canfd_start_xmit` silently drops packets instead of re=
turning `NETDEV_TX_BUSY` when buffers are transiently unready.
- [Medium] Data race on `ndev->stats.rx_errors` due to concurrent modificat=
ion from hardirq and softirq contexts.
- [Low] Useless `processed_mask` check in `loongson_canfd_tx_interrupt`.
--

--- Patch [1]: [PATCH v6 1/2] can: Add Loongson CAN-FD controller driver ---
commit 5f440f327c688c271e3208983fc49fe2d7c3dd2d
Author: Binbin Zhou <zhoubinbin@loongson.cn>

can: Add Loongson CAN-FD controller driver

Add a new driver for the Loongson CAN-FD controller, which is integrated
into Loongson-2K series SoCs. The controller supports both CAN 2.0 and
CAN-FD protocols, with up to 8 TX buffers and a flexible RX buffer.

> diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_=
canfd.c
> new file mode 100644
> index 0000000000000..211133258b083
> --- /dev/null
> +++ b/drivers/net/can/loongson_canfd.c
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
> +	if (!loongson_canfd_insert_frame(priv, cf, buf_id, can_is_canfd_skb(skb=
))) {
> +		netdev_err(ndev, "TXNF set but cannot insert frame into TXTB! HW Bug?"=
);
> +		dev_kfree_skb_any(skb);
> +		ndev->stats.tx_dropped++;
> +		return NETDEV_TX_OK;
> +	}

[Severity: Medium]
Is it correct to drop the packet and return NETDEV_TX_OK here?

If the loop falls through because all buffers have active tx_bs states,=20
buf_id remains 0. Insertion will then fail. Should this instead stop the=20
queue and return NETDEV_TX_BUSY to avoid dropping packets during transient=
=20
buffer states?

[ ... ]
> +static int loongson_canfd_rx(struct net_device *ndev)
> +{
[ ... ]
> +	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta0);
> +	regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, &meta1);
> +
> +	/* Number of characters received */
> +	rwcnt =3D FIELD_GET(REG_FRAME_META1_RWCNT, meta1);
> +	if (!rwcnt)
> +		return -EAGAIN;
> +	dbcnt =3D (rwcnt - 2) * LOONGSON_CANFD_DW_BYTE;

[Severity: High]
Can this result in an integer underflow if rwcnt is 1?=20

It appears dbcnt operates without a bounds check against the SKB allocation=
=20
size. If the hardware provides rwcnt < 2, dbcnt could underflow to a huge=20
32-bit integer, leading to a buffer overflow when writing data to cfd->data.

[ ... ]
> +static void loongson_canfd_err_interrupt(struct net_device *ndev, u32 is=
r)
> +{
[ ... ]
> +	/* Check for Bus Error interrupt */
> +	if (isr & REG_INT_STAT_BEI) {
> +		mask |=3D REG_INT_STAT_BEI;
> +		netdev_err(ndev, "Bus Error interrupt\n");
> +		priv->can.can_stats.bus_error++;
> +		stats->rx_errors++;

[Severity: Medium]
Could this cause a data race on ndev->stats.rx_errors?

This is executed in hardirq context, while the same counter is also=20
incremented in softirq context in loongson_canfd_rx_napi(). Non-atomic=20
increments across these contexts might lead to torn updates or lost counts.

[ ... ]
> +static int loongson_canfd_rx_napi(struct napi_struct *napi, int quota)
> +{
[ ... ]
> +	while (!rxbuf_is_empty && work_done < quota && ret !=3D -EAGAIN) {
> +		ret =3D loongson_canfd_rx(ndev);
> +		work_done++;
> +		rxbuf_is_empty =3D loongson_canfd_rxbuf_empty(priv);
> +	}
[ ... ]
> +	if (rxbuf_is_empty) {
> +		if (napi_complete_done(napi, work_done)) {

[Severity: High]
What happens if the while loop exits early due to ret =3D=3D -EAGAIN but=20
rxbuf_is_empty is false?=20

This skips napi_complete_done() even though work_done < quota, which=20
leaves the NAPI state stuck in NAPI_STATE_SCHED but off the poll list,=20
potentially stalling the RX path permanently.

[ ... ]
> +static void loongson_canfd_tx_interrupt(struct net_device *ndev)
> +{
[ ... ]
> +	for (buf_id =3D 0; buf_id < LOONGSON_CANFD_TXBUF_NUM; buf_id++) {
> +		if (processed_mask & BIT(buf_id))
> +			continue;

[Severity: Low]
Is this processed_mask check needed?

Since buf_id strictly increments from 0 to 7 in this loop, the bit for the=
=20
current buf_id will always be clear when evaluated.

[ ... ]
> +	if (processed_mask) {
> +		/*
> +		 * Clear the interrupt again. We do not want to receive again interrupt
> +		 * for the buffer already handled. If it is the last finished one then
> +		 * it would cause log of spurious interrupt.
> +		 */
> +		regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, REG_INT_STAT_TXBHC=
I);
> +	}

[Severity: High]
Could clearing the TX interrupt status at the end of the loop cause a race=
=20
condition?=20

If a different TX buffer completes transmission after it was checked by the=
=20
loop but before the REG_INT_STAT_TXBHCI bit is cleared, the software clear=
=20
might wipe out the new hardware assertion, permanently losing the completio=
n=20
for that buffer.

[ ... ]
> +static irqreturn_t loongson_canfd_interrupt(int irq, void *dev_id)
> +{
[ ... ]
> +	for (unsigned int irq_loops =3D 0; irq_loops < 10000; irq_loops++) {
> +		/* Get the interrupt status */
> +		regmap_read(priv->regmap, LOONGSON_CANFD_INT_STAT, &isr);

[Severity: High]
Is there a risk of an endless loop here?

If the hardware asserts an unhandled interrupt bit (like DOI or BSI), or if=
=20
TXBHCI is set but skipped because processed_mask =3D=3D 0 in the TX handler=
,=20
the bit will remain set in INT_STAT. The loop will spin 10,000 times, and=20
then loongson_canfd_disable_interrupts() will permanently kill the=20
interface.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784597141.gi=
t.zhoubinbin@loongson.cn?part=3D1
