Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793401745;
	b=yArCAJ8577bxKpIvwLWUKG0dg+ix2ButKiUBi8i6xTvaYbtOPEq/nukk6YBrin2wPkbl
	 2WmT3TO4wARwm4vnN1qRC+aprmH4q5k5a4wB5/iejPX0X5lSfMwZwGXSlmgzPvxK4wclV
	 PBNXVB2z68oztUsxay+GfdmuecZCJe3PZZ0eO5ZCquaTziR/8U129D87KMlBiT92+/QmY
	 VAbx7fn8RkqIY+Ss1z/sxrqIH4lRxg1YKsXeY8oGIYvjWpkyotNUGpb16alq2YQ0GAJK4
	 s58YO+wznwO6xyqhrZob6SkaUmay9VK34e/2rlfiOFkl1IAEX95p2BQYuGEqt+VGOCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793401745;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IiWUEIlhjeb51F3IsNl9xE//H3Z+R4gE4rB8NaFBeq4=;
	b=oORZkqlf2v8qsYu+Ge5i39Im0qOB+yuRF94Ju9/oaOJ5C0jTAIe+cS8uY+kHnbKB3Frr
	 u+jrf3rgGBtQOvDQr6+iyBsCMhQyl21nPyTyGcLWzZOC76aYfIkz3rak9OL7cSlo6GkZn
	 hmtFmPia4MzTI73Zpd1IXdZBzgo3L7kqbvYR5TWPI/5j0qcgAkSl2+V2zV5yLxqgmla7v
	 ceUDbXw9XTTfZBr2oao8JN4haBjgoA8Sy/yI1MiorKkl7Z9sv/Agw292fOytKTaRkbaAP
	 TH5fpj8rQuoKRglNCVOTrwUGG0iSg+6vzBZLJ+CXyjMJkIVMsi/gNP4kNdMJ++yLhKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X0xamLfg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A63606A31A;
	Fri, 30 Oct 2026 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X0xamLfg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D42E1F000C1;
	Fri, 30 Oct 2026 23:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793401744;
	bh=IiWUEIlhjeb51F3IsNl9xE//H3Z+R4gE4rB8NaFBeq4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X0xamLfgujhrO/Gibsh8LsoP0x6vGKE9830DB6BKwLeLwGm6vyIHrZSIqJu4hXenA
	 q7l3bxwdxfx928BjHEqcCn+pbUAbnW+Q79JqB5uEoUILbOU9DsTPjoSDPeaxwaRBku
	 QMjyAWlJ7XPfU9pMyzYGgDn9wE8ISsMgnClNKaURr6qnZttkdwIjVImtTtJ21hlGL0
	 oIY/tE9w9YzsO0au+Lm6adtglbQ32fi/gDeRqA3Ab4i5+cMnBMxXzrVCAPSgIpGSvg
	 lc2fEHuJd6m4zXbfk/6X4iuuuB6l6jnmVpOxAZkcmYvgY5/3xx0m+HMeyVK+C+s9cC
	 vqG4+ZNEi7vLQ==
Subject:
 Re: [PATCH net v3 1/3] can: j1939: fix session reference leaks on timer rearm
From: netdev-bot+sashiko@kernel.org
To: zihanx@nebusec.ai
Cc: linux-can@vger.kernel.org, llvm@lists.linux.dev, robin@protonic.nl,
 o.rempel@pengutronix.de, kernel@pengutronix.de, socketcan@hartkopp.net,
 mkl@pengutronix.de, ecathinds@gmail.com, dev.kurt@vandijck-laurijssen.be,
 maxime.jayat@mobile-devices.fr, bst@pengutronix.de, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 vega@nebusec.ai, kuba@kernel.org
Date: Fri, 30 Oct 2026 23:09:02 +0000
Message-ID: <179340174277.3127.3604810896327361577@kernel.org>
In-Reply-To:
 <21bf54f2fbab33155e924e0743f17b1e47655255.1793259424.git.zihanx@nebusec.ai>
References:
 <21bf54f2fbab33155e924e0743f17b1e47655255.1793259424.git.zihanx@nebusec.ai>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 2 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In j1939_tp_schedule_txtimer_locked() and
  j1939_tp_set_rxtimeout_locked(), the reference bookkeeping for the…
