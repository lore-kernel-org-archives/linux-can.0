Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794520183;
	b=fLEeorODHxXwjX2j01ij9+Vs+FRd+0VuEbdEjV2CaMTYy8HlIznbsDOAJy4z7WP8imgs
	 5OGAnj1aZnLxu9c10Chmfk4/yi1AnxV/DZI9qtvtV5MeB4Mq1hBOEyvx4ej7H449HW3Qu
	 VPEoIjiCJ8SVopWH243KQolZramDM4Caj2YLz7ywQ/pIWYa/bkpDbM85DVsWWJtWj9Bbb
	 Wu/V+fMpKisGB7hn2sI1AaDoKqVEgkqJpWGy9lFwRJicIBn3DWPl+7wemUL6a4Dm9h9Bf
	 1KRvlj/EgD1LUB8m4UMN7d/OjONbyXr2SLnMugnTaERouK7kke/sKq+EtcyEdyhCexQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794520183;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VNDpWZ/WbAOErLSFshS8UFWvuUmheFhDs22oNrK3ADo=;
	b=GkU3udqqtTBcxSb6XrZCggorFxCfm4uDo3Lf0aHeMRMp5oxRmAuaIz/4qEjgHFYQIRxp
	 H/eIzoQfVhteOwLF7i+qT+wyMehUgQ6YEdaG9s49Hi4tHtbb0S+zWT1VH1wX+j7O7G5hj
	 Qwm+PrboVxoYG61sab8CLj4oY/02BXkzUgL9mSO67ehW8Sdj2zzZdvt6inxRPkvTBhVoA
	 DAFeKd1xIhNkpyL8y5SCCsHvWuFsvOHIDxeOXCE9Vd0wSs0jmtQ52AnsYOCSyJgkFCsyP
	 KDmVSHZhvaUdSzq5SzV4xdz0jqhAdTcfkiTmMA8MPFApSxMWsw5Dgsd9iYcyLwt/9vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZgjvYr6B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780FC606A89A;
	Thu, 12 Nov 2026 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZgjvYr6B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2B51F000C4;
	Thu, 12 Nov 2026 21:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794520183;
	bh=VNDpWZ/WbAOErLSFshS8UFWvuUmheFhDs22oNrK3ADo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZgjvYr6B8OPQLXmYagMsG7NamPs2/1vzqFcT1XXgyX+mlyUBoREH4UqQGbgbqDyFN
	 fnSm4ACVQGy/IRtxeQCU4CjhRl4xuUK4GfoNrmFUp+9CAGRwVuWawQ3AOe5zJh1FIA
	 8ZBQkFNK3aXwJKaklPQ6kA9zlTHLt1r0DNK9hticqBIS/BKFYXFvHaqnzkv5foOpVv
	 32g+7cGASJVqP49EHUTF6piuTG6Fy6rjSVYM5fJ1WiKVuq05emBx2D3KBLJ93UuosO
	 vc/PwynLLz5WQ6+k5mcYL/nC9DjPzvmT+rYak3SKPfeNr3NmsBCzjUkoVcV057QROm
	 9AVflc3RvUfCw==
Subject: Re: [PATCH net v7 4/4] can: j1939: reject a CTS that names more
 packets than the message has
From: netdev-bot+sashiko@kernel.org
To: quchaosheng000406@163.com
Cc: robin@protonic.nl, o.rempel@pengutronix.de, socketcan@hartkopp.net,
 mkl@pengutronix.de, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 12 Nov 2026 21:49:42 +0000
Message-ID: <179452018249.488853.178284371976315484@kernel.org>
In-Reply-To: <179410166346.60581.17199842424718803160@163.com>
References: <179410166346.60581.17199842424718803160@163.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message of "can: j1939: reject a CTS that names
  more packets than the message has" gets the current behaviour wrong…
- [Low] This patch makes the transmitter-role branch of
  j1939_xtp_rx_dpo_one() (net/can/j1939/transport.c, lines 1894-1899)…

--

can: j1939: reject a CTS that names more packets than the message has

