Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484477;
	b=r0PUugh3TWxObfsgzxum4rYFcXgBdb0mzyHDxHNNm0MzTODkvnpamB6XibRLx6iY+wK4
	 gas0myJlWPsya+s0VQo42z0gIqXiqt2UPI4SGGAeELhn7eNIHc8Y0vhtEmrrPrmLEktkp
	 Fve7Dgar2WA1qnnfPgHd7HIAvLmu1m6LujLgWesTtZwr7PovuXKk73YfgczZYkbjd9/PB
	 9wm4BantSCovPklwWcDFRJriOJIv0IzJyJHEoqRKh/adfDNVl07njy4v+Zhvqi0obZ6/E
	 VGyOuGPri0H2BwdJ2qHx7QTVpKzqIOOTM8CDwPsFmp7j7yxmeTFf9POn0KW5vktV+Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484477;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GOiYOwDTMLuI377qcDRM3BT7G1PIxpU75EHZh9LEOHc=;
	b=lUP0TugBmOiU9u4hq2fwtS0IKqT/cQycTGQ590Q/WL1pAhEsGvZ+BHDIWRhB+zlFv3aV
	 okdlqfXyIhq2dWPYHOqh7CtH0sAfj7JxTgDWvN4PvGB6lsrglJAK/IiZ3AnvXugEGE8e4
	 gBLu12Jmu69/fVCufaGmaPXt6B6Q8DCxyCv4vks0em/A75fiFVuKCPBO9onQRmWK3GZvY
	 VilqtU3stALK6MnGrDXPmR67ayNdnYCjYYQwIGBN0HhBp17Hoevt58fiGQ9C+SbQpuzpN
	 3RZNE4VWQTdaqRoOlRUnerfSVBzVwCi3ab1WuK81akCdPWtCVLNcmm9W2OT01lmSpmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmQVj9D2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2458E606A31E
	for <linux-can@vger.kernel.org>; Tue, 20 Oct 2026 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmQVj9D2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149021F000CD;
	Tue, 20 Oct 2026 08:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792484476;
	bh=GOiYOwDTMLuI377qcDRM3BT7G1PIxpU75EHZh9LEOHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hmQVj9D21ZgE93W9Il8mktTAExd3Z3/2TZI/X5XghW15SZ0lr0+yImHUNyfJs1ESW
	 xoxrwxx/D4cB9yYAUFEkiFC0WR6bIbpWRKcPQ3bTgsmKGwx1oGjGttZapvwH72zwWy
	 2ICdvUlhcuDXv7T024BhrI5mIg8uHTESk7v9Me6PyKhLKCiNKf3kiZYOqUQGx80iKU
	 D3RQS7pkwGRLFke7kVK+ysJJ25yEYmVdX7/M1pHKvn0E0wTaJN+RwSnFeeTGMxMpE5
	 MCbS+3c44fu+fr5hoILvEaajRqkYfurCtKJTK0XeWOBNGHSttk444QaJc6sICshv9K
	 Xb+duuENi7v7g==
Message-ID: <sashiko-outbox-178529@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5] can: j1939: validate the EDPO packet number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chaosheng Qu" <quchaosheng000406@163.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261020025036.74454-1-quchaosheng000406@163.com>
References: <20261020025036.74454-1-quchaosheng000406@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:21:15 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] can: j1939: stranded session in j1939_xtp_rx_dat_one() after bad E=
DPO
- [Medium] can: j1939: aborted ETP session in j1939_xtp_rx_dpo_one() still =
accepts data
--

commit f0380724094c96563fb623cd857d2412a9cce46d
Author: Chaosheng Qu <quchaosheng000406@163.com>

can: j1939: validate the EDPO packet number

This commit validates the packet number in ETP.CM_DPO (EDPO) against
session->pkt.total and aborts the session if the offset is out of range.
It also makes j1939_session_cancel() return whether the abort timer was
armed and adds a NULL check in j1939_session_completed().

