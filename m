Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793685250;
	b=WlP1OEgwyX+b5ErWAS3krcxGCttqZkdwXQ04pdrj2VPa2Kl6g1RW6s59T7ZqdrmixhDB
	 attKE0l8mAbpZrKTsZxPR7nfuE3oDMBMzKT4n846L1zLf2BGZVlIXMOKKN/LtuZTeB7B2
	 UGQAvoZdB/XtrvG4JCpw/NG8DU4brTiDGGJmOaZcytPX3mnU/aPCftkZoFlAgJO2Rq7uf
	 vf4CSQwFt0PEc5Q2aYTD8Ex4mESQGUwQH/67NX3e9by4mz2sNm0t3jzxJpbEDPZlVx0C8
	 DOB2XuUr/0GmWXvCvWIXxAcudTQJ0UkxlptRHpcQ2fakexfrvhnBXXlwq+ORYsXDZ4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793685250;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2ChYdBMPDWCKTiaRT4HcEq79TK5vVb+kLsZlIznS30g=;
	b=Sj0P6Tjg551vLnbBhNubfKHNKTr4ZpoDr5NwsUsJU+67xIcry69FaKn50GfEt06V9/S+
	 g9nBiaNs1VgDfPR9txgsNsnj6NSIR+W/DX0kfftuZBkzPXdHKwH2yMZfz4RPRnJoQlQqE
	 IH7tFYVOiMM1fqznDBp2uzg2muNk0YodEUGEz9qoYyyUUI6b8hf3J6pjHd8Z1194/lJRu
	 fpkcyLbstFqZvgXz3RqvVm3uCBuE7KPoyKRStDc+NR3SlVUOfefK6+GyFJHyUfcke8dTm
	 CaXg/Q6VlE2zzl39Ep/SLa3xMv8K7lZ1qD7dh9XUkTgy1mVmbLjdlWVQmzoidYPfkPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkA2XNBR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43119606A32C
	for <linux-can@vger.kernel.org>; Tue,  3 Nov 2026 05:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkA2XNBR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05641F000C1;
	Tue,  3 Nov 2026 05:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793685250;
	bh=2ChYdBMPDWCKTiaRT4HcEq79TK5vVb+kLsZlIznS30g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kkA2XNBRI3yNBHfgqEiIDB1Pix7Qs2rmVNkpnNmbCUg+/LCFBV0OoXc4vOJTJeA/M
	 +S/dUAlCrp5s4zMN1T4OB5ZW07zDDMBZsYGLB8m50KQ+kkrZqLnpwyB/u8TUZO6KgC
	 frGzfnAHnV7Acl5jcSyiLJW80ABI3BWMZaOuFwTXuJDxOYmRaqtXQ8D8TGAiD4SnyU
	 ecG8YH2Gk5YWXrmJKyplCUfLpRPQvWwCOltyEoBhsMoeiFL56jpL1qJV8JLFNuTooY
	 /FxUmVH0ofevyveqlM6TWui6ZlQ6cj4Ihu8TmxfW7cR+0lnU3OIxQjZXhhW754iqxS
	 Zuz0uLdSjRq2w==
Message-ID: <sashiko-outbox-194600@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 2/3] can: j1939: cancel TX timer after RX timeout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zihan Xi" <zihanx@nebusec.ai>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <02b6632da2b01b51edbe4c7b794ca3c473bfd559.1793681851.git.zihanx@nebusec.ai>
References: <cover.1793681851.git.zihanx@nebusec.ai>
 <02b6632da2b01b51edbe4c7b794ca3c473bfd559.1793681851.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 05:54:09 +0000
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
) drops kref
--

commit 6ad432b9ff1c3b364014147532b4d663b71e57c7
Author: Zihan Xi <zihanx@nebusec.ai>

can: j1939: cancel TX timer after RX timeout

This commit cancels a J1939 session's TX timer asynchronously via
j1939_session_txtimer_cancel_async() when an RX timeout moves an active
session to J1939_SESSION_WAITING_ABORT in j1939_tp_rxtimer().

Link: https://bugtracker.nebusec.ai/f/11143

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 4958f7c47ca44..c85d7bb3c12d4 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1387,6 +1387,7 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct=
 hrtimer *hrtimer)
