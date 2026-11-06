Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793938731;
	b=HE38+7QWcFsZiTWWySn++BeWB4zE9F2Dv23ct1O9xgOv/tTe4JgJ7OscTVYtNWUc+COg
	 QsIwEFxj/BN6KDs/egEzfzNhI/UPaaAHxAsWKE/eb22kpXrtlV0rNWGk4hnuEXGHHLNBw
	 3YbFejhg5zKQ++K5RXOYmGp9rcobV3CII1dNBY9cbhEUaxrwzFISNJkaKx01lDEfWnO7i
	 nXPRyoq7DypHeObrJisjkBnwtD0p8oWWK10Yi+CQtR4bLTw0pjmwVbblt7fVy71yYmcYm
	 YSIAITjQCZnljikJuhokDBCvq0Hf7oxmx5nmCWaQ4E9FCYg02Ir7JGiJ/1fkhSrXzzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938731;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hG0DQlDJ3fqB6/pU1ARHXwcxenrjgm5IkMXxY+iXdSU=;
	b=wxtKGZfEXR2yR9R42ufSr9HKWfo7F4IaYkyNmW2vhXqeEc5pOB1XtRudvfPJWHRnWzu7
	 42k2dwOaC115Itv1k67W3Xk4BLWbY9fZDRZ8E+whmnhZkJYcZ/nbjoNFICzMG+N/iM+zH
	 GGEJC3CY8uHXD+kzPB6sSjveH5QuDstzXn5XOLAVUCpMCSb0RVWeSv4pWZmw6bgksrW0I
	 pAJH7gzSPql6Eh44LuOnhV2Bhunw0a6NYIBwPf3m++N2FP/kJrkS1Jq6lCOjDOcooY1ZU
	 MYcULnxT6dtJ+IgURmEvl38UV5fOUKk35HiZ3KpWLkgIjTKmRbz5V4nDHZNu1IdZbEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Erpanaxs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B2E606A32E
	for <linux-can@vger.kernel.org>; Fri,  6 Nov 2026 04:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Erpanaxs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA691F008A3;
	Fri,  6 Nov 2026 04:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793938730;
	bh=hG0DQlDJ3fqB6/pU1ARHXwcxenrjgm5IkMXxY+iXdSU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Erpanaxsr3in46Nmxh+HAMfHSQceXU2qXxGWKO4ZnuYXj1xw/YSF4OpTmQcPfFYWt
	 TASi6/MYu9WMkT2Hb/f2nKUlXzAbRU8EBC13dp200bTsg4xwV+HdfSr2vG/5pjZhyC
	 LlagjHk85+2G0nRiQ+nkPPjqBl7PHV75gwOr1Zl1+SBzG9HU2Ev5yzW8MLYj1E5OmV
	 GbAXu7kFdxxlR8Dv64aonWsFYk3jV0DmEbqhid6OLQjxwgrIiOt0cTE8xHhWsGqLVw
	 MI6MT+IRAkYei7lRb55a6A9YMMcEE8gCcPKc9pQ9RoMv5FwiNlXmVTBYl1GJjWQCMP
	 c/F0Vj7cSY+Lg==
Subject:
 Re: [PATCH net v6 1/2] can: j1939: account for timer references across rearm
From: netdev-bot+sashiko@kernel.org
To: zihanx@nebusec.ai
Cc: linux-can@vger.kernel.org, robin@protonic.nl, o.rempel@pengutronix.de,
 kernel@pengutronix.de, socketcan@hartkopp.net, mkl@pengutronix.de,
 lkp@intel.com, bst@pengutronix.de, dev.kurt@vandijck-laurijssen.be,
 maxime.jayat@mobile-devices.fr, vega@nebusec.ai, kuba@kernel.org
Date: Fri, 06 Nov 2026 04:18:49 +0000
Message-ID: <179393872965.488853.13839884999102482015@kernel.org>
In-Reply-To: <a05ee3472a73152e352fd7320f51431ae366e773.1793788955.git.zihanx@nebusec.ai>
References: <a05ee3472a73152e352fd7320f51431ae366e773.1793788955.git.zihanx@nebusec.ai>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message for "can: j1939: account for timer
  references across rearm" describes only timer reference accounting.
