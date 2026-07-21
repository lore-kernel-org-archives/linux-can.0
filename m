Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE3F3C4B86
	for <linux-can@vger.kernel.org>; Tue, 21 Jul 2026 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625159; cv=none; b=QW/P5XRROzO6/Uq26Sgc513ShBt8CMglNBtxRW8+UY2c6EcOD+AdnPUoqEIGvPXhV7Guhd9RwttIb/dlbXlFUmWoz0Q9FBmxjRBu0mMaRvLPtDlABp6QX1LnQl1f15LII0AEvutf/eHtK5U4PoEhzwk1k6uUQSE4pMaoWYd66HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625159; c=relaxed/simple;
	bh=g1xeUx21erwPXnn1CGi22VHmTYCacKmAbyFtEDLkpYs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=clFKeukMy+GG++NPdEePSyuDeX2qtf37XF77614DneauX33YQ0T5fX3s5WYIOV/s5/ALPsvHam53C6/JNAcnw2rfvUjtij6p4+D9bhZwxZ5AOBMYwd/YbhyOmKfwoOC8k5Ec0IUl65HUOJwfeUezT7hV+LX4Wo7NrM0zirtM9GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmDreucf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmDreucf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4C21F00A3A;
	Tue, 21 Jul 2026 09:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784625158;
	bh=S69Zi5vFpW2bnkIphYgKTkHuo+9GyeNpCNaVWCZUP6Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KmDreucfz36vrqaqQAeLdj9t4cW+ZAh/SsRqTKpH30UJ33jMOgMuj3MLn2KyAsTnK
	 NyxYGH6AXu4XwCWIH48dUjRtOovjgUsBlCacti/E938sZVGo9sbUsESZQwyN3hEI2d
	 ON6P4gaR1PhfBbJJGb5Dhjc3vnYp55eNRywFOBV4N+22wW1by8BytpiFuqaHbwc/C0
	 R1x6voBabEJQy6JETNvXfkvu7SQyll+MtiQU5YAqHoKTWXzrpBQJ9Ljvvr2uC4tkgJ
	 fEZZbdb5uEMNFzv/IEpfTXxQEhUa3f9Kdf2oh6vl3HIGMp2cIuLtJSabtXtSQEMKqo
	 IxryeI5kiMlDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] can: isotp: fix timer drain order, wakeup handling
 and tx_gen ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260721085544.15541-1-socketcan@hartkopp.net>
References: <20260721085544.15541-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 09:12:37 +0000
Message-Id: <20260721091238.2C4C21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] TOCTOU race in `isotp_tx_timeout` exposes intermediate state, corr=
upting error reporting and overwriting subsequent transfer results.
- [High] Silent failure when TX timeout error is overwritten by rapidly com=
pleting concurrent transfers, causing false success reports.
--

--- Patch [1]: [PATCH v6] can: isotp: fix timer drain order, wakeup handlin=
g and tx_gen ordering ---
commit fc49d60dded5144b72722946923b8f8955622fbf
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: fix timer drain order, wakeup handling and tx_gen ordering
   =20
This patch addresses sashiko-bot findings by serializing TX state transitio=
ns
and handling concurrent claims during wait_tx_done timeouts. It also aligns
lock-free accesses and uses skb->hash as a unique loopback echo frame indic=
ator.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 54becaf6898f1..703d110377f87 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -965,10 +1007,10 @@ static enum hrtimer_restart isotp_tx_timeout(struc=
t isotp_sock *so)
>  	/* only claim the timeout if the state is still unchanged */
>  	if (cmpxchg(&so->tx.state, old_state, ISOTP_IDLE) !=3D old_state)
>  		return HRTIMER_NORESTART;
> =20
> -	/* we did not get any flow control or echo frame in time */
> +	/* detected timeout: report 'communication error on send' */
> +	WRITE_ONCE(so->tx_result, isotp_pack_tx_result(gen, ECOMM));

[Severity: High]
Could this lead to a race condition where a stale error corrupts a new
transfer?=20

If this thread is preempted immediately after the cmpxchg() sets the state
to ISOTP_IDLE, the socket becomes available for other threads.

A concurrent sendmsg() thread could then claim the socket, increment
so->tx_gen, and complete a new transfer.=20

