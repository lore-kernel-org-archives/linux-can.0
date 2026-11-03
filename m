Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793679049;
	b=UYLz4o/tDQ0NPc8mgLGBshHfOPFVF/XCXUSIIfXlmzULpgQ6UrjKgSvr6AQxw5MWK9/8
	 Gpwf3ZecZEMmVlszZmi025GTGRVoA3YSCk1bOyMr9tQFXDNPR9Ue5cCfELnNykHcB+5Z2
	 c1qVBzEPTchJuWbvB5e2GTNl8CnJm0IIquJb2T4S62FMZ8lZIXzLDH1xE5VEU0JbETq0j
	 6sMBXetxZWX5xMPlAQtPhYPfQyuWR+nI/UpC6mdft2jlpnUjeeo2DpahQugenkxpbWN9Z
	 c9LHDqzQO0FzXSJXEW/jP5nMc9VnvV3BuKYgB8/fqev1yYLuDb6xLE3RjTWlog0JHIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793679049;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pAHr1VTTVQ5Ev7ta+7zGKOcqGwud1Q2YS54y148GjqY=;
	b=LnZ9Rbm4ikjvycZy1A3oxcnSE3DGb+hjSc1EKahTbxZCYDewAy29YD0q1uqkeWTjfpDI
	 xg3IR9GjXpl5Ly3BKaE3jlChTX+nZKdamQeCuCN8Wdxz2hMakymFxuq9wWuPz157MGd6W
	 hSotcTQPNkNCXlIPGo+8sMoZtQpUlC5zBiljUXkOTfaN6VYXBwH2iGNNd6/M0C+EdOEOU
	 f2Rbhk4laETaJhmINRd2AVQvwIj/Vkj5572E/Hqk7QPymIFq8sJWMa0FrWVuR+fn8Tkop
	 1m0g2rzVpoAnF0l/Lnp6NqnZLJkqFajRDDu/oO8FLK4xvoLz7tCii+cTXWIMla0nj4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IHSPqmbn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAA2606A324
	for <linux-can@vger.kernel.org>; Tue,  3 Nov 2026 04:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IHSPqmbn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF111F000C1;
	Tue,  3 Nov 2026 04:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793679048;
	bh=pAHr1VTTVQ5Ev7ta+7zGKOcqGwud1Q2YS54y148GjqY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IHSPqmbnAQA9qujsEi9jMdlu2PiM/8vyqU96lTGrDom21tSrXDEfcyLxK14EAVmMD
	 gjxWLQFIwih20x1GAGRKkJmdYkRvGtWoZ7Qafiz1MEpfyBOo30onQZKXSQfTnlyUL9
	 78z6qR5QC7k5HXS7RypvwlofAIdsc0cS4cSmSvL04hLaVXEZNmmlWhcWDD+AmVpe/C
	 a+Db90v98RVr3m8v/EQVS+6frs3pYyeLG8a2mwQFCeL/U6qJ/5lEsgc9M/XQ93Z0hT
	 hQHZtguToWKrwEMlcXRjkRKBT0i42m+iReo5ZsO+G+/MGuS+G6EGTutwEocpsNvmVE
	 NQNVrQdhv0yIw==
Subject: Re: [PATCH v5] can: j1939: fix j1939_ecu refcount leak and related
 race conditions
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Tue, 03 Nov 2026 04:10:47 +0000
Message-ID: <179367904752.488853.7037337500598589957@kernel.org>
In-Reply-To: <d0590019-f0c9-4288-9653-a7b6056012af@I-love.SAKURA.ne.jp>
References: <d0590019-f0c9-4288-9653-a7b6056012af@I-love.SAKURA.ne.jp>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] On PREEMPT_RT the AB-BA deadlock that Step 2 claims to fix can
  still happen, through the hrtimer softirq_expiry_lock.
- [Medium] The rcu_barrier() added to j1939_module_exit() does not do
  what its comment says.
- [Medium] __j1939_ecu_release_rcu() asserts with
  WARN_ON(hrtimer_cancel(&ecu->ac_map_timer)) that ac_map_timer is not…

--

can: j1939: fix j1939_ecu refcount leak and related race conditions

This squashed patch moves the final ECU release into an RCU callback, so
the release can always take priv->lock for write. It splits the address
claim timer into ac_wait_timer and ac_map_timer to avoid an AB-BA deadlock
between hrtimer_cancel() under priv->lock and the timer handler. It also
makes j1939_ecu_get() fail once the netdev is unregistering or rx has been
released, which fixes the syzbot refcount leak.

