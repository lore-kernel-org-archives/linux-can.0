Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5BF2989B5
	for <linux-can@vger.kernel.org>; Sun, 12 Jul 2026 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783880152; cv=none; b=ruQMsocO9Mb8Dftkgg6F18KAffGu9ESVpOkjBpHbKlftwjQZT0fMl1PFO6iJVXozwr00WWyfL7VaAWjZ8XdBaqVfgNUv8cVd+ZUPZWAcJxllEfjK/sJbHe7jGopnf8D0l1YvVsyT2Ym/z3KqFnZQsaCQuLBBVKUYUpuSddFuY+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783880152; c=relaxed/simple;
	bh=DACpVZzWyw45/8NuXAYSBqex+d0pRVSzQyASXaNMpPs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jYicSSBI9IcVKpjpMPetGd2pgsO6iZ116AHVg2S5e4g1rsOuZkws8ev6Rrp5dNWmKgzsYD6HQNYS4oZUPN7KjwWaEhjEB+uref5wg4aM7ZFS8o3vroWbVC57dGJMhbma5KrNyBESxUx6Iu99Q4BzZTQz8rlyH2v1evDp9pLeARk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIYJloRH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIYJloRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAB21F000E9;
	Sun, 12 Jul 2026 18:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783880150;
	bh=y6lxMd9j10Z9ybS4NcELMubo/K6K1SidgcqmRNsEOF0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kIYJloRHSSc5rTGEMQOSe9Sod/vQmTO6S1CvdZ/w4/x8jrGyrUCUsEdPPawLLdPGj
	 byqUSn0WHhhIkZPXzK3m1lhY5yuQja75zHUnzx5DbCTC3cC754uTRPlJSSYbWDe6GS
	 HndgXW3jLXOeFP5LbM6bvNpRMLPa1b+xLIkkGo4XX2W6K+LLlnAwkvGj+9WR4iwBzJ
	 AUUozgpgTUoB8kjbBRDgKCiuGF8fWioAoeUoUo6JTss2e5f2TM3ySucqOjs+lVe96j
	 W0b4/he/BGctajYP9G8Xm/0QgCEDX+rZYCZEZt7kpAd/yY2uzEJJNHSpIJxaWZa+fM
	 ipqhBX6NR7iQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/3] can: isotp: use unconditional synchronize_rcu()
 in isotp_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260712-isotp-fixes-v10-1-793a1b1ce17f@hartkopp.net>
References: <20260712-isotp-fixes-v10-0-793a1b1ce17f@hartkopp.net>
 <20260712-isotp-fixes-v10-1-793a1b1ce17f@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 18:15:49 +0000
Message-Id: <20260712181550.4BAB21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] CAN filter leak in isotp_release() during concurrent netdevice unr=
egistration leading to Use-After-Free.
- [High] Missing synchronization and state cleanup in isotp_sendmsg error p=
ath causes data corruption when racing with CAN echo frames.
--

--- Patch [1]: [PATCH v10 1/3] can: isotp: use unconditional synchronize_rc=
u() in isotp_release() ---
commit fa3db7e87e5eabd37c1bb7bc38aae86169f62182
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: use unconditional synchronize_rcu() in isotp_release()

This commit adds an unconditional synchronize_rcu() in isotp_release()
before cancelling timers. It addresses a race condition where a
concurrent NETDEV_UNREGISTER could cause a use-after-free in the timer
callback on the freed socket.

Closes: https://lore.kernel.org/linux-can/20260707085210.6B6C01F000E9@smtp.=
kernel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index c48b4a818297e..d30937345bcdc 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1237,11 +1237,18 @@ static int isotp_release(struct socket *sock)
>  						  SINGLE_MASK(so->txid),
>  						  isotp_rcv_echo, sk);
>  				dev_put(dev);

[Severity: High]
This is a pre-existing issue, but is there a potential CAN filter leak here
that could lead to a use-after-free?

If a user closes the ISOTP socket exactly when the bound netdevice is being
unregistered, unlist_netdevice(dev) is called before the NETDEV_UNREGISTER
notifiers.

If isotp_release() runs in this window, it removes the socket from
isotp_notifier_list and calls dev_get_by_index(). Since the device is
unlisted, dev_get_by_index() returns NULL, causing isotp_release() to skip
can_rx_unregister().

Because the filter is left active, any matching CAN frames subsequently
processed by the unregistering device might trigger isotp_rcv() with the
freed socket pointer. Does the newly added synchronize_rcu() below prevent
this if the filter is never actually unregistered?

> -				synchronize_rcu();
>  			}
>  		}
>  	}
> =20
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

[Severity: High]
This is a pre-existing issue, but does the error path in isotp_sendmsg()
properly clean up the echo state when interrupted by a signal?

If a user initiates a blocking transfer with wait_tx_done enabled, and it
is interrupted by a signal, the err_event_drop path forcefully sets
so->tx.state =3D ISOTP_IDLE without clearing so->cfecho or waiting for the
in-flight CAN hardware echo:

net/can/isotp.c:isotp_sendmsg() {
[ ... ]
err_event_drop:
        /* got signal: force tx state machine to be idle */
        so->tx.state =3D ISOTP_IDLE;
        hrtimer_cancel(&so->txfrtimer);
        hrtimer_cancel(&so->txtimer);
[ ... ]
}

When the background echo frame arrives, isotp_rcv_echo() matches the stale
so->cfecho and unconditionally continues transmission by reading from
so->tx.buf and incrementing so->tx.idx:

net/can/isotp.c:isotp_rcv_echo() {
[ ... ]
        if (skb->sk !=3D sk || so->cfecho !=3D *(u32 *)cf->data)
                return;
[ ... ]
        if (!so->tx_gap) {
                /* enable echo timeout handling */
                hrtimer_start(&so->txtimer, ktime_set(ISOTP_ECHO_TIMEOUT, 0=
),
                              HRTIMER_MODE_REL_SOFT);
                isotp_send_cframe(so);
                return;
        }
[ ... ]
}

Concurrently, the user can call sendmsg() again since the state is IDLE,
overwriting the buffer and lengths without locks. Could this time-of-check
to time-of-use race cause the background softirq to read corrupted indices
and result in out-of-bounds memory accesses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-isotp-fixe=
s-v10-0-793a1b1ce17f@hartkopp.net?part=3D1