Link: https://sashiko.dev/#/patchset/20260928193312.553632-1-mkl@pengutroni=
x.de?part=3D3

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..8e171b7138594 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1158,13 +1158,16 @@ static void __j1939_session_cancel(struct j1939_s=
ession *session,
>  		j1939_sk_send_loop_abort(session->sk, session->err);
>  }
> =20
> -static void j1939_session_cancel(struct j1939_session *session,
> +static bool j1939_session_cancel(struct j1939_session *session,
>  				 enum j1939_xtp_abort err)
>  {
> +	bool active =3D false;
> +
>  	j1939_session_list_lock(session->priv);
> =20
>  	if (session->state >=3D J1939_SESSION_ACTIVE &&
>  	    session->state < J1939_SESSION_WAITING_ABORT) {
> +		active =3D true;
>  		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
>  		__j1939_session_cancel(session, err);
>  	}
> @@ -1173,6 +1176,8 @@ static void j1939_session_cancel(struct j1939_sessi=
on *session,
> =20
>  	if (!session->sk)
>  		j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
> +
> +	return active;
>  }

[ ... ]

> @@ -1823,14 +1837,36 @@ static void j1939_xtp_rx_dpo_one(struct j1939_ses=
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
> +	/*
> +	 * EDPO is peer controlled.  It names the packet the announced window
> +	 * starts at, and j1939_xtp_rx_dat_one() places data at
> +	 * "dat[0] - 1 + pkt.dpo", so it has to stay inside the message.  A
> +	 * value past the end moves pkt.dpo beyond the reassembled buffer and
> +	 * makes the ETP completion path look up offset "pkt.dpo * 7", which is
> +	 * no longer covered by any queued skb.
> +	 */
> +	if (dpo >=3D session->pkt.total) {
> +		netdev_warn(session->priv->ndev,
> +			    "%s: 0x%p: EDPO %u out of range (total %u), aborting\n",
> +			    __func__, session, dpo, session->pkt.total);
> +		j1939_session_timers_cancel(session);
> +		if (!j1939_session_cancel(session,
> +					  J1939_XTP_ABORT_BAD_EDPO_OFFSET))
> +			j1939_session_deactivate_activate_next(session);
> +		return;
> +	}

[Severity: High]
Can an ETP.DT frame arriving right after a rejected ETP.CM_DPO strand the
struct j1939_session and leak its net_device references?

When the first out-of-range ETP.CM_DPO arrives on an active receiving ETP
session from a non-local peer, j1939_xtp_rx_dpo_one() calls
j1939_session_cancel(), which transitions session->state to
J1939_SESSION_WAITING_ABORT, arms session->rxtimer for 500 ms, and returns
true. The session remains on priv->active_session_list with session->last_c=
md
and session->pkt.dpo unchanged (and for a non-local peer SA, the echoed abo=
rt
frame has J1939_ECU_LOCAL_SRC set and J1939_ECU_LOCAL_DST unset, so
j1939_tp_cmd_recv() does not deactivate the receiving session on loopback).

In ETP, ETP.CM_DPO is immediately followed by ETP.DT data frames (such as in
the 5-frame sequence in the commit description). When that ETP.DT frame
arrives within 500 ms and fails validation in j1939_xtp_rx_dat_one() (for
example, because session->last_cmd was not updated to J1939_ETP_CMD_DPO, or
because dat[0] =3D=3D 0 with session->pkt.dpo =3D=3D 0 evaluates packet to =
-1), it
jumps to out_session_cancel:

net/can/j1939/transport.c:j1939_xtp_rx_dat_one() {
    ...
 out_session_cancel:
	kfree_skb(se_skb);
	j1939_session_timers_cancel(session);
	j1939_session_cancel(session, abort);
	j1939_session_put(session);
}

Here j1939_session_timers_cancel() cancels the pending 500 ms abort rxtimer,
and j1939_session_cancel() sees session->state =3D=3D J1939_SESSION_WAITING=
_ABORT,
does not re-arm rxtimer, and returns false. Because j1939_xtp_rx_dat_one()
(and similarly out_session_cancel in j1939_xtp_rx_cts_one()) ignores the
return value of j1939_session_cancel(), the session is left on
priv->active_session_list with no active timers, leaking struct j1939_sessi=
on,
struct j1939_priv, and the net_device references if the socket is closed
before interface teardown.

> +
>  	/* transmitted without problems */
> -	session->pkt.dpo =3D j1939_etp_ctl_to_packet(skb->data);
> +	session->pkt.dpo =3D dpo;
>  	session->last_cmd =3D dat[0];
>  	j1939_tp_set_rxtimeout(session, 750);
> =20

[Severity: Medium]
What happens if a remote peer follows an out-of-range ETP.CM_DPO with a val=
id
in-range ETP.CM_DPO and ETP.DT frames before the 500 ms abort timeout expir=
es?

After the first out-of-range ETP.CM_DPO puts the receiving session into
J1939_SESSION_WAITING_ABORT, the session stays on priv->active_session_list
for 500 ms with its previous session->pkt.dpo and session->last_cmd intact.

Because neither j1939_xtp_rx_dpo_one(), j1939_xtp_rx_dat_one(), nor
j1939_session_completed() checks session->state or session->err:

net/can/j1939/transport.c:j1939_xtp_rx_dat_one() {
    ...
	switch (session->last_cmd) {
	case 0xff:
		break;
	case J1939_ETP_CMD_DPO:
		if (skcb->addr.type =3D=3D J1939_ETP)
			break;
    ...
}

Wouldn't subsequent valid ETP.CM_DPO and ETP.DT frames received within that
500 ms window overwrite rxtimer, reassemble the payload, send ETP.CM_EOMA, =
and
deliver the already-aborted session's payload to user space via
j1939_session_completed() -> j1939_sk_recv()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020025036.7445=
4-1-quchaosheng000406@163.com?part=3D1