Link: https://lkml.kernel.org/r/179202402875.794844.18141702206663586949.b4-review@b4

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index cdc3c0a719379..7980c87e004f1 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -14,25 +14,64 @@
>  
>  #include "j1939-priv.h"
>  
> -static void __j1939_ecu_release(struct kref *kref)
> +static void __j1939_ecu_release_rcu(struct rcu_head *rcu)
>  {
> -	struct j1939_ecu *ecu = container_of(kref, struct j1939_ecu, kref);
> +	struct j1939_ecu *ecu = container_of(rcu, struct j1939_ecu, rcu);
>  	struct j1939_priv *priv = ecu->priv;
>  
> +	write_lock_bh(&priv->lock);
>  	list_del(&ecu->list);
> +	write_unlock_bh(&priv->lock);

[ ... ]

> +	WARN_ON(hrtimer_cancel(&ecu->ac_wait_timer));
> +	WARN_ON(hrtimer_cancel(&ecu->ac_map_timer));

[Severity: Medium]
Can this WARN_ON() fire if ac_map_timer is still queued when the last
reference goes away?

j1939_ecu_wait_timer_cancel() takes over the bit 0 handoff reference
through j1939_ecu_map_timer_handler_locked(). It never cancels the
ac_map_timer that j1939_ecu_wait_timer_handler() has already armed:

void j1939_ecu_wait_timer_cancel(struct j1939_ecu *ecu)
{
	if (hrtimer_cancel(&ecu->ac_wait_timer))
		j1939_ecu_put(ecu);
	j1939_ecu_map_timer_handler_locked(ecu);
}

CAN bus input can drive this sequence in j1939_ac_process():

  remote ECU claims address A, wait timer holds the only ref   (1)
  250ms later j1939_ecu_wait_timer_handler() sets bit 0 and
    arms ac_map_timer with 0 expiry
  before the soft ac_map_timer runs, another address claim
    arrives for the same NAME with SA 0xFE (idle)
  j1939_ecu_get_by_name_locked()                               (2)
  j1939_ecu_wait_timer_cancel()
    hrtimer_cancel(&ecu->ac_wait_timer) returns 0
    j1939_ecu_map_timer_handler_locked()
      clears bit 0, j1939_ecu_map_locked() gets                (3)
      j1939_ecu_put()                                          (2)
  j1939_ecu_unmap_locked()                                     (1)
  out_ecu_put: j1939_ecu_put()                                 (0)
    call_rcu(&ecu->rcu, __j1939_ecu_release_rcu)

Suppose soft hrtimer expiry on that CPU is delayed past a grace period,
for example when ksoftirqd/ktimers is starved or softirqs are threaded on
PREEMPT_RT. Then hrtimer_cancel(&ecu->ac_map_timer) here returns 1 and the
WARN_ON() triggers.

j1939_ecu_unmap_all() on the unregister path can hit the same case,
because it calls j1939_ecu_wait_timer_cancel() for every ECU.

The cancel before kfree() prevents a use-after-free. The result is a WARN
splat, or a panic with panic_on_warn.

Should j1939_ecu_wait_timer_cancel() also try to disarm ac_map_timer (for
example with hrtimer_try_to_cancel()) when it takes over the handoff
reference?

[ ... ]

> @@ -101,48 +142,122 @@ void j1939_ecu_unmap_all(struct j1939_priv *priv)

[ ... ]

> +void j1939_ecu_wait_timer_cancel(struct j1939_ecu *ecu)
> +{
> +	if (hrtimer_cancel(&ecu->ac_wait_timer))

[Severity: High]
On PREEMPT_RT, can the AB-BA deadlock that step 2 is meant to fix still
happen here through the hrtimer softirq_expiry_lock?

This hrtimer_cancel() still runs with priv->lock held for write. It is
called from j1939_ac_process(), and now also from the new loop over every
ECU in j1939_ecu_unmap_all().

On RT, suppose the soft ac_wait_timer callback is running on CPU C. Then
hrtimer_try_to_cancel() returns -1 and the canceller does:

kernel/time/hrtimer.c:hrtimer_cancel_wait_running() {
    ...
	atomic_inc(&base->cpu_base->timer_waiters);
	spin_lock_bh(&base->cpu_base->softirq_expiry_lock);
    ...
}

hrtimer_run_softirq() on CPU C holds softirq_expiry_lock across all soft
callbacks in that run. Between callbacks it drops the lock only if a
waiter was already registered:

kernel/time/hrtimer.c:hrtimer_sync_wait_running() {
	if (atomic_read(&cpu_base->timer_waiters)) {
		raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
		spin_unlock(&cpu_base->softirq_expiry_lock);
		spin_lock(&cpu_base->softirq_expiry_lock);
		raw_spin_lock_irq(&cpu_base->lock);
	}
}

Two things can let CPU C go on to the next expired soft timer while it
still holds softirq_expiry_lock:

  the canceller's atomic_inc() lands after this check, or
  the SCHED_FIFO ktimers thread takes the rtlock back first

If that next callback takes priv->lock, would this deadlock?

CPU A (holds priv->lock for write)
j1939_ecu_wait_timer_cancel()
  hrtimer_cancel(&ecu->ac_wait_timer)
    hrtimer_cancel_wait_running()
      spin_lock_bh(&cpu_base->softirq_expiry_lock)   <- waits for CPU C

CPU C (holds softirq_expiry_lock)
j1939_ecu_map_timer_handler() for another ECU
  write_lock_bh(&priv->lock)                         <- waits for CPU A

The transport txtimer/rxtimer callbacks can also take priv->lock with
read_lock_bh(), through j1939_send_one()->j1939_ac_fixup()->
j1939_name_to_addr() and through j1939_address_is_local().

Lockdep on RT would also record priv->lock -> softirq_expiry_lock, which
is the reverse of softirq_expiry_lock -> priv->lock.

> +		/* The corresponding j1939_ecu_get() is in j1939_ecu_wait_timer_start(). */
>  		j1939_ecu_put(ecu);
> +	j1939_ecu_map_timer_handler_locked(ecu);
>  }

[ ... ]

> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> index 5e5e6c228f225..bdf536440aded 100644
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c
> @@ -424,6 +424,11 @@ static __exit void j1939_module_exit(void)
>  	can_proto_unregister(&j1939_can_proto);
>  
>  	unregister_netdevice_notifier(&j1939_netdev_notifier);
> +
> +	/* We need to make sure that __j1939_ecu_release_rcu() is
> +	 * no longer running before unmapping memory for this module.
> +	 */
> +	rcu_barrier();

[Severity: Medium]
Does this rcu_barrier() really make sure that __j1939_ecu_release_rcu() is
no longer running? It only waits for callbacks that are already queued.
Address claim hrtimers can still be armed at this point and can queue new
call_rcu() callbacks after it returns.

The cancel loop added to j1939_ecu_unmap_all() only runs while the netdev
is unregistering:

	if (READ_ONCE(priv->ndev->reg_state) != NETREG_REGISTERED) {
		...
		list_for_each_entry(ecu, &priv->ecus, list)
			if (j1939_ecu_valid(ecu))
				j1939_ecu_wait_timer_cancel(ecu);
	}

When the last socket is closed and the netdev is still registered:

j1939_sk_release()
  j1939_netdev_stop()
    __j1939_rx_release()
      j1939_ecu_unmap_all()                <- cancel loop skipped
      j1939_priv_set(priv->ndev, NULL)

A remote ECU's ac_wait_timer, armed by j1939_ac_process(), can stay
pending for up to 250ms while it holds the only ECU reference.

After j1939_priv_set(ndev, NULL), j1939_priv_get_by_ndev() returns NULL.
The notifier walk in unregister_netdevice_notifier() therefore can no
longer reach this priv.

Only sockets hold the module reference. It is dropped in sk_prot_free()
once the socket's RCU-deferred free runs (SOCK_RCU_FREE), so rmmod can
proceed while the timer is still armed. In that case rcu_barrier() returns
at once.

Later, j1939_ecu_wait_timer_handler() and j1939_ecu_map_timer_handler()
would run from unloaded module text. The final j1939_ecu_put() in the map
handler then queues __j1939_ecu_release_rcu(), which is also module text,
after the barrier has returned.

The old ac_timer already allowed a timer to fire after unload. But the
comment here promises a guarantee for the new RCU callback that does not
seem to hold.

Would it be enough to cancel the address claim timers unconditionally in
__j1939_rx_release()? Alternatively, could module exit wait until all
ECUs of detached privs have been released?

>  }
>  
>  module_init(j1939_module_init);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/d0590019-f0c9-4288-9653-a7b6056012af%40I-love.SAKURA.ne.jp
