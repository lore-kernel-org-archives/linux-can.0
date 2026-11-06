Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937644;
	b=i55CLh0YHRZdlivFS1oHA1q4VQQDgxkbsiwYNEHiIPow9/yUgKMes2JsaBKZUvlQMGUL
	 o3+pKHrWJ2eIv9iA6yei6nnw3i5e/7JRztxE+jdw4PHn67y3IQE96czLwvBNUMcdNwl3T
	 NJHyiUTUKy32Cb5sHzA5Kx08TSifCvYfG9GmwXs/qBJ20LfOm6aimmGC2QjCR+V+L15pd
	 SDv/jpjC5NkrcpkeJ5Ibg9MOri2YHK1fJZ5ul4ohmFlcH8qAa4HJhqYfJ6PEVGmKU9/3P
	 bZ/p7kVi8hNQ8un8v3wGAE0dClTOfV1kNr1WLJ73JIKYVbHMuYLKL5EFBO6EJI94Okw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937644;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KPhYUVEWWmYUi2/I9/9kP0FrKE+M/XNnl1+StCf+7E8=;
	b=dUTuHydH16SL7dGohKKCRO7wb8pJL5C6hEDa8oYwasua/lVNz3zbuLahaE67Glm6gbbR
	 Olr1SCe98UYtWd9LeIhkcGCdW63MH4nuwHIogEvYD4G5LYR2/POfC2ZGhlf3tle0PzHZU
	 6sRXSkb2c1wTb4nNyJnenuBVUgjz0UlU5NCpnFV71YZyG/IVY6XrLwiciAU0kSbi8+RsO
	 Wu80aJVVQMSC5au+nkBFaqiaKscQrs/bhwF6DwJ7AxtOk2oJJb+UO6zWrark5R3aLcJ8o
	 Cjj+3OMIO0s4CRHdxxC+12xAc0nlRSttwCX3WzDoF3rA2cbUrAtlqTMgtm5jjgXdjUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoJbSZwr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9767A606A31B
	for <linux-can@vger.kernel.org>; Fri,  6 Nov 2026 04:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoJbSZwr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BC61F0089F;
	Fri,  6 Nov 2026 04:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793937643;
	bh=KPhYUVEWWmYUi2/I9/9kP0FrKE+M/XNnl1+StCf+7E8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZoJbSZwr0SUwKGuT8c5KI9T9LLziYztaXFxNCTGMaABIZkv5HV9XPbKxwPxa+whg0
	 8wIFAZPAS49+6le1PYJh5EjsbWQkeRW/KBtjFqd3GSSk602lg/NwUq46SZ3+6VatBx
	 OZHw3ZAhDCnmv5dQmVC6/Y+quu25Bbo6/fvDqtjwLdU1dkMEM7YdSIBs2kAveJAZuj
	 70UCnJfUP8msmGenD8iyN7qLuffdn+Mbr1lhNL9H+e5jz1V19dJOPlS4Rp7Bj6VI/i
	 nhvcZE+lWtpjvylh5f3dRXCkXJ/nTjDKGNZg+N2anQ66kixDKYiRwq52TO8ZbGe2/P
	 wt31SMrSN5H2Q==
Subject: Re: [PATCH v6] can: j1939: fix j1939_ecu refcount leak and related
 race conditions
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Fri, 06 Nov 2026 04:00:42 +0000
Message-ID: <179393764229.488853.17334137875789332818@kernel.org>
In-Reply-To: <c9de355a-d66e-4f28-9636-a6fef8fe8b84@I-love.SAKURA.ne.jp>
References: <c9de355a-d66e-4f28-9636-a6fef8fe8b84@I-love.SAKURA.ne.jp>
X-sashiko-severity: Critical
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 1 · High: 1 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Double put of the ECU reference that
  j1939_ecu_timer_handler() hands to the tasklet.
- [High] can: j1939: deadlock between priv->lock and softirq_expiry_lock
  on PREEMPT_RT
- [Medium] Teardown ordering gap between the new ac_tasklet and module
  unload.
- [Low] The comment in j1939_ecu_timer_handler() says the
  !test_and_set_bit()/test_and_clear_bit() pairing 'guarantees that the…
- [Low] __j1939_ecu_release() documents a contract: 'priv->ecus readers
  must validate with j1939_ecu_valid() or j1939_ecu_get()', because ECUs…
- [Low] The comment in j1939_ecu_unmap_all() calls the timer cancellation
  a speed-up only, saying j1939_ecu_get() in the tasklet 'will fail if…
- [Low] For Step 3, the commit message says the fix works by 'making
  j1939_ecu_get() fail unless three conditions ... are met'.

