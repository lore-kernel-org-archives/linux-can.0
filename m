Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591482;
	b=YDRtizILtLU9pxicbcyuOybGpf+YAPuPBPAvru1Sz816vnhTP0fOLncFNdYao711/soJ
	 toNn2yJCf2COQInrru3FsJb2KSNTe4YRfeMtPnNIOuq89TqP6xp9czZXLxPCTrmyPjcsy
	 coYqjs1ltzYJmOFcxW9N5ZNLf2HDG+bfALb31hT1qZXKgzQ/JiGQ9WW9lA0DZpxi6idUR
	 PVtTuhFX5/Uns9vCh5vDakp0/uUjY6RO4lFNXyQNorOgCrmFt1/6X6s/ofFEP95DtSAlO
	 rgNEglstHqZYYwbkEH/AvDTlWQRsX9hPcjcRmDQpMQBC29dV1SrxTk/7xDSkofx5UKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591482;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qzvOxSAhsrGsZe3MjLUXKTqtDprRbcLZ/WDuskMMi5Y=;
	b=qZumB/flZSfQIV8mEaS9/0OQGM6wFJYRbSdCsS2539KKjokAI1hBvtAh9+BxsUqVYkHh
	 V1zwJwZ14mlCalleCbJC/TBgpST72gtJuUKm4SalDjKHY+cxZMkfNzjZLU5Fti9rS66fS
	 3Dd6Q/eKBp47JbaLd3rAGLcQl5Fl/gvIsjLw2fUmIzov/+6Sh9Ngwm3/14GOOz+cgLBgF
	 wZO9Mxiv1ZlBmH5wPQIUKZE7D58yHRndWQlyxs1iiKz4a5I1E+R+mMfwUx0Grn2DGzWNb
	 6pclIeGq/bzk37fLdGS29VHbETFeZaj+zxySulmMRcSYZeb/DVECiVRQ5NbDwfO8gFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iexiUaf3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B74607D2FA
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iexiUaf3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DAE1F000C5;
	Fri, 13 Nov 2026 17:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591481;
	bh=qzvOxSAhsrGsZe3MjLUXKTqtDprRbcLZ/WDuskMMi5Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iexiUaf3hnnmK96wdFPrPvmqhZOaqJa6qPCKpToAlHG+kGFWvM9ccPTCdnxbrJZIZ
	 6yjTP812JufrKVNe9W6BPid+nEYlaB37Npl/RYzrWxcd62ldsUvMI8C7NMmYvXzoTZ
	 gmxCcM7h4IyAWRpxV9Kkeh1JXY7/2cdsdFYMTwXjtGi8JhyVCiwb76vGGXqyQRqf+N
	 49WAwTqH0aApCViZ0St/CpHk3VlL2/xI8vjIOPpk2HnLNYH48JDe9/V6dNpm4uLZlw
	 JIbDVuwNnHjpt/7kPEAnP72gmpjbX8EArL+41iw7DVA1WEekfGkE2iWkUnx5IuG93S
	 +Lx48hMi3ykxw==
Message-ID: <sashiko-outbox-213334@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 3/3] can: j1939: fix "struct j1939_ecu" refcount
 leak
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <60b30b7c-91dc-4138-bc92-be922ffd6215@I-love.SAKURA.ne.jp>
References: <8de287d7-b4e1-4062-b40e-b193f5ec68ca@I-love.SAKURA.ne.jp>
 <ba3e6880-6dff-4fa6-a2e4-629c3d35b8d5@I-love.SAKURA.ne.jp>
 <60b30b7c-91dc-4138-bc92-be922ffd6215@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:38:01 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] can: j1939: ecu refcount leak in j1939_ecu_timer_start() when
  handler runs
- [Medium] can: j1939: stale ac_want_abort in j1939_ecu_timer_handler()
  aborts claim
- [Medium] can: j1939: race in j1939_ecu_unmap_all() when ecu kref drops
  to zero
--

commit 9ea6a93bf539408118e87c073de50599bff887f6
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