- [Low] The commit message names no concrete trigger and no user-visible
  impact for the refcount bug it fixes.
- [Low] In j1939_xtp_rx_rts_session_active() the comment on the
  receiver's forced deactivation is now stale.
- [Low] Two new comments in j1939_xtp_rx_abort_one() promise a single
  abort report: "Only the terminal path that wins the state transition…

--

can: j1939: account for timer references across rearm

The patch adds a per-timer lock, a reference flag, a shutdown flag and a
canceler count, so that txtimer and rxtimer each hold exactly one session
reference while queued or running. It reworks the cancel, rearm and
callback completion paths. It also gates the terminal state transitions
(deactivate, cancel, complete, remote abort) on the session state.

Link: https://bugtracker.nebusec.ai/f/11143

> Track one session reference for each timer lifetime spanning queued and
> running states. Serialize timer restart, cancellation, and callback
> completion so rearming an active timer cannot leak or lose its pin.
>
> Apply the same lifetime accounting to the RX timer and stop terminal
> paths from leaving queued timers behind.

[Severity: Medium]

The message only describes timer reference accounting. The patch also
seems to change protocol behaviour and behaviour that userspace can see.
Should these changes be described here, or split into separate patches?

Compared with the baseline:

j1939_xtp_rx_abort_one(): a remote ABORT used to always overwrite
session->err with j1939_xtp_abort_to_errno(). It was then reported via
j1939_sk_send_loop_abort() or J1939_ERRQUEUE_RX_ABORT. If the session is
already in J1939_SESSION_WAITING_ABORT, it is now only deactivated.
session->err keeps the local errno and nothing more is reported, which
changes the sk_err and ee_errno that userspace sees.

j1939_session_completed(): this now returns early unless the state is
J1939_SESSION_ACTIVE. An EOMA or final broadcast DAT that arrives after a
local abort no longer delivers se_skb via j1939_sk_recv(). It also no
longer activates the next session.

j1939_session_cancel(): this now returns bool. It deactivates at once if
__j1939_tp_set_rxtimeout() cannot arm the abort timeout.

j1939_tp_schedule_txtimer(): this silently does nothing unless the state
is J1939_SESSION_ACTIVE and no cancel or shutdown is pending. Also,
j1939_tp_set_rxtimeout() no longer rearms in J1939_SESSION_WAITING_ABORT.
Later CTS/DAT handling can therefore no longer replace the abort timeout.

j1939_simple_txnext(): the echo timeout is now armed after
j1939_send_one() instead of before it.

The synchronous j1939_session_timers_cancel() calls before
j1939_session_cancel() are removed from the CTS, DAT and RTS error paths.

The netdev_alert() calls in j1939_tp_txtimer() and j1939_tp_rxtimer()
now print only when the caller wins the state transition.

The new comment "Only the terminal path that wins the state transition
reports abort" suggests the patch also fixes double-deactivation and
double-report races. The message does not mention these. The follow-up
commit "can: j1939: serialize TX with session shutdown" does not describe
these changes either.

Since this is tagged for stable, could the message say which hunks fix
the refcount problem and which ones change protocol or reporting
behaviour?

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..fbeb858956e03 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c

[ ... ]

