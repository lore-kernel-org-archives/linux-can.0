Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368902;
	b=PcJh9HS6WnHdMJWvbB6EBucQdXcGnZjWk4HQqOySq7PIHjO+nO+5MnT0HsHbZ02p1ArF
	 6nMH7fkpe70c+9UsUth12tCvCnG4mSGVxedUg1dbh1ZuC3PiAy2dkbuKKcajTVj8UzgjW
	 qKx1Z5cQMr/pdqBIAKMJwOcaVgZ/Vvcn1n260vG7zOoPgGmn661Y+Cn5Sdc1VQJ1SZXyG
	 yenz0UtmKQ+G7NdA0/fgS+hJlTTDuhrJQa4DBICNuRImwhs+UHGXMX+VNtpynrU+g7OCL
	 0Q5BhJBI9eUQCy86oDH9LgfA4g2EpJd5f3+VYEJrSeD3hz50eQ51zgPCt7uabSzCxpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368902;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=8MugCmGZ4cK60f5hecujTUnNRYO5tymPTKM8TTppB2A=;
	b=ey1eYE3o2jvqssfHPIeX8rQvXCR/dBe6hAQw7H3sY7+45AqSe6abEIR5YFHPTfiAGKjA
	 4oMlGfvzRNVNmyOHsWiAj6kFv9xIxsK511hg4j62FGIAik39zHHK6a0KzDFbvuD5RrRpI
	 1TmxBfK75HZQt9n5c2L8U1s/sAsUpaYmG/+0cURfpIFoPIQPFdD/zTZ11bzvErnzgK4Q/
	 HSzUclU5oc5r4LONPsIvFMZqR+m1Jk3/89olSI65wJEpaiygsZXI+xiiAGZEIr2hn6XBq
	 RN9dYpo7ZRaUAq9/gsfo0Y9J+IsRzi9NGWhb0k2pH89RXJO0DG0YCyWyw1SyHlW3FZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gVjoAVxC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571D6606A32A
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 03:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gVjoAVxC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9391F0093C;
	Wed, 11 Nov 2026 03:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368901;
	bh=8MugCmGZ4cK60f5hecujTUnNRYO5tymPTKM8TTppB2A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gVjoAVxCxP2J+GM5sVKahXTkBRibxZt1pSqnQXsKl/KXWoZq8KFCZMiozfDVUH2xw
	 Z7Tr3C/cloBotdCEOxMYfVIODY8zJDx63Mw4v9aQrCCKuWV95v/cdWEIl6G/v81fKJ
	 5vZZfGamf3iuzq7grlpd6Wndf3AO83gov1yQT+pQi/FDkA5JJlwn6helfYuwL446I4
	 GFVLy0DvP9xZTPqtO/dlPCTlYGAYXDIK+XLkZm8GyzqYnJcr33s6MRbqdHyKlKyh4v
	 DWmpNOhUfcdpo3QfUQMmqETg2v3RUhuAFDv//1O34LrtbWoI5j0Bmxl+KG9j+4AchW
	 Lx+3zV15otLXQ==
Subject:
 Re: [PATCH net v8 1/2] can: j1939: account for timer references across rearm
From: netdev-bot+sashiko@kernel.org
To: zihanx@nebusec.ai
Cc: linux-can@vger.kernel.org, robin@protonic.nl, o.rempel@pengutronix.de,
 kernel@pengutronix.de, socketcan@hartkopp.net, mkl@pengutronix.de,
 bst@pengutronix.de, lkp@intel.com, maxime.jayat@mobile-devices.fr,
 ecathinds@gmail.com, vega@nebusec.ai, kuba@kernel.org
