Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB0A46D2CA
	for <linux-can@vger.kernel.org>; Tue, 21 Jul 2026 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651189; cv=none; b=VIfyxZ6SuwkFbt+VKICB9IJb/JOqitNq3q6jht1wev/yIvRSr5l5+Iex2D0SB3o9Xa2wNn2PoPvRs2f6DlxK4h1ziAkz584jcXmZ6jCHF4OVJdqVFuQPWMMG5JrAAW17fjbIw7mV02AZ7eVlaAIzysLgJPp5GsPUhFR5DuIIXdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651189; c=relaxed/simple;
	bh=LRQePpEtD7FoyX/mhFcjrPAgOJI1Q4R5rWgDiRdv6W4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S7JnB3+0UfRXTTeBofDQzC5N9HDQ2iBTY0p/JjD6Q2QzFgCpsW9/+AEpQm8vKATVLXAQlyHMqOCB36bRByqdnKu5Ycp/gMXG6+48pA5GEbYF1CSKapj539B7iMgQ2KdaKUpJbb6A5AbrDhw8GiEdEZl8jxzw7Vy9R5oMvA7ejg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGx3Ws7X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGx3Ws7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6521F000E9;
	Tue, 21 Jul 2026 16:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784651188;
	bh=Cl4UtiDDSpB6BduBfNJSQbnXwZJapQHyMSr44zb1b5w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DGx3Ws7XKit/XcpHKo7Gp6YvxSA3w1nf6M91P23v30tKsvUC9trP8I4hxHYOEpLLZ
	 l/TJk7EJy372USOZ1qoKi8RDejFfANX++UwFdVD1ATcodOWnsTuKWk02GkBjMH3M1N
	 eyB/dUpur0cYOOt8vamxWJVv65nY6JlGHkfoxWxab608dloT4owb6nhO/FBL5EKGb5
	 sccu8X/AFhdGQCFKGGrWT7SZ/b0hasQKpBmuae1EvTGrBd2sAngN6BssF5CrU+NCEe
	 Notj/zpFIrML3QZFVY2aPyhirIn18MHZHoof9dkjnrHa2wZgcMGgG/LyX44nrJe3Im
	 Fop1qGTWkni7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9] can: isotp: fix timer drain order, wakeup handling
 and tx_gen ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260721161350.33874-1-socketcan@hartkopp.net>
References: <20260721161350.33874-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 16:26:27 +0000
Message-Id: <20260721162627.BB6521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] A 24-bit generation counter wrap-around combined with uninitiali=
zed tx_result slots can lead to falsely reporting success for timed-out tra=
nsfers.
--

--- Patch [1]: [PATCH v9] can: isotp: fix timer drain order, wakeup handlin=
g and tx_gen ordering ---
commit ff6af136ee9e3a0bf07e3a23e40b4fe8fbb8be75
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: fix timer drain order, wakeup handling and tx_gen ordering

This patch addresses various lock-free state transition and timer handling
issues in the ISOTP TX path. It introduces a generation counter and packed
result slots to safely pass transmission status back to the sender.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 54becaf6898f1..09c0ee0fc9f3b 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -177,6 +187,52 @@ static LIST_HEAD(isotp_notifier_list);

[ ... ]

> +/* fetch the result recorded for 'gen', as a (negative) errno (0 for suc=
cess) */
> +static int isotp_get_tx_result(struct isotp_sock *so, u32 gen)
> +{
> +	u32 result =3D READ_ONCE(so->tx_result[gen % ISOTP_TX_RESULT_SLOTS]);
> +
> +	if (isotp_get_tx_gen(result) !=3D gen) {
> +		pr_notice_once("can-isotp: tx_result[] slot reused before read\n");
> +
> +		/* report failure rather than risk a false success */
> +		return -ECOMM;
> +	}
> +
> +	return -(isotp_get_tx_err(result));
> +}

[Severity: Medium]
Can this stale check pass incorrectly if the 24-bit generation counter wraps
around?

If a previous transfer succeeded, this slot will hold a success value.
If a user subsequently performs exactly 16,777,216 failed transfers
(for example, hitting local ENOBUFS errors that increment the generation
but never update the result slot), the generation counter will wrap back
to this exact value, making the stale success value look like a valid result
for the current generation.

[ ... ]

> @@ -946,10 +1017,14 @@ static void isotp_rcv_echo(struct sk_buff *skb, vo=
id *data)

[ ... ]

>  static enum hrtimer_restart isotp_tx_timeout(struct isotp_sock *so)
>  {
> @@ -965,14 +1040,14 @@ static enum hrtimer_restart isotp_tx_timeout(struc=
t isotp_sock *so)
>  	if (cmpxchg(&so->tx.state, old_state, ISOTP_IDLE) !=3D old_state)
>  		return HRTIMER_NORESTART;
> =20
> -	/* we did not get any flow control or echo frame in time */
> +	/* detected timeout: report 'communication error on send' */
> =20
> -	if (READ_ONCE(so->tx_gen) =3D=3D gen) {
> -		/* report 'communication error on send' */
> -		sk->sk_err =3D ECOMM;
> -		if (!sock_flag(sk, SOCK_DEAD))
> -			sk_error_report(sk);
> -	}
> +	/* a stale read of this slot by a waiter still falls back to ECOMM */
> +	isotp_set_tx_result(so, gen, ECOMM);

[Severity: Medium]
Does this order of operations allow a timed-out transfer to incorrectly ret=
urn
success?

The state is updated to ISOTP_IDLE via cmpxchg before the result is set.
Updating the state to ISOTP_IDLE wakes up the waiting process in
isotp_sendmsg(), which then reads the result slot.

If the generation counter wrapped around as described above, and the waiter
reads the slot before isotp_set_tx_result() writes the ECOMM error, it seems
the waiter will read the perfectly matching stale success value.

[ ... ]

> @@ -1046,29 +1123,32 @@ static int isotp_sendmsg(struct socket *sock, str=
uct msghdr *msg, size_t size)

[ ... ]

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
> +	my_gen =3D isotp_inc_tx_gen(READ_ONCE(so->tx_gen));
> +	WRITE_ONCE(so->tx_gen, my_gen);
> +	smp_wmb(); /* pairs with the cmpxchg() in isotp_tx_timeout() */
> +	WRITE_ONCE(so->tx.state, ISOTP_SENDING);

[Severity: Medium]
Should the result slot be cleared when a new transfer claims a generation?

Since the new generation is claimed here, setting the corresponding result =
slot
to an uninitialized or pending state would ensure that a stale success value
from a wrapped-around generation counter cannot be mistakenly read by the
waiter on a timeout.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721161350.3387=
4-1-socketcan@hartkopp.net?part=3D1
