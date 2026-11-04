Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817504;
	b=pdDRkPF1lpnBvajDTT3vsmtrN9ds5UZHcHMYdL1tFCTScZ316Ix9XwWWgGxOIMYvdH36
	 tatr1EIdmmpc8Rpx+Owmb0423ObnaSTxbwDVVFA3jPTXB7+P7atYA7UY9y7j7Rd+vHKCt
	 yEjkzr+oS0D0zSP/kHX5IzjcK1qezho4/QGjmnuVIsjN8ZpyXg496O5x9zqGBKPbRTL1W
	 VrsBYnNBEMUNEO1TlANRKmJmmCmXyWXhp2F3vdQmVBbpqr2zmARQ/dMhDgf6aCfGjOYIj
	 zVZPNmGufQ00u6oRuiWnIGOodIyvV4T31oNrRbreJh4aTnUw592A9RhN7jCxi67pRMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817504;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+ABLMxbrBEy79TVflAp78O366Ekt0yBCOru/H8veL8I=;
	b=cG9lZAuOFMWeB9gW6TyQLNs1xoTzL4t5FoWnbyr6kV12WGid51sE74PdY2iZS714XBa5
	 GnSq7jWPoGS9qOJGpSLZHmllhlpEuAlberrO4YGklGbgPUx3OW4pYeoX5ppr9FKBUH8MC
	 8wyuJC/0bD+kaWs2qSmNJf2znEhAzL3VtVgv+BG2BIBhtDbMbbRj3jzQk1y26rMJmJxeQ
	 CeUpHnQm7FZcpoJVprssk4dFkXjFcjkm3fN/jtCh36pVRpr0PC7RBtIv8ziAV15EWkl90
	 KxUD3cAdM+Egsz9ETWXyGnaoo8LDBB6APnFiZOwBUEAhQWYwWRU7NPwlnk2XRcIpj7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AxqAUSQW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9EB606A326
	for <linux-can@vger.kernel.org>; Wed,  4 Nov 2026 18:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AxqAUSQW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D998A1F000C1;
	Wed,  4 Nov 2026 18:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793817503;
	bh=+ABLMxbrBEy79TVflAp78O366Ekt0yBCOru/H8veL8I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AxqAUSQWDza7BF5XclsPia3uLV7VwnGqFV1ePhF+utIMvbQkPUIELEtN0cEh9ITi0
	 5miYwcGGy92p3qA8Ljtsdzv+iLDxJAHsdAeGw1wN+kS2lbsQmEddgcDkuodW/K/I9T
	 lvyJARVpCT8XeZcy8i6ZZIhdHoHXlXVTIPecxkuPsQrpoeTYWLXQWD7w0X3z7QnfJs
	 pk+QIJuUT5vKtxJ3DhU7ozpyjBjQs57ZCANJe/nSeHK+GDa4AMQK8iusezwjYMYLzm
	 ZwqZ20tvhR1kq3yOMsJO/jy2pKV9moYASIEiOWH7BJ3uMOyW7j1M6XFdumxlZQNRkX
	 FsWU1bRXFe3Ag==
Subject: Re: [PATCH net v5 1/3] can: j1939: fix TX timer reference accounting
From: netdev-bot+sashiko@kernel.org
To: zihanx@nebusec.ai
Cc: linux-can@vger.kernel.org, robin@protonic.nl, o.rempel@pengutronix.de,
 kernel@pengutronix.de, socketcan@hartkopp.net, mkl@pengutronix.de,
 ecathinds@gmail.com, bst@pengutronix.de, lkp@intel.com,
 maxime.jayat@mobile-devices.fr, vega@nebusec.ai, kuba@kernel.org
Date: Wed, 04 Nov 2026 18:38:22 +0000
Message-ID: <179381750240.488853.5715558061683000544@kernel.org>
In-Reply-To: <fe402cff5706b3162d4e8aec02cc62dd7fa0b303.1793681851.git.zihanx@nebusec.ai>
References: <fe402cff5706b3162d4e8aec02cc62dd7fa0b303.1793681851.git.zihanx@nebusec.ai>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The TX-timer pin can be lost while the timer is still queued.
- [Medium] The subject and body describe only reference accounting.
- [Low] The commit message says what the new accounting scheme does but
  not what is broken, how it is triggered, or what users see.
- [Low] In struct j1939_session (net/can/j1939/j1939-priv.h), the comment
  "One reference pins the complete queued/running timer lifetime." sits…

--

can: j1939: fix TX timer reference accounting

