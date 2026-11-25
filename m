Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630697;
	b=g2S56YNnynu2xvgFkoT6In53MLslMHEYTm7zWA5yD/uEfwpaLyG9z+GLicJ7VYAP3br/
	 KlON1ZA+D0Kw0VEvh9NkK7NLz3TjKgGAC50Qsnyu80hSJyniszJHbru3nQQmx4ebSSJQD
	 /8tE5DEJA37baH9GuIHGdfHvYV2SKA31XmE23CO6d6v2HZ4FrS7MXHEGRYdVSlTOc3xmM
	 JmaFQ2qF24TwYxvVXxjWUxcd7J2NwYgsSbTzngwQXCmHLpJI3gzGbSlfrhY0m/jYSrI0/
	 i/qWTEGVIYDvHNL6P8wX9EaF08nnKOPoa2Ia5OHtpTfrbc0fR0XFo+79Xig+R2NmkLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630697;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xXWFbqmp3LDYv+b4hPYuWyvSUNv3Gb3/UfHgOu30yYo=;
	b=dpgdxEem6smYzTs3CEhiJ0JOquDipgvx5kEXljMmVeEVwrZDSUgIkZSyQ9N6TiMvGH20
	 9cO3iugGCllii8N1aguH723YFjh+B1BVyxOoQh+4VqemgDLgKzABI2LhGc2xlwsaxk+w7
	 39ttGT8VVpB7ff7tW/iPOwvMTcvZvzwoiEaP1vIFycWpMqRaUdSQ4XBme9kUjYEKBZye5
	 6eUjc/eBg6IQuEP4Z6e7TOqU8z+WiibTGGXgNmv0j1WuUvWqT1FmnhTOzAVfSQvvNNzxT
	 0oGpFGBpBMcnWUYvQTMwNR6+go/mvQbZ5dxGJmhwg2u7BuCumHJMEywElyAfK4wZLEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XF/DynUT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC31C606A33F
	for <linux-can@vger.kernel.org>; Wed, 25 Nov 2026 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XF/DynUT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C36A1F000EB;
	Wed, 25 Nov 2026 18:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795630697;
	bh=xXWFbqmp3LDYv+b4hPYuWyvSUNv3Gb3/UfHgOu30yYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XF/DynUT+4pzAW12EQwkhjOjrQ/yG5LsqHh4N4Rgc/f28JlMF4H94Xv9Fs1g3sz+j
	 k1HscaL9JGj8L/dFNWwMydGg3dlkimuOdDuBsePMHJTNMf2OncnCVCpP64Td81fpe6
	 6KspqjcIFwYvao/muea49JGPOdZ3WLu4KSGLc4fRBSnXTuUaDSQCKe6xfmRNG8N99c
	 79weeqxCWcNrAp7c6LQUbIaZeQL1fGnarVHixYEBV9rMw+Mbs5KJ+Tv8ypuG7Es2li
	 EQXC3+AU+xHwSD+9KPG4JcHIeW/6mdY1hKuRviI1Kz2S07Tj9zMon55a8PVKsXxvpU
	 NuZ5XBZ5Bfg0Q==
Message-ID: <sashiko-outbox-233959@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] can: j1939: reject an out-of-range data packet
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Piyus Kedia" <piyus@iiitd.ac.in>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261124181757.638280-1-piyus@iiitd.ac.in>
References: <20261124181757.638280-1-piyus@iiitd.ac.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:18:16 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] can: j1939: session leak in j1939_xtp_rx_dpo_one() on repeated
  invalid DPO
- [Medium] can: j1939: aborted session completed in
  j1939_session_completed() on EOMA
--

commit e965a3918b3f2f0306bb887a70504c5f042637e7
Author: Piyus Kedia <piyus@iiitd.ac.in>

can: j1939: reject an out-of-range data packet offset

This commit rejects out-of-range ETP data packet offsets in
j1939_xtp_rx_dpo_one() and looks up the completed receive message skb at
offset 0 in j1939_session_completed().

Link: https://lore.kernel.org/all/179553126874.3135.14817947057284289051@ke=
rnel.org/

> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index 8fcfd13e5e6f8..225467843e428 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1242,10 +1242,15 @@ static void j1939_session_completed(struct j1939_=
session *session)
>  	struct sk_buff *se_skb;
> =20
>  	if (!session->transmission) {
> -		se_skb =3D j1939_session_skb_get(session);
> -		/* distribute among j1939 receivers */
> -		j1939_sk_recv(session->priv, se_skb);
> -		consume_skb(se_skb);
> +		/* the whole message, not the window the peer's last DPO
> +		 * happened to name
> +		 */
> +		se_skb =3D j1939_session_skb_get_by_offset(session, 0);
> +		if (se_skb) {
> +			/* distribute among j1939 receivers */
> +			j1939_sk_recv(session->priv, se_skb);
> +			consume_skb(se_skb);
> +		}
>  	}
> =20
>  	j1939_session_deactivate_activate_next(session);

[Severity: Medium]
Can an incoming EOMA frame still complete a receive session that
j1939_xtp_rx_dpo_one() already cancelled?

After j1939_session_cancel() transitions the session to
J1939_SESSION_WAITING_ABORT and queues J1939_ERRQUEUE_RX_ABORT, the
session stays on priv->active_session_list until the abort frame or the
500 ms rxtimer deactivates it.  If an EOMA frame arrives during that
window, j1939_xtp_rx_eoma() finds the session and calls
j1939_xtp_rx_eoma_one() -> j1939_session_completed() without checking
session->state or session->err.  Because j1939_session_completed() now
fetches offset 0 instead of pkt.dpo * 7, it delivers the aborted
session's skb to receiving sockets via j1939_sk_recv() and queues a
second J1939_ERRQUEUE_RX_ABORT when the session is destroyed.

> @@ -1823,14 +1828,25 @@ static void j1939_xtp_rx_dpo_one(struct j1939_ses=
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
> +		netdev_info(session->priv->ndev,
> +			    "%s: 0x%p: data packet offset %u is not below the %u packet(s) of=
 this session\n",
> +			    __func__, session, dpo, session->pkt.total);
> +		j1939_session_timers_cancel(session);
> +		j1939_session_cancel(session, J1939_XTP_ABORT_FAULT);
> +		return;
> +	}

[Severity: High]
Does a second out-of-range DPO frame leak the session and its netdev
references?

On the first invalid DPO, j1939_session_cancel() sets session->state to
J1939_SESSION_WAITING_ABORT and starts the 500 ms rxtimer:

net/can/j1939/transport.c:j1939_session_cancel() {
	if (session->state >=3D J1939_SESSION_ACTIVE &&
	    session->state < J1939_SESSION_WAITING_ABORT) {
		j1939_tp_set_rxtimeout(session, J1939_XTP_ABORT_TIMEOUT_MS);
		__j1939_session_cancel(session, err);
	}
}

If a second invalid DPO arrives while the session is still in
J1939_SESSION_WAITING_ABORT (for example, when the peer source address is
not local so the looped-back abort frame is not received locally, or when
back-to-back DPO frames are already queued), j1939_session_timers_cancel()
cancels the 500 ms rxtimer and j1939_session_cancel() does not restart it.
The session then stays on priv->active_session_list with no running
timers, leaking the session, its receive skb, and its netdev_hold()
references so unregister_netdevice() hangs after the socket closes.

Should this check for J1939_SESSION_WAITING_ABORT and call
j1939_session_deactivate_activate_next(session), the same way
j1939_xtp_rx_rts_session_active() does?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124181757.6382=
80-1-piyus@iiitd.ac.in?part=3D1
