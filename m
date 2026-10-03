Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5511C84D7;
	Sat,  3 Oct 2026 04:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791003268; cv=none; b=sRxxCk8Z5Qy9rpvjQVEjo1fGVS0xxvuvnRCCi/JiUgVCSP15l5dF1xVGnqUCjGdK0/AjtOXlKE9jUUuk/RUtcTGQKze0KUdUSJAdCiN76shY1o5Y4uZ8kaGBe1/PzCwKH03vg4pp4yEo67RWoHmSbMc/725882GDiezR2RdT+h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791003268; c=relaxed/simple;
	bh=3OXTh+oBjeDwYxskyfhntp4KmKNQB142H3W0L/SH5ig=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fwYa4HDqteByPfJ4++5wWBIqo3VaGgjPHDxblHVIXmUweJ9nP4noroYL6B6iJEFsftZOIygtLfQk8XdDcvPADAM/VoQyJr1zyzCuLrxDWb2KiQcj9AqMW5Hu0wnk2aMurQuYentkgJ+wCA7ddXv4vM/STwHAJmARwxrNnph1a04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSkcH4/3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSkcH4/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67CA1F000FF;
	Sat,  3 Oct 2026 04:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791003265;
	bh=v8sKs2lhZZePXeDFrspZsvPpoFgbeANBYb6q+5CIx0Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WSkcH4/3qY8obN/hVY/JamxOgVUZMPDz3QdzzZqFa+e3caOXglHMh+aPIFKP06pRt
	 TpsUqyVAT+aF6RMYNJj6rlbkKEamgG4eQNQlq0ajcLwysi15vOenAnzJxUiN9EV6LK
	 4cGTbUH3ovPntETGpE7yhmS2o+inqCHkXb/6vzTvVFGMFVdG8K6+RqVwKmwItQE0t4
	 TUWt/MoP+w5Xn9M5kYTKi2UVvsxVWw0YSP8b3x3gto6MPZ/jE3G/b1AQFnoKu4f6yK
	 pgDskAddhKKAAETWzeKIO6kiD8zFiqzu+pNDAia/4Qp7kRNbTvCsJRI9ZTEhN8XrUc
	 wFPdoktSrVSmQ==
Subject: Re: [PATCH net v2 RESEND] can: j1939: validate the EDPO packet number
From: netdev-bot+sashiko@kernel.org
To: quchaosheng000406@163.com
Cc: robin@protonic.nl, o.rempel@pengutronix.de, kernel@pengutronix.de,
 socketcan@hartkopp.net, mkl@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Sat, 03 Oct 2026 04:54:24 +0000
Message-ID: <179100326445.1406898.9460146166731761306@kernel.org>
In-Reply-To: <20260930055942.216879-1-quchaosheng000406@163.com>
References: <20260930055942.216879-1-quchaosheng000406@163.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the transmitter role is unaffected by
  the new check: "a transmitter derives the offset from pkt.tx_acked,…
- [Medium] The new EDPO abort branch in j1939_xtp_rx_dpo_one() calls
  j1939_session_timers_cancel() and then j1939_session_cancel() without…
- [Low] The commit message reports that a kernel with only the NULL guard
  in j1939_session_completed() "still panics 3 out of 3 runs", and uses…

Pre-existing issues:
- [Low] j1939_xtp_rx_dat_one() computes `packet = (dat[0] - 1 +
  session->pkt.dpo)` and rejects only `packet > session->pkt.total`, so…

--

can: j1939: validate the EDPO packet number

This patch checks the ETP.CM_DPO packet number against pkt.total in
j1939_xtp_rx_dpo_one(). When the number is out of range, it aborts the
session with J1939_XTP_ABORT_BAD_EDPO_OFFSET. It also adds a NULL check for
the skb returned by j1939_session_skb_get() in j1939_session_completed().

> Both roles tolerate the check because a transmitter derives the offset
> from pkt.tx_acked, which is "cts_packet - 1" with cts_packet <= pkt.total,
> so the largest value it ever announces is pkt.total - 1.

[Severity: Medium]

Where is the cts_packet <= pkt.total bound enforced? In
j1939_xtp_rx_cts_one(), the peer's 24-bit packet number is rejected only
when it is 0 or when dat[1] is larger than pkt.block:

net/can/j1939/transport.c:j1939_xtp_rx_cts_one() {
    ...
	if (!pkt)
		goto out_session_cancel;
	else if (dat[1] > session->pkt.block /* 0xff for etp */)
		goto out_session_cancel;

	/* set packet counters only when not CTS(0) */
	session->pkt.tx_acked = pkt - 1;
	j1939_session_skb_drop_old(session);
	session->pkt.last = session->pkt.tx_acked + dat[1];
	if (session->pkt.last > session->pkt.total)
		/* safety measure */
		session->pkt.last = session->pkt.total;
    ...
}

Only pkt.last is clamped. tx_acked is not, and the transmitter copies it
straight into its EDPO:

net/can/j1939/transport.c:j1939_session_tx_dpo() {
    ...
	session->pkt.dpo = session->pkt.tx_acked;
	pkt = session->pkt.dpo;
    ...
}

So a peer that sends an ETP.CM_CTS with a packet number above pkt.total
makes the local transmitter put an EDPO >= pkt.total on the bus. That
EDPO is looped back through j1939_xtp_rx_dpo(priv, skb, true) into
j1939_xtp_rx_dpo_one() on the transmit session.

There the new check aborts the transmit session with
J1939_XTP_ABORT_BAD_EDPO_OFFSET. That is a receiver-side abort code, and it
is sent back to the peer and reported to the sending socket.

