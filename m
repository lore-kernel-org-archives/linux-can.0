Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025200;
	b=MDUO6GbLqSottA3tNr7vyfBHvnyCZod6z8iuUWwB1luPvFU6jHsEZ+336lAI/tfy4Ysi
	 x6ypsoRX3tt/Xrk3rK24qgyCti4H5hNPCLZiolhPeXAhMsdY6beW/FzpYb4kcy45PZU9G
	 fwewyYr6SY18d+r7VQAC/HKNFDdatK/ZyH8SRcAc0Hm+ZZvqfrXhUT+ebQ2Ft5tq3C1xa
	 IFUIIZUlL1STL8IFmjHD5YRTqZvEWWKciH7iMoq1ws1GeI7UVH59dVjlK/OZzsjydmQuX
	 23kg9fQ5VIyI36UOVJjHCXLc77sNITzMGyNFTMOI9mPOuCyH0IEBPYZ0a+qSFRb+9hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025200;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rBmkXn2CzjPa1TgdbrdQ8AakmaLk3EMzm0PkbcfguF4=;
	b=0fFOZYDjXMJtX3m3qwq+MCONVI+bCaKnXZq1RJjg3UuT86W2P2jPVxc/vBVDpZOcop0B
	 eCIjf0GkfZqO64OdOaTLGb734rH9a9ZDtKq8VXVTbWSxWPi8+BUfUsVgSmizBTfNTErei
	 WHwhZZgDMx5X2gaaglLMSInWDC0glaVqIEVb8vpvYm672INOG9A7RkdWM0rzXYn6Wm9gd
	 gskfwNE9IhGo443rYUM84vUWo213RRTn5TyyeDpGGvuRfkXBrrYHpbJ1bpkb5Rdh3Xdr+
	 0nIloiawpuPssLz7PUKfQzmKPWiZRt5WKtee8ywhQ5GVWZu3C15tqM9qf0VTGhjh+xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jzZGyZ/D";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A54606A326
	for <linux-can@vger.kernel.org>; Sat,  7 Nov 2026 04:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzZGyZ/D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F97F1F0089F;
	Sat,  7 Nov 2026 04:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794025199;
	bh=rBmkXn2CzjPa1TgdbrdQ8AakmaLk3EMzm0PkbcfguF4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jzZGyZ/DoRhyCu4cfnaUfFUiR7LFO6XAjVo+Q333ARytumu6EMlce5VxfnjxiK6iR
	 z/2coddPbv+fjWKcgLWYqr4PlenY8IznlRhsPNyGM5ObJLnb2PzzOjRKWTtCx56K4I
	 xZrBGIVIT4bA0DOL9A0PT6lsR65jHme2/eSn+A4zyIS2gS8GtF10XSaoH0iBBt0NOq
	 gGtUcVALqGn+JTIPU2DKayD03OTps/1L53styET7xapEXGMMy3lfTtmy/TtVSHSZ25
	 Jolf0jY3aICMk2KPNYYW0qASgiwUkALxh7QCbUmyrE23hYMuDrPIh+ZKGErt6GoxYO
	 Olog7f4fct25w==
Subject: Re: [PATCH v7 1/2] can: j1939: fix possibility of list corruption in
 __j1939_ecu_release()
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Sat, 07 Nov 2026 04:19:58 +0000
Message-ID: <179402519856.488853.13100883367235550085@kernel.org>
In-Reply-To: <00aae7aa-8351-4d69-8938-4d8e4eee78c2@I-love.SAKURA.ne.jp>
References: <00aae7aa-8351-4d69-8938-4d8e4eee78c2@I-love.SAKURA.ne.jp>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit "can: j1939: fix possibility of list corruption in
  __j1939_ecu_release()" fixes a real, reachable memory-safety bug but…
- [Low] The commit message calls the bug only a "possibility of list
  corruption", which understates it.

Pre-existing issues:
- [High] Nothing cancels a pending ecu->ac_timer on teardown, so the new
  destroy_workqueue(j1939_ecu_wq) in j1939_module_exit() does not…
- [High] ABBA-style deadlock in j1939_ac_process()
  (net/can/j1939/address-claim.c).

--

can: j1939: fix possibility of list corruption in __j1939_ecu_release()

This patch moves the final release of a struct j1939_ecu to a dedicated
workqueue, so list_del() on priv->ecus always runs under
write_lock_bh(&priv->lock). ECUs can now stay on priv->ecus with a zero
refcount, so j1939_ecu_get() switches to kref_get_unless_zero() and the
list walkers skip ECUs whose kref has dropped to zero.

> Since not all callers are calling j1939_ecu_put() with priv->lock held
> for write, list corruption might happen if the last user called
> j1939_ecu_put() without priv->lock held for write.

[Severity: Low]
Is list corruption the whole problem here? Before this patch, a final put
without the lock ran list_del() and then kfree() straight away:

