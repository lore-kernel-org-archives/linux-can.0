Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795814460;
	b=FY+34kou7pXxH56Ksl/P9OjRzudacYZDnIcNIT/plxLD5AeD24zr5RpzTjLg9UGT5Q98
	 LRxjaDPEBVQs/ls4+UP+xfUSM4exKMlq1teWrn4xzTWSXaPkYebGvwHWofRnz/yyqBZ12
	 QmWPTXmO+1JD+s20c+0zkEhPE1VNmR7d68+eR/P/+VKRUngdDFWWjiUZVaYqnVceXJ9T0
	 FPR7Ns/ERE98Am57FPjSfzKekwHkNjeRMOYFy1cpRnNJgeZSltXfDzulBBwznamW2DZ1H
	 YF4TR896S2q8NXT3+E4JJQ1ccCnksb7oq80Z+3w6SuXfry00Y0oyEdLbleyrVelZoaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795814460;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ly1apLr7OkWIDurB9d/lgQbHVHVg/Kqu260IAZP44BA=;
	b=hDnA5kh1J3H4NIALytm2R6oW99gGdWaEabUTDCImH99bkfTXxXzlVyuqDy/K2B2NcwU6
	 QH3xBG1RnYGeNFRiNFiVtW4criS6xbNnJ7f0PXPM+nJ4O1myj4sSMjuBWidcMvO41xQeW
	 KxLgvcSmMOYwukKNDAVyCa3EDpkcyCMtFVFNTIjA3FQbdQTh6SjPohQfLXOGjNS9MBEYx
	 DXijIQ4Jq9BxeWRMExEabyvDVxMChP3t/ecjnhxwRHmIOTi5tLmX5Dw9wTh3HtsHkqnbj
	 bI3wTnqbUAPCsra7uJISSYjj7WXGSLTLkUFU54cvgG/Y7r9PclspcUPwuzTsbrjraLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwyQOC3F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D21C606A31C
	for <linux-can@vger.kernel.org>; Fri, 27 Nov 2026 21:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwyQOC3F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67A51F00899;
	Fri, 27 Nov 2026 21:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795814460;
	bh=ly1apLr7OkWIDurB9d/lgQbHVHVg/Kqu260IAZP44BA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hwyQOC3F94vK++gkMWBaibhv+Cak7WK48c5PQhnbv4y2juLQkSvr0jjA9SYorAK13
	 DLO8sJZmPEOGdlrjUtqStKfmKZzCVX3kJ38ZyGdhwO29btS9yGHPVCKMyCVWW7tYQU
	 s4CKOJis90w6RxxQlEKItiprD3XqUBBPeSpwUvnq+3u9oljaZ72ldSIb2M0wTu0NTf
	 B9CKEbDlCMSBEkb6Weffy78sEAHEvm+TZCeQE1FNvIshOqNeqJymrqQTwkDohFFF9j
	 nNEVc4pRmCcZgF+TUPc6a8VO7jByunRGD9E3p3r7Xtymfrhn5ZUY8NTnhRR6JQPB8P
	 clzcKbmG8YrQg==
Subject:
 Re: [PATCH RESEND v4] can: j1939: cancel all pending ECUs on device stop
From: netdev-bot+sashiko@kernel.org
To: dmantipov@yandex.ru
Cc: robin@protonic.nl, o.rempel@pengutronix.de, socketcan@hartkopp.net,
 mkl@pengutronix.de, linux-can@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+489e907b2a026a6f5fa0@syzkaller.appspotmail.com, kuba@kernel.org
Date: Fri, 27 Nov 2026 21:20:59 +0000
Message-ID: <179581445921.3131.2282726576035151270@kernel.org>
In-Reply-To: <20261126082257.491041-1-dmantipov@yandex.ru>
References: <20261126082257.491041-1-dmantipov@yandex.ru>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 1 · High: 2 (1) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] j1939_ecu_cancel_all() (net/can/j1939/bus.c:99-108) calls
  j1939_ecu_put() whenever `hrtimer_try_to_cancel(&ecu->ac_timer) != -1`.