Date: Wed, 11 Nov 2026 03:48:20 +0000
Message-ID: <179436890073.488853.351945341699455054@kernel.org>
In-Reply-To: <20261109131624.276943-2-zihanx@nebusec.ai>
References: <20261109131624.276943-2-zihanx@nebusec.ai>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message ("account for timer references across
  rearm") understates what this stable-tagged patch does.
- [Low] The commit message names neither the leak trigger nor its impact.
- [Low] In j1939_simple_txnext(), the J1939_SIMPLE echo timeout is now
  armed only after a successful send (j1939_send_one at line 1286, then…

--

can: j1939: account for timer references across rearm

This patch makes each j1939 session timer hold one session reference for
its whole queued and running lifetime, instead of taking one on every
hrtimer_start(). It adds per-timer locks, shutdown flags and canceler
counts so that rearming and cancellation are synchronized with terminal
state changes, and it arms the simple-TX echo timeout only after a
successful send.

Link: https://bugtracker.nebusec.ai/f/11143

> Rearming a session timer updates the existing hrtimer rather than
> creating another callback. Taking a session reference for every start
> can therefore leave references behind when the timer is rearmed.

[Severity: Low]
Could the commit message name the trigger and the impact here?

Before this patch, the receiver do_cts_eoma branch of
j1939_xtp_rx_dat_one() calls j1939_tp_schedule_txtimer() without
cancelling first:

	} else if (do_cts_eoma) {
		j1939_tp_set_rxtimeout(session, 1250);
		if (!session->transmission)
			j1939_tp_schedule_txtimer(session, 0);

The old j1939_tp_schedule_txtimer() called j1939_session_get() and then
hrtimer_start(). Several TP.DT frames that satisfy pkt.rx >= pkt.last can
be processed before the txtimer softirq runs, for example duplicates of
the last packet in one NET_RX batch. Each of those calls takes a
reference, but the single callback drops only one.

The session is then never freed, so j1939_session_destroy() never reaches
netdev_put() and j1939_priv_put(). The session memory leaks and the CAN
net_device stays pinned, which can hang unregister_netdevice(). A remote
CAN node can trigger this.

> Track one session reference across each timer's queued and running
> lifetime. Apply the same accounting to the RX timer and synchronize
> rearming and cancellation with terminal state changes. Arm the simple-TX
> echo timeout only after a successful send, and keep terminal session
> transitions from leaving stale timer references or changing the result.

[Severity: Medium]
Is this description complete for a patch tagged Cc: stable? Besides the
timer reference accounting, several changes in net/can/j1939/transport.c
are visible to userspace. "changing the result" only hints at them.

j1939_xtp_rx_abort_one(): a peer abort that arrives in
J1939_SESSION_WAITING_ABORT no longer overwrites session->err. It also no
longer calls j1939_sk_send_loop_abort() or queues J1939_ERRQUEUE_RX_ABORT:

	} else if (!rxtimer_shutdown &&
		   session->state == J1939_SESSION_WAITING_ABORT) {
		...
		deactivate = j1939_session_deactivate_locked(session);

Peer aborts are also ignored completely once rxtimer_shutdown is set.

j1939_session_completed(): this now returns early unless the state is
J1939_SESSION_ACTIVE. An EOMA, or the final BAM TP.DT, that arrives after
a local abort no longer completes the session. The reassembled data is
not delivered through j1939_sk_recv() either:

	if (!completed)
		return;

j1939_session_cancel(): J1939_ERRQUEUE_RX_ABORT is now queued only when
the call wins the transition. Before, it was queued on every call:

	if (cancelled && !session->sk)
		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);

j1939_tp_schedule_txtimer() and j1939_tp_set_rxtimeout() now silently
refuse to arm for non-active sessions, or while a cancel is pending.

j1939_tp_rxtimer(): the simple message echo timeout path now calls
j1939_sk_queue_activate_next(). The old code only called
j1939_session_deactivate().

Several netdev_alert() messages are now printed only when the caller wins
the state transition.

The follow-up commit "can: j1939: serialize TX with session shutdown"
does not describe these changes either.

Could these changes be spelled out in the commit message, or split into
separate patches? That would let stable backporters see which
userspace-visible changes are part of the fix.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..c327fd9618a0c 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c

[ ... ]

> @@ -1082,12 +1283,12 @@ static int j1939_simple_txnext(struct j1939_session *session)
>  
>  	can_skb_set_owner(skb, se_skb->sk);
>  
> -	j1939_tp_set_rxtimeout(session, J1939_SIMPLE_ECHO_TIMEOUT_MS);
> -
> -	ret = j1939_send_one(priv, skb);
> +	ret = j1939_send_one(session->priv, skb);
>  	if (ret)
>  		goto out_free;
>  
> +	j1939_tp_set_rxtimeout(session, J1939_SIMPLE_ECHO_TIMEOUT_MS);
> +

[Severity: Low]
Can this leave a J1939_SIMPLE session in J1939_SESSION_ACTIVE with no
timer armed?

If j1939_send_one() fails with -ENETDOWN, the code jumps to out_free and
the echo timeout is never armed. j1939_tp_txtimer() then does nothing for
that error, because it expects a later netdev event to clean up:

	case -ENETDOWN:
		/* In this case we should get a netdev_event(), all active
		 * sessions will be cleared by j1939_cancel_active_session().

That expectation does not hold if the interface was already down before
the session was created. On the path
j1939_sk_sendmsg()->j1939_sk_send_loop()->j1939_tp_send(), no function
checks IFF_UP. j1939_session_activate() checks only the registration
state:

	} else if (priv->ndev->reg_state != NETREG_REGISTERED) {
		ret = -ENODEV;

j1939_sk_netdev_event_netdown() leaves ENETDOWN in sk_err. The first
sendmsg consumes it through sock_error() in sock_alloc_send_skb(). A
second sendmsg then activates a simple session, and can_send() returns
-ENETDOWN.

Before this patch, the pre-armed echo timeout fired after
J1939_SIMPLE_ECHO_TIMEOUT_MS, set session->err = -ETIME, and deactivated
the session. Now the session stays on priv->active_session_list until
socket close, NETDEV_UNREGISTER or another down event.

The old rxtimer path also left the session at the head of the socket's
sk_session_queue, because it did not call
j1939_sk_queue_activate_next(). So the socket queue stall is not new.

The follow-up commit "can: j1939: serialize TX with session shutdown"
keeps this ordering.

Would it make sense to also arm the echo timeout, or deactivate the
session, when the send fails with -ENETDOWN?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109131624.276943-1-zihanx%40nebusec.ai
