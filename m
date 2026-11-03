Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793684901;
	b=r7vDBrwnlVTvucUSfwFP5CWixsm0Bye/L39RWxRkSuAqhvRI3sof4ZhtkH4KTD4y/sFa
	 AHcVUW2ED7o8vPSeghYClTTJQDnUATfjpU/U9/ZxZLXfRXVZx4GKyrFE7Kb4TNgRLOcQq
	 gdwSfrXQr5ma//5SbzDeBti5a0mv+ddRQdToFhVGPNz0k+gTs8UcUD6FvGeIsbrKZZjYD
	 6Hop9AZlHiDjpyfD//0FcsupSNMqYde34iCNV/ufo5fs7CEiYLzVIfdWI0IqkpyZOxdUr
	 wdiDrrBjMmNs/y4nbfpfA6Bdq60EF0WZLxo+5Zlg7PSucIX9QZkt66TuW9n6fN6FmtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793684901;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CQ647n9XEy2T9VvTvQKIk4/6oh0KPmVBOY8AA0sdZeQ=;
	b=LCYGKEzIk4xSwMI/yyMtq9NcBeWqdE3P767rP3VlPfWc9Nwmi60Wc2PIacqxdEVR5OA3
	 81jEvF1NJEc0wyx3CEznLKJzeX4+rzlZ4gScuQ4bmOkNIHQI6dgvjnYmUEQg6BV7xm8iw
	 YgtwZOcsc2+U4kYtv7Z++vuUUmypkDQml7AGrmklnHgjKFunuiZSyaLNJ6i9TFySKnj0Q
	 +fccB7j+nvTOi9L6Bf68s7l6vSMg7ZwoKS4kj5GLsIV4TAUW4wAtnM/Tbs/EEL8U+On9t
	 Jv6J++L4P+KB5N5BnFOgNrN9sTcuzpryzwfubQG4mW0gcGLIbqH1+dXUa8wxjG7exGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lxt+c5sr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA46606A324
	for <linux-can@vger.kernel.org>; Tue,  3 Nov 2026 05:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lxt+c5sr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9F21F000C1;
	Tue,  3 Nov 2026 05:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793684901;
	bh=CQ647n9XEy2T9VvTvQKIk4/6oh0KPmVBOY8AA0sdZeQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lxt+c5sr0mygJ68aSawCM66w4UrIbwFKPT3LS4h9ln6/tobcNwK19dzrS3e36emij
	 o5Hg+ZA1Okm6RXZfmpJ5v7FyDtcH4QBxfx7rleSioBniu7oFBgrdcsD1G18KlX06bx
	 2T1gNNH3hxfTJ+ZZSGTgbf6cxBSsgK7vwE5EwpkI/1Emr+LyiHPfmZeYS8TIz6gCHS
	 FpOq5Zob+CGyhkcafqDEbNF+tLHtasuyqvZWphqe3WTB9s+toIgEhb2bfhJQ6KnHFx
	 DI/PjsL7iVBFUdWuyismsdOXAccQBI5pxC9r/AnpUAatnth9VwRyjwspyc8bLeAM+D
	 VtrdnJbAO9TZw==
Message-ID: <sashiko-outbox-194598@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 1/3] can: j1939: fix TX timer reference
 accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zihan Xi" <zihanx@nebusec.ai>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <fe402cff5706b3162d4e8aec02cc62dd7fa0b303.1793681851.git.zihanx@nebusec.ai>
References: <cover.1793681851.git.zihanx@nebusec.ai>
 <fe402cff5706b3162d4e8aec02cc62dd7fa0b303.1793681851.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 05:48:20 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] can: j1939: race in j1939_session_txtimer_cancel_async_locked(=
) drops ref
--

commit f9122b0d36d586b125a26171c0a02491b3e5aab6
Author: Zihan Xi <zihanx@nebusec.ai>

can: j1939: fix TX timer reference accounting

This commit reworks J1939 session TX timer reference accounting so a single
kref reference covers the queued and running lifetime of session->txtimer,
adding synchronization around timer arming, cancellation, and callback
completion.