- [High] The fix is incomplete: the claim timer can still map an ECU
  after j1939_ecu_unmap_all(), so the ECU/priv/netdev leak the patch…
- [High] The commit message says pending ECUs are cancelled "on device
  stop", but j1939_ecu_cancel_all() runs unconditionally at the top of…
- [Low] The ownership comment in j1939_ecu_timer_start() (bus.c:123-125)
  says the timer's ECU reference "is held here and released in the…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is the same
  lock/timer inversion the patch says it avoids.

--

can: j1939: cancel all pending ECUs on device stop

This patch adds j1939_ecu_cancel_all(). It walks priv->ecus under
priv->lock, cancels each ECU's address-claim timer with
hrtimer_try_to_cancel() and drops the ECU reference. It is called from
j1939_netdev_stop() so that ECUs, and the j1939_priv they reference, are
not left unfreed after the device is stopped.

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
Can this drop a reference that the timer never held?

hrtimer_try_to_cancel() returns 0 when the timer is not active. That is
the case for an ECU whose claim timer was never armed or has already
fired. The != -1 test handles 0 the same way as a successful cancel (1),
so j1939_ecu_put() runs for every idle ECU on priv->ecus.

The timer reference is only taken in j1939_ecu_timer_start():

	j1939_ecu_get(ecu);

	/* Schedule timer in 250 msec to commit address change. */
	hrtimer_start(&ecu->ac_timer, ms_to_ktime(250),
		      HRTIMER_MODE_REL_SOFT);

The existing j1939_ecu_timer_cancel() only puts when an armed timer was
actually removed:

	if (hrtimer_cancel(&ecu->ac_timer))
		j1939_ecu_put(ecu);

For a remote ECU that has finished its address claim, the sequence is:

j1939_ac_process()
    j1939_ecu_create_locked()       kref = 1
    j1939_ecu_timer_start()         kref = 2
    out_ecu_put: j1939_ecu_put()    kref = 1

j1939_ecu_timer_handler()  (250 ms later)
    j1939_ecu_map_locked()          kref = 2, priv->ents[sa].ecu = ecu
    j1939_ecu_put()                 kref = 1

j1939_sk_release()  (any j1939 socket on that interface)
    j1939_netdev_stop()
        j1939_ecu_cancel_all()
            hrtimer_try_to_cancel() returns 0
            j1939_ecu_put()         kref = 0, kfree(ecu)

At this point priv->ents[sa].ecu still points at the freed ECU.

If that was the last socket, __j1939_rx_release()->j1939_ecu_unmap_all()
calls j1939_ecu_unmap_locked() on it. That reads ecu->priv and ecu->addr
from freed memory, puts the freed object a second time, and drops
priv->kref an extra time.

If other sockets keep the device alive, the next frame from that address
goes through j1939_ac_recv()->j1939_ecu_get_by_addr(). That calls
kref_get() on the freed ECU and then reads ecu->name.

Local ECUs are hit the same way. Closing an unrelated socket can drop a
reference owned by a bound socket's j1939_local_ecu_get() or by the ents[]
mapping. The owner then gets a use-after-free later, or hits the
WARN_ON_ONCE(!ecu) in j1939_local_ecu_put().

Should this check be == 1 instead, to match j1939_ecu_timer_cancel()?

> +	write_unlock_bh(&priv->lock);

[Severity: High]
Does this fully close the leak described in the commit message?

j1939_ecu_cancel_all() runs at the top of j1939_netdev_stop(), while
j1939_can_recv() is still registered. The RX handler is only unregistered
later, in __j1939_rx_release():

	j1939_can_rx_unregister(priv);
	j1939_ecu_unmap_all(priv);
	j1939_priv_set(priv->ndev, NULL);

