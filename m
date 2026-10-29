Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265439;
	b=RKVAHIWOURbXLmleqSZlGloXPOeO1Dy4GvqCmT2XcVsHS0Oy7jZW1YQkzGIlt8yLV0E6
	 9jV4qm6eNDfJhVPGgS1lxFaF/WT91tSKBQ7qPG8wTxALrmN/3evCpN7+58ZNwliKEsnOk
	 y3TCblu5Ej5NdGJPghzd2ijYhBb+NEsnGduIQyohPDOHR7OtrVdiO0fbffz8kVu8uT2UG
	 dOWe232dX0SWa0JYikMMNlVRF4Zg8DuU7z2cx5YLQ3hCJdwNi5h0YUGqAUDDYY+O3XyFU
	 RYTvkvmWrLT8h2y8T8YHVPgGyKP5Cde/Y2qhjkMULOcfaLnAL/O21hsCvMG1iyCRu6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265439;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IWrTTGOejMCkIxZRRragLUIRD3Eelqb7N1W4aTMWi4E=;
	b=q1K6JvpWUdwahPfU4xPxMbWoAZV0FnF5rjGlZdsrJjdsX7wW6t7016GjGeBXn4Xxjfod
	 iZ5ANhhSrtjfZg+0/twS3jsIiHr1As8QBUp92wjr1OGOS8tktMEaLdKnAotG6mQFzpbYy
	 AX+hn7FcgQpboG6KWsFEdzc+6k/9upz2Hnhxk0Zv7GDwQDAmLvlAq7msac15Yj2kd4xCT
	 9Rbs4q2XdO/4UuUQdam9ztxq3twoDkDqdjZfx8/7I87jn3zD+ShEfbEqAYp+7OAmvOIZO
	 tugS3r4SsDi8n8gu9KW2p57uR0rzd7hAnJQwG5pvHRiiy620HMGlHuow0QjdmgbEOsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTIgFPiZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C81F606A321
	for <linux-can@vger.kernel.org>; Thu, 29 Oct 2026 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTIgFPiZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D611F031E2;
	Thu, 29 Oct 2026 09:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265439;
	bh=IWrTTGOejMCkIxZRRragLUIRD3Eelqb7N1W4aTMWi4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kTIgFPiZ6n6G0QNzo01ef1InaMWYH5d/OeoGDHPbgiAMg+0bR4tzYd+z2IP1hLlBi
	 YW3On2r3jilXvs+7sx9Yuv41lrjeZVwxG/+CZA9hwM+VJYZk2CLnTxFEmkQ7UPyNYd
	 RZ2lC7Ph+K+HOU3BTr32fOTOSUVHjBBbARvM3uiNFDwfBy9lgW7BRqKn2KxdXWnvIt
	 C2tK2jO0ljILyNYdL3JkmqRrUjOm+e6WHwyxeAzdUQBW/cnO09XVHZqTae6SMTIVJN
	 ezLqDBsFlcAJWR5n3a38Itn861/4VF/ZYhVdgiDe0jwkaLFD3+KBNaax86K2ky7unP
	 /HMU0S3VeB67g==
Message-ID: <sashiko-outbox-189017@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/3] can: j1939: fix session reference leaks on
 timer rearm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zihan Xi" <zihanx@nebusec.ai>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <21bf54f2fbab33155e924e0743f17b1e47655255.1793259424.git.zihanx@nebusec.ai>
References: <cover.1793259424.git.zihanx@nebusec.ai>
 <21bf54f2fbab33155e924e0743f17b1e47655255.1793259424.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:17:18 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] can: j1939: uncancelled rearmed timers on session deactivation
- [Medium] can: j1939: missing rxtimer_cancelers check in j1939_tp_rxtimer()
- [Medium] can: j1939: spurious RX abort errqueue in j1939_tp_rxtimer()
- [Medium] can: j1939: unconditional abort report in j1939_xtp_rx_abort_one=
()
- [Medium] can: j1939: race between j1939_xtp_rx_cts_one() and running j193=
9_tp_txtimer()
--

commit 7eba1ba447e6468d3fbb3a6bd7b54eae6d683f35
Author: Zihan Xi <zihanx@nebusec.ai>

