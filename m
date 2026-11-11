Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394813;
	b=FNIAIRHxHC5br2IMm4+xZhoYv0ifVUMrcG2BNjZpzAAnw0lqkR3cmcppvWHY9HWrS7Q4
	 lQkzxQkpAzKSnspTS2oHgsN8iTAOMgHVNWSMpL/O2U7+JQC/WNFgBztxsuH/B0fWmrKoS
	 +a9wssafEphw61uNWeP83iIc3jJavCiXV4VTSknc8p1GlsxgTblLk+sRF4qhxwSXkcB9M
	 ZL9sxWBx65wWTmNXqEri+Afs3Q2oyzVUgkbL3UyOM2Cc1zwB6ztv56A9eBneeIbaou59D
	 Llrjl+CyAnHj5IEh8OeWoUu+4GZH0U3mp/IRygUmg/HSbrFXNwdOrKmoeGqNev8aZ5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394813;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=msi34iDDBgcNjtW/OamYj9HUrdGlF5FL7BzgR03nde0=;
	b=cbSFNknbOe1LRyJ+fJU8k2D4N93BC2/oUT4E0Okmsiq3Wlf2uknsQhbgCFxB+9YlnP8z
	 fiPre1cjcllcyHTiwZOZzT4qJC14iR4Xe4bfuC/amlT5MEalGR4HFMGHIMAovp1Jl1nEG
	 mCY9QAcKHVH6ih9S+akNlATeMsL889ndxZmnmOchJf+JJKNzWs/YNKgUUF7pLrRo5NL4c
	 uTw6pzEfpHL0BnMIbHwHMo9oLvdnjp+Xk2X+ehJoyTptEWpkrtG/sE08fdFW9+0H011Ua
	 2GBS9uoIMWJfPIhvKbVc3xDghFlIZ21RDbXqsFhA2ZckOoE17SeUoeKCOWS0gCtJN9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWgsptBH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC93A606A331
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWgsptBH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98931F00A05;
	Wed, 11 Nov 2026 11:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794394813;
	bh=msi34iDDBgcNjtW/OamYj9HUrdGlF5FL7BzgR03nde0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jWgsptBHrJyWEnHZzbXw8FHMM8U5dwQn7c5eXmeQ+JB7US6EDW38vOUGzhKtvL3JZ
	 Jixdn0vq/Vtf7XU6SnRB8xZcS4Ttc62+vMfb5vR4QSH1LbYkF0/0CdhJDq+M3J1qY4
	 dWyf30MRZvvAJgb/8F1mDC+0B57BX6GMXlGJYgCQ57b2iFr9YxRmtI2DgcFPsQz7ix
	 IXYMoeFtjSAcshLCrshWlwCwH9FpqBTPVyuPoymLD39N8h+N7m0x3rl89wsCl97PKl
	 i/lNZqK/IuqVgltkcoZ5KXXSYLpvzEcCC9Z8FDwiTgtAkVZf3/lCziIbsdLYCThDOo
	 n8OYofGL9dr1Q==
Message-ID: <sashiko-outbox-208840@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v9 1/4] can: j1939: serialize cancel and rearm of
 the receive timer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chaosheng Qu" <chaosheng.qu.linux@gmail.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261111-j1939-edpo-v9-v9-1-e779ca334a81@163.com>
References: <20261111-j1939-edpo-v9-v9-0-e779ca334a81@163.com>
 <20261111-j1939-edpo-v9-v9-1-e779ca334a81@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 11:00:12 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] can: j1939: session ref leak in j1939_tp_arm_rxtimer_locked()
- [Medium] can: j1939: armed rxtimer left on deactivated session in
  cancel paths
- [Medium] can: j1939: race on session->state in j1939_tp_rxtimer()
--

commit 1460925f6781f194bfa61b943a4417a2108a6cee
Author: Chaosheng Qu <quchaosheng000406@163.com>

can: j1939: serialize cancel and rearm of the receive timer

This commit introduces j1939_tp_arm_rxtimer_locked() to cancel and rearm
session->rxtimer under active_session_list_lock using
hrtimer_try_to_cancel(), and updates session cancellation and RTS handling
paths.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..fa23260e1833f 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -721,15 +721,42 @@ void j1939_tp_schedule_txtimer(struct j1939_session=
 *session, int msec)
