Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794728412;
	b=Ja9ZJi0OiOEtRQaXW6CloqXQmHgl2WT8IHLUiyRlKtnh1KPg3OtCDjIsK2tKNSvaFifn
	 rbAUvc7CFkiGRYNYoDXXYVTJEBslvNM1L09fUiq8zXB2XdFjvoEKMNFKhYz0dVa8s9pcg
	 mC8JGMtAI857daUojQ+kNVRI2F1+f2jkGUkVbqbvp/v5HQwxIJLBemTg+2pD0fi46GJK1
	 xkEbPMQn0LFryOf8rIL+MCX2wzWxVg9DwpYgSZUvvHRDW4gCJNKL1Gt7FctiBZDHL18kw
	 0qh2u0gGuLZsmeLzgfyJ055qswY/Mgo/AB6B1cdBCt7PSAQEAkXgHheLfziKANtgCEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794728412;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JPZT8Q9THEzPwoMv4Kuevux7biG3GWG88D0kqc4c3E4=;
	b=RmT7mJ3eNcZdQ5wuQMmFaBGutP6+dUGeJ2N2CBauUeUDrZfGMH0+Q7rwK5LE6lMwd1N3
	 JbbsOz5MuM8eqOo/cOe7puAwxmaVYzheBOFuYcda2mC8i6zCPOO/fVy/niijNVB5QaLKQ
	 BO/K/aweoThxbfCSRmFwvlhdaIDKhvx09+FKlgHHlBJRTaqsMyeJG35AN3suy/H0GGSj2
	 oVhhFl9J1bGu0Cg2KMDtP7j0oh9RYZZqsuHAUOmr2CO1Ve3cnmbsVCL/4np4RPNTtaxso
	 1bDSTTRIsvaVyjd/jXz/qMnQpntw9a8vxTVC3J1Ogzf0v0NBjW/23Gp1Qnl7ydLQ+QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KkC+WB5I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1B5606A31A
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KkC+WB5I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A77C1F000C4;
	Sun, 15 Nov 2026 07:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794728412;
	bh=JPZT8Q9THEzPwoMv4Kuevux7biG3GWG88D0kqc4c3E4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KkC+WB5Ilx0wVcAfPpJ6EKm1W/hdtlFKwxkNr/S3Pfwpdjvn5xUoYL6dO7+T2xuEs
	 duv5XTcZ17DMWpYkCbVJZ6pZg8/Wn5k1p1ikPRjhtWkEZ55rLRNmtj75Yh6lB9FS2U
	 PwUdEXgflZoD9x3sF0EKMDJ49BhYEpt9jGO6SncwRFXckMnGhhypPLYyTBLKL9SNFb
	 Czpzvq6gVN1UrJ1AgK+WZOB6vbRcfXIQM6Xj+8M7svyVNA6nVRKmFflHsMWETGJJih
	 llepnF7rLIvNrqBe4SNsO48oj5A5uFVQ1B4F4HuhD0Ts+6cfFpj001qA7qari9fNlT
	 +80t1IjXNa5gA==
Subject: Re: [PATCH v12 3/3] can: j1939: fix "struct j1939_ecu" refcount leak
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Sun, 15 Nov 2026 07:40:11 +0000
Message-ID: <179472841159.488853.10765214433306974984@kernel.org>
In-Reply-To: <60b30b7c-91dc-4138-bc92-be922ffd6215@I-love.SAKURA.ne.jp>
References: <60b30b7c-91dc-4138-bc92-be922ffd6215@I-love.SAKURA.ne.jp>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch fixes one path to the "struct j1939_ecu" refcount
  leak, but another path to the same leak is still reachable.
- [High] can: j1939: ecu refcount leak in j1939_ecu_timer_start() when
  handler runs
- [Medium] can: j1939: stale ac_want_abort in j1939_ecu_timer_handler()
  aborts claim
- [Low] The commit message describes the change only as fixing a "struct
  j1939_ecu" refcount leak.
- [Low] The patch also changes net/can/j1939/socket.c: in
  j1939_sk_bind(), `ndev->reg_state` becomes…

--

can: j1939: fix "struct j1939_ecu" refcount leak

