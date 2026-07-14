Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7B717A300
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025236; cv=none; b=pkxe4qp/79V7ILjSxtqDRtfr1y6JDhzpkiIsrQsrosjivIi4QYmwO3QfCV4EtA4Q9Or5VcUbVJOcDdIMCza03uNxVYiVTuKTsmgFR2G+SNfR8H0ruAJJfWFjsVXPTWgXnohg/ZDHkLQpln2A9FOHEI4hDdqC2zmBofPatmsbN5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025236; c=relaxed/simple;
	bh=onYQMygahVA4yCjOLltrL0mPDd0z+V1KwRvzrJtG8Qo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kJ7H7R3Y5BwNlLrjcBLCnN3QM0EqgkTUE0ZXf4PSjIq3OAuk462adKQXQ95cNS7r/O3eJmG8bs5HfnSilMkGm+Nar41HcIvekBsC4RIz7mGb6d3rdmklNLo/UsxkTd4EKSstUqz7UYOP0ENjSCho8hK/YM2bYnAKmTt96M0tzlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WluNWONo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WluNWONo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FEC1F000E9;
	Tue, 14 Jul 2026 10:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784025234;
	bh=WUwL8bc4sum6ro78bJJ5Fytz6PZXVXiDATmDonnZ7Tg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WluNWONoN8TTn1dgESCWFHce/v4ve8Vs3UnUdrrt3VsqtJ4BqyYQuYjUhSQ7Q0Ab2
	 MU7TZ4unyg8JNYAcFS2dP6jTeQnoh71w+4q7JC5s5DoZsY6GBIFOLGzvl31ejA0HWr
	 wBrM+63JMzbYhQ/JHeop4Hd+9giCaQHQgXz/9d1WdvoJccI17SLtxw2P1LrTgl9XfO
	 8wa0E48hrpXu9fhhKYOgQbodfSU/zzK/gA6rpqYYs63iSRkoS2J2rMADurm4dzpcaZ
	 bDZWxuutRHALgc8nijzRTsfphfKUzA4BdvYbXctvF30F3cEaSLyPgctfjEO97DN0Hv
	 7/1+S+NBFkZbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 02/11] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260714-bcm_fixes-v13-2-fd667c61099a@hartkopp.net>
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
 <20260714-bcm_fixes-v13-2-fd667c61099a@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:33:53 +0000
Message-Id: <20260714103353.F0FEC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe lockless iteration of `bo->tx_ops` and `bo->rx_ops` in proc=
fs, using `list_add()` instead of `list_add_rcu()` for list updates and `li=
st_for_each_entry()` instead of `list_for_each_entry_rcu()`.
- [High] `bcm_rx_setup()` modifies an active `rx_op`'s data and state from =
process context without any synchronization with `bcm_rx_handler()` running=
 in softirq context.
- [High] `bcm_tx_setup()` modifies an active `tx_op`'s frames and flags wit=
hout holding `bcm_tx_lock`, racing with the softirq timer and transmission =
paths.
--

--- Patch [2]: [PATCH v13 02/11] can: bcm: fix lockless bound/ifindex race =
and silent RX_SETUP failure ---
commit 79233a73945b83eac56e8c17536d2f019c104f50
Author: Oliver Hartkopp <socketcan@hartkopp.net>

    can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure
   =20
    bcm_sendmsg() reads bo->ifindex and checks bo->bound before taking
    lock_sock(), while bcm_notify(), bcm_connect() and bcm_release() all
    mutate both fields under that same lock. Because the lockless reads
    and the locked writes are unordered with respect to each other, a
    racing bcm_notify() (device unregister) or bcm_connect() (concurrent
    bind on another thread sharing the socket) can make bcm_sendmsg()
    observe an inconsistent combination, e.g. a stale bound=3D1 together
    with the now-cleared ifindex=3D0, silently turning a socket bound to a
    specific CAN interface into one that also matches "any" interface.

    Link: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP=
