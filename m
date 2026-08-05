Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5258F3F075A
	for <linux-can@vger.kernel.org>; Wed,  5 Aug 2026 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920990; cv=none; b=OkGf9i0eEqYKp4awhaEnaX6dD9/teHXabfrZ8LB0tAKsq6lyY7AZlCvUpKZFFE1XNszcHLIw3dsxNglAAHNoayusru9Pdz8v6prd7VONUVYn0jJkM8AWFw0G0E9bJxIxnkbNlw0/U69EcykCwAFaXts4Fe/ygHWbHBNimINscr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920990; c=relaxed/simple;
	bh=MZhdf42hriZ9mlt8WpNCLJDNzJIHqDnROpuqOHz2uwU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rTMT6HJeV+yKz2ff5zrIJ2wU2Tqv566A2olcPyV+Tm7Dq8MxMv9rqfTgZckc8ZTSDG1iJG/np2Oek+9N/y6Pc+U6eRDUzYB3YrqwySS255OQQdzg/ivP+P3BfrG0qgnZjEuMO2bBo8+VklK/QD2BEooix9VwBUPgArCu5Ie7BvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSQXjhQQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSQXjhQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320891F000E9;
	Wed,  5 Aug 2026 09:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785920988;
	bh=xINUjkZgtlh9Hn890LbeNXqywHeQpZfKYcLZ0ShDqhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KSQXjhQQw3Ma5OV5rObn0oD8UPdAbWejrhanpZZ0rjCOJEKoToMNMqdMgsOg9E2eh
	 2UR80o39r1Whoc3Ad1I1dWJei8wuV3Px2Mu1lzCL80a3K4Whf+5+tTOPEwqcE4uOBl
	 NMZGGhkghvMv+YGx3O5pmUqeq/C4RFtQmBPyfY8oIVPTWmEa9S8SBfAapDE4DK4viz
	 pAZQ5HLPWsaZRvj/qIXKGmVxceyETnyjl67qWsNZTuqOrJMXuCJOwXfRxSAuW4Lx+6
	 /r5kEPtSwZ1c2N/nCna1k8atPgwbFhLikhZTsVfOAiVK/5eYmFjHheQLLHFJrtU/KA
	 eZnc5+GKvoo2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/2] can: Add Loongson CAN-FD controller driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Binbin Zhou" <zhoubinbin@loongson.cn>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <197f2d234153e77ce980d7cf28624cce1ce842a2.1785898181.git.zhoubinbin@loongson.cn>
References: <cover.1785898181.git.zhoubinbin@loongson.cn>
 <197f2d234153e77ce980d7cf28624cce1ce842a2.1785898181.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 09:09:47 +0000
Message-Id: <20260805090948.320891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Out-of-bounds write in RX path when handling classical CAN 2.0=
 frames with unusually large length values.
- [High] Returning -EAGAIN on invalid RX frames leaves the hardware FIFO bl=
ocked, causing permanent desynchronization and an interrupt storm.
- [High] The driver uses undefined lowercase `field_get()` and `field_prep(=
)` macros, and dynamic masks would break the build even with standard bitfi=
eld macros.
- [High] TX interrupt handler clears the interrupt status conditionally and=
 at the wrong time, causing lost interrupts and infinite loops.
- [High] Explicitly clearing the error interrupt status at the end of `loon=
gson_canfd_err_interrupt()` creates a race condition.
- [High] Incorrect logic in `loongson_canfd_txbuf_freed()` artificially lim=
its the 8-buffer hardware TX ring to a queue depth of 1.
- [Medium] The driver mutates the netlink-provided `can_bittiming` structur=
e during hardware calculation.
- [Medium] Directly casting the byte array payload to a 32-bit pointer for =
regmap access reverses the byte order on Big Endian systems.
--

--- Patch [1]: [PATCH v7 1/2] can: Add Loongson CAN-FD controller driver ---
commit 8ea91a6644d61e09bfa3d704e0a569716fdc82b2
Author: Binbin Zhou <zhoubinbin@loongson.cn>
Subject: can: Add Loongson CAN-FD controller driver

This commit adds a new network device driver for the Loongson CAN-FD
controller found in Loongson-2K SoCs. The driver supports CAN 2.0, CAN-FD,
loopback, and various other controller modes, using NAPI for receive and
offering TX echo support.