- [Medium] j1939_tp_rxtimer() now skips the timeout abort while a
  temporary drain is in progress (the `!session->rxtimer_cancelers` re-…
- [Medium] j1939_xtp_rx_abort_one() now assigns session->err =
  j1939_xtp_abort_to_errno() only while the session is in…
- [Low] In this commit, j1939_tp_txtimer() samples txtimer_shutdown and
  session->state under their locks, drops the locks, and then sends…

Pre-existing issues:
- [High] j1939_session_tx_dat() picks se_skb using session->pkt.tx, then
  reads session->pkt.tx again inside the loop to compute `offset =…
- [Medium] j1939_session_timers_cancel() drains the RX timer even when it
  holds the abort timeout of a session already in…

--

can: j1939: fix session reference leaks on timer rearm

This commit tracks queued-timer and running-callback session references
separately for the j1939 TX and RX hrtimers. It also adds a txtimer_lock
and an RX drain counter so that rearming is gated during cancellation, and
it moves next-session txtimer scheduling outside the socket queue lock.

Link: https://bugtracker.nebusec.ai/f/11143
Link: https://lore.kernel.org/all/cover.1793012287.git.zihanx@nebusec.ai/

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..0dd08d1b8f755 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c

[ ... ]

> @@ -714,23 +832,117 @@ static int j1939_xtp_tx_abort(struct j1939_priv *priv,
>  	return j1939_xtp_do_tx_ctl(priv, re_skcb, swap_src_dst, pgn, dat);
>  }
>  
> -void j1939_tp_schedule_txtimer(struct j1939_session *session, int msec)
> +static void j1939_tp_schedule_txtimer_locked(struct j1939_session *session,
> +					     int msec)
>  {
> -	j1939_session_get(session);
> +	bool queued;
> +	int ret;
> +
> +	lockdep_assert_held(&session->txtimer_lock);
> +	if (session->txtimer_shutdown)
> +		return;
> +
> +	/* Replace the queued pin; a running callback retains its separate pin. */
> +	ret = hrtimer_try_to_cancel(&session->txtimer);

[ ... ]

> +	} else {
> +		/* A dispatched callback may already have requeued the timer. */
> +		queued = hrtimer_is_queued(&session->txtimer);
> +		if (!queued && !session->txtimer_cbref &&
> +		    session->txtimer_qref) {
> +			/* Claim the reference of the dispatched callback. */
> +			WARN_ON_ONCE(session->txtimer_cb_running);
> +			session->txtimer_qref = false;
> +			session->txtimer_cbref = true;
> +			session->txtimer_cb_running = true;
> +		}
> +		if (!session->txtimer_qref) {
> +			j1939_session_get(session);
> +			session->txtimer_qref = true;
> +		}
> +	}
> +
>  	hrtimer_start(&session->txtimer, ms_to_ktime(msec),
>  		      HRTIMER_MODE_REL_SOFT);
>  }

[Severity: High]

Can the hrtimer_is_queued() check here race with the hrtimer core?

hrtimer_try_to_cancel() returns -1 whenever the callback is running, even
if the timer has already been enqueued again. txtimer_lock does not
serialize against __run_hrtimer(), which dequeues and dispatches the next
expiry while holding only the hrtimer base lock.

Consider:

CPU X                                CPU Y
j1939_tp_txtimer() (C1)
  txtimer_done:
    qref = true, cbref = false
    hrtimer_start()
  spin_unlock_bh(&txtimer_lock)
                                     j1939_tp_schedule_txtimer_locked()
                                       hrtimer_try_to_cancel() == -1
                                       hrtimer_is_queued() == true
                                       no new reference taken
C1 returns, timer expires
__run_hrtimer() dispatches C2
C2 spins on txtimer_lock
                                       hrtimer_start()
                                     spin_unlock_bh(&txtimer_lock)
C2: cbref == false, so
    qref = false, cbref = true

At this point the timer is queued with txtimer_qref == false. If C2 does
not rearm, it puts its cbref. Then the next expiry, or
j1939_session_txtimer_cancel() seeing hrtimer_try_to_cancel() == 1, puts a
reference that nobody holds.

Could this underflow the session kref and lead to a use-after-free of
struct j1939_session?

The external rearm can come from j1939_xtp_rx_cts_one() or
j1939_xtp_rx_rts() on a remote CTS/RTS frame. Hard irqs stay enabled under
spin_lock_bh(), and on PREEMPT_RT the holder can be preempted, so the
window between hrtimer_is_queued() and hrtimer_start() can be stretched.

j1939_tp_set_rxtimeout_locked() makes the same hrtimer_is_queued() decision
for rxtimer_qref under active_session_list_lock. Does it have the same
problem?

[ ... ]

> @@ -806,7 +1018,8 @@ static int j1939_session_tx_dpo(struct j1939_session *session)
>  	return 0;
>  }
>  
> -static int j1939_session_tx_dat(struct j1939_session *session)
> +static int j1939_session_tx_dat(struct j1939_session *session,
> +				unsigned int *txtimer_delay)
>  {
>  	struct j1939_priv *priv = session->priv;
>  	struct j1939_sk_buff_cb *se_skcb;

[Severity: High]

This isn't a bug introduced by this patch, but can j1939_session_tx_dat()
read from before se_skb->data when a concurrent CTS moves pkt.tx?

se_skb is selected using session->pkt.tx, but the loop reads pkt.tx again:

	while (session->pkt.tx < pkt_end) {
		dat[0] = session->pkt.tx - session->pkt.dpo + 1;
		offset = (session->pkt.tx * 7) - se_skcb->offset;
		len =  se_skb->len - offset;
		if (len > 7)
			len = 7;

		if (offset + len > se_skb->len) {

j1939_xtp_rx_cts_one() can run in the CAN RX softirq on another CPU and
does this with no serialization against the txtimer callback:

	session->pkt.tx_acked = pkt - 1;
	...
	session->pkt.tx = session->pkt.tx_acked;

Once the echoed DPO has set last_cmd to DPO, a new ETP CTS is no longer
rejected as a duplicate.

For example, take a second segment with se_skcb->offset == 1785 and a CTS
for packet 255. pkt.tx becomes 254 and offset becomes -7. len is clamped
to 7, and offset + len is 0 in unsigned arithmetic, so the bounds check
passes. This copy then sends 7 bytes of uninitialized headroom (reserved
for the CAN header by j1939_sk_alloc_skb()) onto the bus:

		memcpy(&dat[1], &tpdat[offset], len);

Could pkt.tx be sampled once per iteration, or could the bounds check be
done with signed arithmetic?

[ ... ]

> @@ -1165,7 +1385,8 @@ static void j1939_session_cancel(struct j1939_session *session,
>  
>  	if (session->state >= J1939_SESSION_ACTIVE &&
>  	    session->state < J1939_SESSION_WAITING_ABORT) {
> -		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
> +		j1939_tp_set_rxtimeout_locked(session,
> +					      J1939_XTP_ABORT_TIMEOUT_MS);
>  		__j1939_session_cancel(session, err);
>  	}
>  

[Severity: Medium]

This is a pre-existing issue, but what rearms the abort timeout for a
session that is already in J1939_SESSION_WAITING_ABORT?

The out_session_cancel paths in j1939_xtp_rx_cts_one() (duplicate CTS) and
j1939_xtp_rx_dat_one() (malformed DAT) do:

 out_session_cancel:
	j1939_session_timers_cancel(session);
	j1939_session_cancel(session, err);

j1939_session_timers_cancel() drains the rxtimer that held the abort
timeout. j1939_session_cancel() only rearms when the state is below
J1939_SESSION_WAITING_ABORT. The new rxtimer_pending handling only keeps
rearms requested during the drain, not the timeout that was already
queued.

Does this leave the session on active_session_list in WAITING_ABORT with
no timer? If so, it would block the socket's session queue until socket
close or NETDEV_DOWN reaches j1939_cancel_active_session(). For RX
sessions, a new RTS through j1939_xtp_rx_rts_session_active() would also
clear it.

The baseline code (hrtimer_cancel() followed by the same state check)
behaves the same way.

> @@ -1180,13 +1401,35 @@ static enum hrtimer_restart j1939_tp_txtimer(struct hrtimer *hrtimer)

[ ... ]

> +	spin_lock_bh(&session->txtimer_lock);
> +	/* A concurrent rearm may already have recorded the callback pin. */
> +	if (!session->txtimer_cbref) {
> +		WARN_ON_ONCE(session->txtimer_cb_running);
> +		WARN_ON_ONCE(!session->txtimer_qref);
> +		session->txtimer_qref = false;
> +		session->txtimer_cbref = true;
> +	}
> +	session->txtimer_cb_running = true;
> +	shutdown = session->txtimer_shutdown;
> +	spin_unlock_bh(&session->txtimer_lock);
> +
> +	j1939_session_list_lock(priv);
> +	state = session->state;
> +	j1939_session_list_unlock(priv);
> +	if (shutdown || state != J1939_SESSION_ACTIVE)
> +		goto txtimer_done;
> +
>  	if (session->skcb.addr.type == J1939_SIMPLE) {
>  		ret = j1939_simple_txnext(session);
>  	} else {
>  		if (session->transmission)
> -			ret = j1939_xtp_txnext_transmiter(session);
> +			ret = j1939_xtp_txnext_transmiter(session, &txtimer_delay);
>  		else
>  			ret = j1939_xtp_txnext_receiver(session);
>  	}

[Severity: Low]

The state and txtimer_shutdown are sampled, and the locks dropped, before
any frames are sent. A concurrent j1939_cancel_active_session(),
j1939_session_deactivate() or abort could therefore move the session to
J1939_SESSION_DONE while j1939_simple_txnext() or
j1939_xtp_txnext_transmiter() is still transmitting.

With only this commit applied, can frames still be sent for a session that
is being torn down? The baseline had no gate here at all.

This looks closed later in the series by "can: j1939: stop TX sends after
session shutdown". That commit adds tx_send_lock and tx_send_shutdown, and
re-checks the state in j1939_session_tx_send() right before
j1939_send_one().

[ ... ]

> @@ -1271,18 +1558,24 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)

[ ... ]

>  	} else {
>  		j1939_session_list_lock(session->priv);
> -		if (session->state >= J1939_SESSION_ACTIVE &&
> +		if (!session->rxtimer_cancelers &&
> +		    session->state >= J1939_SESSION_ACTIVE &&
>  		    session->state < J1939_SESSION_ACTIVE_MAX) {
>  			netdev_alert(priv->ndev, "%s: 0x%p: rx timeout, send abort\n",
>  				     __func__, session);
> -			j1939_session_get(session);
> -			hrtimer_start(&session->rxtimer,
> -				      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
> -				      HRTIMER_MODE_REL_SOFT);
> +			j1939_tp_set_rxtimeout_locked(session,
> +						      J1939_XTP_ABORT_TIMEOUT_MS);
>  			__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
>  		}
>  		j1939_session_list_unlock(session->priv);
> @@ -1291,6 +1584,13 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
>  			j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
>  	}

[Severity: Medium]

With the new rxtimer_cancelers check, the abort is skipped while a
temporary drain is running. The notification after it is still
unconditional:

		if (!session->sk)
			j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);

Suppose the drain is j1939_xtp_rx_dat_one() handling the final DAT frame,
waiting in hrtimer_cancel() through this chain:

j1939_session_timers_cancel()
  j1939_session_rxtimer_cancel_sync(session, true)

Would every matching error queue subscriber get a J1939_EE_INFO_RX_ABORT
record with ee_errno = session->err (usually 0)? j1939_session_completed()
would then still deliver the full message.

For drain callers that do abort (j1939_xtp_rx_abort_one() and the CTS/DAT
out_session_cancel paths), would subscribers see RX_ABORT twice?

[ ... ]

> @@ -1372,7 +1672,11 @@ static void j1939_xtp_rx_abort_one(struct j1939_priv *priv, struct sk_buff *skb,
>  		    j1939_xtp_abort_to_str(abort));
>  
>  	j1939_session_timers_cancel(session);
> -	session->err = j1939_xtp_abort_to_errno(priv, abort);
> +	j1939_session_list_lock(priv);
> +	if (session->state >= J1939_SESSION_ACTIVE &&
> +	    session->state < J1939_SESSION_ACTIVE_MAX)
> +		session->err = j1939_xtp_abort_to_errno(priv, abort);
> +	j1939_session_list_unlock(priv);
>  	if (session->sk)
>  		j1939_sk_send_loop_abort(session->sk, session->err);
>  	else

[Severity: Medium]

session->err is now only updated while the session is between
J1939_SESSION_ACTIVE and J1939_SESSION_ACTIVE_MAX. Both notifications
still read it unconditionally.

A concurrent completion, timer deactivation or j1939_cancel_active_session()
could move the session to J1939_SESSION_DONE before this check. In that
case, does j1939_sk_send_loop_abort() set sk->sk_err to a stale value or 0
and still call sk_error_report()? The J1939_ERRQUEUE_RX_ABORT record would
carry the same stale ee_errno.

Before this patch the assignment was unconditional, so the reported errno
always matched the abort.

Should the notifications be skipped when the state check fails, or use the
computed errno directly?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793259424.git.zihanx%40nebusec.ai
