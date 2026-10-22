Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792667678;
	b=S2jtRFsj3eI+ttDCM6nbpu0qjVHVKuz4QgFysntZJQVWB+OArQacf7m4sIfSC5oBJRqs
	 dWU2c2+gZNf2zq7qqu5amWjlUYIsAj8Tm/STNrI8uf1tODikIG6mMVABeLI+X8gZrmI5s
	 8a8hzFcoqN0TcjFl4n2m5mIjXwYgfx1BKutTYZwx5Jnu9aQpJs8jG3+me1EfXnnGXY8Ya
	 bN/MVT24K0rPV03exZFVpE7gNAe/wkc0Cdr6tBaaQyGLJZOFkt6obuVys67vV3/BAG5M8
	 BSxHKL2Bh3+cXTY44CtrjhyKlzjjKZY1LpIqhpQkKPfZzu+1hqV03v6Y0jWG4RrqS/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792667678;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=t+yL5LIQB/XmcvJ8XLaIeDs48TsCXFtavG5KeRNid4c=;
	b=HXJ8eg36w2/AdriSmA57j3ZV6VaF/ODyBKrZGgN2XsUuTNLyw3lNd0a0/hryq6zfqPMS
	 w9gVvocsyvZ67n6yHiGSVH2SnG1ysbqizFIWK1f1KzDq/JsKRfIGqP5QOgluci9OghGH3
	 b32PQTOlk/03OeVwS85cdVuFXXEWtqYlyx5G3S5VPen/Egt/E0/vcHhn+gd7UJLBuaJh6
	 5HGH8hKx+gkzuzIzvN45xjR9CK0NKkTJ/3LPCZHGHqvMZe74WZaZLsaU6/HbqFriZbeB0
	 rhmdoH9X47xHEJHtF5eoNFQzy8LrgQ/DO/Zex0135dMGsP17i+DDG1VD2tR75U9u5ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GIlf13MG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4E5606A31A;
	Thu, 22 Oct 2026 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GIlf13MG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411B51F000C1;
	Thu, 22 Oct 2026 11:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792667677;
	bh=t+yL5LIQB/XmcvJ8XLaIeDs48TsCXFtavG5KeRNid4c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GIlf13MGlXhAX/mXk5BsRycqLHftbyuOxyQnVjsBO8hLoRnZQ0VjikgebF0P4ejmQ
	 WUTa4omRJ3wCX+kxUkcFYCUXpsbGZVpTNGQIFDtB7vqw7WKc2o42DfD/xf5aKqJbK6
	 KQlu+Z95/SnJs1nLV85YoJAbFyRhuyFOl4x1vCycsRXOxpDX8aLlMrd6tVKIzaC+Ru
	 RGXnwvnRwIhFijAOKFkqhToOxWAEN8WXfwMfi6/8+3xDz4F+88vmZIaTvtSGnlndxH
	 R8nac2q575zxBJz9D6RkN825n/7GVSwTpj/wH4nS7XMo0Gv/q4z2BkXFBfpZ5BO/uY
	 3WgVY2LMHZSwA==
Subject: Re: [PATCH net-next 11/11] can: protect the receive lists with a
 per-device lock
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, mailhol@kernel.org,
 stable@kernel.org
Date: Thu, 22 Oct 2026 11:14:36 +0000
Message-ID: <179266767682.3135.6448103178144570295@kernel.org>
In-Reply-To: <20261021102756.1900679-12-mkl@pengutronix.de>
References: <20261021102756.1900679-12-mkl@pengutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] After this patch, CAN_RAW serializes bind/setsockopt/release
  against NETDEV_UNREGISTER only with lock_sock().
- [Medium] can: raw/isotp: race in bind() overwrites ENODEV with ENETDOWN
  on unbind
- [Low] isotp_bind() now publishes so->dev with WRITE_ONCE(so->dev, dev)
  inside the RCU lookup (net/can/isotp.c:1623).

Pre-existing issues:
- [Low] isotp_bind() calls can_rx_register() twice: for rx_id when
  isotp_register_rxid(so) is true (net/can/isotp.c:1648-1650), and for…

--

can: protect the receive lists with a per-device lock

This commit adds a spinlock to struct can_dev_rcv_lists. The receive lists
of a CAN device are now protected per device instead of by the per-netns
rcvlists_lock, so can_rx_unregister() can find subscriptions after the
device has moved to another namespace.

