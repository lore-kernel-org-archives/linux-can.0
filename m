Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261B7491589;
	Sat, 10 Oct 2026 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791640973; cv=none; b=Qaauu93fBV8ApPFwm9jyan18CaKPgI6p5ASCiHZSC15R7aGTOyUHNGa2rcLgnCjutfXcwfX4SpVj8WymtB9f6VQlew/h48JSWs93UN5hRSAYRdBJbSzoXwmcb8dLIqTVUydoTw2673Szew3UdS2Qhxr7DS2J007bI26jFNgVGjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791640973; c=relaxed/simple;
	bh=DXHCGwj+5VzB922dMmHTM62omAUeddMs9mFQ7Tf4YKo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IFL/XHkySHhxRFXhKS+F9GyxxX1lCPN1zR6BI0YqE5xsuEVww8NCyHZ/p8cmawgKrgiEvsu61MDG6HWH9SwdOVz4ngvDxztX3GlflN1b03uHjYyVyUgwSqSikWyzndzSU1EY1m8AMVZEfvbvsKMGj6JpqGgO2icDTcMNX3fz7aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iidx2GIy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iidx2GIy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F44C1F000FF;
	Sat, 10 Oct 2026 14:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791640971;
	bh=bcNkVhzr1qoNj8l56Xmw4FJaWoMKBSzwad62JjcB3r0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Iidx2GIyUQUiJuGp7gxMncd2jWjfqs4l7qIqoHkmmL9C/aH3wkOeZ2x2657dZUAu6
	 IThTSzjxY9Qu1wh2yuuEv2bNrW3WUi2lyCZJhJshZbE4S0jG2T6yyhgbGRYDJ2zLq5
	 LrtAoCGUHVGKEvvdSQ2OIvyYluogM07RoUvEOdFv+2GDF72C8GLzopdpnI+amxtaDY
	 /MXc18/x4tHK+t1NyShLvlBpNkYUoSNJkD+mClJz+hjIc9bQkmLPJ7/rsc0fFF8YvU
	 ++cXRlpFSrmHhWP/YSlc77QPnJnHFaNAyy3Q4NAKAW3JPGWyzH3e+dbaw3mHhMlwKh
	 FwwsFvqj6Jarg==
Subject: Re: [PATCH net-next 06/37] can: j1939: cancel pending address claim
 timers from j1939_ecu_unmap_all()
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, hemanth.selam@gmail.com
Date: Sat, 10 Oct 2026 14:02:50 +0000
Message-ID: <179164097070.434549.15097602958395529437@kernel.org>
In-Reply-To: <20261009134323.64064-7-mkl@pengutronix.de>
References: <20261009134323.64064-7-mkl@pengutronix.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 (1) · High: 2 (1) · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix does not fully close the race it targets.
- [High] can: j1939: list corruption in __j1939_ecu_release due to
  unlocked list_del
- [Medium] The new cancel loop in j1939_ecu_unmap_all()
  (net/can/j1939/bus.c:109-132) ends every non-zero…
- [Low] The commit fixes a user-triggerable refcount leak that hangs
  netdev unregister, but it has no 'Fixes:' tag and no 'Cc:…
- [Low] The ownership comment in j1939_ecu_timer_start()
  (net/can/j1939/bus.c:142-144) still says the timer-held reference is…
- [Low] The new comment on the hrtimer_try_to_cancel() < 0 branch in
  j1939_ecu_unmap_all() (net/can/j1939/bus.c:118) says the timer is…

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but
  __j1939_ecu_release() (net/can/j1939/bus.c:17-26) calls…
- [High] This problem wasn't introduced by this patch, but
  j1939_ac_process() (net/can/j1939/address-claim.c) takes…

--

can: j1939: cancel pending address claim timers from j1939_ecu_unmap_all()

This patch makes j1939_ecu_unmap_all() cancel pending address claim
hrtimers on priv->ecus before it clears priv->ents[]. The goal is to stop
a late j1939_ecu_timer_handler() from re-mapping an ECU after teardown,
which leaks the ECU's references and hangs unregister_netdevice().

Link: https://patch.msgid.link/9ba38419-967a-4d47-bcdf-bbb2fa7d3e9f@I-love.SAKURA.ne.jp

> Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd

[Severity: Low]
Should this have a Fixes: tag and a Cc: stable@vger.kernel.org trailer?

j1939_ecu_unmap_all(), j1939_ecu_timer_start(), j1939_ecu_timer_cancel()
and j1939_ecu_timer_handler() all appear unchanged since:

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

