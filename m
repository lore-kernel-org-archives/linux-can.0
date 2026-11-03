Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793684795;
	b=akxWOLE6QxhWa1TkEK4FeCext+lJdLQjq68cq5GRnXCgsK6dyCcy0NWciPeCcKbyrNmY
	 WB6oj6C34eu8NIahjtKfbchMVJzGgli+4p+leHKjkSTSGTjBOtmxc7zTi/atWB6TArs72
	 sT92HwSt8bhq5hgAPi4I11N61EeZIEeC+gEn0kVF2FgZASKvAAWh2YRDFFJoBUPkk3TaG
	 wCYU+wq3TpykLb6jAhMoFP6hyHsoTBpvPlnksMogj3KoHJEu2ApQ4ESLLj7y5AXcFoAoz
	 smUkvrFL+jUA6bm0ei2t+CGuOkuzG05Ddo84lj6fONLGve6pi/I6IU084fT7U7LxF5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793684795;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lM2PP5xK0rlPuxARzJXe0OJAu/cGnCfxTuw0IRZeedg=;
	b=XBAPOOL/QdkLEAtKAJY0lNI67qEQX1CBtRENUy/dlpR+T/1qLLg7vR0/0QQ0IVNKG48V
	 b9fDEq4UUTtZ1GPGnUhZ8GhzRXJfZp3tJc2Io+3qpMwRSlzBKVtIk+TJKWsX1v4GTyo8c
	 XoClzu+koezxQhj5XDcNC0ipACdE/85dt72Tme8K3kfmxltMItgBl7MZ1raN7t6iJyFab
	 IMYmOKez+DD+7JXehYSVj53tAB3eTL6p8NTlL8KnhvTXyrSZbsy84iMqYyuDdID9ArywH
	 SkoOGH38e/T1gKDbBj5ezwFn63j07x2q7l7VDe960qIC9uH2IG7Z4oFbw5HLwC3djgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bz1neshN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B80606A324
	for <linux-can@vger.kernel.org>; Tue,  3 Nov 2026 05:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bz1neshN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABFA1F000C1;
	Tue,  3 Nov 2026 05:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793684795;
	bh=lM2PP5xK0rlPuxARzJXe0OJAu/cGnCfxTuw0IRZeedg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bz1neshN5F4KgcVTQ0tLMkSF9vShoPKSya3zlJ+Ga3ZrvvpX8fm50z8WsybfSI4wh
	 /bUbfuke9VhTMVfBrdxMTqy3FH8/RAgtt/clQOUi6ClqNUVU5mv2dzOoN1NKCKV9fo
	 8JAftbt9pdTp1x+zUgMszfb1+5EvFJpPDrDE3ya/q3uhlngB2BaLmlyc1SgzjKKzUT
	 QnLpVDsatSpRnq9VhraEvKoliuqZ9GynC+PdN5RoeM3uJruwDr2fpQ47CnTNYjy2mW
	 MvgVc7bG8knqQRmQ/9pSRmwfhJYj2g9uhUI7PrEvXinJVWYbkIvSZ/18iFKqlaTPdz
	 a5BzQj7OeKqgw==
Message-ID: <sashiko-outbox-194597@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 3/3] can: j1939: serialize session TX with state
 changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zihan Xi" <zihanx@nebusec.ai>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <c7ce2c35e7d6a5097363b9b0ec69dabdc17a5326.1793681851.git.zihanx@nebusec.ai>
References: <cover.1793681851.git.zihanx@nebusec.ai>
 <c7ce2c35e7d6a5097363b9b0ec69dabdc17a5326.1793681851.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 05:46:32 +0000
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
- [High] can: j1939: rxtimer left armed on -ESHUTDOWN in j1939_simple_txnex=
t()
- [High] can: j1939: race between j1939_session_cancel() and j1939_tp_rxtim=
er()
- [High] can: j1939: rxtimer left armed on DONE session in duplicate RTS an=
d abort paths
- [High] can: j1939: reference leak in concurrent j1939_tp_set_rxtimeout() =
calls
- [Medium] can: j1939: j1939_session_tx_dat() logs alert and arms rxtimer o=
n -ESHUTDOWN
--

commit a6494e93c192c5af789ee93f88a46a4c6b3896d4
Author: Zihan Xi <zihanx@nebusec.ai>