can: j1939: fix session reference leaks on timer rearm

This patch separates queued timer and running callback references for J1939
session TX and RX hrtimers to avoid leaking session references on timer
rearming. It also drains terminal timers outside state locks and moves
next-session timer scheduling outside the socket queue lock.

Link: https://bugtracker.nebusec.ai/f/11143
Link: https://lore.kernel.org/all/cover.1793012287.git.zihanx@nebusec.ai/

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..0dd08d1b8f755 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -301,22 +302,139 @@ void j1939_session_put(struct j1939_session *sessi=
on)
>  	kref_put(&session->kref, __j1939_session_release);
>  }
> =20
> +static void j1939_session_txtimer_cancel_async(struct j1939_session *ses=
sion)
> +{
> +	bool put_qref =3D false;
> +	int ret;
> +
> +	spin_lock_bh(&session->txtimer_lock);
> +	session->txtimer_shutdown =3D true;
> +	ret =3D hrtimer_try_to_cancel(&session->txtimer);
> +	if (ret =3D=3D 1) {
> +		WARN_ON_ONCE(!session->txtimer_qref);
> +		session->txtimer_qref =3D false;
> +		put_qref =3D true;
> +	}
> +	spin_unlock_bh(&session->txtimer_lock);
> +
> +	if (put_qref)
> +		j1939_session_put(session);
> +}

[ ... ]

> +/* Cancel a queued RX timer without waiting; caller may be in softirq co=
ntext. */
>  static void j1939_session_rxtimer_cancel(struct j1939_session *session)
>  {
> -	if (hrtimer_cancel(&session->rxtimer))
> +	bool put_qref =3D false;
> +	int ret;
> +
> +	j1939_session_list_lock(session->priv);
> +	ret =3D hrtimer_try_to_cancel(&session->rxtimer);
> +	if (ret =3D=3D 1) {
> +		WARN_ON_ONCE(!session->rxtimer_qref);
> +		session->rxtimer_qref =3D false;
> +		put_qref =3D true;
> +	}
> +	j1939_session_list_unlock(session->priv);
> +
> +	if (put_qref)
>  		j1939_session_put(session);
>  }

[ ... ]

> @@ -1127,6 +1342,11 @@ static bool j1939_session_deactivate(struct j1939_=
session *session)
>  	active =3D j1939_session_deactivate_locked(session);
>  	j1939_session_list_unlock(priv);
> =20
> +	if (active) {
> +		j1939_session_txtimer_cancel_async(session);
> +		j1939_session_rxtimer_cancel(session);
> +	}
> +
>  	return active;
>  }

[ ... ]

