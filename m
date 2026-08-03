Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578984137B9;
	Mon,  3 Aug 2026 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768200; cv=none; b=F7MUIr88Eq2+oyiQfAXE9KBYX/D3d7ZQ8Qv+0mHbFXpFZQpd+2nLlxP5xjIsXtMGJxLSb5DIrsX6B89+6WkogEYTCgyMrVaBRiZeYLb6Cf+XPQ5QpudPjZ6Zsczsdvq5sNhNXeGNpu+oy76VgpRGTubxzyph4X4xI8Y02eAhZz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768200; c=relaxed/simple;
	bh=/wFBezbWLXLut7mevP/0wcXIbm2ZNy/Ny44UkBvW2wI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HlSocMjyn5FVZ5UdapnsNnFj/NvSrEDvIyL4xluqQ7SPUomowyxZun/JPqRb+wKxZqRfsjBhiOc6SmoeDRmbJMg2K4j9oU7rIetAtKufQrI5rMvdnOgFud2irtvTiPekLIOahiG3Mj9mWW4o6QXIv77J088GQ3y3wnyz78D9N4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O34iEgwA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O34iEgwA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36A41F00A3A;
	Mon,  3 Aug 2026 14:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768198;
	bh=yC4lR9M0J9f/WG5ISp/yO1s4i9/Dqa4nmujKiSChVIY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O34iEgwA7vZJ2UbM+oftFy3iJirs9iNTpPmd50J4+YT2iC+PsNxhC49OaL/l+OjCS
	 7YPrmpZlfFpSQDCoNIwgcNK9uCc7j0l3WHGJWzaZB0dDAAZhgC5/QrcLr5Gy1/HBa1
	 c5T4WUYiJbGjiWf4HpQMv7tyPtBL1IErr/vVqNHyoMQwFmz3kxV/hxa8u5BRrQ5qrn
	 jvenLmOewFPNECFLCGBht+scbXu3qOypGACuYIYJPYnxs0xO4+l95jYU48r4aJPJ7C
	 pP5E4LJkoB3BAeVOZucKxsi0+ncYxIP47g+s5l6MX+hTevWq+3iXMss/TczQDNAcHF
	 CpUn15zBpAEtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] can: arasan-canfd: add driver for arasan CAN-FD
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jisheng Zhang" <jszhang@kernel.org>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, devicetree@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260803140531.12692-3-jszhang@kernel.org>
References: <20260803140531.12692-1-jszhang@kernel.org>
 <20260803140531.12692-3-jszhang@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 14:43:15 +0000
Message-Id: <20260803144317.A36A41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 16 potential issue=
(s) to consider:
- [Critical] Divide-by-zero kernel panic when configuring the device in sta=
ndard CAN 2.0 mode.
- [High] Off-by-one and potential negative index bypass in RX/TX queue inde=
x validation.
- [High] Uninitialized kernel stack memory is copied to the DMA buffer and =
leaked.
- [High] Missing NAPI work_done accounting on SKB allocation failure or TX =
abort causes infinite softirq loop.
- [High] Incorrect operator precedence corrupts Extended CAN IDs during rec=
eption.
- [High] Enabling NAPI after enabling hardware interrupts causes a permanen=
t stall if an interrupt fires early.
- [High] Pending NAPI poll can run concurrently with system suspend, access=
ing powered-down hardware.
- [High] Driver completely ignores CAN framework Bit Timing configurations.
- [High] Unhandled TX aborts permanently leak TX queue slots and stall tran=
smission.
- [Medium] Asynchronous pm_runtime_put() is cancelled by pm_runtime_disable=
(), leaving hardware incorrectly powered on and leaking clocks.
- [Medium] Leaking Linux internal CAN flags into hardware TX registers.
- [Medium] Inconsistent internal state transitioning when multiple bus erro=
r interrupts trigger.
- [Medium] Lockless call to netif_stop_queue on the TX error path can race =
with netif_wake_queue.
- [Medium] Missing dma_wmb() and dma_rmb() barriers when interacting with D=
MA buffers and device registers using relaxed I/O.
- [Medium] Truncation of 64-bit DMA addresses causing hardware misdirection.
- [Medium] DMA descriptors and data are processed using CPU-native byte ord=
er without endianness conversions.
--