This patch makes j1939_ecu_unmap_all() cancel each ECU's ac_timer. It also
adds j1939_ecu_verify_get(), which refuses new ECU references from
j1939_ecu_timer_start() and j1939_ecu_map_locked() once the netdev is no
longer registered or rx_kref has dropped to zero. In j1939_sk_bind(), the
reg_state check becomes a READ_ONCE() and gains an explanatory comment.

Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index 8cbf8716d286e..a0120567bb8f5 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c

[ ... ]

> @@ -130,8 +141,43 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
>  void j1939_ecu_unmap_all(struct j1939_priv *priv)
>  {
>  	int i;
> +	struct j1939_ecu *ecu;
>
> +rescan:
>  	write_lock_bh(&priv->lock);
> +	/* Need to shutdown timers now, for j1939_module_exit() might be called
> +	 * relatively shortly after returning from j1939_ecu_unmap_all() from
> +	 * __j1939_rx_release() from j1939_netdev_stop() from j1939_sk_release().
> +	 */

[Severity: Low]
This isn't a bug, but should the commit message mention the module unload
hazard that this comment describes? The changelog only talks about the
struct j1939_ecu refcount leak.

Before this patch, a pending ac_timer holds the reference taken in
j1939_ecu_timer_start(). While that reference is held the kref can't reach
zero, so release_work is never queued. That leaves destroy_workqueue() in
j1939_module_exit() with nothing to wait for, and the hrtimer_cancel() in
__j1939_ecu_release_work() never runs for that ECU.

After the last j1939 socket closes and __j1939_rx_release() returns, rmmod
can finish while the timer is still pending. j1939_ecu_timer_handler()
would then run from freed module text.

The earlier commit in this series, "can: j1939: fix possibility of UAF in
__j1939_ecu_release()", says it fixes the timer-after-j1939_module_exit()
case. That fix seems to depend on the cancellation added here.

Would it help stable backporters if this changelog said so?

> +	list_for_each_entry(ecu, &priv->ecus, list) {
> +		if (!j1939_ecu_valid(ecu))
> +			continue;
> +		switch (hrtimer_try_to_cancel(&ecu->ac_timer)) {
> +		case 0:	/* Not active or already finished. */
> +			continue;
> +		case 1:	/* Successfully canceled. */
> +			/* Drop the ref from j1939_ecu_timer_start(). */
> +			j1939_ecu_put(ecu);
> +			continue;
> +		default: /* Currently executing. */

[ ... ]

> +		write_unlock_bh(&priv->lock);
> +		if (hrtimer_cancel(&ecu->ac_timer))
> +			/* Drop the ref from j1939_ecu_timer_start(). */
> +			j1939_ecu_put(ecu);
> +		/* Drop the ref from default: above. */
> +		j1939_ecu_put(ecu);
> +		goto rescan;
> +	}

[ ... ]

> @@ -141,9 +187,9 @@ void j1939_ecu_unmap_all(struct j1939_priv *priv)
>  void j1939_ecu_timer_start(struct j1939_ecu *ecu)
>  {
>  	/* The corresponding j1939_ecu_put() is in
> -	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel().
> +	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel() or j1939_ecu_unmap_all().
>  	 */
> -	if (!j1939_ecu_get(ecu))
> +	if (!j1939_ecu_verify_get(ecu))
>  		return;

[Severity: High]
Beyond the reference leak above, the same hrtimer_try_to_cancel()
behaviour can also leave a cancelled claim armed.

While j1939_ecu_timer_handler() is running, hrtimer_try_to_cancel()
returns -1 even if j1939_ecu_timer_start() has already queued ac_timer
again. In that case j1939_ecu_timer_cancel() neither dequeues the new
expiry nor drops the reference taken for it. It only sets
ac_want_abort, which the running callback consumes.

With two re-arms in that window, one reference is never dropped. The
ECU then keeps its j1939_priv and the netdev reference held through
priv_dev_tracker, so unregister_netdevice() hangs in
netdev_wait_allrefs_any().

If the second claim cancels without re-arming, nothing leaks, but the
stale expiry survives:

CPU0 (ac_timer expired, priv->lock not taken yet)
j1939_ecu_timer_handler()

CPU1
j1939_ac_process()            /* NAME N, address sa1 */
    j1939_ecu_timer_cancel()  /* -1, sets ac_want_abort */
    j1939_ecu_timer_start()   /* takes ref B, timer queued */
j1939_ac_process()            /* NAME N, idle address */
    j1939_ecu_timer_cancel()  /* -1 again, timer stays queued */
    j1939_ecu_unmap_locked()  /* no j1939_ecu_timer_start() */

CPU0
    write_lock_bh(&priv->lock);
    /* sees ac_want_abort, clears it, returns */

The expiry queued by the first claim is still pending, and
ac_want_abort is now false. 250 ms later j1939_ecu_timer_handler()
calls j1939_ecu_map_locked() and maps the ECU at sa1. Its most recent
claim said it could not claim an address.

The second claim might instead lose arbitration to prev. The late
handler then tries to map the ECU at the address it just lost, which
usually just trips the already-mapped warning in
j1939_ecu_map_locked().

How is j1939_ecu_timer_cancel() meant to cancel an expiry that
j1939_ecu_timer_start() queued while the previous callback was still
running? Should j1939_ecu_timer_start() avoid re-arming, or avoid
taking another reference, while the callback is still active? Or does
the abort handshake need to track each queued expiry separately?

[Severity: High]
Can the reference taken here still leak if the timer is re-armed twice
while j1939_ecu_timer_handler() is running?

When the callback is running, j1939_ecu_timer_cancel() only sets a flag:

	default: /* Currently executing. */
		/* Tell j1939_ecu_timer_handler() to abort unless committed. */
		if (!ecu->ac_commit_done)
			ecu->ac_want_abort = true;

In that state hrtimer_try_to_cancel() returns -1 and dequeues nothing.
j1939_ecu_timer_start() takes a new reference on every call, and then
hrtimer_start() replaces any expiry that is already queued.

Consider one ECU, with j1939_ac_process() called under priv->lock:

CPU1 (ac_timer expired)
j1939_ecu_timer_handler()
    write_lock_bh(&priv->lock);   /* waiting */

CPU0
j1939_ac_process()                /* NAME N, address sa1 */
    j1939_ecu_timer_cancel()      /* -1, sets ac_want_abort */
    j1939_ecu_timer_start()       /* takes ref B, enqueues timer */

CPU2
j1939_ac_process()                /* NAME N, address sa2 */
    j1939_ecu_timer_cancel()      /* -1 again, queued expiry stays */
    j1939_ecu_timer_start()       /* takes ref C, hrtimer_start()
                                     replaces CPU0's expiry */

This needs CPU2 to get priv->lock before CPU1. It could already be queued
on the lock, or CPU1 could be between the handler's write_unlock_bh() and
its return.

The running callback then aborts and drops ref A. The one remaining expiry
drops ref C.

What drops ref B?

If nothing does, __j1939_ecu_release_work() never runs. The ECU's netdev
tracker and j1939_priv references are then never released, and
unregistering the CAN netdev would hang in netdev_wait_allrefs_any(). That
is the same symptom as the syzbot report this patch closes.

The new loop in j1939_ecu_unmap_all() drops at most one timer reference
per ECU, so it can't get ref B back.

The unlocked hrtimer_cancel() window in its default: branch looks like a
second place where the same double re-arm can happen. On the NETDEV_DOWN
path rx_kref is still non-zero, so j1939_ecu_verify_get() still allows
re-arming there.

The ac_want_abort/ac_commit_done handshake comes from the earlier commit
in this series, "can: j1939: fix possibility of hard-lockup/deadlock in
j1939_ecu_timer_cancel()". This patch relies on its assumption that each
armed timer holds exactly one reference.

> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index 50a598ef5fd4a..6e22ec5e88f5a 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c
> @@ -484,7 +484,15 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr_unsized *uaddr, in
>  			goto out_release_sock;
>  		}
>
> -		if (ndev->reg_state != NETREG_REGISTERED) {
> +		/* Do nothing and fail early if netdev is no longer registered.
> +		 * This check is racy but we don't need to recheck after j1939_jsk_add()
> +		 * is called, for either j1939_sk_netdev_event_unregister() from
> +		 * j1939_netdev_notify(NETDEV_UNREGISTER) (which is retried by
> +		 * netdev_wait_allrefs_any() as long as priv->rx_kref held by
> +		 * j1939_netdev_start() is preventing j1939_priv_set(priv->ndev, NULL)
> +		 * from being called) or j1939_sk_release() will take care of this race.
> +		 */
> +		if (READ_ONCE(ndev->reg_state) != NETREG_REGISTERED) {

[Severity: Low]
This isn't a bug, but the commit message only lists the three bus.c
changes. Could it also mention this j1939_sk_bind() change (the READ_ONCE()
annotation and the new comment) and say why it's needed?

A smaller point: j1939_ecu_unmap_all() is also called from
j1939_netdev_notify() on NETDEV_DOWN:

	case NETDEV_DOWN:
		j1939_cancel_active_session(priv, NULL);
		j1939_sk_netdev_event_netdown(priv);
		j1939_ecu_unmap_all(priv);

With this patch, ifdown also cancels pending 250 ms address-claim timers,
so they no longer fire and remap the ECU. The changelog only hints at this
with the word "unconditionally". Could it say so explicitly?

>  			dev_put(ndev);
>  			ret = -ENODEV;
>  			goto out_release_sock;

[ ... ]

> @@ -141,9 +187,9 @@ void j1939_ecu_unmap_all(struct j1939_priv *priv)
>  void j1939_ecu_timer_start(struct j1939_ecu *ecu)
>  {
>  	/* The corresponding j1939_ecu_put() is in
> -	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel().
> +	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel() or j1939_ecu_unmap_all().
>  	 */
> -	if (!j1939_ecu_get(ecu))
> +	if (!j1939_ecu_verify_get(ecu))
>  		return;
>  
>  	/* Schedule timer in 250 msec to commit address change. */

[Severity: Medium]
This isn't introduced here, but the new code depends on the
ac_want_abort/ac_commit_done handshake from the earlier patch "can:
j1939: fix possibility of hard-lockup/deadlock in
j1939_ecu_timer_cancel()". Can a stale ac_want_abort make an
uncontested address claim abort?

When j1939_ecu_timer_handler() takes the abort path, it clears the flag
and skips setting ac_commit_done before dropping priv->lock:

	if (ecu->ac_want_abort) {
		ecu->ac_want_abort = false;
		goto out;
	}
	...
	ecu->ac_commit_done = true;
out:
	write_unlock_bh(&priv->lock);

The callback is still running after that unlock, until __run_hrtimer()
clears base->running. In that window hrtimer_callback_running() is true
and ac_commit_done is false:

CPU0 (ac_timer callback, ac_want_abort already set)
j1939_ecu_timer_handler()
    ecu->ac_want_abort = false;
    write_unlock_bh(&priv->lock);
    /* still in callback: j1939_ecu_put(), return */

CPU1 (one Address Claim for the same NAME, new address)
j1939_ac_process()
    j1939_ecu_timer_cancel()      /* -1, ac_commit_done is false,
                                     so ac_want_abort = true */
    j1939_ecu_timer_start()       /* ac_commit_done = false,
                                     new 250 ms timer queued */

Nothing clears ac_want_abort after that. CPU0 is already past the lock,
and j1939_ecu_timer_start() leaves the flag alone. When the new timer
expires, j1939_ecu_timer_handler() sees the stale flag, skips
j1939_ecu_map_locked() and returns.

The ECU then stays out of priv->ents[] even though nobody contested the
claim. Sends using that NAME fail with -EADDRNOTAVAIL from
j1939_ac_fixup() until something re-arms the timer.

Clearing ac_want_abort in j1939_ecu_timer_start() doesn't look right on
its own. A callback still waiting for priv->lock would then commit the
new address early.

Would it work to set ac_commit_done on the abort path as well, so that
a cancel after the unlock no longer requests an abort? Or does the
abort request need to be tied to a specific arming of the timer?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/8de287d7-b4e1-4062-b40e-b193f5ec68ca%40I-love.SAKURA.ne.jp
