Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039817;
	b=BEnRTOZB9nW3e/E3gq3up0Cly1nixue84wm2Rjpq4MON7MlkGXd1Hpl3mNQcbJMgWiDc
	 k7OBWP8HY4w06ehX3qnUgG5RaBQUCbz19jtfy+xTjlf+XVNw5S779I+zGRVKXN7bjE/2j
	 ZfauKxrSR3HWuNf9iYPxoNHFAKpTjBX8OMKMwC15+CDS9ZJTDXTHXaT5OY88M0VFyVgHx
	 69J2JA9KZlTYJK3m88Qrd06t1GqtiEEzo2C8UzVZs7dNOmp+gLWYrHncc3RSRPxV+0COf
	 8ihwQnmS6Odrr5NZk8JPeCxyJJF42vCJihRRHvJZVbbtr9Oh+zMNkEX6sVBZD8MSkUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039817;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bEjX+HTrIo7mOCTNdLjkH+bfWnt9x64ZCgwzVxJoUbo=;
	b=kpGakq7ql/eHt68dBPxRf+/TSkxQDUXKG/WDVK+Cypdq/tQAx5skom1gjcT531cv88xk
	 SbCRNoh+J0GbY8KhFs/AekzkZ9QHeSUECG/+pw+mjzYRvwJxIlBiY7dUulpBNEoKhABsh
	 jeS2VRk/Pif3CAs2uxFgGWBzJg4Cc49Hih+AcSmzyp+pZ05zzRAB8F+ffkrohNj4fjk4d
	 ugoj0cQXjSfgj3r3cgAD/8NFFg/agcYNpsdPzAiI3ZsLmLyCprWVGK8SMY2dQm6nu2dVQ
	 OUkxSYMhJEM5oCwbGvbl5B2zYdsHXkBD/P47ibC1fyctjOytnv+irfqWS62xoK9sTYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WbvbtiVx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F350606A31C
	for <linux-can@vger.kernel.org>; Wed, 18 Nov 2026 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WbvbtiVx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEA41F000C4;
	Wed, 18 Nov 2026 22:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039817;
	bh=bEjX+HTrIo7mOCTNdLjkH+bfWnt9x64ZCgwzVxJoUbo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WbvbtiVx/RXtxSUVe6yrW55YLGNqwzWEpggKie0FOx6hOBR24EdCC1StTf1t+Shaq
	 UT42y8wiZzA0H2qC/Sarf+HUIvSn9F2JGxiZqJf9DvGUY7qpn4+lAXAEbLqGy2X3Nu
	 cJ2wwvu0hIpO9ho7QT6YoDjs+f2lRVfR8MUuHpB0p0B5+lqL+lqMov+Ve9LtmcF6N8
	 9ZkhUHsuvGpGIV8g6R1CZSx5JunqwanS96TAxsidAnHBZsSEhYpHsI10Tnm6Xe3CFW
	 Yhf300U0jjkwVG/mzcMWpe91fhgu5LHx/ZgLaSTFY2UgLGZ+P1MMJ7E2LOyH5G+iF9
	 RXuhjvN+jGDVg==
Message-ID: <sashiko-outbox-222094@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 06/11] can: isotp: always start the rx timeout in
 ISOTP_WAIT_DATA state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261117220818.1142581-7-mkl@pengutronix.de>
References: <20261117220818.1142581-1-mkl@pengutronix.de>
 <20261117220818.1142581-7-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:10:16 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] can: isotp: rxtimer not restarted on invalid CF length in
  isotp_rcv_cf()
--

commit 94f5ff3c55fd4fb8ddb6ad8f21dc67ceb4b06102
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: always start the rx timeout in ISOTP_WAIT_DATA state

This commit starts so->rxtimer in isotp_rcv_ff() and isotp_rcv_cf()
before checking CAN_ISOTP_LISTEN_MODE or calling isotp_send_fc() so that
reception does not stay in ISOTP_WAIT_DATA without an active timeout.

Link: https://patch.msgid.link/20261117-can-bcmlock-memcg-v6-6-6826a6227d36=
@hartkopp.net

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 8229b6a69ecd0..0293d590186c4 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -726,13 +730,13 @@ static int isotp_rcv_cf(struct sock *sk, struct can=
fd_frame *cf, int ae,
>  		return 0;
>  	}
> =20
> +	/* start rx timeout, isotp_send_fc() restarts it */
> +	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
> +		      HRTIMER_MODE_REL_SOFT);
> +
>  	/* perform blocksize handling, if enabled */
> -	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs) {
> -		/* start rx timeout watchdog */
> -		hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
> -			      HRTIMER_MODE_REL_SOFT);
> +	if (!so->rxfc.bs || ++so->rx.bs < so->rxfc.bs)
>  		return 0;
> -	}
> =20
>  	/* no creation of flow control frames */
>  	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)

[Severity: Medium]
Can isotp_rcv_cf() still leave so->rx.state in ISOTP_WAIT_DATA without a
running so->rxtimer when cf->len is invalid?

Earlier in isotp_rcv_cf(), so->rxtimer is cancelled before checking
cf->len against so->rx.ll_dl:

net/can/isotp.c:isotp_rcv_cf() {
    ...
	hrtimer_cancel(&so->rxtimer);

	if (READ_ONCE(so->rx.state) !=3D ISOTP_WAIT_DATA)
		return 1;

	/* CFs are never longer than the FF */
	if (cf->len > so->rx.ll_dl)
		return 1;

	/* CFs have usually the LL_DL length */
	if (cf->len < so->rx.ll_dl) {
		/* this is only allowed for the last CF */
		if (so->rx.len - so->rx.idx > so->rx.ll_dl - ae - N_PCI_SZ)
			return 1;
	}
    ...
}

Unlike the sequence-number mismatch path below it, which resets
so->rx.state to ISOTP_IDLE, a consecutive frame that fails either cf->len
check returns before reaching the new hrtimer_start() while leaving
so->rx.state in ISOTP_WAIT_DATA.  If no further frames arrive (for
example, if the CAN device is removed), the transfer never times out and
isotp_bind() continues to fail with -EAGAIN until the socket is closed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117220818.1142=
581-1-mkl@pengutronix.de?part=3D6
