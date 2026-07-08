Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29C7372B32
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524976; cv=none; b=M/tW1cPLeJHmODFeqSdDDJzkC2bzWeP0SJTxzrF0bYg4SKWpqvVLw8+JKHBkeIYvjTd04R8IeiadVf2eMWN9W76QTaXNimq+af3mC+kcDKOfky37b2Ac75jLvma/0B92P0ERt9S+sO31rzL6+0MHCBHDLN0KOeNH03rQSEpaOS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524976; c=relaxed/simple;
	bh=d1bmvjgomWLSnauxG+1xOPpziFkjiPLRB+zCQT7BZEE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ICL7mUL5zjDXqPes/BMvNS1jhBrtADeJMyeSWil4wl414A9BebmZlrp8U2dfIEsyzQrq9KrAXB20mtjmqan1eTRxL2ahjB75yYUW6DyFCX0lUHrNACZJiKQXX44wVMExh59/2l8m71sz7+sajveeBWJXvuPGhTh6/in6l3D3gj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFEahhcG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFEahhcG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C01E1F00A3A;
	Wed,  8 Jul 2026 15:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783524974;
	bh=iU/dD9yHEfY98Zs1/mMh8gEhWhIhme7++wvDzcYYNkQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cFEahhcGSnRxz8sM6xCl8eluIs1bz9Io3Py22eyo9g/arFeA2trpgLLw7xEp1u6g9
	 UBygiMUnzYbHjzEjCpflaYai2IoeD3PCjV57c0e+lV5uvJ3c++EVWsKvaMnFvbGeql
	 08ThVJ5jeYXDKgRoueAqJO/KzPK6ELgbFwK6CSOp9DwDfRsiKrHlR8QDUOeV7DYIpo
	 5KhSJxWB4xoi+MI2LWxviALX1ObsJ15PPBAR6rTAC5ggGXA9KAZhV2OV91szGcAhD5
	 fzrOG1r6poExXyHK7vMbSZL17R+KFZLtLFH5ViMnisMro4PlOfzUStLxeibHb7KIcy
	 MJLPKFeHbLVYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/10] can: bcm: defer rx_op deallocation to
 workqueue to fix thrtimer UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260708-bcm_fixes-v7-1-c78896b342e4@hartkopp.net>
References: <20260708-bcm_fixes-v7-0-c78896b342e4@hartkopp.net>
 <20260708-bcm_fixes-v7-1-c78896b342e4@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 15:36:13 +0000
Message-Id: <20260708153614.4C01E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent lockless access to op->frames and metadata between proc=
ess context setups (bcm_rx_setup / bcm_tx_setup) and softirq handlers (bcm_=
rx_handler / bcm_can_tx).
--

--- Patch [1]: [PATCH v7 01/10] can: bcm: defer rx_op deallocation to workq=
ueue to fix thrtimer UAF ---
commit a3f554e14b7943cd3930531fdd91052fab6a02ca
Author: Lee Jones <lee@kernel.org>

can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

This commit resolves a use-after-free issue when tearing down BCM RX
operations by deferring the cancellation of timers and memory deallocation
to a dedicated workqueue. It also takes a reference on the socket to ensure
it is not freed while timers are still armed.

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

[Severity: High]
This is a pre-existing issue, but does bcm_tx_setup() overwrite op->frames
directly from userspace without holding bcm_tx_lock?

When updating an existing operation, bcm_tx_setup() appears to do:

    /* update CAN frames content */
    for (i =3D 0; i < msg_head->nframes; i++) {
        cf =3D op->frames + op->cfsiz * i;
        err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);

While concurrently, bcm_can_tx() drops the lock before dereferencing a
pointer into op->frames:

    /* read currframe under lock protection */
    spin_lock_bh(&op->bcm_tx_lock);
    cf =3D op->frames + op->cfsiz * op->currframe;
    spin_unlock_bh(&op->bcm_tx_lock);
    ...
    skb_put_data(skb, cf, op->cfsiz);

Can this allow a concurrent bcm_tx_setup() on another CPU to overwrite the
frames, leading to the transmission of partially updated (torn) CAN frames?

>  		op->ifindex =3D ifindex;
> =20
>  		/* initialize uninitialized (kzalloc) structure */
[ ... ]
> @@ -1221,6 +1243,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
> =20
>  		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
>  		op->sk =3D sk;
> +		sock_hold(sk);

[Severity: High]
This is also a pre-existing issue, but does bcm_rx_setup() modify op->frames
locklessly here as well?

    /* update CAN frames content */
    err =3D memcpy_from_msg(op->frames, msg,
                          msg_head->nframes * op->cfsiz);

This bypasses bcm_rx_update_lock. In bcm_rx_handler(), it attempts to read
safely by taking the lock:

    /* snapshot RTR content under lock: op->flags/op->frames may be
     * updated concurrently by bcm_rx_setup().
     */
    spin_lock_bh(&op->bcm_rx_update_lock);
    ...
    rtr_frame =3D op->flags & RX_RTR_FRAME;
    if (rtr_frame)
        memcpy(&rtrframe, op->frames, op->cfsiz);

Because bcm_rx_setup() does not acquire bcm_rx_update_lock when modifying
op->frames directly from userspace, can this result in bcm_rx_handler()
acting on inconsistent metadata or evaluating torn multiplex masks?

>  		op->ifindex =3D ifindex;
> =20
>  		/* ifindex for timeout events w/o previous frame reception */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v7-0-c78896b342e4@hartkopp.net?part=3D1
