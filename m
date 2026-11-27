Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791840;
	b=eSPDn6oblQTIic/YcydTPLHiqqaNGcaKXq9mxjZzSctjTvFdWINLCpqqT2JUJtoRXe+S
	 FNnOOLRy25wa3Peno7OJDu1XDHTyVFArQigR8KQwTRaKz1O9alQUp1un58ynyKH3pnlFP
	 D6OI2YxwNowe769QDNqOAweNPYN88mSYo0sr5QPPI4dV26Sx+MQAvnf4JnlSs0pxsrAwn
	 0PTesztBs3gwuYp3VxTP4mnB+PRl9e1sOlMNHq2pYbymCR6cWXpK7Qmmh7nM13XBsUeI1
	 53lgjgijfNEI2oAxpqMZJKvhUBwLuq5OzTMDSC4Qo6MH6G+/YhQxBXBeQR20ETSxnIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791840;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d7AwnLP3KBSWaNF33NQKZMexxXU+SW59ZjGJ/o6MX9o=;
	b=BdwMtbCqiPBasJv4cVZxyDsCaktDs7q1bqb6+BHtbMRWEErmq60AISZ5163PWDfW2HmO
	 6dMu7M7QCTpoYYv7jSpLGtJNEHRdetqund4rSSjS+Dm4TqZp0REBqFmPX8Z8alQcpBepm
	 XU9lCezGYeplutlRv0teBMcWiEBgMSO3uGZzrZADCtyK/i239t5luQQPUAsz3e18zx6UE
	 HokJBcTMMUMk4evvP+8cxhHtJtNSZT0eox8GdYcDzZfBWA+39Dq7ihc0+WTzQLonREkAu
	 Pt9DHB0ypUMHu+MIYD6SmHDYXj/dVyyRNAfbGGaRdYAHCEzDZvwLANW2QPWwA2Oy6pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P26jFS04;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B72A606A31C
	for <linux-can@vger.kernel.org>; Fri, 27 Nov 2026 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P26jFS04
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9541B1F0089C;
	Fri, 27 Nov 2026 15:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791839;
	bh=d7AwnLP3KBSWaNF33NQKZMexxXU+SW59ZjGJ/o6MX9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P26jFS04WpOD6YMByaOAp2jquaE1Nh5xEyNNyJ+UYRKw2XkIV6v7NteqoCgfyABql
	 Tb6NOiTaOilGDfB9TVPM2y0RyxmRxR7ODL9fe0Ub2Y2m4Os1UsfTFWyt6lBnLiNvKj
	 HcuUxI1svh0UbRMDj6tMQlA2KoQBBEp4x7L2LPG9auAJ6bzEwCm6pBqSS3xRt05u2g
	 0xehM+2N9UVR+HELa2B5r8jCuFRcW/D+HkNfvh69BiL+hA0vrGgd/5kBB70r6dmhvH
	 TxSVQb7xH/LqDXeGAbIrITgsuTwNn0fHMxpY68E8/MQeCXMjlwbA66v8v+S0Gj2BOL
	 xhM38puYYMIUA==
Message-ID: <sashiko-outbox-237670@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3] can: j1939: reject an out-of-range data packet
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Piyus Kedia" <piyus@iiitd.ac.in>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261126150339.2110025-1-piyus@iiitd.ac.in>
References: <20261126150339.2110025-1-piyus@iiitd.ac.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:03:59 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] can: j1939: session leak on ETP.DT after bad DPO in
  j1939_xtp_rx_dpo_one()
- [Medium] can: j1939: unlocked was_dying check in
  j1939_xtp_rx_dpo_one() leaks session
- [Medium] can: j1939: j1939_xtp_rx_dpo_one() and rx_dat_one() accept
  aborted sessions
- [Medium] can: j1939: duplicate RX_ABORT and wrong abort code in
  j1939_xtp_rx_dpo_one()
- [Medium] can: j1939: unlocked state check before timer cancel in
  j1939_xtp_rx_eoma_one()
- [Low] can: j1939: commit message misstates NULL skb copy and omits
  EOMA state check
--

commit 42dc0f1ef825e9a1fb806f7836041c2eaa69424c
Author: Piyus Kedia <piyus@iiitd.ac.in>

can: j1939: reject an out-of-range data packet offset

This commit rejects out-of-range ETP data packet offsets in
j1939_xtp_rx_dpo_one(), ignores EOMA on cancelled sessions in
j1939_xtp_rx_eoma_one(), and looks up the completed receive skb at offset 0
in j1939_session_completed().

