Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591052;
	b=3NCPZ//MY8TXXsowOzubFgv0zhG0bkAfh+Yp0Rx+islvc933cyWvmmhJU2rBj4ziBP8Q
	 OqAi72FL8oksQZWt/FdvwxhAxN1GumsTlXqjrJdK/0ZfzDoiRYbDsU66P6Q7NoV8Noypb
	 DlHSma72LwNXBkh+FoJKPOTFgmqQGPisyd4LJ2m0rOO3cWQlMg9Mzz3YBuBwB2hHzcBRd
	 j4QOLp5IhBESaIjA5BIlZ3gv8c28Uvo2lwhE+Rb4F6TLs1KYf5jUfK0R4s6OvjlDiqdCa
	 vhlxXSw4qvSWyCfaSzF+x4HXD7ag2W3fbSXY5jZtr5q5yL5Yohu+KoeiSrQWxGpKXQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591052;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sJFg7q2Wd+Xwp2tgQ2DYlLZv88TnXYzRR4nBdNTduME=;
	b=umI8Ot55dbA6X/fgZDvMSKJcOdyryY01CFElkKpse5JhWIwTbTeKWyJYx8ttu3U7c3lT
	 vG2WCTL9crNUSaKz5M6sprx7nJXD+FFBpEiCjYqkXh6Bc14OGLCuNCONJKnVaanPIlLuH
	 Eac5LpDKI6MWFlOTpqGANnup5OdEbVNS1l2eZKitPnkw0o0iMM2Dr4XAxIKN8fLfbZ/G3
	 a/CtaAHKxqVUHgHMUUYvr5kLssqNXKxm4Fl+TgKSI5L/yXSiO3M6ynqESQUY/m5GJd1Kv
	 v4tGwFJ6TVuAGes3Xob5dHmQ/wC+MRN8e7Ni42T9Ftan3OIjQgZuyLx4QJVuqMZvo+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owoOeviV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A2B606B351
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owoOeviV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902951F000C5;
	Fri, 13 Nov 2026 17:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591051;
	bh=sJFg7q2Wd+Xwp2tgQ2DYlLZv88TnXYzRR4nBdNTduME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=owoOeviVKGNQo1bY/TczfDQ+QBV6TyBmBIyQNWaS/GuwLy2n59MHIheh/FAv4iPQp
	 J0GJxb31vUG1a0QPuGAJULyehRrShhU4yofACR0QoAOshFGvalpGKGWvs357taT9Hp
	 eMeJmsRlPfHdOVwJ1Qrw0s65UA/SZ/Zwxp4ex7XxbRBfAx0xoN1TRxRD3v1SvQqKhu
	 3/eFyE+QWnibmce/ncgbNkRdNGfnn32SMeOhx75pEwKPRpKFK52DBx994iTrXPN3pJ
	 k4KctzFl321Vwj5NTq4pGsEnV5lc1OE8IgzdPpTej8WbcAEOYbmayq29yi2eGmmP8i
	 oaGqw+OcH9e9w==
Message-ID: <sashiko-outbox-213314@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 2/3] can: j1939: fix possibility of
 hard-lockup/deadlock in j1939_ecu_timer_cancel()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <ba3e6880-6dff-4fa6-a2e4-629c3d35b8d5@I-love.SAKURA.ne.jp>
References: <8de287d7-b4e1-4062-b40e-b193f5ec68ca@I-love.SAKURA.ne.jp>
 <ba3e6880-6dff-4fa6-a2e4-629c3d35b8d5@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:30:51 +0000
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
- [High] can: j1939: ecu ref leak and uncanceled timer in
  j1939_ecu_timer_cancel()
- [Medium] can: j1939: stale ac_want_abort on abort path in
  j1939_ecu_timer_handler()
--

commit fa21532ae1ca00bb699863f7fb0ec168d518ddc4
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

can: j1939: fix possibility of hard-lockup/deadlock in j1939_ecu_timer_canc=
el()

This commit replaces hrtimer_cancel() in j1939_ecu_timer_cancel() with
hrtimer_try_to_cancel() and two boolean flags on struct j1939_ecu to
avoid waiting for j1939_ecu_timer_handler() while holding priv->lock.

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index c49c96dea7960..8cbf8716d286e 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -147,15 +147,25 @@ void j1939_ecu_timer_start(struct j1939_ecu *ecu)
>  		return;
> =20
>  	/* Schedule timer in 250 msec to commit address change. */
> +	ecu->ac_commit_done =3D false;
>  	hrtimer_start(&ecu->ac_timer, ms_to_ktime(250),
>  		      HRTIMER_MODE_REL_SOFT);
>  }
> =20
>  void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
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
> +		/* Tell j1939_ecu_timer_handler() to abort unless committed. */
> +		if (!ecu->ac_commit_done)
> +			ecu->ac_want_abort =3D true;
> +	}
>  }

[Severity: High]
Can j1939_ecu_timer_cancel() fail to dequeue ecu->ac_timer and leak an
ecu->kref reference when two address-claim frames arrive while a previous
j1939_ecu_timer_handler() callback is still running?

