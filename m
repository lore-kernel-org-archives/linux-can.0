Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664894;
	b=caE+xNL8pS1CFk8pkg+gtzD99PSSFwrEU+7b3Qy6Mnjt889r+z2DdH02shQ2PZdyRVs/
	 BFZ+O6eLD4tFBFW6K7OyynxM+7OF7T+AJAO9tSUxx6hLkoDfGkP8UEwTXNE0udEMgTjIO
	 MDLspu2bQ05vs5WXQJw3hBLwu2vdg0eOH5+vnRW1KFs4xOlvWfGlfAdXNYGAcAmaLRmkW
	 msk1LMaVc13b5ZhEqR9i0ZK0rKOjbB+Tej1K5iSeCIXM/Ode6yqNGhhkvB6BEYgb/yyVw
	 i9obTuqt5oiKYwdUrZxiFpUOCd+qup6pRsuJiqUMdAHBJ4A+nZ69SWFWOx1v5T+yyKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664894;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2tuVHPeBsSMDqbaageFYjY6u9zxj6cJEEJgdvZIvtHg=;
	b=xHB9h+M2lWmSx0bUNpmWd/PIMh9orPefOdH7k3Davk8vrUQ4q66tZz9GNTNkE9djNC/2
	 QTPLp3qWEwaGSs7NKDr7LqOQDCJ9ktnWM0iWRqIhfq3VPfaOyzzwztWD70UX2+QlGFYrQ
	 0I/zfagyEmfgxNn5hpLoYqzKULjQaHJ/MzgHwtBFkOyzoLGNCAB6rr/toS1T6Ee5faq4R
	 QqHsbhezMgJOgGY8pPKNG6jYxhhrgeK8iri2BOg+zUKcbc+c5jJlIR6YHwYbuj/z0aTWk
	 gLuDjTzWcfXy/Bc4d/xFX07n2GA2CRgfuyctDNc04X1rX9k583ZVHhF/LX9hBSXeLPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flh3Zw23;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96982606A319
	for <linux-can@vger.kernel.org>; Thu, 22 Oct 2026 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flh3Zw23
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274811F000C1;
	Thu, 22 Oct 2026 10:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792664894;
	bh=2tuVHPeBsSMDqbaageFYjY6u9zxj6cJEEJgdvZIvtHg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=flh3Zw231XPa9nb/f59QNBOn0/OxNE6eWoxDwSmEJSD65XstbmpRA4uxizA1C5tlX
	 C+X87Iktca5Z2mabmKdXpExz9E1wwxqxK2Xs6vvmdFVCZ38dXdY6mZykGIY706PgL7
	 nD7MHf2/EHE6G+SbkBJJz6YIEo/Sk7PmDdwO4mWB4Reh5mg9WR2JjzoZgFco92QHJg
	 WmKKszHA2b7cTxNGIk8T7ww8wz2ljDTFJ3AJA1UB+i3Nw6XJNvE0plh/s5I2NOaOOx
	 9xwzIcFiO8sQyi9WlC7DDvWTlzusW0jup4vc8iJ7ddpSZNvTL/XK7iRdaPMWvtp/OK
	 1Cv/75bN0rsBg==
Message-ID: <sashiko-outbox-181335@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 11/11] can: protect the receive lists with a
 per-device lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261021102756.1900679-12-mkl@pengutronix.de>
References: <20261021102756.1900679-1-mkl@pengutronix.de>
 <20261021102756.1900679-12-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 10:28:13 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] can: raw/isotp: race in bind() overwrites ENODEV with ENETDOWN o=
n unbind
- [Medium] can: isotp: premature so->dev publication in isotp_bind() races =
with NETDEV_DOWN
--

commit 8449957dc1b032324bb9194614a09818da738dd0
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: protect the receive lists with a per-device lock

