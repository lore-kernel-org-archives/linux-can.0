Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107735;
	b=HgAgB/0z87ISsN56Rx7TahrMtChN/QUg+xCJbyGwCB33AcPvHV83MQXrk9yH0/qSl5tx
	 8rblolxq6MJ8ew+75jHZnviunuW+R4b5F5IL3GdzNQXqNoyCBBMlaEbtLdQoYPQy9p3NX
	 WYldNwEhmzFMOWiZI1mysmMR4at2D6/KHf0bX7qNJ6XimocfLtxXKBFvAMKNZUqB0DFKa
	 d/qqsBjtXzsik64KcLQrhfTXj1VsliGqP2YHTs4q1Dti1HYh9KboUkUV3KSdonGd9MHyw
	 DOhlKZyzPDyMDgYw3sXH/bViR4pdoTv9u+AqbmmFgGoD8U1NtYxQroF7EFi8d9EYzzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107735;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w+B2a6utpDlYSUDnfJZjvv4ma32T4tLpqFbqnAplgi0=;
	b=etccS2O4ZJ3OKZeVHt9gBD96TmJcPWAxyEV8bXkQa+8Dm2gbHl20m7S2ALYVRBbbmtd5
	 OWU7ZyF5OJ87ThJQLA1Tc3zvXZHddByQle6VWNpDDXwgK0nH3g0NMnLnLtTx05hoOMK5U
	 mN6wl0kePNX4WdTeSEhgzIXi0li8yuV60Of2MYzetXc5VifEp8fkncgYaWafaZE7IMaFK
	 ++dXFPTMD+c3Ql4J0/f/owk3g3Us3clQMdkFfE4lp89AEOxfZxi3lDx/XbH0cKqRh/yhx
	 79vN75Zj+VdE9u+YuTEf0MEMH4VWmubpaKls2idP1zOfI2XJEe7SF7qy3SWElEW6bkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gC3hBXJV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7E0606CB4F
	for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gC3hBXJV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05331F01180;
	Tue, 27 Oct 2026 13:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793107734;
	bh=w+B2a6utpDlYSUDnfJZjvv4ma32T4tLpqFbqnAplgi0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gC3hBXJVK0GVG8DQVEcSf2We3Syc0k089XLjSEIP6gguDut1v6HbsBqDbB3+DTutG
	 10l3CIGfMtEURsMmMkFE58N3Z8COdzp37Z8OfcSMcuFP9sdojO/Ja0mKEQSDyYJajU
	 X9nnewv3ONmYW1o4/OBeMPJsIUKmkjSVFfqjvgOH/mUnLsldCx09+4qw6U6JJYDQjT
	 uCkS+kbHHPcxIwyrlEEhlqz8htDip8CxlTpAeD4t851rM8moOhBMnAIQTQJCbmppIZ
	 A3GCgsszIEauw+1tdT10bewKW3b6kFV4w01M+LgnRLU/ew5tPd83ZKkEXVRaLXoLlr
	 Jx3zHN3HtJqkA==
Message-ID: <sashiko-outbox-186622@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] can: j1939: fix session reference leak on TX
 timer restart
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zihan Xi" <zihanx@nebusec.ai>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <c07c904f7c5d36e2ddd2ecaa2e76c4b210b0647e.1793012287.git.zihanx@nebusec.ai>
References: <cover.1793012287.git.zihanx@nebusec.ai>
 <c07c904f7c5d36e2ddd2ecaa2e76c4b210b0647e.1793012287.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 13:28:54 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] can: j1939: rxtimer race and leak in j1939_cancel_active_session()
- [High] can: j1939: lock inversion calling hrtimer_cancel() under txtimer_=
lock
- [Low] can: j1939: missing lock annotations in j1939_session_list_lock()
--

commit f04ccae0c143b4770bcd167c770232649c770e32
Author: Zihan Xi <zihanx@nebusec.ai>

can: j1939: fix session reference leak on TX timer restart

