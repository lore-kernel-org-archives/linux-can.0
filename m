Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93EA1991CB
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503583; cv=none; b=YlW3awSvWvhIYE+Om01oIg4rImNqeKGF8GRqnCKEb93IuBJo3d9TcD6TMVX/l4stp1SRDUGqrjgwQE4+m1j7OPYt4/1LsceRG76gAi65EmT87VP0NVmWG2hkaIEE1lung8rbVMSIyJX38p0TeilrjfwkP4zxu9/tjfDEYxmUtbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503583; c=relaxed/simple;
	bh=/EvOZALmegcNwyTI1+9al7bbm0WszMsL6sV8ltv8xh8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oIAJe6XVy5+j5xmRBp9yrZ04togzzH9bpiFmm7jlWY5dxByMrQ8TSspJWdBzcuzkd/sxE/qQfEcJK7cxbYb91JWnmhKhHAQbMbTw8CiZG85+l6jY0pCQlMqYPvdKH/X6UcthE7f/B5tWhCh6uSG7lZSpHX/gPpwHP6xc+xD4W8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7XrEI5G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7XrEI5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D9C1F000E9;
	Wed,  8 Jul 2026 09:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783503581;
	bh=CZaGdVDYvsnHICrv8n3kQ28Z2qwNT2cVM5kQN0+ve0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n7XrEI5Ggzugs1sPzfv8i5Xx03/x86K5J2V3pQh6s/PKPNvA71or5vUMEwyb9f0n0
	 6C/zwSxZaRqjr1LUBfm98tQogZhF0o0mR1lIt3uJbA1rHB2lucbAbqhywkOgnpdDoH
	 nNuemYIvR88eDne+iudfhTKc6tNirdP52ZptcZb8RUzTlsPh3HErabk0Hg25w2UqDc
	 1DeCYEeIWSRSdY5qGSKAATUDtwzy+nLWBbwNzuBUOBV2T9aOp1Ji9gcxkRPcJ2h58S
	 3ZBydCYJ4mv80Z897IxQGwD99xXpK8RN+CsYeqz0wwBQRoUT5FnxgNGCBWdJ6YeNnw
	 0PwiTQWfycQLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/9] can: bcm: fix CAN frame rx/tx statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260708-bcm_fixes-v6-4-80710a2bc398@hartkopp.net>
References: <20260708-bcm_fixes-v6-0-80710a2bc398@hartkopp.net>
 <20260708-bcm_fixes-v6-4-80710a2bc398@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 09:39:40 +0000
Message-Id: <20260708093941.33D9C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The split of statistic updates across two separate spinlock crit=
ical sections in bcm_rx_handler allows frames_filtered to persistently exce=
ed frames_abs after a counter reset, breaking their invariant and causing n=
egative reduction percentages.

Pre-existing issues:
- [High] Concurrent, lockless updates to op->rx_stamp and op->rx_ifindex in=
 bcm_rx_handler() cause data races and potential torn writes.
--

--- Patch [4]: [PATCH v6 4/9] can: bcm: fix CAN frame rx/tx statistics ---
commit fb8c8dc88e31fc268389c46d858c779a051a866c
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix CAN frame rx/tx statistics

KCSAN detected a data race within the bcm_rx_handler() when two CAN frames
have been simultaneously received and processed in a single rx op by two
different CPUs.

Use atomic operations with (signed) long data types to access the
statistics in the hot path to fix the KCSAN complaint.

Additionally simplify the update and check of statistics overflow by
using the atomic operations in a separate bcm_update_stats() function and
put this function under bcm_rx_update_lock to prevent races when resetting
the counters.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index af4bb4182bc29..340b7fc89744e 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -497,12 +510,9 @@ static void bcm_rx_changed(struct bcm_op *op, struct=
 canfd_frame *data)
>  {
>  	struct bcm_msg_head head;
> =20
> -	/* update statistics */
> -	op->frames_filtered++;
> -
> -	/* prevent statistics overflow */
> -	if (op->frames_filtered > ULONG_MAX/100)
> -		op->frames_filtered =3D op->frames_abs =3D 0;
> +	/* update statistics (frames_filtered <=3D frames_abs) */
> +	if (atomic_long_read(&op->frames_abs))
> +		atomic_long_inc(&op->frames_filtered);

[Severity: Medium]
With the statistic updates now split across two separate lock regions in
bcm_rx_handler(), is it possible for frames_filtered to exceed frames_abs?

If Thread A calls bcm_update_stats() in the first lock region and triggers
the counter reset, then releases the lock, could Thread B interleave and
increment frames_abs to 1 before Thread A reaches the second lock region?

When Thread A subsequently calls bcm_rx_changed() in the second lock region,
it would observe frames_abs =3D=3D 1 and increment frames_filtered (for the
frame that already caused the reset).

If Thread B then enters the second lock region and also increments
frames_filtered, wouldn't frames_filtered become larger than frames_abs?

When read by bcm_proc_show(), would this cause the reduction calculation
(100 - (frames_filtered * 100) / frames_abs) to yield a negative percentage?

[ ... ]

> @@ -748,16 +758,19 @@ static void bcm_rx_handler(struct sk_buff *skb, voi=
d *data)
>  	op->rx_stamp =3D skb->tstamp;
>  	/* save originator for recvfrom() */
>  	op->rx_ifindex =3D skb->dev->ifindex;
> -	/* update statistics */
> -	op->frames_abs++;
> =20
> -	/* snapshot the flag under lock: op->flags/op->frames may be updated
> -	 * concurrently by bcm_rx_setup().
> +	/* snapshot RTR content under lock: op->flags/op->frames may be
> +	 * updated concurrently by bcm_rx_setup().
>  	 */
>  	spin_lock_bh(&op->bcm_rx_update_lock);

[Severity: High]
This isn't a bug introduced by this patch, but since bcm_rx_handler() can be
executed concurrently on multiple CPUs for the same bcm_op, can these lockl=
ess
updates to op->rx_stamp (a 64-bit ktime_t) and op->rx_ifindex cause data ra=
ces?

If so, could this lead to torn writes on 32-bit platforms, causing corrupted
timestamps and interface indices to be sent to userspace?

> +
> +	/* update statistics with lock analogue to bcm_rx_changed() callers */
> +	bcm_update_stats(op);
> +
>  	rtr_frame =3D op->flags & RX_RTR_FRAME;
>  	if (rtr_frame)
>  		memcpy(&rtrframe, op->frames, op->cfsiz);
> +
>  	spin_unlock_bh(&op->bcm_rx_update_lock);
> =20
>  	if (rtr_frame) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v6-0-80710a2bc398@hartkopp.net?part=3D4