> @@ -716,18 +868,68 @@ static int j1939_xtp_tx_abort(struct j1939_priv *priv,
>  
>  void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec)
>  {
> -	j1939_session_get(session);
> +	j1939_session_list_lock(session->priv);
> +	if (session->state != J1939_SESSION_ACTIVE) {
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
> +	/* One pin covers an armed timer and any callback/successor overlap. */
> +	if (!session->txtimer_ref) {
> +		j1939_session_get(session);
> +		session->txtimer_ref = true;
> +	}
> +
>  	hrtimer_start(&session->txtimer, ms_to_ktime(msec),
>  		      HRTIMER_MODE_REL_SOFT);

[Severity: Low]

This isn't a bug, but the commit message does not name a concrete
trigger or a user-visible impact for the refcount bug fixed here.

In the baseline, j1939_tp_schedule_txtimer() always did:

	j1939_session_get(session);
	hrtimer_start(&session->txtimer, ...);

j1939_xtp_rx_dat_one() calls it without cancelling first:

	} else if (do_cts_eoma) {
		j1939_tp_set_rxtimeout(session, 1250);
		if (!session->transmission)
			j1939_tp_schedule_txtimer(session, 0);

A txtimer may already be queued, for example an -ENOBUFS retry scheduled
10-25 ms out. In that case hrtimer_start() silently replaces it, and the
queued timer's session reference leaks.

The leaked session keeps its priv reference and netdev tracker (see
j1939_session_destroy()). A DAT frame from the bus can therefore leave
device unregister stuck.

The message only says that rearming "cannot leak or lose its pin". It
does not say which path leaks a pin and which path loses one (a possible
use-after-free). The Link: also points to a tracker that is not public.

Could the message describe the triggering path and the impact, so that
stable backporters can judge it?

[ ... ]

> @@ -1371,13 +1691,32 @@ static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
>  		    session, j1939_xtp_ctl_to_pgn(skb->data), abort,
>  		    j1939_xtp_abort_to_str(abort));
>  
> +	/* Only the terminal path that wins the state transition reports abort. */

[Severity: Low]

Is this comment accurate for RX sessions? It suggests userspace sees a
single abort report, and so does "A local abort already owns the error
report" below. However, j1939_session_destroy() queues another report
when the last reference is dropped:

	} else if (session->err) {
		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
	}

__j1939_sk_errqueue() does not de-duplicate RX_ABORT. It is gated only
by SOF_TIMESTAMPING_RX_SOFTWARE. An RX session (session->sk == NULL) that
is aborted via j1939_xtp_rx_abort_one(), j1939_session_cancel() or
j1939_tp_rxtimer() therefore still produces a second RX_ABORT errqueue
entry at destroy time.

The duplicate report existed before this patch. Could the comment be
reworded so it does not promise a single report?

> +	j1939_session_list_lock(priv);
> +	spin_lock(&session->rxtimer_lock);
> +	rxtimer_shutdown = session->rxtimer_shutdown;
> +	spin_unlock(&session->rxtimer_lock);
> +	if (!rxtimer_shutdown && session->state == J1939_SESSION_ACTIVE) {
> +		session->err = j1939_xtp_abort_to_errno(priv, abort);
> +		deactivate = j1939_session_deactivate_locked(session);
> +		report = deactivate;
> +	} else if (!rxtimer_shutdown &&
> +		   session->state == J1939_SESSION_WAITING_ABORT) {
> +		/* A local abort already owns the error report. */
> +		deactivate = j1939_session_deactivate_locked(session);
> +	}

[ ... ]

> @@ -1727,7 +2065,6 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
>  			     __func__, session, skcb->addr.sa, skcb->addr.da,
>  			     session->last_cmd);
>  
> -		j1939_session_timers_cancel(session);
>  		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
>  		if (session->transmission) {
>  			j1939_session_deactivate_activate_next(session);

[Severity: Low]

Both j1939_session_timers_cancel() calls are now gone from
j1939_xtp_rx_rts_session_active(). Is the comment just below still
accurate?

		} else if (session->state == J1939_SESSION_WAITING_ABORT) {
			/* Force deactivation for the receiver.
			 * If we rely on the timer starting in j1939_session_cancel,
			 * a second RTS call here will cancel that timer and fail
			 * to restart it because the state is already WAITING_ABORT.
			 */
			j1939_session_deactivate_activate_next(session);

The first j1939_session_cancel() now moves the receiver to
J1939_SESSION_WAITING_ABORT. It also arms the abort rxtimer through
__j1939_tp_set_rxtimeout(..., true). The second j1939_session_cancel()
fails the state < J1939_SESSION_WAITING_ABORT check and does nothing.

Nothing in this function cancels the abort timer any more. The timer
stays queued until j1939_session_deactivate() cancels it asynchronously.

The reason given in the comment no longer applies. Should the comment be
updated?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793788955.git.zihanx%40nebusec.ai