can: j1939: serialize session TX with state changes

This commit adds a per-session tx_send_lock and tx_send_shutdown gate to
serialize J1939 session frame transmissions against terminal state
transitions. It also reorders RX abort timeout setup in j1939_session_cance=
l()
and updates simple session timeout handling.

Link: https://bugtracker.nebusec.ai/f/11143

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index c85d7bb3c12d4..7d6ed7fb8c56b 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c

[ ... ]

> @@ -730,12 +757,13 @@ static int j1939_tp_tx_dat(struct j1939_session *se=
ssion,
>  	if (j1939_tp_padding && len < 8)
>  		memset(skb_put(skb, 8 - len), 0xff, 8 - len);
> =20
> -	return j1939_send_one(priv, skb);
> +	return j1939_session_tx_send(session, skb);
>  }

[Severity: Medium]
When j1939_tp_tx_dat() returns -ESHUTDOWN in j1939_session_tx_dat() because=
 a
terminal state transition won, won't j1939_session_tx_dat() log a spurious
netdev_alert() and potentially re-arm session->rxtimer on the terminated
session?

In j1939_session_tx_dat():

	ret =3D j1939_tp_tx_dat(session, dat, len + 1);
	if (ret < 0) {
		/* ENOBUFS =3D=3D CAN interface TX queue is full */
		if (ret !=3D -ENOBUFS)
			netdev_alert(priv->ndev,
				     "%s: 0x%p: queue data error: %i\n",
				     __func__, session, ret);
		break;
	}
	...
	if (pkt_done)
		j1939_tp_set_rxtimeout(session, 250);

If an earlier loop iteration sent at least one packet (pkt_done > 0) before=
 a
subsequent iteration failed with -ESHUTDOWN, j1939_tp_set_rxtimeout() will
still run and re-arm session->rxtimer after the session has already left
J1939_SESSION_ACTIVE.

Similarly, in j1939_session_tx_rts(), j1939_session_tx_dpo(),
j1939_session_tx_cts(), and j1939_session_tx_eoma(), j1939_tp_set_rxtimeout=
()
is called after j1939_session_tx_send() drops session->tx_send_lock, where a
concurrent terminal transition can be overwritten by the new RX timeout.

[ ... ]

> @@ -1173,7 +1203,7 @@ static int j1939_simple_txnext(struct j1939_session=
 *session)
> =20
>  	j1939_tp_set_rxtimeout(session, J1939_SIMPLE_ECHO_TIMEOUT_MS);
> =20
> -	ret =3D j1939_send_one(priv, skb);
> +	ret =3D j1939_session_tx_send(session, skb);
>  	if (ret)
>  		goto out_free;

[Severity: High]
What happens to session->rxtimer if j1939_session_tx_send() returns -ESHUTD=
OWN
here in j1939_simple_txnext()?

If j1939_tp_txtimer() passes its initial J1939_SESSION_ACTIVE check and a
concurrent j1939_cancel_active_session() transitions the session to
J1939_SESSION_DONE before j1939_simple_txnext() runs, j1939_simple_txnext()
arms session->rxtimer for J1939_SIMPLE_ECHO_TIMEOUT_MS (10 seconds) and gra=
bs
a session reference before j1939_session_tx_send() rejects the packet with
-ESHUTDOWN.

In j1939_tp_txtimer(), the new -ESHUTDOWN case breaks out of the switch
without calling j1939_session_rxtimer_cancel(session), unlike the -ENOBUFS
retry-exhaustion and default error branches:

	case -ESHUTDOWN:
		/* A terminal state transition won before the frame was sent. */
		break;

Since no frame was sent and the session is already unlinked from
priv->active_session_list, won't session->rxtimer remain armed for 10 secon=
ds,
pinning the session, socket, and net_device, and then fire j1939_tp_rxtimer=
()
to log a false timeout alert and overwrite session->err with -ETIME?

[ ... ]