> diff --git a/drivers/net/can/loongson_canfd.c b/drivers/net/can/loongson_=
canfd.c
> index 0000000000000..dbb8bd434080a
> --- /dev/null
> +++ b/drivers/net/can/loongson_canfd.c
> @@ -462,11 +462,4 @@
> static bool loongson_canfd_txbuf_freed(struct loongson_canfd_priv *priv)
> {
> 	return !regmap_test_bits(priv->regmap, LOONGSON_CANFD_TX_STAT, REG_TX_ST=
AT_BRP);
> }

[Severity: High]
Does this logic artificially limit the 8-buffer hardware TX ring to a queue
depth of 1?

Since regmap_test_bits() returns true if any bits in REG_TX_STAT_BRP are se=
t,
the negation here returns true only when all 8 buffers are perfectly idle.

This would cause loongson_canfd_start_xmit() to prematurely stop the queue
and falsely drop frames when even a single buffer is transmitting:

loongson_canfd_start_xmit() {
    ...
	if (unlikely(!loongson_canfd_txbuf_freed(priv))) {
		netif_stop_queue(ndev);
		netdev_err(ndev, "BUG!, no TXB free when queue awake!\n");
		return NETDEV_TX_BUSY;
	}
    ...
}

[ ... ]

> @@ -484,10 +484,7 @@
> static enum loongson_canfd_txbuf_sts
> loongson_canfd_get_txbuf_sts(struct loongson_canfd_priv *priv, u8 buf_id)
> {
> 	u32 sts, mask;
>=20
> 	mask =3D REG_TX_STAT_BS_TX_MASK_BASE << 2 * buf_id;
> 	regmap_read(priv->regmap, LOONGSON_CANFD_TX_STAT, &sts);
>=20
> 	return field_get(mask, sts);
> }

[Severity: High]
Can this compile successfully?

The driver uses an undefined lowercase field_get() macro here, and a lowerc=
ase
field_prep() in loongson_canfd_set_txbuf_cmd().

Even if corrected to the standard FIELD_GET() and FIELD_PREP() macros, the
build will still fail. The bitfield macros enforce a build bug check requir=
ing
the mask to be a compile-time constant, but here the mask is dynamically
derived from the runtime variable buf_id.

[ ... ]

