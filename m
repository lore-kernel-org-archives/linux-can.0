Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36FA31618B
	for <linux-can@vger.kernel.org>; Sat,  3 Oct 2026 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791068626; cv=none; b=exnsuF29KYCiZnKXI+4Od7LHwNJF4QTQE/TvgAVSlvfcYQFAjlFNv0yI6kI6JRg1C3I3fpKMZkUKKD2KEvfZa2pBKr36hF0/3CQ1b4Tv4j8Kx28eyNPIXy+ZovbSh33mxYy41ydo3DfP3d7JhmirgB9H1/GVseytlvewnj5/t6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791068626; c=relaxed/simple;
	bh=2eX2Dslg1O2i2X1zS+vis4IxBdFZlbBj8pwhj6GqISY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d4He5bHtNuOaFqmJSqkS8duesBxbeabkIi70ReB011pbGd+h5/ie7DAGw+oFFuE4uvA0yMCwYD7fgp/JOG/EAFdqW3IMTfAaVe09SIhJvqn1lrNrYynmZM0f+CfcKALFGIvwATZ4VQ4IxbU+3Eq8mCA+Nqk57YkC31wusc+dJx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glSsuz0f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glSsuz0f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DF91F0089B;
	Sat,  3 Oct 2026 23:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791068624;
	bh=8m4vcgRO6VYXgRPdnAViuA+v7zvYZk2y04F0MDsmH1o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=glSsuz0ffT1H5F20nkxa9nVKTNFAtzY0b2Pw8VJ7YxfUkrSHlgqXUKFTDAv/FMk81
	 sXSebL3bVZ6SgNNO2RkGCPD2ewG6iCG4uxdU6pvM1ZEG0ATT5ttdJUenEN2bypz7K2
	 8TI29U6vflpx/Sw95Ie+ZB7WdKiT/Sg8/0UtzmJuTRsVUAeZjY2rOqchXqodM0LxSa
	 PjLHTitVYgYKBWKPma8HmAN2aEg1HlvTjK5i2H1qW+IAK240vU1IoyZ2oEKhl7DAD+
	 1GgG3PoseGCDKgBLHFM75Eqq+w0LjLuJsm2og6hUBRMERXzqzLSNlVIMlNp9Ym25uE
	 TMDbSGiAqjijA==
Subject: Re: [PATCH v4] can: j1939: cancel all pending ECUs on device stop
From: netdev-bot+sashiko@kernel.org
To: dmantipov@yandex.ru
Cc: robin@protonic.nl, o.rempel@pengutronix.de, socketcan@hartkopp.net,
 mkl@pengutronix.de, linux-can@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+489e907b2a026a6f5fa0@syzkaller.appspotmail.com, kuba@kernel.org
Date: Sat, 03 Oct 2026 23:03:43 +0000
Message-ID: <179106862342.1406898.10232676127266682287@kernel.org>
In-Reply-To: <20261002091552.737529-1-dmantipov@yandex.ru>
References: <20261002091552.737529-1-dmantipov@yandex.ru>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 1 · High: 2 (1) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Refcount underflow leading to use-after-free and double free
  in j1939_ecu_cancel_all() (net/can/j1939/bus.c:105).
- [High] Incomplete fix: the ECU/j1939_priv leak the patch is meant to
  close can still happen.
- [High] j1939_ecu_cancel_all() runs on every per-socket stop, not only
  when the device actually stops.
- [Low] Stale comment in j1939_ecu_timer_start()
  (net/can/j1939/bus.c:123-125).

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  j1939_ac_process() has an ABBA deadlock.

--

can: j1939: cancel all pending ECUs on device stop

This adds j1939_ecu_cancel_all(). It walks priv->ecus under priv->lock,
cancels each ECU's address-claim hrtimer with hrtimer_try_to_cancel() and
drops the ECU reference held by the timer. The helper is called from
j1939_netdev_stop() before the rx_kref put, so that ECUs and their
j1939_priv are not leaked after the device stops.

