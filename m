Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025743;
	b=gs1TDVzWFdw2l5lVo212mKWdb0KSkMlt2zoPz9TcQD2+XMjaxS7OuLW4CPKDbhWWJV68
	 rZi8agdEPdPELtKhYi01hdyZOklxsIP6k8SLFziJOD/dl0hc62pGLzpLFKNkOiM6TQHpF
	 96mgMM0VfqOcvtx9qqrCFT0MTvOq4YRR5A1xRFh7cULeN7QFLJFlb7ENZETijt6cm5kNv
	 NELn+Zw6rw50dQb3fvZq4+i5rlAcoHKlIJKhO0+NiKs+kROcE6uPFnjn841TjtlN/VkRG
	 4yHAL/LDBPtJ3CJIBgyRrx21+rYGZU9J91wc+nEz81ioNM3TRpbLisMrWeY1sSaPTPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025743;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=++ZwYK1Sl+BrNzS/e+TrJX2njBOKgUNsQ58gQcgiVbw=;
	b=C+RQL9DwTFswlDdt6TP4sOIhPM5J2mDgXMTcOf5WcxBB7h1zHEpvz67wsHcsoncVg+w+
	 Dr5OBioiRs4EL5ErTiTp4X6CN4BsuAy+t+xNKEumDIXoz1MNsASDQDx+sw4lDLME92/rM
	 1WoRpZRmgG1N7SQ3dYJ5xynjIPrimdfJxon0x2AbloFoxHUN60RrsevqCkyqHS4lDEZZS
	 aCylJxanhU6rpUCA3pDKjyr7DIKp3ekIDzjTBFi1w7cNmqwMrexbkIHDZhJH90R2X4QIr
	 jEtt8YXS942CMnAG83vOlr8ptqfJ2KEz7BYbEXt0sH3NT32R3VOFG/7mcKVX1wOO1Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b7935XZl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C19F606A326
	for <linux-can@vger.kernel.org>; Sat,  7 Nov 2026 04:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b7935XZl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B64D1F0089F;
	Sat,  7 Nov 2026 04:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794025742;
	bh=++ZwYK1Sl+BrNzS/e+TrJX2njBOKgUNsQ58gQcgiVbw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b7935XZlQH7EA0fGxTSrjNZC9Lxa6o6aKX/fFBCUiA4v9HBE5Eu8FyBmGf7OBQlC+
	 cNPwyZAk09ptMzYHwZ4hFI6nZkPcIbJE2eFrWftOHxtO8Srlnj12J0JGj4QTHYsqif
	 0E9hPKcVZvbAbc6bZNj3Hq2/WkVmUftss41L6g7T5TKTgHOnCVukDMGvwLFcdU9bNC
	 v35J5+XbOBzRjvl72ZKPRVmXeuliyo3QxJMcPL3yvT7zNa4MOhtevV2QxjHBVPIIvZ
	 OvyosK6NNyTpn0shovcVZA5uWuzQbNcidBoj4sE7gtOoIAlUgIK4P9EROA5jbEhcI/
	 SOcrTDPeIn0sg==
Subject: Re: [PATCH v8 1/2] can: j1939: fix possibility of list corruption in
 __j1939_ecu_release()
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Sat, 07 Nov 2026 04:29:01 +0000
Message-ID: <179402574159.488853.7548915141881930317@kernel.org>
In-Reply-To: <3d7e48fa-9af5-43e2-84f7-884e61f9d179@I-love.SAKURA.ne.jp>
References: <3d7e48fa-9af5-43e2-84f7-884e61f9d179@I-love.SAKURA.ne.jp>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] j1939_module_exit() (net/can/j1939/main.c:430-440) calls
  destroy_workqueue(j1939_ecu_wq) without making sure no ECU reference…
- [Low] This patch fixes a real, long-standing bug, but its commit
  message has no Fixes: tag and no Cc: stable.
- [Low] The commit message only mentions a "possibility of list
  corruption".

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a
  deadlock.

--

can: j1939: fix possibility of list corruption in __j1939_ecu_release()

This commit moves the final release of struct j1939_ecu (list_del(),
netdev_put(), kfree() and j1939_priv_put()) to a new j1939_ecu_wq
workqueue. That way the list removal always runs under
write_lock_bh(&priv->lock).

ECUs with a zero refcount can now still be found on priv->ecus and in
priv->ents[]. To handle this, j1939_ecu_get() becomes
kref_get_unless_zero(), and lookups skip ECUs whose kref has dropped to
zero.

> Since not all callers are calling j1939_ecu_put() with priv->lock held
> for write, list corruption might happen if the last user called
> j1939_ecu_put() without priv->lock held for write.

[Severity: Low]
Is "list corruption" the whole story? Before this patch,
__j1939_ecu_release() did this with no lock held:

	list_del(&ecu->list);
	netdev_put(priv->ndev, &ecu->priv_dev_tracker);
	kfree(ecu);
	j1939_priv_put(priv);

At the same time, other CPUs can walk priv->ecus under read_lock_bh().
Two examples are j1939_ecu_find_by_name_locked() (called through
j1939_name_to_addr() on the TX path) and j1939_ecu_get_by_name_locked().
That looks like a use-after-free of struct j1939_ecu, not just corrupted
list pointers.

