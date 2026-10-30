Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793401747;
	b=lkUKCK4tdfXUjzCsAJK0Hk9xGZEvHacvBX2w1Cem5WGxl2t3W0egHtDg7E23kYAEuNZP
	 I6RD9dp5GbMemu0kTp0bZ/9Y9cGTNARk9UjN+R3+TXk5UgnVvGLMvN8aj32KJsXxw+XnH
	 SGHVKE7VgdUsQUOBdJFtKht61Fq12jTwIQyW/7mStHpKVhnU+CUk5qik7MQBFwnrC0Tub
	 aOg4cj3/iGNIAOpTVSH0HIXphcF4GSP039xjCgvBR17trAidltUlostQKKhcgEjX8rUPK
	 hd0Cwt2a1QxCTvl4cAYqPBKBdCzH/uHsEAxWggrjgRTbF4bE5XexlxDfNKftIhQGpog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793401747;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JHEnBv7mlQPYfgdTqHQxMbrkQoxYtWgsPA+USmqN1LQ=;
	b=eTFOAEnIbYjKciAvI5zPF0cjDDjwkMKcRZQ/cr9/oys6f1SV4NgcYtaIvqdTTnyOny4u
	 hI5lbpjta5nWdcfDd4Ls1l2V/bWhMz/dlg0Ccj0cB9xk28fDgAnL1J3g5gK8Pt3mDp630
	 6BLFiXDmgkOyrLu/Y37BKGgpqjCh/BNkUcBinEJJFZvIGRz0g4HFxQk/OblqmlkyV3jri
	 /AcynCTBbaieurqueErbIzgSDEgg6sZuRRCihrJWzD1WsJObBnG5+A+OgTjTs1Hj6TI+a
	 7u+PpIUjarJTj76QUq1cxQexr574fK+QpHtDoOXOVuWqHnNcEf/PDwgnlTjQCliTkpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZCxvke3S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A257606A31A;
	Fri, 30 Oct 2026 23:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZCxvke3S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9871F000C1;
	Fri, 30 Oct 2026 23:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793401747;
	bh=JHEnBv7mlQPYfgdTqHQxMbrkQoxYtWgsPA+USmqN1LQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZCxvke3SPm6WIsQv+qlKfrp0H0XlURh7HvRBIjh13jwDjUno4DKJt3S4L/pyQkTYL
	 FodjvZPqblr/CsrWvBflto88AtcDqHZLhGWZYTuBEUy72Eh66/uUf/pJyTkAMCaU7F
	 ogoTH8EEIUvzSM6nGdZm6tsK6nexMT7ZCgPALPpn1ZZvgbi16g3eSFsnz1aFUmr+G5
	 XHGBoheXw4EMGf3AoeKS0ZbAJXxoQfkZml7rhVPrCNxn+VstYqiJewXcByxi82LaAK
	 aQdQcGWoyrzVhAHuXTjGj/LIvAsLoCGWRn/CwHP1sKonVOqDEKGTH6KY90tjGmkbxg
	 m7+mxk3EpUmJg==
Subject: Re: [PATCH net v3 3/3] can: j1939: enable context analysis
From: netdev-bot+sashiko@kernel.org
To: zihanx@nebusec.ai
Cc: linux-can@vger.kernel.org, llvm@lists.linux.dev, robin@protonic.nl,
 o.rempel@pengutronix.de, kernel@pengutronix.de, socketcan@hartkopp.net,
 mkl@pengutronix.de, ecathinds@gmail.com, dev.kurt@vandijck-laurijssen.be,
 maxime.jayat@mobile-devices.fr, bst@pengutronix.de, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 vega@nebusec.ai, kuba@kernel.org
Date: Fri, 30 Oct 2026 23:09:05 +0000
Message-ID: <179340174578.3127.13159979354065824365@kernel.org>
In-Reply-To:
 <0d7b3745c8d8f3d7bf4b91ca3690f5ff1ab52f59.1793259424.git.zihanx@nebusec.ai>
References:
 <0d7b3745c8d8f3d7bf4b91ca3690f5ff1ab52f59.1793259424.git.zihanx@nebusec.ai>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says "Keep the analysis opt-in and its
  annotations separate from the J1939 timer and send synchronization…
- [Low] The patch marks the hrtimer object itself as guarded: `struct
  hrtimer txtimer __guarded_by(&txtimer_lock)`…

--

