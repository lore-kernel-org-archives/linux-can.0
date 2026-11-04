Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817505;
	b=Rz0ZCg90BZ4XfAoBs8ICgnwIqiH/CNeot94BVBIPP3S8Oj/sbhp2b3U2ztpQCDT9m8pK
	 2NHf6CaG7XcHm3p+cGQOPeiG8TrYv2cwWyF+BtKaDh1s3JYTSmEG59eRjuuz1Www8yUKV
	 meZ6Av0aTMsnZBrbQKO7ELh59gLZr3F7cchHOywPMXnYDvNcRAIZNeFDdGYUxYYzaJIr4
	 ffpW8QPRRVRfSNfUMNtMLTxJ9ZTI5V+x/KrL8Hz0BwJ9NeY4QQsWUp+tLElHbt4ofSskT
	 C3xoSM1cpsN7+sLcqfj2zKA3s598Oc2L/1stKhIiLauV+hAOryclMMJId2SgngnrMYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817505;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6rDWYPHdG5GSFLuSeUtlQABzFtmcWKX9aIHL10jlTcE=;
	b=Rw48WSlN0/+96/nNC69UdEg9nCmenSgM5+Bn3WVBOCp79sy0whmCnKengJhKM5aj/ypD
	 tHwM53H4BxLHAFHfkiN0W8n5gsDRps1E62wbEs3Ce6kn58Ma93sKVZQ1mW3FN2kwqkRYQ
	 bR8WTNvJnfxh3mJFYavA8Hckaux/Fj77I/G/hkF0LNDliQViTZr1vAD6QaB+3mGu8FoJI
	 6wBPxBr4EBh547LHrlbfUfJRhQK8RoyrKrU+0YzfsHGenQ8PdG7DqdjqZT4sIkVA/8JGQ
	 5Wzs5WosVwco84nJgnB3w/wNqfiXZtJWNxt3jI9fYj2xyLRcXd3FScsRrnWzOPfU/MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZkqLEOq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9227F606D805
	for <linux-can@vger.kernel.org>; Wed,  4 Nov 2026 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZkqLEOq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DA81F00919;
	Wed,  4 Nov 2026 18:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793817505;
	bh=6rDWYPHdG5GSFLuSeUtlQABzFtmcWKX9aIHL10jlTcE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OZkqLEOqumNWe112ovXRs1fJReKjU7auYirn+a0WQYhYt9j7JT1hg5ulUw7zt8UfB
	 f4oDOUTH7rvv9OnFd/YohnZl+vYBqqZcmNqr5PeWD/ItmdxfhqL2SIeXytLr33FERL
	 TMpUvayIDQ8J/zixf6XSc2Kw7yq4HPcKOsZ4H7exeF5AgM6+5y6NPbCWhjmGwZv7x2
	 l6CYl4bYyLoESlOf1zfQA0V8OkboTO84b8NrBwUzsKK/c/vpr9AbzLEssulUBqUQs2
	 7bQU1cLlkBEA/XOYmWPW2f3V3OrzymnIBgxQ/7wCXdWgto+7UgFcKOYBgezjTmHxMs
	 3YLyy7jUEwGDw==
Subject: Re: [PATCH net v5 2/3] can: j1939: cancel TX timer after RX timeout
From: netdev-bot+sashiko@kernel.org
To: zihanx@nebusec.ai
Cc: linux-can@vger.kernel.org, robin@protonic.nl, o.rempel@pengutronix.de,
 kernel@pengutronix.de, socketcan@hartkopp.net, mkl@pengutronix.de,
 ecathinds@gmail.com, bst@pengutronix.de, lkp@intel.com,
 maxime.jayat@mobile-devices.fr, vega@nebusec.ai, kuba@kernel.org
Date: Wed, 04 Nov 2026 18:38:23 +0000
Message-ID: <179381750380.488853.16842631087071519691@kernel.org>
In-Reply-To: <02b6632da2b01b51edbe4c7b794ca3c473bfd559.1793681851.git.zihanx@nebusec.ai>
References: <02b6632da2b01b51edbe4c7b794ca3c473bfd559.1793681851.git.zihanx@nebusec.ai>
X-sashiko-severity: Critical
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

Critical: 1 · High: 0 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] can: j1939: race in
  j1939_session_txtimer_cancel_async_locked() drops kref
- [Low] The commit message for "can: j1939: cancel TX timer after RX
  timeout" says what the code does ("stop its TX timer after dropping…

--

can: j1939: cancel TX timer after RX timeout

When j1939_tp_rxtimer() moves an active session to WAITING_ABORT, this
patch now calls j1939_session_txtimer_cancel_async() on the session's
TX timer after dropping active_session_list_lock. That matches what
j1939_session_cancel() already does.

Link: https://bugtracker.nebusec.ai/f/11143

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 4958f7c47ca44..c85d7bb3c12d4 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c

[ ... ]

