Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794126324;
	b=oso6q7yWEx3Y2if0V0GAhRsDkWzKtWdQZNwtoecFtSxFxQAN4E6N/jnqw/mldMwEx2DH
	 gZ6Vy88C4Maa1NcW1kkE5YjHenjJZlVem7scC1BmVIuT4UoT29W2XrDcwjrv1e5st8OBg
	 qEMkfrbq4nkbiYIMohoNofCCITS+6UaaEv896y1UeiRcWVmDNAnRoWfAm+IxnCMPWHMPH
	 l3owh1jitlc6lHf8EoXCBZFQ1AuJTGUrAEHioCSVm53Khbv9rzGWr8mGV5gvBfFmj8rV2
	 sTzXcU3cqnINzj1yEjd7TNI8A2eIFq4IHReGIMyiQVkUFHJgVpOQ93sQsufjkMh68VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794126324;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Wy58vSbXBM0A236dvwH2MVx4ZsW7iGg0quDXtxNLMiM=;
	b=pPdnu9vrL+597B+ui/3AX1VqUB1q/PxfDsGQOwmupKmHPY/OsDmX8HEKeAKmTK3C7rHO
	 ixEaH8pRoXRGh5vbVc5E+KpTLaKeoOmquXk65QdVy6mSTO1/jS4p2kYBGSoOYeamwHW2X
	 sP4WpwYdVBlNHLLfnhHWWdQRz3IYUlEAaWWdFVLmbwunA2ZZ6XJo5C+GGunZ+Jx7hnX3S
	 6iCV2MToIBkl4+nUg1jiWJ965clhlbzt+kzpZX5Y+/3bE2PhmnqHcHPm+DWHE3w7sCur1
	 OJQsEOtbaeIidW7/x7pAL266Xea+/SR9Qzo3M64/BpUckgYnM9VRMVp9y6YeyB9W0TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCs6nYOj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A64606A31C
	for <linux-can@vger.kernel.org>; Sun,  8 Nov 2026 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fCs6nYOj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5F51F0089F;
	Sun,  8 Nov 2026 08:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794126323;
	bh=Wy58vSbXBM0A236dvwH2MVx4ZsW7iGg0quDXtxNLMiM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fCs6nYOjogJkDdTd1nIs0huEoaBJ/vbca0gcmgPZGookUhC7deFT6C4dYxos7XfWs
	 IhStl/2xdjU/nk/oAHZjlJChsNJhWnEi9/UhT2DL9paAPtK65QULsmkjTXLb7kFcIx
	 K6uBJupWBs3weBIbWAw/LXMOMckRgKMoP/SFVLZFtkH1kSzoSck0rfWJ/aJsfiXj35
	 UqqCEF5rjZbGsSYjefEa1OBKqdIMPzML/BqUURXfYUDNadbExNWSypXzUmvSWApOPk
	 I6bMdocceiu5Q65xHoru5EPomOAJBtolVnixWE5x1j6347qaHmbs576DPKMD0aYtyV
	 kosPlld+oaAWA==
Subject: Re: [PATCH v9 1/2] can: j1939: fix possibility of list corruption in
 __j1939_ecu_release()
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Sun, 08 Nov 2026 08:25:22 +0000
Message-ID: <179412632236.488853.14928482596814971233@kernel.org>
In-Reply-To: <396b5de7-3fe0-474f-9194-b4816fde7182@I-love.SAKURA.ne.jp>
References: <396b5de7-3fe0-474f-9194-b4816fde7182@I-love.SAKURA.ne.jp>
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

- [Medium] At this commit, j1939_module_exit() relies on
  destroy_workqueue(j1939_ecu_wq) to stop all __j1939_ecu_release_work().
- [Low] Commit "can: j1939: fix possibility of list corruption in
  __j1939_ecu_release()" fixes a real memory-safety bug but has no…
- [Low] The commit message says only that 'list corruption might happen'
  and does not name the callers that put without the lock.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is still
  present at the end of the series.

--

can: j1939: fix possibility of list corruption in __j1939_ecu_release()

This patch moves the release steps for struct j1939_ecu out of
__j1939_ecu_release() and into a new j1939_ecu_wq workqueue. There,
priv->lock can be held for write around list_del(). Lookups now use
kref_get_unless_zero() and kref_read(), so they skip ECUs whose refcount
has already reached zero.

> Since not all callers are calling j1939_ecu_put() with priv->lock held
> for write, list corruption might happen if the last user called
> j1939_ecu_put() without priv->lock held for write.

[Severity: Low]
Does "list corruption" cover the whole problem? Could the commit message
name the callers that drop the last reference without the lock, and the
use-after-free that follows?

For example, j1939_ac_recv() gets its reference from
j1939_ecu_get_by_addr(), which drops priv->lock before it returns. It
then puts that reference without the lock:

net/can/j1939/address-claim.c:j1939_ac_recv() {
    ...
		ecu = j1939_ecu_get_by_addr(priv, skcb->addr.sa);
		if (ecu) {
			skcb->addr.src_name = ecu->name;
			j1939_ecu_put(ecu);
		}
    ...
}

If that put is the last one, the old __j1939_ecu_release() runs
list_del(&ecu->list) and kfree(ecu) without priv->lock.

At the same time, another CPU can be walking priv->ecus under
read_lock_bh() in j1939_ecu_get_by_name_locked(),
j1939_ecu_find_by_name_locked() or j1939_name_to_addr(). That CPU would
dereference the entry being freed. The old j1939_ecu_get_by_name_locked()
could also kref_get() an ECU whose refcount had already reached zero.

Since frames on the CAN bus can trigger this, should the message call it
a use-after-free?

> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[Severity: Low]
Should this have a Fixes: tag and a Cc: stable? The unlocked list_del()
and kfree() in __j1939_ecu_release() seem to go back to the original
J1939 commit:

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

The next patch in this series, "can: j1939: fix "struct j1939_ecu"
refcount leak", has that tag.

This patch also uses WQ_PERCPU, which older trees don't have, so
backports will need changes. Could the stable intent be stated
explicitly?

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
This isn't a bug introduced by this patch, but can the synchronous
hrtimer_cancel() here deadlock against j1939_ecu_timer_handler()?

j1939_ac_process() calls j1939_ecu_timer_cancel() while it holds
priv->lock for write:

net/can/j1939/address-claim.c:j1939_ac_process() {
    ...
	write_lock_bh(&priv->lock);
    ...
	/* cancel pending (previous) address claim */
	j1939_ecu_timer_cancel(ecu);
    ...
}

The timer callback takes the same lock first:

net/can/j1939/bus.c:j1939_ecu_timer_handler() {
    ...
	write_lock_bh(&priv->lock);
    ...
}

CPU0                                  CPU1
j1939_can_recv()
 j1939_ac_recv()
  j1939_ac_process()
   write_lock_bh(&priv->lock)
                                      j1939_ecu_timer_handler()
                                       write_lock_bh(&priv->lock)
                                       <spins>
   j1939_ecu_timer_cancel()
    hrtimer_cancel()
     <callback running, loops>

hrtimer_try_to_cancel() keeps returning -1 while the callback runs. On
!PREEMPT_RT, hrtimer_cancel_wait_running() is only cpu_relax(), so
neither CPU makes progress, and bottom halves are disabled on both.

The trigger is an address-claim frame for the same name with a
different source address. It has to arrive just as that ECU's 250 ms
ac_timer starts running on another CPU, so any node on the CAN bus can
cause it.

The notes after the commit message call this a separate problem ("ABBA
deadlock in j1939_ecu_timer_cancel() under priv->lock"). The FIXME that
the later patch in this series adds in j1939_ecu_timer_cancel() only
mentions the PREEMPT_RT softirq_expiry_lock variant.

Does the plain spin-versus-wait case above on !PREEMPT_RT need handling
too? It still looks present at the end of the series.

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
At this commit, can a pending ecu->ac_timer still queue release work
after destroy_workqueue() has run?

destroy_workqueue() only drains work that is already queued. At this
point, j1939_ecu_unmap_all() does not cancel ecu->ac_timer:

net/can/j1939/bus.c:j1939_ecu_unmap_all() {
	...
	write_lock_bh(&priv->lock);
	for (i = 0; i < ARRAY_SIZE(priv->ents); i++)
		if (priv->ents[i].ecu)
			j1939_ecu_unmap_locked(priv->ents[i].ecu);
	write_unlock_bh(&priv->lock);
}

The timer still holds the ECU reference taken in
j1939_ecu_timer_start(). If rmmod runs within 250 ms of the last j1939
socket closing, the timer can fire afterwards and do this:

j1939_ecu_timer_handler()
  j1939_ecu_put()
    __j1939_ecu_release()
      queue_work(j1939_ecu_wq, &ecu->release_work);

That would queue work on a workqueue that has already been destroyed.

The timer outliving the module was already a problem before this patch,
because j1939_ecu_timer_handler() is itself module text.

The later patch in this series, "can: j1939: fix "struct j1939_ecu"
refcount leak", appears to fix this. It makes j1939_ecu_unmap_all()
cancel every ac_timer and drop the timer references. It also gates
j1939_ecu_timer_start() and j1939_ecu_map_locked() with
j1939_ecu_verify_get(), which fails once priv->rx_kref is zero.

Would it make sense to reorder or combine the two patches, so that this
commit is safe by itself for bisection and backports?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/396b5de7-3fe0-474f-9194-b4816fde7182%40I-love.SAKURA.ne.jp