This patch adds a check to j1939_xtp_rx_cts_one(). A CTS whose packet
number is above pkt.total is now rejected, and the session is aborted
with J1939_XTP_ABORT_ECTS_TOO_BIG. Before this, the function only
rejected a zero packet number and a window above pkt.block.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 5f05c15114ce4..6cb3dec49f3f7 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1504,6 +1504,15 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
>  		goto out_session_cancel;
>  	else if (dat[1] > session->pkt.block /* 0xff for etp */)
>  		goto out_session_cancel;
> +	else if (pkt > session->pkt.total) {
> +		/* The responder asks for more packets than the message has.
> +		 * pkt - 1 becomes pkt.tx_acked below, and the transmitter
> +		 * reports that value in an ETP.CM_DPO, where it would name a
> +		 * packet past the end of the message.
> +		 */
> +		err = J1939_XTP_ABORT_ECTS_TOO_BIG;
> +		goto out_session_cancel;
> +	}

[Severity: Medium]
Does the commit message describe the current behaviour correctly? It
says:

  That value is what j1939_xtp_rx_dpo_one() now bounds, so an oversized
  CTS is currently caught one step later and reported as a bad EDPO
  offset.

Before this patch, the host that receives an oversized ETP CTS goes
through this path:

j1939_xtp_rx_cts_one()
    session->pkt.tx_acked = pkt - 1;   /* >= pkt.total */
j1939_xtp_txnext_transmiter()
    j1939_session_tx_dpo()
        dat[1] = session->pkt.last - session->pkt.tx_acked; /* 0 or wraps */
local echo of that DPO -> j1939_tp_cmd_recv()
    j1939_xtp_rx_dpo(priv, skb, true)
        j1939_xtp_rx_dpo_one()

In j1939_xtp_rx_dpo_one(), the echo then takes the transmitter branch:

	if (dpo >= session->pkt.total) {
		if (session->transmission) {
			...
			j1939_session_cancel(session, J1939_XTP_ABORT_ECTS_TOO_BIG);
		} else {
			j1939_session_cancel(session, J1939_XTP_ABORT_BAD_EDPO_OFFSET);
		}

So isn't the abort code already ECTS_TOO_BIG, not a bad EDPO offset?
The earlier commit in this series, "can: j1939: validate the EDPO
packet number", says the same. For ETP, the actual change seems to be
that the out-of-range DPO, with a zero or wrapped dat[1], is no longer
sent on the bus.

The new check also runs for plain TP sessions. There, pkt = dat[2] and
there is no DPO step. Before this patch, an oversized TP CTS reached
j1939_session_tx_dat() with pkt.tx >= pkt.total:

	se_skb = j1939_session_skb_get_by_offset(session, session->pkt.tx * 7);
	if (!se_skb)
		return -ENOBUFS;

The txtimer then retried until one of two things happened:

  - the rxtimer aborted the session with J1939_XTP_ABORT_TIMEOUT, or
  - the retry limit ended the session with -ENETUNREACH.

With this patch, a TP session aborts at once with code 15. That code is
documented as "ECTS requested packets exceeds message size".

Could the commit message and the new comment cover the TP case as well?
The peer and the socket user will see this change. The comment
currently explains the check only through ETP.CM_DPO.

>  
>  	/* set packet counters only when not CTS(0) */
>  	session->pkt.tx_acked = pkt - 1;

[Severity: Low]
With this check in place, does the transmitter branch in
j1939_xtp_rx_dpo_one() still match its comment?

net/can/j1939/transport.c:j1939_xtp_rx_dpo_one() {
	...
		if (session->transmission) {
			/* A transmitter only builds an EDPO from pkt.tx_acked,
			 * which comes from the responder's ETP.CM_CTS, so an
			 * out-of-range value there is an oversized CTS.
			 */
			j1939_session_cancel(session, J1939_XTP_ABORT_ECTS_TOO_BIG);
	...
}

After this patch, pkt.tx_acked is at most pkt.total - 1 here. The one
exception is j1939_xtp_rx_eoma_one(), which sets it to pkt.total just
before the session completes. j1939_session_tx_dpo() copies
pkt.tx_acked into the DPO packet number, so a DPO built by the local
transmitter can no longer reach dpo >= pkt.total.

The only frame that can still reach this branch is an ETP.CM_DPO with a
local SA that the local transmitter did not build. One example is
another node on the bus using the same SA. Another is a raw CAN frame
injected on the interface. j1939_tp_cmd_recv() passes such a frame to
j1939_xtp_rx_dpo(priv, skb, true).

For that frame, wouldn't J1939_XTP_ABORT_BAD_EDPO_OFFSET be the more
accurate abort reason? The commit message refers to the bound in
j1939_xtp_rx_dpo_one(). Should that role split and its comment be
updated as part of this patch?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179410166344.60581.3898011861151549156%40163.com