RTNL is dropped from raw_bind(), raw_setsockopt(), raw_release(),
isotp_bind() and isotp_release(). These paths now use lock_sock() and a
device pointer published under RCU to serialize against the netdev
notifier.

Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
Link: https://patch.msgid.link/20261020203257.230955-6-socketcan@hartkopp.net

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 5e1c3971ebfce..8ec37d252557e 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -1614,7 +1612,17 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
>  		goto out;
>  	}
>  
> -	dev = dev_get_by_index(net, addr->can_ifindex);
> +	/* Publish the device inside the RCU section of the lookup: When it
> +	 * is unlisted concurrently, either isotp_notify() sees so->dev after
> +	 * synchronize_net() or the lookup fails.
> +	 */
> +	rcu_read_lock();
> +	dev = dev_get_by_index_rcu(net, addr->can_ifindex);
> +	if (dev) {
> +		dev_hold(dev);
> +		WRITE_ONCE(so->dev, dev);
> +	}
> +	rcu_read_unlock();
>  	if (!dev) {
>  		err = -ENODEV;
>  		goto out;
> @@ -1627,7 +1635,12 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
>  		err = -EINVAL;
>  		goto out_put_dev;
>  	}

[Severity: Low]
so->dev is now visible to the lockless check in isotp_notify() before the
remaining checks in isotp_bind() run, and before so->bound is set. The MTU
check can still fail the bind:

	if (READ_ONCE(dev->mtu) < so->ll.mtu) {
		err = -EINVAL;
		goto out_put_dev;
	}

so->dev is only cleared again at out_put_dev.

isotp_bind() no longer holds RTNL. Can a NETDEV_DOWN for the same device
run isotp_notifier()->isotp_notify() inside this window?

The NETDEV_DOWN case only checks READ_ONCE(so->dev) != dev. It does not
look at so->bound or recheck under lock_sock():

	case NETDEV_DOWN:
		sk->sk_err = ENETDOWN;
		if (!sock_flag(sk, SOCK_DEAD))
			sk_error_report(sk);
		break;

Would this set a stale ENETDOWN on a socket that was never bound, whose
bind() then returns -EINVAL? A later successful bind() to another device
(after fixing ll.mtu with CAN_ISOTP_LL_OPTS) would then get that error from
the next recvmsg() or poll().

raw_bind() avoids this. It only publishes ro->bind_dev early, which
raw_notify() uses for NETDEV_UNREGISTER only, and it sets ro->dev after
success. Could isotp use the same approach?

> @@ -1653,15 +1666,17 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
>  	 * can safely reach the device later, even if a concurrent
>  	 * NETDEV_UNREGISTER has already unlisted it by ifindex.
>  	 */
> -	so->dev = dev;
>  	netdev_hold(so->dev, &so->dev_tracker, GFP_KERNEL);

[Severity: Low]
This isn't a bug introduced by this patch, but isotp_bind() ignores the
return values of both can_rx_register() calls just above this:

	if (isotp_register_rxid(so))
		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
				isotp_rcv, sk, sock_i_ino(sk), sk);
	...
	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
			isotp_rcv_echo, sk, sock_i_ino(sk), sk);

It then sets so->bound = 1 unconditionally.

can_rx_register() returns -ENOMEM if kmem_cache_alloc(rcv_cache,
GFP_KERNEL) fails. Can the socket then report a successful bind() while it
is missing its FC/RX receiver or its echo receiver?

Later, isotp_release() and isotp_notify() would call can_rx_unregister()
for an entry that was never added and hit the "receive list entry not
found" warning. raw_enable_filters() and bcm_rx_setup() check this return
value and unwind.

-ENODEV from the net_eq() check does not look reachable here.
isotp_notify() waits on lock_sock() for NETDEV_UNREGISTER, so dev_net(dev)
cannot change during the registrations. That leaves -ENOMEM as the only
error.

The earlier commit "can: replace ARPHRD_CAN type checks with
can_get_ml_priv()" in this series already notes that isotp_bind() ignores
these return values.

[ ... ]

> diff --git a/net/can/raw.c b/net/can/raw.c
> index dfea48768b231..d07f3bb68cd5c 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c

[ ... ]