--

can: j1939: fix j1939_ecu refcount leak and related race conditions

The patch defers ECU release to a workqueue, so the list_del() always
runs under priv->lock. It also moves the address claim commit from the
hrtimer handler to a tasklet, which avoids an AB-BA deadlock with
hrtimer_cancel(). Finally, j1939_ecu_get() now fails once the netdev is
no longer registered or rx_kref has dropped to zero, and pending address
claim timers are cancelled in j1939_ecu_unmap_all().

Link: https://lkml.kernel.org/r/179202402875.794844.18141702206663586949.b4-review@b4

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index cdc3c0a719379..632e9aed6cf52 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c

[ ... ]

> @@ -99,8 +138,17 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
>  void j1939_ecu_unmap_all(struct j1939_priv *priv)
>  {
>  	int i;
> +	struct j1939_ecu *ecu;
>  
>  	write_lock_bh(&priv->lock);
> +	/* Although j1939_ecu_get() from j1939_ecu_map_locked() from
> +	 * j1939_ecu_tasklet_handler() will fail if netdev is no longer
> +	 * registered or __j1939_rx_release() was called, cancel the 250ms
> +	 * timer in order to speed up teardown operation.
> +	 */

[Severity: Low]
Is this comment accurate for every caller? j1939_netdev_notify() also
calls j1939_ecu_unmap_all() for NETDEV_DOWN:

	case NETDEV_DOWN:
		j1939_cancel_active_session(priv, NULL);
		j1939_sk_netdev_event_netdown(priv);
		j1939_ecu_unmap_all(priv);

On that path reg_state is still NETREG_REGISTERED and bound sockets
still hold rx_kref, so j1939_ecu_get() does not fail.

There, the cancel clears bit 0, so the tasklet skips
j1939_ecu_map_locked(). That looks like the only thing that stops a
pending address claim from re-mapping the ECU after the interface goes
down, so it is more than a speed-up.

> +	list_for_each_entry(ecu, &priv->ecus, list)
> +		j1939_ecu_timer_cancel(ecu);

[Severity: High]
Does this still deadlock on CONFIG_PREEMPT_RT?

ecu->ac_timer is a HRTIMER_MODE_REL_SOFT timer. On PREEMPT_RT, if
hrtimer_cancel() finds its callback running, it waits in
hrtimer_cancel_wait_running(), which takes
cpu_base->softirq_expiry_lock with spin_lock_bh().

This loop and j1939_ac_process() both reach that wait through
j1939_ecu_timer_cancel() with write_lock_bh(&priv->lock) held. That
gives the ordering priv->lock -> softirq_expiry_lock.

hrtimer_run_softirq() holds softirq_expiry_lock across all of the
soft hrtimer callbacks it expires on that CPU, not just ac_timer.

The transport timers session->txtimer and session->rxtimer are also
HRTIMER_MODE_REL_SOFT, and they can take priv->lock from inside the
callback:

j1939_tp_txtimer()
  j1939_send_one()
    j1939_ac_fixup()
      j1939_name_to_addr()        <- read_lock_bh(&priv->lock)
      j1939_ecu_get_by_name()     <- read_lock_bh(&priv->lock)
      j1939_ecu_unmap()           <- write_lock_bh(&priv->lock)

That gives the reverse ordering, softirq_expiry_lock -> priv->lock.
Lockdep should report a circular dependency on RT kernels.

It can also hang at runtime:

- CPU 1 holds priv->lock for write and sees ac_timer running on
  CPU 0, so hrtimer_try_to_cancel() returns -1.
- CPU 0 finishes j1939_ecu_timer_handler() before CPU 1 bumps
  timer_waiters. hrtimer_sync_wait_running() then does not drop
  softirq_expiry_lock.
- __hrtimer_run_queues() on CPU 0 moves on to an expired txtimer or
  rxtimer. That callback blocks on priv->lock while holding
  softirq_expiry_lock.
- CPU 1 then blocks on softirq_expiry_lock while holding
  priv->lock.

Step 2 takes priv->lock out of the ac_timer callback. On RT, though,
the wait inside hrtimer_cancel() is effectively a wait on every soft
hrtimer callback running on that CPU. The AB-BA deadlock described in
the commit message is therefore still reachable there.

Can j1939_ecu_timer_cancel() avoid waiting for the callback while
priv->lock is held? Two options come to mind:

- move the cancel outside priv->lock, or
- use hrtimer_try_to_cancel().

Both would need the bit 0 handshake to cope with a handler that is
still running, so I'm not sure what the cleanest fix is here.

[Severity: Low]
__j1939_ecu_release() documents that priv->ecus readers must validate
with j1939_ecu_valid() or j1939_ecu_get(). ECUs with kref == 0 stay on
the list until __j1939_ecu_release_work() runs.

This new loop does neither check. It calls j1939_ecu_timer_cancel(),
which can call j1939_ecu_put(), on dead ECUs as well.

If the refcounting is correct, a dead ECU has no armed timer and bit 0
is clear, so nothing happens. With the double put described below in
j1939_ecu_timer_cancel(), though, could a dead ECU still have bit 0 set
and get put again here from a zero refcount?

Should this loop skip ECUs that fail j1939_ecu_valid()?

> +	/* Unmap any remaining mapped ECUs */

[ ... ]

> @@ -121,29 +170,99 @@ void j1939_ecu_timer_start(struct j1939_ecu *ecu)
>  
>  void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
>  {
> +	/* Drop the ref from j1939_ecu_timer_start() if j1939_ecu_timer_handler() was not called.
> +	 * Don't drop the ref from j1939_ecu_timer_start() if j1939_ecu_timer_handler() was already
> +	 * called.
> +	 */
>  	if (hrtimer_cancel(&ecu->ac_timer))
>  		j1939_ecu_put(ecu);
> +	/* Drop the ref from j1939_ecu_timer_handler() if test_and_set_bit() in
> +	 * j1939_ecu_timer_handler() succeeded and j1939_ecu_tasklet_handler() is not yet called.
> +	 * Don't drop the ref from j1939_ecu_timer_handler() if test_and_set_bit() in
> +	 * j1939_ecu_timer_handler() failed or j1939_ecu_tasklet_handler() was already called.
> +	 */
> +	if (test_and_clear_bit(0, &ecu->flags))
> +		j1939_ecu_put(ecu);

[Severity: Critical]
Can the ref taken in j1939_ecu_timer_handler() be dropped twice here?

When j1939_ecu_timer_handler() wins test_and_set_bit(), it takes a ref
with j1939_ecu_get(), schedules ac_tasklet, and leaves that ref for the
tasklet.

Suppose j1939_ecu_timer_cancel() runs after the handler fired but
before the tasklet clears bit 0. For example, j1939_ac_process() runs
under write_lock_bh(&priv->lock) for every received address claim
frame, while the tasklet is spinning on that lock or still pending:

j1939_ac_process()
  j1939_ecu_timer_cancel()
    hrtimer_cancel() returns 0
    test_and_clear_bit(0, &ecu->flags) returns 1
    j1939_ecu_put(ecu)              <- first drop of the handler's ref

Nothing kills the scheduled tasklet, so it still runs:

j1939_ecu_tasklet_handler()
	if (!test_and_clear_bit(0, &ecu->flags))
		goto out;
	...
 out:
	write_unlock_bh(&priv->lock);
	/* Drop the ref from j1939_ecu_timer_handler(). */
	j1939_ecu_put(ecu);             <- second drop

The out label comes before the unconditional put, so the same ref is
dropped a second time.

Doesn't that leave ecu->kref one below the number of real holders?

As an example, take a socket bind ref. An AC frame arrives and its
timer fires. A second AC frame arrives inside the window, and then a
later timer firing maps the ECU into priv->ents[]. The kref is now 1,
but there are two holders.

When the socket closes, release_work kfree()s the ECU while
priv->ents[addr].ecu still points to it. After that, both
j1939_ac_recv()->j1939_ecu_get_by_addr()->j1939_ecu_get() and
j1939_ecu_unmap_all()->j1939_ecu_unmap_locked() would touch freed
memory.

If there is no extra holder, the early release would instead hit
WARN_ON(hrtimer_cancel()) in __j1939_ecu_release_work(), or a refcount
underflow when ac_timer fires on an ECU whose kref is 0.

The new loop in j1939_ecu_unmap_all() calls j1939_ecu_timer_cancel()
on every ECU. Any ECU with a pending tasklet at NETDEV_DOWN or
__j1939_rx_release() time would therefore be put twice.

Should the handler's ref be dropped in exactly one place? For example,
the tasklet could put only when its own test_and_clear_bit() succeeds,
or j1939_ecu_timer_cancel() could clear the bit without putting.

>  }
>  
>  static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrtimer)
>  {
>  	struct j1939_ecu *ecu =
>  		container_of(hrtimer, struct j1939_ecu, ac_timer);
> +
> +	/* The corresponding j1939_ecu_put() is in
> +	 * j1939_ecu_tasklet_handler() or j1939_ecu_timer_cancel().
> +	 */
> +	if (!j1939_ecu_get(ecu))
> +		goto out;
> +
> +	/*
> +	 * Since we can't commit this address change from this context because we need to hold
> +	 * priv->lock for write before committing while hrtimer_cancel() (which waits for this
> +	 * context to complete) is called with priv->lock held for write, schedule
> +	 * j1939_ecu_tasklet_handler() (which takes priv->lock held for write from a different
> +	 * context) to commit this address change.
> +	 *
> +	 * The !test_and_set_bit() in j1939_ecu_timer_handler() and
> +	 * the test_and_clear_bit() in j1939_ecu_tasklet_handler() (or
> +	 * j1939_ecu_timer_cancel()) pair guarantees that
> +	 * the ref from j1939_ecu_timer_start() is dropped for exactly once.

[Severity: Low]
This isn't a bug, but does this comment name the right reference? The
ref from j1939_ecu_timer_start() is dropped unconditionally at the end
of this function:

out:
	/* Drop the ref from j1939_ecu_timer_start(). */
	j1939_ecu_put(ecu);

The bit 0 handshake actually controls the ref taken by this handler's
own j1939_ecu_get().

The comment above that j1939_ecu_get() also lists only
j1939_ecu_tasklet_handler() and j1939_ecu_timer_cancel() as the
matching puts. It leaves out the put in the else branch of this
function.

[ ... ]

> @@ -152,6 +271,13 @@ struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name)
>  
>  	lockdep_assert_held(&priv->lock);
>  
> +	/* Don't create a new ECU if netdev is no longer registered or
> +	 * __j1939_rx_release() was called.
> +	 */
> +	if (READ_ONCE(priv->ndev->reg_state) != NETREG_REGISTERED ||
> +	    !kref_read(&priv->rx_kref))
> +		return ERR_PTR(-ENODEV);

