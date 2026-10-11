Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40E45FDA7;
	Sun, 11 Oct 2026 01:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791681043; cv=none; b=lfEflbv0W53khIdyJvJWrtG3G7HEbXKVgImIgekGqcDsSzOTg/qndo5+vZcpeHeg41VT3cvBUI36SiQAE0Suhe0ew18rRMxXy2is6Ryt8xD8NUGRdS1FYiAGOPJ/Q9xwOh1qwvI4sSwWEleWn+YuM3SmbxXceWanL8N/GrGUP5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791681043; c=relaxed/simple;
	bh=9LU7Nd2yrxldkf5H6+oocP0otzK4OS1Vf9W9mnTnpLs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I/Yp+7au4vNIsJFOpXQNg/B+VEThXq3ULPlO+cgSwCrhVt4GMgYargYUo/CGerrss+ERGSfFo8+V5mmxgPXNpkk23f3U/cF+ahgz/OgbTGdc55MszksgG1wj677zxB8jqMNqs16gRgknrY+MZDPaZ3lSn0KS8C3b6Dr4wqsFWTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrfaIB4d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrfaIB4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22161F000FF;
	Sun, 11 Oct 2026 01:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791681041;
	bh=s5A5414Hq73qL1OwrSDzN2jz1ltkulaPP3XKToIAuxs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PrfaIB4dQB8MQHmAFRt/EoeShEfiVDBWXUz6oPPDRI5931F9uBxdcPOTUSJwMgrHe
	 WLdxuCKEv+J0VgFwc2J+QbVgyZJERNhR3QGzG0f4lMBYHK1Yd5rjEevtPgPdQZEHJa
	 fIGzXH35XTULimj3vs4gMCyy9y0ZhYN2ycM3+ZnK9xrZ+S33rGfCljQk4afS30439B
	 WQo6WBe0ewKRaAMkFsdiwls2F6vtLT0PtdSQqCBiJRRo2HupuHfxORiOwJQdhXjq/3
	 7qDLqCzfrqMVddDBBDiVNnjlJKMDCo7FzTIxv13u4cdfz3EMgSLwhoSRfWkDAu9gsa
	 1UY6Lox7WUqUA==
Subject: Re: [PATCH net v3] can: j1939: validate the EDPO packet number
From: netdev-bot+sashiko@kernel.org
To: quchaosheng000406@163.com
Cc: robin@protonic.nl, o.rempel@pengutronix.de, kernel@pengutronix.de,
 socketcan@hartkopp.net, mkl@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, sashiko-bot@kernel.org, kuba@kernel.org
Date: Sun, 11 Oct 2026 01:10:40 +0000
Message-ID: <179168104024.1406898.7811399438923305061@kernel.org>
In-Reply-To: <20261009105410.300321-1-quchaosheng000406@163.com>
References: <20261009105410.300321-1-quchaosheng000406@163.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new range check in j1939_xtp_rx_dpo_one()
  (net/can/j1939/transport.c:1852-1858) can leave a receive session…
- [Medium] Part of the commit message's reasoning does not match the
  code.
- [Low] The patch fixes a NULL-pointer dereference that a remote CAN node
  can trigger through crafted ETP.CM_RTS/ETP.CM_DPO/ETP.DT frames, but…
- [Low] The new check in j1939_xtp_rx_dpo_one() also runs for transmit
  sessions, via the looped-back local DPO: j1939_tp_cmd_recv() calls…
- [Low] The new comment in j1939_session_completed() (lines 1247-1252)
  names 'when a peer names a packet past the end of the message in an…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch adds
  another caller that can reach it.

--

can: j1939: validate the EDPO packet number

This commit adds a range check on the ETP.CM_DPO packet number in
j1939_xtp_rx_dpo_one(). If the number is not below pkt.total, the session
is aborted with J1939_XTP_ABORT_BAD_EDPO_OFFSET. It also adds a NULL check
in j1939_session_completed() on the skb returned by
j1939_session_skb_get(), before that skb is passed to j1939_sk_recv().

Link: https://sashiko.dev/#/patchset/20260928193312.553632-1-mkl@pengutronix.de?part=3

