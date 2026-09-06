Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E93347505
	for <linux-can@vger.kernel.org>; Sun,  6 Sep 2026 22:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788734176; cv=none; b=h4LcHt5C2oG46hzAKw5FnUI0JdpWr8GxB4ZqxB6tHWPsnxJnmsSUKVSJQqTg16lZMSlmDAz6QOo32Sl5TsCwK0O04KU16c5V5vsSlGAS4+84UlHDiMq9wnYrvX7PRGYtVhlbSTffjeSkv0JaqnBdeAST3WmDQTpH5wkBpSWl7vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788734176; c=relaxed/simple;
	bh=bkLeCWX+TxCMf1WAMT1uuip9b7yHUHtNGjuLkAQuUBQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cfbdBhWRhqVK/AGEp6uWryi1Bcyx7/XvHcH5zDVjz4TPt/M92/03Szu8+SEfYTMWyZmFKACfj3qCEG+ns9+PUFOO76twJB2g3O3un5CWDPAwE5E9Yq30HA3RQouu/UID224C0eOxa7CcfoHj1O3qoL1YGrEy8loFtn+/BL8fa9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adFd/jiK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adFd/jiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1CD1F00A3A;
	Sun,  6 Sep 2026 22:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788734172;
	bh=Mrm4KtAGOeAZfzRw7z9M9RXioa0GgY1z7gruUP07SQo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=adFd/jiK+891fjM5+k+yQzNMa74TGiVVrXx9IxzT5N3WBUmqRWnvIlmLQgjZ+FOLS
	 uY71yRNmr2P9CjgZXYg/OnfiYULkZb7yK5jWfGGl43Frw0cMV28NRorcOSLwUvix3A
	 WdhMH5j8+WYMyrFZkdZX4IQssl+xYiUL0+dhTWEEG3PgadiXKtpQmFd7I+6RXg8KRf
	 a7bspbySg6Qkl7TRDUjwLlL1GB6HSo2F6XS7MZAQa9roq4p9bQiICeQH4ibClLCG5p
	 A7rvpRGT7wNf5bMdFYp65XoHW/FBmBE4glf6CNa+nR4Qi0dD+Ldl2M0/vv7/+a7q9Y
	 boPVWhs1+gbqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] can: peak_usb: fix slab-out-of-bounds read in
 pcan_usb_handle_bus_evt()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiang Mei" <xmei5@asu.edu>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260906222132.3850994-1-xmei5@asu.edu>
References: <20260906222132.3850994-1-xmei5@asu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 22:36:11 +0000
Message-Id: <20260906223611.CC1CD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The main message decoding loop in `pcan_usb_decode_msg()` and the =
data decoding in `pcan_usb_decode_data()` lack proper bounds checks, leadin=
g to slab-out-of-bounds reads on maliciously crafted or malformed USB packe=
ts.
- [High] The decoding loop in `pcan_usb_pro_decode_buf()` is vulnerable to =
an out-of-bounds read because it dereferences `rec_ptr` before verifying th=
at the pointer is within the buffer boundaries.
- [High] The `restart_timer` and unanchored restart URB are not cancelled d=
uring device disconnect, leading to a Use-After-Free.
- [High] Uninitialized kernel stack memory is sent to the USB device in `pc=
an_usb_set_bittiming` and `pcan_usb_set_can_channel_id`.
- [High] Casting a byte array on the stack to `__le32 *` can cause unaligne=
d memory access exceptions on some architectures.
--

commit 5da73d58a5b6f6aab2dab8be2879ad21991bb88d
Author: Xiang Mei <xmei5@asu.edu>

can: peak_usb: fix slab-out-of-bounds read in pcan_usb_handle_bus_evt()

This commit fixes a slab-out-of-bounds read in pcan_usb_handle_bus_evt() by
checking that mc->ptr + 3 does not exceed mc->end before accessing the rxerr
and txerr counters.

