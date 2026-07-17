Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD70B43F0A9
	for <linux-can@vger.kernel.org>; Fri, 17 Jul 2026 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306758; cv=none; b=f25rwBLskSE1dHLpfiDiqpS5K/i2s3emKG8GzJgg/oFOXPFcctfSeDf0pEznZ2DX+mmJiOxqqQAnS5uztfVe7Atkktwm6Ib0y8lp3sOMtzv9K417WVU/YHb5Yw6merPVzc0v+8uEOemYrLi+iuIQAsZ5fLsMJARtJaX2EbmykDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306758; c=relaxed/simple;
	bh=J15VnpN7m7PFy+n97fFQdsXGBG+iAZNHn9WNAPi7f5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cw8IRLTBRUo8on7e949zcibSvUA6x7VKXZCssDzygzqqjbGXXpmb4uqa6KpDxN5aK6+k885YZSbAOsUQz5hKPYySB1d/Q+z4rlw8lBrl0hNjgoET2Am67J2m/RffoFQ5nOZybySjJrC1wrrZNiE3Mh2UWZBk/Oy6aHbg8/d178I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXDz/uhX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXDz/uhX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120711F000E9;
	Fri, 17 Jul 2026 16:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784306757;
	bh=MX6KxliItbT8+bpGmuRWKfS2e03ftu61nSzri3CMwS8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lXDz/uhX13ZB0nLORrAD+LGdRfqYgPyHznHVKwVYL2Xl/jE98n6gc0EJGZW3xnwt6
	 gi8WHsjikVE7BGZmswNxm0i9d3KtKbl8632xyrnhoVJT5W/0DK5P9gs03yYECYccEH
	 SrcJa/+0EEfjNTYiJECgfeUgXLygl9CrEZzUIOtSZaVsv/3jT/yIpVj5pcsoOYSu+T
	 N+WUlr0syHAaWFc+dTbGP7JdyktScuXL/0EaOmtwVbgrU0dAV741V7v9khSV0ju9YW
	 vH5cVJ2RUN9KY17cywKc0GLOHuGKrKILkSzKZx/1HDD04S1TjAp8qdorma8xU9vzfo
	 KxGb3HhZ4OJxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 08/19] can: bcm: add locking when updating filter
 and timer values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260716155528.809908-9-mkl@pengutronix.de>
References: <20260716155528.809908-1-mkl@pengutronix.de>
 <20260716155528.809908-9-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 16:45:56 +0000
Message-Id: <20260717164557.120711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] A race condition in bcm_can_tx's new heuristic skips the first f=
rame of a restarted multi-frame sequence if the concurrent transmission hap=
pens to be at index 0.

Pre-existing issues:
- [High] Missing payload length validation for RX_RTR_FRAME operations allo=
ws out-of-bounds memory reads when transmitting replies.
- [High] Modifying the CAN_FD_FRAME flag on an existing BCM RX operation cr=
eates a mismatch between op->flags and op->cfsiz, leading to out-of-bounds =
reads and an information leak.
--

--- Patch [8]: [PATCH net 08/19] can: bcm: add locking when updating filter=
 and timer values ---
commit c6674a9f75532d12e818868002b6c50a902d8b3e
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add locking when updating filter and timer values

This patch introduces a new per-op lock (bcm_rx_update_lock) to protect
concurrent accesses to timer and filter data during CAN traffic reception.
It also addresses race conditions related to modifying frames and ensures
consistent RTR frame preparation.

