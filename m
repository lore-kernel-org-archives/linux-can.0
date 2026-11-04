Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805283;
	b=yg3S9Ufxkd30V1QX0b91/ELYHVnaVRuuoZMIexD3k9kfZOs/DeoYlvaiiEAEl8sg2gF0
	 fRvGA5CODNBJdQddIrFtP3fBenXYtUF9Poju8JM2PRairEeftPlw1Sdec/KXy0gK/dJOQ
	 klg/eyXUukIz4Q1YWA4qAfHiDWoUczNUOPpLvV8hCl84sgD54ps6pLRVpt8jW27PDNCTv
	 3VSWhAvFMTEr15O+1Xfm1Oc7+IENj3V9qluHnF+HOceLaLFhrQQFuDqdVL32jj/rYWb/H
	 pPHeQ3cdaI0TW6PuLtbN3pMwYUnbI48ryZQ41cNQ8kLsjzwWsKCeX3Fi3pZ6r6kXHSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805283;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q/AhVrsBACrn7/3+hWma2gFf0oo34JnCkFYw7U7jf6U=;
	b=Pb57ncaoIxpSwNg9gVM3eov5HkocXIxzCxaLk2VNljWYBnnCgd5ORWclUiBec6LwzIyQ
	 hh6yS2sYTdx8MgEAc7smWwqphajUScOTplm6GdTCBraQPf8cVh59nLwMWMyE0QwmFDtHz
	 lMnUHx3Uj2yf4sLnDUGXsMYQoTne+18vMngIWeQvQjDdR7KIhuTDfvDKLaeKDAnMaz2qf
	 VWnAMIFCrtY+XYy011Or8f6X5kAEODlHPRhgpxsFFoljr9X5kVrP+HLLe0rwQEXzhoUJ/
	 Tcmcpkh8JBkoPM5RXGM958GfUYHrB2GXVc3ts3n1eaIrf88T1beAsUOtt1xgwKde6Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Fa7sEJ/o";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056DF606A328
	for <linux-can@vger.kernel.org>; Wed,  4 Nov 2026 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fa7sEJ/o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662821F000C1;
	Wed,  4 Nov 2026 15:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793805282;
	bh=q/AhVrsBACrn7/3+hWma2gFf0oo34JnCkFYw7U7jf6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fa7sEJ/orRYnlVihtHBPxTHoTpLhPh6TDKt73eBXHX3dpDgzfYk1GmEwKZyzeD3oI
	 ScqMO8ViQsANb1bz8Ga7z3riyWrpW1Rd9Khn2pOBZr+IjPBZoY0cGuq4h3H2/Dr/l9
	 fzX4eZzW+N/YWCFt2pkv4xmgrFpeD99Y+XLKgMdxOvGpOjojnpTCSKVjNUCKUwwk0S
	 rInivZoCsvtxCNRjO4P/iS8eMtyvQcU/kqZKQcxPzOlJ4aea6euZIKMCuExVJmYhAN
	 MY0rqL6z/zCUPM8Qf3Bf2bbkjSVlEESHYrL1ls0tFhgMoq7DQkoBilbS7zgW8tSZTX
	 Oztfv+waIZ5vw==
Message-ID: <sashiko-outbox-197493@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] can: j1939: fix j1939_ecu refcount leak and related
 race conditions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <c9de355a-d66e-4f28-9636-a6fef8fe8b84@I-love.SAKURA.ne.jp>
References: <c9de355a-d66e-4f28-9636-a6fef8fe8b84@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 15:14:41 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] can: j1939: double j1939_ecu_put() when j1939_ecu_timer_cancel=
() cancels tasklet
- [High] can: j1939: deadlock between priv->lock and softirq_expiry_lock on=
 PREEMPT_RT
--

commit d7414e2af41caab32fbea0f148b824054b2357bd
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

can: j1939: fix j1939_ecu refcount leak and related race conditions

This commit fixes a struct j1939_ecu reference count leak and related race
conditions by deferring ECU release to a workqueue, handing off address cla=
im
timer completion to a tasklet, and validating netdev registration and RX
reference counts before acquiring ECU references.

