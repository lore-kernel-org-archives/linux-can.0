Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793546475;
	b=GIlY8Hq7K1ZpdWrPgbs96kiXkMqz+xaDuvTCqXFAHxSxym/MhVnvZqy0Ydrov1sgt2tv
	 8kgyrX50WfRfasiJS8G6/7eZku5j5r04GdF+TxfbeY7m+PQmJe3qRA7IvsuoZW1nkrZDL
	 NyPuFqmKQNe+3dcNWpdCzLtHhi9fLLv96mliAcxK9raOxlm56BL50OHCGAsm1NDYs93nd
	 1leEDtPoP1CQUpAh6ltPwKgMFrfeTwgLRT3VYBmPgvlJ8X/e/DzES97CF8dja54IO14wX
	 CFjW5iWjFCJO8nkEc+Hm4sia9svbl2JlS2KEl+Scb1jRO/97WENfiCm9649zSbt1KZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793546475;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nngYTW+N8WLOU7OnLThLn2AHmN2fMeYjX7PMk+3buHw=;
	b=CH3hvsYFOiM0RtIL0sreIO6YEIVbMji7qesIndqo0b0O04pLb8eF+4hcTUKwIkOdRqPL
	 2EYiXLiksqT8rGAZBWsgLCRgaHN9rdJQ19vdIWEzwZPOT1C3KNTgliJ7GbWaJoUER+cpQ
	 kKc3pjlNbGqcNtkGqHSrJd60QrIS2MydSXc9TAXbet5y/FVPpV1wDzsj3/FHSQ1PogF+c
	 39TjDJZWv3NzNVejFuuo4M9sK2hKEfE3gIvZARfrVfsOOpMU66iCfZV5AIq31SjbphQhL
	 xyHbIXJki+lXomliP3/dEGHa55zSGtcqFdutkyh2MUCkPNGUbrMub+5ddOKS3cvEGDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWQj9FX5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E3E606A324
	for <linux-can@vger.kernel.org>; Sun,  1 Nov 2026 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWQj9FX5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A251F000C1;
	Sun,  1 Nov 2026 15:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793546474;
	bh=nngYTW+N8WLOU7OnLThLn2AHmN2fMeYjX7PMk+3buHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iWQj9FX5rxmeQHM9oZxWevoRnxbf7PxMzftmTpUv8qreOgYSU23/f7ih0mqLFbbll
	 Hdzf88F8k/fz88ksiGHGsiXL0ffhUbon7UoJhjQnAV0thc8OaFdkrpIcNgQTKXrT+R
	 ox7o8Lkptw9bZJZL9J19WDc3MPJu7fqkLaHIO8ezywZs2oHNXRsQJbwjuPzIVGo4Up
	 Ie8BLInN137c7Mfy1ILHzaYMGqYv2YUcynP1T5THE3oMObKrK6Mq82i+WSrhzKiE+K
	 ndpfVYBWSM4RwCk9kYcDt6en+mQEon9TQJUUiK2lgtMJv1gNHAlhNI9qRmBvY5ydu3
	 2KjsG+oNSdv2A==
Message-ID: <sashiko-outbox-192466@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] can: j1939: fix j1939_ecu refcount leak and related
 race conditions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <d0590019-f0c9-4288-9653-a7b6056012af@I-love.SAKURA.ne.jp>
References: <d0590019-f0c9-4288-9653-a7b6056012af@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 15:21:13 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] can: j1939: uncanceled ac_map_timer and bogus map in j1939_ecu_wai=
t_timer_cancel()
- [High] can: j1939: uncancelled ac_wait_timer in j1939_ecu_unmap_all() whe=
n netdev is registered
- [High] can: j1939: PREEMPT_RT lock inversion between priv->lock and softi=
rq_expiry_lock
--

commit 29eb5f80c7c0c32da46e05ba6659469cc364a415
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

can: j1939: fix j1939_ecu refcount leak and related race conditions

This patch defers j1939_ecu release to RCU context, splits the address claim
hrtimer into a two-stage timer (ac_wait_timer and ac_map_timer), and gates
ECU reference acquisition on netdevice registration and rx_kref state.

