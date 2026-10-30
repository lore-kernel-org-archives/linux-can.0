Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793401746;
	b=eqB+CxzX2jxMRYf95rgIXIdJ33SXvFGhwSw6DSFUcN9cnCSwHREyEjdTmzB1PfwYzt24
	 iooRp3ocp1WoAofGytJQjFf1DFnFV1rtN78k8TA+Pdtin70cH1yQ9YcF+2s3PJ7Z4bLVT
	 XNLxlaXD5uIRARbFO81H/49gzjOi8yvkgzApVDejMbBb0b/vSkg5zXPI9MH289bxjfwIP
	 xyGhbk4V9YsWtCV9Vkf3CWV57C0uRs85A0fOQRk5026tqkoo26VPNosfwkhIZy7x7oidC
	 F+8q6WqBoDKYbNpRAeE8tRk5LQNcK5NZyCRBgZZjEXXL/yAexoUX+I9Nv7V/bTAEJrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793401746;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=UOebfsV8ruMm8Sd4ySId9aD6oaOR37CKCPx4EACeHMw=;
	b=vTGzupPkF/Fg56D9zXtq4/ClVNmWG89HK5gBPO4erzDgvYIKeWCoSZWqgntxs7GCK+Sy
	 b/HdLDpo2kXDzav6rNQW7EDYc1gB3VdHFZKTEdfeqO/En9MlYRZgpfU2XkAssePBgmhUS
	 eiZwYIS8dhgkE925j6cixDg/LzfelUfSkpMSPf2qVr9Wi2MzpkPsspP1vrMgAIXkJuUkm
	 cXLJPXJ50083IH7n9kwOqgw/xdSmYVqZXFQw7U0Wrt5MxHx6pQeKVj1cW5n4xaULCJipi
	 79xZhi+WzBmwa3uU8jNayKFiQHzs6lMrrjL+PdzPGnANSyCfoGKl4zYcWqG/MK/qnGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lb5euS4I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10658606A31A;
	Fri, 30 Oct 2026 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lb5euS4I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D6E1F0093A;
	Fri, 30 Oct 2026 23:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793401745;
	bh=UOebfsV8ruMm8Sd4ySId9aD6oaOR37CKCPx4EACeHMw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lb5euS4IA7wWllTrgBtb0vhygX2PF1JZJ/Ak7Olr72lkWQxHMKEaYgljYHpYtDqWw
	 YIF3Di5+K2huRJ+qZuelQtrd0aOFUGOsXZvY1h6eGM7zA4N7tpoRlKcHZUxscBPkfT
	 30jAWvoETqWtl571d5JUNwVYiX8MYmK/vnIW9/hAd8g8C9XFbJTp9syo1kWdYWgsRK
	 oCVfMFPV3kSl3hYepTJGMTDdN+imhqNjPekgfVQM+ekgjyL1vLMQuPFWxIVkGQ2gJ0
	 9MSlrdZB6/PISUvYJNBLEdkpKtwtRosnw0YTzzfTeyOXSoNRuK8/qycY49+VKkHYz/
	 GFGzUQ6EgQJ+w==
Subject:
 Re: [PATCH net v3 2/3] can: j1939: stop TX sends after session shutdown
From: netdev-bot+sashiko@kernel.org
To: zihanx@nebusec.ai
Cc: linux-can@vger.kernel.org, llvm@lists.linux.dev, robin@protonic.nl,
 o.rempel@pengutronix.de, kernel@pengutronix.de, socketcan@hartkopp.net,
 mkl@pengutronix.de, ecathinds@gmail.com, dev.kurt@vandijck-laurijssen.be,
 maxime.jayat@mobile-devices.fr, bst@pengutronix.de, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 vega@nebusec.ai, kuba@kernel.org
Date: Fri, 30 Oct 2026 23:09:04 +0000
Message-ID: <179340174433.3127.11663908076902020426@kernel.org>
In-Reply-To:
 <a683b6afb2c21e0d05be0ebe18c4f60b98152d25.1793259424.git.zihanx@nebusec.ai>
