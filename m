Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFE2246BCD;
	Sun, 11 Oct 2026 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791725273; cv=none; b=Rqmen6uAYS1qr8UsLajP4R46KbzJ072lF1ALhG+W/KU9QGct1nr2oehhMwFxVn1G1DyBlKBQ7jyIaij0DWplg81WTBP1Td6ftBEApIKq8RYGEQEoNYdZFza+Sz9gckaJavSt6V2+ME//PEFEytlYVTNprKIDlbZk8mwIgNGBpIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791725273; c=relaxed/simple;
	bh=t2nYPX13+PrWBdY+YJwT9I9mZyHTud9PCo1mcEoMNKs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AmSJHsBHEnTQ+sWj14kSDog8mIKehbk9q5gokkcsckxmSfmOPDrlbU1lWU46adPxv/X+AAAN/JzfWlhZlCBt+pIuQLfJFXgdc/yJ+DcDQ7l6rnw25rySI223fMeOy40dv3hSBbv9l+EySfrqe6c6s2r80b+i0OiUJJbXqlz1bK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzxRmWLn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzxRmWLn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973571F0089B;
	Sun, 11 Oct 2026 13:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791725272;
	bh=H8p/prb5rhIK1NK6s8uviMzmGqLW8YAmVzxAmLALto0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XzxRmWLn4QLcjW93AircWOf3roEbFhDGrtG380xhq3JIPPgWzyB7Ogfuzw9OKCi1P
	 moE9I8rH2udOXRCQw5BfMC2An5xOsEckjgzaxgivvVEobwwIzXKcjnjB87rRKZOPgk
	 AtfS95UgvwH5Awq+IyfuYsLkzjWb1nSA9irFLyFwgtpKOuNKVuWkHqvptyqq2skWg2
	 lF9N/Z3PW1jsQrkx5F6M7ZnUOg64Ku6x6SCDv727s1tW2Pf9mUn5pEyxJc+McpOl6o
	 KOBwjPEC7UrvAnfIUQCkWdRfZ4pmb2EzjUNHG5p/ev7bjEhkZSefFFusrz3WOFJ9lI
	 jn5bIUfZ9cRxw==
Subject: Re: [PATCH net v3] can: j1939: validate the EDPO packet number
From: netdev-bot+sashiko@kernel.org
To: quchaosheng000406@163.com
Cc: robin@protonic.nl, o.rempel@pengutronix.de, kernel@pengutronix.de,
 socketcan@hartkopp.net, mkl@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, sashiko-bot@kernel.org, kuba@kernel.org
Date: Sun, 11 Oct 2026 13:27:51 +0000
Message-ID: <179172527112.1406898.7083713213003423936@kernel.org>
In-Reply-To: <20261009105351.300131-1-quchaosheng000406@163.com>
References: <20261009105351.300131-1-quchaosheng000406@163.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message's justification does not match the code.
- [Medium] The new out-of-range EDPO branch in j1939_xtp_rx_dpo_one()
  calls j1939_session_timers_cancel() and then j1939_session_cancel().
- [Low] The patch fixes a NULL pointer dereference that any CAN peer, or
  any local user with a CAN/vcan interface, can trigger.
- [Low] The new EDPO range check in j1939_xtp_rx_dpo_one() assumes the
  EDPO always comes from the remote peer (its comment says "EDPO is peer…
- [Low] The new comment in j1939_session_completed() explains the NULL
  guard with an example: "e.g. when a peer names a packet past the end…

--

I couldn't run the reproducer. Everything below comes from reading the code at c9baa98874f5.

can: j1939: validate the EDPO packet number

This commit adds a range check on the ETP.CM_DPO packet number in
j1939_xtp_rx_dpo_one(). If the value is not below pkt.total, the session
is aborted with J1939_XTP_ABORT_BAD_EDPO_OFFSET. It also stops
j1939_session_completed() from passing a NULL skb from
j1939_session_skb_get() to j1939_sk_recv().

Link: https://sashiko.dev/#/patchset/20260928193312.553632-1-mkl@pengutronix.de?part=3

> Reaching the dereference needs two things, and this patch keeps them as
> two separate changes because neither is sufficient alone:

[ ... ]

> The reproducer in the link was run three times in each configuration: the
> unpatched kernel panics 3/3, a kernel with only the NULL guard still
> panics 3/3, and this patch gives 0/3.  The middle result is the point --
> it shows the guard does not close this hole on its own, so the range check
> is not redundant with it.

[Severity: Medium]
Is this description accurate? From the code, the NULL guard alone looks
like it should stop the dereference described here.

j1939_session_skb_get() has two callers. j1939_simple_txnext() already
checks for NULL, and j1939_session_completed() is now guarded.

j1939_sk_recv() also has two callers. j1939_can_recv() passes a real skb,
and the other caller is j1939_session_completed().

With the guard in place, how does a NULL se_skb still reach this
dereference?

net/can/j1939/socket.c:j1939_sk_recv_one() {
    ...
	if (oskb->sk == &jsk->sk)
		return;
    ...
}

The range check alone also seems to cover the described trigger. For an
ETP receive session, j1939_xtp_rx_rts_session_new() sets:

	session->pkt.total = (len + 6) / 7;

The session then has a single skb of length len at offset 0. So
dpo < pkt.total gives dpo * 7 < len, and
j1939_session_skb_get_by_offset() always finds that skb.
j1939_xtp_rx_dpo_one() is the only place a receive session's pkt.dpo is
written.

If the guard-only kernel really panicked 3/3, is there a second crash site
that the commit message doesn't name? If not, could the guard-only test
setup be checked again?

The message also says the patch "keeps them as two separate changes", but
both changes are in this one commit. Should they be split into two patches,
or should the wording change?

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260928193312.553632-1-mkl@pengutronix.de?part=3
> Assisted-by: LLM
> Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>

[Severity: Low]
This fixes a NULL pointer dereference in j1939_sk_recv_one(), reached
through j1939_session_completed(), and a CAN peer can trigger it. Should
it carry a Fixes: tag and Cc: stable?

The unvalidated assignment in j1939_xtp_rx_dpo_one() comes from
9d71dd0c7009 ("can: add support of SAE J1939 protocol"):

	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);

