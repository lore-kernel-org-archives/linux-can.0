Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794888166;
	b=YbTWGNyojOITM5IzMkwaPwRckQTC1B5J/mUMF5aYjnKKZMeegY0BKZzFk1CRHqxaR0Yl
	 Szw5djQSU3Lw+C3xxFLdSAbxtJtREm9QLLCltdDi/lEcbHxo6QsxXVZnx2FqLHnLF4U2G
	 e+NfXyE929LKNddH1SXRxZLlQzfIbvBeGS8tU5J1PSymFxjldfPuXLk//TZ2gbjHuPfy9
	 YU0th6pl81v53jL0VjVQWc7ThtAEt8sUN3q+Cyd2tl4KnS268NmLUiyOB9mKMqjG58yo5
	 DmIUA7vJrhIRGJ/Rp6DxAvj1Bfpv0fYfXrELvP6Y7Ms4LMJ/+R8sGGBS6mCi/WVcCGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794888166;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CQqNaLOoSeSIWM4D4HtkcwnMb5XRONCWzpVh6xYCIIw=;
	b=d6+cBCL7miSzJABick4RTgINqXsyoVvjgim4DHPCxBLTgVuEeatSl8Dym1bmQtuq6vEe
	 c5Tj5lHv1keiBW8vVCBjBWHO/5e7GbDYrdnndmTFtZt6vl3nwxIJinL4gySDAPB47LCTj
	 f1Q6m50Tfh1fd0NYRG7g90AjbxgAbXOWKBZ61fbX6mTvcZyh26/xPlemuMRpI3PWN/c3j
	 LW56jFGZ7H87jsRYNXQKlBSrba4z3ZNO5nyoXC3WsYbo+dbJTDXxnQoi4pzkwBIJF5PiG
	 EKeuIqe8+3gX8OdRD/nUPWNl034aDZaSlOSlNXnMxdyOp4I4yGx1tD4beEyOl1MsScw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJb5brXs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBF1606A31C
	for <linux-can@vger.kernel.org>; Tue, 17 Nov 2026 04:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJb5brXs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B011F000C4;
	Tue, 17 Nov 2026 04:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794888166;
	bh=CQqNaLOoSeSIWM4D4HtkcwnMb5XRONCWzpVh6xYCIIw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QJb5brXs13qT8sC0kaNA22PiY1pHnuNAgoDsaFtnCrsnE3iREZ22yDwnethltl2v3
	 X6bqNx3fpSN7ySj9pxdNdUlpdkTfr+7c+8tch8orztnvCEKrauLZiD5mUHdccuOLVt
	 Dzj1bqk+ErapxbHmXXZtBZw1EP0XmAdi1fNFpB6ElD9EdnvtdH49udP5OlBGt1lXUK
	 nl7UdIYllkAb+MLYJElW1SpYSiVTJOGauMogXAb4u9yPrFqRN5os6YHcgB203bMlx/
	 QnQWktkJVco7N1XATECNPml3FGELyngV+19jrNXyHhWk4Q55uilz+jxK+IulutA2zr
	 KPrY13clRu1fQ==
Subject:
 Re: [PATCH v14 6/6] can: j1939: defer j1939_session_destroy() to WQ context
From: netdev-bot+sashiko@kernel.org
To: penguin-kernel@I-love.SAKURA.ne.jp
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 robin@protonic.nl, kernel@pengutronix.de, socketcan@hartkopp.net,
 kuba@kernel.org
Date: Tue, 17 Nov 2026 04:02:45 +0000
Message-ID: <179488816525.3132.2669816626182950239@kernel.org>
In-Reply-To: <1ad7d101-4549-420f-a827-6bf21bae884e@I-love.SAKURA.ne.jp>
References: <1ad7d101-4549-420f-a827-6bf21bae884e@I-love.SAKURA.ne.jp>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message's main claim is wrong.
- [Medium] Moving the whole destroy path into
  j1939_session_destroy_work() makes several user-visible side effects…

--

can: j1939: defer j1939_session_destroy() to WQ context

