Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380663;
	b=IWbHlq3AmGR1F009R25m63NWKCdNNoOu7sJjoGcaBMurqA5zaRlE1891T07uziugJ2Up
	 HTlMoRLyNaTR7nKWVlZGC+c9tVA6cHPYGOF+sOsXeklf1Eo/zCt26bR/i37dVQU5mR2Wv
	 b3KUG59UrNHxzSOeyyDx6cCWJLFDACEhh1+JBcl241HF09Eh1kw8yZMXKuCH6bkl7O62j
	 sTTOi/bCQvSOjYjZLi8y3SoQbnGtozdMV96SAE279gIapo2TSZGUyzhZ07fsQ1FBUQTbU
	 mnPslWNnc5V2797GJNy4pJqKk2ex/yPgH+JZLsymNpOXMw9G/+pwoUrimzVYrbMbLBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380663;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q+0wswrsQ4BmCSQMEsFCRgsr8YmcQVwNgODrCNGUb/g=;
	b=smmgZTlp2GKjruHtZoGqzY13ug/abYR2ApMh74lnarER4aCTY9gHyPCbS0gym27UjZee
	 dq/PQ3b9ywZaXNDLXB3Rkg8D9kcraj2ZJuEsZ2/JH/0c9bOw8xH5gw80SC+mhSlkZa4EZ
	 X2N1+b4rnpr8ub/bea1dOhUtog/Rz1lY7WmuztwdvKkIOnBTNgiHf8O0mOw1XtUwI1L9R
	 B6WMKlQiU2dOz9oBre4FvlsqpQzlukAeYd4ehyOaX5X6Kk3w45TpTWIo8EVI+z6APAYRL
	 YKmMdfqyNE2R79EO50L+Vta7++djeIexXgAb/Ts3LJPmbpTgQHx9jq9fL3aPx7cDC/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="H/kPJPg7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38808606A32E
	for <linux-can@vger.kernel.org>; Wed, 11 Nov 2026 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H/kPJPg7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CDC1F00A05;
	Wed, 11 Nov 2026 07:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794380662;
	bh=q+0wswrsQ4BmCSQMEsFCRgsr8YmcQVwNgODrCNGUb/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H/kPJPg74m05CNCwRK0RX8K/z7NkLBWrd7DP4szAUD0sKkOkI+jYkeGRdxXV1bEKl
	 5EH1yLis8e1mdtLRojjzPDdxLC++pDrgtz1Aq4AuBLrxyx2qhdO09WuD5vuAOQ1Tel
	 T4wXwh1Pd0ObqsduUn1vM1Dp9u5bPTmIYUEOy93P0ZogRQSVkZimq5jQa5e9oLlT8r
	 aanN8UHrlvNnR2i5S0754mXbJzaJxGhhqnPra6bS208c7Foy2zOT3SrkiQYNyfc+16
	 3SyMTfY2NHlam3VDOCEQVaxJ4K0TFwxb69mHeA3CgCBkRHL3gzQCNiAvF7sT2FrQc/
	 5DAw86xALpJFQ==
Message-ID: <sashiko-outbox-208485@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v7 2/4] can: j1939: validate the EDPO packet number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chaosheng Qu" <quchaosheng000406@163.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <179410166345.60581.5430129940541091934@163.com>
References: <179410166344.60581.3898011861151549156@163.com>
 <179410166345.60581.5430129940541091934@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 07:04:22 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] can: j1939: missing txtimer cancel before
  j1939_session_cancel()
- [Medium] can: j1939: session ref leak in j1939_session_cancel() on
  rxtimer race
- [Low] can: j1939: missing Fixes trailer for EDPO bounds check
--

commit 1f6785035506d85ce93ce6a036332f472884137d
Author: Chaosheng Qu <quchaosheng000406@163.com>

> can: j1939: validate the EDPO packet number
>
> ETP.CM_DPO is peer controlled and its packet number is accepted without a=
ny
> validation.  It names the packet a transmission window starts at, and
> j1939_xtp_rx_dat_one() places incoming data at "dat[0] - 1 + pkt.dpo", so=
 a
> value past the end of the message moves pkt.dpo beyond the reassembled
> buffer.
>
> The transfer still completes normally in that case.  With
> pkt.dpo =3D=3D pkt.total, a closing ETP.DT frame with dat[0] =3D=3D 0 eva=
luates to
> packet pkt.total - 1, which is the last in-order packet, so pkt.rx reaches
> pkt.total and the receiver emits its own EOMA.  The local loopback of that
> EOMA runs j1939_session_completed(), which asks j1939_session_skb_get() f=
or
> offset "pkt.dpo * 7" -- one full packet past the end of the queued skb --
> gets NULL, and passes it straight to j1939_sk_recv(), which dereferences
> oskb->sk.
>
> Reject an EDPO that names a packet at or past pkt.total and abort the
> session.  The check has to be ">=3D" and not ">": pkt.total is a packet
> count,
> so the last valid packet is pkt.total - 1.
>
> The abort code depends on the role.  A receiver rejects a bad offset with
> J1939_XTP_ABORT_BAD_EDPO_OFFSET, which the comment next to the definition
> describes as "Bad EDPO offset" and which had no callers.  A transmitter
> only
> builds an EDPO from pkt.tx_acked, which comes from the responder's
> ETP.CM_CTS, so an out-of-range value there is an oversized CTS and is
> reported as J1939_XTP_ABORT_ECTS_TOO_BIG.
>
> Bounding the CTS packet number in j1939_xtp_rx_cts_one() is a separate
> change; this one only stops the value from being used as an offset.
>
> Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>

