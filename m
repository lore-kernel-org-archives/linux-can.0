Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795313051;
	b=hZduVRBdbvs3ckomTWwtbDrZds7Sh1W6uwnCk5Uma7b4uArjS/PKboSehXTSOZ74uHmi
	 lPl5umbwie70opJ00xOwT0JtES8BKH67QKXpFiPl99AshPFZ8vRXbRQuQBOa/dIneGl/3
	 23il16FLVFJmwBuzJGDopE5BGBXeHk+iWAk/oSM2vRR1po3g/jkjuH9+LTqRn45iY1T1h
	 U2AbsQEoPuLUIex8M1kv12ozWqtjXo7UcoixLH5E+rpyHHsJLpBxF6tp7GLAbjsNP7K3d
	 AKBN08AjUNZp79swlQA96iLJqdV9Cto5PFCclGPL1Z1j9wdmrLNeGKme5o6WqQtUNMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795313051;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oDlF75mqNGDi7dF3noxHqXASuXdbE2Ud6m7jvTJURjo=;
	b=3fFzfwXCDow+XBUus106SHzu2LItzIIRw27tS0idt1j6SxwYDm/lWQeYlYJ+AZr3+oZP
	 7ILYru978b7beu3LGnVr+KtrnT4H5gT/cig4WpBmTmo7tuwkZCD1UPJGTl7p+Fmx1xsnB
	 87E8LXSQOHL2Pkc0+MHeHsPa9B8IdBmFQFyN7qGfCFoy0YVbAaror12DEgh6J7Enbbx5i
	 EnNesZL0iSjPPHCEaAMnYm63a55xqGooRBccj5yRZQk4nZ936Rl/rtii6IP4Q4z7ZM0uW
	 1w5/laMPdJtEIAfO+fXOA8nqAuFfIg4DNFmV9M1BcTUurAihZi4U9cNP/31a1Vw7tYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ovjndt+H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCA4606A320
	for <linux-can@vger.kernel.org>; Sun, 22 Nov 2026 02:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ovjndt+H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684BF1F000C4;
	Sun, 22 Nov 2026 02:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795313050;
	bh=oDlF75mqNGDi7dF3noxHqXASuXdbE2Ud6m7jvTJURjo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ovjndt+HcU5eid/O2GiVl9blMmSR6Kt3rH8lA4EDmHIb1VvIj8OsYvZ/0YGWuNXHW
	 66sjwhBh27EZhzF4/9zFPee0PChBNnsrLYErN5FYAJp+k39nGyWQyXhmeBVvH4y7Mx
	 sCVWYs/3nncToTgmYlAi8tzNEnNv4DHMJtcc9QuqWlpbFX1TpTfCVyVQdy+iQ1HVs7
	 qRcUKJu3e5IU6JHCQ4QYlK0eGk5zUxG4iSAv+PEUfhC+ZUHsieEr/cKDCFSYHiW9k6
	 Kk45d2Q6May9m7/gUQvoAyYi/WdMZ8kIKQclnPY3SvbmMXxuHPj+MhYsn2K6rUNFyy
	 /plTjaMYcldLw==
Subject: Re: [PATCH v7 7/8] can: isotp: reject socket options while a transfer
 is active
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 mailhol@kernel.org, zhuling0805@qq.com, kuba@kernel.org
Date: Sun, 22 Nov 2026 02:04:10 +0000
Message-ID: <179531305000.3131.3851387722489339935@kernel.org>
In-Reply-To: <20261120-can-bcmlock-memcg-v7-7-f6b84f5257b1@hartkopp.net>
References: <20261120-can-bcmlock-memcg-v7-7-f6b84f5257b1@hartkopp.net>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch gates isotp_setsockopt_locked() (net/can/isotp.c, lines
  1733-1739) on tx.state/rx.state == ISOTP_IDLE.
- [Low] The commit message says that reading
  CAN_ISOTP_EXTEND_ADDR/CAN_ISOTP_WAIT_TX_DONE after the claim means…

--

can: isotp: reject socket options while a transfer is active

This patch makes isotp_setsockopt_locked() return -EAGAIN while
so->tx.state or so->rx.state is not ISOTP_IDLE, the same way
isotp_bind() already does. It also moves the reads of the
CAN_ISOTP_EXTEND_ADDR and CAN_ISOTP_WAIT_TX_DONE flags in
isotp_sendmsg() to after the transfer claim and the so->bound recheck.

