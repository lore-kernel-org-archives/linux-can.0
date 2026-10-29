Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245100;
	b=INO9/k8S+d3H5JVnrCAgtVcDa2rS1GpvYwTGE7fTc269xTU6Y/d9k2FCvMFHweVzXVk8
	 MJSzUdkSS4aC3HHSbvAUxV0nwugvAomw5WPH3AYfXwcasw/ZSx7tsoBbpjZwuqFlCQzMz
	 mHVDNe7l0YuIGkFpMqfOyJZ7qrZJTnG/7qDTYuTF8ng/F1bsQHCwvAm60jQxWDOdTalqg
	 xl9rwrl1gzOKTaI2ElK1g3l98CvjLN02Zr9KnCuWvgZpEzy238AME/1lcEE0ez9PKwkDD
	 meVdiGbG14rJu1gAHlHd/DQEA85842YV0g4zRT+X02Ap1r+BJqJVkyyed7jVdCtyEHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245100;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1yX6k6AQJ+hIwoKfHlcxjPTgCgzXo8VJxQ4YcdL81NA=;
	b=k84NKE89W06JMn6/2jklC+6X3pt5EAqxoAyvuLlDR7qQe0m6hkIMSheIydEpAm0KNVww
	 Jzi+tcfILXsk0cFdCDLqRoNvG3YoeINHqDarMQdXD3R+Qot1Rf9SS8kTrHdgNknOgJAtX
	 sgF0T87O7rzru+kA9kJuCnHT+laC0/3Oj79k4lvZuT1iMfJPbEniNWJLR+tGESmXx30+b
	 yes9KHS5sGNQvT69rqSOKP5aptqiJ8YNBQXUBKc3UDA3zlnfYsky6x/hgLIrizwA3S9ed
	 mPg+Ad+aPQAZxvYO6Kc+n71Di4NGwisZuofAUAjqNt1yZf1Sb3/fsUjywXi9iZCRAaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YN/lIuJW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF31606A31A
	for <linux-can@vger.kernel.org>; Thu, 29 Oct 2026 03:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YN/lIuJW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120981F01825;
	Thu, 29 Oct 2026 03:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793245099;
	bh=1yX6k6AQJ+hIwoKfHlcxjPTgCgzXo8VJxQ4YcdL81NA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YN/lIuJW2jelkwEW3Fw1BxyUyqgQJcJw0mmWpxDoDRR2pv0hah/xdXl1xKpaDLrI1
	 QkuMvPQECL09JH6t2iGlB0B20JeG/yy8GZRWYp+5d4ZKuBbqJMTQFzixlC20Fd49sw
	 JvmLkgS+FGQbgsRNFQXi4XbTv2kbQOjiytbNnBw8VJGbJiKFOat5ZPWVhUtY7FevYH
	 TONfX0OpJml15j0RsNHeKX5seauYT41w5tKFy0zONTIxcIgMrqDhrhZlsPT4eUIM6s
	 r0MnfQQCzo11vA2j8p1MjEygj5Az32Ulg17H1FXg8I0hDbvmahDysRMBxx2wxR0bw4
	 TaRuNzxGsjHVQ==
Subject: Re: [PATCH v4] can: j1939: fix j1939_ecu refcount leak
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Thu, 29 Oct 2026 03:38:18 +0000
Message-ID: <179324509861.3130.14189329713802638879@kernel.org>
In-Reply-To: <4b2c8d95-d17e-4f36-a340-abf84693d24a@I-love.SAKURA.ne.jp>
References: <4b2c8d95-d17e-4f36-a340-abf84693d24a@I-love.SAKURA.ne.jp>
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In j1939_ac_process() (net/can/j1939/address-claim.c:216-222),
  the new deadlock-avoidance path drops priv->lock and then calls…
- [Medium] __j1939_ecu_release() (net/can/j1939/bus.c:30-41) no longer
  unlinks and frees the ECU immediately.
- [Low] j1939_ecu_create_locked() (net/can/j1939/bus.c:227-229) now
  returns ERR_PTR(-ENOMEM) when priv->ndev->reg_state !=…
- [Low] On NETDEV_DOWN, j1939_netdev_notify() calls j1939_ecu_unmap_all()
  (main.c:375-378), which now cancels every pending address-claim timer…
- [Low] The new comment in j1939_ecu_unmap_all()
  (net/can/j1939/bus.c:135-139) is an unfinished sentence: "Since…