[Severity: Low]
Since this fixes a NULL pointer dereference present since J1939 support was
introduced, should it include a Fixes tag:

  Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 590a04c453b56..b0e62822b56e4 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1849,14 +1849,43 @@ static void j1939_xtp_rx_dpo_one(struct j1939_ses=
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
> +
> +	/* ETP.CM_DPO is peer controlled.  j1939_xtp_rx_dat_one() places data at
> +	 * "dat[0] - 1 + pkt.dpo", so a value at or past pkt.total moves pkt.dpo
> +	 * beyond the reassembled buffer.  The transfer still completes: with
> +	 * pkt.dpo =3D=3D pkt.total a closing ETP.DT with dat[0] =3D=3D 0 evalu=
ates to
> +	 * the last in-order packet, so pkt.rx reaches pkt.total and the receiv=
er
> +	 * emits its own EOMA.  The loopback of that EOMA runs
> +	 * j1939_session_completed(), which asks j1939_session_skb_get() for a
> +	 * packet past the end of the queued skb, gets NULL, and passes it to
> +	 * j1939_sk_recv().
> +	 *
> +	 * pkt.total is a packet count, so the last valid packet is
> +	 * pkt.total - 1 and the check has to be ">=3D".
> +	 */
> +	if (dpo >=3D session->pkt.total) {
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

[Severity: High]
Does aborting here without calling j1939_session_timers_cancel(session) lea=
ve
session->txtimer armed?

j1939_session_cancel() only cancels session->rxtimer, which is why the other
receive-path abort handlers (j1939_xtp_rx_cts_one(),
j1939_xtp_rx_rts_session_active() and j1939_xtp_rx_dat_one()) call
j1939_session_timers_cancel(session) first.

On the transmitter path, after j1939_tp_txtimer() sends ETP.CM_DPO with an
out-of-range pkt.tx, j1939_session_tx_dat() sees NULL from
j1939_session_skb_get_by_offset() and returns -ENOBUFS, so j1939_tp_txtimer=
()
re-arms session->txtimer for 10..25 ms.  When the looped-back ETP.CM_DPO th=
en
hits this check, session->txtimer stays active on the aborting session, ret=
ries
up to J1939_XTP_TX_RETRY_LIMIT and overwrites session->err with -ENETUNREACH
(or on a receiver session, transmits CTS or EOMA and clobbers the abort
timeout via j1939_tp_set_rxtimeout()).

[Severity: Medium]
Can calling j1939_session_cancel() here race with a second cancel or timeout
update to double-arm session->rxtimer and leak a struct j1939_session
reference?

In j1939_session_cancel() (modified in commit "can: j1939: arm the abort ti=
mer
under the session list lock"), j1939_session_rxtimer_cancel() runs before
taking active_session_list_lock, and then hrtimer_start(&session->rxtimer, =
...)
runs unconditionally under the lock whenever abort_sent is true or
session->state =3D=3D J1939_SESSION_WAITING_ABORT:

CPU0                              CPU1
j1939_xtp_rx_dpo_one()            j1939_xtp_rx_dpo_one()
  j1939_session_cancel()            j1939_session_cancel()
    j1939_session_rxtimer_cancel()    j1939_session_rxtimer_cancel()
    j1939_session_list_lock()
    __j1939_session_cancel()
      state =3D WAITING_ABORT
    j1939_session_get()
    hrtimer_start(&rxtimer, ...)
    j1939_session_list_unlock()
                                      j1939_session_list_lock()
                                      /* state =3D=3D WAITING_ABORT */
                                      j1939_session_get()
                                      hrtimer_start(&rxtimer, ...)
                                        <-- overwrites armed timer, leaks r=
ef

j1939_tp_set_rxtimeout() also rearms session->rxtimer without holding
active_session_list_lock, so it can likewise arm session->rxtimer between
j1939_session_rxtimer_cancel() and hrtimer_start().  The leaked kref preven=
ts
j1939_session_destroy() from running, leaking the session and its tracked
net_device reference and hanging unregister_netdevice().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179410166344.60581.=
3898011861151549156@163.com?part=3D2
