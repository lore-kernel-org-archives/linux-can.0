Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794520182;
	b=tbboZ0E/whWYssruizMB9bRRXLDFkj0qp2VQfz0vyf2RD7xFDuWdmELT+FCxtIkVzNEN
	 UHF1BUWGl29AAnW4GIBJHMU0KPL3r6LeggFgHKkiCaVH6VVa6csu+kQoTPH3FOtdZRtom
	 wHfCBLhu4nJMO2pxT0oW8RlsA3Bq5W1CkAmUV3xIGrbeJwMo+1xHwDeHpLCJuG5fGl3++
	 q7UpBAolsi3fdTBgobGksnP7Edr0Az156cgcGUopdRVk55QwJrMSSK+tLxNBfqNSBkrG+
	 ylKbJCaqf3U92K03P0iHzhh/FceA/wfyy1TVUg03ChndHQiEf+/ykvsv65pTyASaWZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794520182;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=8R5PalILD6uN40gCePjh3NQVD0XgaMizYN/kfloOhkE=;
	b=hyg3mJB7kmgvY4QJR5N7MsCIVI1FsJMXkU+u2F6wXqaBR9IOSNHnCUIKsVnHuwf77qMP
	 1slwvPwrU8On8qP/QvHGaK2D2QF0oYm37E31k+O+qncNanJznbP2dG/0JjnEAfLd467iu
	 JBDxmNdVGPcN7zUmgQACWkdwRztZQ98zesOigz8L3GEuEJGPj0kDiqbcgFE8XpAUATwoB
	 OQSLB4SIBgHlk1MEMBMCBya6Rjq6cRGmTfKZW+miRlK4q/MiMUZzwZnhQj3DiOGQq4bQC
	 1JW2Uj3io3VPx3JREJyeBLe8Wb6OgNDNjMaaDTe0XIt3Mmx76jQnVJFb5kUGkrRavQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TjoUp6xp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB025606A890;
	Thu, 12 Nov 2026 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TjoUp6xp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE5D1F000C4;
	Thu, 12 Nov 2026 21:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794520182;
	bh=8R5PalILD6uN40gCePjh3NQVD0XgaMizYN/kfloOhkE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TjoUp6xpi0Lq6xlzVzwLyDvmK+mnWNGwwAn3cQJkOIImZVfpBvg1EybP0KGZcvrif
	 wHYLfxGKc/vl97TPbzvxhTigC9XF/2PjWZa/8cJrxROqy4nnXarklL1IOU3GQlN1ZW
	 Mvt1N2NC6x0kTmmoH8ubxRhzpaFfZ3e8kNbmgmqkFpTgZiaRbDsh7hdmZIiSCxKTHT
	 LoAjyW4QKfh0ovVWz0vjTbaG1JefsHPbApKr2VRILDYwLlRiGitt2URvRuKhN8zsVA
	 gvy6bf1g6RkMlRukzDyl/V4tA38LPUCpCEIgBLaRn0UuILV/fKknTt2nr041mIeIC/
	 KMNUFmJ59fqHQ==
Subject: Re: [PATCH net v7 2/4] can: j1939: validate the EDPO packet number
From: netdev-bot+sashiko@kernel.org
To: quchaosheng000406@163.com
Cc: robin@protonic.nl, o.rempel@pengutronix.de, socketcan@hartkopp.net,
 mkl@pengutronix.de, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 12 Nov 2026 21:49:41 +0000
Message-ID: <179452018139.488853.4180903963444412204@kernel.org>
In-Reply-To: <179410166345.60581.5430129940541091934@163.com>
References: <179410166345.60581.5430129940541091934@163.com>
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

- [Medium] The new EDPO rejection path in j1939_xtp_rx_dpo_one()
  (net/can/j1939/transport.c) calls j1939_session_cancel() without first…
- [Low] The commit fixes a NULL pointer dereference that any remote CAN
  node can trigger, but it carries no Fixes: tag and no Cc: stable.

--

can: j1939: validate the EDPO packet number

This patch makes j1939_xtp_rx_dpo_one() reject an ETP.CM_DPO whose packet
number is at or past pkt.total, and abort the session when that happens.
A receiver aborts with J1939_XTP_ABORT_BAD_EDPO_OFFSET. A transmitter aborts
with J1939_XTP_ABORT_ECTS_TOO_BIG.

