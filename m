Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794728411;
	b=mO9BUwavIDoI+UuLeGo6gn8sKbg9hzsHVToXaf3whfi6bYpxufJJoXnCk9jrfi9DB0JQ
	 m7pf/UEM7YTkMrJD8gALp6hssvxXGUnME/3Nm2sLdu9SBhjsh/KLje0Lcryb3/iyrvlGf
	 3rNzxW51vvW/Lqj7RQs2w8S8qvmzEbb+iMQqt78wd2Mfky+X+XIFqkUBMo7CXoD+2XId/
	 bdLVunUXuXairUFOTBSDhFDFb8CDPocdg2HgE0U5sP5OS0MSRMrEk8Axi7mxesEPoFEDs
	 L56CPCqLkGHW5oKFwIcqPUyPu/6Gt+pvgbqhQrQMpCFZNO1dmgmA/AOuj9TalqmjplQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794728411;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7frlOCurkclEBwRst5i5yDue2DV6lwqFMXXwqAhqOwU=;
	b=BIGGZcDuADBLJcYhWLmIAY6A1aRn86DRyh6iKwRO1S16aPVAzZ2Kyz9hwmb7iKfplSeN
	 apKuHKHVXP3Tcnq2uhwx7VpoMg5svdN6tdl+qqLCm9H0xPv8TkaCMbvsbZqy9FrFiWO7b
	 vuqgcFj4IDw/P1QY0GX+fzUis9F94Uo7GEE6s8Dw9QYSymvpvPemDcjm2QXKvolALdWIT
	 gHBzsFZIObKikB6I4NMce4bI9Gz0SD/SHY0ID1IWGu0LIhsvHgnCEBD0vT0PVKg7yg5l+
	 C/dzh+VNnTATi+HWP1UVFQZAIENpPDElUvOxjQx6KiRKloE7guXseetK8DGvdu2cU+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IRhA2ktU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920F6606A31A
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IRhA2ktU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F160C1F000C4;
	Sun, 15 Nov 2026 07:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794728411;
	bh=7frlOCurkclEBwRst5i5yDue2DV6lwqFMXXwqAhqOwU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IRhA2ktUvq0C72u28jF4eTSxNlJAp2ux9zcGZgOvZoM07INnVt4ejPjX9MwyG4yOZ
	 k2WWkg62EprbhF+atPGIpEA4piPf6EBhwcpinA7EMadx+GX6j2YlSBYtwwHF3LoFsb
	 /S6/tG95IMF5yN42y5oAjxVpITopg7Lm//9kLokgoR1IwIGWiSzSaiDvL/bi7a5ksP
	 S3FwmsNu3soRUiTCOKKBhGWElZ4pGXD4BXPAls7CZVHKCL7IyLVksFW30Q6009g9XH
	 2uE7/QHhUfR5L/odn11TXWZXUyvlOUcafgNRtBNW0kBpuP/KLve8ITkKc/7fbsOZHN
	 sooJ2JtIP9C+A==
Subject: Re: [PATCH v12 2/3] can: j1939: fix possibility of
 hard-lockup/deadlock in j1939_ecu_timer_cancel()
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Sun, 15 Nov 2026 07:40:10 +0000
Message-ID: <179472841048.488853.11794166440037989468@kernel.org>
In-Reply-To: <ba3e6880-6dff-4fa6-a2e4-629c3d35b8d5@I-love.SAKURA.ne.jp>
References: <ba3e6880-6dff-4fa6-a2e4-629c3d35b8d5@I-love.SAKURA.ne.jp>
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

Critical: 0 · High: 2 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] j1939_ecu_timer_cancel() treats -1 from hrtimer_try_to_cancel()
  as meaning only 'the callback is executing'.
- [High] can: j1939: ecu ref leak and uncanceled timer in
  j1939_ecu_timer_cancel()
- [Medium] A stale ac_want_abort flag can make a later, valid address
  claim abort, and the claim is never retried.
- [Low] The patch moves j1939_ecu_put() in j1939_ecu_timer_handler()
  (net/can/j1939/bus.c:196) to after write_unlock_bh(&priv->lock).

--

can: j1939: fix possibility of hard-lockup/deadlock in j1939_ecu_timer_cancel()

This patch replaces hrtimer_cancel() in j1939_ecu_timer_cancel() with
hrtimer_try_to_cancel(). The old call could deadlock while waiting for
j1939_ecu_timer_handler() with priv->lock held. If the callback is
already running, two new bool flags (ac_want_abort and ac_commit_done)
tell the handler to skip the address commit.

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index c49c96dea7960..8cbf8716d286e 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -147,15 +147,25 @@ void j1939_ecu_timer_start(struct j1939_ecu *ecu)
>  		return;
>  
>  	/* Schedule timer in 250 msec to commit address change. */
> +	ecu->ac_commit_done = false;
>  	hrtimer_start(&ecu->ac_timer, ms_to_ktime(250),
>  		      HRTIMER_MODE_REL_SOFT);
>  }
>  
>  void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
>  {
> -	if (hrtimer_cancel(&ecu->ac_timer))
> +	switch (hrtimer_try_to_cancel(&ecu->ac_timer)) {
> +	case 0:	/* Not active or already finished. */
> +		break;
> +	case 1:	/* Successfully canceled. */
>  		/* Drop the ref from j1939_ecu_timer_start(). */
>  		j1939_ecu_put(ecu);
> +		break;
> +	default: /* Currently executing. */
> +		/* Tell j1939_ecu_timer_handler() to abort unless committed. */
> +		if (!ecu->ac_commit_done)
> +			ecu->ac_want_abort = true;
> +	}
>  }