> @@ -1226,13 +1472,37 @@ static enum hrtimer_restart j1939_tp_txtimer(stru=
ct hrtimer *hrtimer)
>  		if (session->skcb.addr.type !=3D J1939_SIMPLE) {
>  			j1939_session_cancel(session, J1939_XTP_ABORT_OTHER);
>  		} else {
> -			session->err =3D ret;
> +			j1939_session_list_lock(priv);
> +			if (session->state >=3D J1939_SESSION_ACTIVE &&
> +			    session->state < J1939_SESSION_ACTIVE_MAX)
> +				session->err =3D ret;
> +			j1939_session_list_unlock(priv);
>  			j1939_session_rxtimer_cancel(session);
>  			j1939_session_deactivate_activate_next(session);
>  		}
>  	}
> =20
> -	j1939_session_put(session);
> +txtimer_done:
> +	spin_lock_bh(&session->txtimer_lock);
> +	WARN_ON_ONCE(!session->txtimer_cb_running ||
> +		     !session->txtimer_cbref);
> +	session->txtimer_cb_running =3D false;
> +	if (txtimer_delay && !session->txtimer_shutdown &&
> +	    !session->txtimer_qref) {
> +		/* Transfer the callback pin to its rearmed timer. */
> +		session->txtimer_cbref =3D false;
> +		session->txtimer_qref =3D true;
> +		hrtimer_start(&session->txtimer, ms_to_ktime(txtimer_delay),
> +			      HRTIMER_MODE_REL_SOFT);
> +	} else {
> +		/* An external qref, if present, owns the next firing. */
> +		session->txtimer_cbref =3D false;
> +		put_cbref =3D true;
> +	}
> +	spin_unlock_bh(&session->txtimer_lock);
> +
> +	if (put_cbref)
> +		j1939_session_put(session);
> =20
>  	return HRTIMER_NORESTART;
>  }
> @@ -1257,8 +1527,25 @@ static enum hrtimer_restart j1939_tp_rxtimer(struc=
t hrtimer *hrtimer)
>  						     struct j1939_session,
>  						     rxtimer);
>  	struct j1939_priv *priv =3D session->priv;
> +	enum j1939_session_state state;
> +	bool active;
> +
> +	j1939_session_list_lock(priv);
> +	if (!session->rxtimer_cbref) {
> +		WARN_ON_ONCE(session->rxtimer_cb_running);
> +		WARN_ON_ONCE(!session->rxtimer_qref);
> +		session->rxtimer_qref =3D false;
> +		session->rxtimer_cbref =3D true;
> +	}
> +	session->rxtimer_cb_running =3D true;
> +	state =3D session->state;
> +	active =3D state >=3D J1939_SESSION_ACTIVE &&
> +		state < J1939_SESSION_ACTIVE_MAX;
> +	j1939_session_list_unlock(priv);
> =20
> -	if (session->state =3D=3D J1939_SESSION_WAITING_ABORT) {
> +	if (!active) {
> +		/* A terminal path won before this callback started its work. */
> +	} else if (state =3D=3D J1939_SESSION_WAITING_ABORT) {
>  		netdev_alert(priv->ndev, "%s: 0x%p: abort rx timeout. Force session de=
activation\n",
>  			     __func__, session);
> =20
> @@ -1271,18 +1558,24 @@ static enum hrtimer_restart j1939_tp_rxtimer(stru=
ct hrtimer *hrtimer)
>  		/* The message is probably stuck in the CAN controller and can
>  		 * be send as soon as CAN bus is in working state again.
>  		 */
> -		session->err =3D -ETIME;
> -		j1939_session_deactivate(session);
> +		j1939_session_list_lock(priv);
> +		if (session->state >=3D J1939_SESSION_ACTIVE &&
> +		    session->state < J1939_SESSION_ACTIVE_MAX) {
> +			session->err =3D -ETIME;
> +			j1939_session_deactivate_locked(session);
> +		}
> +		j1939_session_list_unlock(priv);
> +		j1939_session_txtimer_cancel_async(session);
> +		j1939_session_rxtimer_cancel(session);

[Severity: High]
Can a rearmed timer remain queued holding session->rxtimer_qref or
session->txtimer_qref after the session is deactivated?

In kernel/time/hrtimer.c:hrtimer_try_to_cancel():

	if (!hrtimer_callback_running(timer)) {
		ret =3D remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE);
		if (ret)
			trace_hrtimer_cancel(timer);
	}

whenever the callback is currently executing (base->running =3D=3D timer),
hrtimer_try_to_cancel() returns -1 without removing the timer from the
hrtimer queue, even if the timer was concurrently rearmed with
hrtimer_start().

When j1939_session_deactivate() (or the J1939_SIMPLE branch in
j1939_tp_rxtimer()) deactivates a session, j1939_session_deactivate_locked()
removes the session from priv->active_session_list and sets session->state
to J1939_SESSION_DONE, and then calls j1939_session_txtimer_cancel_async()
and j1939_session_rxtimer_cancel().

If a timer was rearmed while its callback was running:

1. In j1939_tp_rxtimer(), the J1939_SESSION_WAITING_ABORT and J1939_SIMPLE
   branches call j1939_session_rxtimer_cancel() from inside
   j1939_tp_rxtimer() itself. Since hrtimer_callback_running() is true,
   hrtimer_try_to_cancel(&session->rxtimer) always returns -1. If a
   concurrent j1939_tp_set_rxtimeout() rearmed session->rxtimer before
   session->state became J1939_SESSION_DONE, the epilogue of
   j1939_tp_rxtimer() only drops session->rxtimer_cbref and leaves
   session->rxtimer queued with session->rxtimer_qref =3D true.

2. In the active XTP branch of j1939_tp_rxtimer(), the callback rearms
   session->rxtimer for J1939_XTP_ABORT_TIMEOUT_MS (setting
   session->rxtimer_qref =3D true) and drops active_session_list_lock. If a
   concurrent j1939_tp_txtimer() error path calls
   j1939_session_rxtimer_cancel() and j1939_session_deactivate_activate_nex=
t()
   before j1939_tp_rxtimer() finishes executing in __run_hrtimer(),
   hrtimer_try_to_cancel(&session->rxtimer) returns -1 and leaves the abort
   timeout queued.

3. Similarly, if a concurrent j1939_tp_schedule_txtimer() rearms
   session->txtimer while j1939_tp_txtimer() is running (setting
   session->txtimer_qref =3D true) and j1939_session_txtimer_cancel_async()
   runs before j1939_tp_txtimer() exits, hrtimer_try_to_cancel() returns -1.
   At txtimer_done, session->txtimer_shutdown is true, so it takes the else
   branch and only drops session->txtimer_cbref, leaving session->txtimer
   queued with session->txtimer_qref =3D true.

Because the session has already been removed from priv->active_session_list,
j1939_cancel_active_session() during socket close or netdev teardown will no
longer find the session to synchronously drain the remaining queued timer,
delaying j1939_session_destroy() until the timer expires.

>  	} else {
>  		j1939_session_list_lock(session->priv);
> -		if (session->state >=3D J1939_SESSION_ACTIVE &&
> +		if (!session->rxtimer_cancelers &&
> +		    session->state >=3D J1939_SESSION_ACTIVE &&
>  		    session->state < J1939_SESSION_ACTIVE_MAX) {
>  			netdev_alert(priv->ndev, "%s: 0x%p: rx timeout, send abort\n",
>  				     __func__, session);
> -			j1939_session_get(session);
> -			hrtimer_start(&session->rxtimer,
> -				      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
> -				      HRTIMER_MODE_REL_SOFT);
> +			j1939_tp_set_rxtimeout_locked(session,
> +						      J1939_XTP_ABORT_TIMEOUT_MS);
>  			__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
>  		}
>  		j1939_session_list_unlock(session->priv);

[Severity: Medium]
Should the state =3D=3D J1939_SESSION_WAITING_ABORT and
session->skcb.addr.type =3D=3D J1939_SIMPLE branches in j1939_tp_rxtimer() =
also
check session->rxtimer_cancelers?

Callers such as j1939_simple_recv() and j1939_xtp_rx_abort_one() drain
timers via j1939_session_timers_cancel(session) before updating session->err
or deactivating the session:

j1939_simple_recv()
  j1939_session_timers_cancel(session)
    j1939_session_rxtimer_cancel_sync(session, true)
      session->rxtimer_cancelers++;
      j1939_session_list_unlock(session->priv);
      hrtimer_cancel(timer);
  j1939_session_deactivate(session);

Because j1939_tp_rxtimer() only checks !session->rxtimer_cancelers in the
final else branch, a concurrent j1939_tp_rxtimer() running while
j1939_simple_recv() is waiting in hrtimer_cancel() will enter the
J1939_SIMPLE branch, set session->err =3D -ETIME, and deactivate the sessio=
n,
reporting a timeout error for a simple message that was already received.
Likewise, in the J1939_SESSION_WAITING_ABORT branch, j1939_tp_rxtimer() will
deactivate the session while j1939_xtp_rx_abort_one() is waiting in
j1939_session_timers_cancel(), preventing j1939_xtp_rx_abort_one() from
recording the abort error code in session->err.

> =20
>  		if (!session->sk)
>  			j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
>  	}

[Severity: Medium]
If j1939_tp_rxtimer() skips __j1939_session_cancel() in the else branch
because session->rxtimer_cancelers is non-zero or session->state is no
longer active, won't this still unconditionally call
j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT) when !session->sk?