- [Low] The patch adds plain, unannotated reads of priv->ndev->reg_state
  in j1939_ecu_get() (bus.c:55) and j1939_ecu_create_locked()…
- [Low] One commit with the subject "can: j1939: fix j1939_ecu refcount
  leak" contains four separate changes.

--

can: j1939: fix j1939_ecu refcount leak

This commit fixes a j1939_ecu refcount leak reported by syzbot by
cancelling pending address claim timers in j1939_ecu_unmap_all(). It also
allows ECU references to be taken only while the netdev is registered and
rx_kref is non-zero, and defers ECU list removal and freeing to RCU
context. Timer cancellation in j1939_ac_process() is also reworked to avoid
a deadlock with the timer handler.

Link: https://lkml.kernel.org/r/179202402875.794844.18141702206663586949.b4-review@b4

> can: j1939: fix j1939_ecu refcount leak

[Severity: Low]
This isn't a bug, but the subject only mentions the refcount leak. The
patch contains four separate changes:

  (1) cancelling timers in j1939_ecu_unmap_all() for the syzbot leak
  (2) the new j1939_ecu_get() checks on reg_state and rx_kref
  (3) RCU-deferred ECU release, plus rcu_barrier() at module exit
  (4) the lock-drop/restart rework for the priv->lock vs hrtimer_cancel()
      deadlock

Only (1) has a Reported-by:/Closes: tag, but all four share one tag:

> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

Could these be split, so that stable can take the reproducible leak fix
without the redesign?

Also, j1939_ecu_timer_cancel() is renamed to j1939_ecu_timer_stopped(),
which reads like a pure query. The function still cancels the timer, and
it drops an ECU reference when hrtimer_try_to_cancel() returns 1. Could the
name reflect that side effect?

> diff --git a/net/can/j1939/address-claim.c b/net/can/j1939/address-claim.c
> index ca4ad6cdd5cbf..2f27948d6e875 100644
> --- a/net/can/j1939/address-claim.c
> +++ b/net/can/j1939/address-claim.c

[ ... ]

> @@ -212,7 +213,14 @@ static void j1939_ac_process(struct j1939_priv *priv, struct sk_buff *skb)
>  		goto out_unlock_bh;
>  
>  	/* cancel pending (previous) address claim */
> -	j1939_ecu_timer_cancel(ecu);
> +	if (!j1939_ecu_timer_stopped(ecu)) {
> +		write_unlock_bh(&priv->lock);
> +		if (hrtimer_cancel(&ecu->ac_timer))
> +			j1939_ecu_put(ecu);
> +		/* Drop ref from j1939_ecu_get_by_name_locked() and retry. */
> +		j1939_ecu_put(ecu);
> +		goto restart;
> +	}

[Severity: Medium]
priv->lock is dropped before hrtimer_cancel(), so priv->lock no longer
serializes arming and cancelling ac_timer. Can this cancel a timer that a
concurrent j1939_ac_process() has just armed, and leave the ECU unmapped
for good?

Take two AC frames with the same NAME and SA, arriving while the old
ac_timer callback is running:

CPU1 (j1939_ac_process)
  j1939_ecu_timer_stopped() returns false
  write_unlock_bh(&priv->lock)
                              old j1939_ecu_timer_handler() finishes
                              CPU2 (j1939_ac_process, same NAME/SA)
                                j1939_ecu_timer_stopped() returns true
                                ecu->addr = skcb->addr.sa;
                                (may unmap and put prev)
                                j1939_ecu_timer_start(ecu)
  hrtimer_cancel() removes CPU2's timer, returns 1
  j1939_ecu_put(ecu) twice
  goto restart

On restart, ecu->addr now equals skcb->addr.sa, so CPU1 takes the early
exit:

	if (ecu && ecu->addr == skcb->addr.sa) {
		...
		goto out_ecu_put;
	}

It never re-arms the timer. The refcounts stay balanced, but the ECU is
left with ecu->addr == sa, no pending ac_timer, and no priv->ents[sa]
entry. j1939_ecu_map_locked() is never called for it.

Later identical AC frames take the same early exit. j1939_name_to_addr()
would then return J1939_IDLE_ADDR, and name-based sends would fail with
-EADDRNOTAVAIL until the node claims a different address.

On PREEMPT_RT, hrtimer_cancel_wait_running() sleeps on the expiry lock,
which makes this window much wider.

