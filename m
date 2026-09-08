Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6B0550DD8
	for <linux-can@vger.kernel.org>; Tue,  8 Sep 2026 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879445; cv=none; b=ab31D1QKHRKbAdBvc1FfIWWUG1VCMB1jUrCpJr4AP9BG/oDqvY+0ewKLnSnyDdKt2sIJ16ZCK5hlaLhnZv2aFPzCPwAuMFTYLi/4FeBPEmrzsuV+GewXC922+R476yCiMgXqCKrCWqKVU+IhuJl6nvkRoEDSMGNBoP7Jem8kqEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879445; c=relaxed/simple;
	bh=kPU/eNFvsC3OA5QSA7pfIZ3GMdbFmua4udhZO4ymyqY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F29fVPwSLnwG7dLqu3A07TtwXtnEA0LUj9jGbH2zGDDspDrf6wqTgK7icIOrZc5WwaTA+h7iTU3CJ6xFK/1HuAO3HRPTf/saiqmJTzDybixxTFU7KqVl9Ym2gszHReAlpN0Hiu/COxIzUEzAxiODa9oEGpCQzPrw9uVV2UG8iLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8NOFaCY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8NOFaCY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70BD1F00A3D;
	Tue,  8 Sep 2026 14:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788879436;
	bh=AxRrqRNXClmgTqkdDhj6BHGLHtJ+zwh5/Sllm5lPW+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X8NOFaCYqetPQGAryAiQlAxvRrxuBtjdhPjFp+0m8LTauqw8VGt5oenrYByg1KvOH
	 SSrb5ac2DhDFpzN0nC5MnZHVr4/t9K5aiFQgfr+JDHXccxbLJZd5gRuBLJB93pctj6
	 SLTICDkEUfiwLUkgtIVelJMV+DJSEHuxpIjI/WrfKP4DEvOOCLQWrmVaCO49DZis78
	 28uljoXfVLUhkThhT6i0WPSS0IuImkA2Vtq3zkgGGqdixZYrJNCfXoFxzECE9UKw+v
	 oB83WJGxIc7olldcyLhD7MvnOr8EcVNhvVShoH18TmCmAxEvOsbsof/yHIGPsjW05q
	 7lDlVgQ2L8n8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] can: j1939: check received packet count before
 completing session
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liu Chao" <liuc63@xiaopeng.com>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260907145640.1106170-3-liuc63@xiaopeng.com>
References: <20260907145640.1106170-1-liuc63@xiaopeng.com>
 <20260907145640.1106170-3-liuc63@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:57:15 +0000
Message-Id: <20260908145715.D70BD1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Canceling session timers during an already-aborting session perman=
ently leaks the session and blocks the address.
- [Medium] The patch inadvertently suppresses the pre-existing diagnostic w=
arning for EOMA size mismatches on transmitter sessions.

Pre-existing issues:
- [High] AB-BA deadlock between `active_session_list_lock` and the `rxtimer=
` hrtimer callback.
--

commit 66292f8eec0fad08cd8484aafc6afd0d99105fbf
Author: Liu Chao <liuc63@xiaopeng.com>

can: j1939: check received packet count before completing session

This commit adds a packet receive count check in j1939_xtp_rx_eoma_one() to
abort sessions with missing data packets instead of delivering short messag=
es.
It also tightens the EOMA size mismatch warning to abort receive sessions.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fdce57924042..2ecce49ada40a 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1409,11 +1410,23 @@ j1939_xtp_rx_eoma_one(struct j1939_session *sessi=
on, struct sk_buff *skb)
>  	else
>  		len =3D j1939_tp_ctl_to_size(dat);
> =20
> -	if (session->total_message_size !=3D len) {
> +	if (!session->transmission && session->total_message_size !=3D len) {

[Severity: Medium]
Does this inadvertently suppress the diagnostic warning for EOMA size
mismatches on transmitter sessions? By adding the !session->transmission
condition here, protocol violations (a receiver sending an EOMA with an
incorrect size) are now silently ignored on the transmitter instead of
logging a warning. Could we keep the warning for transmitters but only
bypass the newly-added abort?

> +		netdev_warn_once(session->priv->ndev,
> +				 "%s: 0x%p: EOMA size mismatch, expected %i got %i\n",
> +				 __func__, session, session->total_message_size,
> +				 len);
> +		goto out_session_cancel;
> +	}

[ ... ]

>  	j1939_session_timers_cancel(session);
>  	/* transmitted without problems */
>  	j1939_session_completed(session);
> +	return;
> +
> +out_session_cancel:
> +	j1939_session_timers_cancel(session);
> +	j1939_session_cancel(session, J1939_XTP_ABORT_FAULT);
>  }

[Severity: High]
Could this error path cause a permanent leak of the session structure
and permanently block the SA/DA address pair?

If a receive session times out or is aborted, it enters the
J1939_SESSION_WAITING_ABORT state with a timer scheduled to eventually
deactivate it. If a malformed EOMA arrives while waiting, this path will
call j1939_session_timers_cancel() (which cancels the deactivation timer).

Then, j1939_session_cancel() is called:

j1939_session_cancel() {
    ...
    if (session->state >=3D J1939_SESSION_ACTIVE &&
        session->state < J1939_SESSION_WAITING_ABORT) {
        j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
    ...
}

Because the session is already in J1939_SESSION_WAITING_ABORT, the
condition fails and the deactivation timer is never restarted. The session
remains in the active_session_list indefinitely.


[Severity: High]
This is a pre-existing issue, but looking at j1939_session_cancel() exposed
by this path, could it trigger an AB-BA deadlock?

j1939_session_cancel() takes the list lock, then cancels the rx timer:

j1939_session_cancel() {
    j1939_session_list_lock(session->priv);
    ...
    j1939_tp_set_rxtimeout(session, ...); // internally calls hrtimer_cancel
}

Meanwhile, the timer callback attempts to acquire the same list lock:

j1939_tp_rxtimer() {
    ...
    j1939_session_list_lock(session->priv);
}

If j1939_session_cancel() is called exactly when the session's receive
timeout expires, the CPU executing j1939_session_cancel() would spin
waiting for the timer to finish, while the CPU executing j1939_tp_rxtimer()
spins waiting for the list lock, resulting in a deadlock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907145640.1106=
170-1-liuc63@xiaopeng.com?part=3D2