In __run_hrtimer(), base->running remains set to &ecu->ac_timer from
before j1939_ecu_timer_handler() enters write_lock_bh(&priv->lock) until
after it releases priv->lock and returns.  Whenever
hrtimer_callback_running(&ecu->ac_timer) is true, hrtimer_try_to_cancel()
returns -1 without calling remove_hrtimer(), even if ecu->ac_timer was
re-enqueued in the meantime:

CPU0                              CPU1
__run_hrtimer()
  base->running =3D &ecu->ac_timer
  j1939_ecu_timer_handler()
                                  j1939_ac_process() [frame 1, SA1]
                                    write_lock_bh(&priv->lock)
                                    j1939_ecu_timer_cancel(ecu)
                                      hrtimer_try_to_cancel() -> -1
                                    j1939_ecu_timer_start(ecu)
                                      j1939_ecu_get(ecu)
                                      hrtimer_start(&ecu->ac_timer, ...)
                                    write_unlock_bh(&priv->lock)

                                  j1939_ac_process() [frame 2, SA2]
                                    write_lock_bh(&priv->lock)
                                    j1939_ecu_timer_cancel(ecu)
                                      hrtimer_try_to_cancel() -> -1
                                        <-- stays queued, no put
                                    j1939_ecu_timer_start(ecu)
                                      j1939_ecu_get(ecu)
                                      hrtimer_start(&ecu->ac_timer, ...)
                                    write_unlock_bh(&priv->lock)

Frame 2's j1939_ecu_timer_start() overwrites the already-queued timer in
place while taking another reference, so only one future callback runs and
frame 1's ecu->kref reference is leaked (along with j1939_priv and the
netdev reference on priv->ndev).

If frame 2 instead carries J1939_IDLE_ADDR or loses address contention and
does not call j1939_ecu_timer_start(), frame 1's timer is never dequeued;
once CPU0 acquires priv->lock and clears ecu->ac_want_abort, frame 1's
timer fires 250 ms later and maps the canceled address.  Conversely, if
CPU0 had already passed write_unlock_bh(&priv->lock) when frames 1 and 2
ran, j1939_ecu_timer_start() does not clear ecu->ac_want_abort, so frame
2's newly started timer aborts when it expires.

> @@ -165,14 +175,25 @@ static enum hrtimer_restart j1939_ecu_timer_handler=
(struct hrtimer *hrtimer)
>  	struct j1939_priv *priv =3D ecu->priv;
> =20
>  	write_lock_bh(&priv->lock);
> +
> +	/* Abort if j1939_ecu_timer_cancel() told me to abort. */
> +	if (ecu->ac_want_abort) {
> +		ecu->ac_want_abort =3D false;
> +		goto out;
> +	}
> +
>  	/* TODO: can we test if ecu->addr is unicast before starting
>  	 * the timer?
>  	 */
>  	j1939_ecu_map_locked(ecu);
> =20
> +	/* Commit and tell j1939_ecu_timer_cancel() not to ask me to abort. */
> +	ecu->ac_commit_done =3D true;
> +out:
> +	write_unlock_bh(&priv->lock);
> +
>  	/* Drop the ref from j1939_ecu_timer_start(). */
>  	j1939_ecu_put(ecu);
> -	write_unlock_bh(&priv->lock);
> =20
>  	return HRTIMER_NORESTART;
>  }

[Severity: Medium]
Does jumping to out leave ecu->ac_commit_done false after an aborting
handler drops priv->lock, causing the next timer to abort as well?

CPU0                              CPU1
j1939_ecu_timer_handler()
  write_lock_bh(&priv->lock)
  if (ecu->ac_want_abort) {
    ecu->ac_want_abort =3D false;
    goto out;
  }
  write_unlock_bh(&priv->lock)
                                  j1939_ac_process()
                                    write_lock_bh(&priv->lock)
                                    j1939_ecu_timer_cancel(ecu)
                                      hrtimer_try_to_cancel() -> -1
                                      if (!ecu->ac_commit_done)
                                        ecu->ac_want_abort =3D true;
                                    j1939_ecu_timer_start(ecu)
                                      ecu->ac_commit_done =3D false;
                                      hrtimer_start(&ecu->ac_timer, ...)
                                        <-- ac_want_abort stays true
                                    write_unlock_bh(&priv->lock)
  j1939_ecu_put(ecu)
__run_hrtimer()
  base->running =3D NULL

When an earlier j1939_ecu_timer_cancel() aborts the running handler (for
example on J1939_IDLE_ADDR without restarting the timer), the handler
unlocks priv->lock with ecu->ac_commit_done still false.  If a new unicast
address claim arrives before __run_hrtimer() clears base->running,
j1939_ecu_timer_cancel() sees hrtimer_try_to_cancel() =3D=3D -1 and
!ecu->ac_commit_done, setting ecu->ac_want_abort =3D true.  Because the
old handler has already passed write_unlock_bh(&priv->lock) and
j1939_ecu_timer_start() does not clear ecu->ac_want_abort, the new 250 ms
timer will see ecu->ac_want_abort =3D=3D true and abort without mapping the
ECU.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/8de287d7-b4e1-4062-=
b40e-b193f5ec68ca@I-love.SAKURA.ne.jp?part=3D2
