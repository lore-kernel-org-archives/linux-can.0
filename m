Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792656216;
	b=qel9Od66QsDp0aCDpUU9BOfG4H3X3BJPkeCNuRLSqv/BiYqCku92auzTmhkLCQG59bqY
	 an+6cvFWUmt10jdr9ppgob5WelLagflyq2UgstGPvn8pMPaRHUFctB3QcI3ACmIcBe2zd
	 2jXCa1i+rfreZLGF2VGji1qjX7Ef+m05uZl4U/LS8X3lD969vk+fGAPH1flCD8hx7JPii
	 vRmAsnxG7gIVoPqRMFnWqUnMDvSO/mkcVLTWimrH6/kraf/T+qCTjv06RpDTw/cabssfX
	 YuUeKKLn3nq+9LC2plK7LhvJ8z7bDd5fnmKBl5oVARlGpx32luNpopi6/kuJHGGqH4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792656216;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pC9Lx1W2Q8rGV5uVdOMy310EDsBgzPcP/cwOlSKI+4c=;
	b=HpHlYzXx8c+/XKsniqB+lXZCqjg5LH7N0JPr9xeYJt0LJYbStAbk0+1pnE2zPLLIia2+
	 /vgW2G2G1WGnJpVi9jIUxfo7LslsnjP5MA7ox69X4Y4fTus7LEMpZtx9Sm+9GxEIydjNg
	 nRFrAfVrM2TWoH2+GHi4RePO7hd049BUEeaIgdWcMZAkwIMYLlkuq1jDcLnAcz7mn8fnW
	 1bkrdhDXyvHe49Eps8Krt4StYpX+SoKCz4EWSn030oD7zo5YdeBE0AwnnR55Q2lw+8nkQ
	 6UBPfKxiXhoxY07mQiZx0ZkcsiAKwtKUdAf9AxxE7RT2+PJWTnZnmSzbipCqb4ttuuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YW174poN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F62606A319
	for <linux-can@vger.kernel.org>; Thu, 22 Oct 2026 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YW174poN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320E01F000C1;
	Thu, 22 Oct 2026 08:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792656215;
	bh=pC9Lx1W2Q8rGV5uVdOMy310EDsBgzPcP/cwOlSKI+4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YW174poNYBc6JbZFyEeTExjBqgzHqqWWjCpuJY3tkqtHsfu9QRb4SU7f9u/BWqN83
	 VXnRwFh2Pe9ED+aWqOO7VZTthh2W05iW5ezvhN8j+6swC/5tjOsRUNbAIT+6KnW793
	 j33nRMKHHopJyeRa8n+CEl3RJ/QiNfohjLxTZ/tVCTEspxG4m2m2oKNQc5MbhAG7at
	 nc/1s2sc7gniOZMR2T7JmMUrsa+x4wAn29NNrxFFqaUXT4AKOmEwutOrBGNzQAbUO+
	 CE91avv+FKLcCEsjorM8SAqswigOnW4OrsSj2lAyFDAosW6wUKzREt4Muy25EqPAMQ
	 oGm2tQbbId+tA==
Message-ID: <sashiko-outbox-181151@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v6 1/1] can: j1939: validate the EDPO packet number
Reply-To: sashiko-reviews@lists.linux.dev
To: Quchaosheng <quchaosheng000406@163.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <179265494813.314254.14725785769836234084@163.com>
References: <179265494813.314254.14725785769836234084@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 08:03:34 +0000
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
- [High] can: j1939: race on rxtimer and state in j1939_session_cancel()
--

commit c1bc44e269c86cae99ab16d5fb0f92e924343f7e
Author: Quchaosheng <quchaosheng000406@163.com>

can: j1939: validate the EDPO packet number

This commit validates the peer-controlled packet offset in ETP.CM_DPO frames
against session->pkt.total and adds a NULL skb check in
j1939_session_completed(). It also updates j1939_session_cancel() to cancel
rxtimer before taking active_session_list_lock and to deactivate sessions
already in J1939_SESSION_WAITING_ABORT.

