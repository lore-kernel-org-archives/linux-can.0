Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793265329;
	b=aGra9D7wBLGOQYBT3GSJQ4ZDPzY70Zd9YBF1m1eciamWUBm5crQGiH40jV7pcQmxtqSK
	 QdOGqQBCjKmgR221Ull+LV7mQua7pyWGJj34jUV6Laxscs4Ztopcn3pFfIQO5MgymVZH0
	 X53GTaa6UKF+3Qw7jrpOKwlkCG6chRw36ixKZK766vp9ay9B0sDSMgEDYIc2wBhQ3/ky2
	 jm8mxVyj58T6uHx6WxGacLGuJnAdb+JwzEfPGzFO8GKj7qQFa0CotrJIK6Y90dfnQBsY3
	 VLKgNcWIkGtKHsZ/EP+SfaQtdszhWLMJW5UG3svpyasHNxRwHLhu+mv3y0AwB3dLk3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265329;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P0SIf3Z0ah/xydyjtibm/RKq2We8Qb/ubi/Yy0fMOVU=;
	b=W/JFzsSpiY3SnEnA2mRKcHspOsSI4nx6HjufqZi/5FAwQFNb5rpNySRNl0PdZSyxRFj8
	 b/hU8uqQCD4JaAHEbk1QWUU9LfxwKL6bHq75EpTbYFfKHmSDyZY589zGnA1887iD7vhrN
	 1Ww/8igfl6RzxF4ui6jNQHayqtRsLEa29VfwhiZ+7cdM45VJj7SM/HvNdA748Anplr8MU
	 dBOw0s6MnRRzvxfRorytKVjkmbhCzd972fhwYDEWHd/FKBe3Qmt1mFuJlpl8dB+RaDurl
	 fXXjZUxqKpHiwfbjoittSdxM0Tw4f78EtyI4Wwz/qdheynH+zoRALphy32PY0+gqa3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDiV9cm+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13E7606A321
	for <linux-can@vger.kernel.org>; Thu, 29 Oct 2026 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDiV9cm+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFFB1F01825;
	Thu, 29 Oct 2026 09:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793265328;
	bh=P0SIf3Z0ah/xydyjtibm/RKq2We8Qb/ubi/Yy0fMOVU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YDiV9cm+mMPd7hDf6I17q2WGqco5yw6PZZeKzl2tTkjokUwoBp0oKjuimgkBW3L//
	 aCgL/3O10dYPwz5PcPy7nFSkF4HK4hrIWaporlIneni2RSQ9P2AoCkiQgQbSqZ92Yg
	 YzE/GKJdNEbEh3pTqJI53/ZhVvYbL7wcs6sPkwbLSh9wY1N5XNbMLKKCUrJ2m00xNk
	 E1GB/Xfw9lePpE8O7DTjoPE+Xkr/xiBKmOqzDEYEVwosS58hAnX52SgCCsjA+cNZNN
	 fffxEsC0VYPRQZvp2jzEX7Ri9+CLZm4Vrw9W8mh5R1FhWWl5bBVK68kf7q11g4gusP
	 JxOkktCqmauQQ==
Message-ID: <sashiko-outbox-189012@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/3] can: j1939: stop TX sends after session
 shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zihan Xi" <zihanx@nebusec.ai>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <a683b6afb2c21e0d05be0ebe18c4f60b98152d25.1793259424.git.zihanx@nebusec.ai>
References: <cover.1793259424.git.zihanx@nebusec.ai>
 <a683b6afb2c21e0d05be0ebe18c4f60b98152d25.1793259424.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:15:27 +0000
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
- [High] can: j1939: timer callbacks still cancel session after tx_send_shu=
tdown
- [High] can: j1939: unconditional error notifications outside session stat=
e guards
- [High] can: j1939: session leak on sk_session_queue when simple TX races =
rxtimer
- [Medium] can: j1939: TX sends not shut down before draining timers on com=
pletion
- [Medium] can: j1939: spurious netdev_alert() in j1939_session_tx_dat() on=
 -ESHUTDOWN
--

commit 2c11cd00299ff52c942a6b68d469115b501da6d9
Author: Zihan Xi <zihanx@nebusec.ai>

can: j1939: stop TX sends after session shutdown

This commit introduces a per-session tx_send_lock and tx_send_shutdown gate=
 to
serialize session data and control frame transmissions against session
deactivation and incoming XTP ABORT handling. It also suppresses sending an
outbound XTP ABORT frame when tx_send_shutdown has been set.

