Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A9E1B3925;
	Sun, 11 Oct 2026 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791684651; cv=none; b=RPT9XPx1UDnAF5ueYar+XHTkB/jrGFiBXQXXsJbHpBFuXS6X2ORAAEQZeZv27DtJzp+ua1w90nQ20iaQLJ0FpyVaDerirCrAA3KcjD46PRbSd1fSAjHKSC6Yfe28pToeJNDv/HDajSJYRM/DgOmTGcTFEapBi83EdEt0CT+/+70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791684651; c=relaxed/simple;
	bh=jJ03MaPkfkcYpUf2cdCEp3/EcG0Y4RAjMEsEi9r+EHY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DIeAa/1kRvk+fHzADOexVqTyUcm/Q6ND5CUwP3xbbsJDWFZCFXN6EPnvHCauBeZ/j+aEx740lcH7/kJQYXbwNs6Ba7EIIgtlEdAuPNi9QecwTXxUNClG5K0lL8RZNJtme5euUmuaA0ZBrt3xd3fyH2g3aQScKPIRKP4LO8K9J3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZuxx4MQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZuxx4MQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEB01F000FF;
	Sun, 11 Oct 2026 02:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791684650;
	bh=lcZcdia4rKiXWIi4amZ0i+ZFPYexQVlrOWx/SubZwLk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NZuxx4MQiSABZ7TkcfwaK/8b8ez5QFzpo+RZoEDX1bVBunVPehlN4MRQZPVmtf63g
	 CJwoPHKVYVVBpRQVlTk5Q21dFgAKQGDfUB6VFajbUU+mUOEww6Eai0hX6UrSpByoiQ
	 +hidlYUnJF8OteXldlviGHzj03DCXf9DU8h4kAO6CmxxFwWVIVQozpNR4ZeM3Ufis3
	 VdFQFOrWRXmh/INlkKOV4fWmowqC8FBYXdFJDVh9nvfIN0ira4bahh9Ii12ExKKhQ1
	 kYfYvc717riHXIaEjPvPPYinuMmR53shMTNrCXXe5n3dvpKlUTjGEPKn9Sp7IRCd16
	 gBea+dvPkBeYA==
Subject: Re: [PATCH net v3] can: j1939: validate the EDPO packet number
From: netdev-bot+sashiko@kernel.org
To: quchaosheng000406@163.com
Cc: robin@protonic.nl, o.rempel@pengutronix.de, kernel@pengutronix.de,
 socketcan@hartkopp.net, mkl@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, sashiko-bot@kernel.org, kuba@kernel.org
Date: Sun, 11 Oct 2026 02:10:48 +0000
Message-ID: <179168464897.1406898.15309617109343344916@kernel.org>
In-Reply-To: <20261009105559.301873-1-quchaosheng000406@163.com>
References: <20261009105559.301873-1-quchaosheng000406@163.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message's main reason for having two hunks does not
  match the code.
- [Medium] The new EDPO abort branch in j1939_xtp_rx_dpo_one() calls
  j1939_session_timers_cancel() and then j1939_session_cancel() without…
- [Low] The patch fixes a kernel NULL pointer dereference that a peer can
  trigger: a NULL se_skb reaches j1939_sk_recv() from…
- [Low] The new comment in j1939_session_completed() justifies the NULL
  guard with "when a peer names a packet past the end of the message in…

--

can: j1939: validate the EDPO packet number

This patch adds a range check on the ETP.CM_DPO packet number, which
comes from the peer, in j1939_xtp_rx_dpo_one(). If the number is not
below pkt.total, the session is aborted with
J1939_XTP_ABORT_BAD_EDPO_OFFSET. The patch also adds a NULL check on the
skb returned by j1939_session_skb_get() in j1939_session_completed(),
before it is passed to j1939_sk_recv().

Link: https://sashiko.dev/#/patchset/20260928193312.553632-1-mkl@pengutronix.de?part=3

> Reaching the dereference needs two things, and this patch keeps them as
> two separate changes because neither is sufficient alone:

[ ... ]

> The reproducer in the link was run three times in each configuration: the
> unpatched kernel panics 3/3, a kernel with only the NULL guard still
> panics 3/3, and this patch gives 0/3.

[Severity: Medium]
Is this accurate? For the sequence in the commit message, it looks like
each hunk would be enough on its own.

With only the NULL guard, pkt.dpo == 256 and pkt.total == 256, and
j1939_session_completed() calls j1939_session_skb_get():

net/can/j1939/transport.c:j1939_session_skb_get() {
	offset_start = session->pkt.dpo * 7;
	return j1939_session_skb_get_by_offset(session, offset_start);
}

For offset 1792 this returns NULL, and the guard then skips
j1939_sk_recv().