can: j1939: enable context analysis

This enables Clang context analysis for net/can/j1939/transport.o. It
annotates the TX timer state and the TX-send shutdown flag with
__guarded_by() and adds __acquires()/__releases() to the session-list lock
wrappers. It also adds a few comments around the TX timer pinning logic.

> Keep the analysis opt-in and its annotations separate from the J1939
> timer and send synchronization fixes.

[Severity: Medium]
Is this description accurate for the series?

The earlier fix in this series, "can: j1939: fix session reference leaks
on timer rearm" (Fixes: 9d71dd0c7009, Cc: stable), already added this to
j1939_session_new():

	spin_lock_init(&session->tx_send_lock);
	scoped_guard(spinlock_init, &session->txtimer_lock) {
		hrtimer_setup(&session->txtimer, j1939_tp_txtimer,
			      CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
	}

At runtime the spinlock_init guard does nothing beyond spin_lock_init().
It only makes the analysis treat txtimer_lock as held while guarded
members are initialized. Here that is only needed because of the
__guarded_by(&txtimer_lock) on txtimer that this patch adds. By
comparison, tx_send_lock uses plain spin_lock_init().

The same fix also added the "Keep this alias across unlock" comment in
j1939_session_txtimer_cancel(). That comment seems to belong with the
context_unsafe_alias() added here.

The spinlock_init guard class comes from the recent commit d084a73714f8
("compiler-context-analysis: Introduce scoped init guards"). A stable
tree older than that has no class_spinlock_init. Would a backport of the
reference leak fix fail to build as written?

Could the scoped_guard(spinlock_init) move into this patch, next to the
__guarded_by() it supports? The stable fix would then use plain
spin_lock_init() and hrtimer_setup(). Otherwise, could the separation
claim be dropped from the commit message?

> diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
> index 6bf55b7dfffcc..d664f32bbb8f2 100644
> --- a/net/can/j1939/j1939-priv.h
> +++ b/net/can/j1939/j1939-priv.h

[ ... ]

> @@ -293,22 +293,22 @@ struct j1939_session {

[ ... ]

> +	/* Protects TX timer rearming and cancellation. */
> +	spinlock_t txtimer_lock;
> +	struct hrtimer txtimer __guarded_by(&txtimer_lock);
> +	bool txtimer_qref __guarded_by(&txtimer_lock);

[ ... ]

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 570e2b8d08263..7fcf66e93afd7 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c

[ ... ]

> @@ -331,6 +333,7 @@ static void j1939_session_txtimer_cancel(struct j1939_session *session)
>  	session->txtimer_shutdown = true;
>  	timer = &session->txtimer;
>  	/* Keep this alias across unlock; blocking cancel must run outside the lock. */
> +	context_unsafe_alias(timer);
>  	ret = hrtimer_try_to_cancel(timer);
>  	if (ret == 1) {
>  		WARN_ON_ONCE(!session->txtimer_qref);

[Severity: Low]
Does the __guarded_by(&txtimer_lock) on txtimer match how this function
uses it?

The pointer is taken under txtimer_lock. Later in the same function, the
blocking cancel runs after the lock has been dropped:

	spin_unlock_bh(&session->txtimer_lock);

	if (ret < 0) {
		/* Keep the blocking cancel outside txtimer_lock. */
		ret = hrtimer_cancel(timer);

This has to run unlocked because j1939_tp_txtimer() takes txtimer_lock
itself. So the code deliberately uses the object without the lock that
the new annotation says guards it.

include/linux/compiler-context-analysis.h documents context_unsafe_alias()
as a context lock alias barrier:

 * @p: pointer aliasing a context lock or object containing context locks

struct hrtimer is not a context lock and does not contain one. Here the
helper seems to be used only so the analysis loses track of the alias.
That also stops checking the locked hrtimer_try_to_cancel(timer) call
right after it.

Would context_unsafe() around the unlocked hrtimer_cancel(), with a
stated reason, fit better? Another option is to leave the hrtimer
unannotated and guard only the bookkeeping bools.

The RX peer, j1939_session_rxtimer_cancel_sync(), uses the same pattern:
the alias is taken under the lock and hrtimer_cancel() is then called
unlocked. It has neither __guarded_by() nor an alias helper, so the two
timers end up documented differently.

Could the commit message also say that this unlocked access is exempted
from the analysis?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793259424.git.zihanx%40nebusec.ai
