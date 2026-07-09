Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907194DB56B
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620631; cv=none; b=lsUYtQbmVh3lbieiN+I+xMaIdahUaXOAntbm2kOKYm9wU1J+3DGHX68yENS9ET79nltfrpO4Uu9rDXEJvJ5Hdr9NyFlVIbiUgSxUuNsqSurjznrMVs3BkZiKgQXB0ctC9lR8EpBfNvU7ub3Hkhh3zzn/vinEE/b33EATbwvHvTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620631; c=relaxed/simple;
	bh=/WxjYUr0Bb8LaDQ3wVVHbgOdtOD137xW6Pg5EgKxEpY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=op+cdbfyLEto7cNYNEAo72qXocwC9BEjB2Fxa+ri8NOJxIPohpqJfgAHVnLCgUo7642BcVY4PqpX7zgwQaSV0SH4BAZrWBcW4ZgQacw/5yv5/NCbTo2au6Wb1GKMeEX/DgNpsPzkQ56AjVZDxZJx0hzxZOATTKTRk5DOQbT22Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nj5hBalG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nj5hBalG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEC31F000E9;
	Thu,  9 Jul 2026 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783620630;
	bh=CRyoVJwjD2g5oJhg/LP/CCpMe6ljCb5T2RYVqawKvI4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nj5hBalGQYt3Gdw2x6JeZLLVONtWo3fP4jie2OwpxgXinRtjq/w9gOSgmAZcKN8PB
	 i7dHiFmbGIjhLQG3oEpGRUbOjAfQ8DsrOV2NFr51nf1nyToXR4YvsiPQk7BnmZfZUe
	 yWJMpwFcdLzfZ1czu5WgvapABy+TKFzALqylLQecWxWninR0Bsqm+zG7Pac4+FU2rY
	 MBworfK+5i0CP9aCBLIMTFvI/ZJHwy+LA/LM+lqg6J/OONrCfbec8UYUJvhpix2LVo
	 ffTF8h6hx39o91FEhM+Zt6OgpJN4Iuj5q9aN1V7lrJBTT7lNFXediCgzwr++WeW1BI
	 rg3klaVrAtVNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 01/11] can: bcm: defer rx_op deallocation to
 workqueue to fix thrtimer UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260709-bcm_fixes-v11-1-067ba11bec5c@hartkopp.net>
References: <20260709-bcm_fixes-v11-0-067ba11bec5c@hartkopp.net>
 <20260709-bcm_fixes-v11-1-067ba11bec5c@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 18:10:29 +0000
Message-Id: <20260709181029.CAEC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race when updating CAN frames of an existing BCM RX operation
- [High] Missing RCU list primitives causes data races with lockless procfs=
 readers
--

--- Patch [1]: [PATCH v11 01/11] can: bcm: defer rx_op deallocation to work=
queue to fix thrtimer UAF ---
commit ae7bb166ff5dbe1bb7ad111fcf67c490882f4b51
Author: Lee Jones <lee@kernel.org>
can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

This commit fixes a thrtimer UAF during BCM RX operation teardown by
deferring timer cancellation and memory deallocation to a dedicated unbound
workqueue. It also retains a reference on op->sk until the deferred work
completes to ensure the socket is not freed prematurely.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index a4bef2c48a559..bdf53241bd7b3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1221,6 +1243,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
> =20
>  		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
>  		op->sk =3D sk;
> +		sock_hold(sk);
>  		op->ifindex =3D ifindex;
> =20
>  		/* ifindex for timeout events w/o previous frame reception */

[Severity: High]
This is a pre-existing issue, but does bcm_rx_setup() have a data race when
updating CAN frames for an existing BCM RX operation?

It appears memcpy_from_msg() copies directly from user space into op->frames
without holding op->bcm_rx_update_lock or using a staging buffer:

net/can/bcm.c:bcm_rx_setup() {
    ...
    err =3D memcpy_from_msg(op->frames, msg, msg_head->nframes * op->cfsiz);
    ...
    memset(op->last_frames, 0, msg_head->nframes * op->cfsiz);
    ...
}

Since memcpy_from_msg() can sleep, it cannot hold the lock, but this means
concurrent softirq readers like bcm_rx_handler() might observe partially
updated filter masks:

net/can/bcm.c:bcm_rx_handler() {
    ...
    if ((get_u64(op->frames, 0) & get_u64(rxframe, 0)) =3D=3D
    ...
}

Could this lead to valid CAN frames being incorrectly dropped or invalid
frames accepted?

[Severity: High]
This is a pre-existing issue, but does bcm_rx_setup() lack proper RCU list
primitives when inserting into bo->rx_ops?

It currently uses the non-RCU list_add() during setup:

net/can/bcm.c:bcm_rx_setup() {
    ...
    list_add(&op->list, &bo->rx_ops);
    ...
}

This lacks the smp_store_release() barrier needed for concurrent lockless
readers. For instance, bcm_proc_show() iterates these lists locklessly
under rcu_read_lock(), but it uses list_for_each_entry() instead of
list_for_each_entry_rcu():

net/can/bcm.c:bcm_proc_show() {
    ...
    list_for_each_entry(op, &bo->tx_ops, list) {
    ...
}

Can this lack of memory ordering and dependency barriers allow the compiler
to generate unsafe traversals, potentially leading to a NULL pointer
dereference or invalid list traversal for concurrent procfs readers of
/proc/net/can-bcm/*?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v11-0-067ba11bec5c@hartkopp.net?part=3D1
