Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379502;
	b=exJlCIC6d0VEwfcmyOTVBHnyCvdzdKm6Be3r0dfpjjOcWX9MwAyWAbwtGT787l0NNlVM
	 cb7ILU+EwqiV+bOWzQ6UeXROw3mJoRe80z5pYk2a79t9UQlE1e/6RpslxxUj79GyXY0LG
	 Eio+pxGzkDuCilkswKc6aXGAY895u6mFpPy6CeRrpXCTO9+LLdotS+VyeklNZ4x+ULR/v
	 VK8+SdvzU2APHlVjRNuxygsz+ENiyA412ZK0UCyz2BZsyxW0Fl7YrAlHnP+UG75KDSoRn
	 pEE4tGTWwi3Gn1MKYGfP//8tHQ0GzCXNHyyO5wBu4C773BMiGa/mVv0cMOA+Hu/IWWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379502;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l7THpzVuDyIIO3DJL/xTwV1U2+257gony2lsQBM6eAg=;
	b=GKu80/QF8TzRlm3yWNy6wRAZIy26MO+5ZZ/skSudqbkZVKLRA4/SHqJO+9fC3CWTAytq
	 dWYxpQWJIe0WWEMdMDPrZnqGXBBNBlCd1YOivCa/tcjanmvjxoAEnsL1+O7ud/mOg8K+k
	 3cGVGN9xKhnqOqXheKT0+URzUgMvHestIJUq0ykzY16p+wm0556/lq0oFj2hkAm1GM53n
	 QkPdovXVKu4bOZ/oIDhf0X/4m4KrWMnttIOR8edtDKet/JC3m/WiDAbvEBWPBS8lldJ+A
	 HLAWbnjWXaZOSK+7NxfOlYn/2q7Z4CpnAMXhN96Qqk58Gk/Lx4cXSjbqnukwMqSXGyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fg9Kk2hN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67551606A321
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fg9Kk2hN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E418A1F00A06;
	Wed, 11 Nov 2026 06:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794379502;
	bh=l7THpzVuDyIIO3DJL/xTwV1U2+257gony2lsQBM6eAg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fg9Kk2hNkoD/wsnU0BOuV6dJk6QnT//AfbtfKYknN/Zp8lHb1To0tmvROcv7lWq4y
	 yDh+KmqME2c2hNyhsnR/ZQI0744YvyjgNkm7pB93nOVtLoHzHu8z0qY1wYIK6YlIUu
	 DfpJmaDGEThERl0GMuqMyjVONtpjthQznKvFkQusKlfnJgzCjUIwP8Ixg3kCt8Joxp
	 WTYiaK+73dirM2Lgv3foRmhFWRS54yBiVxLN7A32MFGJJNt7SXiRjgmSx/rCicxiVB
	 lF2miZ8CWLIprpMPb/DU7yRVdZUGcRQJTNfSyFgK+ukki6x1DLMavR8eG4uQ9/iDqU
	 e/gG4ZqMdLpYQ==
Message-ID: <sashiko-outbox-208458@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v7 1/4] can: j1939: arm the abort timer under the
 session list lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chaosheng Qu" <quchaosheng000406@163.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <179410166345.60581.16722127854597502548@163.com>
References: <179410166344.60581.3898011861151549156@163.com>
 <179410166345.60581.16722127854597502548@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:45:01 +0000
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
- [High] can: j1939: race in j1939_session_cancel() double-arms rxtimer
  and leaks session
- [Medium] can: j1939: j1939_session_cancel() leaves rxtimer armed on
  deactivated session
- [Low] can: j1939: missing Fixes trailer for commit d966635b384b
--

commit d2f1f6071a930db192083744d44435260ec61c4f
Author: Chaosheng Qu <quchaosheng000406@163.com>

> can: j1939: arm the abort timer under the session list lock
>
> j1939_session_cancel() cancels the receive timer while holding
> active_session_list_lock.  hrtimer_cancel() waits for a callback that is
> already running, and j1939_tp_rxtimer() takes the same lock, so a softirq
> callback waiting for the lock deadlocks against the CPU that holds it.
> Cancel the timer before taking the lock instead.
>
> Cancelling outside the lock opens a second window: the cancel/get/start
> sequence is no longer atomic against j1939_tp_set_rxtimeout(), which rear=
ms
> the same timer from the receive path without holding the lock.  A
> concurrent
> arm in that window queues a timer whose reference is never dropped, and t=
he
> session then never reaches j1939_session_destroy(), keeping both its netd=
ev
> and its j1939_priv reference alive.  Take the lock for the rearms so both
> armers are serialized; hrtimer_start() does not wait for a callback, so it
> is safe to call while holding it.
>
> A session that is already in J1939_SESSION_WAITING_ABORT also gets its
> timer
> back.  A second unparsable frame re-enters j1939_session_cancel() after
> j1939_session_timers_cancel() has killed the timer, and without a rearmed
> timer nothing ever moves that session out of WAITING_ABORT, so
> unregistering
> the device hangs in unregister_netdevice().
>
> The reference accounting stays balanced: one j1939_session_get() per
> hrtimer_start(), dropped by j1939_session_put() in j1939_tp_rxtimer() when
> the timer fires.
>
> Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>

