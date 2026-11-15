Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794721878;
	b=yKe64yoASglTGyxex7wGXEFtJw7rqK3mPEhaEf1hb13exTwdWgHZlaYS2I/086y4xxK1
	 SiaHT0WFpJ0pFeDRTkgKEAso2U/MJ2Du9o67qsaOt9eTt44o6IS7yBudfAvFA1ondDETj
	 g6Up8JI34KW9I0XAwiATwdoc02oTa+YNw+o6hUs4aJVWpdhon/+AKR0UPAJBUXDyUCEnY
	 +yseeh0kKCEu8vDUn0VFxT1xkxhmHeC3HmPilifGMryjy5m3Baged+bb0MgF7x6jLI699
	 TT6t4hED6EnVHGnWywoyE1wQ0psfI/BuFDee6mxl9dm/nprJ8AYbxsGDfegdWU4bEIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794721878;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0G8EYbuYJE8B89Q4BtgiRuY1F1Q71jACf8vbcvfLGCw=;
	b=ykix3/3KQCnAHgOIXiZG3Cvc2Ra+MjvERYfWKT2rea1PpchyOWvvu03u8plBzeK3aTx/
	 oijhfZ9skwg72417UaqJX+cVoqx5KTPc1UqNePlcDX/Y8+9ZfNaYiocm7RLSR6EZ0brYD
	 0VwdhFnfJ2drcMevEXGvAhE0sXBO01q28+sEntkyCHRiiVmYhR5O7BbOBJnGp7rufxncP
	 EZ3c0VekUikTr1xTw61z3XfgAfxnodP8GhB3UiBKvqkeWvpQ0B+3qF2b9jUxxoHoeaPJS
	 Quk7SGI3w4pNXJ2dCRSvewjOhK2Gl/BbwTlKD74zETSHvt76UUZJNFTU5rxvn+bZLkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WkWz5kZP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7DF606A329
	for <linux-can@vger.kernel.org>; Sun, 15 Nov 2026 05:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WkWz5kZP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EDA1F000C4;
	Sun, 15 Nov 2026 05:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794721877;
	bh=0G8EYbuYJE8B89Q4BtgiRuY1F1Q71jACf8vbcvfLGCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WkWz5kZP7/FE8xEU/ckHfWK/4VU1SwxerFOM3Vl3/5HrTu5JPwU3RjJFN+jySfI9u
	 ykFOzhxpAg4Xj+jdQcD2EHbwZZk9wpoV7i80Nd6lWdd37h9A3MutQzoZhbPPR76GdU
	 /D8pESXnIt9iBHUAhOzsEVUJSrYXezMVzmBt3hYGhc5gKgvx3/Ph+FwN0XhEsGY5tm
	 0Tn90Bio74kl7IHhU0pJWiGSa8ppR1xg3WNJmhAT4ia0yi34v7h+DTgLjuPx28vbL1
	 i4nbbX+eGTuKv9nY9EAMUop79H18/aLkQ+j4uyGO/EmC+wJ/NhuxF9fQFoukAMTqsj
	 G7K2lroArPcFQ==
Message-ID: <sashiko-outbox-215235@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 6/6] can: j1939: fix possibility of
 hard-lockup/deadlock in j1939_ecu_timer_cancel()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <dc9d8b6a-5e6c-4392-9b6a-f5f546bfe872@I-love.SAKURA.ne.jp>
References: <7cc08b0f-290e-464b-ab13-0a5ce3c57f4f@I-love.SAKURA.ne.jp>
 <dc9d8b6a-5e6c-4392-9b6a-f5f546bfe872@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 05:51:17 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] can: j1939: j1939_ac_process() drops new claim and leaves
  stale addr on cancel
- [Medium] can: j1939: j1939_ecu_timer_start() races with finishing
  __run_hrtimer()
--

commit d92351ad8ae3e165027e4084ec974a0caa02eabc
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

can: j1939: fix possibility of hard-lockup/deadlock in j1939_ecu_timer_canc=
el()

This commit replaces hrtimer_cancel() in j1939_ecu_timer_cancel() with
hrtimer_try_to_cancel() and two boolean flags to avoid waiting for the
timer callback while holding priv->lock.

> diff --git a/net/can/j1939/address-claim.c b/net/can/j1939/address-claim.c
> index ca4ad6cdd5cbf..eb5916ac97bb4 100644
> --- a/net/can/j1939/address-claim.c
> +++ b/net/can/j1939/address-claim.c
> @@ -211,8 +211,11 @@ static void j1939_ac_process(struct j1939_priv *priv=
, struct sk_buff *skb)
>  	if (IS_ERR_OR_NULL(ecu))
>  		goto out_unlock_bh;
> =20
> -	/* cancel pending (previous) address claim */
> -	j1939_ecu_timer_cancel(ecu);
> +	/* Cancel pending (previous) address claim. If we can't cancel,
> +	 * do nothing until pending (previous) address claim commits or aborts.
> +	 */
> +	if (!j1939_ecu_timer_cancel(ecu))
> +		goto out_ecu_put;

[Severity: Medium]
Does returning early here while setting ecu->abort_ac_handler =3D true drop
both the expiring address claim and the newly received replacement claim?

