Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793516409;
	b=26SGl0KHc3TSJWH/PSN0P6qEZVpIDyMpQ6x1z7HWdZb2P6/jgQs5Ci/bd8G3XP/KgJfG
	 tAKU6jNq4iipl7iEmG728RCisVAx3Aj2rN7WU4lesLI1VBkH26hRBcy0OmANKL7iQ6Xnn
	 Xx09nDGEihy/c0LChDSTJMFEb0ifTAtHZL/OXUl9px0QZipHxg74Sr52eMGS3dKyIXsh4
	 QnHUhtkeKAg8exjxV3XvRiudyG6cNHD2XPWCvQQyhqYKoDKN/+liul6RRyTqFTFPOdh4W
	 BlR5x74ONZ/j/y9ZpxBNckFJ/1WnW13FuoScyXPxi/zNC3eZVVIQ3pFKyxZgfUU8K8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793516409;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gV3ddIFCH0vKuEyo2p0Wd03E9fGHj6ohMR1IhPL5khY=;
	b=4tgehadEVar4b2cpyrw9CRn/1rbsZnqFdlzrbiZB32fM28CSagwwobVZBM2E8OOFLbyF
	 wnjn5cFbc6YgO5FOPHsiCk2DsZOUFig6azyJg7mRkxtkVHs0rJXESYfqX2TQyYVKs3N0V
	 eY3NsJf9AYPmZXYLwK27Tu8bgVCH0XooyHSwO6WAoYas0cpvqJ5fV3iGW4YShjEEsp5pA
	 Cs9+UJU/cil+duZDieRnC50k2KkXr4shpTLqQ//91gTzmSLpleNs9OG5Jp1oEhNh+UfdD
	 FcYxjvH1YamrAc9mq8B47JeAfy1nAf0zuzG+N721y1T1IywEuedltzYcE0BqvPaeDIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ux6wO89X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274F2606A329
	for <linux-can@vger.kernel.org>; Sun,  1 Nov 2026 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ux6wO89X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587CE1F000C1;
	Sun,  1 Nov 2026 07:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793516403;
	bh=gV3ddIFCH0vKuEyo2p0Wd03E9fGHj6ohMR1IhPL5khY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ux6wO89X+Qmqdg6xThzzikYGLVCFuLoUSYgdp7PyDn+E6bgE+R95iHFIQEz+d2/oF
	 x/fqPWBMjvoBINsk2RS7AzlU3+8lkWCKW3ZnGIg8m2TIsvgKejSZfp8yWE/rcTOXhZ
	 rAw3P8x57l3dIvTQsqD4+kE2DJX+XLUx9B7LE6p2nXIr/96H8ogh0giDPo2GP4i7za
	 Clygd/aMxCcmEjhIW9cXg6shI+o2DYNPNZvfCNSiCCtjz7Km4zczKHkvVpWlTZnhU2
	 yV2wENn3MiHRte1QbAwZwmEg38XrrlQyFLUiX2c9chYm6PnZZYlq5Ur3NJiBOlA9yr
	 2Dt/wxEEk1tCQ==
Message-ID: <sashiko-outbox-192298@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 1/1] can: j1939: fix TX timer reference leak
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zihan Xi" <zihanx@nebusec.ai>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <f28a2c7a6891ea9d8b5a495493986e0b426a9978.1793371075.git.zihanx@nebusec.ai>
References: <cover.1793371075.git.zihanx@nebusec.ai>
 <f28a2c7a6891ea9d8b5a495493986e0b426a9978.1793371075.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 07:00:02 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] can: j1939: UAF race between j1939_tp_schedule_txtimer() and c=
allback exit
- [Medium] can: j1939: missed async txtimer cancel in j1939_tp_txtimer() an=
d rxtimer
--

commit e2501c2dd0f50e6cac1c843ab1074d873654c585
Author: Zihan Xi <zihanx@nebusec.ai>

can: j1939: fix TX timer reference leak

This commit reuses the session reference held by a queued TX timer when
its expiry is updated, and tracks queued timer and running callback
references separately under a new txtimer_lock spinlock.

Link: https://bugtracker.nebusec.ai/f/11143

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..bf9021977d855 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c

[ ... ]