Closes: https://sashiko.dev/#/bug/linux-d1d3ef49-c24e-4f3a-91ce-20f8fb222684

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 0b7db1ead7a90..642fec500af9d 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -1188,6 +1188,10 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>  		goto err_out_drop;
>  	}
>  
> +	/* read the options after the claim of the transfer */
> +	ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
> +	wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
> +

[Severity: Low]
The commit message says that reading these flags after the claim means
"all socket options used by isotp_sendmsg() are covered by this check".
Does that also hold for so->ll.tx_flags?

Later in isotp_sendmsg(), so->ll.tx_flags is read only after the state
has been published, the timer armed and rx_lock dropped:

	WRITE_ONCE(so->tx.state, new_state);
	hrtimer_start(tx_hrt, ktime_set(hrtimer_sec, 0),
		      HRTIMER_MODE_REL_SOFT);
	spin_unlock_bh(&so->rx_lock);

	/* send the first or only CAN frame */
	cf->flags = so->ll.tx_flags;

isotp_tx_timeout() takes no lock and can cmpxchg() tx.state back to
ISOTP_IDLE. That happens if the sending task is delayed past the 1s/2s
timeout after spin_unlock_bh(), for example by CFS bandwidth
throttling, RT starvation or a vCPU stall. A malformed or OVFLW FC
handled in isotp_rcv_fc() can reset the state in the same way.

Suppose the bound device is also unregistered in that window, so
isotp_notify() clears so->bound. isotp_setsockopt_locked() then passes
both the -EISCONN check and the new IDLE check. Its CAN_ISOTP_LL_OPTS
case does memcpy(&so->ll, ll, sizeof(*ll)) at the same time as the
plain read of so->ll.tx_flags above.

The impact looks limited to a data race on a single u8 that KCSAN can
flag. The device is already down by then, so can_send() rejects the
skb with -ENETDOWN.

Could cf->flags = so->ll.tx_flags be moved before the final
spin_lock_bh()/hrtimer_start() block, so that the commit message claim
holds?

[ ... ]

> @@ -1726,6 +1730,14 @@ static int isotp_setsockopt_locked(struct socket *sock, int optname,
>  	if (so->bound)
>  		return -EISCONN;
>  
> +	/* A transmission or reception that outlived a previous binding
> +	 * (unbound by NETDEV_UNREGISTER) may still be draining and uses the
> +	 * socket options, see isotp_bind().
> +	 */
> +	if (READ_ONCE(so->tx.state) != ISOTP_IDLE ||
> +	    READ_ONCE(so->rx.state) != ISOTP_IDLE)
> +		return -EAGAIN;
> +

[Severity: Low]
This comment points to isotp_bind(), which says "the FC/echo and RX
watchdog timers bound how long this takes". The commit message makes
the same point:

  As the transmission and the reception always end by their timeouts at
  the latest, this state is only temporary.

Is that accurate for the window in isotp_sendmsg() between the claim
and the final hrtimer_start()? Under rx_lock, isotp_sendmsg() cancels
all three TX timers and moves tx.state out of IDLE:

	hrtimer_cancel(&so->txfrtimer);
	hrtimer_cancel(&so->txtimer);
	hrtimer_cancel(&so->echotimer);
	...
	WRITE_ONCE(so->tx.state, ISOTP_SENDING);

It then calls memcpy_from_msg(), dev_get_by_index() and
sock_alloc_send_skb(). No timer is armed until
hrtimer_start(tx_hrt, ...) near the end of the function.

memcpy_from_msg() can block on a user page fault, for example with
userfaultfd or a FUSE-backed mapping. A blocking sock_alloc_send_skb()
can wait up to sk_sndtimeo, which defaults to MAX_SCHEDULE_TIMEOUT.

If NETDEV_UNREGISTER clears so->bound during that window, setsockopt()
and bind() would keep returning -EAGAIN until sendmsg() makes progress,
not just for a period bounded by a timer.

There is no memory-safety issue here. Could the comment and commit
message be updated to describe this case?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120-can-bcmlock-memcg-v7-0-f6b84f5257b1%40hartkopp.net