>     Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>

[Severity: Low]
Should this commit carry a Fixes: tag and Cc: stable?

The commit message describes a NULL pointer dereference that a remote CAN
node can trigger:

j1939_session_completed()
    se_skb = j1939_session_skb_get(session);   <- NULL
    j1939_sk_recv(session->priv, se_skb);      <- dereferences oskb->sk

git blame on the baseline shows that j1939_xtp_rx_dpo_one() and
j1939_xtp_rx_dat_one() come from commit 9d71dd0c7009 ("can: add support of
SAE J1939 protocol"). Would a Fixes: tag for that commit be appropriate?

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 590a04c453b56..b0e62822b56e4 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1849,14 +1849,43 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,
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
> +		if (session->transmission) {
> +			/* A transmitter only builds an EDPO from pkt.tx_acked,
> +			 * which comes from the responder's ETP.CM_CTS, so an
> +			 * out-of-range value there is an oversized CTS.
> +			 */
> +			j1939_session_cancel(session, J1939_XTP_ABORT_ECTS_TOO_BIG);
> +		} else {
> +			j1939_session_cancel(session, J1939_XTP_ABORT_BAD_EDPO_OFFSET);
> +		}
> +		return;
> +	}

[Severity: Medium]
Should this branch call j1939_session_timers_cancel() before
j1939_session_cancel()? The other receive path aborts in this file do:

j1939_xtp_rx_cts_one() {
    ...
 out_session_cancel:
	j1939_session_timers_cancel(session);
	j1939_session_cancel(session, err);
}

j1939_xtp_rx_dat_one() and both branches of
j1939_xtp_rx_rts_session_active() follow the same pattern.

j1939_session_cancel() only cancels and re-arms the rxtimer. That means the
txtimer can still be pending after this abort. If the txtimer is already
running on another CPU, nothing waits for it to finish.

On a receiver session, a remote node can send ETP.CM_RTS. In response,
j1939_xtp_rx_rts() calls j1939_tp_schedule_txtimer(session, 0) to send the
CTS. Suppose the node then immediately sends an ETP.CM_DPO with a packet
number >= pkt.total. j1939_xtp_rx_dpo_one() does not check last_cmd, so the
frame reaches this branch.

This branch returns before last_cmd is updated, so last_cmd is still
J1939_ETP_CMD_RTS. When the txtimer then runs:

j1939_tp_txtimer()
    j1939_xtp_txnext_receiver()
        case J1939_ETP_CMD_RTS:
            j1939_session_tx_cts()
                j1939_tp_tx_ctl(session, true, dat);
                j1939_tp_set_rxtimeout(session, 1250);

Does this send a CTS after the abort has already gone out? Does it also
replace the abort timeout with a 1250ms rx timeout?

j1939_tp_set_rxtimeout() does not take active_session_list_lock. Suppose it
runs at the same time as the cancel/get/hrtimer_start sequence in
j1939_session_cancel(). Could the rxtimer then be armed twice with two
session references taken, leaking one of them? A leaked reference would
keep the j1939_priv and netdev references alive, and could hang
unregister_netdevice().

The transmitter branch looks like it has the same gap. j1939_tp_txtimer()
does not check session->state. On -ENOBUFS it keeps re-arming itself. At the
retry limit it does this without the lock:

	session->err = -ENETUNREACH;
	j1939_session_rxtimer_cancel(session);
	j1939_session_deactivate_activate_next(session);

That overwrites the abort error and cancels the abort timer.
j1939_tp_cmd_recv() sends a frame down the transmitter path whenever
j1939_tp_im_transmitter(skcb) is true. Can a frame with a spoofed local SA
still reach this branch after the CTS bound is added?

Would it help to add j1939_session_timers_cancel(session) before
j1939_session_cancel() here? hrtimer_cancel() waits for a running callback,
so that would close the window.

> +
>  	/* transmitted without problems */
> -	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);
> +	session->pkt.dpo = dpo;
>  	session->last_cmd = dat[0];
>  	j1939_tp_set_rxtimeout(session, 750);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179410166344.60581.3898011861151549156%40163.com