Other fixes in the same series do carry Fixes: and Cc: stable trailers.
Examples are "can: proc: reset pkg_stats atomics individually" and "can:
convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()".

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index cdc3c0a719379..0d109d1a3b4ae 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -99,8 +99,38 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
>  void j1939_ecu_unmap_all(struct j1939_priv *priv)
>  {
>  	int i;
> +	struct j1939_ecu *ecu;
>  
>  	write_lock_bh(&priv->lock);
> +	/* Cancel all pending address claim timers before unmapping.
> +	 * This prevents an orphaned late-firing timer from re-mapping
> +	 * an ECU after the spaces are cleared.
> +	 */

[Severity: High]
Does this fully close the race? The cancel loop only sees timers that are
armed while priv->lock is held. Nothing seems to stop a new timer from
being armed after the final write_unlock_bh() in this function.

In __j1939_rx_release(), j1939_can_rx_unregister() reaches
can_rx_unregister(). That function only does hlist_del_rcu() and
call_rcu(). It does not wait for a j1939_can_recv() that is already running
on another CPU:

net/can/j1939/main.c:__j1939_rx_release() {
	j1939_can_rx_unregister(priv);
	j1939_ecu_unmap_all(priv);
	j1939_priv_set(priv->ndev, NULL);
	...
}

Could this sequence happen?

CPU A                              CPU B
j1939_can_recv()
  j1939_ac_recv()
    j1939_ac_process()
                                   __j1939_rx_release()
                                     j1939_can_rx_unregister()
                                     j1939_ecu_unmap_all()
                                       write_lock_bh(&priv->lock)
      write_lock_bh(&priv->lock)       <cancel timers, clear ents[]>
      <spins>                          write_unlock_bh(&priv->lock)
      j1939_ecu_create_locked()
      j1939_ecu_timer_start()
                                     j1939_priv_set(priv->ndev, NULL)

250 ms later, j1939_ecu_timer_handler() calls j1939_ecu_map_locked() with
no teardown check. The ECU then goes back into priv->ents[] with an extra
reference.

j1939_priv_get_by_ndev() now returns NULL, so no later
j1939_ecu_unmap_all() can run for this priv. Would the ECU, its
netdev_hold() tracker and its priv reference then leak? That would give the
same "waiting for vxcan1 to become free" hang this patch is meant to fix.

The comment above seems to hold only for timers armed before the loop runs.

Would a synchronize_net() between j1939_can_rx_unregister() and
j1939_ecu_unmap_all() close this? Another option is a teardown flag checked
under priv->lock in j1939_ac_process(), j1939_ecu_timer_start() and
j1939_ecu_timer_handler().

> +rescan_timers:
> +	list_for_each_entry(ecu, &priv->ecus, list) {
> +		int ret = hrtimer_try_to_cancel(&ecu->ac_timer);
> +
> +		if (ret == 0) { /* Not active or already finished. */
> +			continue;
> +		} else if (ret == 1) { /* Successfully canceled. */
> +			/* Drop a ref from j1939_ecu_timer_start(). */
> +			j1939_ecu_put(ecu);

[Severity: High]
This looks pre-existing, but the new cancel loop depends on it. When
the last reference to a j1939_ecu goes away, __j1939_ecu_release()
does list_del(&ecu->list) on priv->ecus and frees the ECU. It does
not take priv->lock itself. It therefore relies on every final
j1939_ecu_put() being done under write_lock_bh(&priv->lock).

The lookup helpers do not guarantee that. j1939_ecu_get_by_addr()
and j1939_ecu_get_by_name() take read_lock_bh(&priv->lock), take a
reference and release the lock again. Their callers, for example
j1939_ac_recv(), then call j1939_ecu_put() with no lock held.

In the meantime another path may drop the remaining references under
priv->lock. The unlocked put is then the final one. Its list_del()
can run concurrently with a reader such as j1939_ecu_get_by_name()
walking priv->ecus under read_lock_bh(). It can also race with a
writer such as the rescan loop added here, or the list_add_tail() in
j1939_ecu_create_locked().

Can that corrupt priv->ecus, or let a walker step onto a freed
j1939_ecu?

With this patch, the timer reference of a pending ECU is dropped here
during teardown instead of later by j1939_ecu_timer_handler(). That
makes it more likely that a transient lookup reference ends up being
the last one.

The comment in the -1 branch shows the invariant is already
understood for j1939_ecu_timer_cancel(): an unlocked put must never
be the final reference. Should it also be enforced for the existing
unlocked callers?

Taking priv->lock inside __j1939_ecu_release() would deadlock for
the many callers that already hold it. Would a separate put helper
that wraps kref_put() in write_lock_bh(&priv->lock) work for the
unlocked callers? Or would you rather convert priv->ecus to RCU?

[Severity: Low]
This put is a new third release site for the timer reference. The comment
in j1939_ecu_timer_start() still lists only two:

	/* The ECU is held here and released in the
	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel().
	 */

Should that comment be updated to mention j1939_ecu_unmap_all()? The same
applies to the ref counting notes in j1939_ac_process().

> +		} else { /* Executing on another CPU. */

[Severity: Low]
Is "Executing on another CPU" accurate? The hrtimer_try_to_cancel()
kernel-doc defines -1 only as "the timer is currently executing the
callback function and cannot be stopped".

On PREEMPT_RT without CONFIG_PREEMPT_RT_NEEDS_BH_LOCK, local_bh_disable()
only disables migration. The soft callback can therefore be preempted on
the same CPU before it takes priv->lock. The comment above
hrtimer_cancel_wait_running() describes this case.

The fallback to hrtimer_cancel() handles this correctly, so only the
comment is affected.

> +			/* Let j1939_ecu_timer_cancel() determine whether to
> +			 * drop a ref from j1939_ecu_timer_start(). But guard
> +			 * with a local ref in order to make sure that unlocked
> +			 * j1939_ecu_put() from j1939_ecu_timer_cancel() cannot
> +			 * be the final reference.
> +			 */
> +			j1939_ecu_get(ecu);

[Severity: Critical]
This is a pre-existing issue, but can this kref_get() find an ECU whose
refcount has already reached zero?

__j1939_ecu_release() calls list_del(&ecu->list) on priv->ecus under
whatever lock the final putter holds. j1939_ac_recv() drops its reference
with no lock held, after j1939_ecu_get_by_addr() has released
read_lock_bh:

net/can/j1939/address-claim.c:j1939_ac_recv() {
	...
		ecu = j1939_ecu_get_by_addr(priv, skcb->addr.sa);
		if (ecu) {
			skcb->addr.src_name = ecu->name;
			j1939_ecu_put(ecu);
		}
	...
}

Take a mapped remote ECU that holds only its ents[] reference:

CPU X                              CPU Y
j1939_ac_recv()
  j1939_ecu_get_by_addr()   /* 2 */
                                   j1939_ac_process()  /* idle SA */
                                     write_lock_bh(&priv->lock)
                                     j1939_ecu_get_by_name_locked() /* 3 */
                                     j1939_ecu_unmap_locked()       /* 2 */
                                     j1939_ecu_put()                /* 1 */
                                     write_unlock_bh(&priv->lock)
  j1939_ecu_put()           /* 0 */
    __j1939_ecu_release()
      list_del(&ecu->list)  /* priv->lock not held */
      kfree(ecu)

A third CPU may be walking or changing priv->ecus under priv->lock at the
same time. Examples are this new rescan loop, j1939_ecu_find_by_name_locked()
and the list_add_tail() in j1939_ecu_create_locked().

Could that corrupt priv->ecus or lead to a use-after-free of the
j1939_ecu? The comment above describes the very invariant that
j1939_ac_recv() breaks: an unlocked j1939_ecu_put() must not be the final
reference.

> +			write_unlock_bh(&priv->lock);
> +			j1939_ecu_timer_cancel(ecu);

[Severity: High]
This isn't a bug introduced by this patch. Here the lock is dropped before
j1939_ecu_timer_cancel(), but j1939_ac_process() still calls it with
write_lock_bh(&priv->lock) held:

net/can/j1939/address-claim.c:j1939_ac_process() {
	...
	write_lock_bh(&priv->lock);
	...
	/* cancel pending (previous) address claim */
	j1939_ecu_timer_cancel(ecu);
	...
}

hrtimer_cancel() waits for a running callback to finish, and
j1939_ecu_timer_handler() starts with write_lock_bh(&priv->lock). Suppose
an AC frame for a NAME with a different or idle SA arrives just as that
ECU's ac_timer expires:

CPU0 (CAN rx)                      CPU1 (HRTIMER_SOFTIRQ)
j1939_ac_process()
  write_lock_bh(&priv->lock)
                                   j1939_ecu_timer_handler()
                                     write_lock_bh(&priv->lock)
                                     <spins>
  j1939_ecu_timer_cancel()
    hrtimer_cancel()
      <waits for callback>

Can these two CPUs deadlock? On !PREEMPT_RT,
hrtimer_cancel_wait_running() is just cpu_relax(). On PREEMPT_RT this
looks like an ABBA between priv->lock and softirq_expiry_lock.

The new unlocked j1939_ecu_timer_cancel() call here runs with
j1939_netdev_lock or RTNL held. It would also hang behind such a deadlock.

> +			write_lock_bh(&priv->lock);
> +			j1939_ecu_put(ecu);
> +		}
> +		goto rescan_timers;

[Severity: Medium]
Can this goto make the walk quadratic? Every nonzero return from
hrtimer_try_to_cancel() restarts the walk from the head of priv->ecus,
with write_lock_bh(&priv->lock) held. ECUs that survive cancellation are
scanned again on every restart.

On the NETDEV_DOWN path, j1939_netdev_notify() calls j1939_ecu_unmap_all()
while sockets are still bound. j1939_sk_netdev_event_netdown() does not
drop their local ECU references.

Consider N bound sockets with distinct NAMEs, each with a 250 ms timer left
pending by AC frames. That looks like O(N^2) work with BH disabled and RTNL
held.

The restart is only needed in the -1 branch, where the lock is dropped. In
the ret == 1 case only the current entry can be freed. Would
list_for_each_entry_safe(), with a restart only in the -1 branch, keep the
common case linear?

> +	}
> +	/* Unmap any remaining mapped ECUs */
>  	for (i = 0; i < ARRAY_SIZE(priv->ents); i++)
>  		if (priv->ents[i].ecu)
>  			j1939_ecu_unmap_locked(priv->ents[i].ecu);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009134323.64064-2-mkl%40pengutronix.de