> @@ -1261,19 +1302,36 @@ static void j1939_session_cancel(struct j1939_ses=
sion *session,
> =20
>  	if (session->state >=3D J1939_SESSION_ACTIVE &&
>  	    session->state < J1939_SESSION_WAITING_ABORT) {
> -		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
> -		__j1939_session_cancel(session, err);
> -		spin_lock(&session->txtimer_lock);
> -		session->txtimer_shutdown =3D true;
> -		spin_unlock(&session->txtimer_lock);
> -		cancelled =3D true;
> +		bool tx_send_shutdown;
> +
> +		spin_lock(&session->tx_send_lock);
> +		tx_send_shutdown =3D session->tx_send_shutdown;
> +		spin_unlock(&session->tx_send_lock);
> +		if (!tx_send_shutdown) {
> +			cancelled =3D __j1939_session_cancel(session, err);
> +			if (cancelled) {
> +				spin_lock(&session->txtimer_lock);
> +				session->txtimer_shutdown =3D true;
> +				spin_unlock(&session->txtimer_lock);
> +			}
> +		}
>  	}
> =20
>  	j1939_session_list_unlock(session->priv);
> -	if (cancelled)
> +	if (cancelled) {
> +		bool keep_rxtimer;
> +
> +		/* Do not wait for the RX timer while holding the session-list lock. */
> +		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
> +		j1939_session_list_lock(session->priv);
> +		keep_rxtimer =3D session->state =3D=3D J1939_SESSION_WAITING_ABORT;
> +		j1939_session_list_unlock(session->priv);
> +		if (!keep_rxtimer)
> +			j1939_session_rxtimer_cancel(session);
>  		j1939_session_txtimer_cancel_async(session);
> +	}

[Severity: High]
Can calling j1939_tp_set_rxtimeout() here outside active_session_list_lock
before cancelling txtimer race with a concurrent j1939_tp_set_rxtimeout() c=
all
and leak a session reference?

j1939_tp_set_rxtimeout() performs an unlocked cancel-get-start sequence:

	j1939_session_rxtimer_cancel(session);
	j1939_session_get(session);
	hrtimer_start(&session->rxtimer, ms_to_ktime(msec),
		      HRTIMER_MODE_REL_SOFT);

Because j1939_session_timers_cancel() was removed from the RX error callers
and txtimer is only cancelled asynchronously after j1939_tp_set_rxtimeout(),
an in-flight j1939_tp_txtimer() callback that just completed
j1939_session_tx_send() (or a concurrent RX path) can call
j1939_tp_set_rxtimeout() concurrently with j1939_session_cancel(). If both
callers pass j1939_session_rxtimer_cancel() before either calls
hrtimer_start(), both increment session->kref and the second hrtimer_start()
overwrites the first without dropping its reference, leaking struct
j1939_session, the socket reference, and the net_device tracker.

Also, in the keep_rxtimer check above, what if j1939_xtp_rx_abort_one() runs
concurrently? In j1939_xtp_rx_abort_one():

	j1939_session_timers_cancel(session);
	j1939_session_deactivate_activate_next(session);

If j1939_xtp_rx_abort_one() finishes j1939_session_timers_cancel() (which s=
ets
tx_send_shutdown =3D true and cancels rxtimer) before j1939_session_cancel()
calls j1939_tp_set_rxtimeout(), and j1939_session_cancel() checks keep_rxti=
mer
before j1939_session_deactivate_activate_next() updates session->state to
J1939_SESSION_DONE, keep_rxtimer will evaluate to true because session->sta=
te
is still J1939_SESSION_WAITING_ABORT, leaving rxtimer armed on a DONE sessi=
on.
Should keep_rxtimer also verify that session->tx_send_shutdown is false?

[ ... ]

> @@ -1403,7 +1464,7 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct=
 hrtimer *hrtimer)
>  		 * be send as soon as CAN bus is in working state again.
>  		 */
>  		session->err =3D -ETIME;
> -		j1939_session_deactivate(session);
> +		j1939_session_deactivate_activate_next(session);
>  	} else {
>  		j1939_session_list_lock(session->priv);
>  		if (session->state >=3D J1939_SESSION_ACTIVE &&
> @@ -1414,14 +1475,15 @@ static enum hrtimer_restart j1939_tp_rxtimer(stru=
ct hrtimer *hrtimer)
>  			hrtimer_start(&session->rxtimer,
>  				      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
>  				      HRTIMER_MODE_REL_SOFT);
> -			__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
> -			cancelled =3D true;
> +			cancelled =3D
> +				__j1939_session_cancel(session,
> +						       J1939_XTP_ABORT_TIMEOUT);
>  		}
>  		j1939_session_list_unlock(session->priv);
>  		if (cancelled)
>  			j1939_session_txtimer_cancel_async(session);
> =20
> -		if (!session->sk)
> +		if (cancelled && !session->sk)
>  			j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
>  	}