The old code cancelled and re-armed within one critical section. That is
also where the deadlock fixed by item (4) came from. So this state seems to
be new with the restart approach.

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index cdc3c0a719379..63210da8b7a83 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -14,25 +14,52 @@

[ ... ]

> +static void __j1939_ecu_release(struct kref *kref)
> +{
> +	struct j1939_ecu *ecu = container_of(kref, struct j1939_ecu, kref);
> +
> +	/* Since not all callers are calling j1939_ecu_put() with priv->lock
> +	 * held for write, defer actual release to RCU context. By deferring to
> +	 * RCU context, priv->ecus readers might find ECUs with ecu->kref == 0.
> +	 * Therefore, priv->ecus readers must validate with j1939_ecu_valid() or
> +	 * j1939_ecu_get().
> +	 */
> +	call_rcu(&ecu->rcu, __j1939_ecu_release_rcu);
> +}

[Severity: Medium]
With CONFIG_RCU_LAZY=y, plain call_rcu() is lazy. Dead ECUs (kref == 0) can
then stay on priv->ecus for a long time, possibly several seconds. Can a
stream of AC frames with changing NAMEs make priv->ecus grow during that
window?

In j1939_ac_process(), each frame with a new NAME creates an ECU through
j1939_ecu_create_locked(). The contention logic after
j1939_ecu_get_by_addr_locked() then drops either the new ECU or the
previous owner to kref 0. With this patch, each of these leaves a dead
entry on the list.

These walks visit every dead entry, all under priv->lock with BH disabled:

  j1939_ecu_get_by_name_locked(), on every RX AC frame and from
  j1939_ac_fixup() on TX
  j1939_ecu_find_by_name_locked(), from j1939_name_to_addr()
  the new cancel loop in j1939_ecu_unmap_all(), which calls
  hrtimer_try_to_cancel() on each entry

Each dead entry also holds its netdev tracker and its j1939_priv reference
until the callback runs.

rcu_barrier() and netdev_wait_allrefs() flush them eventually, so this is
not a permanent leak. Before the patch, though, the list held only live
ECUs.

[ ... ]

> -static void j1939_ecu_get(struct j1939_ecu *ecu)
> +static __must_check bool j1939_ecu_get(struct j1939_ecu *ecu)
>  {
> -	kref_get(&ecu->kref);
> +	struct j1939_priv *priv = ecu->priv;
> +
> +	/* Don't get an ECU ref if netdev is no longer registered or
> +	 * __j1939_rx_release() was called or __j1939_ecu_release() was called.
> +	 */
> +	return priv->ndev->reg_state == NETREG_REGISTERED &&
> +		kref_read(&priv->rx_kref) && kref_get_unless_zero(&ecu->kref);
> +}

[Severity: Low]
unregister_netdevice_many_notify() updates reg_state with:

	WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERING);

It does this under netdev_lock/RTNL and never takes priv->lock. Should this
read, and the matching one in j1939_ecu_create_locked(), use READ_ONCE() to
avoid KCSAN reports?

The two sides share no lock, so this check also does not order reference
acquisition against unregistration. A reader can see NETREG_REGISTERED just
before the state changes, and still map an ECU or arm its timer.

What actually keeps teardown correct seems to be the rx_kref check.
rx_kref reaches 0 before __j1939_rx_release() calls j1939_ecu_unmap_all()
under priv->lock. The commit message, however, presents (a) as one of the
conditions that closes the race:

  (a) A netdev which is associated with j1939_priv is still registered
      (indicated by priv->ndev->reg_state == NETREG_REGISTERED).

Is that description accurate, or is (a) only an early bailout?

[ ... ]