Closes: https://lore.kernel.org/linux-can/upsCxxaJjg2FJWhfCx6KjFXLlh8o4IhaH=
KJi@bugs.sh/

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/us=
b/peak_usb/pcan_usb.c
> index 8fd058c328564..e87ed7657cc1b 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -558,6 +558,8 @@ static int pcan_usb_handle_bus_evt(struct pcan_usb_ms=
g_context *mc, u8 ir)
>  	switch (ir) {
>  	case PCAN_USB_ERR_CNT_DEC:
>  	case PCAN_USB_ERR_CNT_INC:
> +		if ((mc->ptr + 3) > mc->end)
> +			return -EINVAL;
> =20
>  		/* save rx/tx error counters from in the device context */
>  		pdev->bec.rxerr =3D mc->ptr[1];

While reviewing this patch, I noticed some other pre-existing issues in this
driver.

This is a pre-existing issue, but does pcan_usb_decode_msg() also lack prop=
er
bounds checks when reading from mc.ptr?

drivers/net/can/usb/peak_usb/pcan_usb.c:pcan_usb_decode_msg() {
	...
	for (err =3D 0; mc.rec_idx < mc.rec_cnt && !err; mc.rec_idx++) {
		u8 sl =3D *mc.ptr++;
	...
}

[Severity: High]
Does this code dereference mc.ptr without verifying that it has not exceeded
mc.end? If a malicious USB device sends a packet with rec_cnt set larger th=
an
the available data, could this lead to a slab-out-of-bounds read?

Similarly, in pcan_usb_decode_data():

drivers/net/can/usb/peak_usb/pcan_usb.c:pcan_usb_decode_data() {
	...
		/* Ignore next byte (client private id) if SRR bit is set */
		if (can_id_flags & PCAN_USB_TX_SRR)
			mc->ptr++;
	...
}

[Severity: High]
Can this pointer increment bypass previous bounds checks and push the point=
er
past the buffer's end for the next iteration?

This is a pre-existing issue, but does pcan_usb_pro_decode_buf() have a
similar out-of-bounds read vulnerability?

drivers/net/can/usb/peak_usb/pcan_usb_pro.c:pcan_usb_pro_decode_buf() {
	...
	for (; rec_cnt > 0; rec_cnt--) {
		union pcan_usb_pro_rec *pr =3D (union pcan_usb_pro_rec *)rec_ptr;
		u16 sizeof_rec =3D pcan_usb_pro_sizeof_rec[pr->data_type];
	...
}

[Severity: High]
Could this read the data_type field from memory before checking if rec_ptr =
is
within msg_end? If previous records exactly consume the buffer, could this
read past the end of the buffer?

This is a pre-existing issue, but is the restart_timer and unanchored resta=
rt
URB properly cancelled during device disconnect?

drivers/net/can/usb/peak_usb/pcan_usb.c:pcan_usb_restart_async() {
	...
	return usb_submit_urb(urb, GFP_ATOMIC);
}

drivers/net/can/usb/peak_usb/pcan_usb.c:pcan_usb_restart_pending() {
	...
	mod_timer(&pdev->restart_timer,
			jiffies + msecs_to_jiffies(PCAN_USB_STARTUP_TIMEOUT));
	...
}

drivers/net/can/usb/peak_usb/pcan_usb.c:pcan_usb_restart() {
	...
	struct pcan_usb *pdev =3D timer_container_of(pdev, t, restart_timer);
	...
}

[Severity: High]
Does this unanchored URB and uncancelled timer lead to a Use-After-Free if
the device is disconnected? Since the URB is not anchored to
dev->tx_submitted, the disconnect path won't kill it, and the timer could
fire and access freed memory.

This is a pre-existing issue, but do pcan_usb_set_bittiming() and
pcan_usb_set_can_channel_id() leak uninitialized stack memory to the USB
device?

drivers/net/can/usb/peak_usb/pcan_usb.c:pcan_usb_set_bittiming() {
	u8 args[PCAN_USB_CMD_ARGS_LEN];
	...
	args[0] =3D btr1;
	args[1] =3D btr0;

	return pcan_usb_send_cmd(dev, PCAN_USB_CMD_BITRATE, PCAN_USB_SET, args);
}

drivers/net/can/usb/peak_usb/pcan_usb.c:pcan_usb_set_can_channel_id() {
	u8 args[PCAN_USB_CMD_ARGS_LEN];
	...
	args[0] =3D can_ch_id;
	return pcan_usb_send_cmd(dev, PCAN_USB_CMD_DEVID, PCAN_USB_SET, args);
}

[Severity: High]
Are these args arrays passed to pcan_usb_send_cmd() without being fully
zero-initialized? Could this leak up to 13 bytes of uninitialized kernel
stack memory per command?

This is a pre-existing issue, but does pcan_usb_get_serial() cast an
unaligned byte array to a 4-byte integer pointer?

drivers/net/can/usb/peak_usb/pcan_usb.c:pcan_usb_get_serial() {
	u8 args[PCAN_USB_CMD_ARGS_LEN];
	...
	err =3D pcan_usb_wait_rsp(dev, PCAN_USB_CMD_SN, PCAN_USB_GET, args);
	if (err)
		return err;
	*serial_number =3D le32_to_cpup((__le32 *)args);
	...
}

[Severity: High]
Does casting this 1-byte aligned stack array to an unaligned __le32 pointer
cause alignment traps on architectures with strict alignment requirements?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906222132.3850=
994-1-xmei5@asu.edu?part=3D1