Link: https://patch.msgid.link/20260714-bcm_fixes-v15-3-562f7e3e42da@hartko=
pp.net

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index b612135b017d1..1e5f8d65d351b 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -341,14 +348,20 @@ static void bcm_can_tx(struct bcm_op *op)
>  	if (!err)
>  		op->frames_abs++;
> =20
> -	op->currframe++;
> +	/* only advance the cyclic sequence if nothing reset currframe while
> +	 * we were sending - a concurrent TX_RESET_MULTI_IDX means this
> +	 * frame's bookkeeping belongs to a sequence that no longer exists
> +	 */
> +	if (!cyclic || op->currframe =3D=3D idx) {
> +		op->currframe++;

[Severity: Medium]
Does this new heuristic skip the first frame of a restarted multi-frame
sequence if the concurrent transmission happens to be at index 0?

If a concurrent bcm_tx_setup() resets the sequence by setting
op->currframe =3D 0 while bcm_can_tx() is actively transmitting frame
index 0 (where idx =3D=3D 0), the condition will evaluate to true.
This would increment op->currframe to 1, causing the newly configured
sequence to incorrectly skip the first frame.

> -	/* reached last frame? */
> -	if (op->currframe >=3D op->nframes)
> -		op->currframe =3D 0;
> +		/* reached last frame? */
> +		if (op->currframe >=3D op->nframes)
> +			op->currframe =3D 0;

[ ... ]

> @@ -1130,6 +1173,24 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_h=
ead, struct msghdr *msg,
>  	return err;
>  }
> =20
> +static void bcm_rx_setup_rtr_check(struct bcm_msg_head *msg_head,
> +				   struct bcm_op *op, void *new_frames)
> +{
> +	/* funny feature in RX(!)_SETUP only for RTR-mode:
> +	 * copy can_id into frame BUT without RTR-flag to
> +	 * prevent a full-load-loopback-test ... ;-]
> +	 * normalize this on the staged buffer, before it is
> +	 * ever installed into op->frames.
> +	 */
> +	if (msg_head->flags & RX_RTR_FRAME) {

[Severity: High]
This is a pre-existing issue, but does bcm_rx_setup_rtr_check() fail to
validate the len field of the user-supplied RTR frame?

If a user configures an RX_RTR_FRAME operation without providing a valid
len field (for example, passing a payload length larger than the CAN limits
of 8 or 64), it appears the length goes unchecked before installation.
When a matching RTR request is received, bcm_rx_handler() will trigger
bcm_can_tx() to send this stored frame. The underlying CAN driver might
then trust the user-supplied length to read the payload from the buffer,
which could result in an out-of-bounds memory read.

> +		struct canfd_frame *frame0 =3D new_frames;
> +
> +		if ((msg_head->flags & TX_CP_CAN_ID) ||
> +		    frame0->can_id =3D=3D op->can_id)
> +			frame0->can_id =3D op->can_id & ~CAN_RTR_FLAG;
> +	}
> +}

[ ... ]

> @@ -1175,19 +1238,48 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
>  			return -E2BIG;
> =20
>  		if (msg_head->nframes) {
> -			/* update CAN frames content */
> -			err =3D memcpy_from_msg(op->frames, msg,
> +			/* get new CAN frames content before locking */
> +			new_frames =3D kmalloc(msg_head->nframes * op->cfsiz,
> +					     GFP_KERNEL);
> +			if (!new_frames)
> +				return -ENOMEM;
> +
> +			err =3D memcpy_from_msg(new_frames, msg,
>  					      msg_head->nframes * op->cfsiz);
> -			if (err < 0)
> +			if (err < 0) {
> +				kfree(new_frames);
>  				return err;
> +			}
> =20
> -			/* clear last_frames to indicate 'nothing received' */
> -			memset(op->last_frames, 0, msg_head->nframes * op->cfsiz);
> +			bcm_rx_setup_rtr_check(msg_head, op, new_frames);
>  		}
> =20
> +		spin_lock_bh(&op->bcm_rx_update_lock);
>  		op->nframes =3D msg_head->nframes;
>  		op->flags =3D msg_head->flags;

[Severity: High]
This is a pre-existing issue, but can updating an existing operation's
flags create a dangerous mismatch between op->flags and op->cfsiz?

By overwriting op->flags with the newly supplied flags while leaving
op->cfsiz at its previously configured value, the CAN_FD_FRAME state can
diverge from its statically determined allocation size.

For instance, if a user modifies an existing standard operation to include
the CAN_FD_FRAME flag, later checks like the one in bcm_rx_cmp_to_index()
might assume a larger layout and perform an out-of-bounds read past the
end of the heap-allocated op->frames buffer. Conversely, dropping the flag
could cause functions like bcm_rx_update_and_send() to copy an excessive
number of bytes from a smaller SKB buffer.

> +		if (msg_head->nframes) {
> +			/* update CAN frames content */
> +			memcpy(op->frames, new_frames,
> +			       msg_head->nframes * op->cfsiz);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716155528.8099=
08-1-mkl@pengutronix.de?part=3D8