Link: https://lkml.kernel.org/r/179202402875.794844.18141702206663586949.b4=
-review@b4

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index cdc3c0a719379..7980c87e004f1 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c

[ ... ]

> @@ -101,48 +142,122 @@ void j1939_ecu_unmap_all(struct j1939_priv *priv)
>  	int i;
> =20
>  	write_lock_bh(&priv->lock);
> +	if (READ_ONCE(priv->ndev->reg_state) !=3D NETREG_REGISTERED) {
> +		struct j1939_ecu *ecu;
> +
> +		/* Although j1939_ecu_get() from j1939_ecu_map_locked() from
> +		 * j1939_ecu_map_timer_handler_locked() will fail if netdev is
> +		 * no longer registered, try to bail out early by dropping
> +		 * the ref from j1939_ecu_wait_timer_start() now in order to
> +		 * speed up teardown operation.
> +		 */
> +		list_for_each_entry(ecu, &priv->ecus, list)
> +			if (j1939_ecu_valid(ecu))
> +				j1939_ecu_wait_timer_cancel(ecu);
> +	}

[Severity: High]
What happens when j1939_ecu_unmap_all() is called while priv->ndev->reg_sta=
te
is still NETREG_REGISTERED?

j1939_ecu_unmap_all() is called from two paths: __j1939_rx_release() (via
j1939_netdev_stop() when the last bound J1939 socket is closed or unbound)
and j1939_netdev_notify() on NETDEV_DOWN:

net/can/j1939/main.c:__j1939_rx_release() {
	...
	j1939_can_rx_unregister(priv);
	j1939_ecu_unmap_all(priv);
	j1939_priv_set(priv->ndev, NULL);
	mutex_unlock(&j1939_netdev_lock);
}

When the last bound socket is closed while the netdevice is still registere=
d,
reg_state =3D=3D NETREG_REGISTERED is true, so j1939_ecu_unmap_all() skips
canceling pending 250ms ac_wait_timer instances on priv->ecus, and
__j1939_rx_release() then detaches priv from priv->ndev via
j1939_priv_set(priv->ndev, NULL).

Any unmapped ECU with an armed ac_wait_timer continues holding its ecu->kref
reference from j1939_ecu_wait_timer_start(), so __j1939_ecu_release() is not
called and call_rcu(&ecu->rcu, __j1939_ecu_release_rcu) is not queued yet.
Because can_ml->j1939_priv is now NULL, a subsequent NETDEV_UNREGISTER
notification sees j1939_priv_get_by_ndev(ndev) =3D=3D NULL and cannot cance=
l the
timer either.

Furthermore, if the can-j1939 module is unloaded via j1939_module_exit()
during that 250ms window after the socket closes, rcu_barrier() returns
immediately because call_rcu() has not been invoked for ecu->rcu. When
ac_wait_timer fires up to 250ms later, wouldn't the hrtimer subsystem invoke
j1939_ecu_wait_timer_handler() in unmapped module memory?

Similarly, when j1939_netdev_notify() handles NETDEV_DOWN while sockets
remain bound (reg_state =3D=3D NETREG_REGISTERED and rx_kref > 0), pending
ac_wait_timer instances are not canceled in j1939_ecu_unmap_all(), allowing
them to expire while the interface is down and map ECUs into priv->ents[] v=
ia
j1939_ecu_map_locked().