--- Patch [2]: [PATCH 2/2] can: arasan-canfd: add driver for arasan CAN-FD =
controller ---
commit fa1764e16e0ce790d11207dabd342ce03079236b
Author: Jisheng Zhang <jszhang@kernel.org>

can: arasan-canfd: add driver for arasan CAN-FD controller

Add driver for the arasan CAN-FD controller.

> diff --git a/drivers/net/can/arasan-canfd.c b/drivers/net/can/arasan-canf=
d.c
> new file mode 100644
> index 0000000000000..63a6191f84f63
> --- /dev/null
> +++ b/drivers/net/can/arasan-canfd.c
[ ... ]
> +static int arasan_canfd_set_bittiming(struct net_device *ndev)
> +{
> +	struct arasan_canfd_priv *priv =3D netdev_priv(ndev);
> +	struct can_bittiming *bt =3D &priv->can.bittiming;
> +	struct can_bittiming *dbt =3D &priv->can.fd.data_bittiming;
> +	u32 cl_2, cl_4, fd_2, fd_4, classic_cycle, fd_cycle;
[ ... ]
> +	fd_cycle =3D priv->can.clock.freq / dbt->bitrate;

[Severity: Critical]
Can this cause a divide-by-zero crash when configuring the device in standa=
rd
CAN 2.0 mode?

When the interface is brought up without CAN FD mode enabled, the CAN frame=
work
does not populate the fd.data_bittiming structure, leaving dbt->bitrate as =
0.

> +	fd_2 =3D fd_cycle / 2;
> +	fd_4 =3D fd_cycle / 4;
> +	arasan_canfd_write(priv, LVL_FD_BAUD, fd_cycle);
> +	arasan_canfd_write(priv, LVL_ALLOWABLE_FD_JUMP, fd_2);
> +	arasan_canfd_write(priv, LVL_FD_END_OF_SYNC_SEG, fd_4);

[Severity: High]
Does this driver completely bypass the CAN framework's calculated timing
parameters?

The code derives cycle lengths directly from the clock frequency and assigns
fixed proportions for timing segments instead of using the calculated values
in bt like bt->prop_seg, bt->phase_seg1, and bt->sjw. This prevents userspa=
ce
from configuring specific sample points via netlink.

[ ... ]
> +static void arasan_canfd_err_interrupt(struct net_device *ndev, u32 isr)
> +{
[ ... ]
> +	if (isr & BUS_STATE2) {
> +		priv->can.state =3D CAN_STATE_BUS_OFF;
> +		priv->can.can_stats.bus_off++;
> +		can_bus_off(ndev);
> +		cf.can_id |=3D CAN_ERR_BUSOFF;
> +	}
> +
> +	if (isr & BUS_STATE1) {
> +		priv->can.state =3D CAN_STATE_ERROR_PASSIVE;

[Severity: Medium]
Could an independent evaluation of these states cause a lower-priority state
to overwrite a terminal state?

If the hardware latches both conditions simultaneously, the driver processes
Bus Off, but then immediately processes Error Passive and overwrites the
internal state to CAN_STATE_ERROR_PASSIVE, breaking the CAN state machine.
Should this use an else if structure?

[ ... ]
> +static void arasan_canfd_write_frame(struct net_device *ndev, struct sk_=
buff *skb, int idx)
> +{
> +	struct canfd_frame *cf =3D (struct canfd_frame *)skb->data;
> +	struct arasan_canfd_priv *priv =3D netdev_priv(ndev);
> +	struct can_tx_frame tx_frame;

[Severity: High]
Does allocating tx_frame on the stack without initializing it leak kernel
memory?

The code copies only cf->len bytes into the data array, leaving the remaind=
er
of the 64-byte array and the resv_0 field uninitialized. The entire 76-byte
structure is then copied into the DMA-mapped buffer, potentially leaking
uninitialized kernel stack data to the device.

> +	u32 *data =3D (u32 *)&tx_frame;
> +	u8 *ecc =3D priv->buf->ecc_buffer.read.tx_frames[idx];
> +	int i;
> +
> +	tx_frame.header.header0 =3D can_fd_len2dlc(cf->len);

[Severity: Medium]
Are these CPU-native bitwise operations and assignments safe on big-endian
architectures?

The DMA descriptors are populated using CPU-native types and directly copie=
d to
DMA memory. On big-endian systems, this data will be stored in big-endian
format. If the hardware expects little-endian byte ordering, it will interp=
ret
swapped bits.

> +
> +	if (cf->can_id & CAN_EFF_FLAG) {
> +		/* Extended CAN ID format */
> +		tx_frame.header.header0 |=3D TX_HEADER0_IDE;
> +		tx_frame.header.header0 |=3D FIELD_PREP(TX_HEADER0_ID,
> +				(cf->can_id & CAN_EFF_MASK) >> 18);
> +		tx_frame.header.ext_id =3D cf->can_id;

[Severity: Medium]
Does this direct assignment write Linux internal CAN flags into the hardware
descriptor?

cf->can_id contains internal flags such as CAN_EFF_FLAG and CAN_RTR_FLAG.
Writing these directly into the hardware's TX descriptor field might corrupt
hardware configuration bits. Should this be masked using CAN_EFF_MASK?

[ ... ]
> +	memcpy(tx_frame.data, cf->data, cf->len);
> +	priv->buf->r_buffer.tx_frames[idx] =3D tx_frame;
> +
> +	for (i =3D 0; i < sizeof(tx_frame) / sizeof(u32); i++)
> +		ecc[i] =3D ecc_calc(data[i]);
> +
> +	arasan_canfd_write(priv, HITXFIFO,
> +			   priv->buf_dma + offsetof(struct can_buffer, r_buffer.tx_frames[idx=
]));

[Severity: Medium]
Is a dma_wmb() barrier needed here before writing to the HITXFIFO register?

Because writel_relaxed lacks memory ordering guarantees, the CPU can reorder
the register write before the DMA memory writes complete, potentially causi=
ng
the hardware to transmit stale data.

[ ... ]
> +static netdev_tx_t arasan_canfd_start_xmit(struct sk_buff *skb, struct n=
et_device *ndev)
> +{
> +	int ret;
> +
> +	if (can_dev_dropped_skb(ndev, skb))
> +		return NETDEV_TX_OK;
> +
> +	ret =3D arasan_canfd_start_xmit_queue(skb, ndev);
> +	if (ret < 0) {
> +		netdev_err(ndev, "BUG!, TX full when queue awake!\n");
> +		netif_stop_queue(ndev);

[Severity: Medium]
Can this lockless call to netif_stop_queue race with netif_wake_queue?

If a concurrent TX completion occurs right after arasan_canfd_start_xmit_qu=
eue
releases the lock, the completion handler will free a slot and call
netif_wake_queue. This lockless netif_stop_queue could then execute,
overwriting the wake and deadlocking transmission.

> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	return NETDEV_TX_OK;
> +}
> +
> +static int arasan_canfd_tx(struct net_device *ndev, unsigned long addr)
> +{
> +	struct arasan_canfd_priv *priv =3D netdev_priv(ndev);
> +	struct net_device_stats *stats =3D &ndev->stats;
> +	int idx;
> +
> +	guard(spinlock)(&priv->tx_lock);
> +
> +	idx =3D (addr - priv->buf_dma - offsetof(struct can_buffer, r_buffer.tx=
_frames)) /
> +		sizeof(struct can_tx_frame);
> +	if (idx > CAN_MAX_TX_QUEUE)
> +		return 0;

[Severity: High]
Does this bounds check fail to protect against negative index values?

The driver calculates the signed integer idx by subtracting priv->buf_dma f=
rom
a hardware-provided address. If the hardware address is unexpectedly small,
it can cause unsigned wrap-around, resulting in a negative value when cast =
to
int. A negative value passes the idx > CAN_MAX_TX_QUEUE check.
Additionally, the check uses > instead of >=3D, so idx =3D=3D CAN_MAX_TX_QU=
EUE
passes, causing an off-by-one out-of-bounds access.

[ ... ]
> +static int arasan_canfd_rx(struct net_device *ndev, unsigned long addr)
> +{
> +	struct arasan_canfd_priv *priv =3D netdev_priv(ndev);
> +	struct net_device_stats *stats =3D &ndev->stats;
> +	struct canfd_frame *cf;
> +	struct sk_buff *skb;
> +	u32 header0, header1, header2;
> +	struct can_rx_frame *rx_frame;
> +	int idx, type;
> +
> +	idx =3D (addr - priv->buf_dma - offsetof(struct can_buffer, w_buffer.rx=
_frames)) /
> +		sizeof(struct can_rx_frame);
> +	if (idx > CAN_MAX_RX_QUEUE)
> +		return 0;

[Severity: High]
Does this bounds check have the same off-by-one and negative index bypass
issue as the TX path?

The idx calculation can produce a negative integer or exactly equal
CAN_MAX_RX_QUEUE, both of which bypass this check and lead to out-of-bounds
memory access.

[ ... ]
> +	if (type =3D=3D RX_HEADER0_TYPE_FD)
> +		skb =3D alloc_canfd_skb(ndev, &cf);
> +	else
> +		skb =3D alloc_can_skb(ndev, (struct can_frame **)&cf);
> +
> +	if (unlikely(!skb)) {
> +		stats->rx_dropped++;
> +		return 0;
> +	}

[Severity: High]
Could returning 0 on allocation failure lead to an infinite softirq loop?

In the NAPI poll loop, work_done is incremented by the return value of this
function. If this returns 0 under memory pressure, work_done is not advance=
d.
Under continuous CAN traffic, work_done will never reach quota, and the poll
loop will spin the CPU indefinitely in softirq context.

[ ... ]
> +	if (header0 & RX_HEADER0_B_EXT) {
> +		/* The received frame is an Extended format frame */
> +		cf->can_id =3D FIELD_GET(RX_HEADER1_EXTID, header1);
> +		cf->can_id |=3D (FIELD_GET(RX_HEADER0_ID_0_6, header0) |
> +				(FIELD_GET(RX_HEADER1_ID_7_10, header1) << 7) << 18);

[Severity: High]
Does faulty operator precedence corrupt the CAN ID reconstruction here?

Because the bitwise OR operator has lower precedence than the left shift
operator, the compiler evaluates this as:
A | ((B << 7) << 18)
This means the lower 7 bits of the standard ID are never shifted up by 18,
corrupting bits 0-6 instead.

[ ... ]
> +static int arasan_canfd_poll(struct napi_struct *napi, int quota)
> +{
> +	struct net_device *ndev =3D napi->dev;
> +	struct arasan_canfd_priv *priv =3D netdev_priv(ndev);
> +	u32 buf_cnt, ier;
> +	int type, work_done =3D 0;
> +	unsigned long addr;
> +
> +	while ((buf_cnt =3D arasan_canfd_read(priv, USED_BUFS_PTR_COUNT)) > 0 &&
> +	       (work_done < quota)) {
> +		addr =3D arasan_canfd_read(priv, USED_BUFS_PTR);
> +		type =3D FIELD_GET(TYPE_MASK, addr);

[Severity: Medium]
Is a dma_rmb() barrier needed here after reading USED_BUFS_PTR?

Without a read memory barrier, the CPU might reorder memory accesses and
read stale RX descriptor data in arasan_canfd_rx before the hardware has
fully written it.

> +		addr &=3D ~TYPE_MASK;
> +		switch (type) {
> +		case TYPE_RX:
> +			work_done +=3D arasan_canfd_rx(ndev, addr);
> +			arasan_canfd_write(priv, RX_PTR_BUFS, addr);
> +			break;
> +		case TYPE_TX:
> +			work_done +=3D arasan_canfd_tx(ndev, addr);
> +			break;
> +		case TYPE_TX_ABORT:
> +			netdev_err(ndev, "tx abort\n");
> +			break;

[Severity: High]
Does this TX abort case permanently leak TX queue slots?

This case does not extract the transmission index, free the socket buffer,
or reclaim the queue slot. The SKB and TX queue slot are leaked, which will
permanently stall transmission once the queue fills up. It also fails to
increment work_done, risking a softirq stall similar to the RX allocation
failure path.

[ ... ]
> +static int arasan_canfd_open(struct net_device *ndev)
> +{
[ ... ]
> +	ret =3D arasan_canfd_chip_start(ndev);
> +	if (ret < 0) {
> +		netdev_err(ndev, "arasan_canfd_chip_start failed!\n");
> +		goto err_candev;
> +	}
> +
> +	napi_enable(&priv->napi);
> +	netif_start_queue(ndev);

[Severity: High]
Does enabling NAPI after hardware interrupts are unmasked create a deadlock
window?

arasan_canfd_chip_start enables hardware interrupts. If an interrupt fires
before napi_enable is called, the ISR will mask the interrupt and schedule
a NAPI poll. Since NAPI isn't enabled yet, the poll is discarded and the
interrupt remains masked permanently.

[ ... ]
> +static void arasan_canfd_init(struct arasan_canfd_priv *priv)
> +{
[ ... ]
> +	/* setup base registers */
> +	arasan_canfd_write(priv, R_BASE_ADDR,
> +			   priv->buf_dma + offsetof(struct can_buffer, r_buffer));

[Severity: Medium]
Can this truncate a 64-bit DMA address?

priv->buf_dma can be a 64-bit address on platforms without a restricted DMA
mask, but it is written directly into a 32-bit register. If the address is
above 4GB, the hardware will be directed to the wrong memory location.

[ ... ]
> +static int arasan_canfd_suspend(struct device *dev)
> +{
> +	struct net_device *ndev =3D dev_get_drvdata(dev);
> +
> +	if (netif_running(ndev)) {
> +		netif_stop_queue(ndev);
> +		netif_device_detach(ndev);
> +		arasan_canfd_chip_stop(ndev);
> +	}
> +
> +	return pm_runtime_force_suspend(dev);
> +}

[Severity: High]
Can a pending NAPI poll run concurrently with system suspend here?

This function stops the chip but fails to call napi_disable() and disable_i=
rq()
to wait for and terminate concurrent executions. pm_runtime_force_suspend w=
ill
shut off the device clocks, meaning a concurrent NAPI poll could access pow=
ered
down hardware and cause a kernel panic.

[ ... ]
> +static int arasan_canfd_probe(struct platform_device *pdev)
> +{
[ ... ]
> +err_disableclks:
> +	pm_runtime_put(priv->dev);
> +	pm_runtime_disable(&pdev->dev);

[Severity: Medium]
Does pm_runtime_disable cancel the asynchronous suspend request?

Calling pm_runtime_disable immediately after an asynchronous pm_runtime_put
cancels the pending suspend work. This means the suspend callback is never
executed, leaving the hardware incorrectly powered on and leaking clocks.
Should this use pm_runtime_put_sync instead?

[ ... ]
> +static void arasan_canfd_remove(struct platform_device *pdev)
> +{
> +	struct net_device *ndev =3D platform_get_drvdata(pdev);
> +	struct arasan_canfd_priv *priv =3D netdev_priv(ndev);
> +
> +	unregister_candev(ndev);
> +	netif_napi_del(&priv->napi);
> +	pm_runtime_disable(&pdev->dev);

[Severity: Medium]
Does this also suffer from the cancelled asynchronous suspend issue?

unregister_candev invokes arasan_canfd_close, which performs an asynchronous
pm_runtime_put. The immediate pm_runtime_disable cancels it, again leaking
clocks and leaving the device powered on.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803140531.1269=
2-1-jszhang@kernel.org?part=3D2
