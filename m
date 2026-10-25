Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792967283;
	b=qqn0shqzr8Da5v1PVwxtxR9IWo+BUgjT5qL22w+RDBNkG/oZm0vDAqTI/rGSjJnso6Qp
	 9H/mIDBfdDbkV+Or72JueqFIib1TFcM/1Le5I1nOOuQIyy6uBwvySY48TtPscxaWx2zAr
	 COUpCUEgVKvF9tOYhc0wPgzFoOs+h1N3dIaa0RbgHvjGbDO8b7sj0Opp/XK907QQHW5MN
	 bsyMJrcbGglB8RUgxt3VHcheauC+SrSFY+kwsjdsqo/1t1GqDsCETn2Ds6qRNZEnvE7Ig
	 E9NS+RSP28Q7itnK15235Ntyp+1ajqh9/wpA7fJ5dyJzoOFBEPH0pQo75vGtiXmwpOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792967283;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eTPfnVKqOHf6K4A0aiDsjqJ3sj3m4j0pRk70u7qMsvM=;
	b=d1V4M8WADm+b2TtGDFggF6FIOVAoSjnOAS50xCuNQ3+Zo45l1m8h83KyftQ/oba2ngng
	 MHte0gmETIXA+UWdr5BbnSkQaVk0tpEN7wBny7sV7gUsVNy+AFQ1jb3QuGR3kJtLfBiVY
	 ynNxmYQy0IC9+Rdnq4fUISWAVZG5UfnpmNRTRZhId2rcrJobxfKi/cb/p14JQ7W4w3utD
	 dDSnAbDzabpXloUhhIwcL51C+msXc4eUHHlX1wH+snEEX5XC84J5yP5RqU2Xr817uMWbv
	 3rcpo/hMQNU91+gzx5+q5Yn0oeBtlKtl206geNGxYADOe93GQT4poW9x+NtEMNxsZoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXY2e72I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A199606A31B
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXY2e72I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80B71F01825;
	Sun, 25 Oct 2026 22:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792967282;
	bh=eTPfnVKqOHf6K4A0aiDsjqJ3sj3m4j0pRk70u7qMsvM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XXY2e72IEYHoPcdoSqBvcSVeZuoVtsPHR56Q6MrmRJJ0fcYHz6PLUnhNFEUCQUmuH
	 kKHoEyGw2S2xYbKEcUAgRk9xpOxuUx9HtsTwPK/w4J9MhVtJ8kbUYMrQ0cJ2udCmcf
	 sKTXvQoDh4svPjyFpuB2OzEYIoCfU3lEkNTdEQuEXhs4PDOxauBLntkdHGzjopOdSJ
	 iMRW01GuztDIPEDgF79gRK77IEjhFk+00mysgFuhGGSAttKSBp8TnovAFIM9EQYZ52
	 KQvAlP2MXJO1CnYsXCIZ0VAEuY3xOC6M1WTsIj4aLNb+TSOUi9DV3BXsCWIPON9iWT
	 murRYNAZGOfSw==
Message-ID: <sashiko-outbox-184481@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/7] can: isotp: check the return values of
 can_rx_register() in isotp_bind()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261025-can-rx-lock-v9-5-7ef2a2b5c2b4@hartkopp.net>
References: <20261025-can-rx-lock-v9-0-7ef2a2b5c2b4@hartkopp.net>
 <20261025-can-rx-lock-v9-5-7ef2a2b5c2b4@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 22:28:02 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] can: isotp: incomplete rollback and premature rx registration in=
 isotp_bind()
--

commit b2feba7ed89eac12b701d3372fa7b7613b9b4096
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: check the return values of can_rx_register() in isotp_bind()