> @@ -750,18 +772,47 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>  			  sockptr_t optval, unsigned int optlen)
>  {
>  	struct sock *sk = sock->sk;

[ ... ]

> -	rtnl_lock();
> +	if (optname == CAN_RAW_FILTER) {
> +		/* Copy the filters before lock_sock(), so a stalled copy can
> +		 * not block raw_notify() waiting for lock_sock() under RTNL.
> +		 */

[ ... ]

> +	}
> +
>  	lock_sock(sk);
>  
> -	err = raw_setsockopt_locked(sock, optname, optval, optlen);
> +	err = raw_setsockopt_locked(sock, optname, optval, optlen,
> +				    filter, &sfilter, count);

[Severity: Medium]
The comment says a stalled copy must not block raw_notify() while it waits
for lock_sock() under RTNL. The early copy only covers CAN_RAW_FILTER,
though. Do the other options still copy from user memory with lock_sock()
held?

In raw_setsockopt_locked(), CAN_RAW_ERR_FILTER still does:

	if (copy_from_sockptr(&err_mask, optval, optlen))
		return -EFAULT;

CAN_RAW_LOOPBACK, CAN_RAW_RECV_OWN_MSGS, CAN_RAW_FD_FRAMES,
CAN_RAW_XL_FRAMES, CAN_RAW_XL_VCID_OPTS and CAN_RAW_JOIN_FILTERS do the
same after lock_sock(sk) is taken here.

raw_getsockopt(CAN_RAW_FILTER) also writes to the user buffer with
lock_sock() held:

	lock_sock(sk);
	...
		if (copy_to_iter(ro->filter, len,
				 &opt->iter_out) != len)
			err = -EFAULT;

Suppose one of these copies stalls on a FUSE-backed mapping while the
socket is bound, or while ro->bind_dev matches the device. Would a
NETDEV_UNREGISTER of that device then leave raw_notify() sleeping in
lock_sock() with RTNL held?

raw_notifier()
  raw_notify()
    lock_sock(sk)   <- waits for the stalled setsockopt/getsockopt

The unregister could come from ip link del of a vcan device in the user's
own network namespace, a namespace move, or a USB unplug.

The new ro->bind_dev hint also adds cases where raw_notify() takes
lock_sock(): a stale bind_dev that matches the unregistered device leads
there too.

Before this patch, raw_setsockopt() held rtnl_lock() itself across these
copies, so overall exposure is lower than before. The new design relies on
lock_sock() never being held across a user copy, though. Should the
remaining copies in raw_setsockopt_locked() and raw_getsockopt() also move
out of the locked section?

isotp_setsockopt() has the same pattern against isotp_notify(), since every
option is copied under lock_sock():

	lock_sock(sk);
	ret = isotp_setsockopt_locked(sock, level, optname, optval, optlen);
	release_sock(sk);

That code predates this patch. With RTNL gone from isotp_bind(), however,
bind relies on lock_sock() alone to serialize with isotp_notify().

[ ... ]

> @@ -528,16 +557,24 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
>  		ro->ifindex = ifindex;
>  		ro->bound = 1;
>  		/* bind() ok -> hold a reference for new ro->dev */
> -		ro->dev = dev;
> +		WRITE_ONCE(ro->dev, dev);
>  		netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
> +
> +		if (dev) {
> +			/* Either raw_notify() sees ro->dev on NETDEV_DOWN or
> +			 * we see the cleared IFF_UP, pairs with raw_notify()
> +			 */
> +			smp_mb();
> +			if (!(READ_ONCE(dev->flags) & IFF_UP))
> +				notify_enetdown = 1;
> +		}
>  	}
>  
>  out_put_dev:
> -	/* remove potential reference from dev_get_by_index() */
> +	/* remove reference from the device lookup */
>  	dev_put(dev);
>  out:
>  	release_sock(sk);
> -	rtnl_unlock();
>  
>  	if (notify_enetdown) {
>  		sk->sk_err = ENETDOWN;

[Severity: Medium]
With RTNL gone from raw_bind(), can a concurrent NETDEV_UNREGISTER now
leave the socket reporting ENETDOWN instead of ENODEV?

unregister_netdevice_many_notify() and __dev_change_net_namespace()
close the device first, which clears IFF_UP. Only after that do they
call unlist_netdevice(), synchronize_net() and the NETDEV_UNREGISTER
notifier.

Suppose raw_bind() looks up the device before it is unlisted. It then
publishes ro->bind_dev, sees IFF_UP already cleared, and sets
notify_enetdown. raw_notify() for NETDEV_UNREGISTER matches
ro->bind_dev and sleeps in lock_sock() with RTNL held.

Once raw_bind() calls release_sock(), both threads write sk->sk_err
outside the socket lock:

raw_notify()                    raw_bind()
  lock_sock(sk)
  unbind, ro->dev = NULL
  release_sock(sk)
  sk->sk_err = ENODEV
                                  sk->sk_err = ENETDOWN
                                  sk_error_report(sk)

sk_err holds a single value, so the later write wins and the ENODEV is
lost. Userspace then sees ENETDOWN on a socket that is no longer bound
and has ro->count == 0 with no filters registered.

An application that treats ENETDOWN as "interface is down, wait for it
to come back" keeps blocking in recvmsg(). It never learns that the
device is gone and that it has to rebind.

The old code also wrote sk_err after rtnl_unlock(). There,
NETDEV_UNREGISTER could only start after bind() dropped RTNL, and the
synchronize_net() before the notifier made this ordering practically
unreachable. With this patch the notifier is already queued on
lock_sock() and runs as soon as bind() releases it.

isotp_bind() and isotp_notify() have the same pattern. so->dev is
published early and IFF_UP is already clear, so notify_enetdown gets
set. isotp_notify() then writes ENODEV after its release_sock(), while
isotp_bind() writes ENETDOWN after its own.

Would it work to set sk_err and call sk_error_report() before
release_sock() in both bind() paths and in the NETDEV_UNREGISTER case
of raw_notify() and isotp_notify()? The reported error would then
follow lock_sock() ownership. Or do you prefer another way to keep the
ENODEV from being clobbered?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021102756.1900679-2-mkl%40pengutronix.de