This patch moves the j1939 session teardown from the final kref put into
a work item on j1939_wq, so that j1939_module_exit() can wait for it via
destroy_workqueue(). It also cancels session->txtimer and session->rxtimer
before the session is freed.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..87a932d10ffea 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -259,8 +259,11 @@ static void __j1939_session_drop(struct j1939_session *session)
>  	sock_put(session->sk);
>  }
>  
> -static void j1939_session_destroy(struct j1939_session *session)
> +static void j1939_session_destroy_work(struct work_struct *work)
>  {
> +	struct j1939_session *session = container_of(work, struct j1939_session,
> +						     release_work);
> +	struct j1939_priv *priv = session->priv;
>  	struct sk_buff *skb;
>  
>  	if (session->transmission) {

[ ... ]

> @@ -283,9 +286,18 @@ static void j1939_session_destroy(struct j1939_session *session)
>  		kfree_skb(skb);
>  	}
>  	__j1939_session_drop(session);

[Severity: Medium]
Moving the whole destroy path onto j1939_wq makes several side effects
that userspace can see asynchronous. The commit message doesn't mention
this. Is it intended for a stable fix?

The TX_ACK, TX_ABORT and RX_ABORT notifications from j1939_sk_errqueue()
are now built from the workqueue. __j1939_sk_errqueue() stamps the skb when
it builds it:

	skb->tstamp = ktime_get_real();

Doesn't that mean the SCM_TSTAMP_ACK timestamp for a finished TX session
now records when the work item ran, not when the session completed?

The ordering of notifications also seems to change. The final put of the
finished session often happens in j1939_sk_queue_activate_next_locked():

	list_del_init(&first->sk_session_queue_entry);
	j1939_session_put(first);

After that put, the function activates the next session. If there was no
error, it calls j1939_tp_schedule_txtimer(first, 0). Can the soft hrtimer
for session N+1 then emit TX_SCHED (via j1939_xtp_rx_cts_one()) before
the deferred work emits TX_ACK for session N? Before this patch, TX_ACK(N)
was always queued first.

Several releases now also wait for the work item:

- j1939_sock_pending_del() and the waitq wakeup in __j1939_session_drop()
- sock_put(session->sk)
- netdev_put()

So a close() blocked in j1939_sk_release() on:

	wait_event_interruptible(jsk->waitq,
				 !j1939_sock_pending_get(&jsk->sk))

and netdev unregister refcount waits now depend on j1939_wq making
progress. Should the commit message describe these changes?

> -	netdev_put(session->priv->ndev, &session->priv_dev_tracker);
> -	j1939_priv_put(session->priv);
> +
> +	/* There can't be any ref on this session because __j1939_session_release()
> +	 * was already called. But we need to make sure that j1939_tp_txtimer() and
> +	 * j1939_tp_rxtimer() are no longer running before kfree().
> +	 */
> +	WARN_ON(hrtimer_cancel(&session->txtimer));
> +	WARN_ON(hrtimer_cancel(&session->rxtimer));
> +
> +	netdev_put(priv->ndev, &session->priv_dev_tracker);
> +
>  	kfree(session);
> +	j1939_priv_put(priv);
>  }
>  
>  static void __j1939_session_release(struct kref *kref)
> @@ -293,7 +305,12 @@ static void __j1939_session_release(struct kref *kref)
>  	struct j1939_session *session = container_of(kref, struct j1939_session,
>  						     kref);
>  
> -	j1939_session_destroy(session);
> +	/* To close a race window that j1939_module_exit() starts as soon as
> +	 * j1939_priv_put() dropped the module's refcount, defer actual release
> +	 * to WQ context where j1939_module_exit() can wait for completion.
> +	 */
> +	INIT_WORK(&session->release_work, j1939_session_destroy_work);
> +	queue_work(j1939_wq, &session->release_work);
>  }

[Severity: Medium]
The commit message says this closes:

  "a race window that j1939_module_exit() starts as soon as
  j1939_priv_put(session->priv) from j1939_session_destroy() dropped
  the module's refcount"

Can that race actually happen?

Since the earlier "can: j1939: fix possibility of UAF on module unload"
change, j1939_priv_put() only queues __j1939_priv_release_work(). That
work item does module_put() from j1939_wq. In the old code, the module
text that still ran after that point was kfree(session) and the return
through __j1939_session_release() -> j1939_session_put() -> caller.

With this patch, __j1939_session_release() calls queue_work() and then
returns through the same j1939_session_put() -> caller path. The window
between dropping the last reference and leaving module text looks the
same. It now ends in queue_work() instead of j1939_priv_put().

Every caller that can drop the last session reference already seems to
be covered:

- CAN RX softirq: j1939_can_recv() runs under rcu_read_lock() in
  can_receive(), and j1939_module_exit()->can_proto_unregister() calls
  synchronize_rcu().
- txtimer/rxtimer: these use HRTIMER_MODE_REL_SOFT, so they run in
  softirq with BH disabled, and the same synchronize_rcu() waits for
  them.
- sendmsg/release syscalls: the socket holds a reference on
  j1939_proto.owner.
- netdev notifier: it runs under rtnl, and unregister_netdevice_notifier()
  takes rtnl_lock().
- j1939_wq work items: destroy_workqueue() drains them.

The patch leaves other j1939_priv_put() calls of the same shape, which
may also drop the last reference, unchanged. For example, in
j1939_can_recv():

done:
	j1939_priv_put(priv);
	kfree_skb(skb);

and in j1939_netdev_notify():

	j1939_priv_put(priv);

notify_done:
	return NOTIFY_DONE;

The behaviour changes here seem to be that hrtimer_cancel() now waits for
a running j1939_tp_txtimer() or j1939_tp_rxtimer() before kfree(), and
that j1939_priv_put() now runs after kfree(session).

Since this is tagged for stable, could the commit message describe what
the deferral actually fixes? Alternatively, could it say which caller
context was unprotected before this patch?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/1d96e742-0479-4c36-ad0a-a0aaeda0a4fc%40I-love.SAKURA.ne.jp
