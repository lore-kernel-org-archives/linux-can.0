Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5143E42B32D
	for <linux-can@vger.kernel.org>; Mon, 20 Jul 2026 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556588; cv=none; b=iKRwMavdj39lNcaH+o7m9d25gHg6A/Wmb3eTEbffHf/plPG3ixd+3yyQy6Gyl8n70i6sYmb8M3q9DGZCSpAVy/zhwoC7f5MTd13aINOoty+FhvFkpFRkicM/TrIWdmqJoYdwHBQjSSf6pI3UEMTSsKPqbndGSm7c4fENiaN5Thg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556588; c=relaxed/simple;
	bh=Hr7fa9C7cb5+P5d07vx2NB+CpsyiPk8tubQPNDPClZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DQ+0PTm+XjxETR30CAI71uONMraOiAgzRjeyAPO7uIBZY0Q8LmibdT5HANqg63+IxobKFm46V+t6YVDM3XNDKSjMJvzkoHuZmrwCYE6J2heeuqMQolNoh7NrJVmGsh5iMBwlGbV3MVBSNwMbctPtacrHScJwI7aD3RlSuh2trAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hP50gSrW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hP50gSrW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91E71F000E9;
	Mon, 20 Jul 2026 14:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784556587;
	bh=Y11dnrOrZlvHdx2ZjfTyJZb7gijNqt7GenSZRlZi68M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hP50gSrWNf9FCZaGbfA7aFffDkGLvFHZJQQrZcWeTpoeuoF8t93EVd0i0CIaWe87T
	 HL5OkOwoiM9B9YJZ6Bd8j2nDjnvwzsvqhAj/fRckxdn+4Uichsi7q44WIALDvtXFv1
	 MogmsBd06M3ymWS41oflDYUgj8ZgZM8L+Lbo4+ukSDs1Q1qJXpT0y8+iNTYCkSB+aH
	 nejD/gO6tbgJTOcJpthsij4WelieNg39aDI+sQL64PBKpx6PFBEN4fw+sPIdF4b0Vj
	 r3S14gtAIvvxsPL9Qt6XEmnRhTwAsSwVcdEXu5VWpwns5B1UReCSjYObB2951R+84T
	 4p74hvRqODHlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] can: isotp: fix timer drain order, wakeup handling
 and tx_gen ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260720135701.124633-1-socketcan@hartkopp.net>
References: <20260720135701.124633-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 14:09:46 +0000
Message-Id: <20260720140946.A91E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A stale local echo from an interrupted transfer can prematurely co=
mplete a new transfer if their first 3 payload bytes match.
- [Medium] Missing READ_ONCE()/WRITE_ONCE() for lock-free accesses to `so->=
cfecho` causes data races.
--

--- Patch [1]: [PATCH v2] can: isotp: fix timer drain order, wakeup handlin=
g and tx_gen ordering ---
commit f9db7885e3deec5f74c17326758f7a0025ece72d
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: fix timer drain order, wakeup handling and tx_gen ordering
   =20