This commit drops the session reference that j1939_tp_schedule_txtimer()
took on every arm. Instead it uses one txtimer_ref pin, protected by a new
txtimer_lock. It also adds a txtimer_shutdown latch and a canceler counter
so the cancel, deactivate and abort paths stop the TX timer and keep it
from being re-armed.

Link: https://bugtracker.nebusec.ai/f/11143

> can: j1939: fix TX timer reference accounting
>
> Keep one session reference across the complete queued and running lifetime
> of the TX timer. Re-arming an active timer reuses this pin; cancellation
> or callback completion drops it only after no successor remains queued.

[Severity: Low]
Could the commit message describe the bug being fixed and how it is
triggered?

Before this patch, j1939_tp_schedule_txtimer() took a session reference on
every hrtimer_start(). j1939_xtp_rx_dat_one() re-arms the receiver's txtimer
without cancelling it first:

net/can/j1939/transport.c:j1939_xtp_rx_dat_one() {
    ...
	} else if (do_cts_eoma) {
		j1939_tp_set_rxtimeout(session, 1250);
		if (!session->transmission)
			j1939_tp_schedule_txtimer(session, 0);
    ...
}

A second qualifying DAT frame from the remote peer passes the checks
(last_cmd is 0xff and pkt.rx + 1 <= total) and sets do_cts_eoma again. If
that frame is handled before the soft timer fires, the queued timer is
re-armed and one session reference leaks.

The leaked session keeps its netdev tracker and j1939_priv references.
These are released only in j1939_session_destroy(), so the result is a
permanent leak and an "unregister_netdevice: waiting for canX" hang.

This is tagged for stable. Could the message say that a remote peer can
trigger this, and what the user sees?

> diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
> index cf26352d1d8ce..c95fca38b8b15 100644
> --- a/net/can/j1939/j1939-priv.h
> +++ b/net/can/j1939/j1939-priv.h

[ ... ]

> @@ -290,6 +291,11 @@ struct j1939_session {
>  		unsigned int dpo;
>  	} pkt;
>  	struct hrtimer txtimer, rxtimer;
> +	unsigned int txtimer_cancelers; /* block starts while a cancel waits */
> +	spinlock_t txtimer_lock;
> +	/* One reference pins the complete queued/running timer lifetime. */
> +	bool txtimer_shutdown;
> +	bool txtimer_ref;
>  };

[Severity: Low]
This isn't a bug, but the comment sits above txtimer_shutdown while it
describes txtimer_ref on the next line.

The "running" part also promises more than the code does.
j1939_tp_txtimer() clears txtimer_ref and calls j1939_session_put() at
txtimer_done, while the callback is still executing:

	if (!queued && session->txtimer_ref) {
		session->txtimer_ref = false;
		put_ref = true;
	}
	...
	if (put_ref)
		j1939_session_put(session);

	return HRTIMER_NORESTART;

So any context that touches the session after a callback completes needs
its own reference.

Could the header also say what txtimer_lock protects? It would also help
to note that txtimer_shutdown is a one-way latch that permanently blocks
j1939_tp_schedule_txtimer().

The misplaced comment is still there at the end of the series.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..4958f7c47ca44 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -301,9 +301,78 @@ void j1939_session_put(struct j1939_session *session)
>  	kref_put(&session->kref, __j1939_session_release);
>  }
>  
> -static void j1939_session_txtimer_cancel(struct j1939_session *session)
> +static void j1939_session_txtimer_cancel(struct j1939_session *session,
> +					 bool shutdown)
>  {
> -	if (hrtimer_cancel(&session->txtimer))
> +	bool put_ref = false;
> +	int ret;
> +

[ ... ]

> +	/* Never wait for a softirq callback while holding txtimer_lock. */
> +	if (ret < 0) {
> +		ret = hrtimer_cancel(&session->txtimer);
> +		if (ret == 1) {
> +			spin_lock_bh(&session->txtimer_lock);
> +			if (!WARN_ON_ONCE(!session->txtimer_ref)) {
> +				session->txtimer_ref = false;
> +				put_ref = true;
> +			}
> +			spin_unlock_bh(&session->txtimer_lock);
> +		}
> +	}

[ ... ]

> +static bool
> +j1939_session_txtimer_cancel_async_locked(struct j1939_session *session)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&session->txtimer_lock);
> +	session->txtimer_shutdown = true;
> +	ret = hrtimer_try_to_cancel(&session->txtimer);
> +	/* Let a queued successor finish promptly after callback exit. */
> +	if (ret < 0 && session->txtimer_ref &&
> +	    hrtimer_is_queued(&session->txtimer))
> +		hrtimer_start(&session->txtimer, 0, HRTIMER_MODE_REL_SOFT);