> Reaching the dereference needs two things, and this patch keeps them as
> two separate changes because neither is sufficient alone:
>
>   - the range check in j1939_xtp_rx_dpo_one(), which stops pkt.dpo from
>     leaving the message
>   - the NULL guard in j1939_session_completed(), which covers the offset
>     lookup coming up empty for any other reason
>
> The reproducer in the link was run three times in each configuration: the
> unpatched kernel panics 3/3, a kernel with only the NULL guard still
> panics 3/3, and this patch gives 0/3.  The middle result is the point --
> it shows the guard does not close this hole on its own, so the range check
> is not redundant with it.

[Severity: Medium]
Is this description accurate? With only the NULL guard applied, the
reproducer sequence in the message seems to go like this:

  ETP.CM_DPO (packet 256) -> pkt.dpo = 256
  ETP.DT seq 0            -> packet 255, passes "packet > pkt.total"
  j1939_session_skb_get_by_offset(session, 1785) finds the 1786 byte skb
  pkt.rx reaches 256, the receiver sends EOMA

The loopback of that EOMA then runs:

  j1939_xtp_rx_eoma_one()
    j1939_session_completed()
      se_skb = j1939_session_skb_get(session);  /* offset 1792, NULL */
      if (se_skb) {                             /* j1939_sk_recv() skipped */

The other users of pkt.dpo on this path all handle a NULL lookup already:
j1939_simple_txnext(), j1939_session_tx_dat() and j1939_xtp_rx_dat_one().
j1939_sk_queue_activate_next() returns early for receive sessions with
sk == NULL.

The reverse case also seems to hold. With only the range check, dpo < total
gives dpo * 7 <= (total - 1) * 7 < total_message_size. The single reassembly
skb at offset 0 then always covers the lookup.

Where does the guard-only kernel panic in the 3/3 runs? Is there a second
crash site that the message doesn't describe?

Also, the message says the patch "keeps them as two separate changes", but
this is a single commit.

[ ... ]

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260928193312.553632-1-mkl@pengutronix.de?part=3
> Assisted-by: LLM
> Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>

[Severity: Low]
Should this have a Fixes: tag and Cc: stable? A remote CAN node can trigger
the NULL dereference with crafted ETP.CM_RTS, ETP.CM_DPO and ETP.DT frames.

The unvalidated assignment in j1939_xtp_rx_dpo_one() and the outline of
j1939_session_completed() both come from:

  Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

The unguarded se_skb lookup line was last changed in 7ac56e40d054.

The message describes reachability in terms of a local vcan interface. On
a real bus, can't any remote node send this sequence to a bound J1939
receiver?

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
This isn't a bug, but the comment gives an EDPO past the end of the message
as its example. The range check added to j1939_xtp_rx_dpo_one() by this same
patch now rejects that case.

For receive sessions, pkt.dpo is written only in j1939_xtp_rx_dpo_one() and
starts at 0. The single reassembly skb sits at offset 0 with length
total_message_size. Since (total - 1) * 7 < total_message_size, the lookup
should always succeed after this patch.

Could the comment instead describe what the guard still protects against?

> +		if (se_skb) {
> +			/* distribute among j1939 receivers */
> +			j1939_sk_recv(session->priv, se_skb);
> +			consume_skb(se_skb);
> +		}
>  	}
>  
>  	j1939_session_deactivate_activate_next(session);
> @@ -1823,14 +1832,34 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,

[ ... ]

> +	if (dpo >= session->pkt.total) {

[Severity: Low]
This check also runs for transmit sessions, through the looped-back local
DPO. When LOCAL_SRC is set, j1939_tp_cmd_recv() calls
j1939_xtp_rx_dpo(priv, skb, true).

The transmit side can still produce a pkt.dpo past the end of the message.
j1939_xtp_rx_cts_one() only rejects pkt == 0, and it doesn't compare pkt
against pkt.total:

	if (!pkt)
		goto out_session_cancel;
	...
	session->pkt.tx_acked = pkt - 1;

j1939_session_tx_dpo() then sends that value:

	session->pkt.dpo = session->pkt.tx_acked;

When the DPO echoes back, the new check aborts the transmit session with
J1939_XTP_ABORT_BAD_EDPO_OFFSET. That tells the peer our EDPO offset was
bad, but the actual fault was its oversized ETP.CM_CTS.

Would J1939_XTP_ABORT_ECTS_TOO_BIG, or a pkt.total check in
j1939_xtp_rx_cts_one(), be more accurate here? This doesn't crash, and the
local errno is EPROTO either way.

It also means the statement that the check "stops pkt.dpo from leaving the
message" only holds for receive sessions.

> +		netdev_warn(session->priv->ndev,
> +			    "%s: 0x%p: EDPO %u out of range (total %u), aborting\n",
> +			    __func__, session, dpo, session->pkt.total);
> +		j1939_session_timers_cancel(session);
> +		j1939_session_cancel(session, J1939_XTP_ABORT_BAD_EDPO_OFFSET);
> +		return;
> +	}

