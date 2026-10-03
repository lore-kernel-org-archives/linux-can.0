Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084261A9FB7
	for <linux-can@vger.kernel.org>; Sat,  3 Oct 2026 05:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791006517; cv=none; b=dTrl7ued9rMfPctWzpUToqY2RHDXbPFLopQ3OhsUSIbLk15qikZb5bPP71JGQqr/uCzCQawMw47Ao/Q22L7BaIUN32MhfOE3fNZKJ5xaqNcisKAS+zQeYMP9w4d2DPWEKABzdk9zu+MClyi99xzTz8BzrNIAsBhmcw9/Tt9qtIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791006517; c=relaxed/simple;
	bh=6OcntRfLQCK48Q4ls1SWpCpFoF+QXLqMxxpy5bUFXUA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m0VYFAJzq3EzzWJvuUd8Bo1dJs1kHGCNYX8pmRPWNdJsRSySCCsT74X32wSy3a4i0eTwUMlkeVUesfmQK7m6DRIXW36zYmzhCatytGAYMUZx6rw/Fr1L+UANFkbZTp5NMbd9myTPoZdvSILheb1YrwdhZ6i75tF16/YcdVyEqIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cs/W1CeG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cs/W1CeG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF481F0089B;
	Sat,  3 Oct 2026 05:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791006515;
	bh=loUoQX5xPb9cvzwXg3NuMUZku5iZhLh1gQ7ZbeAHnUg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Cs/W1CeGmYe5nVzqMkAGmu+Bbb3rT4Ms5a/ZG7ABZwH4LjuGshYF9TCDm39o0OaIi
	 8Ncs4Dpt3f8Mut6ATAtswf/xkCA3tde1Tvlr4ucbLq04TPtyFmYp6pv2rHbvdBMs2a
	 wW08KfVTM6qDebQ3lMw+IDBVK0caDvaTNwOmrW8k/efInsNhvYkTtgpHRxw0UZr+Ya
	 6RtwS0plCtjAJcD1O+u9QZvFOB6XibJwR+URA98wxBb7WWWuY1zndjTID/ZjBb3LtJ
	 KW1lWJhZ+SahXXjwXZDpv9HWDLXOxC1kQ38YbVwihaHMhWQY8z9Wx92tAdm2Z2kR8K
	 bw8lzwZJ+RGUA==
Subject: Re: [PATCH v5 1/3] can: remove CAN filters independent from namespace
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, stable@kernel.org, o.rempel@pengutronix.de,
 kuba@kernel.org
Date: Sat, 03 Oct 2026 05:48:34 +0000
Message-ID: <179100651478.1406898.6853696436813565877@kernel.org>
In-Reply-To: <20260929163424.16382-2-socketcan@hartkopp.net>
References: <20260929163424.16382-2-socketcan@hartkopp.net>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] bcm_release() (net/can/bcm.c) unregisters device-bound receive
  filters without holding RTNL, so a concurrent namespace move can still…
- [Medium] The commit message describes a failure that does not occur in
  the notifier code.
- [Medium] The patch removes the early net_eq() return in bcm_notify()
  and moves lock_sock(sk) above the switch (net/can/bcm.c:1838).

--

can: remove CAN filters independent from namespace

This commit removes the net_eq() namespace check from the BCM, ISOTP and
RAW netdev notifiers, so CAN filters are removed on NETDEV_UNREGISTER
even when the device namespace differs from the socket namespace. In
bcm.c it adds tracked net_device pointers (bo->dev, op->tx_dev) for
device comparisons, and bcm_notify() now takes lock_sock() for every
event. In isotp_release() the can_rx_unregister() calls now use
dev_net(so->dev).

Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/

> When the devices namespace is changed the socket namespace and the device
> namespace might differ. The net_eq(dev_net(dev), sock_net(sk)) check in
> the CAN protocols netdev notifiers therefore led to skipping the required
> removal of the CAN filters from the (namespace changed) CAN devices.

[Severity: Medium]

Is this root cause accurate? In __dev_change_net_namespace(), the
UNREGISTER notifiers run while dev_net(dev) still points to the old
namespace:

net/core/dev.c:__dev_change_net_namespace() {
    ...
	unlist_netdevice(dev);
    ...
	call_netdevice_notifiers(NETDEV_UNREGISTER, dev);
    ...
	netdev_lock(dev);
	dev_net_set(dev, net);
	netdev_unlock(dev);
	dev->ifindex = new_ifindex;
    ...
}

The bind and registration paths are raw_bind(), isotp_bind(),
bcm_connect(), bcm_rx_setup() and bcm_sendmsg(). All of them look up
the device with dev_get_by_index(sock_net(sk), ...). can_rx_register()
also refuses a device from another namespace:

	if (dev && !net_eq(net, dev_net(dev)))
		return -ENODEV;

For a socket with filters on the moved device, wouldn't the removed
net_eq() check in raw_notify(), isotp_notify() and bcm_notify() have
passed during the move?

No registration seems able to get in between either:

- raw and isotp register under rtnl.
- bcm_rx_setup() runs under lock_sock(), which bcm_notify() also takes
  for UNREGISTER.
- Lookups fail after unlist_netdevice().

I couldn't find a path where the notifier sees a bound device in a
foreign namespace.

The real bug this patch fixes looks like it is in isotp_release():

