Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EEA3F12C8
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524977; cv=none; b=cD+Fd81f1zXYzknPLqT67FWmgpNdCoaibJxbVjnUkgh0QSpTh4TK/Zd1aNfQatYB6S3xkuXcfG5EXzRrfxfS1TzTJ7KbZLvR7P634QncTrMLPW94Eq7MTr9TPXBSD7+OS1ji6DtFW43ho/w7N3ikfMNJ5+ed4We2GUBMjpXrQfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524977; c=relaxed/simple;
	bh=j/RcLjA/075AXCRRwvMbweovUmLJNRz0GfXJBnsaoC0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uGWYx2+4ORcJsVO6l5sHiXEjD6tgoNbzxISM+eu1XQUAw8SPBqIsc5CnwOyxAydEPctV6VxH96R+6cjrpz7uQVXW2ztBo8CqqubdtQH50zSRApNUNUvF6QS+VXyvr11WCGCCC1jguPvXzDq0FbDowxEcDtNNX0ljArEJbOGxEjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpFCyVLv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpFCyVLv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EA01F00A3D;
	Wed,  8 Jul 2026 15:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783524975;
	bh=cKJ16qMpKVFFhe25mK99R9qlo+PqOs6wtE0j5DFZ+kg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PpFCyVLvrDMhRhu05dbDM4Sy9NIkJOGnD0bCrLd9kyh36oGaPiPYuJh6IlskuYKvl
	 sIjFCjfiRKUB0GL3I8ZN+e0UBpfJk7dfROltUcItMwUvniXOZjtfqSuFH7mUxatsl9
	 QF18SkTYjRUio0fPiERuup4JFKcwzXcXxTQyVfylJYLVzseqg48ExZF0bGumUHdwjt
	 yugMNhVGTVaBz/O26+f7sBNWVG5OBdgeJ25tvhH+Xfs/2t5O5r6hMC7xGVaRDVl1B6
	 xn6eICYjfC6YPXfGFbIGmMBY64wkB4LKRxtWFn3ODVMs+0KCmWN7Q0Dsfk7xcjwPVg
	 EYwXUfNDOwHCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/10] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260708-bcm_fixes-v7-2-c78896b342e4@hartkopp.net>
References: <20260708-bcm_fixes-v7-0-c78896b342e4@hartkopp.net>
 <20260708-bcm_fixes-v7-2-c78896b342e4@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 15:36:14 +0000
Message-Id: <20260708153615.36EA01F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing RCU memory barriers for tx_ops and rx_ops list insertions =
and iterations, risking unhandled page faults in procfs.
- [High] Unsynchronized updates to active BCM RX operations can corrupt CAN=
 frame filtering.
- [High] Unsynchronized updates to active BCM TX operations can transmit to=
rn CAN frames.
--

--- Patch [2]: [PATCH v7 02/10] can: bcm: fix lockless bound/ifindex race a=
nd silent RX_SETUP failure ---
commit a05a784ab0fbce0367eb9df72d3333b7e2033fcb
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure

bcm_sendmsg() reads bo->ifindex and checks bo->bound before taking
lock_sock(), while bcm_notify(), bcm_connect() and bcm_release() all
mutate both fields under that same lock. This commit fixes a race
where bcm_sendmsg() could observe an inconsistent combination of these
fields. It also ensures bcm_rx_setup() reports -ENODEV when the target
device concurrently disappears.

Link: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_p=
V3At4g=3Dh1kVEtyhA@mail.gmail.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index bdf53241bd7b3..b612135b017d1 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1323,6 +1323,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_h=
ead, struct msghdr *msg,
> =20
>  				op->rx_reg_dev =3D dev;
>  				dev_put(dev);
> +			} else {
> +				/* the requested device is gone - do not
> +				 * silently succeed without registering
> +				 */
> +				err =3D -ENODEV;
>  			}
> =20
>  		} else

[Severity: High]
This is a pre-existing issue, but can unsynchronized updates to active
BCM RX operations corrupt CAN frame filtering?

When updating an existing BCM RX operation, bcm_rx_setup() in net/can/bcm.c
copies data from user space directly into op->frames via:

    err =3D memcpy_from_msg(op->frames, msg, msg_head->nframes * op->cfsiz);

This happens without disabling softirqs or taking a lock that the softirq
handler respects. Concurrently, bcm_rx_handler() runs in NET_RX_SOFTIRQ
context and accesses these fields locklessly to evaluate incoming CAN
frames or generate RTR replies.

Does this data race allow the softirq to observe torn data, resulting in
corrupted CAN frame filtering or malformed RTR replies?

[Severity: High]
This is a pre-existing issue, but do bcm_rx_setup() and bcm_tx_setup()
need RCU release barriers when inserting into bo->rx_ops and bo->tx_ops?

In net/can/bcm.c, new operations are inserted using list_add() instead
of list_add_rcu():

    list_add(&op->list, &bo->tx_ops);
    // and
    list_add(&op->list, &bo->rx_ops);

Concurrently, bcm_proc_show() iterates through these lists. For rx_ops,
it uses list_for_each_entry_rcu() (but the insertion lacked a release
barrier). For tx_ops, it iterates inside rcu_read_lock() using:

    list_for_each_entry(op, &bo->tx_ops, list) {

which lacks an acquire barrier. Since list_add() doesn't execute a write
memory barrier, can concurrent procfs readers observe the newly linked
node before its internal pointers are fully initialized, potentially
dereferencing garbage pointers and causing an unhandled page fault?

[ ... ]

> @@ -1396,12 +1401,13 @@ static int bcm_sendmsg(struct socket *sock, struc=
t msghdr *msg, size_t size)
>  {
>  	struct sock *sk =3D sock->sk;
>  	struct bcm_sock *bo =3D bcm_sk(sk);
> -	int ifindex =3D bo->ifindex; /* default ifindex for this bcm_op */
> +	int ifindex;
>  	struct bcm_msg_head msg_head;
>  	int cfsiz;
>  	int ret; /* read bytes or error codes as return value */
> =20
> -	if (!bo->bound)
> +	/* Lockless fast-path check for bound socket */
> +	if (!READ_ONCE(bo->bound))
>  		return -ENOTCONN;
> =20
>  	/* check for valid message length from userspace */

[Severity: High]
This is a pre-existing issue, but can unsynchronized updates to active
BCM TX operations cause the transmission of torn CAN frames?

When bcm_sendmsg() delegates to bcm_tx_setup() in net/can/bcm.c to update
an existing BCM TX operation, bcm_tx_setup() copies data from user space
into op->frames without acquiring op->bcm_tx_lock:

    err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);

Concurrently, the transmission timer may fire and execute bcm_can_tx().
It calculates the frame pointer under the lock but drops the lock before
copying the frame data locklessly into the SKB:

    skb_put_data(skb, cf, op->cfsiz);

Does this data race allow a partially written (torn) CAN frame to be
constructed and transmitted onto the CAN bus, causing data corruption
on the network?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v7-0-c78896b342e4@hartkopp.net?part=3D2