[Severity: High]
Can j1939_ecu_timer_cancel() miss a timer that was already re-armed?

__run_hrtimer() sets base->running before it calls
j1939_ecu_timer_handler(). It only clears it after the handler has
returned and cpu_base->lock is taken again. While base->running points
at ecu->ac_timer, hrtimer_try_to_cancel() skips remove_hrtimer() and
returns -1, even if j1939_ecu_timer_start() has queued the timer again
in the meantime:

kernel/time/hrtimer.c:hrtimer_try_to_cancel() {
    ...
	if (!hrtimer_callback_running(timer)) {
		ret = remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE);
    ...
}

That window covers the handler waiting in write_lock_bh(&priv->lock).
It also covers the stretch between write_unlock_bh() and the return to
__run_hrtimer(). With CONFIG_PREEMPT_RT=y the soft callback is
preemptible, so the window can be long.

j1939_ac_process() calls j1939_ecu_timer_cancel() under priv->lock.
Unless the claim is idle or lost, it then calls
j1939_ecu_timer_start() under the same lock. Address Claimed frames
reach this path via j1939_can_recv() and j1939_ac_recv(). So a remote
CAN peer, or a local user on a PF_CAN socket, controls the timing.

Suppose the handler for an old expiry (holding ref R1) is in that
window:

- Frame 1 for the same NAME gets -1 from the cancel.
  j1939_ecu_timer_start() then takes R2, clears ac_commit_done and
  queues the timer.
- Frame 2 arrives before base->running is cleared. Its cancel gets -1
  again. R2 is not dropped, the queued timer is not removed, and
  ac_want_abort is set.

>From there:

1. Frame 2 claims another unicast address. j1939_ecu_timer_start()
   takes R3 but only re-arms the already queued timer. The single
   expiry puts just one of R2/R3.

   The ecu kref can then never reach zero, so
   __j1939_ecu_release_work() never runs. That leaks the struct
   j1939_ecu, its j1939_priv reference and the netdev reference held
   through ecu->priv_dev_tracker. Wouldn't unregister_netdevice() then
   wait forever?

   If the old handler had already passed write_unlock_bh(), nobody
   consumes the flag from frame 2 either. The re-armed expiry then
   aborts.

2. Frame 2 is idle (J1939_IDLE_ADDR) or loses contention
   (ecu->name > prev->name), so nothing re-arms. Say the old handler
   was still waiting for priv->lock. It consumes ac_want_abort and
   returns. Frame 1's timer is still queued with the flag cleared.
   250 ms later, j1939_ecu_map_locked() maps the ECU even though
   frame 2 withdrew or lost that claim.

3. Same as 2, but the old handler had already passed
   write_unlock_bh(). ac_want_abort stays set while the timer is
   still queued. Now frame 3 arrives after base->running is cleared.
   Its cancel returns 1 and drops the reference. Neither that path
   nor j1939_ecu_timer_start() clears ac_want_abort, so frame 3's
   timer aborts instead of committing a valid claim.

The old hrtimer_cancel() waited for the callback, removed the queued
instance and returned 1. So all three look new with this patch.

Clearing ac_want_abort when hrtimer_try_to_cancel() returns 0 or 1
looks safe, since no handler is left to consume it then. That would
cover case 3. It doesn't help with the leaked reference or the queued
timer that is never removed, though.

A single bool can't express "callback running and timer queued
again". Should the timer reference be tied to an armed state tracked
under priv->lock rather than to the return value of
hrtimer_try_to_cancel()? Or is there another way to handle the -1
case?

[Severity: High]
Can this leak an ECU reference?

hrtimer_try_to_cancel() returns -1 whenever hrtimer_callback_running() is
true, even if the timer has been queued again in the meantime:

kernel/time/hrtimer.c:hrtimer_try_to_cancel() {
    ...
	if (!hrtimer_callback_running(timer)) {
		ret = remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE);
    ...
}

j1939_ac_process() always calls j1939_ecu_timer_cancel() and then
j1939_ecu_timer_start() under priv->lock, and each start takes a new
reference. Here is one sequence for NAME N while a handler run is in
flight:

1. T1 holds ref R1. Its handler is running (base->running == timer) and
   is blocked on priv->lock.
2. AC frame A (addr Y): cancel gets -1 and sets ac_want_abort. Start
   takes R2 and enqueues the timer.
