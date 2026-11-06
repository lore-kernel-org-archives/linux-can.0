Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793938732;
	b=SqSPLgFFaXzUmoU/WpDwcAowNklMqAbNmy8yS82+tAcI4DvDuRff2jY5SYvV6EIFLIsB
	 m7AZgwrGNzZyVdP7VLYDmcDbQ4QithzMgNE6UutUV2dRvIoKTvsri49XMidX680GYbLR9
	 /2xV3ysOnRl3WM8PLPXZ/4EYWW1eYRjaD1SINogOSddfbM2F0AO+uHj0mCTY68hzbhbNr
	 vaAbgRMp20pG9mpDRhXlw1sJjwKIRl66JD1bfJJ4Xx9FDQ5KYr+mZMRT+8ynSWK+LVuUr
	 j20J8OsaFjRlkDhfFwcc1gGsoKaPwmzWYjP6AVeq9x5tpnbRClKXk635MM/ax7sRsLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938732;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=K7eIM7ifS5Tzk54oYdIpR4pQDHU9665Colcy1CawcKc=;
	b=Z4aolzTZt20TCBwuSjoaMtPbaN7nYL2kcqvRHqxnLiTvpy4ZVzGRgVFRUoBNoDNCKVbJ
	 u01CfRi43KdGnC7LkDy+tZCifdDI3Zkc0jv6wZ5NnGifygVvVeJR+n8XvaE9qmqBh2fVY
	 GE79LLVFhohn1RCljtS+ddLTA9/HZnESmyxGSK+UVon8buv4IBJY8eeu6TWw+Dau766Sg
	 RhoXAf6WeVxCm3LuTkm+0eojhTi2auMqNSH3+qKUnoBt1f9JztovuIw+UUlMsIEzBs6/q
	 g6fOCV/a3n1hc/i4ITtaSWa/U+FGezi7nZSAuN3XRks3JzSmdVynJMrbG1uUfb1VuKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHbuTrs4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7085B606A330
	for <linux-can@vger.kernel.org>; Fri,  6 Nov 2026 04:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHbuTrs4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530C21F008A1;
	Fri,  6 Nov 2026 04:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793938732;
	bh=K7eIM7ifS5Tzk54oYdIpR4pQDHU9665Colcy1CawcKc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kHbuTrs4yuIyalGmgmAzy+qcY1PMF4cG+PL2z4fyvG2zSZW5UbjAffCb0a2LayDFG
	 lgw86DsEIuwIrTHV/sQzJmK8/A2jlPUv8EH3dqch3meBxbMqSANflOgb09J6UhB8AF
	 x2myHo+ByPDSvxHDOaJz0eKrT/ezBjlyup831uY+bgpui3ez30qeqYR1WAGB8GI1fR
	 DGYbWtPK9HGh+YvXF5CDcIbzclPrTVnewFZltugTffb8z5+DMufMtG5tsd/2g/xOuT
	 86SeIDy5EZLNoNq3jcgQF1MEICrr6nxSxlOEXa629diUqt2Dzm9nuFeLkaXQrm4EL7
	 uAWAN6Ruo3Ctg==
Subject: Re: [PATCH net v6 2/2] can: j1939: serialize TX with session shutdown
From: netdev-bot+sashiko@kernel.org
To: zihanx@nebusec.ai
Cc: linux-can@vger.kernel.org, robin@protonic.nl, o.rempel@pengutronix.de,
 kernel@pengutronix.de, socketcan@hartkopp.net, mkl@pengutronix.de,
 lkp@intel.com, bst@pengutronix.de, dev.kurt@vandijck-laurijssen.be,
 maxime.jayat@mobile-devices.fr, vega@nebusec.ai, kuba@kernel.org
Date: Fri, 06 Nov 2026 04:18:50 +0000
Message-ID: <179393873091.488853.8495060637149077532@kernel.org>
In-Reply-To: <f9f8aa1cd4eb28c018aa35ec85a1032003d4421a.1793788955.git.zihanx@nebusec.ai>
References: <f9f8aa1cd4eb28c018aa35ec85a1032003d4421a.1793788955.git.zihanx@nebusec.ai>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message covers only part of what the patch changes.