> @@ -99,8 +128,36 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
>  void j1939_ecu_unmap_all(struct j1939_priv *priv)
>  {
>  	int i;
> +	struct j1939_ecu *ecu;
>  
> +restart:
>  	write_lock_bh(&priv->lock);
> +	/* Cancel all pending address claim timers before unmapping.
> +	 * This prevents an orphaned late-firing timer from re-mapping
> +	 * an ECU after the spaces are cleared. Since j1939_ecu_put()
> +	 * might make , we need to skip invalid ECUs.
> +	 */

[Severity: Low]
This isn't a bug, but this sentence is unfinished: "Since j1939_ecu_put()
might make , we need to skip invalid ECUs."

The comment also doesn't match the loop below it. The loop does not skip
invalid ECUs first. It calls j1939_ecu_timer_stopped() on every entry,
including entries with kref 0, and that function can call j1939_ecu_put()
when hrtimer_try_to_cancel() returns 1. Only after that does it filter with
kref_get_unless_zero().

The code looks correct. An armed timer always holds a reference, so a
return of 1 implies kref >= 1. Also, __j1939_ecu_release_rcu() needs
priv->lock before it can unlink the entry.

The next comment ("It is OK to call j1939_ecu_timer_stopped() even if there
is no ref") states this invariant without saying why. Could one of the
comments spell it out?

> +	list_for_each_entry(ecu, &priv->ecus, list) {
> +		/* It is OK to call j1939_ecu_timer_stopped() even if there is
> +		 * no ref on this ECU, for __j1939_ecu_release_rcu() has not
> +		 * removed this ECU from priv->ecus list due to priv->lock.
> +		 */
> +		if (j1939_ecu_timer_stopped(ecu))
> +			continue;

[Severity: Low]
j1939_netdev_notify() also calls this function on NETDEV_DOWN:

	case NETDEV_DOWN:
		j1939_cancel_active_session(priv, NULL);
		j1939_sk_netdev_event_netdown(priv);
		j1939_ecu_unmap_all(priv);

This now cancels pending claim timers but leaves ecu->addr unchanged. Can a
NAME-bound local ECU whose claim was still inside the 250 ms window get
stuck after ifdown/ifup?

Before this patch, the pending timer stayed armed and mapped the ECU when
it fired. Now the ECU is left with ecu->addr == SA and no mapping.

After ifup, the application sends an AC with the same NAME and SA.
j1939_ac_fixup() sees ecu->addr == sa and does nothing. The echoed frame
then hits the early exit in j1939_ac_process():

	if (ecu && ecu->addr == skcb->addr.sa) {

So j1939_ecu_timer_start() is skipped. j1939_name_to_addr() returns
J1939_IDLE_ADDR, and name-based sends fail with -EADDRNOTAVAIL until a
different SA is claimed.

ECUs that were already mapped at NETDEV_DOWN behave the same way before
this patch, because j1939_ecu_unmap_locked() also leaves ecu->addr
unchanged. This change extends that existing problem to pending claims.

Two possible fixes would cover both cases:

  reset ecu->addr for cancelled or unmapped claims
  let the early exit fall through when the ECU is neither mapped nor
  waiting on its timer

Would either of these work?

> +		/* Keep this ECU valid while calling hrtimer_cancel(). But
> +		 * don't use j1939_ecu_get() here, for we want to wait for
> +		 * completion of timer callback regardless of netdev's state.
> +		 */
> +		if (!kref_get_unless_zero(&ecu->kref))
> +			continue;

[ ... ]

> @@ -152,6 +222,13 @@ struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name)
>  
>  	lockdep_assert_held(&priv->lock);
>  
> +	/* Don't create a new ECU if netdev is no longer registered or
> +	 * __j1939_rx_release() was called.
> +	 */
> +	if (priv->ndev->reg_state != NETREG_REGISTERED ||
> +	    !kref_read(&priv->rx_kref))
> +		return ERR_PTR(-ENOMEM);
> +

[Severity: Low]
Nothing has been allocated at this point. Should this return -ENODEV
instead of -ENOMEM?

j1939_local_ecu_get() passes the error through PTR_ERR_OR_ZERO(), and
j1939_sk_bind() returns it to userspace. bind(2) can therefore fail with
ENOMEM while the CAN device is being unregistered.

This can happen on a re-bind of an already-bound socket. It can also
happen on a first bind that races with reg_state changing after this check
in j1939_sk_bind():

		if (ndev->reg_state != NETREG_REGISTERED) {
			dev_put(ndev);
			ret = -ENODEV;

The new j1939_ecu_get() checks also make j1939_ecu_get_by_name_locked()
return NULL in this state, even when a valid ECU exists. A re-bind that
used to succeed therefore now falls through to this create.

Documentation/networking/j1939.rst describes ENOMEM as an allocation
failure and ENODEV as a missing or unusable device. As written, this case
also can't be told apart from a real kzalloc failure just below it.

>  	ecu = kzalloc_obj(*ecu, gfp_any());
>  	if (!ecu)
>  		return ERR_PTR(-ENOMEM);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/4b2c8d95-d17e-4f36-a340-abf84693d24a%40I-love.SAKURA.ne.jp