Link: https://sashiko.dev/#/patchset/20260928193312.553632-1-mkl@pengutroni=
x.de?part=3D3

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..2cc6c46c4d50b 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1161,18 +1161,39 @@ static void __j1939_session_cancel(struct j1939_s=
ession *session,
>  static void j1939_session_cancel(struct j1939_session *session,
>  				 enum j1939_xtp_abort err)
>  {
> +	bool waiting;
> +
> +	/* Cancel the rxtimer before taking the list lock: hrtimer_cancel()
> +	 * waits for a running callback, and j1939_tp_rxtimer() takes the
> +	 * same lock.
> +	 */
> +	j1939_session_rxtimer_cancel(session);
>  	j1939_session_list_lock(session->priv);
> =20
> +	waiting =3D session->state =3D=3D J1939_SESSION_WAITING_ABORT;
>  	if (session->state >=3D J1939_SESSION_ACTIVE &&
>  	    session->state < J1939_SESSION_WAITING_ABORT) {
> -		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
>  		__j1939_session_cancel(session, err);
> +		/* hrtimer_start() does not wait for the callback, so arming
> +		 * the abort timer here cannot deadlock.
> +		 */
> +		j1939_session_get(session);
> +		hrtimer_start(&session->rxtimer,
> +			      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
> +			      HRTIMER_MODE_REL_SOFT);
>  	}
> =20
>  	j1939_session_list_unlock(session->priv);
> =20
>  	if (!session->sk)
>  		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
> +
> +	/* The abort went out on an earlier call, and this caller has just
> +	 * cancelled the timer that would have finished the session off, so
> +	 * nothing else is left to deactivate it.
> +	 */
> +	if (waiting)
> +		j1939_session_deactivate_activate_next(session);
>  }

[Severity: High]
In j1939_session_cancel(), j1939_session_rxtimer_cancel(session) is called
before acquiring active_session_list_lock, while session->rxtimer is re-arm=
ed
and waiting is evaluated under that lock.

Can this window between cancelling session->rxtimer and acquiring
active_session_list_lock introduce two races with concurrent receive packet
processing or a concurrent j1939_session_cancel() call?

First, receive handlers such as j1939_xtp_rx_dat_one(),
j1939_xtp_rx_cts_one(), and j1939_xtp_rx_dpo_one() call
j1939_tp_set_rxtimeout(session, ...) without holding active_session_list_lo=
ck.
If another processor calls j1939_tp_set_rxtimeout() after
j1939_session_rxtimer_cancel() returns here, but before
active_session_list_lock is acquired:

  j1939_session_cancel()
    j1939_session_rxtimer_cancel(session);
                                         j1939_tp_set_rxtimeout()
                                           j1939_session_rxtimer_cancel(ses=
sion);
                                           j1939_session_get(session);
                                           hrtimer_start(&session->rxtimer,=
 ...);
    j1939_session_list_lock(session->priv);
    __j1939_session_cancel(session, err);
    j1939_session_get(session);
    hrtimer_start(&session->rxtimer, ...);

Doesn't hrtimer_start() in j1939_session_cancel() re-enqueue session->rxtim=
er
while it is already armed, overwriting it without dropping the reference
taken by j1939_tp_set_rxtimeout() and permanently leaking session->kref
(which also holds a netdev reference on priv->ndev and blocks
unregister_netdevice())?

Second, if two callers concurrently enter j1939_session_cancel() on the same
session (for example, j1939_tp_txtimer() racing with an incoming packet),
both can execute j1939_session_rxtimer_cancel(session) before either acquir=
es
active_session_list_lock:

  j1939_session_cancel()                 j1939_session_cancel()
    j1939_session_rxtimer_cancel()         j1939_session_rxtimer_cancel()
    j1939_session_list_lock()
    __j1939_session_cancel()
      session->state =3D J1939_SESSION_WAITING_ABORT;
    j1939_session_get(session);
    hrtimer_start(&session->rxtimer, ...);
    j1939_session_list_unlock()
                                           j1939_session_list_lock()
                                           waiting =3D session->state =3D=3D
                                             J1939_SESSION_WAITING_ABORT;
                                           j1939_session_list_unlock()
                                           if (waiting)
                                             j1939_session_deactivate_activ=
ate_next()

Wouldn't the second caller observe waiting as true and call
j1939_session_deactivate_activate_next(session) even though its
j1939_session_rxtimer_cancel() ran before the first caller armed the abort
timer, removing the session from priv->active_session_list while
session->rxtimer remains armed?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179265494813.314254=
.14725785769836234084@163.com?part=3D1