--

can: j1939: serialize TX with session shutdown

This patch adds a per-session tx_send_lock and a tx_send_shutdown flag. It
routes session frame transmission through a new j1939_session_tx_send()
helper, which drops frames with -ESHUTDOWN once shutdown has been
published or the state is no longer ACTIVE. The state writes in activate,
deactivate and cancel now happen under the new lock.

Link: https://bugtracker.nebusec.ai/f/11143

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index fbeb858956e03..390923a050469 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c

[ ... ]

> @@ -1350,10 +1390,13 @@ j1939_session_deactivate_activate_next(struct j1939_session *session)
>  
>  static bool j1939_session_fail(struct j1939_session *session, int err)
>  {
> -	bool deactivate = false;
> +	bool deactivate = false, tx_send_shutdown;
>  
>  	j1939_session_list_lock(session->priv);
> -	if (session->state == J1939_SESSION_ACTIVE) {
> +	spin_lock(&session->tx_send_lock);
> +	tx_send_shutdown = session->tx_send_shutdown;
> +	spin_unlock(&session->tx_send_lock);
> +	if (!tx_send_shutdown && session->state == J1939_SESSION_ACTIVE) {
>  		session->err = err;
>  		deactivate = j1939_session_deactivate_locked(session);
>  	}

[Severity: Low]

This isn't a bug, but the commit message only covers part of this change:

  Prevent a timer callback from sending session frames after a concurrent
  terminal state transition. Serialize the send with the state change and
  reject frames once shutdown has been published.

That description matches j1939_session_tx_send(). The patch also adds
tx_send_shutdown checks to paths that do not send frames:

  - j1939_session_fail() stops recording session->err and stops
    deactivating once tx_send_shutdown is set.

  - __j1939_session_cancel() returns early, so no abort frame is sent and
    j1939_sk_send_loop_abort() is not called. The abort frame is also now
    sent while tx_send_lock is held.

  - j1939_session_cancel() gets an outer copy of the same check.

  - __j1939_tp_set_rxtimeout() gets a new check.

  - The new -ESHUTDOWN result skips the netdev_alert() in
    j1939_session_tx_dat() and is silently dropped in j1939_tp_txtimer().

Are most of these checks needed? Only j1939_session_timers_shutdown_locked()
sets tx_send_shutdown. It runs under active_session_list_lock and sets
rxtimer_shutdown in the same section, and rxtimer_shutdown is never
cleared:

j1939_session_timers_shutdown_locked() {
	lockdep_assert_held(&session->priv->active_session_list_lock);
	j1939_session_tx_send_shutdown(session);
	spin_lock(&session->rxtimer_lock);
	session->rxtimer_shutdown = true;
	spin_unlock(&session->rxtimer_lock);
}

As a result, the new check in __j1939_tp_set_rxtimeout() repeats the
existing rxtimer_shutdown test.

The check in __j1939_session_cancel() can never fire either, because
j1939_session_cancel() already tests the same flag under the same list
lock.

Behaviour only seems to change in j1939_simple_recv(). It publishes the
shutdown while the state is still ACTIVE, drops the list lock, drains the
timers, and only deactivates later:

	j1939_session_list_lock(priv);
	session = j1939_session_get_simple(priv, skb);
	if (session)
		j1939_session_timers_shutdown_locked(session);
	j1939_session_list_unlock(priv);

Within that window, a txtimer error such as -ENOMEM from
j1939_simple_txnext() reaches j1939_session_fail(). It is now ignored,
where before it set session->err and deactivated the session. That may be
intended, since the echo has already confirmed the send.

Could the commit message mention this change and explain why it is safe?

The patch is tagged for stable and adds a new lock around j1939_send_one()
on every session TX path. Could the message also describe the user-visible
symptom being fixed? For example, stray TP.DT, CTS, EOMA or simple frames
showing up on the bus after a concurrent terminal transition.

Could the redundant checks also be dropped?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793788955.git.zihanx%40nebusec.ai
