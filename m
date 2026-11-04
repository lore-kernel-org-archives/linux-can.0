Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817507;
	b=mOhwDusP0PdTaVm2MDmNT8YgLCK0CHudlq3Ye9bp6Gob5ysld87ksjKhN+9cfv0z2xnW
	 ww7xImETSLAB/MoWfXZzpEy9bfltLBQ4DSbxeu7EkIArXQulF26WJZiEYj4oHb8Gh5TqZ
	 f5Sr8RnU8UC74s78lKwZB/vD9ovD17Cov1uHJCIEqUt/kY3ekVAjPyp/eB+caqTYomoUA
	 wqo+aCXYnxOW6+NgRQBpnIx3htm9Nr16rADWR2h3gpg0rIIyH4f7UHcw72BIEJcRNo+Qi
	 QPV8DYTduOFS+qR7Yq1j/7yBeb5kFd+eyy/NG/GQ2D9J7X7JKyJScSlpn657SokYr3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817507;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=qDsdcscEu1Nx/3x/zX/tYc9+NNNng7Rf5Fj/zHQmXi4=;
	b=Ba2egaAupjk3vpZLKql1uPzKugXzJz+6zWcbId/kgLDyq+HPz8S6LovcbV9aolQeEq6g
	 SscSJpj+2lpjKlxAL1aOPlzl+LVxup75b8QoJPy6xKEFwRjxbzcx8qzv5XlIZ2zt/X2tk
	 H93Ab6RNGgYylnus3ynC8XvnTIFoF5K+Lno9/4ln5TVy6HT7LFmAaZULtuvjtI2bvruv/
	 RiyhYwDUYEokje6Ev2KoWWY5HkZlcqc95McoJEaxMR9CP5b6kDNdQurWvs3u4/cEoH6oE
	 MRkFbJab49zJs8hcDYF8AB6gLqYjDWpPYxMDtNSCS6eCbLMsT+XFsImgfO7Rpohyp9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SMK8Kmf9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD97606EE98
	for <linux-can@vger.kernel.org>; Wed,  4 Nov 2026 18:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SMK8Kmf9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACAAC1F00A20;
	Wed,  4 Nov 2026 18:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793817506;
	bh=qDsdcscEu1Nx/3x/zX/tYc9+NNNng7Rf5Fj/zHQmXi4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SMK8Kmf9yU8/OL1VFq0lT7Ihufw+KUvs/cObABNFDM37RqrzRKzAQwaZ1IctlOUsI
	 xaD1qjCPo0VIojkIlEOr7sCyDxoglIdbYoL/TaH4AGFCpe1J9jvmejw+zwYsGG0IS2
	 7DOC7KNpvGsOC44lW9Oxh0ZQBM1xsO7ElEw3KXTOvoB46gwR46d5b41Cw9zkjOuO+R
	 Beo0CZczy1SKqG6wlQnmHED4NcGeB24Oacte6k8bhXY8D7XWOZIjH5xMICwlqBG2A/
	 zk7vq0hxoyz7HjAoA4mOYaXXKsSrSvyDFs9ZwhxGyOHKiQ26Joq/KigzPKbrtJFE2v
	 uK3KY/Th7LyDQ==
Subject:
 Re: [PATCH net v5 3/3] can: j1939: serialize session TX with state changes
From: netdev-bot+sashiko@kernel.org
To: zihanx@nebusec.ai
Cc: linux-can@vger.kernel.org, robin@protonic.nl, o.rempel@pengutronix.de,
 kernel@pengutronix.de, socketcan@hartkopp.net, mkl@pengutronix.de,
 ecathinds@gmail.com, bst@pengutronix.de, lkp@intel.com,
 maxime.jayat@mobile-devices.fr, vega@nebusec.ai, kuba@kernel.org
Date: Wed, 04 Nov 2026 18:38:25 +0000
Message-ID: <179381750524.488853.11293066468805707518@kernel.org>
In-Reply-To: <c7ce2c35e7d6a5097363b9b0ec69dabdc17a5326.1793681851.git.zihanx@nebusec.ai>
References: <c7ce2c35e7d6a5097363b9b0ec69dabdc17a5326.1793681851.git.zihanx@nebusec.ai>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] j1939_tp_set_rxtimeout() does j1939_session_rxtimer_cancel()
  (hrtimer_cancel plus a put if the timer was armed), then…