[Severity: High]
Could moving j1939_tp_set_rxtimeout() outside active_session_list_lock in
j1939_session_cancel() race with j1939_tp_rxtimer() here in two ways?

First, in j1939_session_cancel(), __j1939_session_cancel() sets session->st=
ate
to J1939_SESSION_WAITING_ABORT before the old rxtimer is cancelled in
j1939_tp_set_rxtimeout(). If the pre-existing rxtimer expires in that windo=
w,
j1939_tp_rxtimer() sees:

	if (session->state =3D=3D J1939_SESSION_WAITING_ABORT) {
		netdev_alert(priv->ndev, "%s: 0x%p: abort rx timeout. Force session deact=
ivation\n",
			     __func__, session);

		j1939_session_deactivate_activate_next(session);

and immediately deactivates the session instead of waiting for the 500ms ab=
ort
timeout.

Second, if j1939_tp_rxtimer() passes that initial check while session->state
is still J1939_SESSION_ACTIVE and spins on j1939_session_list_lock() while
j1939_session_cancel() sets session->state =3D J1939_SESSION_WAITING_ABORT,
then once j1939_session_cancel() drops the lock, j1939_tp_rxtimer() checks:

	if (session->state >=3D J1939_SESSION_ACTIVE &&
	    session->state < J1939_SESSION_ACTIVE_MAX)

Since J1939_SESSION_WAITING_ABORT is less than J1939_SESSION_ACTIVE_MAX and
tx_send_shutdown is still false, won't j1939_tp_rxtimer() call
__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT) a second time,
overwriting session->err with EHOSTUNREACH and sending a second ABORT frame?

Also, right above __j1939_session_cancel() in j1939_tp_rxtimer(),
j1939_session_get(session) and hrtimer_start(&session->rxtimer, ...) are
called unconditionally before checking whether __j1939_session_cancel()
returns true. If __j1939_session_cancel() returns false because
session->tx_send_shutdown is set, doesn't that re-arm session->rxtimer with=
 a
new reference on a session that has already shut down?

[ ... ]

> @@ -1852,7 +1916,6 @@ static int j1939_xtp_rx_rts_session_active(struct j=
1939_session *session,
>  			return -EBUSY;
> =20
>  		/* RTS on active session */
> -		j1939_session_timers_cancel(session);
>  		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
>  	}
> =20
> @@ -1862,7 +1925,6 @@ static int j1939_xtp_rx_rts_session_active(struct j=
1939_session *session,
>  			     __func__, session, skcb->addr.sa, skcb->addr.da,
>  			     session->last_cmd);
> =20
> -		j1939_session_timers_cancel(session);
>  		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
>  		if (session->transmission) {
>  			j1939_session_deactivate_activate_next(session);

[Severity: High]
In j1939_xtp_rx_rts_session_active(), when session->last_cmd !=3D 0, does
removing j1939_session_timers_cancel() leave session->rxtimer armed after t=
he
session is deactivated right below?

	if (session->last_cmd !=3D 0) {
		...
		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
		if (session->transmission) {
			j1939_session_deactivate_activate_next(session);
		} else if (session->state =3D=3D J1939_SESSION_WAITING_ABORT) {
			j1939_session_deactivate_activate_next(session);
		}

		return -EBUSY;
	}

Previously, j1939_session_timers_cancel() stopped the timers, and on a
receiver session (!session->transmission) the first j1939_session_cancel() =
put
the session into J1939_SESSION_WAITING_ABORT so the second
j1939_session_cancel() was a no-op after the second j1939_session_timers_ca=
ncel()
cancelled the abort timer.

With j1939_session_timers_cancel() removed, j1939_session_cancel() transiti=
ons
the session to J1939_SESSION_WAITING_ABORT and starts session->rxtimer for
500ms, and then j1939_session_deactivate_activate_next() immediately moves =
the
session to J1939_SESSION_DONE and unlinks it from priv->active_session_list
without cancelling session->rxtimer. Won't that leave session->rxtimer armed
with an active reference on a DONE session?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793681851.gi=
t.zihanx@nebusec.ai?part=3D3
