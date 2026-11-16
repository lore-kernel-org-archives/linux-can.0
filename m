Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855071;
	b=CaGV7cU8WwGuM4gIh8JRXq6oPE1i+sm3UZjV8y6m2E1KLIrs5cM5+fkxPR59HMLAobjh
	 MIR9dNW+/8QExDZ1hQQbuiHqYcPGudZZaf9ydphhYzTx/rjSVQ8ELgYpEZDFZzlZBQDG7
	 nBT4EDA72cZWGFPvAG/FfZRpOopdmfGaKF8kXxPl/4JGKN8TEItwGPgDt84wpMDzDjtUf
	 EhGhr7fNAO+1e3khCV10da5VQQRHWlylD/0uUEiJJ3bweHAC90h6VunymoM8q+NP2PZD8
	 UnrfiEVKlT1we3hu2ICNnsTsm2QTYqnI4v7lUVw/ZSKhwl7wm71mUtuTxBIiIUA4utw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855071;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mzv8k2VLegcaUxa+/t3QZvymhTuhbTXjuBrxGZBoVt8=;
	b=P2KCjG7C6iCArycrA1fsMxosmD/uLWNKXDueOjYPyJdZEg0mZZoob/8JkiQ9ngLCj6zr
	 6uZloiVVygioZiLkmiZClKYbRHANorBvlPFe4FaQZJ97kbWGAWbqUbxtX4PIBN8k+8v8x
	 L/9/9M1AyH8KRtPV2xwg15kyMzIKB3sHNCBdj4/Gy/6aI7Zc7QongA4RTF4DEmpSQN9g9
	 ZhAD97wx2YOygxKAPSi5I7n4qEO0cRkoB9c6GYLjEWVVYnkWJz7G6WEvZNC/u8XhaxlIb
	 XwrF6nhiu4zrPVfPYM5pIxlpIeibbCbNMWxVAjIPESluQYbbmG6pKW0egqi8JLW11kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0YCbpFk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E8F606A31C
	for <linux-can@vger.kernel.org>; Mon, 16 Nov 2026 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0YCbpFk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D6C1F000C4;
	Mon, 16 Nov 2026 18:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855071;
	bh=mzv8k2VLegcaUxa+/t3QZvymhTuhbTXjuBrxGZBoVt8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E0YCbpFkOrU5jy32EUKuF20GVwgN7avO824Mu6/tc15NzcXXdyY0zivFzdFAUhgi9
	 X7/fZAlFI4GXBEKR1FiKwBmCepnxldNp+YpezLRoguBD6RyV8uwu1blmsNFp3/Aca6
	 BP84/RugEIdFuTQNToMmYajo0iLccpC+BhgvLbnWSsQPVUWxQdVxdXeGTx3cfYWT8Q
	 91JRE3oSZ0TXNK2MdtCsr3a1+lfObXRrnWmb9w+ZSSAxm6y+saHhM9qScOyVRwxrmK
	 XM8eqapt/9mdADbuTOgTJgjgywcBRnJAgITrMxaOavFg+UqJtnHK1krxUOxCTxou4F
	 ohM/Y18R3rjqA==
Subject: Re: [PATCH v13 6/6] can: j1939: fix possibility of
 hard-lockup/deadlock in j1939_ecu_timer_cancel()
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Mon, 16 Nov 2026 18:51:10 +0000
Message-ID: <179485507057.3132.5060269371508010060@kernel.org>
In-Reply-To: <dc9d8b6a-5e6c-4392-9b6a-f5f546bfe872@I-love.SAKURA.ne.jp>
References: <dc9d8b6a-5e6c-4392-9b6a-f5f546bfe872@I-love.SAKURA.ne.jp>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When the cancel is only logical, both the pending address
  claim and the new one are thrown away, and the ECU's address state is…
- [Medium] The new logical-cancel scheme can abort a freshly armed timer
  instead of the old callback it was aimed at.

--

can: j1939: fix possibility of hard-lockup/deadlock in j1939_ecu_timer_cancel()

j1939_ecu_timer_cancel() used to call hrtimer_cancel() with priv->lock held
for write, while the timer handler takes the same lock. The patch switches
to hrtimer_try_to_cancel() and adds two bool flags to cancel logically when
the handler is already running. In that case, j1939_ac_process() drops the
address claim frame.

> diff --git a/net/can/j1939/address-claim.c b/net/can/j1939/address-claim.c
> index ca4ad6cdd5cbf..eb5916ac97bb4 100644
> --- a/net/can/j1939/address-claim.c
> +++ b/net/can/j1939/address-claim.c
> @@ -211,8 +211,11 @@ static void j1939_ac_process(struct j1939_priv *priv, struct sk_buff *skb)
>  	if (IS_ERR_OR_NULL(ecu))
>  		goto out_unlock_bh;
>  
> -	/* cancel pending (previous) address claim */
> -	j1939_ecu_timer_cancel(ecu);
> +	/* Cancel pending (previous) address claim. If we can't cancel,
> +	 * do nothing until pending (previous) address claim commits or aborts.
> +	 */
> +	if (!j1939_ecu_timer_cancel(ecu))
> +		goto out_ecu_put;

[Severity: Medium]
Does this lose both the pending claim and the new one?

