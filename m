Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602581;
	b=trx+PxEhGpiv65vfb/XcTahiVRpWXOsh35DXrBPpoVVMQeCl5z/lZ00WXaeQDdPVbg/a
	 K0YMBUGzGzzT+u9Be4eqf5LQ56NuRYbjat9mHxjhzB2kQFmJc36JfdoE/5IrjMDnGUVja
	 2vHKq4pk8n7v59+twqsPlwM4No1IJ4UImrFSPTtDnOJiqKAAfS4uYXrYVnKrN13ntXz6w
	 mF6wGFh2CN+thu421/O5rLLLJj76C0zjri9raXPjr74awlkiaLbG9sxX3DirD3RMm0xsi
	 J4lW9wCP2VF6tkn9QRrIAPh9MddVjoMb40ZisVGiJ5f4rXHWSYZvhqoQTu7ZTGG9RLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602581;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wud4C/mIhueZpyZM/xGOisgEgShfFSaFZckKVDRT5KY=;
	b=ZAL0WGUVXT8Km19U4eh0p5TrQD9phui/399sS/B1XhXIEZW5vk5MMzO63cbNGS65w0pr
	 lP7+FrLiwoeKeYBedrIzgKGxOK7t52oLXXH5xWwZNuA5m8/ldwaRVKwqiU7fgsc77Q6V3
	 c13E8DZyZtVaGaj85xU1Y4UmS5N7HtPZP9TZORAzltX+W3ypWK0Bn20jIr2iCfyNouIIi
	 8dFbHxei7hHCIn7iKGeZ3XNhZsCoNM2wBpIs14yCP0VDnZrPiKLyUGc6+z9GGiwLCHopG
	 U4zKTjVkncfLzkKf4lNoxkW5n9UsYTrvmBagHU1q5cHtylAhu9nlNZQaLUg3XxIg0Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TqtUr1sB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3497A606A31D;
	Wed, 21 Oct 2026 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TqtUr1sB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA511F000C1;
	Wed, 21 Oct 2026 17:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792602580;
	bh=wud4C/mIhueZpyZM/xGOisgEgShfFSaFZckKVDRT5KY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TqtUr1sBCeAEFUDFDFCIil+Sw8cfGaXt70z8giVk8UIan5ki914F83TcpddO77CgA
	 rNH67DqTa3c7ie47xUNBFojaCQxEaWBpP9+XSxv9pNEGSr345B8Vgx4eD6tnpkYkW0
	 ALktntHFGnzRMEzMda3JIaebkL11fACQBXcZFYwtCTOP8/S/jqA701+/fy+1UHzFae
	 Z8BQWD9m3KdMx7fPssr8+pgouIfb5dz+VAFqIleJLGnKOTP0tlu8o/CY/xzzRwdPf1
	 P8iTt+wN8wr6dM5Y2fhlLspEbXwGP58V+5E7M0XI00XIE4utBqTmV6rKqqJUlZ9hG3
	 HgB698JvwtXbA==
Subject: Re: [PATCH net v5] can: j1939: validate the EDPO packet number
From: netdev-bot+sashiko@kernel.org
To: quchaosheng000406@163.com
Cc: robin@protonic.nl, o.rempel@pengutronix.de, kernel@pengutronix.de,
 socketcan@hartkopp.net, mkl@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, sashiko-bot@kernel.org, kuba@kernel.org
Date: Wed, 21 Oct 2026 17:09:39 +0000
Message-ID: <179260257977.3131.9208782139437391826@kernel.org>
In-Reply-To: <20261020032219.80117-1-quchaosheng000406@163.com>
References: <20261020032219.80117-1-quchaosheng000406@163.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch adds a return value to j1939_session_cancel() so
  callers can tell when it did nothing because the session was already…
- [Medium] Parts of the commit message's account of the transmitter-role
  check are wrong, and the new branch sends a misleading abort code.
- [Low] The new comment in j1939_session_completed()
  (transport.c:1251-1256) gives 'when a peer names a packet past the end…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the helper the
  patch modifies has a deadlock.
- [Low] j1939_xtp_rx_dpo_one() now range-checks the EDPO value before
  storing it in pkt.dpo.

--

can: j1939: validate the EDPO packet number

This patch rejects an ETP.CM_DPO whose packet number is at or past
pkt.total and aborts the session with J1939_XTP_ABORT_BAD_EDPO_OFFSET.
It changes j1939_session_cancel() to report whether it started the abort,
so the new EDPO path can force-deactivate a session that is already
waiting for an abort. It also adds a NULL skb check to
j1939_session_completed().