References:
 <a683b6afb2c21e0d05be0ebe18c4f60b98152d25.1793259424.git.zihanx@nebusec.ai>
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

Critical: 0 · High: 1 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] can: j1939: unconditional error notifications outside session
  state guards
- [Medium] A SIMPLE (single-frame) session whose RX echo timeout fires
  before its gated send can leave the owning socket's session queue…
- [Low] The new send gate j1939_session_tx_send() returns -ESHUTDOWN when
  tx_send_shutdown is set or the session is no longer…
- [Low] Two new comments do not match the code.

--

can: j1939: stop TX sends after session shutdown

This patch adds a per-session tx_send_lock and a tx_send_shutdown flag.
Session data and control frames now go through a new
j1939_session_tx_send() gate, which drops the frame with -ESHUTDOWN once
the session is no longer active or the gate is closed. The deactivation
and cancel paths now take tx_send_lock, and an incoming abort closes the
gate before the timers are drained.

Link: https://bugtracker.nebusec.ai/f/11143
Link: https://lore.kernel.org/all/cover.1793012287.git.zihanx@nebusec.ai/

> diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
> index c0a4c14782400..6bf55b7dfffcc 100644
> --- a/net/can/j1939/j1939-priv.h
> +++ b/net/can/j1939/j1939-priv.h
> @@ -238,6 +238,10 @@ struct j1939_session {
>  	struct list_head sk_session_queue_entry;
>  	struct kref kref;
>  	struct sock *sk;
> +	/* Serializes session TX sends against transition to DONE. */
> +	spinlock_t tx_send_lock;
> +	bool tx_send_shutdown;
> +

[Severity: Low]
This isn't a bug, but is this comment narrower than what the lock actually
covers?

__j1939_session_cancel() now asserts tx_send_lock before it sets
J1939_SESSION_WAITING_ABORT. Also, j1939_session_tx_send() rejects any
state other than J1939_SESSION_ACTIVE. So sends are serialized against the
WAITING_ABORT transition too, not only against DONE.

The new comment in j1939_xtp_rx_abort_one() has a similar problem:

	/* Stop TX callbacks before waiting for the timer callbacks to drain. */
	j1939_session_tx_send_shutdown(session);

j1939_session_tx_send_shutdown() only sets tx_send_shutdown, which makes
j1939_session_tx_send() fail. It doesn't stop a txtimer callback that is
already running. That callback keeps doing its non-send work, such as
j1939_tp_set_rxtimeout() in j1939_session_tx_dat() or
j1939_simple_txnext(), until j1939_session_timers_cancel() drains it.

Could these two comments describe the lock and the send gate more
precisely?

[ ... ]

> @@ -779,10 +802,11 @@ static int j1939_tp_tx_dat(struct j1939_session *session,
>  	if (j1939_tp_padding && len < 8)
>  		memset(skb_put(skb, 8 - len), 0xff, 8 - len);
>  
> -	return j1939_send_one(priv, skb);
> +	return j1939_session_tx_send(session, skb);
>  }

[Severity: Low]
Will the new -ESHUTDOWN result be logged as an alert in
j1939_session_tx_dat()? That loop only filters out -ENOBUFS:

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
}

Here is the sequence. A txtimer callback passes its entry check while the
session is still active. Before the next j1939_tp_tx_dat() call, another
CPU closes the gate. That can happen through j1939_xtp_rx_abort_one() when
a peer abort arrives, through j1939_cancel_active_session(), or through
the rxtimer cancel path. The result is an alert-level "queue data error:
-108" line.

The window is widest when j1939_tp_packet_delay is 0, because several data
frames are sent in one callback.

j1939_tp_txtimer() treats the same value as an expected race:

	case -ESHUTDOWN:
		/* A terminal path won before this packet could be sent. */
		break;

Should j1939_session_tx_dat() skip the alert for -ESHUTDOWN as well?

[ ... ]

