Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794520180;
	b=EsGLC6facZF6gmmbzukfrdPFRYXpIvbPDzsStv69E/BRXk3PF6eMSp5zmOsRbp+ZzNp0
	 T0vDKZGxllv2ib3YlsmLFdZsrvMSOc/bg6rhrmI1vVWlbJrARbO+LrgSwrmxF4RYzQoJ8
	 FHY8FRUbatiOmLeFaXPTq9Plg49EUmjsS13ry/1xsXf8jdfxvQR7EtWS6eOT6z0Yl0awW
	 CPvqgwlT0Wk3qpMikegHnONrFu5ElsIFKesuMM9sfWsper+MkMdJ+6xHQksc4HHbcVMm3
	 me1RBiI6NoyAq6RNuIWcM/+AvRBY255/2gV8nuraKszlNa+EML8Gsejyb2XgdzVfYaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794520180;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fA7MGIX7sFoJuHtVpQTwpMUwqWA8Po39oqIyO1NpZAM=;
	b=SfdgtRWGEsyIXe3dMljjuvYdN/p7LYA7X2LXgsJCAqIEglpPDk5DMUSNZYkk0AoGSPq8
	 Si0xV0BEnBbaU1NrD+x/rxxvTscIk9co2LZEq3sYRopYRt1Xw87FB/V5dgARc/ghrDUq7
	 DWSePL9d1/TacCAppG3CdyyocqXgFQC8pBBscritnyKkIk9V8ivMnArnm3C0J9Qste8LP
	 OxP9KmekpAhfu8ECkpWHgb3/mSQZzCz7Mov7FkqlksUMeCP2TrE13tJ/nVQllIRDjBeW/
	 5d2GedkMOIGv109MVJnqM5OKn927QUG8ZRe50kQr+eOUtyRmrspS4pVqGbyWd0s3XhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MflpITcI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B7A606A31C;
	Thu, 12 Nov 2026 21:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MflpITcI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D33B1F000C7;
	Thu, 12 Nov 2026 21:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794520180;
	bh=fA7MGIX7sFoJuHtVpQTwpMUwqWA8Po39oqIyO1NpZAM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MflpITcItcrBrCVeumrOJ58qNy01D58JYAkMje7Ht00dUxOZeQEtjzgabO9FC3zh3
	 3Kw4ZzFrrO2MVt8gnh2dfXUhxFY8Kz94ME0p+hTufo3u4f0lN6ErveeB+HVihhgxVN
	 4545SGf0Nivw25Z5m0AUvFmy0Ri1jiJB24SAHboXjJXQhUpnGW1WbKbYfPcC1TXAeU
	 K8reYynECg5g/vAj0hKB/Hu9zjPpX4xuh2LCspum+CySrus/Qu5tlAZIP9kgxIRrBb
	 SwJbZzkY+1sLZ8riGBZXnWqmEkI5qmObiqBJoe+VciYP8i7w3HmCphroJvdSAxV3gP
	 WqbsnrmAsksVw==
Subject: Re: [PATCH net v7 1/4] can: j1939: arm the abort timer under the
 session list lock
From: netdev-bot+sashiko@kernel.org
To: quchaosheng000406@163.com
Cc: robin@protonic.nl, o.rempel@pengutronix.de, socketcan@hartkopp.net,
 mkl@pengutronix.de, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 12 Nov 2026 21:49:39 +0000
Message-ID: <179452017919.488853.15478724062923628521@kernel.org>
In-Reply-To: <179410166345.60581.16722127854597502548@163.com>
References: <179410166345.60581.16722127854597502548@163.com>
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit message says the rearms take the list lock "so both
  armers are serialized".
- [High] This is a new regression: two j1939_session_cancel() calls
  running at the same time on the same session now double-arm the…
- [Medium] j1939_session_cancel() now also re-arms the rxtimer when the
  state is already WAITING_ABORT.