Closes: https://syzkaller.appspot.com/bug?extid=489e907b2a026a6f5fa0

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index cdc3c0a719379..0b5232b536051 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -96,6 +96,17 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
>  	write_unlock_bh(&ecu->priv->lock);
>  }
>  
> +void j1939_ecu_cancel_all(struct j1939_priv *priv)
> +{
> +	struct j1939_ecu *ecu, *tmp;
> +
> +	write_lock_bh(&priv->lock);
> +	list_for_each_entry_safe(ecu, tmp, &priv->ecus, list)
> +		if (hrtimer_try_to_cancel(&ecu->ac_timer) != -1)
> +			j1939_ecu_put(ecu);

[Severity: Critical]
Can this drop a reference that the timer never took? hrtimer_try_to_cancel()
returns 0 when the timer is not active, 1 when it removed a queued timer,
and -1 when the callback is running. The != -1 test also calls
j1939_ecu_put() when the return value is 0.

The timer's reference is taken in j1939_ecu_timer_start() just before
hrtimer_start(). It is dropped either by the handler or by a cancel that
returns non-zero. The existing helper follows that rule:

void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
{
	if (hrtimer_cancel(&ecu->ac_timer))
		j1939_ecu_put(ecu);
}

An idle ac_timer is the normal state once the 250 ms claim window has
passed. So every j1939_netdev_stop() call drops a reference it does not own
from most ECUs on priv->ecus.

For example, take a socket bound with NAME N and SA S. It has sent an
Address Claimed frame, and the ECU was mapped after 250 ms. The ECU kref is
now 2 (one from bind, one from ents[S]). On close():

j1939_sk_release()
  j1939_local_ecu_put()              kref 2 -> 1
  j1939_netdev_stop()
    j1939_ecu_cancel_all()
      hrtimer_try_to_cancel() == 0
      j1939_ecu_put()                kref 1 -> 0, kfree(ecu)
    kref_put_mutex()
      __j1939_rx_release()
        j1939_ecu_unmap_all()
          j1939_ecu_unmap_locked(priv->ents[S].ecu)

__j1939_ecu_release() does list_del() and kfree() but leaves
priv->ents[S].ecu pointing at the freed ECU. j1939_ecu_unmap_locked() then
reads ecu->priv and ecu->addr, writes ent->nusers and calls j1939_ecu_put()
on the freed object a second time.

If this is not the last rx_kref, the stale ents[] entry can still be reached
from the RX softirq. For example, j1939_ac_recv()->j1939_ecu_get_by_addr()
would call kref_get() on freed memory. Remote ECUs that are held only by
ents[] (kref 1) would also be freed this way whenever any socket is closed.

Should this only call j1939_ecu_put() when hrtimer_try_to_cancel() returns
1, as j1939_ecu_timer_cancel() does?

[Severity: Low]
This isn't a bug, but the comment in j1939_ecu_timer_start() still lists
only two places that release the timer's reference:

	/* The ECU is held here and released in the
	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel().
	 */

Should it also mention j1939_ecu_cancel_all()?

[Severity: High]
This isn't a bug introduced by this patch, but the commit message gives the
deadlock on priv->lock between j1939_ecu_timer_handler() and a synchronous
cancel as the reason for using hrtimer_try_to_cancel() here. The same
pattern is already present in j1939_ac_process():

net/can/j1939/address-claim.c:j1939_ac_process() {
    ...
	write_lock_bh(&priv->lock);
    ...
	/* cancel pending (previous) address claim */
	j1939_ecu_timer_cancel(ecu);
    ...
}

j1939_ecu_timer_cancel() calls hrtimer_cancel(), which waits for a running
callback. The callback starts with:

net/can/j1939/bus.c:j1939_ecu_timer_handler() {
    ...
	write_lock_bh(&priv->lock);
    ...
}

CPU0 (NET_RX softirq)
j1939_can_recv()->j1939_ac_recv()->j1939_ac_process()
  write_lock_bh(&priv->lock)
  j1939_ecu_timer_cancel()
    hrtimer_cancel()     waits while try_to_cancel returns -1

CPU1 (hrtimer softirq, the ECU's ac_timer just expired)
j1939_ecu_timer_handler()
  write_lock_bh(&priv->lock)   spins, held by CPU0

Can these two CPUs lock up waiting on each other? The path is reached when
a claim arrives for a known NAME with a different SA while that ECU's
previous 250 ms timer is expiring. On PREEMPT_RT, the wait is on
softirq_expiry_lock, which is held by the timer thread that is blocked on
priv->lock, so it looks like it still deadlocks there.

> +	write_unlock_bh(&priv->lock);
> +}
> +
>  void j1939_ecu_unmap_all(struct j1939_priv *priv)
>  {
>  	int i;

[ ... ]

> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> index 5e5e6c228f225..1f68ba8037004 100644
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c
> @@ -306,6 +306,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
>  
>  void j1939_netdev_stop(struct j1939_priv *priv)
>  {
> +	j1939_ecu_cancel_all(priv);
>  	kref_put_mutex(&priv->rx_kref, __j1939_rx_release, &j1939_netdev_lock);

[Severity: High]
Is this the right place for a device-wide cancel? j1939_netdev_stop() runs
once per socket: from j1939_sk_release(), from the j1939_sk_bind() error
path and from j1939_sk_netdev_event_unregister(). Only the final rx_kref
drop reaches __j1939_rx_release().

As written, closing any single J1939 socket cancels the pending address
claim timers of every ECU on the interface. That includes local ECUs of
other sockets that are still bound, and remote nodes. RX stays active the
whole time.

A cancelled claim never reaches j1939_ecu_map_locked(). j1939_ac_process()
has already stored ecu->addr = sa before arming the timer, so a repeated
claim with the same NAME and SA takes the early exit and never re-arms the
timer:

	if (ecu && ecu->addr == skcb->addr.sa) {
		...
		goto out_ecu_put;
	}

The surviving socket's ECU then stays unmapped. j1939_name_to_addr()
returns J1939_IDLE_ADDR, and j1939_ac_fixup() fails that socket's
NAME-based sends with -EADDRNOTAVAIL. A local user who opens and closes
J1939 sockets faster than every 250 ms could keep ECUs on the bus from ever
completing their address claim.

The subject says "on device stop". Would it work better to cancel from
__j1939_rx_release(), next to the existing j1939_ecu_unmap_all()?

[Severity: High]
Can an ECU still be mapped after the final j1939_ecu_unmap_all(), leaving
the same j1939_priv and netdev reference leak this patch is meant to fix?
There appear to be two ways.

First, when hrtimer_try_to_cancel() returns -1, j1939_ecu_cancel_all()
skips that ECU and nothing waits for the callback later. If the running
j1939_ecu_timer_handler() gets priv->lock only after this sequence:

__j1939_rx_release()
  j1939_can_rx_unregister(priv);
  j1939_ecu_unmap_all(priv);
  j1939_priv_set(priv->ndev, NULL);

it calls j1939_ecu_map_locked() and takes a new ents[] reference that
nothing releases. This window is wider on PREEMPT_RT, where soft hrtimers
run in a preemptible thread.

Second, the CAN receiver stays registered between j1939_ecu_cancel_all()
and j1939_can_rx_unregister(). can_rx_unregister() also only does
hlist_del_rcu() and call_rcu(), so it does not wait for in-flight
j1939_can_recv() calls. An Address Claimed frame processed in that window
re-arms a timer that holds a reference:

j1939_can_recv()->j1939_ac_recv()->j1939_ac_process()
  j1939_ecu_timer_start(ecu);

250 ms later, the handler maps the ECU after j1939_ecu_unmap_all() has
already run. j1939_priv_set(ndev, NULL) has made priv unreachable from the
notifiers, so that mapping is never undone.

In both cases the ECU keeps its j1939_priv reference and netdev tracker,
and unregister_netdevice() hangs. Would it be better to cancel only after
the RX path is quiesced (or to check a stopping flag under priv->lock), and
to wait for or undo running callbacks in the final rx_kref release?

>  	j1939_priv_put(priv);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002091552.737529-1-dmantipov%40yandex.ru