Blame on the unguarded j1939_sk_recv() call in j1939_session_completed()
points to 7ac56e40d054 ("can: j1939: j1939_session_completed(): use
consistent name se_skb for the session skb"). That commit only renamed the
variable, so 9d71dd0c7009 looks like the right Fixes: target.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..065b4f71e9af8 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1243,9 +1243,18 @@ static void j1939_session_completed(struct j1939_session *session)
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
Can this example still happen? The same patch makes j1939_xtp_rx_dpo_one()
reject any dpo >= pkt.total before it writes session->pkt.dpo, and that is
the only place a receive session's pkt.dpo is written.

pkt.total is (len + 6) / 7 and the receive skb covers [0, len), so an EDPO
past the end of the message can no longer reach this guard.

Could the comment name a case that can still return NULL, or just say the
check is defensive?

> +		if (se_skb) {
> +			/* distribute among j1939 receivers */
> +			j1939_sk_recv(session->priv, se_skb);
> +			consume_skb(se_skb);
> +		}
>  	}

[ ... ]

> @@ -1823,14 +1832,34 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,

[ ... ]

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
> +	if (dpo >= session->pkt.total) {
> +		netdev_warn(session->priv->ndev,
> +			    "%s: 0x%p: EDPO %u out of range (total %u), aborting\n",
> +			    __func__, session, dpo, session->pkt.total);
> +		j1939_session_timers_cancel(session);
> +		j1939_session_cancel(session, J1939_XTP_ABORT_BAD_EDPO_OFFSET);

[Severity: Low]
Does the EDPO checked here always come from the peer?
j1939_tp_cmd_recv() also sends the originator's own looped-back
ETP.CM_DPO to this function:

	if (j1939_tp_im_transmitter(skcb))
		j1939_xtp_rx_dpo(priv, skb, true);

On the originator, j1939_session_tx_dpo() builds the EDPO from:

	session->pkt.dpo = session->pkt.tx_acked;

j1939_xtp_rx_cts_one() sets tx_acked from the peer's ECTS:

	session->pkt.tx_acked = pkt - 1;

That packet number is only checked for being non-zero, never against
pkt.total. So a peer ECTS with a packet number greater than pkt.total makes
the originator's own EDPO hit this check.

The transmit session is then aborted with J1939_XTP_ABORT_BAD_EDPO_OFFSET,
and the log says the EDPO is out of range.

Would J1939_XTP_ABORT_ECTS_TOO_BIG be the better abort code on the
transmitter side? The local errno is EPROTO either way, so only the code
sent on the bus and the log message differ.

> +		return;
> +	}

[Severity: Medium]
Can this leave a receive session that is already in
J1939_SESSION_WAITING_ABORT with no timer?

Say a peer sends two out-of-range EDPOs with the same PGN, the second one
within J1939_XTP_ABORT_TIMEOUT_MS of the first.

First EDPO:
  j1939_xtp_rx_dpo_one()
    j1939_session_timers_cancel()
    j1939_session_cancel()
      j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS)
      __j1939_session_cancel()   -> state = WAITING_ABORT, ABORT sent

Second EDPO:
  j1939_session_get_by_addr_locked()   -> still finds the session
  j1939_xtp_rx_dpo_one()
    j1939_session_timers_cancel()      -> cancels the abort rxtimer
    j1939_session_cancel()             -> does nothing, because of:

	if (session->state >= J1939_SESSION_ACTIVE &&
	    session->state < J1939_SESSION_WAITING_ABORT) {

Nothing re-arms rxtimer after that. So the WAITING_ABORT branch in
j1939_tp_rxtimer() never reaches j1939_session_deactivate_activate_next().

The echo of our own ABORT doesn't deactivate the session either. It
arrives with J1939_ECU_LOCAL_SRC, and j1939_xtp_rx_abort(priv, skb, true)
only matches transmission sessions.

The session then stays on priv->active_session_list. It holds its kref,
its priv and netdev references and the reassembly skb. That lasts until
the peer sends an ABORT, a new RTS or a valid DPO, or the netdev goes down.

Before this patch, every DPO went through
j1939_tp_set_rxtimeout(session, 750), which re-armed the timer.

Commit 1809c82aa073 ("net: can: j1939: j1939_xtp_rx_rts_session_active():
deactivate session upon receiving the second rts") fixed the same case for
the RTS path:

	} else if (session->state == J1939_SESSION_WAITING_ABORT) {
		/* Force deactivation for the receiver.
		...
		j1939_session_deactivate_activate_next(session);
	}

Should the DPO path do the same? Or should it skip
j1939_session_timers_cancel() when the session is already aborting?

j1939_xtp_rx_dat_one() and j1939_xtp_rx_cts_one() already use the same
cancel-then-cancel sequence. This patch adds one more frame type that can
trigger it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009105351.300131-1-quchaosheng000406%40163.com