For example, when an incoming broadcast BAM session completes in
j1939_xtp_rx_dat_one() and calls j1939_session_timers_cancel(session),
session->rxtimer_cancelers is incremented while hrtimer_cancel() waits for a
concurrently running j1939_tp_rxtimer(). j1939_tp_rxtimer() sees
session->rxtimer_cancelers !=3D 0 and skips __j1939_session_cancel(), but
after unlocking it still queues a spurious J1939_ERRQUEUE_RX_ABORT with
session->err =3D=3D 0 to subscribed sockets.

[ ... ]

> @@ -1372,7 +1672,11 @@ static void j1939_xtp_rx_abort_one(struct j1939_pr=
iv *priv, struct sk_buff *skb,
>  		    j1939_xtp_abort_to_str(abort));
> =20
>  	j1939_session_timers_cancel(session);
> -	session->err =3D j1939_xtp_abort_to_errno(priv, abort);
> +	j1939_session_list_lock(priv);
> +	if (session->state >=3D J1939_SESSION_ACTIVE &&
> +	    session->state < J1939_SESSION_ACTIVE_MAX)
> +		session->err =3D j1939_xtp_abort_to_errno(priv, abort);
> +	j1939_session_list_unlock(priv);
>  	if (session->sk)
>  		j1939_sk_send_loop_abort(session->sk, session->err);
>  	else
>  		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
>  	j1939_session_deactivate_activate_next(session);