This patch is a follow-up to commit cf070fe33bfb ("can: isotp: serialize
TX state transitions under so->rx_lock") which addresses following
sashiko-bot findings:

[ ... ]

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 54becaf6898f1..ff6299f5c4a0b 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -899,32 +901,32 @@ static void isotp_rcv_echo(struct sk_buff *skb, voi=
d *data)
>  	spin_lock(&so->rx_lock);
> =20
>  	/* so->cfecho may since belong to a new transfer; recheck under lock */
> -	if (so->cfecho !=3D *(u32 *)cf->data)
> +	if (READ_ONCE(so->cfecho) !=3D *(u32 *)cf->data)
>  		goto out_unlock;

[Severity: High]
This is a pre-existing issue, but can a stale local echo prematurely comple=
te
a new transfer if their first 4 payload bytes match?

If a transmission (SF or CF-broadcast) is interrupted by a signal,
isotp_sendmsg() cancels timers, sets the state to IDLE, and returns, leaving
a pending loopback echo in the network queue.=20

If the user immediately retries sendmsg with the exact same payload, won't
this stale echo be processed by isotp_rcv_echo() and match the new so->cfec=
ho
tag, since the tag is derived solely from the first 4 bytes of the CAN fram=
e?

This seems like it could cause the sender to falsely believe the transfer is
complete while it may still be in progress, violating the
CAN_ISOTP_WAIT_TX_DONE guarantee.

> =20
>  	/* cancel local echo timeout */
>  	hrtimer_cancel(&so->echotimer);
> =20
>  	/* local echo skb with consecutive frame has been consumed */
> -	so->cfecho =3D 0;
> +	WRITE_ONCE(so->cfecho, 0);

[ ... ]

> @@ -1046,29 +1052,32 @@ static int isotp_sendmsg(struct socket *sock, str=
uct msghdr *msg, size_t size)
>  		if (msg->msg_flags & MSG_DONTWAIT)
>  			return -EAGAIN;
> =20
> -		if (so->tx.state =3D=3D ISOTP_SHUTDOWN)
> +		if (READ_ONCE(so->tx.state) =3D=3D ISOTP_SHUTDOWN)
>  			return -EADDRNOTAVAIL;
> =20
>  		/* wait for complete transmission of current pdu */
>  		err =3D wait_event_interruptible(so->wait,
> -					       so->tx.state =3D=3D ISOTP_IDLE);
> +					       READ_ONCE(so->tx.state) =3D=3D ISOTP_IDLE ||
> +					       READ_ONCE(so->tx.state) =3D=3D ISOTP_SHUTDOWN);
>  		if (err)
>  			return err;
>  	}
> =20
> -	/* new transfer: bump so->tx_gen and drain the old one's timers,
> -	 * still under the so->rx_lock we just claimed the socket with
> -	 */
> -	WRITE_ONCE(so->tx.state, ISOTP_SENDING);
> -	WRITE_ONCE(so->tx_gen, READ_ONCE(so->tx_gen) + 1);
> +	/* txfrtimer's callback re-arms echotimer lock-free: drain it first */
> +	hrtimer_cancel(&so->txfrtimer);
>  	hrtimer_cancel(&so->txtimer);
>  	hrtimer_cancel(&so->echotimer);
> -	hrtimer_cancel(&so->txfrtimer);
> -	so->cfecho =3D 0;
> +
> +	/* new transfer: increment so->tx_gen and set tx.state after barrier */
> +	my_gen =3D READ_ONCE(so->tx_gen) + 1;
> +	WRITE_ONCE(so->tx_gen, my_gen);
> +	smp_wmb(); /* pairs with the cmpxchg() in isotp_tx_timeout() */
> +	WRITE_ONCE(so->tx.state, ISOTP_SENDING);
> +	WRITE_ONCE(so->cfecho, 0);

[Severity: Medium]
This is a pre-existing issue, but does this miss some READ_ONCE() and
WRITE_ONCE() annotations for lock-free accesses to so->cfecho in
isotp_sendmsg() and isotp_bind()?

While the patch aligns many accesses, isotp_sendmsg() sets the transmission
state to ISOTP_SENDING before so->cfecho is initialized and written for
SF-mode and CF-broadcast. Because the state is already ISOTP_SENDING, a
concurrently arriving stale echo can trigger isotp_rcv_echo(), which reads
so->cfecho via READ_ONCE().=20

However, isotp_sendmsg() still performs plain reads and writes later in the
function:

    if (so->cfecho)
        pr_notice_once("can-isotp: uninit cfecho %08X\n", so->cfecho);

    /* ... */
    so->cfecho =3D *(u32 *)cf->data;

Similarly, isotp_bind() performs a plain write to so->cfecho =3D 0; while
isotp_rcv_echo() could still be processing an in-flight echo.=20

Could this lead to data races or torn reads?

>  	spin_unlock_bh(&so->rx_lock);
> =20
>  	/* so->bound is only checked once above - a wakeup may have
> -	 * unbound/rebound the socket meanwhile, so re-validate it
> +	 * unbound/rebound the socket meanwhile =3D> recheck
>  	 */
>  	if (!so->bound) {
>  		err =3D -EADDRNOTAVAIL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720135701.1246=
33-1-socketcan@hartkopp.net?part=3D1