This commit checks the return values of can_rx_register() in isotp_bind()
for the RX and echo receivers. If registering the echo receiver fails, it
unregisters the previously registered RX receiver and returns the error.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 1a272ce6a2bde..da80ef606ce09 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1624,16 +1624,25 @@ static int isotp_bind(struct socket *sock, struct=
 sockaddr_unsized *uaddr, int l
> =20
>  	ifindex =3D dev->ifindex;
> =20
> -	if (isotp_register_rxid(so))
> -		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
> -				isotp_rcv, sk, sock_i_ino(sk), sk);
> +	if (isotp_register_rxid(so)) {
> +		err =3D can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
> +				      isotp_rcv, sk, sock_i_ino(sk), sk);
> +		if (err)
> +			goto out_put_dev;
> +	}
> =20
>  	/* no consecutive frame echo skb in flight */
>  	WRITE_ONCE(so->cfecho, 0);
> =20
>  	/* register for echo skb's */
> -	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
> -			isotp_rcv_echo, sk, sock_i_ino(sk), sk);
> +	err =3D can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
> +			      isotp_rcv_echo, sk, sock_i_ino(sk), sk);
> +	if (err) {
> +		if (isotp_register_rxid(so))
> +			can_rx_unregister(net, dev, rx_id, SINGLE_MASK(rx_id),
> +					  isotp_rcv, sk);
> +		goto out_put_dev;
> +	}

[Severity: Medium]
Can this rollback leave the socket permanently wedged or with stale state if
a frame arrives while the second can_rx_register() is running?

In net/can/isotp.c:isotp_bind(), the first can_rx_register() publishes
isotp_rcv to the device's RCU receive list while so->ifindex, so->rxid,
so->txid, and so->bound are still uninitialized (or zero), and then the
second can_rx_register() allocates with GFP_KERNEL. Because isotp_rcv() runs
in softirq without checking so->bound, incoming frames matching rx_id can be
processed during this window:

1. If a First Frame arrives, isotp_rcv() -> isotp_rcv_ff() sets
so->rx.state to ISOTP_WAIT_DATA:

net/can/isotp.c:isotp_rcv_ff() {
	...
	/* initial setup for this pdu reception */
	so->rx.sn =3D 1;
	WRITE_ONCE(so->rx.state, ISOTP_WAIT_DATA);

	/* no creation of flow control frames */
	if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
		return 0;

	/* send our first FC frame */
	isotp_send_fc(sk, ae, ISOTP_FC_CTS);
	return 0;
}

When CAN_ISOTP_LISTEN_MODE is not set, isotp_send_fc() looks up so->ifindex
(which is still 0) and returns before starting so->rxtimer:

net/can/isotp.c:isotp_send_fc() {
	...
	dev =3D dev_get_by_index(sock_net(sk), so->ifindex);
	if (!dev) {
		kfree_skb(nskb);
		return 1;
	}
	...
	hrtimer_start(&so->rxtimer, ktime_set(1, 0), HRTIMER_MODE_REL_SOFT);
	return 0;
}

If the second can_rx_register() then fails with -ENOMEM, can_rx_unregister()
removes isotp_rcv without resetting so->rx.state to ISOTP_IDLE. With
isotp_rcv unregistered and so->rxtimer never armed, so->rx.state stays in
ISOTP_WAIT_DATA forever, causing all future isotp_bind() attempts on the
socket to fail with -EAGAIN:

net/can/isotp.c:isotp_bind() {
	...
	if (READ_ONCE(so->tx.state) !=3D ISOTP_IDLE ||
	    READ_ONCE(so->rx.state) !=3D ISOTP_IDLE) {
		err =3D -EAGAIN;
		goto out;
	}
	...
}

2. If a Single Frame arrives in this window before the second
can_rx_register() fails, isotp_rcv() -> isotp_rcv_sf() queues an skb onto
sk->sk_receive_queue of the unbound socket, which cannot be read while
unbound and would be delivered as stale data if the socket is later bound.

3. Because can_rx_unregister() only schedules deletion via call_rcu(), an
in-flight isotp_rcv() callback can still be running after isotp_bind() drops
lock_sock(sk) and returns an error, racing with subsequent isotp_setsockopt=
()
calls that modify so->opt, so->rxfc, and so->ll without taking so->rx_lock
when so->bound is 0.

Would it make sense to initialize the socket fields before registering the
receivers (or guard isotp_rcv() on so->bound) and ensure any in-flight
receiver and partial RX state are cleaned up on failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025-can-rx-loc=
k-v9-0-7ef2a2b5c2b4@hartkopp.net?part=3D5