Link: https://bugtracker.nebusec.ai/f/11143
Link: https://lore.kernel.org/all/cover.1793012287.git.zihanx@nebusec.ai/

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 0dd08d1b8f755..570e2b8d08263 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c

[ ... ]

> @@ -1363,12 +1398,14 @@ static void __j1939_session_cancel(struct j1939_s=
ession *session,
>  	struct j1939_priv *priv =3D session->priv;
> =20
>  	WARN_ON_ONCE(!err);
> +	lockdep_assert_held(&session->tx_send_lock);
>  	lockdep_assert_held(&session->priv->active_session_list_lock);
> =20
>  	session->err =3D j1939_xtp_abort_to_errno(priv, err);
>  	session->state =3D J1939_SESSION_WAITING_ABORT;
>  	/* do not send aborts on incoming broadcasts */
> -	if (!j1939_cb_is_broadcast(&session->skcb)) {
> +	if (!session->tx_send_shutdown &&
> +	    !j1939_cb_is_broadcast(&session->skcb)) {
>  		j1939_xtp_tx_abort(priv, &session->skcb,
>  				   !session->transmission,
>  				   err, session->skcb.addr.pgn);
> @@ -1381,6 +1418,7 @@ static void __j1939_session_cancel(struct j1939_ses=
sion *session,
>  static void j1939_session_cancel(struct j1939_session *session,
>  				 enum j1939_xtp_abort err)
>  {
> +	spin_lock_bh(&session->tx_send_lock);
>  	j1939_session_list_lock(session->priv);
> =20
>  	if (session->state >=3D J1939_SESSION_ACTIVE &&
> @@ -1391,6 +1429,7 @@ static void j1939_session_cancel(struct j1939_sessi=
on *session,
>  	}
> =20
>  	j1939_session_list_unlock(session->priv);
> +	spin_unlock_bh(&session->tx_send_lock);
> =20
>  	if (!session->sk)
>  		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);

[Severity: High]
When j1939_xtp_rx_abort_one() processes an incoming XTP ABORT frame, it cal=
ls
j1939_session_tx_send_shutdown(session) and then drains both timers via
j1939_session_timers_cancel(session) while session->state is still
J1939_SESSION_ACTIVE:

net/can/j1939/transport.c:j1939_xtp_rx_abort_one() {
	...
	j1939_session_tx_send_shutdown(session);
	j1939_session_timers_cancel(session);
	j1939_session_list_lock(priv);
	if (session->state >=3D J1939_SESSION_ACTIVE &&
	    session->state < J1939_SESSION_ACTIVE_MAX)
		session->err =3D j1939_xtp_abort_to_errno(priv, abort);
	j1939_session_list_unlock(priv);
	if (session->sk)
		j1939_sk_send_loop_abort(session->sk, session->err);
	else
		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
	j1939_session_deactivate_activate_next(session);
}

While j1939_session_timers_cancel() is waiting for txtimer in
j1939_session_txtimer_cancel() (before j1939_session_rxtimer_cancel_sync()
increments session->rxtimer_cancelers), a concurrent j1939_tp_txtimer()
callback that fails prior to j1939_session_tx_send() (for instance with
-EOVERFLOW in j1939_session_tx_dat(), -ENOENT in j1939_session_tx_cts() or
j1939_session_tx_eoma(), or -ENOMEM in j1939_tp_tx_dat_new()) can call
j1939_session_cancel(), or a concurrent j1939_tp_rxtimer() callback can ent=
er
its non-simple timeout branch.

Because !session->tx_send_shutdown is only checked around j1939_xtp_tx_abor=
t()
inside __j1939_session_cancel() rather than gating the cancellation block in
j1939_session_cancel() and j1939_tp_rxtimer(), won't the timer callback sti=
ll:

1. rearm session->rxtimer for J1939_XTP_ABORT_TIMEOUT_MS via
   j1939_tp_set_rxtimeout_locked() (or record session->rxtimer_pending =3D =
true
   if rxtimer_cancelers is non-zero),
2. overwrite session->err with the local timer error and transition
   session->state to J1939_SESSION_WAITING_ABORT, and
3. immediately call j1939_sk_send_loop_abort(session->sk, session->err),
   waking session->sk with the wrong sk_err before j1939_xtp_rx_abort_one()
   sets session->err from the received ABORT frame and notifies the socket a
   second time?

Should j1939_session_cancel() and the timeout branch in j1939_tp_rxtimer()
check !session->tx_send_shutdown before rearming rxtimer and calling
__j1939_session_cancel()?

[ ... ]

> @@ -1460,6 +1498,9 @@ static enum hrtimer_restart j1939_tp_txtimer(struct=
 hrtimer *hrtimer)
>  		 * propagation of the error to user space.
>  		 */
>  		break;
> +	case -ESHUTDOWN:
> +		/* A terminal path won before this packet could be sent. */
> +		break;
>  	case -EOVERFLOW:
>  		j1939_session_cancel(session, J1939_XTP_ABORT_ECTS_TOO_BIG);
>  		break;

[Severity: Medium]
Here j1939_tp_txtimer() treats -ESHUTDOWN as an expected race with session
shutdown, but in j1939_tp_txtimer() -> j1939_xtp_txnext_transmiter() ->
j1939_session_tx_dat(), a -ESHUTDOWN return from j1939_tp_tx_dat() still hi=
ts
the error log check:

net/can/j1939/transport.c:j1939_session_tx_dat() {
	...
		ret =3D j1939_tp_tx_dat(session, dat, len + 1);
		if (ret < 0) {
			/* ENOBUFS =3D=3D CAN interface TX queue is full */
			if (ret !=3D -ENOBUFS)
				netdev_alert(priv->ndev,
					     "%s: 0x%p: queue data error: %i\n",
					     __func__, session, ret);
			break;
		}
}

Will a session shutdown racing with j1939_session_tx_dat() emit a spurious
netdev_alert() with -ESHUTDOWN (and still call j1939_tp_set_rxtimeout() if
pkt_done > 0 from earlier packets in the loop)?

> @@ -1558,6 +1599,7 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct=
 hrtimer *hrtimer)
>  		/* The message is probably stuck in the CAN controller and can
>  		 * be send as soon as CAN bus is in working state again.
>  		 */
> +		spin_lock_bh(&session->tx_send_lock);
>  		j1939_session_list_lock(priv);
>  		if (session->state >=3D J1939_SESSION_ACTIVE &&
>  		    session->state < J1939_SESSION_ACTIVE_MAX) {
>  			session->err =3D -ETIME;
>  			j1939_session_deactivate_locked(session);
>  		}
>  		j1939_session_list_unlock(priv);
> +		spin_unlock_bh(&session->tx_send_lock);
>  		j1939_session_txtimer_cancel_async(session);
>  		j1939_session_rxtimer_cancel(session);

[Severity: High]
Can this J1939_SIMPLE timeout path in j1939_tp_rxtimer() leak the session on
jsk->sk_session_queue and hang socket close when it races with
j1939_simple_txnext()?

In j1939_tp_txtimer() -> j1939_simple_txnext(), rxtimer is armed before
j1939_session_tx_send() is called, and j1939_sk_queue_activate_next(session)
is only called if j1939_session_tx_send() succeeds:

net/can/j1939/transport.c:j1939_simple_txnext() {
	...
	j1939_tp_set_rxtimeout(session, J1939_SIMPLE_ECHO_TIMEOUT_MS);

	ret =3D j1939_session_tx_send(session, skb);
	if (ret)
		goto out_free;

	j1939_sk_errqueue(session, J1939_ERRQUEUE_TX_SCHED);
	j1939_sk_queue_activate_next(session);
}

If j1939_tp_rxtimer() fires before j1939_session_tx_send() succeeds (either
between j1939_tp_set_rxtimeout() and j1939_session_tx_send(), or while txti=
mer
is retrying after j1939_session_tx_send() returned -ENOBUFS),
j1939_tp_rxtimer() transitions session->state to J1939_SESSION_DONE via
j1939_session_deactivate_locked() and cancels both timers without calling
j1939_sk_queue_activate_next(session).

When j1939_simple_txnext() then calls j1939_session_tx_send(), it sees
state !=3D J1939_SESSION_ACTIVE and returns -ESHUTDOWN, jumping to out_free
without calling j1939_sk_queue_activate_next(session), and j1939_tp_txtimer=
()
breaks out of its switch on -ESHUTDOWN.

Doesn't that leave session permanently queued on jsk->sk_session_queue with
its queue kref and jsk->skb_pending count held, stalling subsequent queued
sessions and causing j1939_sk_release() to block indefinitely waiting on
!j1939_sock_pending_get(&jsk->sk)?

>  	} else {
> +		spin_lock_bh(&session->tx_send_lock);
>  		j1939_session_list_lock(session->priv);
>  		if (!session->rxtimer_cancelers &&
>  		    session->state >=3D J1939_SESSION_ACTIVE &&
>  		    session->state < J1939_SESSION_ACTIVE_MAX) {
>  			netdev_alert(priv->ndev, "%s: 0x%p: rx timeout, send abort\n",
>  				     __func__, session);
>  			j1939_tp_set_rxtimeout_locked(session,
>  						      J1939_XTP_ABORT_TIMEOUT_MS);
>  			__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
>  		}
>  		j1939_session_list_unlock(session->priv);
> +		spin_unlock_bh(&session->tx_send_lock);
> =20
>  		if (!session->sk)
>  			j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);

[Severity: High]
In this branch of j1939_tp_rxtimer(), as well as in j1939_session_cancel() =
and
j1939_xtp_rx_abort_one(), the socket error notification outside the lock ru=
ns
unconditionally even when the state check (or !session->rxtimer_cancelers)
evaluates to false.

For example, when an RX session (!session->sk) completes in
j1939_xtp_rx_dat_one() (when final is true) and calls
j1939_session_timers_cancel() -> j1939_session_rxtimer_cancel_sync(),
session->rxtimer_cancelers is incremented while waiting for a running
j1939_tp_rxtimer() callback to finish. In j1939_tp_rxtimer(), the condition
!session->rxtimer_cancelers is false, so __j1939_session_cancel() is skipped
and session->err remains 0, but j1939_tp_rxtimer() still calls
j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT) after dropping the lock=
s.

Similarly, if j1939_session_cancel() or j1939_xtp_rx_abort_one() finds that
another path already transitioned session->state out of the active range, it
still invokes j1939_sk_errqueue() or j1939_sk_send_loop_abort().

Should these error notifications be gated on whether the caller actually won
the state transition?

> @@ -1671,6 +1716,8 @@ static void j1939_xtp_rx_abort_one(struct j1939_pri=
v *priv, struct sk_buff *skb,
>  		    session, j1939_xtp_ctl_to_pgn(skb->data), abort,
>  		    j1939_xtp_abort_to_str(abort));
> =20
> +	/* Stop TX callbacks before waiting for the timer callbacks to drain. */
> +	j1939_session_tx_send_shutdown(session);
>  	j1939_session_timers_cancel(session);
>  	j1939_session_list_lock(priv);
>  	if (session->state >=3D J1939_SESSION_ACTIVE &&

[Severity: Medium]
Here j1939_xtp_rx_abort_one() calls j1939_session_tx_send_shutdown(session)
before j1939_session_timers_cancel(session), because session->state is still
J1939_SESSION_ACTIVE while the timers are being drained.

However, the other paths that call j1939_session_timers_cancel(session) bef=
ore
deactivating or canceling the session do not call
j1939_session_tx_send_shutdown(session) first:

- j1939_xtp_rx_eoma_one() sets session->pkt.tx_acked =3D session->pkt.total,
  calls j1939_session_timers_cancel(session), and only then calls
  j1939_session_completed(session) -> j1939_session_deactivate().
- j1939_xtp_rx_dat_one() (both the final completion branch and
  out_session_cancel) calls j1939_session_timers_cancel(session) before
  j1939_session_completed(session) or j1939_session_cancel(session, abort).
- j1939_simple_recv() calls j1939_session_timers_cancel(session) before
  j1939_session_deactivate(session).
- j1939_xtp_rx_cts_one() (at out_session_cancel) and
  j1939_xtp_rx_rts_session_active() call j1939_session_timers_cancel(sessio=
n)
  before j1939_session_cancel().

While j1939_session_timers_cancel() is waiting for an in-flight
j1939_tp_txtimer() callback in those paths, both session->tx_send_shutdown =
is
false and session->state is J1939_SESSION_ACTIVE, so j1939_session_tx_send()
still allows packets through (and in j1939_xtp_rx_eoma_one(), a concurrent
j1939_tp_rxtimer() firing before rxtimer_cancelers is incremented can still
send an XTP ABORT frame on a completed session).

Should j1939_session_timers_cancel() itself call
j1939_session_tx_send_shutdown(session) (or should those callers shut down =
TX
sends before draining the timers)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793259424.gi=
t.zihanx@nebusec.ai?part=3D2