- [Medium] The patch introduces -ESHUTDOWN from j1939_session_tx_send()
  to mean 'a terminal state transition won before the frame was sent',…
- [Medium] j1939_session_cancel() now publishes WAITING_ABORT (via
  WRITE_ONCE in __j1939_session_cancel() under…
- [Medium] j1939_tp_rxtimer() can cancel a session a second time after
  j1939_session_cancel() has already moved it to WAITING_ABORT.
- [Low] This patch changes when user space gets RX_ABORT error-queue
  notifications, and the commit message does not say so.
- [Low] The comment in j1939_xtp_rx_rts_session_active() explains the
  forced receiver deactivation this way: 'If we rely on the timer…

--

can: j1939: serialize session TX with state changes

This patch adds a per-session tx_send_lock and a tx_send_shutdown flag.
Session frame sends now check the session state at the send point and
are serialized against terminal state changes. It also arms the RX abort
timeout in j1939_session_cancel() outside the active-session-list lock,
removes the j1939_session_timers_cancel() calls before
j1939_session_cancel() on the RX error paths, and advances the socket
queue when a simple session times out.

Link: https://bugtracker.nebusec.ai/f/11143

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index c85d7bb3c12d4..7d6ed7fb8c56b 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c

[ ... ]

> @@ -1261,19 +1302,36 @@ static void j1939_session_cancel(struct j1939_session *session,
>  
>  	if (session->state >= J1939_SESSION_ACTIVE &&
>  	    session->state < J1939_SESSION_WAITING_ABORT) {
> -		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
> -		__j1939_session_cancel(session, err);
> -		spin_lock(&session->txtimer_lock);
> -		session->txtimer_shutdown = true;
> -		spin_unlock(&session->txtimer_lock);
> -		cancelled = true;
> +		bool tx_send_shutdown;
> +
> +		spin_lock(&session->tx_send_lock);
> +		tx_send_shutdown = session->tx_send_shutdown;
> +		spin_unlock(&session->tx_send_lock);
> +		if (!tx_send_shutdown) {
> +			cancelled = __j1939_session_cancel(session, err);

[ ... ]

>  	j1939_session_list_unlock(session->priv);
> -	if (cancelled)
> +	if (cancelled) {
> +		bool keep_rxtimer;
> +
> +		/* Do not wait for the RX timer while holding the session-list lock. */
> +		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);

[Severity: Medium]
Can an old protocol rxtimer fire between the state change and this
re-arm?

By this point __j1939_session_cancel() has already written
WAITING_ABORT under the list lock. The lock is then dropped before
j1939_tp_set_rxtimeout() cancels the old rxtimer.

Suppose an earlier rxtimer expires in that window, for example the 750
or 1250 ms timeout armed by j1939_xtp_rx_dat_one() or
j1939_xtp_rx_cts_one(). j1939_tp_rxtimer() checks the state without the
lock and takes this branch:

	if (session->state == J1939_SESSION_WAITING_ABORT) {
		netdev_alert(priv->ndev, "%s: 0x%p: abort rx timeout. Force session deactivation\n",
			     __func__, session);

		j1939_session_deactivate_activate_next(session);

Would that deactivate the session right away? The abort wait would be
skipped, and the next session queued on the socket would start while
the peer may still be sending for the aborted one.

The keep_rxtimer recheck keeps the references balanced, but the grace
period is still lost. Before this patch, the RX error paths drained the
rxtimer with j1939_session_timers_cancel(), and the abort timer was
armed under the lock before the state changed.

> +		j1939_session_list_lock(session->priv);
> +		keep_rxtimer = session->state == J1939_SESSION_WAITING_ABORT;
> +		j1939_session_list_unlock(session->priv);
> +		if (!keep_rxtimer)
> +			j1939_session_rxtimer_cancel(session);
>  		j1939_session_txtimer_cancel_async(session);

[Severity: High]
Can two concurrent j1939_tp_set_rxtimeout() calls leak a session
reference here?

j1939_tp_set_rxtimeout() is not atomic:

static inline void j1939_tp_set_rxtimeout(struct j1939_session *session,
					  int msec)
{
	j1939_session_rxtimer_cancel(session);
	j1939_session_get(session);
	hrtimer_start(&session->rxtimer, ms_to_ktime(msec),
		      HRTIMER_MODE_REL_SOFT);
}

The RX error paths no longer call j1939_session_timers_cancel(). So
j1939_session_cancel() now calls this helper with no lock held, and
before j1939_session_txtimer_cancel_async(), which does not wait for a
running txtimer callback.

A txtimer callback whose frame went out just before
__j1939_session_cancel() took tx_send_lock can be in
j1939_session_tx_cts() or j1939_session_tx_eoma(), or at the end of
j1939_session_tx_dat(), at the same time:

CPU1 (j1939_xtp_rx_cts_one())          CPU2 (txtimer callback)
j1939_session_cancel()                 j1939_session_tx_dat()
  j1939_tp_set_rxtimeout()               j1939_tp_set_rxtimeout(session, 250)
    hrtimer_cancel()                       hrtimer_cancel()
    j1939_session_get()                    j1939_session_get()
    hrtimer_start()                        hrtimer_start()

Both sides take a reference, but only one timer is armed, so
j1939_tp_rxtimer() drops only one of them. The keep_rxtimer recheck
cancels at most one arm.

Would this pin the session forever, along with its skb_queue, the
j1939_priv reference and the netdev_hold() tracker from
j1939_session_new()? If so, unregister_netdevice() would wait for the
CAN interface indefinitely.

The non-atomic pattern in j1939_tp_set_rxtimeout() predates this patch.
This particular pair, though, was closed by the synchronous drain in
j1939_session_timers_cancel().

> +	}
>  
> -	if (!session->sk)
> +	if (cancelled && !session->sk)
>  		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);

[Severity: Low]
This changes when RX_ABORT is queued to user space, and the commit
message doesn't mention it.

Before the patch, j1939_session_cancel() and the else branch of
j1939_tp_rxtimer() queued J1939_ERRQUEUE_RX_ABORT whenever
!session->sk. Now it is queued only when this particular call made the
ACTIVE to WAITING_ABORT transition.

Some cases no longer produce the extra notification:

- the second j1939_session_cancel(..., J1939_XTP_ABORT_BUSY) in
  j1939_xtp_rx_rts_session_active() on the receiver side
- a stale rxtimer firing on a DONE session
- a cancel that loses to a terminal path that already called
  j1939_session_timers_cancel()

j1939_session_destroy() still sends one RX_ABORT when session->err is
set.

This looks like an intentional de-duplication. Since the patch is tagged
for stable, could the commit message list this user-visible change along
with the other side changes it describes?

>  }
>  
> @@ -1329,6 +1387,9 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)
>  		 * propagation of the error to user space.
>  		 */
>  		break;
> +	case -ESHUTDOWN:
> +		/* A terminal state transition won before the frame was sent. */
> +		break;

[Severity: Medium]
Does j1939_session_tx_dat() need the same handling for -ESHUTDOWN?

j1939_tp_txtimer() treats it as benign here, but the send loop in
j1939_session_tx_dat() still prints an alert for it:

net/can/j1939/transport.c:j1939_session_tx_dat() {
    ...
		ret = j1939_tp_tx_dat(session, dat, len + 1);
		if (ret < 0) {
			/* ENOBUFS == CAN interface TX queue is full */
			if (ret != -ENOBUFS)
				netdev_alert(priv->ndev,
					     "%s: 0x%p: queue data error: %i\n",
					     __func__, session, ret);
			break;
		}
    ...
	if (pkt_done)
		j1939_tp_set_rxtimeout(session, 250);
    ...
}

Suppose an RX error path such as j1939_xtp_rx_cts_one() cancels the
session while a block is being sent. The next j1939_tp_tx_dat() returns
-ESHUTDOWN, and "queue data error: -108" is printed for the race this
patch is meant to handle quietly.

If some frames went out before the gate closed, pkt_done is non-zero, so
j1939_tp_set_rxtimeout(session, 250) then runs on a WAITING_ABORT
session.

Could that replace the 500 ms J1939_XTP_ABORT_TIMEOUT_MS timer armed by
j1939_session_cancel() with a 250 ms one? j1939_tp_rxtimer() would then
force-deactivate the session early.

Before this patch, the RX error paths drained the txtimer with
j1939_session_timers_cancel() before cancelling. That way this callback
could not touch the rxtimer after the abort timer was armed.

>  	case -EOVERFLOW:
>  		j1939_session_cancel(session, J1939_XTP_ABORT_ECTS_TOO_BIG);
>  		break;
> @@ -1403,7 +1464,7 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
>  		 * be send as soon as CAN bus is in working state again.
>  		 */
>  		session->err = -ETIME;
> -		j1939_session_deactivate(session);
> +		j1939_session_deactivate_activate_next(session);
>  	} else {
>  		j1939_session_list_lock(session->priv);
>  		if (session->state >= J1939_SESSION_ACTIVE &&
> @@ -1414,14 +1475,15 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
>  			hrtimer_start(&session->rxtimer,
>  				      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
>  				      HRTIMER_MODE_REL_SOFT);
> -			__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
> -			cancelled = true;
> +			cancelled =
> +				__j1939_session_cancel(session,
> +						       J1939_XTP_ABORT_TIMEOUT);

[Severity: Medium]
Can this cancel a session a second time after j1939_session_cancel()
has already moved it to WAITING_ABORT?

The WAITING_ABORT check at the top of j1939_tp_rxtimer() runs without
the lock. The range check here still accepts WAITING_ABORT, because it
is below J1939_SESSION_ACTIVE_MAX:

CPU1 (e.g. j1939_xtp_rx_cts_one())      CPU2
j1939_session_cancel()                   j1939_tp_rxtimer()
  j1939_session_list_lock()                sees state ACTIVE
  __j1939_session_cancel()                 j1939_session_list_lock() spins
    state = WAITING_ABORT
    j1939_xtp_tx_abort()
  j1939_session_list_unlock()
                                           state < J1939_SESSION_ACTIVE_MAX
                                           __j1939_session_cancel(TIMEOUT)

__j1939_session_cancel() only bails out when tx_send_shutdown is set:

	spin_lock(&session->tx_send_lock);
	if (session->tx_send_shutdown) {
		spin_unlock(&session->tx_send_lock);
		return false;
	}

j1939_session_cancel() never sets that flag, so the second call would
run in full. It would:

- overwrite session->err, for example EILSEQ with EHOSTUNREACH
- send a second raw ABORT frame with a different reason code
- call j1939_sk_send_loop_abort() again
- queue another J1939_ERRQUEUE_RX_ABORT for sessions without a socket

Before this patch, the RX error paths drained the rxtimer with
j1939_session_timers_cancel() first, which closed this interleaving.
The commit message says:

    Ignore callback cancellation if a terminal path already shut down
    sends, including its raw ABORT response.

Should that also cover a session that is already in WAITING_ABORT?

>  		}
>  		j1939_session_list_unlock(session->priv);
>  		if (cancelled)
>  			j1939_session_txtimer_cancel_async(session);

[ ... ]

> @@ -1852,7 +1916,6 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
>  			return -EBUSY;
>  
>  		/* RTS on active session */
> -		j1939_session_timers_cancel(session);
>  		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
>  	}
>  
> @@ -1862,7 +1925,6 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
>  			     __func__, session, skcb->addr.sa, skcb->addr.da,
>  			     session->last_cmd);
>  
> -		j1939_session_timers_cancel(session);
>  		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
>  		if (session->transmission) {
>  			j1939_session_deactivate_activate_next(session);

[Severity: Low]
This isn't a bug, but the comment just below this in
j1939_xtp_rx_rts_session_active() now looks stale:

			/* Force deactivation for the receiver.
			 * If we rely on the timer starting in j1939_session_cancel,
			 * a second RTS call here will cancel that timer and fail
			 * to restart it because the state is already WAITING_ABORT.
			 */

It was the j1939_session_timers_cancel() call removed here that
cancelled the timer. With that call gone, j1939_session_cancel() on a
WAITING_ABORT session leaves the rxtimer alone, so a second RTS no
longer cancels the abort timer.

Should the comment be updated to match the new behaviour?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793681851.git.zihanx%40nebusec.ai
