Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFFE391E78;
	Fri, 16 Oct 2026 02:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118227; cv=none; b=Lbwh4rSeJs0X75ohrUk0Xpt81il+AUrg+1/5YE7hOGbB1DRxmseb/U0lr00VCjdRak0chSeAKWBFSHMaRzuqLnamI0+0kQ/Bti7d/RRFCgiseD6uZN5IQHWDU+Q65ETKsPksI2kwWui1R1SlH3ty4nn7AnEkPN/Q0Gnx6T5UeDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118227; c=relaxed/simple;
	bh=bUrLLbqmztpproXjVgTPwqQ8dyDDfMG1UkTzhTJ/GQc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LyGKuh87+ugG44wspHWg35x5y7ph7sNTSvEnvz7iD7ZI1mF7npS+e+aPs2VtaBqHc8fYaRQMpfrSCCfgsR8o1BHp+960hiYnnKICqAFf5FBmNcsBLVsXOEjt22eeb0jX5RUPdHw2x4usOm+7su+DZ0/XhFyQwmnqtlWVAoIBzYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1GFCeJF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1GFCeJF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC0F1F000C5;
	Fri, 16 Oct 2026 02:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792118226;
	bh=ppE64hLvHeym9F2cTK/P6MnoHfNBKh8cbyMY3c0l7+g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q1GFCeJFtGerNi8OWU5rDIPUO/T766uQ7iOw7wEztaqoY840ukZL1DQVWUhLMiY5U
	 mgcm7rBQ7hq6pdIBLXoGzR+1NVX2cDD/oTvrmIJnemG24urm3cd8SMbO6p2HcE0iCq
	 xetrLdTW3I/6wRRQRWNn5979jdDvrGqpWz9+yuCEKRSM0BkZjcx+LjwyNxTeB4Q/+j
	 832VxS8pTqPSnZLhQyw+FMV/TumRz4ocj/qrtiBDYYZi1ys2opgabhSiIeFJ7ly+vW
	 uLXCQpB2sYRRowqwKOJiWi1CNYo99D09M3p/L9MYg8VoCxElY1EIygwiCQ0Osg6T6Q
	 jfxHRtQ5kmXag==
Subject: Re: [PATCH net-next 08/37] can: bcm: fix filter removal race between
 release and netns change
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 kurt.van.dijck@eia.be
Date: Fri, 16 Oct 2026 02:37:05 +0000
Message-ID: <179211822523.434549.241636889494644724@kernel.org>
In-Reply-To: <20261015015336.816543-9-mkl@pengutronix.de>
References: <20261015015336.816543-9-mkl@pengutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit moves remove_proc_entry() ahead of rtnl_lock() so
  that procfs readers cannot stall RTNL from close().