[Severity: High]
Can the TX timer end up queued with no session reference here?

The hrtimer_is_queued() check and the hrtimer_start() are ordered only by
txtimer_lock. The second phase of j1939_session_txtimer_cancel() drops
txtimer_lock and then calls hrtimer_cancel(). The race needs three CPUs:

CPU C: j1939_tp_txtimer()
    queues a successor (tx_dat pdelay re-arm or -ENOBUFS retry)
    txtimer_done: queued == true, keeps txtimer_ref, returns

CPU A: j1939_session_timers_cancel(), or the cancel in
       j1939_xtp_rx_cts_one() / j1939_xtp_rx_rts()
    j1939_session_txtimer_cancel()
        hrtimer_try_to_cancel() returns -1 (C is running)
        drops txtimer_lock, spins in hrtimer_cancel()

CPU B: j1939_cancel_active_session() (from j1939_sk_release() or the
       netdev notifier), j1939_session_deactivate() or
       j1939_session_cancel()
    j1939_session_txtimer_cancel_async_locked()
        hrtimer_try_to_cancel() returns -1 (C is running)
        sees txtimer_ref == true and hrtimer_is_queued() == true

C then returns. A's hrtimer_cancel() removes the queued successor and
returns 1.

B is still acting on its earlier hrtimer_is_queued() result. It calls
hrtimer_start(), which queues the timer again, and returns false without
dropping a reference.

A then takes txtimer_lock, sees txtimer_ref still true, clears it and
calls j1939_session_put(). Nothing re-checks whether the timer was
queued again in the meantime.

Suppose the remaining references (A's lookup reference, the active list
reference dropped by deactivate, the socket queue reference) reach zero
before the 0ns soft timer runs. Wouldn't j1939_session_destroy() then free
the session while its hrtimer is still in the per-CPU hrtimer queue?

That would be a use-after-free or hrtimer rbtree corruption. If the
session survives, the callback still hits
WARN_ON_ONCE(!session->txtimer_ref).

On PREEMPT_RT, spinlock_t holders can be preempted, which makes this
window much wider.

Could the phase 2 removal in j1939_session_txtimer_cancel() be serialized
against this restart? Another option is to re-check the queued state
before dropping the pin.

The later patches in the series ("cancel TX timer after RX timeout" and
"serialize session TX with state changes") do not change these functions.

[ ... ]

> @@ -716,9 +785,29 @@ static int j1939_xtp_tx_abort(struct j1939_priv *priv,
>  
>  void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec)
>  {
> -	j1939_session_get(session);
> +	j1939_session_list_lock(session->priv);
> +	if (session->state != J1939_SESSION_ACTIVE) {
> +		j1939_session_list_unlock(session->priv);
> +		return;
> +	}
> +
> +	spin_lock(&session->txtimer_lock);
> +	if (session->txtimer_cancelers || session->txtimer_shutdown) {
> +		spin_unlock(&session->txtimer_lock);
> +		j1939_session_list_unlock(session->priv);
> +		return;
> +	}

[Severity: Medium]
The subject and commit message cover only reference accounting. This patch
also changes the TX timer lifecycle in ways other nodes can see on the
bus. Should the message describe these changes, or should they go in a
separate patch?

The new rules are:

j1939_tp_schedule_txtimer() now returns silently, with no error to the
caller, unless the state is J1939_SESSION_ACTIVE, txtimer_shutdown is
clear and txtimer_cancelers is 0.

j1939_tp_txtimer() now skips all TX work (RTS, CTS, DAT, EOMA and simple
send) when txtimer_shutdown is set or the state is not ACTIVE:

	if (shutdown || !can_rearm)
		goto txtimer_done;

j1939_session_deactivate() and j1939_session_cancel() now set
txtimer_shutdown and call j1939_session_txtimer_cancel_async(). Before
this, a queued txtimer stayed armed and could still put frames on the bus.

j1939_session_timers_cancel() now passes shutdown=true, which latches
txtimer_shutdown for good. j1939_session_deactivate_locked() sets
txtimer_shutdown even when the session is not active.

Together these fix a separate bug that the message does not mention: TX
frames being sent on a session already in WAITING_ABORT or DONE. Having it
inside a stable refcount fix makes bisecting and backporting harder.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793681851.git.zihanx%40nebusec.ai