Link: https://sashiko.dev/#/patchset/20260928193312.553632-1-mkl@pengutronix.de?part=3

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..8e171b7138594 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1158,13 +1158,16 @@ static void __j1939_session_cancel(struct j1939_session *session,
>  		j1939_sk_send_loop_abort(session->sk, session->err);
>  }
>  
> -static void j1939_session_cancel(struct j1939_session *session,
> +static bool j1939_session_cancel(struct j1939_session *session,
>  				 enum j1939_xtp_abort err)
>  {
> +	bool active = false;
> +
>  	j1939_session_list_lock(session->priv);
>  
>  	if (session->state >= J1939_SESSION_ACTIVE &&
>  	    session->state < J1939_SESSION_WAITING_ABORT) {
> +		active = true;
>  		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);

[Severity: High]
This isn't a bug introduced by this patch, but can j1939_session_cancel()
deadlock against the rxtimer callback here?

The lock is held with spin_lock_bh() while j1939_tp_set_rxtimeout() does
a synchronous cancel:

j1939_session_cancel()
  j1939_session_list_lock()
  j1939_tp_set_rxtimeout()
    j1939_session_rxtimer_cancel()
      hrtimer_cancel(&session->rxtimer)

j1939_tp_rxtimer() takes the same lock on every branch. It takes it
directly in the active branch:

	} else {
		j1939_session_list_lock(session->priv);

and through j1939_session_deactivate() in the WAITING_ABORT and
J1939_SIMPLE branches.

Suppose CPU A is in j1939_tp_txtimer() and reaches the -EOVERFLOW case, or
the default case (for example -ENOENT or -ENOMEM). It calls
j1939_session_cancel() without cancelling the rxtimer first.

If CPU B is running this session's j1939_tp_rxtimer() at the same time and
is spinning on active_session_list_lock, then CPU A waits in
hrtimer_cancel() for CPU B while holding the lock CPU B needs.

The new EDPO caller calls j1939_session_timers_cancel() first, but the
txtimer callers don't. Could the helper cancel the rxtimer before taking
the lock, or re-arm it without a synchronous cancel?

[ ... ]

> @@ -1243,9 +1248,18 @@ static void j1939_session_completed(struct j1939_session *session)
>  
>  	if (!session->transmission) {
>  		se_skb = j1939_session_skb_get(session);
> -		/* distribute among j1939 receivers */
> -		j1939_sk_recv(session->priv, se_skb);
> -		consume_skb(se_skb);
> +
> +		/* The offset "pkt.dpo * 7" is not necessarily covered by a
> +		 * queued skb, e.g. when a peer names a packet past the end of
> +		 * the message in an EDPO.  j1939_simple_txnext() already
> +		 * guards its call the same way; dropping the message is
> +		 * better than handing a NULL skb to j1939_sk_recv().
> +		 */

[Severity: Low]
Can the example in this comment still happen after this patch?

The new check in j1939_xtp_rx_dpo_one() returns before pkt.dpo is assigned
whenever dpo >= pkt.total. For a receiver session pkt.dpo is therefore
either 0 or a validated value, and (pkt.total - 1) * 7 lies inside the
reassembly skb.

Should the comment describe the NULL check as defense in depth, as the
commit message does?

[ ... ]

> @@ -1823,14 +1837,36 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,
>  				 struct sk_buff *skb)
>  {
>  	const u8 *dat = skb->data;
> +	unsigned int dpo;
>  
>  	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
>  		return;
>  
>  	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
>  
> +	dpo = j1939_etp_ctl_to_packet(dat);
> +
> +	/*
> +	 * EDPO is peer controlled.  It names the packet the announced window
> +	 * starts at, and j1939_xtp_rx_dat_one() places data at
> +	 * "dat[0] - 1 + pkt.dpo", so it has to stay inside the message.  A
> +	 * value past the end moves pkt.dpo beyond the reassembled buffer and
> +	 * makes the ETP completion path look up offset "pkt.dpo * 7", which is
> +	 * no longer covered by any queued skb.
> +	 */

[Severity: Low]
This is a pre-existing issue, but the comment says pkt.dpo "has to stay
inside the message". Only this writer enforces that. The other writer,
j1939_session_tx_dpo(), still does:

	session->pkt.dpo = session->pkt.tx_acked;

and tx_acked comes from an unchecked CTS packet number in
j1939_xtp_rx_cts_one():

	session->pkt.tx_acked = pkt - 1;

j1939_xtp_txnext_transmiter() then calls j1939_session_tx_dat() with that
value before the echo reaches the new check. In that case
j1939_session_skb_get_by_offset() returns NULL, so it fails safely with
-ENOBUFS retries and then -ENETUNREACH. The commit message also says CTS
validation will be a separate change.

Could the comment say that the transmitter-side writer is not covered
yet?

> +	if (dpo >= session->pkt.total) {
> +		netdev_warn(session->priv->ndev,
> +			    "%s: 0x%p: EDPO %u out of range (total %u), aborting\n",
> +			    __func__, session, dpo, session->pkt.total);
> +		j1939_session_timers_cancel(session);
> +		if (!j1939_session_cancel(session,
> +					  J1939_XTP_ABORT_BAD_EDPO_OFFSET))
> +			j1939_session_deactivate_activate_next(session);

[Severity: High]
This handles a second out-of-range EDPO. What happens if the next bad
frame is an ETP.DT or an ETP.CM_CTS instead?

The other callers still ignore the new return value. In
j1939_xtp_rx_dat_one():

 out_session_cancel:
	kfree_skb(se_skb);
	j1939_session_timers_cancel(session);
	j1939_session_cancel(session, abort);
	j1939_session_put(session);

j1939_xtp_rx_cts_one() has the same out_session_cancel pattern, and so
does the first branch of j1939_xtp_rx_rts_session_active().

Take this sequence from a remote node:

  ETP.CM_RTS            -> receive session created
  ETP.CM_DPO (>= total) -> WAITING_ABORT, abort rxtimer armed
  ETP.DT with DLC != 8, or while last_cmd is still ETP_RTS
                        -> out_session_cancel in j1939_xtp_rx_dat_one()

j1939_session_get_by_addr() still finds the WAITING_ABORT session.
j1939_session_timers_cancel() removes the abort timer.
j1939_session_cancel() then does nothing, because the state is already
J1939_SESSION_WAITING_ABORT. Nothing is left to deactivate the session.

The receiver's own abort echo doesn't recover it. That echo is handled by
j1939_xtp_rx_abort(priv, skb, true), which only matches transmission
sessions.

Now suppose the last J1939 socket is closed. __j1939_rx_release() calls
j1939_priv_set(priv->ndev, NULL), so j1939_netdev_notify() can no longer
reach j1939_cancel_active_session().

Does that leave the session's netdev_hold() reference held forever, so
that unregister_netdevice() waits indefinitely?

The commit message says:

  The abort branch must not strand a session that is already waiting for
  an abort.

and:

  two out-of-range EDPOs followed by two RTS frames leave the receiving
  session deactivated; no netdev reference remains stuck

The timers_cancel() plus cancel() pattern predates this patch. Two
malformed DT frames can strand a session on their own. This patch adds
another peer-controlled way into WAITING_ABORT, though.

Would it be more robust to handle the already-WAITING_ABORT case inside
j1939_session_cancel(), or to stop callers from cancelling an armed abort
timer, instead of fixing each caller separately?

[Severity: Medium]
For a transmission session, this sends J1939_XTP_ABORT_BAD_EDPO_OFFSET to
the responder. A transmitter only sees an out-of-range EDPO here when the
responder sent an oversized packet number in ETP.CM_CTS. The in-tree enum
describes that case as:

	J1939_XTP_ABORT_ECTS_TOO_BIG = 15,
	/* ECTS requested packets exceeds message size */

j1939_tp_txtimer() already uses that code for -EOVERFLOW. Should the
transmitter role send J1939_XTP_ABORT_ECTS_TOO_BIG here, so the responder
isn't told its EDPO was bad when it never sent one?

A few statements in the commit message also don't seem to match the
code. It says:

  Rejecting the looped-back EDPO aborts the transmission instead of
  letting it run with an offset that cannot be encoded.

tx_acked is pkt - 1, where pkt is a non-zero 24-bit value, so
j1939_session_tx_dpo() writes it to dat[2..4] without truncation. Only
dat[1] = pkt.last - pkt.tx_acked wraps.

This check also runs on the CAN echo, after j1939_session_tx_dpo() has
already put the EDPO on the bus. Before the patch the transmitter didn't
run with that offset either. j1939_session_tx_dat() gets -ENOBUFS from the
skb lookup, and the session eventually ends with -ENETUNREACH.

It also says:

  Make j1939_session_cancel() report whether it started the abort, and
  force-deactivate the receiver when it did not.  This is the same
  recovery used by the second-RTS path.

The code force-deactivates both roles, and only when
j1939_session_cancel() returns false. The second-RTS path in
j1939_xtp_rx_rts_session_active() always deactivates the transmitter. It
deactivates the receiver whenever the state is J1939_SESSION_WAITING_ABORT
after the call.

Could the commit message be updated to match the code?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020032219.80117-1-quchaosheng000406%40163.com