> @@ -711,27 +711,10 @@
> static void loongson_canfd_set_btr(struct net_device *ndev, struct can_bi=
ttiming *bt, bool nominal)
> {
> 	struct loongson_canfd_priv *priv =3D netdev_priv(ndev);
> 	u32 ph1_max =3D FIELD_MAX(REG_BTR_PH1);
> 	u32 btr =3D 0;
>=20
> 	/*
> 	 * The timing calculation functions have only constraints on tseg1,
> 	 * which is prop_seg + phase1_seg combined.
> 	 * tseg1 is then split in half and stored into prog_seg and phase_seg1.
> 	 * In Loongson CAN-FD, PROP is 7 bits wide but PH1 only 6, so we must
> 	 * re-distribute the values here.
> 	 */
> 	if (bt->phase_seg1 > ph1_max) {
> 		bt->prop_seg +=3D bt->phase_seg1 - ph1_max;
> 		bt->phase_seg1 =3D ph1_max;
> 	}

[Severity: Medium]
Does this mutate the netlink-provided can_bittiming structure?

By directly modifying bt->prop_seg and bt->phase_seg1 via the bt pointer, t=
he
driver modifies the shared persistent structure (priv->can.bittiming or
priv->can.fd.data_bittiming) instead of a local copy.

This can corrupt the core CAN state visible to userspace, leading to incorr=
ect
calculations on subsequent interface restarts.

[ ... ]

> @@ -985,41 +985,15 @@
> static bool loongson_canfd_insert_frame(struct loongson_canfd_priv *priv,
> 					const struct canfd_frame *cf, u8 buf, bool isfdf)
> {
[ ... ]
> 	/* Write Data payload */
> 	for (unsigned int i =3D 0; i < cf->len; i +=3D LOONGSON_CANFD_DW_BYTE) {
> 		regmap_write(priv->regmap,
> 			     LOONGSON_CANFD_TX_DATA_1 + LOONGSON_CANFD_FRAME_DB_1 + i,
> 			     *(u32 *)(cf->data + i));
> 	}
>=20
> 	return true;
> }

[Severity: Medium]
Will this silently corrupt the CAN frame payload on big endian architecture=
s?

Directly casting the byte array payload to a 32-bit pointer reverses the by=
te
order when the host-endian u32 is written out on big endian systems.

This also violates strict aliasing rules. The same issue appears in the
receive path in loongson_canfd_rx().

[ ... ]

> @@ -1114,64 +1114,14 @@
> static int loongson_canfd_rx(struct net_device *ndev)
> {
[ ... ]
> 	/* Number of characters received */
> 	rwcnt =3D FIELD_GET(REG_FRAME_META1_RWCNT, meta1);
> 	if (rwcnt < 2)
> 		return -EAGAIN;
>=20
> 	dbcnt =3D (rwcnt - 2) * LOONGSON_CANFD_DW_BYTE;
> 	if (dbcnt > CANFD_MAX_DLEN)
> 		return -EAGAIN;

[Severity: High]
Does returning -EAGAIN here leave the hardware FIFO permanently blocked?

Since the first two meta words were already popped from the FIFO via
regmap_read(), returning without draining the remaining payload words leaves
the hardware FIFO completely out of sync.

This can lead to a permanent device lockup and an endless interrupt
NAPI storm.

[ ... ]

> 	/* Flexible Data-rate Format */
> 	is_can_fd =3D !!(meta1 & REG_FRAME_META1_FDF);
> 	if (is_can_fd) {
> 		skb =3D alloc_canfd_skb(ndev, &cfd);
> 	} else {
> 		skb =3D alloc_can_skb(ndev, &ccf);
> 		cfd =3D (struct canfd_frame *)ccf;
> 	}
[ ... ]
> 	/* Copy payload */
> 	for (i =3D 0; i < dbcnt; i +=3D LOONGSON_CANFD_DW_BYTE)
> 		regmap_read(priv->regmap, LOONGSON_CANFD_RX_DATA, (u32 *)(cfd->data + i=
));

[Severity: Critical]
Can this loop cause an out-of-bounds write if a classical CAN 2.0 frame is
received with an unusually large length?

If a corrupted bus frame or hardware glitch causes a classical CAN 2.0 frame
to have an rwcnt indicating more than 2 payload words, alloc_can_skb() will
only allocate an 8-byte data buffer.

However, the loop will blindly copy up to 64 bytes into cfd->data, corrupti=
ng
skb_shared_info and adjacent memory.

[ ... ]

> @@ -1275,103 +1275,14 @@
> static void loongson_canfd_err_interrupt(struct net_device *ndev, u32 isr)
> {
[ ... ]
> 	if (skb)
> 		netif_rx(skb);
>=20
> 	regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, mask);
> 	regmap_write(priv->regmap, LOONGSON_CANFD_INT_MASK, mask << 16);
> }

[Severity: High]
Does explicitly clearing the error interrupt status here create a race
condition?

The main handler loongson_canfd_interrupt() already correctly clears error
interrupts before calling this function. Redundantly writing the mask back =
to
LOONGSON_CANFD_INT_STAT at the very end of this function creates a window f=
or
lost interrupts.

Any new error asserted by the hardware during the execution of this handler
will be instantly cleared and ignored, dropping crucial events like bus-off
or arbitration lost.

[ ... ]

> @@ -1480,59 +1480,17 @@
> static void loongson_canfd_tx_interrupt(struct net_device *ndev)
> {
[ ... ]
> 		loongson_canfd_set_txbuf_cmd(ndev, TXT_CMD_SR_CLEAN, buf_id);
> 	}
>=20
> 	/*
> 	 * If no buffers were processed this time, we cannot clear - that would =
introduce
> 	 * a race condition.
> 	 */
> 	if (processed) {
> 		/*
> 		 * Clear the interrupt again. We do not want to receive again interrupt
> 		 * for the buffer already handled. If it is the last finished one then
> 		 * it would cause log of spurious interrupt.
> 		 */
> 		regmap_write(priv->regmap, LOONGSON_CANFD_INT_STAT, REG_INT_STAT_TXBHCI=
);
> 	}
>=20
> 	/* Check if at least one TX buffer is free */
> 	if (loongson_canfd_txbuf_freed(priv))
> 		netif_wake_queue(ndev);
> }

[Severity: High]
Does conditionally clearing the interrupt status at the end lead to lost
interrupts or infinite loops?

If a new TX buffer completes after its buf_id is checked in the loop, but
before the end of the function, the regmap_write unconditionally clears
REG_INT_STAT_TXBHCI, erasing the new completion notification.

Additionally, if the handler runs but no buffers are ready (processed is
false), the interrupt status is never cleared. This will cause
loongson_canfd_interrupt() to loop repeatedly and potentially shut down the
device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785898181.gi=
t.zhoubinbin@loongson.cn?part=3D1
