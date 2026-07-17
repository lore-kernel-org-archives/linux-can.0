Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5974E54B
	for <linux-can@vger.kernel.org>; Fri, 17 Jul 2026 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306766; cv=none; b=SXFE4dJw7fd31pddXt/ELMv/7eLg6FpBLqOeEXPLpPs5rAz2IpeHGZwuvsMzOMsdJshkBmzmNQMdWN+eRsL6X+201cYArkHsz0qVclOT0/OV0abTASaQl47XbHCNRPm4AUHtzdjaaHjn+msy0jCAtHr4GFoOukkKlAFsV7L/6GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306766; c=relaxed/simple;
	bh=XEE6wo2Q6IZKT3u+/VYSPLQlxStBWmv1hQKnqOc6/5I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VIHA1UBmFbMapnBq+nVO/6AUftbN8sipiASPqW8l24+j0r7AnE1x+mTbMnfxQiCYvoEUwVC3/a05S1wBan7zXMd93NaTngOOCypMJwr0GlncdAYA0ErSe0pqFEbZtH+Ur4aZGuR/J8CfMUiFkebRgLtgoG5WgNdTB+4pksSsCP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qtlul5vF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qtlul5vF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCDF1F000E9;
	Fri, 17 Jul 2026 16:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784306765;
	bh=PHOLYjsMMjNznIhoukl7TuDypO2DK3EJvXpkabVxj8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qtlul5vFoH4H/3lVUGXeXk1/iLrBK6w8ZX/XH5y23C9N9ZYU5bZJ/zj3XcF8CbxgN
	 ZyZVLl5Trt/TZUW96vnIHB2/qR49TNsMms1NJZQ98xZCG7Ono7tWPUyMCSq4jfeAH2
	 b8kT6leqKyGFjq+nLqPRAhYyHdG9jghToyaO1g9eYmgG3Yoth2IueCW+mzD8TjHO4n
	 8ouezZnh0CMyCiaLD80zIrAJ0U5RGLzycPhMMYlAmDls/uU+lRsIOppVw+xnB7j0Pa
	 q3Zy7VB/LHFbSLNVdz7gamndOYPjpDW2MbmqgcnSV7hzpHQhAUKpna2CxvtzfXvPDA
	 88qs+S92Oyukg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 19/19] can: isotp: serialize TX state transitions
 under so->rx_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20260716155528.809908-20-mkl@pengutronix.de>
References: <20260716155528.809908-1-mkl@pengutronix.de>
 <20260716155528.809908-20-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 16:46:04 +0000
Message-Id: <20260717164605.3DCDF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Racy evaluation of `so->tx_gen` in `isotp_tx_timeout` suppresses l=
egitimate timeout errors and forces waiters to block on subsequent transfer=
s.
--

--- Patch [19]: [PATCH net 19/19] can: isotp: serialize TX state transition=
s under so->rx_lock ---
commit d815650c77b9d2ce6acff4c164869dfbfb037f2e
Author: Oliver Hartkopp <socketcan@hartkopp.net>
can: isotp: serialize TX state transitions under so->rx_lock

This commit reorganizes the locking and state machine in the CAN ISOTP
transmit path, making sendmsg() operations fully serialized under
so->rx_lock. It introduces a generation counter (so->tx_gen) to handle
timer callbacks racing with new transfers.

Link: https://patch.msgid.link/20260712-isotp-fixes-v10-3-793a1b1ce17f@hart=
kopp.net

> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> +static enum hrtimer_restart isotp_tx_timeout(struct isotp_sock *so)
>  {
>  	struct sock *sk =3D &so->sk;
> +	u32 gen =3D READ_ONCE(so->tx_gen);
> +	u32 old_state =3D READ_ONCE(so->tx.state);
> =20
>  	/* don't handle timeouts in IDLE or SHUTDOWN state */
> +	if (old_state =3D=3D ISOTP_IDLE || old_state =3D=3D ISOTP_SHUTDOWN)
> +		return HRTIMER_NORESTART;
> +
> +	/* only claim the timeout if the state is still unchanged */
> +	if (cmpxchg(&so->tx.state, old_state, ISOTP_IDLE) !=3D old_state)
>  		return HRTIMER_NORESTART;
> =20
>  	/* we did not get any flow control or echo frame in time */
> =20
> -	/* report 'communication error on send' */
> -	sk->sk_err =3D ECOMM;
> -	if (!sock_flag(sk, SOCK_DEAD))
> -		sk_error_report(sk);
> +	if (READ_ONCE(so->tx_gen) =3D=3D gen) {

[Severity: High]
Does setting the state to ISOTP_IDLE before checking the generation
counter introduce a race condition?

If cmpxchg() successfully sets the state to ISOTP_IDLE, a concurrent
isotp_sendmsg() thread could immediately acquire the socket, set the state
to ISOTP_SENDING, and bump so->tx_gen.

If this occurs before we evaluate READ_ONCE(so->tx_gen) here, the timer
callback will incorrectly assume the transfer was superseded and skip
setting the ECOMM error. Could this lead to silent data loss?

> +		/* report 'communication error on send' */
> +		sk->sk_err =3D ECOMM;
> +		if (!sock_flag(sk, SOCK_DEAD))
> +			sk_error_report(sk);
> +	}
> =20
> -	/* reset tx state */
> -	so->tx.state =3D ISOTP_IDLE;
>  	wake_up_interruptible(&so->wait);
> =20
>  	return HRTIMER_NORESTART;
>  }

[ ... ]

> @@ -960,13 +1024,24 @@ static int isotp_sendmsg(struct socket *sock, stru=
ct msghdr *msg, size_t size)

[ ... ]

> +	/* new transfer: bump so->tx_gen and drain the old one's timers,
> +	 * still under the so->rx_lock we just claimed the socket with
> +	 */
> +	WRITE_ONCE(so->tx.state, ISOTP_SENDING);
> +	WRITE_ONCE(so->tx_gen, READ_ONCE(so->tx_gen) + 1);

[Severity: High]
If the timeout callback races with the state transition above, a
concurrent sender updating so->tx_gen here will poison the check in the
interrupted timer callback.

Could this also cause the sender thread to block waiting for an unrelated
concurrent transmission to finish, rather than handling the timeout?

> +	hrtimer_cancel(&so->txtimer);
> +	hrtimer_cancel(&so->echotimer);
> +	hrtimer_cancel(&so->txfrtimer);
> +	so->cfecho =3D 0;
> +	spin_unlock_bh(&so->rx_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716155528.8099=
08-1-mkl@pengutronix.de?part=3D19