Take the -1 case this patch is meant to handle. The soft hrtimer callback
for a claim of address A is blocked in write_lock_bh(&priv->lock).
Meanwhile j1939_ac_process() holds the lock and is handling a new AC frame
from the same NAME with SA B:

j1939_ac_process()
  j1939_ecu_timer_cancel()
    hrtimer_try_to_cancel() returns -1, done_ac_handler is false
    ecu->abort_ac_handler = true;
    return false;
  goto out_ecu_put;

The jump skips the unmap and the ecu->addr = skcb->addr.sa update. It
also skips the comparison with the current owner of B, the kick of that
owner, and j1939_ecu_timer_start().

The handler then gets the lock and takes the abort path:

j1939_ecu_timer_handler()
	if (ecu->abort_ac_handler) {
		ecu->abort_ac_handler = false;
		goto out;
	}

so j1939_ecu_map_locked() is never called.

After that, the ECU is not mapped at any address and no timer is armed.
priv->ents[B] still points at the previous owner, even if that owner lost
on NAME priority. ecu->addr is still A.

Since ecu->addr is still A, a later AC from this NAME with sa == A takes
the early exit in j1939_ac_process():

	if (ecu && ecu->addr == skcb->addr.sa) {
		...
		goto out_ecu_put;
	}

so the ECU stays unmapped until it claims some address other than A.

Without the race, either A would commit and B would then move the ECU,
or A would be cancelled and B processed. Here neither happens.

The comment says "do nothing until pending (previous) address claim
commits or aborts". But the same call forces the previous claim to
abort, and nothing retries the dropped frame. Is this the intended
behavior?

[ ... ]

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index 9b40f37546233..6520c91a6e1ec 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -156,15 +156,35 @@ void j1939_ecu_timer_start(struct j1939_ecu *ecu)
>  		return;
>  
>  	/* Schedule timer in 250 msec to commit address change. */
> +	ecu->abort_ac_handler = false;
> +	ecu->done_ac_handler = false;
>  	hrtimer_start(&ecu->ac_timer, ms_to_ktime(250),
>  		      HRTIMER_MODE_REL_SOFT);
>  }
>  
> -void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
> +bool j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
>  {
> -	if (hrtimer_cancel(&ecu->ac_timer))
> +	switch (hrtimer_try_to_cancel(&ecu->ac_timer)) {
> +	case 0:	/* Not active or already finished. */
> +		break;
> +	case 1:	/* Successfully canceled. */
>  		/* Drop the ref from j1939_ecu_timer_start(). */
>  		j1939_ecu_put(ecu);
> +		break;
> +	default: /* Currently executing. */
> +		/* OK to call j1939_ecu_timer_start() again if
> +		 * j1939_ecu_timer_handler() already committed or aborted.
> +		 */
> +		if (ecu->done_ac_handler)
> +			break;
> +		/* Tell j1939_ecu_timer_handler() to abort. */
> +		ecu->abort_ac_handler = true;
> +		/* Don't call j1939_ecu_timer_start() until
> +		 * j1939_ecu_timer_handler() commits or aborts.
> +		 */
> +		return false;
> +	}
> +	return true;
>  }

[Severity: Medium]
Can this abort a newly armed timer instead of the old callback?

hrtimer_try_to_cancel() returns -1 whenever the callback is running, even
if the timer has been enqueued again since then:

kernel/time/hrtimer.c:hrtimer_try_to_cancel() {
    ...
	if (!hrtimer_callback_running(timer)) {
		ret = remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE);
    ...
}

hrtimer_start() can re-enqueue the timer while its callback is still
running, because switch_hrtimer_base() keeps the same base in that case:

	if (unlikely(hrtimer_callback_running(timer)))
		return base;

The handler releases priv->lock before __run_hrtimer() clears
base->running:

	ecu->done_ac_handler = true;
	write_unlock_bh(&priv->lock);

	/* Drop the ref from j1939_ecu_timer_start(). */
	j1939_ecu_put(ecu);

Consider this sequence:

CPU0 (arming T1)
j1939_ecu_timer_handler()
  ecu->done_ac_handler = true;
  write_unlock_bh(&priv->lock);
  /* __run_hrtimer() has not cleared base->running yet */

CPU1, AC frame A' (sa != ecu->addr)
j1939_ac_process()
  j1939_ecu_timer_cancel()
    hrtimer_try_to_cancel() returns -1, done_ac_handler is true
    return true;
  j1939_ecu_timer_start()
    abort_ac_handler = false, done_ac_handler = false
    hrtimer_start()  /* T2 enqueued */

CPU1, AC frame B for the same NAME, still before base->running is cleared
j1939_ac_process()
  j1939_ecu_timer_cancel()
    hrtimer_try_to_cancel() returns -1, done_ac_handler is false
    ecu->abort_ac_handler = true;
    return false;
  goto out_ecu_put;  /* B dropped */

250ms later T2 fires, sees abort_ac_handler and skips
j1939_ecu_map_locked().

Both A' and B are lost, even though no handler for A' was running when B
arrived. If B had arrived a little later, hrtimer_try_to_cancel() would
have returned 1 and B would have been processed normally.

The two bools cannot tell an old callback that is still unwinding in
__run_hrtimer() apart from a handler for the current arming. Would the
abort/done state need to be tied to each arming, for example with a
generation counter?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/7cc08b0f-290e-464b-ab13-0a5ce3c57f4f%40I-love.SAKURA.ne.jp