- [Medium] bcm_release() now holds the global rtnl_mutex across the whole
  rx_ops unregistration loop (rtnl_lock() at net/can/bcm.c:1951,…
- [Low] Stale comment in bcm_release().

--

can: bcm: fix filter removal race between release and netns change

bcm_release() now takes rtnl_lock() before it removes the socket from
bcm_notifier_list. It holds RTNL across the rx_ops unregistration, so
bcm_release() and bcm_notify() can no longer both skip filter removal
while the bound device moves to another netns. The bcm_busy_notifier
busy-wait becomes a WARN_ON_ONCE(), and the procfs entry and tx_ops are
now removed before RTNL is taken.

Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
Link: https://patch.msgid.link/20261014142114.280279-3-socketcan@hartkopp.net

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 6759662e024c..301920011a30 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1926,21 +1926,19 @@ static int bcm_release(struct socket *sock)
>  
>  	/* remove bcm_ops, timer, rx_unregister(), etc. */
>  
> -	spin_lock(&bcm_notifier_lock);
> -	while (bcm_busy_notifier == bo) {
> -		spin_unlock(&bcm_notifier_lock);
> -		schedule_timeout_uninterruptible(1);
> -		spin_lock(&bcm_notifier_lock);
> -	}
> -	list_del(&bo->notifier);
> -	spin_unlock(&bcm_notifier_lock);
> -
> +	/* Remove the procfs entry and the tx_ops before taking RTNL:
> +	 * remove_proc_entry() waits for concurrent readers of the entry and
> +	 * must not hold up RTNL for them. Clear bo->bcm_proc_read so that
> +	 * bcm_notify() does not remove the entry a second time.
> +	 */
>  	lock_sock(sk);
>  
>  #if IS_ENABLED(CONFIG_PROC_FS)
>  	/* remove procfs entry */
> -	if (net->can.bcmproc_dir && bo->bcm_proc_read)
> +	if (net->can.bcmproc_dir && bo->bcm_proc_read) {
>  		remove_proc_entry(bo->procname, net->can.bcmproc_dir);
> +		bo->bcm_proc_read = NULL;
> +	}
>  #endif /* CONFIG_PROC_FS */

[Severity: Medium]
list_del(&bo->notifier) now runs after rtnl_lock(). That means this
first lock_sock() section runs while the socket is still on
bcm_notifier_list. Can a procfs reader still stall RTNL here, just
indirectly through the socket lock?

Consider this interleaving:

CPU1 (close)
bcm_release()
  lock_sock(sk)
  remove_proc_entry()
    proc_entry_rundown()
      wait_for_completion()      <- waits for the reader on CPU2

CPU2 (reader of /proc/net/can-bcm/<ino>)
proc_reg_read()
  use_pde()
  pde_read()                     <- copy to a FUSE or userfaultfd
                                    backed buffer blocks

CPU3 (NETDEV_UNREGISTER, RTNL held)
bcm_notifier()
  bcm_notify(bo, NETDEV_UNREGISTER, dev)
    lock_sock(sk)                <- blocks behind CPU1

bcm_notify() takes lock_sock(sk) before it checks whether any op or the
binding uses dev. So deleting or moving any CAN device in the socket's
netns would be enough.

Before this patch, the socket was unlinked first and the busy-wait made
sure bcm_notify() was not running for it, so this interleaving was not
possible.

The procfs entry is mode 0644 and is created on any connect(), including
can_ifindex = 0. With unprivileged user namespaces, a vcan device in a
user-owned netns can trigger the notifier, and RTNL is global.

Does this mean the commit message goal ("which could otherwise stall
RTNL from a plain close()") is only partly met?

There are similar RTNL stall paths already. bcm_sendmsg() holds
lock_sock() across memcpy_from_msg() in bcm_tx_setup() and
bcm_rx_setup(), and bcm_notify() itself calls remove_proc_entry() under
RTNL. This particular ordering is new with this patch, though.

[ ... ]

> @@ -1948,6 +1946,21 @@ static int bcm_release(struct socket *sock)
>  		bcm_remove_op(op);
>  	}
>  
> +	release_sock(sk);
> +
> +	rtnl_lock();
> +
> +	/* The netdev notifier chain runs under RTNL, so bcm_notifier() can't
> +	 * be walking bcm_notifier_list and point to this socket. The spinlock
> +	 * is still needed as bcm_init() adds sockets without holding RTNL.
> +	 */
> +	spin_lock(&bcm_notifier_lock);
> +	WARN_ON_ONCE(bcm_busy_notifier == bo);
> +	list_del(&bo->notifier);
> +	spin_unlock(&bcm_notifier_lock);
> +
> +	lock_sock(sk);
> +
>  	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
>  		/*
>  		 * Don't care if we're bound or not (due to netdev problems)

[Severity: Low]
This isn't a functional problem, but the comment a bit further down in
this rx_ops loop in bcm_release() still describes a concurrent
unregister:

			 * op->rx_reg_dev is a tracked reference taken
			 * when the subscription was registered, so it
			 * stays valid here even if a concurrent
			 * NETDEV_UNREGISTER already unlisted the device.

This loop now runs between rtnl_lock() and rtnl_unlock(), and the socket
stays on bcm_notifier_list until RTNL is taken. A NETDEV_UNREGISTER has
either already finished, in which case bcm_notify()->bcm_rx_unreg()
cleared op->rx_reg_dev, or it runs after this loop, when the socket is
no longer on the list.

Can a concurrent NETDEV_UNREGISTER still happen at this point? The old
comment seems to contradict the new comment added above it.

The same comment in bcm_delete_rx_op() is still accurate, because that
path does not hold RTNL. Should the copy in bcm_release() be updated?

> @@ -1973,6 +1986,8 @@ static int bcm_release(struct socket *sock)
>  
>  	}
>  
> +	rtnl_unlock();
> +
>  	synchronize_rcu();

[Severity: Medium]
The global rtnl_mutex is now held across the whole rx_ops
unregistration loop, and userspace decides how long that loop is. Is
that intended?

bcm_rx_setup() allocates one op per distinct (can_id, ifindex) with
kzalloc(OPSIZ, GFP_KERNEL). That allocation is not memcg accounted, and
there is no per-socket limit. bcm_connect() accepts can_ifindex == 0
without any device, and ANYDEV ops register on the all-devices list
through:

	err = can_rx_register(sock_net(sk), NULL, op->can_id,

So an unprivileged user with no CAN hardware can create a very large
number of ops.

On close(), each op calls can_rx_unregister(). That takes
spin_lock_bh(&net->can.rcvlists_lock) and walks the receiver hlist
linearly until it finds the match.

A second socket can put M newer entries in front of the victim's
entries in the same bucket. It can do this with EFF ids that fold to
the same bucket in effhash(), or with the same SFF id. RTNL would then
be held for roughly K * M list steps.

Before this patch, the same loop ran only under lock_sock(sk), so only
the closing task paid for it. Now it would block netlink and netdev
configuration in every network namespace.

The loop without cond_resched() already existed, and the attacker needs
a lot of kernel memory. What is new is that RTNL covers the whole loop.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015015336.816543-2-mkl%40pengutronix.de