[Severity: Low]
The commit message describes the Step 3 fix as:

  Fix this problem by canceling pending address claim timers from
  j1939_ecu_unmap_all() and making j1939_ecu_get() fail unless three
  conditions listed below are met.

This hunk adds a second check in j1939_ecu_create_locked() that returns
-ENODEV, and the commit message does not mention it. Could it be
described there?

This errno reaches bind() through j1939_local_ecu_get():

	ecu = j1939_ecu_get_by_name_locked(priv, name);
	if (!ecu)
		ecu = j1939_ecu_create_locked(priv, name);
	err = PTR_ERR_OR_ZERO(ecu);

j1939_ecu_get_by_name() now also fails for existing ECUs while the
device is unregistering. In that window, j1939_ac_fixup() returns
-ENODEV for address claim sends:

		ecu = j1939_ecu_get_by_name(priv, skcb->addr.src_name);
		if (!ecu)
			return -ENODEV;

So bind() and AC sendmsg() can now fail during teardown, where they
used to succeed.

> +
>  	ecu = kzalloc_obj(*ecu, gfp_any());

[ ... ]

> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> index 5e5e6c228f225..22c272f8dfde2 100644
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c

[ ... ]

> @@ -424,6 +432,11 @@ static __exit void j1939_module_exit(void)
>  	can_proto_unregister(&j1939_can_proto);
>  
>  	unregister_netdevice_notifier(&j1939_netdev_notifier);
> +
> +	/* We need to make sure that __j1939_ecu_release_work() is
> +	 * no longer running before unmapping memory for this module.
> +	 */
> +	destroy_workqueue(j1939_ecu_wq);
>  }

[Severity: Medium]
Can a pending ecu->ac_tasklet outlive this destroy_workqueue()?

j1939_ecu_unmap_all() cancels the hrtimers. It does not kill or wait
for an ac_tasklet that j1939_ecu_timer_handler() has already scheduled.

tasklet_kill() is only called from __j1939_ecu_release_work(). That
only runs after the last ref is dropped, and the pending tasklet itself
holds a ref.

Consider this sequence:

j1939_netdev_stop()
  __j1939_rx_release()
    j1939_ecu_unmap_all()     <- timers cancelled, tasklet still pending
rmmod
  j1939_module_exit()
    destroy_workqueue(j1939_ecu_wq)
<softirq processing delayed, e.g. ksoftirqd starved>
j1939_ecu_tasklet_handler()   <- runs from unloaded module text
  j1939_ecu_put()
    __j1939_ecu_release()
      queue_work(j1939_ecu_wq, ...)   <- workqueue already destroyed

The comment here assumes nothing can queue release_work after
destroy_workqueue(). Is there something that guarantees these tasklets
have finished before this point?

>  
>  module_init(j1939_module_init);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/c9de355a-d66e-4f28-9636-a6fef8fe8b84%40I-love.SAKURA.ne.jp