can: j1939: fix "struct j1939_ecu" refcount leak

This commit cancels pending ecu->ac_timer instances in
j1939_ecu_unmap_all() and adds j1939_ecu_verify_get() so that
j1939_ecu_map_locked() and j1939_ecu_timer_start() do not take new ECU
references after netdev unregistration or __j1939_rx_release().

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
> =20
> +rescan:
>  	write_lock_bh(&priv->lock);
> +	/* Need to shutdown timers now, for j1939_module_exit() might be called
> +	 * relatively shortly after returning from j1939_ecu_unmap_all() from
> +	 * __j1939_rx_release() from j1939_netdev_stop() from j1939_sk_release(=
).
> +	 */
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
> +			/* Get a ref, in order to call hrtimer_cancel() without priv->lock.
> +			 * If we can't get a ref, __j1939_ecu_release_work() will call
> +			 * hrtimer_cancel() without priv->lock, and j1939_module_exit()
> +			 * will wait for completion of __j1939_ecu_release_work().
> +			 */
> +			if (!j1939_ecu_get(ecu))
> +				continue;
> +			break;
> +		}

[Severity: Medium]
Can j1939_ecu_unmap_all() return before __j1939_ecu_release() queues
ecu->release_work on j1939_ecu_wq?

In j1939_ecu_timer_handler(), j1939_ecu_put(ecu) is called after
write_unlock_bh(&priv->lock).  When that drops the final reference,
kref_put() decrements ecu->kref to 0 before __j1939_ecu_release() calls
queue_work(j1939_ecu_wq, &ecu->release_work):

CPU0                              CPU1
j1939_ecu_timer_handler()
  write_unlock_bh(&priv->lock)
  j1939_ecu_put(ecu)
    refcount_dec_and_test() -> 0
                                  j1939_ecu_unmap_all()
                                    write_lock_bh(&priv->lock)
                                    !j1939_ecu_valid(ecu) -> skips ecu
                                    write_unlock_bh(&priv->lock)
                                  j1939_module_exit()
                                    destroy_workqueue(j1939_ecu_wq)
    __j1939_ecu_release()
      queue_work(j1939_ecu_wq, ...)  <-- use-after-free

Because j1939_ecu_valid(ecu) and j1939_ecu_get(ecu) both see ecu->kref =3D=
=3D 0
before queue_work() runs, j1939_ecu_unmap_all() neither cancels
ecu->ac_timer nor waits for the running handler, and destroy_workqueue()
in j1939_module_exit() can complete while CPU0 is still in
__j1939_ecu_release() and j1939_ecu_timer_handler().