>  						     struct j1939_session,
>  						     rxtimer);
>  	struct j1939_priv *priv =3D session->priv;
> +	bool cancelled =3D false;
> =20
>  	if (session->state =3D=3D J1939_SESSION_WAITING_ABORT) {
>  		netdev_alert(priv->ndev, "%s: 0x%p: abort rx timeout. Force session de=
activation\n",
> @@ -1414,8 +1415,11 @@ static enum hrtimer_restart j1939_tp_rxtimer(struc=
t hrtimer *hrtimer)
>  				      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
>  				      HRTIMER_MODE_REL_SOFT);
>  			__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
> +			cancelled =3D true;
>  		}
>  		j1939_session_list_unlock(session->priv);
> +		if (cancelled)
> +			j1939_session_txtimer_cancel_async(session);

[Severity: Critical]
Can calling j1939_session_txtimer_cancel_async() here race with a concurrent
j1939_session_txtimer_cancel() and re-arm session->txtimer without holding a
session kref, leading to a use-after-free of struct j1939_session?

Specifically, j1939_session_txtimer_cancel_async() calls
j1939_session_txtimer_cancel_async_locked():

net/can/j1939/transport.c:j1939_session_txtimer_cancel_async_locked() {
	lockdep_assert_held(&session->txtimer_lock);
	session->txtimer_shutdown =3D true;
	ret =3D hrtimer_try_to_cancel(&session->txtimer);
	/* Let a queued successor finish promptly after callback exit. */
	if (ret < 0 && session->txtimer_ref &&
	    hrtimer_is_queued(&session->txtimer))
		hrtimer_start(&session->txtimer, 0, HRTIMER_MODE_REL_SOFT);
	...
}

While j1939_session_txtimer_cancel() waits for a running callback outside
session->txtimer_lock:

net/can/j1939/transport.c:j1939_session_txtimer_cancel() {
	...
	/* Never wait for a softirq callback while holding txtimer_lock. */
	if (ret < 0) {
		ret =3D hrtimer_cancel(&session->txtimer);
		if (ret =3D=3D 1) {
			spin_lock_bh(&session->txtimer_lock);
			if (!WARN_ON_ONCE(!session->txtimer_ref)) {
				session->txtimer_ref =3D false;
				put_ref =3D true;
			}
			spin_unlock_bh(&session->txtimer_lock);
		}
	}
	...
}

Consider the following sequence across three CPUs when an RX timeout occurs
while j1939_tp_txtimer() is completing and a synchronous cancellation (for
example via j1939_xtp_rx_abort_one() on the abort frame sent by
__j1939_session_cancel(), or via an incoming CTS/RTS frame) runs
concurrently:

1. On CPU 0, j1939_tp_txtimer() is running, has queued a successor via
   j1939_tp_schedule_txtimer() (so session->txtimer is queued and
   session->txtimer_ref is true), releases session->txtimer_lock, and is
   about to finish __run_hrtimer().

2. On CPU 1, j1939_session_txtimer_cancel() increments
   session->txtimer_cancelers, sees hrtimer_try_to_cancel() return -1 becau=
se
   CPU 0 has not cleared base->running yet, drops session->txtimer_lock, and
   calls hrtimer_cancel(&session->txtimer).

3. On CPU 2, j1939_tp_rxtimer() calls j1939_session_txtimer_cancel_async(),
   which acquires session->txtimer_lock and enters
   j1939_session_txtimer_cancel_async_locked(). It also sees
   hrtimer_try_to_cancel() return -1 while CPU 0 is still in __run_hrtimer(=
),
   and evaluates ret < 0 && session->txtimer_ref &&
   hrtimer_is_queued(&session->txtimer) as true without checking
   session->txtimer_cancelers.

4. CPU 0 finishes __run_hrtimer() and clears base->running. On CPU 1,
   hrtimer_cancel(&session->txtimer) immediately succeeds in cancelling the
   queued timer and returns 1.

5. CPU 2 calls hrtimer_start(&session->txtimer, 0, HRTIMER_MODE_REL_SOFT),
   re-enqueuing session->txtimer, and releases session->txtimer_lock.

6. CPU 1 acquires session->txtimer_lock, sees ret =3D=3D 1 and
   session->txtimer_ref =3D=3D true, sets session->txtimer_ref =3D false, a=
nd drops
   the timer's session reference via j1939_session_put(session).

At that point, session->txtimer is queued in the hrtimer subsystem with
session->txtimer_ref =3D=3D false and no kref pinning the session. Should
j1939_session_txtimer_cancel_async_locked() avoid calling hrtimer_start()
when session->txtimer_cancelers is non-zero (or otherwise synchronize with
concurrent cancelers)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793681851.gi=
t.zihanx@nebusec.ai?part=3D2