3. The T1 handler aborts, drops priv->lock and puts R1.
4. AC frame B (addr Z != Y) arrives before the T1 callback has returned
   to __run_hrtimer(). Cancel gets -1 again, so R2 is not dropped and the
   timer is not dequeued. Start takes R3 and only re-arms the same queued
   timer.
5. The one remaining expiry puts only one of R2/R3.

Once the kref can never reach zero, __j1939_ecu_release_work() never
runs. That skips netdev_put(priv->ndev, &ecu->priv_dev_tracker),
kfree(ecu) and j1939_priv_put().

Wouldn't unregistering the CAN netdev then wait forever for the leaked
device reference?

j1939_ecu_unmap_all() doesn't seem to recover this either. The extra
reference has no pending expiry, so hrtimer_try_to_cancel() returns 0
there.

There also seems to be a lost-cancel variant:

1. Frame A (addr Y) re-arms the timer.
2. Frame B (idle address) runs before the T1 handler takes priv->lock.
   Its cancel gets -1, but ac_want_abort is already true.
3. The T1 handler consumes the single flag.
4. The re-armed expiry then maps the ECU at Y, even though frame B
   revoked that claim.

The previous hrtimer_cancel() would have waited for the callback,
removed the queued instance and returned 1, so both cases look new with
this patch. They also seem to remain after the later commit "can: j1939:
fix "struct j1939_ecu" refcount leak", which does not change
j1939_ecu_timer_cancel() or the handler.

A single bool can't represent "callback running and timer queued again".
Does the cancellation logic need a different design here?

> @@ -165,14 +175,25 @@ static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrtimer)
>  	struct j1939_priv *priv = ecu->priv;
>  
>  	write_lock_bh(&priv->lock);
> +
> +	/* Abort if j1939_ecu_timer_cancel() told me to abort. */
> +	if (ecu->ac_want_abort) {
> +		ecu->ac_want_abort = false;
> +		goto out;
> +	}

[Severity: Medium]
Can a stale ac_want_abort make a later, valid address claim abort?

On this abort path ac_commit_done stays false. After write_unlock_bh(),
the hrtimer core still treats the callback as running, because
__run_hrtimer() only clears base->running after fn() returns.

A j1939_ecu_timer_cancel() in that window gets -1 and sees
!ac_commit_done. It then sets ac_want_abort = true again, even though
this handler run has already made its decision.

j1939_ecu_timer_start() resets only ac_commit_done, not ac_want_abort.
The next armed expiry then aborts without calling
j1939_ecu_map_locked().

A possible sequence for NAME N:

1. Frame 1 (addr X) arms the timer.
2. The timer expires on CPU1 and the handler blocks on priv->lock.
3. Frame 2 (addr 0xFE, idle) cancels, gets -1 and sets ac_want_abort.
   The idle path doesn't re-arm the timer.
4. The handler takes the lock, consumes the flag, aborts and unlocks.
5. Frame 3 (addr Z != X) runs after the unlock but before the callback
   returns. Cancel gets -1 and sets ac_want_abort again, then start
   re-arms the timer.
6. 250 ms later the handler aborts on the stale flag.

After that, further AC frames from N with addr Z take the early exit in
j1939_ac_process():

	if (ecu && ecu->addr == skcb->addr.sa) {
		...
		goto out_ecu_put;
	}

So the timer is never re-armed, and the ECU stays unmapped at Z until it
claims a different address.

"Handler already aborted" and "handler not yet decided" both show up as
ac_commit_done == false. Should the code tell these two states apart?

> +
>  	/* TODO: can we test if ecu->addr is unicast before starting
>  	 * the timer?
>  	 */
>  	j1939_ecu_map_locked(ecu);
>  
> +	/* Commit and tell j1939_ecu_timer_cancel() not to ask me to abort. */
> +	ecu->ac_commit_done = true;
> +out:
> +	write_unlock_bh(&priv->lock);
> +
>  	/* Drop the ref from j1939_ecu_timer_start(). */
>  	j1939_ecu_put(ecu);
> -	write_unlock_bh(&priv->lock);
>  
>  	return HRTIMER_NORESTART;
>  }

[Severity: Low]
This isn't a bug in the series as posted. However, the commit message
does not mention that j1939_ecu_put() now runs after write_unlock_bh().

The move is only safe because of the earlier commit "can: j1939: fix
possibility of UAF in __j1939_ecu_release()". That commit defers
list_del() and kfree() to __j1939_ecu_release_work(), which takes
priv->lock itself.

At the baseline, __j1939_ecu_release() calls list_del(&ecu->list),
netdev_put() and kfree(ecu) synchronously. It relies on the caller
holding priv->lock.

This patch carries Cc: stable and Fixes: 9d71dd0c7009. Suppose a stable
tree picked it up without its predecessor. Wouldn't a last put from the
timer handler then modify priv->ecus without the lock, racing with
walkers such as j1939_ecu_get_by_name_locked()?

Could the commit message note this dependency?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/8de287d7-b4e1-4062-b40e-b193f5ec68ca%40I-love.SAKURA.ne.jp