> @@ -1298,7 +1323,7 @@ static int j1939_simple_txnext(struct j1939_session *session)
>  
>  	j1939_tp_set_rxtimeout(session, J1939_SIMPLE_ECHO_TIMEOUT_MS);
>  
> -	ret = j1939_send_one(priv, skb);
> +	ret = j1939_session_tx_send(session, skb);
>  	if (ret)
>  		goto out_free;
>  

[Severity: Medium]
Can this permanently stall the socket's session queue for a J1939_SIMPLE
session?

The 10 s echo rxtimer is armed before the gated send. Suppose two things
happen:

- the txtimer callback stalls for 10 s or more between
  j1939_tp_set_rxtimeout() and j1939_session_tx_send(), for example a
  starved ktimers thread on PREEMPT_RT, or vCPU steal
- the rxtimer runs on another CPU

The J1939_SIMPLE branch of j1939_tp_rxtimer() then does:

			session->err = -ETIME;
			j1939_session_deactivate_locked(session);
		...
		j1939_session_txtimer_cancel_async(session);
		j1939_session_rxtimer_cancel(session);

It never calls j1939_sk_queue_activate_next().

When the txtimer resumes, j1939_session_tx_send() returns -ESHUTDOWN, so
j1939_simple_txnext() jumps to out_free and skips:

	j1939_sk_errqueue(session, J1939_ERRQUEUE_TX_SCHED);
	j1939_sk_queue_activate_next(session);

The new -ESHUTDOWN case in j1939_tp_txtimer() also just breaks.

The session, now in J1939_SESSION_DONE, stays at the head of
jsk->sk_session_queue with no timer left. j1939_sk_send_loop() only
activates a session when j1939_sk_queue_session() reports an empty queue.
Later sendmsg() calls would queue behind the dead session and never be
sent until the socket is closed or the netdev goes down.

Before this patch, the resumed callback called j1939_send_one() and then
j1939_sk_queue_activate_next(), so the queue moved forward.

Should the -ESHUTDOWN path for J1939_SIMPLE sessions still advance the
socket queue?

[ ... ]

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1579,6 +1623,7 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
>  			__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
>  		}
>  		j1939_session_list_unlock(session->priv);
> +		spin_unlock_bh(&session->tx_send_lock);
>  
>  		if (!session->sk)
>  			j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);

[Severity: High]
Can the abort notifications still fire after the state guard has
decided that this path does not own the transition?

This patch takes tx_send_lock around the guarded blocks in
j1939_session_cancel() and j1939_tp_rxtimer(). The
j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT) call after each
block is still unconditional.

In the else branch of j1939_tp_rxtimer(), an RX session (session->sk
is NULL) can reach the locked block while another CPU is draining it
through j1939_session_rxtimer_cancel_sync(session, true). That happens
from j1939_session_timers_cancel() on the final packet in
j1939_xtp_rx_dat_one(), and from j1939_xtp_rx_abort_one().

With rxtimer_cancelers non-zero, __j1939_session_cancel() is skipped
and session->err stays 0. Every matching socket still gets an RX_ABORT
error queue entry with ee_errno 0. In the final-packet case, user
space sees an abort for a transfer that is completing normally. In
the rx_abort_one case, subscribers get the RX_ABORT twice.

j1939_session_cancel() has the same shape. Suppose j1939_tp_txtimer()
gets -EOVERFLOW or an unknown error after another path has already
moved the session to WAITING_ABORT or DONE. The guard then skips
__j1939_session_cancel(), but RX subscribers still get another
RX_ABORT.

j1939_xtp_rx_abort_one() has the same problem. The session can reach
DONE while j1939_session_timers_cancel() is draining, for example
through j1939_cancel_active_session() or the WAITING_ABORT branch of
j1939_tp_rxtimer(). In that case session->err is not updated, yet
j1939_sk_send_loop_abort() still writes the old value into
sk->sk_err and calls sk_error_report(). That value is either 0 or
whatever error the winning path left there. For an RX session the
function queues one more RX_ABORT.

Should each of these paths record under the lock whether it actually
performed the cancel or deactivation, and notify user space only when
it did? Or are these duplicate and zero-errno notifications considered
acceptable?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793259424.git.zihanx%40nebusec.ai