When this timeout handler resumes and executes the WRITE_ONCE() above, it
would overwrite the new transfer's result with the stale ECOMM error and
the old generation tag.=20

Later, when the new transfer's waiter in isotp_sendmsg() reads so->tx_resul=
t,
it checks that so->tx_gen still matches its own claim:

isotp_sendmsg() {
        ...
        /* ISOTP_IDLE: so->tx_gen still matches our own claim */
        err =3D isotp_get_tx_err(READ_ONCE(so->tx_result));
        if (err)
                return -err;
}

Since so->tx_gen matches the new transfer, the waiter extracts the error
without validating the generation tag inside tx_result, falsely returning
-ECOMM instead of success.

> =20
>  	if (READ_ONCE(so->tx_gen) =3D=3D gen) {
> -		/* report 'communication error on send' */
>  		sk->sk_err =3D ECOMM;
>  		if (!sock_flag(sk, SOCK_DEAD))

[ ... ]

> @@ -1223,20 +1274,57 @@ static int isotp_sendmsg(struct socket *sock, str=
uct msghdr *msg, size_t size)
>  	if (wait_tx_done) {
> -		/* wait for complete transmission of current pdu */
> -		err =3D wait_event_interruptible(so->wait, so->tx.state =3D=3D ISOTP_I=
DLE);
> +		/* wake up for:
> +		 * - concurrent sendmsg() claiming a new transfer
> +		 * - complete transmission of current PDU
> +		 * - shutdown state change in isotp_release()
> +		 */
> +		err =3D wait_event_interruptible(so->wait,
> +					       READ_ONCE(so->tx_gen) !=3D my_gen ||
> +					       READ_ONCE(so->tx.state) =3D=3D ISOTP_IDLE ||
> +					       READ_ONCE(so->tx.state) =3D=3D ISOTP_SHUTDOWN);
>  		if (err)
>  			goto err_event_drop;
> =20
> -		err =3D sock_error(sk);
> +		if (READ_ONCE(so->tx_gen) !=3D my_gen) {
> +			/* a new transfer has since been claimed - so->tx.state
> +			 * already belongs to it, but so->tx_result still
> +			 * carries our own completion status, unless a second
> +			 * transfer has since completed and overwritten it too
> +			 */
> +			u32 result =3D READ_ONCE(so->tx_result);
> +			int tx_err =3D 0;
> +
> +			if (isotp_get_tx_gen(result) =3D=3D my_gen)
> +				tx_err =3D isotp_get_tx_err(result);
> +
> +			return tx_err ? -tx_err : size;
> +		}

[Severity: High]
Can a timed-out transfer falsely return success if its error is overwritten
by a concurrent transfer?

If a transfer times out, so->tx_result is set to the error code and the
waiting sendmsg() thread is woken up.

Before the original thread gets CPU time, a concurrent thread calling
sendmsg() could claim the newly IDLE socket and complete a short transfer.
This successful transfer unconditionally overwrites so->tx_result with 0:

isotp_rcv_echo() {
        ...
        if (so->tx.idx >=3D so->tx.len) {
                /* we are done */
                WRITE_ONCE(so->tx_result, isotp_pack_tx_result(so->tx_gen, =
0));
                WRITE_ONCE(so->tx.state, ISOTP_IDLE);
                ...
}

When the originally woken thread finally runs, it observes that
READ_ONCE(so->tx_gen) !=3D my_gen and enters this block.=20

Since the generation tag inside the overwritten tx_result no longer matches
my_gen, it defaults to tx_err =3D 0 and returns the payload size. This would
cause the application to silently lose data, falsely believing its message
was sent successfully.

> +
> +		if (READ_ONCE(so->tx.state) =3D=3D ISOTP_SHUTDOWN) {
> +			/* isotp_release() has taken over the claim */
> +			err =3D -EADDRNOTAVAIL;
> +			goto err_event_drop;
> +		}
> +
> +		/* ISOTP_IDLE: so->tx_gen still matches our own claim */
> +		err =3D isotp_get_tx_err(READ_ONCE(so->tx_result));
>  		if (err)
> -			return err;
> +			return -err;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721085544.1554=
1-1-socketcan@hartkopp.net?part=3D1