- [Low] The patch fixes a deadlock (hrtimer_cancel() under
  active_session_list_lock against j1939_tp_rxtimer(), which takes that…
- [Low] The subject, 'can: j1939: arm the abort timer under the session
  list lock', does not describe the change.
- [Low] This behaviour change is not described in the commit message.
- [Low] The flag abort_sent and the comment 'whether the abort frame just
  went out or the session is already in WAITING_ABORT' in…

--

can: j1939: arm the abort timer under the session list lock

This patch moves the rxtimer cancel in j1939_session_cancel() outside of
active_session_list_lock, to avoid a deadlock against j1939_tp_rxtimer().
It then re-arms the abort timer under the lock. It also re-arms the timer
for sessions that are already in J1939_SESSION_WAITING_ABORT.

> can: j1939: arm the abort timer under the session list lock

[Severity: Low]
This isn't a bug, but does the subject describe the change? Before this
patch, j1939_session_cancel() already armed the abort timer under the lock,
because j1939_tp_set_rxtimeout() was called inside
j1939_session_list_lock().

The patch makes two changes. It moves the cancel out of the lock, which is
the deadlock fix. It also re-arms WAITING_ABORT sessions, which is the
stuck-session fix.

Would these be easier to bisect and backport as two separate patches?

[ ... ]

> Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>

[Severity: Low]
Should this have a Fixes: tag and Cc: stable? git blame shows that
j1939_session_cancel(), with j1939_tp_set_rxtimeout() called inside the
lock, comes from commit d966635b384b.

The related fix 1809c82aa073 for the same session leak class carried
"Fixes: 9d71dd0c7009" and "Cc: stable@vger.kernel.org".

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..590a04c453b56 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1161,12 +1161,38 @@ static void __j1939_session_cancel(struct j1939_session *session,
>  static void j1939_session_cancel(struct j1939_session *session,
>  				 enum j1939_xtp_abort err)
>  {
> +	bool abort_sent = false;
> +
> +	/* Cancel the abort timer before taking the list lock.
> +	 *
> +	 * hrtimer_cancel() waits for a callback that is already running, and
> +	 * j1939_tp_rxtimer() takes the same lock, so cancelling the timer while
> +	 * holding active_session_list_lock can deadlock: the lock holder waits
> +	 * for the callback, the callback waits for the lock.
> +	 */
> +	j1939_session_rxtimer_cancel(session);
> +
>  	j1939_session_list_lock(session->priv);
>  
>  	if (session->state >= J1939_SESSION_ACTIVE &&
>  	    session->state < J1939_SESSION_WAITING_ABORT) {
> -		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
>  		__j1939_session_cancel(session, err);
> +		abort_sent = true;
> +	}

[Severity: Low]
This isn't a bug, but the name abort_sent doesn't quite match the code.
__j1939_session_cancel() skips j1939_xtp_tx_abort() for broadcast
sessions:

net/can/j1939/transport.c:__j1939_session_cancel() {
    ...
	session->state = J1939_SESSION_WAITING_ABORT;
	/* do not send aborts on incoming broadcasts */
	if (!j1939_cb_is_broadcast(&session->skcb)) {
    ...
}

abort_sent is still set to true in that case. __j1939_session_cancel()
also always sets J1939_SESSION_WAITING_ABORT, so the state check below is
already true whenever abort_sent is.

Is the flag needed at all? The comment below ("whether the abort frame just
went out or the session is already in WAITING_ABORT") describes two cases
that the code never distinguishes.

> +
> +	/* Re-arm under the lock, whether the abort frame just went out or the
> +	 * session is already in WAITING_ABORT and only needs its timer back.
> +	 *
> +	 * hrtimer_start() does not wait for a running callback, so arming here
> +	 * cannot deadlock, and taking the lock closes the window against
> +	 * j1939_tp_set_rxtimeout(), which rearms the same timer from the
> +	 * receive path without holding it.
> +	 */

[Severity: High]
Does taking the lock here actually close the window against
j1939_tp_set_rxtimeout()? That function is unchanged, and it still does
cancel, get and start without active_session_list_lock:

net/can/j1939/transport.c:j1939_tp_set_rxtimeout() {
	j1939_session_rxtimer_cancel(session);
	j1939_session_get(session);
	hrtimer_start(&session->rxtimer, ms_to_ktime(msec),
		      HRTIMER_MODE_REL_SOFT);
}

None of its callers hold the list lock either. That covers the RX softirq
paths and the txtimer paths: j1939_session_tx_rts(),
j1939_session_tx_dpo(), j1939_session_tx_dat(), j1939_session_tx_cts(),
j1939_session_tx_eoma() and j1939_simple_txnext().

Only one of the two armers takes the lock. Are they really serialized, as
the commit message says ("so both armers are serialized")?

The cancel is now outside the lock. Can this sequence leak a session
reference?

CPU A (j1939_session_cancel)       CPU B (j1939_tp_set_rxtimeout)
j1939_session_rxtimer_cancel()
                                   j1939_session_rxtimer_cancel()
                                     (nothing pending)
                                   j1939_session_get()
                                   hrtimer_start()
j1939_session_list_lock()
__j1939_session_cancel()
j1939_session_get()
hrtimer_start()
  (re-enqueues the already queued timer)

Both sides take a reference, but only one timer is queued.
j1939_tp_rxtimer() calls j1939_session_put() once per expiry. The reverse
order leaks the same way.

Once a kref leaks, j1939_session_destroy() never runs. So netdev_put(),
j1939_priv_put() and, for TX sessions, the sock_put() in
__j1939_session_drop() never happen either. Wouldn't unregister_netdevice()
then hang, which is the leak the commit message says this patch closes?

j1939_cancel_active_session() at unregister doesn't look able to recover
this. It only drops one rxtimer reference through hrtimer_try_to_cancel(),
plus the list reference.

Would it help to use hrtimer_try_to_cancel() under the lock and put when it
returns 1, as j1939_cancel_active_session() does? Another option is to tie
the get to whether the timer was actually inactive.

> +	if (abort_sent || session->state == J1939_SESSION_WAITING_ABORT) {
> +		j1939_session_get(session);
> +		hrtimer_start(&session->rxtimer,
> +			      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
> +			      HRTIMER_MODE_REL_SOFT);
>  	}

[Severity: High]
Can two concurrent j1939_session_cancel() calls on the same session
double-arm the rxtimer here? For example, CPU A is in
j1939_tp_txtimer()->j1939_session_cancel(). CPU B is in an RX
out_session_cancel path such as j1939_xtp_rx_dat_one() or
j1939_xtp_rx_cts_one():

CPU A                                CPU B
j1939_session_rxtimer_cancel()
  hrtimer_cancel() returns 1, put
                                     j1939_session_rxtimer_cancel()
                                       (nothing pending)
j1939_session_list_lock()
__j1939_session_cancel()
  state = WAITING_ABORT
j1939_session_get()
hrtimer_start()
j1939_session_list_unlock()
                                     j1939_session_list_lock()
                                     state == WAITING_ABORT
                                     j1939_session_get()
                                     hrtimer_start()
                                       (re-enqueues the queued timer)
                                     j1939_session_list_unlock()

That is two gets for a single expiry of j1939_tp_rxtimer(), so one kref
would never be dropped.

Before this patch, CPU B saw WAITING_ABORT under the lock and did nothing.
The WAITING_ABORT re-arm combined with the lockless cancel seems to be what
introduces this.

The commit message says "The reference accounting stays balanced: one
j1939_session_get() per hrtimer_start()". Doesn't that only hold if
hrtimer_start() is never called on a timer that is already queued?

[Severity: Medium]
Does the WAITING_ABORT re-arm conflict with the existing workaround in
j1939_xtp_rx_rts_session_active()? That code still assumes
j1939_session_cancel() won't restart the timer in WAITING_ABORT:

net/can/j1939/transport.c:j1939_xtp_rx_rts_session_active() {
    ...
		j1939_session_timers_cancel(session);
		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
		if (session->transmission) {
			j1939_session_deactivate_activate_next(session);
		} else if (session->state == J1939_SESSION_WAITING_ABORT) {
			/* Force deactivation for the receiver.
			 * If we rely on the timer starting in j1939_session_cancel,
			 * a second RTS call here will cancel that timer and fail
			 * to restart it because the state is already WAITING_ABORT.
			 */
			j1939_session_deactivate_activate_next(session);
		}
    ...
}

Take a receive session where the peer sends a second RTS. The first
j1939_session_timers_cancel() and j1939_session_cancel() pair at the top of
this function moves the session to WAITING_ABORT and arms the timer.

The second pair then kills that timer. With this patch,
j1939_session_cancel() re-arms it with a new reference.
j1939_session_deactivate_activate_next() then moves the session to DONE
without cancelling the timer.

When that timer fires on the DONE session, j1939_tp_rxtimer() takes the
generic else branch. The state check fails, but it still runs:

		if (!session->sk)
			j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);

Doesn't this deliver an extra J1939_ERRQUEUE_RX_ABORT to matching sockets
for a session that has already finished? It also keeps the session, netdev
and priv references alive for another J1939_XTP_ABORT_TIMEOUT_MS.

The comment in j1939_xtp_rx_rts_session_active() would also no longer
match what j1939_session_cancel() does.

[Severity: Low]
Is this change in timeout semantics intended? Every j1939_session_cancel()
on a session already in WAITING_ABORT now cancels the pending abort timer
and starts a fresh J1939_XTP_ABORT_TIMEOUT_MS timer.

That includes the calls from j1939_tp_txtimer(), which don't cancel the
timers first:

		if (session->skcb.addr.type != J1939_SIMPLE) {
			j1939_session_cancel(session, J1939_XTP_ABORT_OTHER);

Before this patch, those calls did nothing and the original abort deadline
stood. Now the forced deactivation happens 500ms after the last cancel,
not 500ms after the abort.

A peer could keep sending malformed TP frames less than 500ms apart, for
example DT frames with skb->len != 8 that reach out_session_cancel in
j1939_xtp_rx_dat_one(). Wouldn't that keep the session in WAITING_ABORT on
the active list indefinitely?

The commit message only says such sessions "also gets its timer back".
Could it mention that an existing pending deadline is also pushed back?

>  
>  	j1939_session_list_unlock(session->priv);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179410166344.60581.3898011861151549156%40163.com