1. The socket is unlinked from the notifier list.
2. A namespace move completes.
3. can_rx_unregister(sock_net(sk), so->dev, ...) returns early on its
   own net_eq() check.

That is a race between release and the move, not the notifier check.

Could the commit message describe the path that was actually hit, or
the reproducer from the report? The BCM rework, which is tagged for
stable, is justified by this description.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 3d637a1e0ac1a..cd3522ec32c0a 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1792,15 +1833,13 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
>  {
>  	struct sock *sk = &bo->sk;
>  	struct bcm_op *op;
> -	int notify_enodev = 0;
> +	int sk_err = 0;
>  
> -	if (!net_eq(dev_net(dev), sock_net(sk)))
> -		return;
> +	lock_sock(sk);

[Severity: Medium]

With the early return gone and lock_sock() moved above the switch,
bcm_notifier() now takes the lock of every BCM socket in every
namespace. It does this for every NETDEV_DOWN and NETDEV_UNREGISTER of
any CAN device, while holding RTNL:

net/can/bcm.c:bcm_notifier() {
    ...
	list_for_each_entry(bcm_busy_notifier, &bcm_notifier_list, notifier) {
		spin_unlock(&bcm_notifier_lock);
		bcm_notify(bcm_busy_notifier, msg, dev);
		spin_lock(&bcm_notifier_lock);
	}
    ...
}

Before this change, sockets in other namespaces returned immediately,
and NETDEV_DOWN never took lock_sock().

bcm_sendmsg() holds lock_sock() across bcm_tx_setup(), bcm_rx_setup()
and bcm_tx_send(), and these call memcpy_from_msg() on the user buffer.
Suppose that buffer is on a FUSE-backed mmap that never answers the
read. An unprivileged user in a user namespace can set this up. The
copy then blocks with the socket lock held.

Can a CAN device event in an unrelated namespace then block in
lock_sock() inside bcm_notify() with RTNL held? An example is "ip link
set can0 down" in init_net. That would stall network configuration
system-wide.

A similar stall was already possible for same-namespace UNREGISTER
events. This change extends it to cross-namespace events and to
NETDEV_DOWN. Later patches in this series don't appear to change this.

NETDEV_DOWN only needs the bo->dev == dev comparison, which
raw_notify() and isotp_notify() already do without the socket lock.
Would a lockless check, before lock_sock(), of whether this socket
references dev at all avoid this?

>  
>  	switch (msg) {

[ ... ]

> @@ -1984,6 +2025,10 @@ static int bcm_release(struct socket *sock)
>  	if (bo->bound) {
>  		WRITE_ONCE(bo->bound, 0);
>  		bo->ifindex = 0;
> +		if (bo->dev) {
> +			netdev_put(bo->dev, &bo->dev_tracker);
> +			bo->dev = NULL;
> +		}
>  	}
>  
>  	sock_orphan(sk);

[Severity: High]

Does bcm_release() still have the same window between release and a
namespace move that this patch closes for isotp?

bcm_release() removes the socket from bcm_notifier_list and then takes
only lock_sock(). Unlike raw_release() and isotp_release(), it does not
take rtnl_lock():

net/can/bcm.c:bcm_release() {
    ...
	list_del(&bo->notifier);
	spin_unlock(&bcm_notifier_lock);

	lock_sock(sk);
    ...
			if (op->rx_reg_dev)
				bcm_rx_unreg(op->rx_reg_dev, op);
    ...
}

The list_del() can happen before a concurrent move's UNREGISTER walk
reaches this socket. In that case bcm_notify() never runs for it, and
op->rx_reg_dev stays set.

bcm_rx_unreg() then reads dev_net(dev) without RTNL, and
can_rx_unregister() reads it a second time:

net/can/bcm.c:bcm_rx_unreg() {
	if (op->rx_reg_dev == dev) {
		can_rx_unregister(dev_net(dev), dev, op->can_id,
				  REGMASK(op->can_id), bcm_rx_handler, op);

		/* mark as removed subscription */
		op->rx_reg_dev = NULL;
		netdev_put(dev, &op->rx_reg_dev_tracker);
    ...
}

net/can/af_can.c:can_rx_unregister() {
    ...
	if (dev && !net_eq(net, dev_net(dev)))
		return;
    ...
}

The concurrent writer is dev_net_set() in __dev_change_net_namespace(),
which runs under RTNL and netdev_lock().

Say the argument is sampled as the old namespace and dev_net_set() runs
before the net_eq() check. can_rx_unregister() then returns without
unlinking anything. bcm_rx_unreg() still clears op->rx_reg_dev, and
bcm_remove_op() later frees op.

Can the next frame received on the device in the new namespace then
call bcm_rx_handler() with the freed op?

Now say the check passes instead. hlist_del_rcu() runs under the old
namespace's rcvlists_lock, while code in the new namespace may modify
the same per-device list under its own lock.

Could this corrupt the receive list?

The isotp_release() change to dev_net(so->dev) in this patch relies on
rtnl_lock() being held there. This window existed before this patch,
and later patches in this series don't appear to change bcm_release().

For the BCM part of this fix to be complete, does bcm_release() need
rtnl_lock() around the unregister step, as raw_release() and
isotp_release() take?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929163424.16382-1-socketcan%40hartkopp.net