9x_pV3At4g=3Dh1kVEtyhA@mail.gmail.com/

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
This isn't a bug introduced by this patch, but does bcm_rx_setup() safely
modify an active rx_op's data and state from process context without
synchronization with bcm_rx_handler() running in softirq context?

bcm_rx_setup() directly overwrites op->frames via memcpy_from_msg() and
clears op->last_frames while only holding lock_sock(sk):

net/can/bcm.c:bcm_rx_setup() {
    ...
    err =3D memcpy_from_msg(op->frames, msg, msg_head->nframes * op->cfsiz);
    ...
}

Concurrently, bcm_rx_handler() executes locklessly in the softirq RX path
and reads these frames:

net/can/bcm.c:bcm_rx_handler() {
    ...
    if ((get_u64(op->frames, 0) & get_u64(rxframe, 0)) =3D=3D ...
    ...
}

Since memcpy_from_msg() copies from userspace and can block or be preempted,
could the softirq observe partially updated frames, mismatched lengths, or
torn flags, leading to incorrect CAN message filtering and potential data
corruption?

[ ... ]
> @@ -1436,20 +1463,21 @@ static int bcm_sendmsg(struct socket *sock, struc=
t msghdr *msg, size_t size)
>  			struct net_device *dev;
> =20
>  			dev =3D dev_get_by_index(sock_net(sk), ifindex);
> -			if (!dev)
> -				return -ENODEV;
> +			if (!dev) {
> +				ret =3D -ENODEV;
> +				goto out_release;
> +			}
> =20
>  			if (dev->type !=3D ARPHRD_CAN) {
>  				dev_put(dev);
> -				return -ENODEV;
> +				ret =3D -ENODEV;
> +				goto out_release;
>  			}
> =20
>  			dev_put(dev);
>  		}
>  	}
> =20
> -	lock_sock(sk);
> -
>  	switch (msg_head.opcode) {
> =20
>  	case TX_SETUP:

[Severity: High]
This is a pre-existing issue, but does bcm_tx_setup() modify an active
tx_op's frames and flags without holding bcm_tx_lock, racing with the softi=
rq
timer and transmission paths?

When updating an existing tx op, bcm_tx_setup() calls memcpy_from_msg() to
update op->frames before acquiring bcm_tx_lock:

net/can/bcm.c:bcm_tx_setup() {
    ...
    err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
    ...
}

Meanwhile, bcm_can_tx() drops the lock and calls skb_put_data() to copy the
frame into an skb:

net/can/bcm.c:bcm_can_tx() {
    ...
    skb_put_data(skb, cf, op->cfsiz);
    ...
}

Could this data race allow the softirq to transmit partially updated CAN
frames onto the bus? Because memcpy_from_msg() accesses userspace and might
block, the race window appears wide enough to result in deterministic
corruption of transmitted frames under concurrent updates.

[Severity: High]
This is also a pre-existing issue, but is it safe for bcm_proc_show() to
iterate over bo->tx_ops and bo->rx_ops locklessly in procfs, while
bcm_tx_setup() and bcm_rx_setup() use list_add() instead of list_add_rcu()?

bcm_tx_setup() and bcm_rx_setup() insert new operations using the plain
list_add() macro, which lacks the smp_store_release() memory barrier:

net/can/bcm.c:bcm_tx_setup() {
    ...
    list_add(&op->list, &bo->tx_ops);
    ...
}

bcm_proc_show() traverses tx_ops locklessly under rcu_read_lock(), but uses
the unsafe list_for_each_entry() macro entirely bypassing RCU read primitiv=
es:

net/can/bcm.c:bcm_proc_show() {
    ...
    list_for_each_entry(op, &bo->tx_ops, list) {
    ...
}

Could a concurrent procfs reader observe the list pointer before the bcm_op
structure is fully visible in memory, causing a dereference of uninitialized
memory or a crash?

>  		ret =3D bcm_tx_setup(&msg_head, msg, ifindex, sk);
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v13-0-fd667c61099a@hartkopp.net?part=3D2