This commit fixes a session reference leak when rearming an active TX hrtim=
er
by serializing TX timer starts and cancellations under a per-session spinlo=
ck
and reusing the existing timer reference. It also defers scheduling a newly
activated session until after dropping sk_session_queue_lock.

Link: https://bugtracker.nebusec.ai/f/11143
Link: https://lore.kernel.org/all/cover.1792979091.git.zihanx@nebusec.ai/

> diff --git a/net/can/j1939/Makefile b/net/can/j1939/Makefile
> index 19181bdae1736..113595c257309 100644
> --- a/net/can/j1939/Makefile
> +++ b/net/can/j1939/Makefile
> @@ -1,5 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> =20
> +CONTEXT_ANALYSIS :=3D y

[Severity: Low]
Enabling CONTEXT_ANALYSIS :=3D y in net/can/j1939/Makefile opts all files in
this directory into Clang's thread-safety analysis when
CONFIG_WARN_CONTEXT_ANALYSIS=3Dy is enabled.

In net/can/j1939/transport.c, j1939_session_list_lock() and
j1939_session_list_unlock() wrap spin_lock_bh() and spin_unlock_bh() without
context lock annotations:

static inline void j1939_session_list_lock(struct j1939_priv *priv)
{
	spin_lock_bh(&priv->active_session_list_lock);
}

static inline void j1939_session_list_unlock(struct j1939_priv *priv)
{
	spin_unlock_bh(&priv->active_session_list_lock);
}

Because spin_lock_bh() and spin_unlock_bh() carry __acquires() and
__releases() annotations, won't Clang emit -Wthread-safety-analysis warnings
(failing the build under CONFIG_WERROR=3Dy) unless j1939_session_list_lock()
and j1939_session_list_unlock() are annotated with
__acquires(&priv->active_session_list_lock) and
__releases(&priv->active_session_list_lock)?

[ ... ]

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..4a2e986023d89 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -9,6 +9,7 @@
>  //                         Oleksij Rempel <kernel@pengutronix.de>
> =20
>  #include <linux/can/skb.h>
> +#include <linux/cleanup.h>
>  #include <net/can.h>
> =20
>  #include "j1939-priv.h"
> @@ -303,7 +304,13 @@ void j1939_session_put(struct j1939_session *session)
> =20
>  static void j1939_session_txtimer_cancel(struct j1939_session *session)
>  {
> -	if (hrtimer_cancel(&session->txtimer))
> +	int ret;
> +
> +	spin_lock_bh(&session->txtimer_lock);
> +	ret =3D hrtimer_cancel(&session->txtimer);
> +	spin_unlock_bh(&session->txtimer_lock);
> +
> +	if (ret)
>  		j1939_session_put(session);
>  }

[Severity: High]
Can calling hrtimer_cancel() while holding session->txtimer_lock here (and =
in
j1939_tp_schedule_txtimer()) cause a lock ordering inversion with the hrtim=
er
softirq expiry lock?

Because session->txtimer and session->rxtimer use HRTIMER_MODE_REL_SOFT,
hrtimer_cancel() -> hrtimer_cancel_wait_running() acquires
cpu_base->softirq_expiry_lock when waiting for a running callback,
establishing the lock order:

  session->txtimer_lock -> cpu_base->softirq_expiry_lock

In the reverse direction, when j1939_tp_txtimer() or j1939_tp_rxtimer() runs
in softirq context under hrtimer_run_softirq() (which holds
cpu_base->softirq_expiry_lock), it can call:

  j1939_sk_queue_activate_next()
    -> j1939_tp_schedule_txtimer(next, txtimer_delay)
      -> spin_lock_bh(&next->txtimer_lock)

This establishes the reverse lock order:

  cpu_base->softirq_expiry_lock -> session->txtimer_lock

Since all session->txtimer_lock instances share the same lockdep class, won=
't
this trigger a lockdep circular locking dependency splat and risk deadlocki=
ng
on CONFIG_PREEMPT_RT when a softirq timer callback tries to acquire
next->txtimer_lock while another thread holds next->txtimer_lock waiting in
hrtimer_cancel()?