__j1939_ecu_release()
    list_del(&ecu->list);
    netdev_put(priv->ndev, &ecu->priv_dev_tracker);
    kfree(ecu);

Some readers walk priv->ecus under read_lock_bh(&priv->lock) and
dereference ecu->name and ecu->list.next:

  - j1939_ecu_find_by_name_locked(), via j1939_name_to_addr() and
    j1939_local_ecu_put()
  - j1939_ecu_get_by_name_locked()

For example:

CPU A: j1939_ac_recv()
    ecu = j1939_ecu_get_by_addr(priv, skcb->addr.sa);
CPU B: unmaps the same ECU under write_lock_bh(&priv->lock)
CPU A:
    j1939_ecu_put(ecu);   <- final put, kfree(ecu) without priv->lock
CPU C: j1939_ecu_find_by_name_locked()
    list_for_each_entry(ecu, &priv->ecus, list)
        if (ecu->name == name)   <- reads the freed ecu

Wouldn't that be a use-after-free, reachable from the CAN RX softirq and
from sendmsg?

The code change covers this, because the release now runs under
write_lock_bh() in __j1939_ecu_release_work(). Could the commit message
mention the use-after-free too?

> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[Severity: Low]
Should this patch carry a Fixes: tag and Cc: stable? The unlocked
list_del() and kfree() in __j1939_ecu_release() come from:

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

j1939_ac_fixup() and j1939_ac_recv() can both drop the last ECU reference
without priv->lock:

j1939_ac_recv()
    ecu = j1939_ecu_get_by_addr(priv, skcb->addr.sa);
    if (ecu) {
        skcb->addr.src_name = ecu->name;
        j1939_ecu_put(ecu);
    }

The next patch in the series, "can: j1939: fix "struct j1939_ecu"
refcount leak in j1939_ecu_map_locked()", carries Fixes: 9d71dd0c7009. It
also edits the bool-returning j1939_ecu_get() that this patch adds.

With no tags on this patch, could stable tooling take the follow-up
without its prerequisite, or skip this fix altogether?

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
This is a pre-existing issue, but can this hrtimer_cancel() deadlock
against j1939_ecu_timer_handler()? j1939_ac_process() calls it with
priv->lock held for write:

j1939_ac_process()
    write_lock_bh(&priv->lock);
    ...
    /* cancel pending (previous) address claim */
    j1939_ecu_timer_cancel(ecu);
        hrtimer_cancel(&ecu->ac_timer);

The timer callback takes the same lock first:

j1939_ecu_timer_handler()
    write_lock_bh(&priv->lock);

Suppose the soft hrtimer callback is already running on CPU1 and spinning
on priv->lock. Then hrtimer_try_to_cancel() on CPU0 returns -1, and
hrtimer_cancel() keeps looping in hrtimer_cancel_wait_running() for a
callback that can never finish. On PREEMPT_RT it waits on the expiry lock,
which is held by the softirq that is blocked on priv->lock.

The trigger is an address-claim frame for the same NAME with a different
SA, arriving while the previous ac_timer is expiring. Any node on the CAN
bus can send such a frame.

The commit notes list this as a separate problem ("ABBA deadlock in
j1939_ecu_timer_cancel() under priv->lock"). Neither this patch nor the
next one in the series changes it.

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

[Severity: High]
This isn't a bug introduced by this patch, but does destroy_workqueue()
here give the guarantee the comment describes? It only drains work that is
already queued. Nothing cancels an ecu->ac_timer that is still armed at
teardown.

j1939_ecu_timer_start() takes an ECU reference and arms a 250 ms timer.
If the last j1939 socket is then closed:

j1939_netdev_stop()
  __j1939_rx_release()
    j1939_ecu_unmap_all()

only the priv->ents[] references are dropped, and hrtimer_cancel() is
never called. With the sockets gone, the module refcount can reach zero,
and rmmod can run j1939_module_exit() while the timer is still pending.

When the timer fires, j1939_ecu_timer_handler() runs from unloaded module
text. If its put is the final one:

j1939_ecu_timer_handler()
  j1939_ecu_put(ecu)
    __j1939_ecu_release()
      queue_work(j1939_ecu_wq, &ecu->release_work);

wouldn't queue_work() operate on the workqueue that destroy_workqueue()
has already freed?

The timer firing into unloaded module text predates this patch, and the
commit notes list the uncanceled ac_timer as separate work.

The follow-up "can: j1939: fix "struct j1939_ecu" refcount leak in
j1939_ecu_map_locked()" fixes the re-map leak by making j1939_ecu_get()
fail once rx_kref is 0. Its commit message says ac_timer is still not
cancelled, so this race is still present at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/00aae7aa-8351-4d69-8938-4d8e4eee78c2%40I-love.SAKURA.ne.jp
