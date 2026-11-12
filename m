Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794473456;
	b=YYX3mAiQUzcmED/vIURc2Ypw3aO3qH+VkQ6Ce3KwuTSxv5M4t64Vf77BUS1Kl73n6o6/
	 vssIZmeo/zMj/RXK/KTfbF+KqzUY/hElYXpk8nYh5UhMuwOBYbiZFpGj3BkrynzCD1lnt
	 gAuScs9+9f6leKetXREMYsme13TVws+C8FJn0Py8d9WorCwUK4rP3X0BDwptTwvfcTFyF
	 dtCJilUpW4Y66nzzlSV4FcUWkdQyC4rxHAzwo0dAPxYQqzjxFDKBEUYpIbm+oVzPC3cKX
	 TYJuvrwP9pSFea2AFhr9XhrwRlOOHsHitBQL35Ef8bQ34VOCJj/49KLaypVjqs5m7dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473456;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7CX91LtA04PMt4a9KO8kqyKdV7N0/UmraKQmcIVaGQM=;
	b=W6dK4z1jVX+0Yjf5KHxjx8B4D3/rANdBbToklZlxMKPj8tpl+mE/gDUsL2o8CVyX4X35
	 egYh/VAonWvj04zxdoz8b17MjCgWgKeNKZKuwDWpR5otVmrveFhDkYqYwlr5ccQRhIBWb
	 hqrFSwO6cEQQPyYRPa+mqNZtm/FvOtXWgnXQW/BXdj+XBZ/O0hLWqq8HiJ+Ah9Q4QRvGX
	 LUkGzXBG5E+qhzjttAAxZnOUJHKGqoG5exK9v0tjyn/hDTYwPFTYiN4HD/TH4bt2+xxjS
	 XnM/M16kYWig2TKrPsG72rBp+W++kKchSkNImLRl2yEylNObjDa7j0ZLE06ozUpwDGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ht8w3eoQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4870606A323
	for <linux-can@vger.kernel.org>; Thu, 12 Nov 2026 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ht8w3eoQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506061F00A05;
	Thu, 12 Nov 2026 08:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794473455;
	bh=7CX91LtA04PMt4a9KO8kqyKdV7N0/UmraKQmcIVaGQM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ht8w3eoQk0b3q36alEpoQN7MTSjWNPYGdXpYXxXab2Q8Muhgpd5zL/IHUD1tFSlee
	 VdKy4iPKKRFSol9rI4lbresINDhVZu0zhQ2jZYbeMiAEYhUXTpIbKdeawl0yXWoUwl
	 gxkIr/cuezU9Bc9tTiX/T60JX+sv80WxmLLRBbbwKIiCf9Ls7NvSDw1qfjwgREJ0DD
	 IS1R7iy587npCqFMyWCyFIaqkj5DnozzjCgzF4MuFoTlcOvd1h0/KVCU50Je/+9j6Z
	 5n+mmALtEzhBdxDMIfRTkTQV9dxWd4rqqlNY3J7feNzTiNaJOcpCG1fODaPvlhiSeS
	 F0SB8SPJW8xbQ==
Subject: Re: [PATCH v11 2/3] can: j1939: fix possibility of
 hard-lockup/deadlock in j1939_ecu_timer_cancel()
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Thu, 12 Nov 2026 08:50:54 +0000
Message-ID: <179447345481.488853.2498503016448521701@kernel.org>
In-Reply-To: <f516220f-b922-4172-bf35-ce34d5f21b39@I-love.SAKURA.ne.jp>
References: <f516220f-b922-4172-bf35-ce34d5f21b39@I-love.SAKURA.ne.jp>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] j1939_ac_process() (net/can/j1939/address-claim.c) now gives
  up on an Address Claimed frame whenever hrtimer_try_to_cancel()…
- [Low] On the new hrtimer_try_to_cancel() == -1 path, the in-code
  comment and Documentation/networking/j1939.rst no longer match the…

Pre-existing issues:
- [High] At the target commit, j1939_ecu_unmap_all()
  (net/can/j1939/bus.c) only walks priv->ents[] and calls…

--

can: j1939: fix possibility of hard-lockup/deadlock in j1939_ecu_timer_cancel()

The patch switches j1939_ecu_timer_cancel() from hrtimer_cancel() to
hrtimer_try_to_cancel(). This avoids waiting for a running ac_timer
callback while priv->lock is held for write. If the callback is running,
j1939_ecu_timer_cancel() now returns false and j1939_ac_process() ignores
the address claim frame.

> diff --git a/net/can/j1939/address-claim.c b/net/can/j1939/address-claim.c
> index ca4ad6cdd5cbf..89ba8c6fbe74d 100644
> --- a/net/can/j1939/address-claim.c
> +++ b/net/can/j1939/address-claim.c
> @@ -212,7 +212,8 @@ static void j1939_ac_process(struct j1939_priv *priv, struct sk_buff *skb)
>  		goto out_unlock_bh;
>  
>  	/* cancel pending (previous) address claim */
> -	j1939_ecu_timer_cancel(ecu);
> +	if (!j1939_ecu_timer_cancel(ecu))
> +		goto out_ecu_put;

[Severity: Medium]

If the previous ac_timer callback is running, this path skips several
steps: the idle/unmap handling, the ecu->addr update, the contention
check against prev, and j1939_ecu_timer_start(). Could the kernel then
end up committing the superseded claim instead of the new one?

Once j1939_ac_process() releases priv->lock, the running handler takes
it and maps the ECU at the old, unchanged ecu->addr:

net/can/j1939/bus.c:j1939_ecu_timer_handler() {
	write_lock_bh(&priv->lock);
	...
	j1939_ecu_map_locked(ecu);
	...
	write_unlock_bh(&priv->lock);
}

