Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071564;
	b=mKH5DChhbdBbsx6IdFIa1swif4T1/PGujgukyD0f6EJTzd2UgF27sepg8Jwy6YbUR0JU
	 CsdhG+X7w7CALqqdLG76BzS7hvYp0CPThqzNuu82YOHSa1e7ZE/31CFjg9CA2vETdK5Kw
	 bolB21vX184JlQUso2zSNBgHaxDcbqS996DaelLCpbH2eGGuGiuF5hXgGLHvtDyb8Wl5q
	 dmHKvuPa6Jy0/28LvpQBSICFquPBwS1TvtOhldRVW8qyZRZEEv/jYINBcIbzLNS4aE6nR
	 hlRDSgG0nA5ozBd13ZYpuarUyMm8yt2OKDr7hVQzONegtAaDuduTXsT0PqNALzQdUpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071564;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VfSM7D90CUOJ3PEG6hbEASD3E14Odl9blvw88Xfzrcw=;
	b=3e0tWhjf7AcxfPAIRlLqPulBWa3eSbp9uhh33FzoZtt0u7uUz1jzX/IBu5xhxuovD2cn
	 MVsTU6PizBKfqJWEb5mJkbUkmQsEFlByBDF8VEM9Tht43WpvEMNAIfCPhxSBasMUDIly1
	 wNZ+HEaDvLt6jvDV97yTGzQO1agLcxTKex5rI1iVdcvHqITarlajRWswccx7wWgyMPcHb
	 ypEyqJT5hGMKtOz0GYfmMqkly4Rq7HKwC3z8/wJoGUfWTFOBKc0bO6X+D/Kdg7zMKssnv
	 9lMVbF/c+qgnSl95Ya1UgRwMrMu362QhQcRVr2SSw2LBVEy1XzakwulI/4bAthst6Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d39QMCYA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F1F606A320
	for <linux-can@vger.kernel.org>; Thu, 19 Nov 2026 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d39QMCYA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9990E1F000C7;
	Thu, 19 Nov 2026 06:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795071564;
	bh=VfSM7D90CUOJ3PEG6hbEASD3E14Odl9blvw88Xfzrcw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=d39QMCYA222lLzKW3Wj8+cgDeCHpZoLop1Z7sfHYKo5bu0xPfhgGzd8Zz8EBXUctm
	 2T81EoiLMc1ezqczIXsSBqy+avc0JoLbKfySvA+f1XS7uwT/VRfbWuKRaPbm+Kdt6a
	 6Db2VXpGL5cLfeJuz007s3Q+oZ/4VjDGVkqM7fdWcbvdiBcVDeS87Ul1Tf9YQVmX0e
	 7V/d7WvdXhQU3XUOiCusEmLhjp4rsr/twlegNzWzpOWnTsgqlkGz1keTylSOlRPqnU
	 EeSHmBjWoSJmfNrjLope/fD7i52n11+u2smWy6D5KnxoZ1M6Ow6PEsaUDzDC1u0hSS
	 73vJIQwwML/Qg==
Subject: Re: [PATCH v6 7/8] can: isotp: reject socket options while a transfer
 is active
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 mailhol@kernel.org, zhuling0805@qq.com, kuba@kernel.org
Date: Thu, 19 Nov 2026 06:59:23 +0000
Message-ID: <179507156318.3132.6797739670423336759@kernel.org>
In-Reply-To: <20261117-can-bcmlock-memcg-v6-7-6826a6227d36@hartkopp.net>
References: <20261117-can-bcmlock-memcg-v6-7-6826a6227d36@hartkopp.net>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch says the new -EAGAIN in isotp_setsockopt_locked()
  (net/can/isotp.c:1732-1734) is "only temporary" because "the…
- [Medium] isotp_sendmsg() computes `ae` (CAN_ISOTP_EXTEND_ADDR) and
  `wait_tx_done` (CAN_ISOTP_WAIT_TX_DONE) from so->opt.flags in its…
- [Low] The patch carries a plain `Cc: stable@vger.kernel.org` with
  `Fixes: e057dd3fc20f` (2020) and no `# depends on` note.

--

can: isotp: reject socket options while a transfer is active

This patch makes isotp_setsockopt_locked() return -EAGAIN while
so->tx.state or so->rx.state is not ISOTP_IDLE, matching the check that
already exists in isotp_bind(). The goal is to stop setsockopt() from
changing so->opt, so->ll and so->tx.ll_dl under an isotp_sendmsg() that
keeps running after NETDEV_UNREGISTER has cleared so->bound.