>  		      HRTIMER_MODE_REL_SOFT);
>  }
> =20
> -static inline void j1939_tp_set_rxtimeout(struct j1939_session *session,
> -					  int msec)
> +/*
> + * Rearm the receive timer as one step under active_session_list_lock.
> + *
> + * j1939_tp_set_rxtimeout() is called from receive handlers that do not =
hold
> + * the session list lock, while j1939_session_cancel() is called from the
> + * transmit timer path.  If the cancel and the rearm are not serialized,=
 a
> + * concurrent caller can start the timer after this one cancelled it and
> + * before this one starts it again: hrtimer_start() on an already armed =
timer
> + * reprograms it without dropping the reference taken by that caller, an=
d the
> + * session leaks together with its netdev reference.
> + *
> + * hrtimer_try_to_cancel() does not wait for a running callback, so it c=
an be
> + * called with the lock held even though j1939_tp_rxtimer() takes the sa=
me
> + * lock; a callback that is already running drops its own reference.  Fo=
r the
> + * same reason the return value is only 1 when the timer was queued: whe=
n this
> + * runs from j1939_tp_rxtimer() itself, the timer is no longer queued an=
d 0 is
> + * the expected result.
> + */
> +static void j1939_tp_arm_rxtimer_locked(struct j1939_session *session, i=
nt msec)
> +{
> +	if (hrtimer_try_to_cancel(&session->rxtimer) =3D=3D 1)
> +		j1939_session_put(session);
> +
>  	j1939_session_get(session);
>  	hrtimer_start(&session->rxtimer, ms_to_ktime(msec),
>  		      HRTIMER_MODE_REL_SOFT);
>  }

[Severity: High]
Can j1939_tp_arm_rxtimer_locked() still leak a session reference when
session->rxtimer is armed more than once while j1939_tp_rxtimer() is
running?

kernel/time/hrtimer.c:hrtimer_try_to_cancel() {
    ...
	if (!hrtimer_callback_running(timer)) {
		ret =3D remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE);
		if (ret)
			trace_hrtimer_cancel(timer);
	}
    ...
}

__run_hrtimer() keeps base->running set to &session->rxtimer for the entire
duration of j1939_tp_rxtimer() until after the callback returns, so
hrtimer_try_to_cancel() skips remove_hrtimer() and returns -1 even if
session->rxtimer has already been re-enqueued.

CPU0                              CPU1
j1939_tp_rxtimer()
                                  j1939_tp_set_rxtimeout()
                                    j1939_session_list_lock()
                                    j1939_tp_arm_rxtimer_locked()
                                      hrtimer_try_to_cancel() -> -1
                                      j1939_session_get(session)
                                      hrtimer_start(&session->rxtimer, ...)
                                    j1939_session_list_unlock()
  j1939_session_list_lock()
  j1939_tp_arm_rxtimer_locked()
    hrtimer_try_to_cancel() -> -1
    j1939_session_get(session)
    hrtimer_start(&session->rxtimer, ...)  <-- leaks CPU1's session ref

Because hrtimer_try_to_cancel() returns -1 on CPU0 while the callback is
running, j1939_session_put() is skipped and hrtimer_start() reprograms the
queued timer in place without releasing the first reference, permanently
leaking the session and its netdev_hold() reference.

[ ... ]

> @@ -1161,18 +1188,29 @@ static void __j1939_session_cancel(struct j1939_s=
ession *session,
>  static void j1939_session_cancel(struct j1939_session *session,
>  				 enum j1939_xtp_abort err)
>  {
> +	bool waiting;
> +
>  	j1939_session_list_lock(session->priv);
> =20
> +	waiting =3D session->state =3D=3D J1939_SESSION_WAITING_ABORT;
>  	if (session->state >=3D J1939_SESSION_ACTIVE &&
>  	    session->state < J1939_SESSION_WAITING_ABORT) {
> -		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
>  		__j1939_session_cancel(session, err);
> +		j1939_tp_arm_rxtimer_locked(session, J1939_XTP_ABORT_TIMEOUT_MS);
>  	}
> =20
>  	j1939_session_list_unlock(session->priv);
> =20
>  	if (!session->sk)
>  		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
> +
> +	/* The abort already went out on an earlier call, so this one armed no
> +	 * timer.  Several callers cancel the timers before calling here, which
> +	 * would otherwise leave the session on the list with nothing to finish
> +	 * it off, so deactivate it now.
> +	 */
> +	if (waiting)
> +		j1939_session_deactivate_activate_next(session);
>  }
> =20
>  static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
> @@ -1279,10 +1317,8 @@ static enum hrtimer_restart j1939_tp_rxtimer(struc=
t hrtimer *hrtimer)
>  		    session->state < J1939_SESSION_ACTIVE_MAX) {
>  			netdev_alert(priv->ndev, "%s: 0x%p: rx timeout, send abort\n",
>  				     __func__, session);
> -			j1939_session_get(session);
> -			hrtimer_start(&session->rxtimer,
> -				      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
> -				      HRTIMER_MODE_REL_SOFT);
> +			j1939_tp_arm_rxtimer_locked(session,
> +						    J1939_XTP_ABORT_TIMEOUT_MS);
>  			__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
>  		}
>  		j1939_session_list_unlock(session->priv);