Say the new claim moved the ECU to a different SA, or was a Cannot-Claim
with SA 0xFE that should have unmapped it. That update seems to be lost.
The old NAME<->SA pairing would then stay in priv->ents[] until the NAME
sends another AC, and ACs are not periodic.

The frame is also not really dropped, as the commit message suggests,
because j1939_can_recv() still passes it on:

net/can/j1939/main.c:j1939_can_recv() {
	...
	j1939_ac_recv(priv, skb);

	if (j1939_tp_recv(priv, skb))
		goto done;

	j1939_simple_recv(priv, skb);
	j1939_sk_recv(priv, skb);
	...
}

So userspace sees the NAME at the new SA while the kernel keeps it at
the old SA. Would j1939_name_to_addr() then return the stale SA? If so,
j1939_ac_fixup() would fill in the wrong SA for sockets bound by NAME,
and the wrong DA for dst_name sends.

For local ECUs, j1939_ac_fixup() unmaps the ECU when the new claim is
transmitted, but the running handler would then map it back at the old
SA.

hrtimer_try_to_cancel() also returns -1 for as long as
hrtimer_callback_running() is true, not only while the handler is
spinning on priv->lock. That includes the window after the handler's
write_unlock_bh() but before __run_hrtimer() clears base->running. On
PREEMPT_RT this window can be wider, because the softirq thread can be
preempted.

In that window the old hrtimer_cancel() would have waited briefly
without deadlocking, then processed the claim correctly. Are claims that
used to be handled correctly now lost too?

The commit message says it is impossible to drop priv->lock, and
"Therefore" the frame is dropped. Is ignoring the claim the only option
that keeps the lock held?

One alternative: on -1, carry on with the update and re-arm the timer.
Calling hrtimer_start() on a timer whose callback is running is allowed.
j1939_ecu_timer_handler() could then skip the mapping if
hrtimer_is_queued() is true, or if a per-ECU generation counter has
changed.

This code is still the same at the end of the series.

[Severity: Low]

This isn't a bug, but the comment above the call still says "cancel
pending (previous) address claim". On the new false path, the previous
claim is not cancelled, because its running handler maps the ECU at the
old SA. The new claim is the one that gets discarded. Could a comment
here say what happens to the frame in that case?

j1939_ecu_timer_cancel() says "Let the caller decide how to handle this
situation". However, j1939_ac_process(), the only caller, does not
document what it chose.

Documentation/networking/j1939.rst says that after binding with a new
SA and sending a valid address claim:

  This restarts the state machine in the kernel (and any other
  participant on the bus) for this NAME.

It also says the NAME-SA pair becomes valid if nobody contests it within
250ms. When this race hits, the state does not change and no 250ms timer
is started for the new claim. Should the documentation be updated to
match?

>  
>  	if (j1939_address_is_idle(skcb->addr.sa)) {
>  		j1939_ecu_unmap_locked(ecu);
> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index c49c96dea7960..c6278d7cb1b1f 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -151,11 +151,19 @@ void j1939_ecu_timer_start(struct j1939_ecu *ecu)
>  		      HRTIMER_MODE_REL_SOFT);
>  }
>  
> -void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
> +bool j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
>  {
> -	if (hrtimer_cancel(&ecu->ac_timer))
> +	switch (hrtimer_try_to_cancel(&ecu->ac_timer)) {
> +	case 0:	/* Not active or already finished. */
> +		return true;
> +	case 1:	/* Successfully canceled. */
>  		/* Drop the ref from j1939_ecu_timer_start(). */
>  		j1939_ecu_put(ecu);
> +		return true;
> +	default: /* Currently executing. */
> +		/* Let the caller decide how to handle this situation. */
> +		return false;
> +	}
>  }

[Severity: High]

This is a pre-existing issue and was not introduced by this patch. At
this commit, j1939_ecu_unmap_all() does not cancel any pending
ecu->ac_timer:

net/can/j1939/bus.c:j1939_ecu_unmap_all() {
	write_lock_bh(&priv->lock);
	for (i = 0; i < ARRAY_SIZE(priv->ents); i++)
		if (priv->ents[i].ecu)
			j1939_ecu_unmap_locked(priv->ents[i].ecu);
	write_unlock_bh(&priv->lock);
}

Suppose an AC frame arms ac_timer just before the last socket closes:

j1939_sk_release()
  j1939_netdev_stop()
    __j1939_rx_release()
      j1939_can_rx_unregister(priv);
      j1939_ecu_unmap_all(priv);
      j1939_priv_set(priv->ndev, NULL);

The timer can still fire up to 250ms later. Can j1939_ecu_timer_handler()
then map the ECU back into the detached priv, taking an ECU reference
that is never dropped? That would leak the ECU, the priv and the netdev
tracker reference, and unregister_netdevice could wait forever.

Can the handler also run after j1939_module_exit() has destroyed
j1939_ecu_wq and the module has been unloaded?

The hrtimer_cancel() in __j1939_ecu_release_work() can't help here,
because the armed timer itself holds an ECU reference.

The later patch in this series, "can: j1939: fix "struct j1939_ecu"
refcount leak", appears to fix this. With it, j1939_ecu_unmap_all()
walks priv->ecus and tries to cancel each timer under priv->lock. If
that fails, it drops priv->lock, holds a temporary reference, and calls
hrtimer_cancel().

j1939_ecu_timer_start() and j1939_ecu_map_locked() also switch to
j1939_ecu_verify_get(). It refuses once rx_kref is 0 or the netdev is
unregistered.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/a1dd9760-7815-400a-a39c-a1a03cf8262e%40I-love.SAKURA.ne.jp
