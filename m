Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA06346A08
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693309; cv=none; b=djwPkNIRk1nQmY12yX4BPFaxf6GePoVVHxi/AF/5re2L3hLKyG7qGYd5Phttxj6fCUnQ9Hb1PI5LrTcwXhgVj4NYKCCVkiG7OMd1gqsVfJvRh0kVbpMIkLeqnYIbhfB1oWmjKtnD0oNYhOS3+Bmv2SceMbM3k96SHOVadi3tN90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693309; c=relaxed/simple;
	bh=5TrM8BE/Q9zVkI/J+cwWOxB5KYYtsKrNhArQDv7AEHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sYFYoy0X3tPCQvQJD4e9G83NzAxv2FH1vOFqwecRwgh2L4J8XfgQgZoYJrOTY7m3wE4qjIZ8mG8+rCNaXcuzBgH8sMWrI+9LgrYVbg7qKKWp3oqfGAy0j9hHR29KbyNZjmG/7pUlGcwZ5XmD2YieYveisC0IQsZ06TBgI00lHNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaZo+Y5a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaZo+Y5a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAE61F000E9;
	Fri, 10 Jul 2026 14:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783693307;
	bh=fkXRukI/v0sAhUZzPcBOOgP065VWEzalz5+PXoJ6mM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jaZo+Y5agFI0v/yeRpK5K/Zdk2vSYuCL2piheZzA1PKAT3vudGSRWf0pdbF7megua
	 eBFJAC+0d0JinHDdE8i00yW10QiFa+cl554HDKyFIwRKGb9+W9/X4NXECRWR1kY5yn
	 18um2uXySwlVy4xOh6nRDtDjTBBF1pG+4UYJ2hd90/YcEk78/jdkZHkS5DQk5duw8t
	 d8IL/Ix0not4xax/2u8ckP6TGpudXJg9MnfqNcLfNr4juRzN/4gq3HGgNKQUgFPN4T
	 jXGx+ITFot6Oz5MuxZWPyPODI9KWSGF0vPUawkJeh3tSGXZ59awhivwezDmT6SCt29
	 tA1RsjP2A6G8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] can: isotp: use unconditional synchronize_rcu()
 in isotp_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260710-isotp-fixes-v4-1-2a4af437f61b@hartkopp.net>
References: <20260710-isotp-fixes-v4-0-2a4af437f61b@hartkopp.net>
 <20260710-isotp-fixes-v4-1-2a4af437f61b@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 14:21:46 +0000
Message-Id: <20260710142146.BDAE61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition during network device unregistration causes `isotp_=
release()` to skip CAN filter unregistration, leading to a memory leak and =
a Use-After-Free.
- [High] Data race on `so->rx.state` and `so->tx.state` between hrtimer cal=
lbacks and socket operations.
--

--- Patch [1]: [PATCH v4 1/2] can: isotp: use unconditional synchronize_rcu=
() in isotp_release() ---
commit 6feb0d6dc5d6600aa28544bf14c75b5f268d9b41
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: use unconditional synchronize_rcu() in isotp_release()

isotp_notify() unregisters the (RCU) CAN filters via can_rx_unregister()
and clears so->bound without waiting for a grace period. isotp_release()
uses so->bound to decide whether it needs to call synchronize_rcu()
before cancelling so->rxtimer. When NETDEV_UNREGISTER runs first, it
skips that synchronize_rcu() and can cancel the timer while an in-flight
isotp_rcv() is executing, leading to a use-after-free timer callback.

Link: https://lore.kernel.org/linux-can/20260707085210.6B6C01F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index c48b4a818297e..d30937345bcdc 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1237,11 +1237,18 @@ static int isotp_release(struct socket *sock)
>  						  SINGLE_MASK(so->txid),
>  						  isotp_rcv_echo, sk);
>  				dev_put(dev);
> -				synchronize_rcu();
>  			}
>  		}
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but could this cause a memory le=
ak
and a Use-After-Free during concurrent network device unregistration?

In isotp_release(), the socket is prematurely removed from the notifier lis=
t:

    list_del(&so->notifier);

If the device is concurrently being unregistered, this subsequent lookup fa=
ils:

    dev =3D dev_get_by_index(net, so->ifindex);
    if (dev) {

This failure causes the critical can_rx_unregister() steps to be skipped.

Since the socket is no longer on the notifier list, the subsequent
NETDEV_UNREGISTER broadcast will not call isotp_notify() to clean up the
filters either.

The socket memory is subsequently freed, leaving the stale filter in the
device's receiver list, which retains a dangling pointer to the socket,
leading to a Use-After-Free when a delayed CAN frame is processed.

[Severity: High]
This is a pre-existing issue, but does this non-atomic assignment race with
concurrent protocol state machine transitions?

In isotp_rx_timer_handler():

    so->rx.state =3D ISOTP_IDLE;

This modifies the RX state without holding so->rx_lock, racing with
concurrent CAN frame reception in sendmsg and softirq RX handlers.

For example, isotp_rcv() acquires the lock and begins processing a frame.
If isotp_rcv_cf() observes ISOTP_WAIT_DATA, it proceeds to cancel the timer.
hrtimer_cancel() blocks until the racing timer callback finishes. Once the
timer finishes, it has already changed the state to ISOTP_IDLE and signaled
an ETIMEDOUT error. However, isotp_rcv_cf() then resumes and processes the
frame into the buffer as if the state were still valid, hopelessly corrupti=
ng
the sequence.

A similar data race occurs on so->tx.state in isotp_tx_timer_handler():

    so->tx.state =3D ISOTP_IDLE;

This uses plain unprotected writes against concurrent atomic operations
(cmpxchg) and RX softirq modifications, leading to unexpected packet drops,
infinite wait stalls, and protocol failure.

> +	/* Always wait for a grace period before touching the timers below.
> +	 * A concurrent NETDEV_UNREGISTER may have already unregistered our
> +	 * filters and cleared so->bound in isotp_notify() without waiting
> +	 * for in-flight isotp_rcv() callers to finish, so this call must not
> +	 * be skipped just because so->bound is already 0 here.
> +	 */
> +	synchronize_rcu();
> +
>  	hrtimer_cancel(&so->txfrtimer);
>  	hrtimer_cancel(&so->txtimer);
>  	hrtimer_cancel(&so->rxtimer);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-isotp-fixe=
s-v4-0-2a4af437f61b@hartkopp.net?part=3D1