Link: https://lkml.kernel.org/r/179202402875.794844.18141702206663586949.b4=
-review@b4

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
> =20
>  	write_lock_bh(&priv->lock);
> +	/* Although j1939_ecu_get() from j1939_ecu_map_locked() from
> +	 * j1939_ecu_tasklet_handler() will fail if netdev is no longer
> +	 * registered or __j1939_rx_release() was called, cancel the 250ms
> +	 * timer in order to speed up teardown operation.
> +	 */
> +	list_for_each_entry(ecu, &priv->ecus, list)
> +		j1939_ecu_timer_cancel(ecu);
> +	/* Unmap any remaining mapped ECUs */
>  	for (i =3D 0; i < ARRAY_SIZE(priv->ents); i++)
>  		if (priv->ents[i].ecu)
>  			j1939_ecu_unmap_locked(priv->ents[i].ecu);
> @@ -109,10 +157,11 @@ void j1939_ecu_unmap_all(struct j1939_priv *priv)
> =20
>  void j1939_ecu_timer_start(struct j1939_ecu *ecu)
>  {
> -	/* The ECU is held here and released in the
> +	/* The corresponding j1939_ecu_put() is in
>  	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel().
>  	 */
> -	j1939_ecu_get(ecu);
> +	if (!j1939_ecu_get(ecu))
> +		return;
> =20
>  	/* Schedule timer in 250 msec to commit address change. */
>  	hrtimer_start(&ecu->ac_timer, ms_to_ktime(250),
> @@ -121,29 +170,99 @@ void j1939_ecu_timer_start(struct j1939_ecu *ecu)
> =20
>  void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
>  {
> +	/* Drop the ref from j1939_ecu_timer_start() if j1939_ecu_timer_handler=
() was not called.
> +	 * Don't drop the ref from j1939_ecu_timer_start() if j1939_ecu_timer_h=
andler() was already
> +	 * called.
> +	 */
>  	if (hrtimer_cancel(&ecu->ac_timer))
>  		j1939_ecu_put(ecu);

[Severity: High]
As reported by Sashiko on v5 [1], can calling hrtimer_cancel(&ecu->ac_timer)
in j1939_ecu_timer_cancel() while holding write_lock_bh(&priv->lock) in
j1939_ecu_unmap_all() and j1939_ac_process() still cause an AB-BA deadlock =
on
PREEMPT_RT kernels?

Because ecu->ac_timer is set up with HRTIMER_MODE_REL_SOFT, if ecu->ac_timer
is currently running its callback when hrtimer_cancel() is called,
hrtimer_try_to_cancel() returns -1 and hrtimer_cancel_wait_running() acquir=
es
spin_lock_bh(&base->cpu_base->softirq_expiry_lock) while priv->lock is held:

  j1939_ecu_unmap_all() / j1939_ac_process()
    write_lock_bh(&priv->lock)
    j1939_ecu_timer_cancel()
      hrtimer_cancel(&ecu->ac_timer)
        hrtimer_cancel_wait_running()
          spin_lock_bh(&base->cpu_base->softirq_expiry_lock)

However, softirq_expiry_lock is a per-CPU lock held by hrtimer_run_softirq()
across all HRTIMER_MODE_REL_SOFT timer callbacks on that CPU. In
net/can/j1939/transport.c, session->txtimer (j1939_tp_txtimer) and
session->rxtimer (j1939_tp_rxtimer) also use HRTIMER_MODE_REL_SOFT and acqu=
ire
priv->lock under softirq_expiry_lock:

  hrtimer_run_softirq()
    spin_lock_bh(&cpu_base->softirq_expiry_lock)
    __hrtimer_run_queues()
      j1939_tp_txtimer() / j1939_tp_rxtimer()
        j1939_send_one()
          j1939_ac_fixup()
            j1939_ecu_get_by_name() -> read_lock_bh(&priv->lock)
            j1939_ecu_unmap() -> write_lock_bh(&ecu->priv->lock)

If one CPU holds write_lock_bh(&priv->lock) and waits in
hrtimer_cancel_wait_running() for ecu->ac_timer on another CPU, and that
other CPU finishes j1939_ecu_timer_handler() and advances in
__hrtimer_run_queues() to an expired session->txtimer or session->rxtimer,
won't the two CPUs deadlock on softirq_expiry_lock and priv->lock?

> +	/* Drop the ref from j1939_ecu_timer_handler() if test_and_set_bit() in
> +	 * j1939_ecu_timer_handler() succeeded and j1939_ecu_tasklet_handler() =
is not yet called.
> +	 * Don't drop the ref from j1939_ecu_timer_handler() if test_and_set_bi=
t() in
> +	 * j1939_ecu_timer_handler() failed or j1939_ecu_tasklet_handler() was =
already called.
> +	 */
> +	if (test_and_clear_bit(0, &ecu->flags))
> +		j1939_ecu_put(ecu);
>  }
> =20
>  static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrti=
mer)
>  {
>  	struct j1939_ecu *ecu =3D
>  		container_of(hrtimer, struct j1939_ecu, ac_timer);
> +
> +	/* The corresponding j1939_ecu_put() is in
> +	 * j1939_ecu_tasklet_handler() or j1939_ecu_timer_cancel().
> +	 */
> +	if (!j1939_ecu_get(ecu))
> +		goto out;

[ ... ]

> +	if (likely(!test_and_set_bit(0, &ecu->flags))) {
> +		tasklet_schedule(&ecu->ac_tasklet);
> +	} else {
> +		netdev_warn(ecu->priv->ndev,
> +			    "Skipped mapping ECU, addr: 0x%02x, name: 0x%016llx.\n",
> +			    ecu->addr, ecu->name);
> +		j1939_ecu_put(ecu);
> +	}
> +out:
> +	/* Drop the ref from j1939_ecu_timer_start(). */
> +	j1939_ecu_put(ecu);
> +	return HRTIMER_NORESTART;
> +}
> +
> +static void j1939_ecu_tasklet_handler(struct tasklet_struct *tasklet)
> +{
> +	struct j1939_ecu *ecu =3D container_of(tasklet, struct j1939_ecu, ac_ta=
sklet);
>  	struct j1939_priv *priv =3D ecu->priv;
> =20
>  	write_lock_bh(&priv->lock);
> +	/* Check if j1939_ecu_timer_cancel() was called. */
> +	if (!test_and_clear_bit(0, &ecu->flags))
> +		goto out;
>  	/* TODO: can we test if ecu->addr is unicast before starting
>  	 * the timer?
>  	 */
>  	j1939_ecu_map_locked(ecu);
> -
> -	/* The corresponding j1939_ecu_get() is in
> -	 * j1939_ecu_timer_start().
> -	 */
> -	j1939_ecu_put(ecu);
> + out:
>  	write_unlock_bh(&priv->lock);
> -
> -	return HRTIMER_NORESTART;
> +	/* Drop the ref from j1939_ecu_timer_handler(). */
> +	j1939_ecu_put(ecu);
>  }

[Severity: Critical]
As reported by Sashiko on v5 [2], doesn't this drop the reference from
j1939_ecu_timer_handler() twice when j1939_ecu_timer_cancel() races with the
scheduled tasklet?

When ecu->ac_timer fires, j1939_ecu_timer_handler() takes one new reference=
 on
ecu for the tasklet handoff, sets bit 0 of ecu->flags, schedules
ecu->ac_tasklet, and drops the initial timer reference from
j1939_ecu_timer_start().

If j1939_ecu_timer_cancel(ecu) is then called under write_lock_bh(&priv->lo=
ck)
(from j1939_ac_process() or j1939_ecu_unmap_all()) before
j1939_ecu_tasklet_handler() acquires write_lock_bh(&priv->lock):

  j1939_ecu_timer_cancel()
    if (test_and_clear_bit(0, &ecu->flags))
      j1939_ecu_put(ecu);

j1939_ecu_timer_cancel() clears bit 0 and drops the tasklet's reference, wh=
ile
ecu->ac_tasklet remains scheduled.

When j1939_ecu_tasklet_handler() subsequently runs, test_and_clear_bit(0,
&ecu->flags) returns false and jumps to out, which unlocks priv->lock and
still calls j1939_ecu_put(ecu) a second time for the same reference. Won't
this underflow ecu->kref and prematurely free struct j1939_ecu?

Furthermore, if j1939_ac_process() calls j1939_ecu_timer_cancel(ecu) follow=
ed
by j1939_ecu_timer_start(ecu), clearing bit 0 in j1939_ecu_timer_cancel()
while ecu->ac_tasklet is still queued allows a subsequent
j1939_ecu_timer_handler() to see bit 0 clear if the tasklet was delayed.

[1] https://lore.kernel.org/r/d0590019-f0c9-4288-9653-a7b6056012af@I-love.S=
AKURA.ne.jp
[2] https://lore.kernel.org/r/d0590019-f0c9-4288-9653-a7b6056012af@I-love.S=
AKURA.ne.jp

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/c9de355a-d66e-4f28-=
9636-a6fef8fe8b84@I-love.SAKURA.ne.jp?part=3D1