Closes: https://sashiko.dev/#/bug/linux-d1d3ef49-c24e-4f3a-91ce-20f8fb222684

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 0293d590186c4..32c88749d75e7 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1725,6 +1725,14 @@ static int isotp_setsockopt_locked(struct socket *sock, int optname,
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

[Severity: Medium]
The commit message says:

  As the transmission and the reception always end by their timeouts at
  the latest, this state is only temporary.

Does that hold on the rx side? isotp_rcv_cf() cancels the rx watchdog
before it checks the frame length. Two of the early returns that follow
leave so->rx.state in ISOTP_WAIT_DATA and never re-arm the timer:

net/can/isotp.c:isotp_rcv_cf() {
    ...
	hrtimer_cancel(&so->rxtimer);
    ...
	/* CFs are never longer than the FF */
	if (cf->len > so->rx.ll_dl)
		return 1;

	/* CFs have usually the LL_DL length */
	if (cf->len < so->rx.ll_dl) {
		/* this is only allowed for the last CF */
		if (so->rx.len - so->rx.idx > so->rx.ll_dl - ae - N_PCI_SZ)
			return 1;
	}
    ...
}

The earlier patch in this series, "can: isotp: always start the rx
timeout in ISOTP_WAIT_DATA state", adds hrtimer_start() in isotp_rcv_ff()
and after the CF data copy. It does not cover these returns.

While the socket is bound, a later SF or FF resets the state. But
isotp_notify() for NETDEV_UNREGISTER unregisters isotp_rcv() and
isotp_rcv_echo() and clears so->bound. It does not reset rx.state or the
timers:

net/can/isotp.c:isotp_notify() {
    ...
		so->ifindex = 0;
		WRITE_ONCE(so->bound, 0);
		WRITE_ONCE(so->dev, NULL);
    ...
}

After that, only isotp_release() writes rx.state.

Here is one sequence. A remote peer sends an FF and then a short CF that
is not the last one. On CAN FD, a CF longer than the FF's LL_DL has the
same effect. Then the device goes away, for example a USB adapter is
unplugged or a vcan is deleted.

Can rx.state then stay in ISOTP_WAIT_DATA for good? If so, every later
setsockopt() on the unbound socket returns -EAGAIN until the socket is
closed. isotp_bind() has the same state check, so the socket could not
be rebound either. Before this patch, setsockopt() on an unbound socket
always succeeded.

[Severity: Medium]
Does this fully close the option-change race the commit message
describes? isotp_sendmsg() reads two values from so->opt.flags in its
declarations. This happens before the so->bound check and before
so->tx.state is claimed:

net/can/isotp.c:isotp_sendmsg() {
    ...
	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
	int wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
    ...
	/* so->bound is only checked once above - a wakeup may have
	 * unbound/rebound the socket meanwhile => recheck
	 */
	if (!READ_ONCE(so->bound)) {
		err = -EADDRNOTAVAIL;
		goto err_out_drop;
	}
    ...
}

The new check only covers the window after tx.state has been claimed.
The recheck after the claim only tests so->bound. Consider:

Thread A (bound socket)
isotp_sendmsg()
    reads ae and wait_tx_done
    is preempted, or waits in the claim loop behind another transfer

NETDEV_UNREGISTER
isotp_notify()
    WRITE_ONCE(so->bound, 0);

Thread B (same socket, tx and rx idle)
setsockopt(CAN_ISOTP_OPTS)
    toggles CAN_ISOTP_EXTEND_ADDR, passes the new check
bind() to another device
    passes the idle check, so->bound = 1

Thread A
    claims tx.state = ISOTP_SENDING
    the recheck sees so->bound == 1
    builds the SF/FF with the old ae

isotp_send_cframe() and isotp_rcv() recompute ae from the new
so->opt.flags:

net/can/isotp.c:isotp_send_cframe() {
    ...
	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
    ...
}

So the SF/FF and the CFs/FCs of the same PDU would disagree on the
extended address byte. Also, wait_tx_done would no longer match the
configured flags.

This does not corrupt memory: the frame indices are bounded by
so->tx.ll_dl and so->tx.len, which are read after the claim. Could ae
and wait_tx_done be computed after the claim and the bound recheck
instead?

[Severity: Low]
This patch has a plain "Cc: stable@vger.kernel.org" with
"Fixes: e057dd3fc20f". But the argument that the -EAGAIN is only
temporary depends on the earlier series patch "can: isotp: always start
the rx timeout in ISOTP_WAIT_DATA state".

Without that patch, isotp_rcv_ff() in CAN_ISOTP_LISTEN_MODE returns
before any rxtimer is started. isotp_rcv_cf() also does not restart the
timer at a block boundary when no FC is sent. That patch's own commit
message says this leaves rx.state in ISOTP_WAIT_DATA "until the socket
is closed" once the device is gone.

If this patch is backported alone, would this -EAGAIN become permanent
for those sockets?

The commit message also says:

  isotp_bind() already rejects a new binding while so->tx.state or
  so->rx.state are not ISOTP_IDLE for the same reason.

That check in isotp_bind() was added by commit 20bab8b88baac1 in July
2026, so older stable trees probably don't have it.

Other patches in this series use "Cc: stable@vger.kernel.org # depends
on ...". For example, "can: bcm: use a private mutex instead of
lock_sock()" depends on "can: bcm: copy the CAN frames outside of
lock_sock()". Should this patch have a similar dependency note?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117-can-bcmlock-memcg-v6-0-6826a6227d36%40hartkopp.net