> @@ -1414,8 +1415,11 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
>  				      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
>  				      HRTIMER_MODE_REL_SOFT);
>  			__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
> +			cancelled = true;
>  		}
>  		j1939_session_list_unlock(session->priv);
> +		if (cancelled)
> +			j1939_session_txtimer_cancel_async(session);

[Severity: Critical]
Can this new call race with a synchronous j1939_session_txtimer_cancel()
on another CPU and leave the TX timer queued without its session
reference?

j1939_session_txtimer_cancel_async_locked() kicks the timer with
hrtimer_start(&session->txtimer, 0, ...) when hrtimer_try_to_cancel()
returns -1 and the timer is still queued, but it does not look at
session->txtimer_cancelers. j1939_session_txtimer_cancel() on the other
hand drops session->txtimer_lock while it waits in hrtimer_cancel(), so
holding txtimer_lock here does not serialize against it.

Consider this interleaving:

CPU0: j1939_tp_txtimer() has queued a successor through
      j1939_tp_schedule_txtimer(). At txtimer_done it sees queued ==
      true, keeps session->txtimer_ref set and returns, but
      __run_hrtimer() has not cleared the running state yet.

CPU1: j1939_session_txtimer_cancel(), for example from
      j1939_xtp_rx_abort_one(), j1939_xtp_rx_cts_one() or
      j1939_xtp_rx_rts(), increments txtimer_cancelers, gets -1 from
      hrtimer_try_to_cancel(), drops txtimer_lock and blocks in
      hrtimer_cancel().

CPU2: j1939_tp_rxtimer() reaches the new
      j1939_session_txtimer_cancel_async() call. Under txtimer_lock,
      hrtimer_try_to_cancel() also returns -1, and txtimer_ref and
      hrtimer_is_queued() are both true.

CPU0: __run_hrtimer() clears the running state.

CPU1: hrtimer_cancel() dequeues the successor and returns 1.

CPU2: hrtimer_start(&session->txtimer, 0, ...) enqueues the timer
      again.

CPU1: retakes txtimer_lock, sees ret == 1 with txtimer_ref set,
      clears txtimer_ref and calls j1939_session_put().

The timer is now queued with txtimer_ref == false and nothing pinning
the session. Once the remaining references are dropped the session can
be freed while the hrtimer is still enqueued, and j1939_tp_txtimer()
then runs on freed memory. Even if the session survives, the callback
trips WARN_ON_ONCE(!session->txtimer_ref).

The racy check lives in j1939_session_txtimer_cancel_async_locked(),
which this hunk does not touch, but this patch adds a new caller in
RX timeout context that runs concurrently with RX frame processing,
and the abort that __j1939_session_cancel() queues right before it may
itself be what drives the synchronous cancel on the receive path.

Should the async path skip the hrtimer_start() kick while
txtimer_cancelers is non-zero, or should j1939_session_txtimer_cancel()
recheck hrtimer_is_queued() under txtimer_lock after hrtimer_cancel()
returns before dropping the reference? Given the earlier question
about what this call fixes, would it be simpler to leave the TX timer
alone here and rely on the state check in j1939_tp_txtimer()?

[Severity: Low]
What failure does this fix? The commit message says what the code does:

  "stop its TX timer after dropping active_session_list_lock"

It does not say what goes wrong without the change, yet it carries
Fixes: 9d71dd0c7009 and Cc: stable.

On top of the earlier commit "can: j1939: fix TX timer reference
accounting", a TX timer that is still queued when the RX timeout fires
already looks like a no-op. j1939_tp_txtimer() checks the state before
doing anything:

net/can/j1939/transport.c:j1939_tp_txtimer() {
    ...
	j1939_session_list_lock(priv);
	can_rearm = session->state == J1939_SESSION_ACTIVE;
	j1939_session_list_unlock(priv);
	if (shutdown || !can_rearm)
		goto txtimer_done;
    ...
}

j1939_tp_schedule_txtimer() also refuses to re-arm outside ACTIVE:

	if (session->state != J1939_SESSION_ACTIVE) {
		j1939_session_list_unlock(session->priv);
		return;
	}

So after __j1939_session_cancel() moves the session to WAITING_ABORT,
a queued TX timer would fire, see the non-ACTIVE state, send nothing
and drop its session reference. The queued && (txtimer_shutdown ||
!can_rearm) branch at txtimer_done already makes a queued successor of
a running callback fire right away.

j1939_session_txtimer_cancel_async() uses hrtimer_try_to_cancel(), so
it does not stop a callback that is already running either. The only
visible difference seems to be that the txtimer session reference is
dropped a few milliseconds earlier.

The later commit "can: j1939: serialize session TX with state changes"
points the same way: it says a running TX callback "can continue and
send a stale CTS or EOMA" even with this cancellation in place.

Could the commit message describe the concrete failure from the linked
report, such as a leak, a stray frame or a splat? If there isn't one,
it could be reworded as a consistency follow-up to the
j1939_session_cancel() change. In that case, is the Cc: stable tag
still needed?

>  
>  		if (!session->sk)
>  			j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793681851.git.zihanx%40nebusec.ai