CPU0                              CPU1
j1939_ecu_timer_handler()
  /* waiting on priv->lock */
                                  j1939_ac_process() /* new claim for SA2 */
                                    write_lock_bh(&priv->lock)
                                    j1939_ecu_timer_cancel(ecu)
                                      hrtimer_try_to_cancel() -> -1
                                      ecu->abort_ac_handler =3D true
                                      return false
                                    goto out_ecu_put  <-- drops SA2 claim
                                    write_unlock_bh(&priv->lock)
  write_lock_bh(&priv->lock)
  if (ecu->abort_ac_handler)
    goto out                      <-- aborts SA1 claim without mapping
  j1939_ecu_put(ecu)

Because SAE J1939 address claim messages are one-shot announcements,
neither SA1 nor SA2 is claimed.  For a remote ECU (ecu->nusers =3D=3D 0),
j1939_ecu_put() in the timer handler drops the last reference and frees
the struct j1939_ecu.  For a surviving ECU (such as a local ECU with
ecu->nusers > 0), ecu remains unmapped with no running timer while
ecu->addr still holds SA1, so any later claim for SA1 hits the early check
in j1939_ac_process() and is ignored:

net/can/j1939/address-claim.c:j1939_ac_process() {
	...
	if (ecu && ecu->addr =3D=3D skcb->addr.sa) {
		...
		goto out_ecu_put;
	}
	...
}

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index 9b40f37546233..6520c91a6e1ec 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -156,15 +156,35 @@ void j1939_ecu_timer_start(struct j1939_ecu *ecu)
>  		return;
> =20
>  	/* Schedule timer in 250 msec to commit address change. */
> +	ecu->abort_ac_handler =3D false;
> +	ecu->done_ac_handler =3D false;
>  	hrtimer_start(&ecu->ac_timer, ms_to_ktime(250),
>  		      HRTIMER_MODE_REL_SOFT);
>  }
> =20
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
> +		ecu->abort_ac_handler =3D true;
> +		/* Don't call j1939_ecu_timer_start() until
> +		 * j1939_ecu_timer_handler() commits or aborts.
> +		 */
> +		return false;
> +	}
> +	return true;
>  }
> =20
>  static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrti=
mer)
> @@ -174,14 +194,28 @@ static enum hrtimer_restart j1939_ecu_timer_handler=
(struct hrtimer *hrtimer)
>  	struct j1939_priv *priv =3D ecu->priv;
> =20
>  	write_lock_bh(&priv->lock);
> +
> +	/* Abort if j1939_ecu_timer_cancel() told me to abort. */
> +	if (ecu->abort_ac_handler) {
> +		ecu->abort_ac_handler =3D false;
> +		goto out;
> +	}
> +
>  	/* TODO: can we test if ecu->addr is unicast before starting
>  	 * the timer?
>  	 */
>  	j1939_ecu_map_locked(ecu);
> =20
> +out:
> +	/* Tell j1939_ecu_timer_cancel() that this handler has finished
> +	 * its critical section (either committed or aborted), so no need
> +	 * to set abort_ac_handler again while __run_hrtimer() is finishing.
> +	 */
> +	ecu->done_ac_handler =3D true;
> +	write_unlock_bh(&priv->lock);
> +
>  	/* Drop the ref from j1939_ecu_timer_start(). */
>  	j1939_ecu_put(ecu);
> -	write_unlock_bh(&priv->lock);
> =20
>  	return HRTIMER_NORESTART;
>  }

[Severity: Medium]
Can allowing j1939_ecu_timer_start() while __run_hrtimer() is still
finishing cause a subsequent j1939_ecu_timer_cancel() to fail to cancel
the newly started timer and Poison it with ecu->abort_ac_handler =3D true?

__run_hrtimer() keeps base->running set to &ecu->ac_timer until after
j1939_ecu_timer_handler() returns and cpu_base->lock is re-acquired.  If
two address claim frames arrive after write_unlock_bh(&priv->lock) but
before __run_hrtimer() clears base->running:

CPU0                              CPU1
__run_hrtimer()
  j1939_ecu_timer_handler()
    ecu->done_ac_handler =3D true
    write_unlock_bh(&priv->lock)
                                  j1939_ac_process() /* frame 1 */
                                    j1939_ecu_timer_cancel(ecu)
                                      hrtimer_try_to_cancel() -> -1
                                      /* done_ac_handler is true */
                                      return true
                                    j1939_ecu_timer_start(ecu)
                                      ecu->done_ac_handler =3D false
                                      hrtimer_start(&ecu->ac_timer, ...)
                                  j1939_ac_process() /* frame 2 */
                                    j1939_ecu_timer_cancel(ecu)
                                      hrtimer_try_to_cancel() -> -1
                                      /* done_ac_handler is now false */
                                      ecu->abort_ac_handler =3D true
                                      return false  <-- drops frame 2
    j1939_ecu_put(ecu)
  base->running =3D NULL

Because hrtimer_callback_running(&ecu->ac_timer) is still true on CPU0,
hrtimer_try_to_cancel() on frame 2 returns -1 without dequeuing frame 1's
newly started timer.  With ecu->done_ac_handler cleared by frame 1,
j1939_ecu_timer_cancel() sets ecu->abort_ac_handler =3D true and drops frame
2, while frame 1's timer remains queued for 250 ms only to abort when it
fires.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/7cc08b0f-290e-464b-=
ab13-0a5ce3c57f4f@I-love.SAKURA.ne.jp?part=3D6