>  	for (i =3D 0; i < ARRAY_SIZE(priv->ents); i++)
>  		if (priv->ents[i].ecu)
>  			j1939_ecu_unmap_locked(priv->ents[i].ecu);
>  	write_unlock_bh(&priv->lock);
>  }
> =20
> -void j1939_ecu_timer_start(struct j1939_ecu *ecu)
> +void j1939_ecu_wait_timer_start(struct j1939_ecu *ecu)
>  {
> -	/* The ECU is held here and released in the
> -	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel().
> +	lockdep_assert_held(&ecu->priv->lock);
> +
> +	/* The corresponding j1939_ecu_put() is in j1939_ecu_map_timer_handler_=
locked()
> +	 * or j1939_ecu_wait_timer_cancel() or j1939_ecu_wait_timer_handler().
>  	 */
> -	j1939_ecu_get(ecu);
> +	if (!j1939_ecu_get(ecu))
> +		return;
> =20
>  	/* Schedule timer in 250 msec to commit address change. */
> -	hrtimer_start(&ecu->ac_timer, ms_to_ktime(250),
> +	hrtimer_start(&ecu->ac_wait_timer, ms_to_ktime(250),
>  		      HRTIMER_MODE_REL_SOFT);
>  }
> =20
> -void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
> +static void j1939_ecu_map_timer_handler_locked(struct j1939_ecu *ecu)
>  {
> -	if (hrtimer_cancel(&ecu->ac_timer))
> +	if (!test_and_clear_bit(0, &ecu->flags))
> +		return;
> +	/* TODO: can we test if ecu->addr is unicast before starting
> +	 * the timer?
> +	 */
> +	j1939_ecu_map_locked(ecu);
> +
> +	/* The corresponding j1939_ecu_get() is in j1939_ecu_wait_timer_start()=
. */
> +	j1939_ecu_put(ecu);
> +}
> +
> +void j1939_ecu_wait_timer_cancel(struct j1939_ecu *ecu)
> +{
> +	if (hrtimer_cancel(&ecu->ac_wait_timer))
> +		/* The corresponding j1939_ecu_get() is in j1939_ecu_wait_timer_start(=
). */
>  		j1939_ecu_put(ecu);
> +	j1939_ecu_map_timer_handler_locked(ecu);
>  }

[Severity: High]
Can calling j1939_ecu_map_timer_handler_locked(ecu) inside
j1939_ecu_wait_timer_cancel() leave ecu->ac_map_timer queued after the timer
reference is dropped, and also map an ECU whose address claim is being
canceled?

When ecu->ac_wait_timer expires, j1939_ecu_wait_timer_handler() sets bit 0 =
of
ecu->flags and calls hrtimer_start(&ecu->ac_map_timer, ms_to_ktime(0),
HRTIMER_MODE_REL_SOFT). Because hrtimer_start() computes softexpires from t=
he
current ktime_get() (which has advanced past basenow sampled at the start of
__hrtimer_run_queues()), ecu->ac_map_timer is left queued for a subsequent
softirq timer pass.

If j1939_ecu_wait_timer_cancel(ecu) is called under write_lock_bh(&priv->lo=
ck)
(from j1939_ac_process() or j1939_ecu_unmap_all()) after
j1939_ecu_wait_timer_handler() has queued ac_map_timer but before
j1939_ecu_map_timer_handler() acquires priv->lock:

1. hrtimer_cancel(&ecu->ac_wait_timer) returns 0, and
   j1939_ecu_wait_timer_cancel(ecu) calls
   j1939_ecu_map_timer_handler_locked(ecu) without canceling
   ecu->ac_map_timer.

2. j1939_ecu_map_timer_handler_locked(ecu) clears bit 0 of ecu->flags, calls
   j1939_ecu_map_locked(ecu), and calls j1939_ecu_put(ecu) while
   ecu->ac_map_timer remains queued in the hrtimer subsystem.

3. If the caller then drops the last reference on ecu (for example in
   j1939_ecu_unmap_all(), or at out_ecu_put in j1939_ac_process() when an
   idle address is received or address contention is lost),
   __j1939_ecu_release_rcu() can run before ac_map_timer fires (such as on
   CONFIG_PREEMPT_RT or when softirq delivery on the target CPU is delayed)
   and trigger WARN_ON(hrtimer_cancel(&ecu->ac_map_timer)).

4. If j1939_ac_process() instead starts a new address claim cycle via
   j1939_ecu_wait_timer_start(ecu), clearing bit 0 of ecu->flags while the
   prior cycle's ac_map_timer is still queued allows the new cycle's
   j1939_ecu_wait_timer_handler() to set bit 0 and race with the earlier
   cycle's pending j1939_ecu_map_timer_handler(), which can clear bit 0 and
   drop the new cycle's timer kref prematurely.

5. In addition, calling j1939_ecu_map_locked(ecu) when canceling a timer
   maps the ECU even though the address claim is being aborted or replaced,
   which can also emit a spurious netdev_warn("Trying to map already mapped
   ECU...") if another contending ECU is already mapped at ecu->addr.

> =20
> -static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrti=
mer)
> +static enum hrtimer_restart j1939_ecu_map_timer_handler(struct hrtimer *=
hrtimer)
>  {
>  	struct j1939_ecu *ecu =3D
> -		container_of(hrtimer, struct j1939_ecu, ac_timer);
> +		container_of(hrtimer, struct j1939_ecu, ac_map_timer);
>  	struct j1939_priv *priv =3D ecu->priv;
> =20
>  	write_lock_bh(&priv->lock);
> -	/* TODO: can we test if ecu->addr is unicast before starting
> -	 * the timer?
> -	 */
> -	j1939_ecu_map_locked(ecu);
> -
> -	/* The corresponding j1939_ecu_get() is in
> -	 * j1939_ecu_timer_start().
> -	 */
> -	j1939_ecu_put(ecu);
> +	j1939_ecu_map_timer_handler_locked(ecu);
>  	write_unlock_bh(&priv->lock);
> +	return HRTIMER_NORESTART;
> +}

[ ... ]

> @@ -160,7 +282,9 @@ struct j1939_ecu *j1939_ecu_create_locked(struct j193=
9_priv *priv, name_t name)
>  	ecu->addr =3D J1939_IDLE_ADDR;
>  	ecu->name =3D name;
> =20
> -	hrtimer_setup(&ecu->ac_timer, j1939_ecu_timer_handler, CLOCK_MONOTONIC,
> +	hrtimer_setup(&ecu->ac_wait_timer, j1939_ecu_wait_timer_handler, CLOCK_=
MONOTONIC,
> +		      HRTIMER_MODE_REL_SOFT);
> +	hrtimer_setup(&ecu->ac_map_timer, j1939_ecu_map_timer_handler, CLOCK_MO=
NOTONIC,
>  		      HRTIMER_MODE_REL_SOFT);

[Severity: High]
Does configuring both ac_wait_timer and ac_map_timer with
HRTIMER_MODE_REL_SOFT still leave a lock inversion with priv->lock on
CONFIG_PREEMPT_RT?

On CONFIG_PREEMPT_RT, hrtimer_run_softirq() holds the per-CPU
cpu_base->softirq_expiry_lock across all HRTIMER_MODE_REL_SOFT timer
callbacks on that CPU:

CPU 0 (softirq timer expiry)
hrtimer_run_softirq()
  spin_lock_bh(&cpu_base->softirq_expiry_lock)
  __hrtimer_run_queues()
    j1939_ecu_map_timer_handler()
      write_lock_bh(&priv->lock)

Meanwhile, j1939_ac_process() and j1939_ecu_unmap_all() call
j1939_ecu_wait_timer_cancel() under write_lock_bh(&priv->lock). If
ac_wait_timer is currently executing its callback, hrtimer_cancel() calls
hrtimer_cancel_wait_running(&ecu->ac_wait_timer), which acquires the same
per-CPU softirq_expiry_lock on CONFIG_PREEMPT_RT:

CPU 1
j1939_ac_process()
  write_lock_bh(&priv->lock)
  j1939_ecu_wait_timer_cancel()
    hrtimer_cancel(&ecu->ac_wait_timer)
      hrtimer_cancel_wait_running()
        spin_lock_bh(&base->cpu_base->softirq_expiry_lock)

Because softirq_expiry_lock is shared per-CPU across all softirq hrtimers
rather than per-timer, if CPU 0 finishes j1939_ecu_wait_timer_handler() and
moves on to j1939_ecu_map_timer_handler() before CPU 1 enters
hrtimer_cancel_wait_running(), can't CPU 0 and CPU 1 deadlock on
softirq_expiry_lock and priv->lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/d0590019-f0c9-4288-=
9653-a7b6056012af@I-love.SAKURA.ne.jp?part=3D1