[Severity: Low]
This fixes the locking and timer re-arming in j1939_session_cancel().
Should this include:

  Fixes: d966635b384b ("can: j1939: transport: make sure the aborted sessio=
n will be deactivated only once")

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..590a04c453b56 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1161,12 +1161,38 @@ static void __j1939_session_cancel(struct j1939_s=
ession *session,
>  static void j1939_session_cancel(struct j1939_session *session,
>  				 enum j1939_xtp_abort err)
>  {
> +	bool abort_sent =3D false;
> +
> +	/* Cancel the abort timer before taking the list lock.
> +	 *
> +	 * hrtimer_cancel() waits for a callback that is already running, and
> +	 * j1939_tp_rxtimer() takes the same lock, so cancelling the timer while
> +	 * holding active_session_list_lock can deadlock: the lock holder waits
> +	 * for the callback, the callback waits for the lock.
> +	 */
> +	j1939_session_rxtimer_cancel(session);
> +
>  	j1939_session_list_lock(session->priv);
> =20
>  	if (session->state >=3D J1939_SESSION_ACTIVE &&
>  	    session->state < J1939_SESSION_WAITING_ABORT) {
> -		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
>  		__j1939_session_cancel(session, err);
> +		abort_sent =3D true;
>  	}
> +
> +	/* Re-arm under the lock, whether the abort frame just went out or the
> +	 * session is already in WAITING_ABORT and only needs its timer back.
> +	 *
> +	 * hrtimer_start() does not wait for a running callback, so arming here
> +	 * cannot deadlock, and taking the lock closes the window against
> +	 * j1939_tp_set_rxtimeout(), which rearms the same timer from the
> +	 * receive path without holding it.
> +	 */

[Severity: High]
Can a concurrent timer arm between j1939_session_rxtimer_cancel() and
hrtimer_start() leak a session reference?

j1939_tp_set_rxtimeout() does not acquire active_session_list_lock, so
taking the lock here does not serialize the two paths.  Even between two
concurrent j1939_session_cancel() callers (for example from
j1939_tp_txtimer() and j1939_tp_recv()), both cancel rxtimer before taking
the lock:

CPU0                                  CPU1
j1939_session_cancel()
  j1939_session_rxtimer_cancel()
                                      j1939_session_cancel()
                                        j1939_session_rxtimer_cancel()
  j1939_session_list_lock()
  session->state =3D ..._WAITING_ABORT
  j1939_session_get(session)
  hrtimer_start(&session->rxtimer)
  j1939_session_list_unlock()
                                        j1939_session_list_lock()
                                        /* state =3D=3D WAITING_ABORT */
                                        j1939_session_get(session)
                                        hrtimer_start(&session->rxtimer)
                                          <-- re-queues armed timer, leaks =
ref

Calling hrtimer_start() on an already-queued rxtimer replaces it in place
without dropping the previous reference, so session->kref never reaches zero
and unregister_netdevice() hangs waiting for the leaked netdev reference.

> +	if (abort_sent || session->state =3D=3D J1939_SESSION_WAITING_ABORT) {
> +		j1939_session_get(session);
> +		hrtimer_start(&session->rxtimer,
> +			      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
> +			      HRTIMER_MODE_REL_SOFT);
> +	}

[Severity: Medium]
Does re-arming session->rxtimer when session->state is already
J1939_SESSION_WAITING_ABORT leave rxtimer running on a deactivated session =
in
j1939_xtp_rx_rts_session_active()?

When a duplicate RTS frame arrives on an active session with
session->last_cmd !=3D 0, j1939_xtp_rx_rts_session_active() cancels and
immediately deactivates the session:

net/can/j1939/transport.c:j1939_xtp_rx_rts_session_active() {
    ...
		j1939_session_timers_cancel(session);
		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
		if (session->transmission) {
			j1939_session_deactivate_activate_next(session);
		} else if (session->state =3D=3D J1939_SESSION_WAITING_ABORT) {
			...
			j1939_session_deactivate_activate_next(session);
		}
}

With this change, j1939_session_cancel() re-arms rxtimer, and
j1939_session_deactivate_activate_next() then sets session->state to
J1939_SESSION_DONE and removes the session from priv->active_session_list
without cancelling rxtimer.  When rxtimer fires 500ms later on the
J1939_SESSION_DONE session, j1939_tp_rxtimer() takes the else branch and
sends a duplicate J1939_ERRQUEUE_RX_ABORT notification.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179410166344.60581.=
3898011861151549156@163.com?part=3D1