[ ... ]

> @@ -2234,24 +2273,37 @@ void j1939_simple_recv(struct j1939_priv *priv, s=
truct sk_buff *skb)
> =20
>  int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk)
>  {
> -	struct j1939_session *session, *saved;
> +	struct j1939_session *session, *iter;
> =20
>  	netdev_dbg(priv->ndev, "%s, sk: %p\n", __func__, sk);
> -	j1939_session_list_lock(priv);
> -	list_for_each_entry_safe(session, saved,
> -				 &priv->active_session_list,
> -				 active_session_list_entry) {
> -		if (!sk || sk =3D=3D session->sk) {
> -			if (hrtimer_try_to_cancel(&session->txtimer) =3D=3D 1)
> -				j1939_session_put(session);
> +	for (;;) {
> +		session =3D NULL;
> +		j1939_session_list_lock(priv);
> +		list_for_each_entry(iter, &priv->active_session_list,
> +				    active_session_list_entry) {
> +			if (sk && sk !=3D iter->sk)
> +				continue;
> +
> +			/* Keep the session alive while cancellation waits for the
> +			 * TX timer callback outside active_session_list_lock.
> +			 */
> +			session =3D iter;
> +			j1939_session_get(session);
> +			WRITE_ONCE(session->txtimer_shutdown, true);
>  			if (hrtimer_try_to_cancel(&session->rxtimer) =3D=3D 1)
>  				j1939_session_put(session);
> -
>  			session->err =3D ESHUTDOWN;
>  			j1939_session_deactivate_locked(session);
> +			break;
>  		}
> +		j1939_session_list_unlock(priv);
> +
> +		if (!session)
> +			break;
> +
> +		j1939_session_txtimer_cancel(session);
> +		j1939_session_put(session);
>  	}
> -	j1939_session_list_unlock(priv);
>  	return NOTIFY_DONE;
>  }

[Severity: High]
In j1939_cancel_active_session(), can session->rxtimer remain armed after
j1939_session_txtimer_cancel() finishes, delaying or leaking the session,
socket, and net_device references and clobbering session->err?

While holding priv->active_session_list_lock, j1939_cancel_active_session()
calls hrtimer_try_to_cancel(&session->rxtimer), sets session->err =3D ESHUT=
DOWN,
and deactivates the session before dropping the lock and calling
j1939_session_txtimer_cancel(session).

If j1939_tp_txtimer() is concurrently running on another CPU (or starts bef=
ore
j1939_session_txtimer_cancel() cancels it, or rearms itself because the
txtimer_shutdown check in j1939_tp_txtimer() is not serialized by
session->txtimer_lock), it executes j1939_simple_txnext(),
j1939_xtp_txnext_transmiter(), or j1939_xtp_txnext_receiver(). Those paths
call j1939_tp_set_rxtimeout(), which takes a new reference via
j1939_session_get(session) and starts session->rxtimer after
hrtimer_try_to_cancel(&session->rxtimer) has already run. For example,
j1939_simple_txnext() arms session->rxtimer for J1939_SIMPLE_ECHO_TIMEOUT_MS
(10s) before calling j1939_send_one(), and on -ENETDOWN, j1939_tp_txtimer()
leaves rxtimer armed expecting j1939_cancel_active_session() to clean it up.

In addition, if j1939_tp_rxtimer() is currently running and has re-armed
session->rxtimer, hrtimer_try_to_cancel(&session->rxtimer) returns -1 and d=
oes
not cancel the newly queued timer or drop its session reference.

Because j1939_session_deactivate_locked() has already removed the session f=
rom
priv->active_session_list, subsequent iterations of the loop will not see it
again. Should session->rxtimer be synchronously cancelled via
j1939_session_rxtimer_cancel(session) after j1939_session_txtimer_cancel(),
similar to j1939_session_timers_cancel()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793012287.gi=
t.zihanx@nebusec.ai?part=3D1