Link: https://bugtracker.nebusec.ai/f/11143

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..4958f7c47ca44 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -301,9 +301,78 @@ void j1939_session_put(struct j1939_session *session)
>  	kref_put(&session->kref, __j1939_session_release);
>  }
> =20
> -static void j1939_session_txtimer_cancel(struct j1939_session *session)
> +static void j1939_session_txtimer_cancel(struct j1939_session *session,
> +					 bool shutdown)
>  {
> -	if (hrtimer_cancel(&session->txtimer))
> +	bool put_ref =3D false;
> +	int ret;
> +
> +	spin_lock_bh(&session->txtimer_lock);
> +	session->txtimer_cancelers++;
> +	if (shutdown)
> +		session->txtimer_shutdown =3D true;
> +	ret =3D hrtimer_try_to_cancel(&session->txtimer);
> +	if (ret =3D=3D 1) {
> +		if (!WARN_ON_ONCE(!session->txtimer_ref)) {
> +			session->txtimer_ref =3D false;
> +			put_ref =3D true;
> +		}
> +	}
> +	spin_unlock_bh(&session->txtimer_lock);
> +
> +	/* Never wait for a softirq callback while holding txtimer_lock. */
> +	if (ret < 0) {
> +		ret =3D hrtimer_cancel(&session->txtimer);
> +		if (ret =3D=3D 1) {
> +			spin_lock_bh(&session->txtimer_lock);
> +			if (!WARN_ON_ONCE(!session->txtimer_ref)) {
> +				session->txtimer_ref =3D false;
> +				put_ref =3D true;
> +			}
> +			spin_unlock_bh(&session->txtimer_lock);
> +		}
> +	}
> +	spin_lock_bh(&session->txtimer_lock);
> +	if (WARN_ON_ONCE(!session->txtimer_cancelers))
> +		session->txtimer_cancelers =3D 0;
> +	else
> +		session->txtimer_cancelers--;
> +	spin_unlock_bh(&session->txtimer_lock);
> +
> +	if (put_ref)
> +		j1939_session_put(session);
> +}
> +
> +static bool
> +j1939_session_txtimer_cancel_async_locked(struct j1939_session *session)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&session->txtimer_lock);
> +	session->txtimer_shutdown =3D true;
> +	ret =3D hrtimer_try_to_cancel(&session->txtimer);
> +	/* Let a queued successor finish promptly after callback exit. */
> +	if (ret < 0 && session->txtimer_ref &&
> +	    hrtimer_is_queued(&session->txtimer))
> +		hrtimer_start(&session->txtimer, 0, HRTIMER_MODE_REL_SOFT);

[Severity: Critical]
Can j1939_session_txtimer_cancel_async_locked() race with a concurrent
hrtimer_cancel() in j1939_session_txtimer_cancel() and leave session->txtim=
er
queued without a session reference?

Unlike j1939_tp_schedule_txtimer(), j1939_session_txtimer_cancel_async_lock=
ed()
does not check session->txtimer_cancelers before calling hrtimer_start(), a=
nd
hrtimer_cancel() in j1939_session_txtimer_cancel() runs without holding
session->txtimer_lock.

If j1939_tp_txtimer() on CPU 0 has re-armed a successor timer and is exiting
after releasing session->txtimer_lock:

CPU 0 (j1939_tp_txtimer)
  queued =3D hrtimer_is_queued(&session->txtimer); /* true, keeps txtimer_r=
ef */
  spin_unlock_bh(&session->txtimer_lock);
  return HRTIMER_NORESTART;
  /* still running in __run_hrtimer() before clearing base->running */

CPU 1 (j1939_session_txtimer_cancel)
  spin_lock_bh(&session->txtimer_lock);
  session->txtimer_cancelers++;
  ret =3D hrtimer_try_to_cancel(&session->txtimer); /* returns -1 */
  spin_unlock_bh(&session->txtimer_lock);
  ret =3D hrtimer_cancel(&session->txtimer);

CPU 2 (j1939_session_txtimer_cancel_async_locked)
  /* holds session->txtimer_lock */
  ret =3D hrtimer_try_to_cancel(&session->txtimer); /* returns -1 */
  if (ret < 0 && session->txtimer_ref &&
      hrtimer_is_queued(&session->txtimer)) /* evaluates true */

If CPU 0 then clears base->running in __run_hrtimer() and CPU 1's
hrtimer_cancel() dequeues the pending successor timer and returns 1 before
CPU 2 calls hrtimer_start():

CPU 2
  hrtimer_start(&session->txtimer, 0, HRTIMER_MODE_REL_SOFT);
  /* re-queues session->txtimer and returns false (ret =3D=3D -1) */

CPU 1
  if (ret =3D=3D 1) {
      spin_lock_bh(&session->txtimer_lock);
      session->txtimer_ref =3D false;
      put_ref =3D true;
      spin_unlock_bh(&session->txtimer_lock);
  }
  ...
  j1939_session_put(session);

Wouldn't this leave session->txtimer queued in the hrtimer subsystem with
session->txtimer_ref set to false and its kref dropped, leading to a
WARN_ON_ONCE(!session->txtimer_ref) and a use-after-free of struct
j1939_session when j1939_tp_txtimer() fires? Should
j1939_session_txtimer_cancel_async_locked() avoid calling hrtimer_start() w=
hen
session->txtimer_cancelers is non-zero (since the synchronous canceler in
j1939_session_txtimer_cancel() is already waiting to cancel the timer)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793681851.gi=
t.zihanx@nebusec.ai?part=3D1
