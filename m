Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792788688;
	b=bMZH1ziDjomE6Gzs2VHyTmOTKw1q0HTxNwiVtYSKUUTeN6m2eFRKbRtZszwJbAsr3Qn5
	 7QqQRXOzyGiPEtdWvajoqnnXlCLF714FiTi0VMTfffjK9yeZsRYthsKjzAMpowR6BOTz1
	 vutA/ypT9aE2r+qD6dXzyrJ/cysoPWczm5rwsAfkCmvNMz2D0e9yQgxYuVRaVs81uBCCn
	 AWvmLVCzDNSZC7YPUocLVpJ/qkP5ysOcV0xr5pj6UmYooNoiIc/zRkLES408SPuJVpjXF
	 mEsd/3Qzhf1RCoDkgXTi+esDJcueiII7Hh5pkF4yl0D1EdDzasVy8BqHkK7m7uQzRpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792788688;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VUvOIWXM7GuPd9PkGOQHg8pnRxe4OjFabD76zKn4bzk=;
	b=48TIh2uWQ7k7ImStXSl8wSLlMGIzHlki112HzYnAn29cB5tQMAUsQOKZ54Dpe1PLfwTx
	 MDqwusnHsas4Zbky2bmkSlIbp3RNGelpMe5e3DlGyru8WlZsn1gK/wz/zYY0BLuhw3POE
	 7yX6+SDt5sEhFH8POX6lU1UEv2kmAsNfoOyz6cD77JYoIH2XMZGT4JYbbkh4H5aFd2H8F
	 z2qevtgg1xNw9cpxbGvQ6mc7WY0W+eZ12UQBi1zN/5qguCVCEx4iDyLpAQI1eqTtymw8Q
	 NhKkL56JRzajxUE2Cd8BgR8+NOzj9mF1B9w3Hm0/+sc6vAT462LKe+XCjn3/IwAJzpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jb+eXcln;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213CD606A320;
	Fri, 23 Oct 2026 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jb+eXcln
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4F51F031E0;
	Fri, 23 Oct 2026 20:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792788687;
	bh=VUvOIWXM7GuPd9PkGOQHg8pnRxe4OjFabD76zKn4bzk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jb+eXclnicc7zmIMH2NIPxdXki9Nhl5p/mA0O8dUef99lZpmHG7cp57/30ZJFr2ld
	 n33MS3c7Jr2fHkvN5paW7Dq1t8Jx0WrGNflvcCYRk/JWqN6mulzsPSuYoq/2/YJeiL
	 mtO664NNJpGz9jxOoZszkgXSzxVajM/JukqJ1hbd3lvFfHJ2+phzNUFlgOUM2NY3YT
	 EwdUVJ1O6EPyWubx0U3XYk6rAfZrsITeHKzVFV6TzP80zugGEg12Kog37vzaZbeJ3W
	 WYWOzGO2OjEKkl/d9wzZBFJu0ldiB4ARvxfHppuSAe4GFP37XtLdWFgCLCdQgEV2Wm
	 XCFNyqYLRtpTQ==
Subject: Re: [PATCH net v6 1/1] can: j1939: validate the EDPO packet number
From: netdev-bot+sashiko@kernel.org
To: quchaosheng000406@163.com
Cc: robin@protonic.nl, o.rempel@pengutronix.de, kernel@pengutronix.de,
 socketcan@hartkopp.net, mkl@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, sashiko-bot@kernel.org, kuba@kernel.org
Date: Fri, 23 Oct 2026 20:51:26 +0000
Message-ID: <179278868667.3130.12995219647320420687@kernel.org>
In-Reply-To: <179265494813.314254.14725785769836234084@163.com>
References: <179265494813.314254.14725785769836234084@163.com>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Deactivating a WAITING_ABORT session straight away in
  j1939_session_cancel() can let that session's own ABORT echo, still in…
- [Medium] j1939_session_cancel() now cancels the rxtimer at line 1170,
  outside active_session_list_lock.
- [Low] The new comment in j1939_xtp_rx_dpo_one() says the transmitter
  'only sees this on the echo of an EDPO it built from an oversized…
- [Low] The subject 'can: j1939: validate the EDPO packet number' covers
  only one of several independent fixes in this patch.
