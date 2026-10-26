Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793005065;
	b=SiYFtojzxB/AWsq50RhoDY/t98s4LZ+k7H7BgXowt9nwY3hAyw0yHuyq9volSKYknAY2
	 dtJ29VipTzZr+910hyWWbO11oDKYgkwfHds+KTjTXqPrCo2Npg8bhjWpQgWljcER2KFg8
	 Jt22rZkd/hx3eDliVAr5qa+eQTktqTxhWkP8YGtC/17m0M1nK/4+592xptbKG0if2RvCO
	 uJN746tKDM/1eWWJicok4u6MatkHPjNxWPyOpjkhHfdC7wAtNQuiUX2Qsz3R7hIRcUoLX
	 WoO+7Mj5fBqtr6dS4ytzxMgFI/9VI8b5ZbsA64PeEmnmQeuI71QEA/BzuQYEY5pTz3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005065;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aMU8gJWTyvNIXFsxcm4/wecsLLnwPXPqVvEW4F1aHjA=;
	b=iKx3MkDavYfUewtVCbJU58NGyvxUQubaPuNyCsFt7L9MrQG3hqUOMSajpSkbzZtFP/6e
	 hXulLScEANRJt5E7KtLEvQiQOiX8VRt8IFpUVEyHXCCafSqLq3Ze6HylG7MqS8WpI6bub
	 ruPID38pwXGA/7/RbLMXyrs9Xj95XWojpI+Y5yPUmBMiZ0DyGoVChaOionx1YuLLNmOSz
	 M8ey0fNSaEFot8fKVzB74RhhkDqgN3uDzwHuoIsyIvRlhorFvL+ixKOlhcKvXfJchtRjO
	 jJQp2bhw5fX80BJdjEGkIX7IS8oAl+0tp60K6jyW6mHufODsT8wmBTFYYsqDy5bsK4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JN7bO/km";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE19606A31B
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JN7bO/km
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981D41F01825;
	Mon, 26 Oct 2026 08:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793005065;
	bh=aMU8gJWTyvNIXFsxcm4/wecsLLnwPXPqVvEW4F1aHjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JN7bO/kmGs6pQhwsfEOAgnYD1BTt7MTKvXJi3e4yaBtZ0ZbmAb2oAMr1unLwcwaTE
	 dm5Udw6ZlQpxvmeffh0dX1yhU52P84C6xNuPGzYB3urqPSYQPL8cBl6ptbe+pNhisw
	 QDpgKsze8xAx7y8EYcvQ3s1l/yifuAVSz+rRVosZ0nJynTGDb16ijXNCUiO7ok8eI+
	 0sxISvdbGeENmKRZIjFCXzHLt/ie+0wYARuNwsoMkOTF9knaVMKEwrl5um11en7r0r
	 EKX8yaouINV+WlgBcuXieYE8Z0VzUT0Z1pxHj+VX+vC3b8zTRh778zarI6kFP1954f
	 qkETQL2cxvesw==
Message-ID: <sashiko-outbox-184711@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] can: j1939: fix session reference leak on TX timer
 restart
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zihan Xi" <zihanx@nebusec.ai>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <6bbcca411ac9433ae4ed8b8e64f56ff16dfc20b0.1792979091.git.zihanx@nebusec.ai>
References: <cover.1792979091.git.zihanx@nebusec.ai>
 <6bbcca411ac9433ae4ed8b8e64f56ff16dfc20b0.1792979091.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 08:57:44 +0000
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
- [Critical] can: j1939: session refcount underflow in j1939_tp_schedule_tx=
timer()
- [High] can: j1939: race between j1939_tp_schedule_txtimer() and txtimer c=
ancellation
--

commit 132d2449245f60a20ddade9b51a9c2efc0a02136
Author: Zihan Xi <zihanx@nebusec.ai>

can: j1939: fix session reference leak on TX timer restart

This patch adds a spinlock to serialize TX timer rearming in
j1939_tp_schedule_txtimer() and reuses the existing session reference when
restarting an already queued TX timer.