[Severity: High]
Can this leave a receive session stuck forever? Suppose a peer sends two
ETP.CM_DPO frames, both with an offset >= pkt.total, less than 500 ms apart.

The first bad DPO:

  j1939_xtp_rx_dpo_one()
    j1939_session_timers_cancel()
    j1939_session_cancel()
      j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS)
      __j1939_session_cancel()       /* state -> WAITING_ABORT */

j1939_session_get_by_addr_locked() doesn't filter on state, so the second
bad DPO still finds the session:

  j1939_xtp_rx_dpo_one()
    j1939_session_timers_cancel()    /* cancels the pending abort rxtimer */
    j1939_session_cancel()           /* WAITING_ABORT, nothing re-armed */

For a receive session, the only code that force-deactivates it is the
WAITING_ABORT branch of j1939_tp_rxtimer(). The looped-back abort only
matches sessions with transmission == true.

That leaves the session on active_session_list with no timer armed. It keeps
its kref, the reassembly skb, the priv reference and the netdev_hold()
reference from j1939_session_new().

If the last J1939 socket is then closed, __j1939_rx_release() clears priv
from the netdev. After that, j1939_netdev_notify() can't reach the session,
and unregister_netdevice would wait forever on the netdev reference.

Before this patch, a DPO in WAITING_ABORT went through
j1939_tp_set_rxtimeout(session, 750), which re-armed the timer, so this path
used to recover on its own. A similar stranding was already possible through
the j1939_xtp_rx_dat_one() error path.

j1939_xtp_rx_rts_session_active() already works around this exact problem:

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

Should the DPO path either skip the cancel when the session is already in
WAITING_ABORT, or force deactivation the way the RTS path does?

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but the
patch adds one more caller that can reach it.

j1939_session_cancel() holds the session list lock (spin_lock_bh) while it
calls j1939_tp_set_rxtimeout(). That calls j1939_session_rxtimer_cancel(),
which uses hrtimer_cancel() and waits for a running callback.
j1939_tp_rxtimer() takes the same lock, directly in its else branch and
through j1939_session_deactivate() in the other branches.

Can these two deadlock?

  CPU A                                CPU C
  j1939_session_cancel()
    j1939_session_list_lock()
                                       j1939_tp_rxtimer()
                                         j1939_session_list_lock()
                                         /* spins on the lock */
    j1939_tp_set_rxtimeout()
      j1939_session_rxtimer_cancel()
        hrtimer_cancel()
        /* waits for CPU C's callback */

In the new branch, j1939_session_timers_cancel() runs before
j1939_session_cancel(), but without the lock. Another context can re-arm the
rxtimer in between. Examples are a concurrent valid DPO or DAT frame, or a
txtimer-driven CTS or EOMA calling j1939_tp_set_rxtimeout().

j1939_tp_txtimer() also calls j1939_session_cancel() on -EOVERFLOW and in
its default case without cancelling the timers first.

Under the same lock, j1939_cancel_active_session() uses
hrtimer_try_to_cancel() instead:

			if (hrtimer_try_to_cancel(&session->rxtimer) == 1)
				j1939_session_put(session);

Would j1939_session_cancel() need a similar non-waiting cancel?

>  	/* transmitted without problems */
> -	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);
> +	session->pkt.dpo = dpo;
>  	session->last_cmd = dat[0];
>  	j1939_tp_set_rxtimeout(session, 750);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009105410.300321-1-quchaosheng000406%40163.com
