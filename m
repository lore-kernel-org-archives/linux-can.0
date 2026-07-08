Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B783290DE
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503674; cv=none; b=ncoKc9P35s5KOOyN1Dv2jMZnVWEpCJ8ku5feNIHQa9zvpgKs2gYMvIap9ydRa5zz8d/nIYdVLo+1iXUH9WYL6MXxwroQk/4bCZWpfU3yGh6zcnK5laSjSdg6JD6kIPEkGXqL5L72NqsWRv3qomTxYw2tlZohRsTzEvFeO6QtSk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503674; c=relaxed/simple;
	bh=Fp/CDHrWkpXlEtyx6YvfMjaXpMidMkyByjJUiQPQO+0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O11/AhUJjz/ZLOlHy0ZOh+NJE2uUNCr0MQiEBgmQ5LrRtPHL5e8dtgo/VaqGqXiPCZ8t+8xKV6FqgfFhMs9NzLYXLBHxwEYuANZumAlFoAqCt3NHUcHOu/c/tstIU8I+j9J5tFkm8PRSqekLVOngnJfcdD0aQJzz2HKtxH6o3fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hz75QTC4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hz75QTC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146C11F000E9;
	Wed,  8 Jul 2026 09:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783503673;
	bh=PVjg9NwwjGGuXFl2fHq+pxCx3ZWSZUKzPQlpYcrRTGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hz75QTC4+baQ7aiWYXQdYDjfJBUrfARLo0FaQ5mliw0FhzSOjmkvaBp4Ta5ZiZhqD
	 wfZbJxetruEsID5j5WaH4VFWRpcx+SU9vYYJqm2TXrBBQulq+ckyhn3RV28bCEj3PX
	 QSl/JrztgJsOgHEObO0wOajdsLmWoLL2UBzYIXrf2+auRHL9A2m0HizjnGsdzn/d8i
	 7I03Huwrk09s84MK+nThHGh2S4APgjYuhiAKExT9x/8TfEk1eU5Y7mDGRB5J6y+j8P
	 xKpb9pNbqWrMul+D3ppZTjMVm+zQzwHbMEAIsdpFw0kQSs9FLsm4RgCV5eKv1bf5BF
	 R/rNMDfZ4HxLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/9] can: bcm: defer rx_op deallocation to workqueue
 to fix thrtimer UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260708-bcm_fixes-v6-1-80710a2bc398@hartkopp.net>
References: <20260708-bcm_fixes-v6-0-80710a2bc398@hartkopp.net>
 <20260708-bcm_fixes-v6-1-80710a2bc398@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 09:41:12 +0000
Message-Id: <20260708094113.146C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Unregistering the CAN protocol before flushing the workqueue cause=
s a kernel WARNING and leaks the slab cache during module unload.

Pre-existing issues:
- [High] Unsafe lockless iteration of `tx_ops` and `rx_ops` lists without R=
CU wrappers leads to data races and potential kernel crashes.
- [High] Unprotected data races during CAN frame configuration updates agai=
nst concurrent timers and softirq handlers.
--

--- Patch [1]: [PATCH v6 1/9] can: bcm: defer rx_op deallocation to workque=
ue to fix thrtimer UAF ---
commit 31beeaafb4b7e3f7496ed0979679240bbb843e27
Author: Lee Jones <lee@kernel.org>
Subject: can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF

This commit replaces immediate call_rcu() with workqueue deferral for BCM
operations to safely cancel hrtimers that can sleep, fixing a use-after-fre=
e.
It adds a reference count on op->sk to prevent the socket from disappearing
before the workqueue executes.

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
This is a pre-existing issue, but does lockless list iteration of tx_ops
and rx_ops miss RCU wrappers?

When reading /proc/net/can-bcm/* via bcm_proc_show(), the code iterates
over tx_ops locklessly using the non-RCU list_for_each_entry().

Concurrently, operations added in bcm_tx_setup() (and bcm_rx_setup() for
rx_ops) use the standard list_add() instead of list_add_rcu():

bcm_tx_setup() {
    ...
    list_add(&op->list, &bo->tx_ops);
}

Since list_add() omits the smp_store_release() memory barrier, can a
concurrent reader see uninitialized or partially linked list pointers,
leading to page faults or infinite loops?

[ ... ]

> @@ -1221,6 +1243,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
> =20
>  		/* bcm_can_tx / bcm_tx_timeout_handler needs this */
>  		op->sk =3D sk;
> +		sock_hold(sk);
>  		op->ifindex =3D ifindex;

[Severity: High]
This is a pre-existing issue, but are CAN frame configuration updates
unprotected against concurrent softirq handlers and timers?

In bcm_rx_setup(), memcpy_from_msg() directly modifies op->frames and
op->last_frames without synchronization. Concurrently, bcm_rx_handler()
accesses these frames locklessly in softirq context:

bcm_rx_handler() {
    ...
    if ((get_u64(op->frames, 0) & get_u64(rxframe, 0)) =3D=3D
        (get_u64(op->frames, 0) &
         get_u64(op->frames + op->cfsiz * i, 0))) {
    ...
}

Similarly in bcm_tx_setup(), memcpy_from_msg() writes user data directly
into op->frames while a firing timer could trigger bcm_can_tx(), which
reads from op->frames locklessly.

Could this result in torn reads and cause the transmission or processing of
corrupted or partially validated CAN frames?

[ ... ]

> @@ -1869,6 +1898,8 @@ static void __exit bcm_module_exit(void)
>  	can_proto_unregister(&bcm_can_proto);
>  	unregister_netdevice_notifier(&canbcm_notifier);
>  	unregister_pernet_subsys(&canbcm_pernet_ops);
> +	rcu_barrier();
> +	destroy_workqueue(bcm_wq);
>  }

[Severity: High]
Can the CAN protocol unregister before the workqueue is flushed?

If a user creates a BCM socket, arms a timer, and closes the socket, and th=
en
the module is immediately unloaded, bcm_module_exit() executes
can_proto_unregister() before destroy_workqueue().

At this point, the deferred bcm_free_op_work() may still be pending in the
workqueue holding a reference to the socket.

Does this cause can_proto_unregister() to destroy the socket's slab cache
while it is still populated, leaking the cache and causing a potential
memory corruption when sk_free() falls back to kfree() on a slab-allocated
object?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v6-0-80710a2bc398@hartkopp.net?part=3D1