> +		write_unlock_bh(&priv->lock);
> +		if (hrtimer_cancel(&ecu->ac_timer))
> +			/* Drop the ref from j1939_ecu_timer_start(). */
> +			j1939_ecu_put(ecu);
> +		/* Drop the ref from default: above. */
> +		j1939_ecu_put(ecu);
> +		goto rescan;
> +	}
> +	/* Unmap any remaining mapped ECUs */
>  	for (i =3D 0; i < ARRAY_SIZE(priv->ents); i++)
>  		if (priv->ents[i].ecu)
>  			j1939_ecu_unmap_locked(priv->ents[i].ecu);
>  	write_unlock_bh(&priv->lock);
>  }
> =20
>  void j1939_ecu_timer_start(struct j1939_ecu *ecu)
>  {
>  	/* The corresponding j1939_ecu_put() is in
> -	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel().
> +	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel() or j1939_ecu_u=
nmap_all().
>  	 */
> -	if (!j1939_ecu_get(ecu))
> +	if (!j1939_ecu_verify_get(ecu))
>  		return;
> =20
>  	/* Schedule timer in 250 msec to commit address change. */

[Severity: High]
Does j1939_ecu_timer_start() leak an ecu reference if two Address Claim
frames are processed while j1939_ecu_timer_handler() is still running on
another CPU?

In __run_hrtimer(), hrtimer_callback_running(&ecu->ac_timer) remains true
until after j1939_ecu_timer_handler() returns, and hrtimer_try_to_cancel()
always returns -1 while the callback is running even if the timer has
already been re-queued:

net/can/j1939/bus.c:j1939_ecu_timer_cancel() {
	switch (hrtimer_try_to_cancel(&ecu->ac_timer)) {
	case 0:	/* Not active or already finished. */
		break;
	case 1:	/* Successfully canceled. */
		/* Drop the ref from j1939_ecu_timer_start(). */
		j1939_ecu_put(ecu);
		break;
	default: /* Currently executing. */
		/* Tell j1939_ecu_timer_handler() to abort unless committed. */
		if (!ecu->ac_commit_done)
			ecu->ac_want_abort =3D true;
	}
}

If two Address Claim frames with changed unicast source addresses arrive on
CPU1 while j1939_ecu_timer_handler() is running on CPU0:

CPU0                              CPU1
j1939_ecu_timer_handler()
                                  j1939_ac_process() [frame 1]
                                    j1939_ecu_timer_cancel(ecu) -> -1
                                      ecu->ac_want_abort =3D true
                                    j1939_ecu_timer_start(ecu)
                                      j1939_ecu_verify_get(ecu)
                                      hrtimer_start(&ecu->ac_timer, ...)
                                  j1939_ac_process() [frame 2]
                                    j1939_ecu_timer_cancel(ecu) -> -1
                                      (does not put ref from frame 1)
                                    j1939_ecu_timer_start(ecu)
                                      j1939_ecu_verify_get(ecu)
                                      hrtimer_start(&ecu->ac_timer, ...)
                                        <-- overwrites queued timer,
                                            leaking frame 1's ecu ref

The leaked ecu->kref also pins priv->kref and ecu->priv_dev_tracker, which
prevents unregister_netdevice() from completing.  In addition, if frame 2
cancels the claim without restarting the timer (for example, with
J1939_IDLE_ADDR) while CPU0 is waiting on write_lock_bh(&priv->lock), CPU0
clears ecu->ac_want_abort =3D false and exits while the timer queued by
frame 1 stays armed and maps the canceled ECU 250 ms later.

[Severity: Medium]
Can a new address claim timer started by j1939_ecu_timer_start() leave a
stale ecu->ac_want_abort set and abort when it fires?

When j1939_ecu_timer_handler() aborts, it leaves ecu->ac_commit_done as
false and unlocks priv->lock before returning:

net/can/j1939/bus.c:j1939_ecu_timer_handler() {
...
	if (ecu->ac_want_abort) {
		ecu->ac_want_abort =3D false;
		goto out;
	}
...
	ecu->ac_commit_done =3D true;
out:
	write_unlock_bh(&priv->lock);

	/* Drop the ref from j1939_ecu_timer_start(). */
	j1939_ecu_put(ecu);
}

If j1939_ac_process() runs on another CPU after write_unlock_bh(&priv->lock)
but before __run_hrtimer() clears base->running:

CPU0                              CPU1
j1939_ecu_timer_handler()
  if (ecu->ac_want_abort)
    ecu->ac_want_abort =3D false
    goto out
  write_unlock_bh(&priv->lock)
                                  j1939_ac_process()
                                    j1939_ecu_timer_cancel(ecu) -> -1
                                      (!ecu->ac_commit_done is true)
                                      ecu->ac_want_abort =3D true
                                    j1939_ecu_timer_start(ecu)
                                      ecu->ac_commit_done =3D false
                                      hrtimer_start(&ecu->ac_timer, ...)
  j1939_ecu_put(ecu)
                                  (250 ms later)
                                  j1939_ecu_timer_handler()
                                    if (ecu->ac_want_abort)
                                      goto out  <-- aborts new claim

Because j1939_ecu_timer_start() does not clear ecu->ac_want_abort and CPU0
has already passed the check, the newly started timer aborts without
mapping the ECU.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/8de287d7-b4e1-4062-=
b40e-b193f5ec68ca@I-love.SAKURA.ne.jp?part=3D3