Link: https://lore.kernel.org/all/179553126874.3135.14817947057284289051@ke=
rnel.org/

> j1939_session_skb_get_by_offset() then looks for a buffered skb at
> pkt.dpo * 7, and j1939_xtp_rx_dat_one() copies into the session's skb at
> that offset.  An offset past the session's packet count has no skb behind
> it, so the lookup returns NULL and the copy and the completion run on it.
>
> Reject an offset that is not below session->pkt.total, and look the
> completed receive message up at offset 0 rather than at whatever window
> the peer's last DPO named.

[Severity: Low]
Does the commit message accurately describe what happens when
j1939_session_skb_get_by_offset() returns NULL, and should it also mention
the state check in j1939_xtp_rx_eoma_one()?

j1939_xtp_rx_dat_one() already checks for a NULL se_skb and jumps to
out_session_cancel before copying, so only j1939_session_completed() ran on
a NULL skb.  Also, the new J1939_SESSION_WAITING_ABORT guard in
j1939_xtp_rx_eoma_one() and the second-DPO deactivation are only described
below the "---" tearline, which git am strips.

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..54e7ae9a88c3e 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
[ ... ]
> @@ -1418,6 +1423,18 @@ j1939_xtp_rx_eoma_one(struct j1939_session *sessio=
n, struct sk_buff *skb)
> =20
>  	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
> =20
> +	if (session->state >=3D J1939_SESSION_WAITING_ABORT) {
> +		/* This session has been cancelled and is waiting for its abort
> +		 * to go out.  Completing it here would hand its data to the
> +		 * receiving sockets and queue a second RX_ABORT, so leave it to
> +		 * the abort path.
> +		 */
> +		netdev_info(session->priv->ndev,
> +			    "%s: 0x%p: EOMA on a cancelled session\n",
> +			    __func__, session);
> +		return;
> +	}
> +
>  	session->pkt.tx_acked =3D session->pkt.total;
>  	j1939_session_timers_cancel(session);
>  	/* transmitted without problems */

[Severity: Medium]
Can j1939_tp_rxtimer() race with this unlocked session->state check before
j1939_session_timers_cancel() cancels rxtimer?

CPU0                                  CPU1
j1939_xtp_rx_eoma_one()
  if (session->state >=3D
      J1939_SESSION_WAITING_ABORT)
                                      j1939_tp_rxtimer()
                                        j1939_session_list_lock()
                                        hrtimer_start(&session->rxtimer, ..=
.)
                                        __j1939_session_cancel()
                                          session->state =3D
                                            J1939_SESSION_WAITING_ABORT;
                                        j1939_session_list_unlock()
                                        j1939_sk_errqueue(..., RX_ABORT)
  j1939_session_timers_cancel()
  j1939_session_completed()  <-- delivers aborted data and queues 2nd RX_AB=
ORT

If rxtimer expires on CPU1 between the state check and
j1939_session_timers_cancel(), CPU0 cancels the 500 ms abort timer and calls
j1939_session_completed(), handing the cancelled session's skb at offset 0
to receiving sockets and queueing a second J1939_ERRQUEUE_RX_ABORT when
j1939_session_destroy() sees session->err set.