[Severity: Medium]
Can j1939_tp_rxtimer() race with j1939_session_cancel() on session->state n=
ow
that j1939_session_cancel() no longer calls hrtimer_cancel(&session->rxtime=
r)
before setting J1939_SESSION_WAITING_ABORT?

CPU0                              CPU1
j1939_tp_rxtimer()
  if (session->state =3D=3D
      J1939_SESSION_WAITING_ABORT)
    -> false
                                  j1939_session_cancel()
                                    j1939_session_list_lock()
                                    __j1939_session_cancel()
                                      session->state =3D
                                        J1939_SESSION_WAITING_ABORT
                                    j1939_tp_arm_rxtimer_locked()
                                    j1939_session_list_unlock()
  j1939_session_list_lock()
  if (session->state >=3D J1939_SESSION_ACTIVE &&
      session->state < J1939_SESSION_ACTIVE_MAX)
    __j1939_session_cancel()  <-- cancels already-aborted session again

Because J1939_SESSION_WAITING_ABORT is less than J1939_SESSION_ACTIVE_MAX,
CPU0 sends a second abort, overwrites session->err with
J1939_XTP_ABORT_TIMEOUT, and rearms session->rxtimer while the callback is
running.  If CPU1 instead finishes before CPU0's unlocked check at the top =
of
j1939_tp_rxtimer(), CPU0 sees J1939_SESSION_WAITING_ABORT on the old timer's
expiration and immediately deactivates the session while the new abort timer
remains queued.

> @@ -1729,16 +1765,10 @@ static int j1939_xtp_rx_rts_session_active(struct=
 j1939_session *session,
> =20
>  		j1939_session_timers_cancel(session);
>  		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
> -		if (session->transmission) {
> -			j1939_session_deactivate_activate_next(session);
> -		} else if (session->state =3D=3D J1939_SESSION_WAITING_ABORT) {
> -			/* Force deactivation for the receiver.
> -			 * If we rely on the timer starting in j1939_session_cancel,
> -			 * a second RTS call here will cancel that timer and fail
> -			 * to restart it because the state is already WAITING_ABORT.
> -			 */
> -			j1939_session_deactivate_activate_next(session);
> -		}
> +		/* Both roles: the peer is restarting the transfer, so free the
> +		 * slot now rather than wait out the abort timeout.
> +		 */
> +		j1939_session_deactivate_activate_next(session);
> =20
>  		return -EBUSY;
>  	}

[Severity: Medium]
Does deactivating the session in j1939_xtp_rx_rts_session_active() and
j1939_session_cancel() leave session->rxtimer armed after the session is
removed from priv->active_session_list?

When session->last_cmd !=3D 0 on an active transmitter session,
j1939_session_cancel() transitions the session to J1939_SESSION_WAITING_ABO=
RT
and arms session->rxtimer for J1939_XTP_ABORT_TIMEOUT_MS, and
j1939_session_deactivate_activate_next() then immediately sets session->sta=
te
to J1939_SESSION_DONE and removes it from priv->active_session_list without
cancelling that timer.  The same happens when j1939_session_cancel() sees
waiting =3D=3D true via callers such as j1939_tp_txtimer() that do not canc=
el
session->rxtimer beforehand, or when another CPU arms session->rxtimer betw=
een
j1939_session_timers_cancel() and j1939_session_list_lock().  Because the
deactivated session is no longer on priv->active_session_list,
j1939_cancel_active_session() cannot cancel the timer during socket close or
netdev teardown, and when the timer expires on an RX session (!session->sk)=
 in
J1939_SESSION_DONE it falls into the else branch of j1939_tp_rxtimer() and
emits a duplicate J1939_ERRQUEUE_RX_ABORT notification.

Also, the commit message does not mention these state-machine changes in
j1939_session_cancel() and j1939_xtp_rx_rts_session_active(), and says
j1939_session_cancel() previously hand-rolled get + hrtimer_start() when it
actually called j1939_tp_set_rxtimeout().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-j1939-edpo=
-v9-v9-1-e779ca334a81@163.com?part=3D1