- [Low] Commit message process problems: (1) The body includes patch-
  revision history and a test matrix comparing revisions ('stock, v5,…

--

can: j1939: validate the EDPO packet number

This commit makes j1939_xtp_rx_dpo_one() reject an ETP.CM_DPO whose packet
number is at or past pkt.total. That stops a NULL skb from reaching
j1939_sk_recv() when the transfer completes. It also changes
j1939_session_cancel() to cancel the rxtimer outside
active_session_list_lock and to deactivate sessions already in
J1939_SESSION_WAITING_ABORT, simplifies second-RTS handling, and adds a
NULL guard in j1939_session_completed().

Link: https://sashiko.dev/#/patchset/20260928193312.553632-1-mkl@pengutronix.de?part=3

> can: j1939: validate the EDPO packet number

[Severity: Low]

This isn't a bug, but the subject only describes the EDPO bound check. The
patch also carries several independent changes:

- j1939_session_cancel() now deactivates sessions already in
  J1939_SESSION_WAITING_ABORT. This fixes an existing session/netdev
  reference strand that needs no EDPO. In the T5/T6 cases, two unparsable
  ETP.DT frames leave ip link del stuck on "unregister_netdevice: waiting
  for vcan0 to become free".

- The rxtimer cancel moves out from under active_session_list_lock. This
  addresses the hrtimer_cancel() vs j1939_tp_rxtimer() wait on the
  j1939_tp_txtimer() -EOVERFLOW and default paths.

- The second-RTS handling in j1939_xtp_rx_rts_session_active() is
  simplified.

- A NULL guard is added in j1939_session_completed().

The dpo >= pkt.total check by itself is enough to stop the T1 NULL
dereference.

Could the WAITING_ABORT deactivation and the timer/lock ordering change be
split into their own patches with their own subjects? That would let them
be bisected, reviewed and backported separately.

> Tested on v7.3-rc7 under QEMU (KVM, vcan).  Three kernels from one tree and
> one configuration (defconfig plus CONFIG_CAN_J1939=y, CONFIG_CAN_VCAN=y,
> CONFIG_LOCKDEP=y, CONFIG_DEBUG_SPINLOCK=y), differing only in this hunk:
> stock, v5, and this revision.  Each case is a standalone guest.

[ ... ]

> until the guest is killed.  v5 fixed only the caller it added, so T3
> through T6 are unchanged from stock.  This revision deactivates in the
> helper, and all four clear.

[ ... ]

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260928193312.553632-1-mkl@pengutronix.de?part=3
> Assisted-by: LLM
> Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>

[Severity: Low]

A few commit message process points. None of them affect the code.

The body compares patch revisions ("stock, v5, and this revision", "v5
fixed only the caller it added"). Could this history move below the ---
line, as Documentation/process/submitting-patches.rst describes?

The Author: line is "Quchaosheng <quchaosheng000406@163.com>", but the
Signed-off-by: line is "Chaosheng Qu <quchaosheng000406@163.com>". The email
is the same, but checkpatch will report a From:/Signed-off-by: name
mismatch.

Reported-by: is followed by Link: and not by the Closes: tag that
checkpatch's BAD_REPORTED_BY_LINK check expects.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..2cc6c46c4d50b 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1161,18 +1161,39 @@ static void __j1939_session_cancel(struct j1939_session *session,
>  static void j1939_session_cancel(struct j1939_session *session,
>  				 enum j1939_xtp_abort err)
>  {
> +	bool waiting;
> +
> +	/* Cancel the rxtimer before taking the list lock: hrtimer_cancel()
> +	 * waits for a running callback, and j1939_tp_rxtimer() takes the
> +	 * same lock.
> +	 */
> +	j1939_session_rxtimer_cancel(session);
>  	j1939_session_list_lock(session->priv);
>  
> +	waiting = session->state == J1939_SESSION_WAITING_ABORT;
>  	if (session->state >= J1939_SESSION_ACTIVE &&
>  	    session->state < J1939_SESSION_WAITING_ABORT) {
> -		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
>  		__j1939_session_cancel(session, err);
> +		/* hrtimer_start() does not wait for the callback, so arming
> +		 * the abort timer here cannot deadlock.
> +		 */
> +		j1939_session_get(session);
> +		hrtimer_start(&session->rxtimer,
> +			      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
> +			      HRTIMER_MODE_REL_SOFT);
>  	}

[Severity: Medium]

Can this leak a session reference? That happens if another path arms the
rxtimer between the cancel at the top of j1939_session_cancel() and this
get+start.

The cancel now runs before spin_lock_bh(). The get+start runs only after
__j1939_session_cancel() has sent the ABORT frame and called
j1939_sk_send_loop_abort().

The other arming path does not take active_session_list_lock:

j1939_tp_set_rxtimeout() {
	j1939_session_rxtimer_cancel(session);
	j1939_session_get(session);
	hrtimer_start(&session->rxtimer, ms_to_ktime(msec),
		      HRTIMER_MODE_REL_SOFT);
}

It is called without that lock from j1939_xtp_rx_cts_one(),
j1939_xtp_rx_dpo_one() and j1939_xtp_rx_dat_one(). So holding the list lock
here does not serialize against it. For example:

CPU0: j1939_tp_txtimer(), j1939_session_tx_dat() returned -EOVERFLOW
  j1939_session_cancel()
    j1939_session_rxtimer_cancel()  /* hrtimer_cancel() returns 0 */
    spin_lock_bh(), __j1939_session_cancel() sends the ABORT

CPU1: ETP.CM_CTS for the same session
  j1939_xtp_rx_cts_one()
    j1939_tp_set_rxtimeout()
      j1939_session_get()           /* +1 */
      hrtimer_start()

CPU0:
    j1939_session_get()             /* +1 */
    hrtimer_start()                 /* re-queues the queued timer */

One expiry of j1939_tp_rxtimer() drops only one reference. The session holds
a netdev reference through priv_dev_tracker and also a priv reference. Would
a later ip link del then hang in unregister_netdevice?

The old code had the same cancel/get/start pattern. There it ran back to
back inside j1939_tp_set_rxtimeout(). This patch widens the window to cover
lock contention and a CAN frame transmit.

The commit message says "The abort timer is then armed with hrtimer_start()
under the lock", but the lock does not serialize rxtimer arming. One option
is to call hrtimer_try_to_cancel() under the lock, since it does not wait.
The reference would be put if it returns 1, before the get+start.

>  
>  	j1939_session_list_unlock(session->priv);
>  
>  	if (!session->sk)
>  		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
> +
> +	/* The abort went out on an earlier call, and this caller has just
> +	 * cancelled the timer that would have finished the session off, so
> +	 * nothing else is left to deactivate it.
> +	 */
> +	if (waiting)
> +		j1939_session_deactivate_activate_next(session);
>  }

[Severity: Medium]

Could deactivating the WAITING_ABORT session here let its own ABORT echo,
still in flight, cancel the next transfer queued on the same socket?

Consider a socket with transmitter session A active and session B queued
behind it. Both use the same SA/DA, the same TP/ETP type and the same PGN,
which j1939_sk_queue_session() allows. The peer sends two malformed
ETP.CM_CTS frames back to back, for example with packet number 0.

First CTS:

j1939_xtp_rx_cts_one()
  goto out_session_cancel
  j1939_session_cancel()
    __j1939_session_cancel()
      j1939_xtp_tx_abort()       /* ABORT sent, echo is async */
    A->state = J1939_SESSION_WAITING_ABORT

The second CTS arrives before the echo is processed.
j1939_session_get_by_addr() still finds A, because WAITING_ABORT sessions
stay on active_session_list. last_cmd was not updated, so:

j1939_xtp_rx_cts_one()
  goto out_session_cancel
  j1939_session_timers_cancel()  /* kills the abort timer */
  j1939_session_cancel()
    if (waiting)
      j1939_session_deactivate_activate_next(A)
        j1939_sk_queue_activate_next_locked()
          j1939_session_activate(B)  /* B is ACTIVE on the list */

Only B's txtimer is delayed, by 10-25 ms. A's ABORT echo then arrives with
J1939_ECU_LOCAL_SRC set:

j1939_tp_cmd_recv()
  j1939_xtp_rx_abort(priv, skb, true)
    j1939_xtp_rx_abort_one()
      j1939_session_get_by_addr(..., false, true)  /* matches B */
      j1939_xtp_rx_cmd_bad_pgn()                   /* PGNs equal */

B is then aborted, and its sender gets an error before B has sent its RTS.
Before this patch, the second CTS left A on the list, so the echo matched A
and cleaned it up.

[ ... ]

> @@ -1823,14 +1846,42 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,

[ ... ]

> +	if (dpo >= session->pkt.total) {
> +		netdev_warn(session->priv->ndev,
> +			    "%s: 0x%p: EDPO %u out of range (total %u), aborting\n",
> +			    __func__, session, dpo, session->pkt.total);
> +		j1939_session_timers_cancel(session);
> +		/* The transmitter only sees this on the echo of an EDPO it built
> +		 * from an oversized ETP.CM_CTS packet number, so it is the
> +		 * responder's CTS that is too big, not the EDPO offset.
> +		 */
> +		j1939_session_cancel(session,
> +				     session->transmission ?
> +				     J1939_XTP_ABORT_ECTS_TOO_BIG :
> +				     J1939_XTP_ABORT_BAD_EDPO_OFFSET);
> +		return;
> +	}

[Severity: Low]

Is the claim in this comment accurate? j1939_can_recv() sets
J1939_ECU_LOCAL_SRC based on the SA alone:

	if (j1939_address_is_unicast(skcb->addr.sa) &&
	    priv->ents[skcb->addr.sa].nusers)
		skcb->flags |= J1939_ECU_LOCAL_SRC;

j1939_tp_cmd_recv() then sends any ETP.CM_DPO with that flag to the
transmitter session:

		if (j1939_tp_im_transmitter(skcb))
			j1939_xtp_rx_dpo(priv, skb, true);

This means any node on the bus that sends an out-of-range DPO with the local
SA reaches this branch. It is not limited to the echo of a locally built
EDPO. In that case the transmitter sends J1939_XTP_ABORT_ECTS_TOO_BIG to
the responder for a CTS the responder never sent.

The abort itself still happens. Only the comment and the abort reason code
look wrong. Could the comment, and the matching sentence in the commit
message, be reworded? Or could the code be chosen differently?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179265494813.314254.14725785769836234084%40163.com