> @@ -716,9 +781,51 @@ static int j1939_xtp_tx_abort(struct j1939_priv *pri=
v,
> =20
>  void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec)
>  {
> -	j1939_session_get(session);
> +	bool queued;
> +	int ret;
> +
> +	j1939_session_list_lock(session->priv);
> +	if (session->state !=3D J1939_SESSION_ACTIVE) {
> +		j1939_session_list_unlock(session->priv);
> +		return;
> +	}
> +
> +	spin_lock(&session->txtimer_lock);
> +	if (session->txtimer_cancelers || session->txtimer_shutdown) {
> +		spin_unlock(&session->txtimer_lock);
> +		j1939_session_list_unlock(session->priv);
> +		return;
> +	}
> +
> +	/* Replace the queued timer without taking another session reference. */
> +	ret =3D hrtimer_try_to_cancel(&session->txtimer);
> +	if (ret =3D=3D 1) {
> +		if (WARN_ON_ONCE(!session->txtimer_qref))
> +			j1939_session_get(session);
> +		session->txtimer_qref =3D true;
> +	} else if (ret =3D=3D 0) {
> +		if (!session->txtimer_qref) {
> +			j1939_session_get(session);
> +			session->txtimer_qref =3D true;
> +		}
> +	} else {
> +		/* The callback is running; preserve its pin and pin the rearm. */
> +		queued =3D hrtimer_is_queued(&session->txtimer);
> +		if (!queued && !session->txtimer_cbref &&
> +		    session->txtimer_qref) {
> +			session->txtimer_qref =3D false;
> +			session->txtimer_cbref =3D true;
> +		}
> +		if (!session->txtimer_qref) {
> +			j1939_session_get(session);
> +			session->txtimer_qref =3D true;
> +		}
> +	}
> +
>  	hrtimer_start(&session->txtimer, ms_to_ktime(msec),
>  		      HRTIMER_MODE_REL_SOFT);
> +	spin_unlock(&session->txtimer_lock);
> +	j1939_session_list_unlock(session->priv);
>  }

[Severity: Critical]
Can this race with the end of j1939_tp_txtimer() and leave session->txtimer
queued without a session->kref reference, leading to a use-after-free of
struct j1939_session?

In j1939_tp_txtimer() at txtimer_done, the running callback (invocation 1)
clears session->txtimer_cbref and unlocks session->txtimer_lock before
returning HRTIMER_NORESTART to __run_hrtimer(), which only clears
base->running after re-acquiring the hrtimer base lock:

net/can/j1939/transport.c:j1939_tp_txtimer() {
    ...
txtimer_done:
	j1939_session_list_lock(priv);
	can_rearm =3D session->state =3D=3D J1939_SESSION_ACTIVE;
	j1939_session_list_unlock(priv);
	spin_lock_bh(&session->txtimer_lock);
	if (session->txtimer_qref &&
	    (session->txtimer_shutdown || !can_rearm))
		hrtimer_start(&session->txtimer, 0, HRTIMER_MODE_REL_SOFT);
	put_cbref =3D session->txtimer_cbref;
	session->txtimer_cbref =3D false;
	spin_unlock_bh(&session->txtimer_lock);
}

If invocation 1 previously rearmed session->txtimer (so timer->is_queued is
1, session->txtimer_qref is true, and session->txtimer_cbref is now false),
and CPU 1 enters j1939_tp_schedule_txtimer() before CPU 0 clears
base->running in __run_hrtimer():

1. On CPU 1, hrtimer_try_to_cancel(&session->txtimer) sees base->running set
   and returns -1 without dequeuing the timer.

2. In the ret < 0 branch, CPU 1 reads queued =3D hrtimer_is_queued(), which
   returns true. Because queued is true and session->txtimer_qref is true,
   CPU 1 neither sets session->txtimer_cbref nor calls
   j1939_session_get(session).

3. Because hrtimer_try_to_cancel(), hrtimer_is_queued(), and hrtimer_start()
   are not atomic with respect to __run_hrtimer() and __hrtimer_run_queues()
   on CPU 0 (which do not take session->txtimer_lock), CPU 0 can finish
   __run_hrtimer() for invocation 1 and immediately dequeue the expired
   timer to start invocation 2 of j1939_tp_txtimer(), which waits on
   session->txtimer_lock.

