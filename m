Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD19CE54B
	for <linux-can@vger.kernel.org>; Fri, 17 Jul 2026 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306755; cv=none; b=b57Ob8c7ujf/dJJTrpdHfcPvHrDS0kkLXkt7j76cK3v6Y9K0nvCTqKlz6fiYcTe/7Ipnts77Gyj+USEnknhceJi5vgOm3HO8uVZ/eAqEdlrM5yTcJDsHsXJcxBXp4nu6rsDCf/ypRqAOHXDo5Wxy4aTOpgyPPfLCXE4EHzlPfms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306755; c=relaxed/simple;
	bh=BPcgmLOwQCfNTJa4Nf1jIOGXW/rtktjr3ehPMvVAy1k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OAWJWBC/WnSEyTOH3Bu2+padeFqxE/6ko/iZxuuT0/EhmfiaMNhBRuDV+6dqKzQJ3IS6b2VJ30xg6EB7LF4UII61T9KRmtAqAKEXU3CKqz5qfmtEFDC4PBiG0XxSWtvAethYtSgfp6on/tDdWfiqAtOQmtSnLgq+cDzbv0SMq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhbCEdx0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhbCEdx0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AD41F00A3A;
	Fri, 17 Jul 2026 16:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784306754;
	bh=zEPWcUZ4RbbRnMGBrmyjIq+dski+QBrncZ10aJlCylY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZhbCEdx0dfIQTtgD7DQE08KRmXU8qYywh4ps8sNOW+bpn97NbRfh/9BEri9ryXeu5
	 xpexei8wchnizbOHx574n/oowlE1xqeL7+o++PPtZR2H9QAsMsgubAimIR0il5zB0s
	 o+LeYxGn97+fNnYtIsg7BfH22rDrXXkvgHX+y49N6zgXAdjduEuzGN4hTVYovwQPUM
	 QFctbWzGe60lQkg6DukwHYum2hVHD479lbxa8Ig2LunzGpkMdIobSpYi2h7XCAJUCL
	 jN5QWhxOweU+j4NQkCW7tA97LwH72s2Z1AA9VjDTvcthpQocwon7QnRfMGRkfg0JKG
	 q38zXan3hcsTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 06/19] can: bcm: defer rx_op deallocation to
 workqueue to fix thrtimer UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260716155528.809908-7-mkl@pengutronix.de>
References: <20260716155528.809908-1-mkl@pengutronix.de>
 <20260716155528.809908-7-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 16:45:53 +0000
Message-Id: <20260717164554.12AD41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unprotected concurrent modification of `op->frames` in `bcm_tx_set=
up` can lead to corrupted or torn CAN frames being transmitted.
- [High] Unprotected modification of `op->frames` and `op->flags` in `bcm_r=
x_setup` races with `bcm_rx_handler` in softirq context.
- [High] The `tx_ops` and `rx_ops` lists are updated without RCU list primi=
tives, creating a data race with concurrent readers in `bcm_proc_show()`.
- [Medium] Concurrent execution of `bcm_rx_handler` on multiple CPUs causes=
 data corruption for `op->last_frames` and statistics.
--

--- Patch [6]: [PATCH net 06/19] can: bcm: defer rx_op deallocation to work=
queue to fix thrtimer UAF ---
commit 542011e18159cf5ca68d911f15d0136be9c07cb9
Author: Lee Jones <lee@kernel.org>
Subject: can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

This commit resolves a use-after-free by deferring timer cancellation and=20
memory deallocation to a dedicated unbound workqueue. It also takes a=20
reference on op->sk to ensure the socket is not freed while timers are=20
still armed.

Link: https://patch.msgid.link/20260714-bcm_fixes-v15-1-562f7e3e42da@hartko=
pp.net

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a559..bdf53241bd7b3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -1060,6 +1081,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
> =20
>  		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
>  		op->sk =3D sk;
> +		sock_hold(sk);
>  		op->ifindex =3D ifindex;

[Severity: High]
This isn't a bug introduced by this patch, but does the unprotected=20
modification of op->frames in bcm_tx_setup() allow torn CAN frames to be=20
transmitted?

When updating an existing operation, the code copies data from userspace:

bcm_tx_setup() {
    ...
    err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
    ...
}

Could a concurrent bcm_can_tx() executed by the TX timer read from=20
op->frames while the copy is happening, since the timer drops the=20
bcm_tx_lock before calling skb_put_data(skb, cf, op->cfsiz)?

[Severity: High]
This is a pre-existing issue, but does adding new elements to the ops=20
lists create a data race with concurrent readers?

When adding a new element, the setup functions call list_add():

bcm_tx_setup() {
    ...
    list_add(&op->list, &bo->tx_ops);
    ...
}

Since list_add() lacks RCU write barriers, could concurrent readers in=20
bcm_proc_show() observe torn list pointers when iterating over tx_ops=20
under rcu_read_lock()?

[ ... ]
> @@ -1221,6 +1243,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
> =20
>  		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
>  		op->sk =3D sk;
> +		sock_hold(sk);
>  		op->ifindex =3D ifindex;

[Severity: High]
This is a pre-existing issue, but can bcm_rx_setup() race with=20
bcm_rx_handler() in softirq context when modifying op->frames?

When bcm_rx_setup() updates an existing operation, it copies frame data:

bcm_rx_setup() {
    ...
    err =3D memcpy_from_msg(op->frames, msg, msg_head->nframes * op->cfsiz);
    ...
}

Since this is only protected by lock_sock() and not serialized against=20
softirq, could an incoming CAN frame trigger bcm_rx_handler()=20
concurrently, leading to inconsistent filter configurations and=20
out-of-bounds array accesses when op->nframes changes?

[Severity: Medium]
This isn't a bug introduced by this patch, but are the shared RX=20
statistics and op->last_frames vulnerable to data corruption?

If bcm_rx_handler() runs concurrently on multiple CPUs for the same=20
bcm_op, it performs non-atomic updates:

bcm_rx_handler() {
    ...
    op->frames_abs++;
    ...
    bcm_rx_update_and_send(op, op->last_frames, rxframe, traffic_flags);
    ...
}

Does modifying op->last_frames and op->frames_abs without holding a=20
spinlock allow torn writes and lost increments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716155528.8099=
08-1-mkl@pengutronix.de?part=3D6