No memory-safety problem was found on the transmitter side.

Should j1939_xtp_rx_cts_one() also check the CTS packet number against
pkt.total? That would make the invariant in the commit message hold.

> On v7.3.0-rc5 under QEMU:
>
>   - an unpatched kernel panics 3 out of 3 runs, in j1939_sk_recv():
>       BUG: kernel NULL pointer dereference, address: 0000000000000018
>       RIP: 0010:j1939_sk_recv+0xaf/0x150
>   - with only the NULL guard in j1939_session_completed() (i.e. without
>     the EDPO range check) it still panics 3 out of 3 runs, so the guard
>     alone does not close the hole and the range check is the actual fix

[Severity: Low]

Is there an oops trace for the guard-only kernel? The only crash shown is
j1939_session_completed() passing a NULL se_skb to j1939_sk_recv(), and the
new guard removes exactly that dereference.

Here is the reproducer sequence with only the guard applied:

- The closing DT gives packet 255.
- The lookup at offset 1785 succeeds and pkt.rx reaches 256.
- The EOMA loopback then runs j1939_session_completed().
- Its lookup at offset 1792 returns NULL, and the guard now skips it.

The other users of a pkt.dpo-based lookup already handle NULL:

- j1939_simple_txnext() returns 0.
- j1939_xtp_rx_dat_one() goes to out_session_cancel.
- j1939_session_tx_dat() returns -ENOBUFS.

Where does the remaining panic come from? If there is no trace for it,
could this part of the commit message be corrected or dropped? The range
check itself still looks worth having.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..065b4f71e9af8 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c

[ ... ]

> @@ -1823,14 +1832,34 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,
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

[ ... ]

> +	if (dpo >= session->pkt.total) {

[Severity: Low]

This is a pre-existing issue and was not introduced by this patch. The new
check treats any index >= pkt.total as out of range, but the related check
in j1939_xtp_rx_dat_one() only rejects packet > pkt.total:

net/can/j1939/transport.c:j1939_xtp_rx_dat_one() {
    ...
	packet = (dat[0] - 1 + session->pkt.dpo);
	if (packet > session->pkt.total ||
	    (session->pkt.rx + 1) > session->pkt.total) {
    ...
}

Even with dpo limited to pkt.total - 1, the peer controls dat[0]. A value
of 2 still gives packet == pkt.total. The next
j1939_session_skb_get_by_offset(session, packet * 7) returns NULL and the
session is cancelled through out_session_cancel, so this does not crash.

Should j1939_xtp_rx_dat_one() use the same >= bound, for consistency?

> +		netdev_warn(session->priv->ndev,
> +			    "%s: 0x%p: EDPO %u out of range (total %u), aborting\n",
> +			    __func__, session, dpo, session->pkt.total);
> +		j1939_session_timers_cancel(session);
> +		j1939_session_cancel(session, J1939_XTP_ABORT_BAD_EDPO_OFFSET);
> +		return;
> +	}

[Severity: Medium]

Can this leave a receive session stuck in J1939_SESSION_WAITING_ABORT? The
new branch cancels both timers without checking the session state.

First out-of-range EDPO:

  j1939_session_timers_cancel()
  j1939_session_cancel()
    state is ACTIVE
    j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS)
    __j1939_session_cancel() -> state = J1939_SESSION_WAITING_ABORT

Second out-of-range EDPO with the same PGN:

  j1939_session_get_by_addr_locked() does not filter by state
  j1939_xtp_rx_cmd_bad_pgn() lets it through
  j1939_session_timers_cancel()
    hrtimer_cancel(&session->rxtimer)  <- abort timeout removed
  j1939_session_cancel()
    state is WAITING_ABORT, so rxtimer is not re-armed

j1939_session_cancel() only re-arms the timer in this case:

	if (session->state >= J1939_SESSION_ACTIVE &&
	    session->state < J1939_SESSION_WAITING_ABORT) {
		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);

The WAITING_ABORT branch in j1939_tp_rxtimer() is the only automatic way to
deactivate the session.

The receiver's own looped-back ABORT is only passed to
j1939_xtp_rx_abort(priv, skb, true), which matches transmitter sessions. So
the session and its reassembly skb stay on priv->active_session_list until
one of these happens:

- the peer sends an ABORT
- the peer sends an RTS with the same PGN
- the netdev goes down

Until then, an RTS for a different PGN on that sa/da pair is rejected with
BUSY.

Before this patch, a DPO that arrived in WAITING_ABORT went through
j1939_tp_set_rxtimeout(session, 750), which re-armed rxtimer.

The out_session_cancel paths in j1939_xtp_rx_dat_one() and
j1939_xtp_rx_cts_one() already have this exposure. This branch adds another
instance of it.

j1939_xtp_rx_rts_session_active() already handles the same problem:

		} else if (session->state == J1939_SESSION_WAITING_ABORT) {
			/* Force deactivation for the receiver.
			 * If we rely on the timer starting in j1939_session_cancel,
			 * a second RTS call here will cancel that timer and fail
			 * to restart it because the state is already WAITING_ABORT.
			 */
			j1939_session_deactivate_activate_next(session);
		}

Should the new EDPO branch do the same, or skip the timer cancel when the
session is already in WAITING_ABORT?

>  
>  	/* transmitted without problems */
> -	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);
> +	session->pkt.dpo = dpo;
>  	session->last_cmd = dat[0];
>  	j1939_tp_set_rxtimeout(session, 750);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930055942.216879-1-quchaosheng000406%40163.com