Link: https://bugtracker.nebusec.ai/f/11143

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..e9af8547c69b4 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -716,9 +716,17 @@ static int j1939_xtp_tx_abort(struct j1939_priv *pri=
v,
> =20
>  void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec)
>  {
> -	j1939_session_get(session);
> +	int ret;
> +
> +	spin_lock_bh(&session->txtimer_lock);
> +	/* Keep the timer's reference when only changing its expiry. */
> +	ret =3D hrtimer_try_to_cancel(&session->txtimer);

[Severity: High]
Could temporarily dequeuing session->txtimer here race with callers that
cancel the timer without holding session->txtimer_lock?

In net/can/j1939/transport.c, neither j1939_session_txtimer_cancel() nor
j1939_cancel_active_session() acquires session->txtimer_lock:

static void j1939_session_txtimer_cancel(struct j1939_session *session)
{
	if (hrtimer_cancel(&session->txtimer))
		j1939_session_put(session);
}

and in j1939_cancel_active_session():

	if (hrtimer_try_to_cancel(&session->txtimer) =3D=3D 1)
		j1939_session_put(session);

Previously, j1939_tp_schedule_txtimer() called hrtimer_start() directly on
an already queued timer, updating its expiry under the hrtimer base lock
without transitioning hrtimer_active(&session->txtimer) to false.

With this change, when session->txtimer is queued and its callback is not
running, hrtimer_try_to_cancel(&session->txtimer) dequeues the timer and
returns 1, making hrtimer_active(&session->txtimer) false until
hrtimer_start() runs.

If another CPU calls j1939_session_txtimer_cancel() (for example via
j1939_session_timers_cancel() on session abort or completion, or from
j1939_xtp_rx_cts_one()) or j1939_cancel_active_session() during that window,
hrtimer_cancel() / hrtimer_try_to_cancel() will see the timer as inactive
and return 0. j1939_tp_schedule_txtimer() will then call hrtimer_start() and
re-arm session->txtimer on a session whose timers were already cancelled.

> +	/* A running callback may already have requeued the timer. */
> +	if (ret !=3D 1 && !hrtimer_is_queued(&session->txtimer))
> +		j1939_session_get(session);
>  	hrtimer_start(&session->txtimer, ms_to_ktime(msec),
>  		      HRTIMER_MODE_REL_SOFT);

[Severity: Critical]
What prevents a queued session->txtimer from expiring or being cancelled
between the lockless hrtimer_is_queued() check and hrtimer_start(), causing
a refcount underflow on session->kref?

In kernel/time/hrtimer.c, hrtimer_try_to_cancel() leaves the timer queued
and returns -1 whenever the timer callback is currently running:

	if (!hrtimer_callback_running(timer)) {
		ret =3D remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE);
		if (ret)
			trace_hrtimer_cancel(timer);
	}

Consider the following sequence across two CPUs when j1939_tp_txtimer() is
running on CPU 0 and has already requeued session->txtimer once (holding one
session->kref reference for the running callback and a second reference for
the queued timer):

1. CPU 1 calls j1939_tp_schedule_txtimer() and takes session->txtimer_lock.
   Because j1939_tp_txtimer() is still running on CPU 0,
   hrtimer_try_to_cancel(&session->txtimer) returns -1 without removing the
   queued timer.

2. CPU 1 checks hrtimer_is_queued(&session->txtimer), which observes
   timer->is_queued =3D=3D 1, so CPU 1 skips j1939_session_get(session) int=
ending
   to reuse the queued timer's reference.

3. Before CPU 1 enters hrtimer_start() and takes the hrtimer base lock, the
   running j1939_tp_txtimer() callback on CPU 0 finishes (dropping its own
   reference via j1939_session_put(session)), and the queued timer either:
   - immediately expires in __hrtimer_run_queues() / __run_hrtimer() (which
     does not take session->txtimer_lock), dequeuing the timer and running a
     second j1939_tp_txtimer() that drops the second session->kref referenc=
e:

	j1939_session_put(session);

	return HRTIMER_NORESTART;

   - or is cancelled by an unlocked j1939_session_txtimer_cancel() or
     j1939_cancel_active_session() on another CPU, which also dequeues the
     timer and drops the second session->kref reference.

4. CPU 1 then executes hrtimer_start(&session->txtimer, ...), which enqueues
   session->txtimer from the inactive state without having taken a new
   session reference.

When that newly started timer subsequently fires in j1939_tp_txtimer() or is
cancelled, j1939_session_put(session) will drop a reference that was never
taken, underflowing session->kref and freeing struct j1939_session while it
is still in use.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792979091.gi=
t.zihanx@nebusec.ai?part=3D1