> @@ -1823,14 +1840,36 @@ static void j1939_xtp_rx_dpo_one(struct j1939_ses=
sion *session,
>  				 struct sk_buff *skb)
>  {
>  	const u8 *dat =3D skb->data;
> +	unsigned int dpo;
> =20
>  	if (j1939_xtp_rx_cmd_bad_pgn(session, skb))
>  		return;
> =20
>  	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
> =20
> +	dpo =3D j1939_etp_ctl_to_packet(dat);
> +	if (dpo >=3D session->pkt.total) {
> +		bool was_dying =3D session->state >=3D J1939_SESSION_WAITING_ABORT;
> +
> +		netdev_info(session->priv->ndev,
> +			    "%s: 0x%p: data packet offset %u is not below the %u packet(s) of=
 this session\n",
> +			    __func__, session, dpo, session->pkt.total);
> +		j1939_session_timers_cancel(session);
> +		j1939_session_cancel(session, J1939_XTP_ABORT_FAULT);
> +		if (was_dying)
> +			/* The cancel above is a no-op once the state is
> +			 * WAITING_ABORT, so it does not restart the timeout
> +			 * this function just cancelled.  Deactivate instead,
> +			 * as j1939_xtp_rx_rts_session_active() does, or the
> +			 * session stays on the active list with no timers and
> +			 * holds its skb and netdev references for good.
> +			 */
> +			j1939_session_deactivate_activate_next(session);
> +		return;
> +	}

[Severity: High]
Does an ETP.DT data frame arriving right after a rejected out-of-range DPO
still leak the session?

In ETP, the sender transmits ETP.DT packets immediately after ETP.CM_DPO
without waiting for an acknowledgment.  When the first out-of-range DPO is
rejected here, session->state becomes J1939_SESSION_WAITING_ABORT with a
500 ms rxtimer, and the function returns before setting session->last_cmd to
J1939_ETP_CMD_DPO.  When the following ETP.DT packet arrives in
j1939_xtp_rx_dat_one(), switch (session->last_cmd) hits default and jumps to
out_session_cancel:

net/can/j1939/transport.c:j1939_xtp_rx_dat_one() {
	...
 out_session_cancel:
	kfree_skb(se_skb);
	j1939_session_timers_cancel(session);
	j1939_session_cancel(session, abort);
	j1939_session_put(session);
}

j1939_session_timers_cancel() cancels the 500 ms abort timer, and
j1939_session_cancel() does not restart it because session->state is already
J1939_SESSION_WAITING_ABORT.  The session stays on
priv->active_session_list with no timers, leaking its queued skb and netdev
reference and causing unregister_netdevice() to hang once the socket closes.

[Severity: Medium]
Can sampling was_dying without active_session_list_lock before
j1939_session_timers_cancel() also leak the session if rxtimer fires
concurrently?

CPU0                                  CPU1
j1939_xtp_rx_dpo_one()
  was_dying =3D session->state >=3D
    J1939_SESSION_WAITING_ABORT;
  /* false */
  netdev_info(...)
                                      j1939_tp_rxtimer()
                                        j1939_session_list_lock()
                                        hrtimer_start(&session->rxtimer, ..=
.)
                                        __j1939_session_cancel()
                                          session->state =3D
                                            J1939_SESSION_WAITING_ABORT;
                                        j1939_session_list_unlock()
  j1939_session_timers_cancel()
  j1939_session_cancel()
  if (was_dying) /* false */  <-- skips deactivate, session leaked

CPU0 cancels the 500 ms abort timer started by CPU1, j1939_session_cancel()
does not re-arm it because the state is now J1939_SESSION_WAITING_ABORT, and
the stale was_dying value skips j1939_session_deactivate_activate_next().

[Severity: Medium]
Does calling j1939_session_cancel() when was_dying is true queue a duplicate
J1939_ERRQUEUE_RX_ABORT, and should the abort reason be
J1939_XTP_ABORT_BAD_EDPO_OFFSET instead of J1939_XTP_ABORT_FAULT?

In j1939_session_cancel(), j1939_sk_errqueue(session,
J1939_ERRQUEUE_RX_ABORT) runs outside the session->state <
J1939_SESSION_WAITING_ABORT check, so calling j1939_session_cancel() when
was_dying is true emits an extra RX_ABORT before j1939_session_destroy()
emits another.  Also, transport.c defines J1939_XTP_ABORT_BAD_EDPO_OFFSET
(12, "Bad EDPO offset") specifically for an invalid ETP.CM_DPO offset,
whereas J1939_XTP_ABORT_FAULT (5) is for exceeding the retransmit limit.

> +
>  	/* transmitted without problems */
> -	session->pkt.dpo =3D j1939_etp_ctl_to_packet(skb->data);
> +	session->pkt.dpo =3D dpo;
>  	session->last_cmd =3D dat[0];
>  	j1939_tp_set_rxtimeout(session, 750);

[Severity: Medium]
Should j1939_xtp_rx_dpo_one() and j1939_xtp_rx_dat_one() reject frames when
session->state >=3D J1939_SESSION_WAITING_ABORT, just as
j1939_xtp_rx_eoma_one() now does?

If a peer sends an in-range DPO during the 500 ms abort window,
j1939_xtp_rx_dpo_one() updates session->pkt.dpo and session->last_cmd,
extends rxtimer to 750 ms, and queues J1939_ERRQUEUE_RX_DPO after RX_ABORT.
Subsequent data packets in j1939_xtp_rx_dat_one() then write into the
cancelled session's skb and can schedule txtimer to transmit CTS or EOMA for
the aborted session, or call j1939_session_completed() directly on a final
BAM packet and deliver the aborted message at offset 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126150339.2110=
025-1-piyus@iiitd.ac.in?part=3D1