Once priv->lock is dropped here, a PGN_ADDRESS_CLAIMED frame can still
reach j1939_ac_recv()->j1939_ac_process()->j1939_ecu_timer_start(). That
arms a new claim timer with a new ECU reference. can_rx_unregister() also
does not wait for receivers that are already running under RCU.

When hrtimer_try_to_cancel() returns -1, the callback is already running
and spinning on the priv->lock held here. In that case the ECU is skipped
and nothing waits for the callback to finish.

Either way, j1939_ecu_timer_handler() can run j1939_ecu_map_locked() after
j1939_ecu_unmap_all(). That sets priv->ents[addr].ecu and takes a
reference. Because priv has already been detached from the netdev, nothing
unmaps it again. The ECU, its j1939_priv reference and the netdev_hold() in
ecu->priv_dev_tracker are all leaked.

Would it be better to kill the timers synchronously in the last-reference
path, after the RX handler is unregistered and RCU readers have drained?

> +}

[Severity: High]
This isn't a bug introduced by this patch, but the commit message gives
the priv->lock vs. timer callback deadlock as the reason for using
hrtimer_try_to_cancel() here. The same pattern is still present in
j1939_ac_process(), which calls hrtimer_cancel() while holding priv->lock:

net/can/j1939/address-claim.c:j1939_ac_process() {
    ...
	write_lock_bh(&priv->lock);
    ...
	/* cancel pending (previous) address claim */
	j1939_ecu_timer_cancel(ecu);
    ...
}

j1939_ecu_timer_cancel() calls hrtimer_cancel(), which loops until the
callback has finished. j1939_ecu_timer_handler() starts with:

	write_lock_bh(&priv->lock);

CPU0 (NET_RX softirq)                 CPU1 (HRTIMER_SOFTIRQ)
                                      j1939_ecu_timer_handler()
j1939_ac_process()
    write_lock_bh(&priv->lock)
                                          write_lock_bh(&priv->lock)
                                          <spins>
    j1939_ecu_timer_cancel()
        hrtimer_cancel()
        <spins waiting for callback>

To trigger this, a remote node sends an AC frame for the same NAME with a
different address just as the previous 250 ms claim timer expires.

Can either CPU make progress in this case?

[Severity: Low]
This isn't a bug, but the ownership comment in j1939_ecu_timer_start()
still says:

	/* The ECU is held here and released in the
	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel().
	 */

Should it also list j1939_ecu_cancel_all() as a release site?

[ ... ]

> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> index d9384cf0e356f..4b62da9fd96dc 100644
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c
> @@ -306,6 +306,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
>  
>  void j1939_netdev_stop(struct j1939_priv *priv)
>  {
> +	j1939_ecu_cancel_all(priv);
>  	kref_put_mutex(&priv->rx_kref, __j1939_rx_release, &j1939_netdev_lock);

[Severity: High]
Is this the right place for the cancel?

j1939_netdev_stop() is called once per socket: from j1939_sk_bind() on
failure, from j1939_sk_release(), and from the netdev notifier. The real
device teardown only happens in __j1939_rx_release(), when the last
rx_kref is dropped.

As written, closing any single j1939 socket cancels every pending
address-claim timer on the interface. That includes claims owned by other
bound sockets and claims from remote ECUs seen on the bus.

j1939_ecu_map_locked() never runs for a cancelled claim, so the ECU keeps
ecu->addr but has no priv->ents[] entry. j1939_name_to_addr() then returns
J1939_IDLE_ADDR because j1939_ecu_is_mapped_locked() is false. Name-based
senders on the remaining sockets fail with EADDRNOTAVAIL.

This does not recover when the peer repeats its claim. j1939_ac_process()
skips re-arming the timer if the NAME and address match:

	if (ecu && ecu->addr == skcb->addr.sa) {
		...
		goto out_ecu_put;
	}

Should the cancellation move into __j1939_rx_release() instead?

The subject says "cancel all pending ECUs on device stop", but the code
runs the cancel on every socket stop, not only on device stop.

>  	j1939_priv_put(priv);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126082257.491041-1-dmantipov%40yandex.ru