The other users of pkt.dpo don't seem able to fault either.
j1939_simple_txnext() already returns 0 on a NULL skb.
j1939_xtp_rx_dat_one() rejects packet > total, and a failed
j1939_session_skb_get_by_offset() there goes to out_session_cancel.

With only the range check, dpo < total gives
dpo * 7 <= (total - 1) * 7 < total_message_size. So the lookup always
lands inside the single reassembly skb that j1939_session_fresh_new()
allocates.

If the guard-only kernel really panics 3/3, could that be a different
crash from the one described here? Or should the test result be checked
again?

A smaller point in the same message:

> j1939_session_skb_get() for offset "pkt.dpo * 7" -- one full packet past
> the end of the queued skb -- gets NULL

The message is 1786 bytes, so 256 * 7 = 1792 is 6 bytes past the end of
the skb, not one full packet past it.

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260928193312.553632-1-mkl@pengutronix.de?part=3
> Assisted-by: LLM
> Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>

[Severity: Low]
Should this have a Fixes: tag and Cc: stable? Before this patch,
j1939_xtp_rx_dpo_one() stored j1939_etp_ctl_to_packet() into pkt.dpo
without any check. That leads to a NULL pointer dereference in
j1939_sk_recv(), reached from j1939_session_completed().

The commit message describes a local user on vcan. On a real CAN bus,
though, it looks like any remote node could send the crafted
ETP.CM_RTS, ETP.CM_DPO and ETP.DT frames. The only requirement seems to
be a local J1939 socket that matches the session, through
j1939_sk_recv_match() in j1939_xtp_rx_rts_session_new(). In that case no
local privileges are needed.

A Fixes: tag pointing at the commit that added the unchecked pkt.dpo
assignment would help stable triage.

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
This isn't a bug, but can the EDPO example in this comment still happen?
The range check this patch adds to j1939_xtp_rx_dpo_one() keeps pkt.dpo
below pkt.total for receive sessions. And (total - 1) * 7 always falls
inside the single reassembly skb.

Would it be clearer to describe the guard as defensive, or to name a
case that can still happen after this patch?

> +		if (se_skb) {
> +			/* distribute among j1939 receivers */
> +			j1939_sk_recv(session->priv, se_skb);
> +			consume_skb(se_skb);
> +		}
>  	}

[ ... ]

> @@ -1823,14 +1832,34 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,

[ ... ]

> +	if (dpo >= session->pkt.total) {
> +		netdev_warn(session->priv->ndev,
> +			    "%s: 0x%p: EDPO %u out of range (total %u), aborting\n",
> +			    __func__, session, dpo, session->pkt.total);
> +		j1939_session_timers_cancel(session);
> +		j1939_session_cancel(session, J1939_XTP_ABORT_BAD_EDPO_OFFSET);
> +		return;
> +	}

[Severity: Medium]
Can a second out of range EDPO leave the session stuck on
priv->active_session_list?

The first bad EDPO goes through j1939_session_cancel(). That arms the
abort rxtimer and moves the session to J1939_SESSION_WAITING_ABORT.

j1939_session_get_by_addr_locked() doesn't filter by state. So a second
bad EDPO within J1939_XTP_ABORT_TIMEOUT_MS reaches this branch again:

j1939_xtp_rx_dpo_one()
  j1939_session_timers_cancel()       <- cancels the pending abort rxtimer
  j1939_session_cancel()
    if (session->state >= J1939_SESSION_ACTIVE &&
        session->state < J1939_SESSION_WAITING_ABORT) {   <- false
            j1939_tp_set_rxtimeout(...);   <- not re-armed

The only automatic path that deactivates a WAITING_ABORT session is
j1939_tp_rxtimer(). With the timer cancelled, the session would keep its
reassembly skb (up to tp_max_packet_size), the netdev tracker and the
j1939_priv reference. These would be held until the peer sends an abort
or a new RTS, or the interface is torn down.

Before this patch, a DPO in WAITING_ABORT went through
j1939_tp_set_rxtimeout(session, 750), which re-armed the timer.

j1939_xtp_rx_rts_session_active() already works around this same
problem:

	} else if (session->state == J1939_SESSION_WAITING_ABORT) {
		/* Force deactivation for the receiver.
		 * If we rely on the timer starting in j1939_session_cancel,
		 * a second RTS call here will cancel that timer and fail
		 * to restart it because the state is already WAITING_ABORT.
		 */
		j1939_session_deactivate_activate_next(session);
	}

Would something similar be needed here? The same timers_cancel plus
session_cancel pattern at out_session_cancel in j1939_xtp_rx_dat_one()
seems to have the same weakness.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009105559.301873-1-quchaosheng000406%40163.com