This commit adds a per-device spinlock to struct can_dev_rcv_lists so that
CAN receive list registrations and unregistrations are protected
independently of network namespace moves. This allows CAN_RAW, CAN_BCM, and
CAN_ISOTP to manage their receive filters under lock_sock() without holding
rtnl_lock().

Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8=
E@doyensec.com/
Link: https://patch.msgid.link/20261020203257.230955-6-socketcan@hartkopp.n=
et

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 5e1c3971ebfce..8ec37d252557e 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -1614,7 +1612,17 @@ static int isotp_bind(struct socket *sock, struct =
sockaddr_unsized *uaddr, int l
>  		goto out;
>  	}
> =20
> -	dev =3D dev_get_by_index(net, addr->can_ifindex);
> +	/* Publish the device inside the RCU section of the lookup: When it
> +	 * is unlisted concurrently, either isotp_notify() sees so->dev after
> +	 * synchronize_net() or the lookup fails.
> +	 */
> +	rcu_read_lock();
> +	dev =3D dev_get_by_index_rcu(net, addr->can_ifindex);
> +	if (dev) {
> +		dev_hold(dev);
> +		WRITE_ONCE(so->dev, dev);
> +	}
> +	rcu_read_unlock();
>  	if (!dev) {
>  		err =3D -ENODEV;
>  		goto out;
> @@ -1627,7 +1635,12 @@ static int isotp_bind(struct socket *sock, struct =
sockaddr_unsized *uaddr, int l
>  		err =3D -EINVAL;
>  		goto out_put_dev;
>  	}
> -	if (!(dev->flags & IFF_UP))
> +
> +	/* Either isotp_notify() sees so->dev on NETDEV_DOWN or we see the
> +	 * cleared IFF_UP, pairs with isotp_notify()
> +	 */
> +	smp_mb();
> +	if (!(READ_ONCE(dev->flags) & IFF_UP))
>  		notify_enetdown =3D 1;
> =20
>  	ifindex =3D dev->ifindex;
> @@ -1653,15 +1666,17 @@ static int isotp_bind(struct socket *sock, struct=
 sockaddr_unsized *uaddr, int l
>  	 * can safely reach the device later, even if a concurrent
>  	 * NETDEV_UNREGISTER has already unlisted it by ifindex.
>  	 */
> -	so->dev =3D dev;
>  	netdev_hold(so->dev, &so->dev_tracker, GFP_KERNEL);
> =20
>  out_put_dev:
> -	/* remove potential reference from dev_get_by_index() */
> +	/* the published so->dev is only valid for a successful bind() */
> +	if (err)
> +		WRITE_ONCE(so->dev, NULL);

[Severity: Medium]
In net/can/isotp.c, isotp_bind() publishes so->dev inside the RCU read-side
critical section before validating can_get_ml_priv(dev) and
READ_ONCE(dev->mtu) < so->ll.mtu:

	rcu_read_lock();
	dev =3D dev_get_by_index_rcu(net, addr->can_ifindex);
	if (dev) {
		dev_hold(dev);
		WRITE_ONCE(so->dev, dev);
	}
	rcu_read_unlock();
	...
	if (READ_ONCE(dev->mtu) < so->ll.mtu) {
		err =3D -EINVAL;
		goto out_put_dev;
	}

Unlike raw_bind(), which publishes ro->bind_dev early (used only for
NETDEV_UNREGISTER under lock_sock(sk)) and only sets ro->dev once validation
and filter registration succeed, isotp_notify() checks READ_ONCE(so->dev)
locklessly for NETDEV_DOWN:

	if (READ_ONCE(so->dev) !=3D dev)
		return;

	switch (msg) {
	...
	case NETDEV_DOWN:
		sk->sk_err =3D ENETDOWN;
		if (!sock_flag(sk, SOCK_DEAD))
			sk_error_report(sk);
		break;
	}

If isotp_bind() fails the MTU check (for example when CAN_ISOTP_LL_OPTS sets
ll.mtu =3D CANFD_MTU and the target device has dev->mtu =3D CAN_MTU) while a
concurrent NETDEV_DOWN notifier runs on that device before out_put_dev clea=
rs
so->dev, won't isotp_notify() observe READ_ONCE(so->dev) =3D=3D dev and set
sk->sk_err =3D ENETDOWN on the still-unbound socket?

Would checking can_get_ml_priv(dev) and READ_ONCE(dev->mtu) < so->ll.mtu
inside rcu_read_lock() before writing so->dev avoid this window?

> +
> +	/* remove reference from the device lookup */
>  	dev_put(dev);
>  out:
>  	release_sock(sk);
> -	rtnl_unlock();
> =20
>  	if (notify_enetdown) {
>  		sk->sk_err =3D ENETDOWN;
> @@ -1864,12 +1879,21 @@ static void isotp_notify(struct isotp_sock *so, u=
nsigned long msg,
>  	if (!net_eq(dev_net(dev), sock_net(sk)))
>  		return;
> =20
> -	if (so->dev !=3D dev)
> +	if (msg =3D=3D NETDEV_DOWN)
> +		smp_mb(); /* pairs with isotp_bind(), see raw_notify() */
> +
> +	/* lockless fast path, see raw_notify() */
> +	if (READ_ONCE(so->dev) !=3D dev)
>  		return;
> =20
>  	switch (msg) {
>  	case NETDEV_UNREGISTER:
>  		lock_sock(sk);
> +		if (so->dev !=3D dev) {
> +			release_sock(sk);
> +			break;
> +		}
> +
>  		/* remove current filters & unregister */
>  		if (so->bound) {
>  			if (isotp_register_rxid(so))
> @@ -1885,7 +1909,7 @@ static void isotp_notify(struct isotp_sock *so, uns=
igned long msg,
> =20
>  		so->ifindex =3D 0;
>  		so->bound  =3D 0;
> -		so->dev =3D NULL;
> +		WRITE_ONCE(so->dev, NULL);
>  		release_sock(sk);
> =20
>  		sk->sk_err =3D ENODEV;
> diff --git a/net/can/raw.c b/net/can/raw.c
> index dfea48768b231..d07f3bb68cd5c 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c

[ ... ]

> @@ -305,16 +309,31 @@ static void raw_notify(struct raw_sock *ro, unsigne=
d long msg,
>  		       struct net_device *dev)
>  {
>  	struct sock *sk =3D &ro->sk;
> +	struct net_device *bind_dev;
> =20
>  	if (!net_eq(dev_net(dev), sock_net(sk)))
>  		return;
> =20
> -	if (ro->dev !=3D dev)
> +	if (msg =3D=3D NETDEV_DOWN)
> +		smp_mb(); /* IFF_UP is cleared before, pairs with raw_bind() */
> +
> +	/* Lockless fast path, ro->bind_dev covers a concurrent bind().
> +	 * Read it before ro->dev, pairs with smp_store_release() in
> +	 * raw_bind(). A stale ro->bind_dev only costs a lock_sock().
> +	 */
> +	bind_dev =3D smp_load_acquire(&ro->bind_dev);
> +	if (READ_ONCE(ro->dev) !=3D dev &&
> +	    (msg !=3D NETDEV_UNREGISTER || bind_dev !=3D dev))
>  		return;
> =20
>  	switch (msg) {
>  	case NETDEV_UNREGISTER:
>  		lock_sock(sk);
> +		if (ro->dev !=3D dev) {
> +			release_sock(sk);
> +			break;
> +		}
> +
>  		/* remove current filters & unregister */
>  		if (ro->bound) {
>  			raw_disable_allfilters(dev_net(dev), dev, sk);
> @@ -326,7 +345,7 @@ static void raw_notify(struct raw_sock *ro, unsigned =
long msg,
> =20
>  		ro->ifindex =3D 0;
>  		ro->bound =3D 0;
> -		ro->dev =3D NULL;
> +		WRITE_ONCE(ro->dev, NULL);
>  		ro->count =3D 0;
>  		release_sock(sk);
> =20

[ ... ]

> @@ -528,16 +557,24 @@ static int raw_bind(struct socket *sock, struct soc=
kaddr_unsized *uaddr, int len
>  		ro->ifindex =3D ifindex;
>  		ro->bound =3D 1;
>  		/* bind() ok -> hold a reference for new ro->dev */
> -		ro->dev =3D dev;
> +		WRITE_ONCE(ro->dev, dev);
>  		netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
> +
> +		if (dev) {
> +			/* Either raw_notify() sees ro->dev on NETDEV_DOWN or
> +			 * we see the cleared IFF_UP, pairs with raw_notify()
> +			 */
> +			smp_mb();
> +			if (!(READ_ONCE(dev->flags) & IFF_UP))
> +				notify_enetdown =3D 1;
> +		}
>  	}
> =20
>  out_put_dev:
> -	/* remove potential reference from dev_get_by_index() */
> +	/* remove reference from the device lookup */
>  	dev_put(dev);
>  out:
>  	release_sock(sk);
> -	rtnl_unlock();
> =20
>  	if (notify_enetdown) {
>  		sk->sk_err =3D ENETDOWN;

[Severity: Medium]
Can raw_bind() and isotp_bind() overwrite sk->sk_err =3D ENODEV with ENETDO=
WN
when racing against a concurrent NETDEV_UNREGISTER?

During unregister_netdevice_many_notify() or __dev_change_net_namespace(),
netif_close() clears IFF_UP before unlist_netdevice(dev), synchronize_net(),
and call_netdevice_notifiers(NETDEV_UNREGISTER, dev).

If raw_bind() or isotp_bind() looks up and publishes the device just before
unlist_netdevice(dev), the following sequence can occur:

1. Under lock_sock(sk), raw_bind() or isotp_bind() sees !(READ_ONCE(dev->fl=
ags) & IFF_UP)
   and sets notify_enetdown =3D 1.
2. Concurrent raw_notify() or isotp_notify() for NETDEV_UNREGISTER sees the
   published ro->bind_dev or so->dev and waits on lock_sock(sk).
3. raw_bind() or isotp_bind() calls release_sock(sk).
4. raw_notify() or isotp_notify() acquires lock_sock(sk), removes the
   filters, resets bound =3D 0 and dev =3D NULL, calls release_sock(sk), an=
d sets
   sk->sk_err =3D ENODEV.
5. raw_bind() or isotp_bind() runs its post-unlock notify_enetdown block:

	release_sock(sk);

	if (notify_enetdown) {
		sk->sk_err =3D ENETDOWN;
		if (!sock_flag(sk, SOCK_DEAD))
			sk_error_report(sk);
	}

This clobbers sk->sk_err =3D ENODEV with ENETDOWN on a socket that is now
unbound. For CAN_RAW sockets in particular, raw_recvmsg() does not check
ro->bound and relies on sk->sk_err =3D ENODEV to report that the device went
away, so overwriting ENODEV with ENETDOWN leaves a subsequent blocking
recvmsg() waiting on an unbound socket with no filters.

Should sk->sk_err and sk_error_report(sk) be updated while still holding
lock_sock(sk) in raw_bind(), isotp_bind(), raw_notify(), and isotp_notify()?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021102756.1900=
679-1-mkl@pengutronix.de?part=3D11