4. CPU 1 then calls hrtimer_start(&session->txtimer, ...), queuing
   invocation 3 while invocation 2 is already running, with only a single
   reference held (session->txtimer_qref =3D=3D true,
   session->txtimer_cbref =3D=3D false).

5. Invocation 2 on CPU 0 acquires session->txtimer_lock, consumes
   session->txtimer_qref (setting session->txtimer_qref =3D false and
   session->txtimer_cbref =3D true), and calls j1939_session_put(session) w=
hen
   it finishes.

At that point, invocation 3 remains queued in the hrtimer tree with
session->txtimer_qref =3D=3D false and no kref pinning session. If the sess=
ion
is deactivated and its remaining references are dropped before invocation 3
expires, struct j1939_session is freed while session->txtimer is still
armed.

[ ... ]

> @@ -1232,7 +1370,20 @@ static enum hrtimer_restart j1939_tp_txtimer(struc=
t hrtimer *hrtimer)
>  		}
>  	}
> =20
> -	j1939_session_put(session);
> +txtimer_done:
> +	j1939_session_list_lock(priv);
> +	can_rearm =3D session->state =3D=3D J1939_SESSION_ACTIVE;
> +	j1939_session_list_unlock(priv);
> +	spin_lock_bh(&session->txtimer_lock);
> +	if (session->txtimer_qref &&
> +	    (session->txtimer_shutdown || !can_rearm))
> +		hrtimer_start(&session->txtimer, 0, HRTIMER_MODE_REL_SOFT);
> +	put_cbref =3D session->txtimer_cbref;
> +	session->txtimer_cbref =3D false;
> +	spin_unlock_bh(&session->txtimer_lock);
> +
> +	if (put_cbref)
> +		j1939_session_put(session);
> =20
>  	return HRTIMER_NORESTART;
>  }

[Severity: Medium]
Could a rearmed session->txtimer miss asynchronous cancellation and remain
pending with its session->kref reference held for its full timeout after
session deactivation or abort?

In j1939_tp_txtimer() at txtimer_done, priv->active_session_list_lock is
released before acquiring session->txtimer_lock, and session->txtimer_lock
is released before j1939_tp_txtimer() returns to __run_hrtimer() and clears
base->running.

If j1939_session_deactivate(), j1939_session_cancel(), or
j1939_cancel_active_session() runs on another CPU after txtimer_done unlocks
session->txtimer_lock (or between unlocking priv->active_session_list_lock
and locking session->txtimer_lock) but before __run_hrtimer() clears
base->running, j1939_session_txtimer_cancel_async_locked() sees
hrtimer_try_to_cancel(&session->txtimer) return -1 because base->running is
still set:

net/can/j1939/transport.c:j1939_session_txtimer_cancel_async_locked() {
	lockdep_assert_held(&session->txtimer_lock);
	session->txtimer_shutdown =3D true;
	ret =3D hrtimer_try_to_cancel(&session->txtimer);
	if (ret !=3D 1)
		return false;
    ...
}

Meanwhile, j1939_tp_txtimer() has already passed the hrtimer_start(..., 0,
...) check in txtimer_done, so a rearmed session->txtimer is neither
canceled nor shortened to 0 ms.

In addition, when j1939_tp_rxtimer() aborts an active session on RX timeout:

net/can/j1939/transport.c:j1939_tp_rxtimer() {
    ...
		j1939_session_list_lock(session->priv);
		if (session->state >=3D J1939_SESSION_ACTIVE &&
		    session->state < J1939_SESSION_ACTIVE_MAX) {
			netdev_alert(priv->ndev, "%s: 0x%p: rx timeout, send abort\n",
				     __func__, session);
			j1939_session_get(session);
			hrtimer_start(&session->rxtimer,
				      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
				      HRTIMER_MODE_REL_SOFT);
			__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
		}
		j1939_session_list_unlock(session->priv);
    ...
}

Unlike j1939_session_cancel(), this path transitions session->state to
J1939_SESSION_WAITING_ABORT via __j1939_session_cancel() without setting
session->txtimer_shutdown =3D true or calling
j1939_session_txtimer_cancel_async(session). Should j1939_tp_rxtimer() also
cancel session->txtimer asynchronously here, and can the txtimer_done window
with __run_hrtimer() be closed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793371075.gi=
t.zihanx@nebusec.ai?part=3D1