Could the message also name the callers that drop references without the
lock, j1939_ac_recv() and j1939_ac_fixup()? It could also say that the
netdev tracker reference and the j1939_priv reference are now released
later from j1939_ecu_wq, not synchronously.

> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[Severity: Low]
This fixes a long-standing memory-safety issue. Should it have a Fixes:
tag and Cc: stable?

The old lockless last-put path looks like this:

CPU A
j1939_ac_recv()
  ecu = j1939_ecu_get_by_addr(priv, skcb->addr.sa);
  ...
                                 CPU B
                                 NETDEV_DOWN
                                   j1939_ecu_unmap_all()
                                     j1939_ecu_unmap_locked()
                                       j1939_ecu_put()  <- mapping ref
  j1939_ecu_put(ecu);            <- last ref, list_del()/kfree() unlocked

The lockless callers, j1939_ac_recv() on RX and j1939_ac_fixup() on TX,
look like they go back to the commit that added the protocol:

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

The next patch in the series ("can: j1939: fix "struct j1939_ecu"
refcount leak in j1939_ecu_map_locked()") has a Fixes: tag. It also
depends on the kref_get_unless_zero() semantics added here. Since this
patch has no tag, stable backporters have no hint that they need it as a
prerequisite.

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index cdc3c0a719379..3422e31338004 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c

[ ... ]

> @@ -122,6 +150,7 @@ void j1939_ecu_timer_start(struct j1939_ecu *ecu)
>  void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
>  {
>  	if (hrtimer_cancel(&ecu->ac_timer))
> +		/* Drop the ref from j1939_ecu_timer_start(). */
>  		j1939_ecu_put(ecu);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but can
j1939_ecu_timer_cancel() deadlock against j1939_ecu_timer_handler()?

j1939_ac_process() takes write_lock_bh(&priv->lock) and cancels the timer
while still holding it. The soft hrtimer callback takes the same lock
before doing anything else:

CPU A (CAN RX softirq)
j1939_ac_recv()
  j1939_ac_process()
    write_lock_bh(&priv->lock);
    ...
    j1939_ecu_timer_cancel(ecu)
      hrtimer_cancel(&ecu->ac_timer)
        hrtimer_try_to_cancel()        <- returns -1, callback running
        hrtimer_cancel_wait_running()  <- loops

CPU B (hrtimer softirq)
j1939_ecu_timer_handler()
  write_lock_bh(&priv->lock);          <- spins, CPU A holds it

On !PREEMPT_RT, hrtimer_cancel_wait_running() is only cpu_relax(), so
both CPUs spin forever in softirq context. On PREEMPT_RT it also
deadlocks, through softirq_expiry_lock and the sleeping rwlock.

The trigger is an address-claim frame for an ECU whose ac_timer is
expiring on another CPU. The frame must carry a different SA, so the
early goto out_ecu_put is not taken. Remote CAN peers can send such
frames.

The note below the --- line calls this "can: j1939: ABBA deadlock in
j1939_ecu_timer_cancel() under priv->lock". The next patch in the series
also says "we can't safely call hrtimer_cancel() with priv->lock held".
Neither patch fixes it yet.

[ ... ]

> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> index d9384cf0e356f..2030f24fce704 100644
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
Can a pending ecu->ac_timer still queue release work after this
destroy_workqueue() call?

destroy_workqueue() drains work that is already queued. It does not stop
new work from being queued. The ac_timer holds an ECU reference taken in
j1939_ecu_timer_start(), and nothing on the teardown path cancels the
timer:

- __j1939_rx_release() only calls j1939_ecu_unmap_all().
- The NETDEV_DOWN and NETDEV_UNREGISTER handlers don't cancel it either.

A possible sequence:

1. An address-claim frame arrives, and j1939_ac_process() ->
   j1939_ecu_timer_start() arms the 250 ms soft hrtimer.
2. The last j1939 socket is closed. j1939_netdev_stop() runs, and the
   module reference held through the proto owner is dropped.
3. rmmod runs j1939_module_exit() -> destroy_workqueue(j1939_ecu_wq).
4. The timer fires:

j1939_ecu_timer_handler()
  j1939_ecu_put(ecu)                  <- last reference
    __j1939_ecu_release()
      queue_work(j1939_ecu_wq, &ecu->release_work);

If the timer fires during the drain, __queue_work() rejects the work with
a WARN. The ECU, its netdev tracker reference and its j1939_priv
reference then leak, and netdev unregister can hang waiting for the
device to become free.

If the timer fires after destroy_workqueue() returns, queue_work()
accesses the freed workqueue.

The root cause, a pending ac_timer that outlives module exit, predates
this patch. But this patch adds the dependency on the global workqueue,
and the new comment promises more than destroy_workqueue() alone can
guarantee.

The next patch in the series also says "For now we don't cancel
ecu->ac_timer from j1939_ecu_unmap_all()". Do the ECU hrtimers need to be
cancelled before the workqueue is destroyed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/3d7e48fa-9af5-43e2-84f7-884e61f9d179%40I-love.SAKURA.ne.jp