[Severity: Medium]
In j1939_xtp_rx_abort_one(), if the session transitions to
J1939_SESSION_DONE while j1939_session_timers_cancel(session) is waiting
outside active_session_list_lock, session->err is not updated, but
j1939_sk_send_loop_abort() or j1939_sk_errqueue() is still called
unconditionally afterwards.

Should reporting the abort also be skipped when the session was already
deactivated?

> @@ -1486,7 +1790,6 @@ j1939_xtp_rx_cts_one(struct j1939_session *session,=
 struct sk_buff *skb)
>  			if (session->pkt.tx_acked)
>  				j1939_sk_errqueue(session,
>  						  J1939_ERRQUEUE_TX_SCHED);
> -			j1939_session_txtimer_cancel(session);
>  			j1939_tp_schedule_txtimer(session, 0);
>  		}
>  	} else {

[Severity: Medium]
Is it safe to remove j1939_session_txtimer_cancel(session) from
j1939_xtp_rx_cts_one() when j1939_tp_txtimer() may already be running on
another CPU?

Previously, j1939_xtp_rx_cts_one() called hrtimer_cancel(&session->txtimer)
before calling j1939_tp_schedule_txtimer(session, 0), waiting for any
in-flight j1939_tp_txtimer() callback to finish.

Without that wait, if j1939_tp_txtimer() is dispatched on CPU 0 (for
instance, from a packet-delay or -ENOBUFS retry timer) while
j1939_xtp_rx_cts_one() runs on CPU 1:

CPU 1 (j1939_xtp_rx_cts_one)
  updates session->pkt.tx_acked, session->pkt.last, session->pkt.tx
  session->last_cmd =3D dat[0];
  j1939_tp_schedule_txtimer(session, 0)
    hrtimer_try_to_cancel(&session->txtimer) -> returns -1
    session->txtimer_qref =3D true;
    hrtimer_start(&session->txtimer, 0, ...);

CPU 0 (j1939_tp_txtimer)
  j1939_xtp_txnext_transmiter(session, &txtimer_delay)
    j1939_session_tx_dat(session, &txtimer_delay)

CPU 0 then transmits using the CTS state just written by CPU 1. At
txtimer_done on CPU 0:

	if (txtimer_delay && !session->txtimer_shutdown &&
	    !session->txtimer_qref) {
		...
	} else {
		/* An external qref, if present, owns the next firing. */
		session->txtimer_cbref =3D false;
		put_cbref =3D true;
	}

Because session->txtimer_qref is already true from CPU 1, CPU 0 either drops
its computed txtimer_delay (losing j1939_tp_packet_delay or the -ENOBUFS
retry backoff in favor of the 0ms timer) or, if CPU 0 already transmitted
all packets up to session->pkt.total, leaves the 0ms timer queued so the
next j1939_tp_txtimer() firing sees session->pkt.tx =3D=3D session->pkt.tot=
al,
fails j1939_session_skb_get_by_offset() with NULL, and triggers -ENOBUFS
retries.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793259424.gi=
t.zihanx@nebusec.ai?part=3D1
