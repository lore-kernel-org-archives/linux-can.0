Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAB4432BD3
	for <linux-can@vger.kernel.org>; Tue, 21 Jul 2026 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784619773; cv=none; b=bgSbG7tnAWmCnTQqg3qh2Vgrw0lo9vZK+97aKE4rJcrLTj5o9lG8EqjPX9MC8x8Z9c5ExozV1xgGwGBaZEVIbXZ363NTetWF14VPmzoirYuWTKpmXdS2PSACKKjm92KfGC5H2uyqPKKBM0j8tQHOekoOX7acD06mDp6JcpDSRYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784619773; c=relaxed/simple;
	bh=fSq42Rb9Olx5FkFMFnIPJuv0Dbm0E9xhaH8OXFl8Sy4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YBWjMndj5mY3pokyk3vglnTjqPrSUKTm+c5iQKOJoufqEMPLjPAPmXm3lv4luB7nI7VMrW3Wsi9rf8aI0KMcGRcsPoWyOdKtyVbMqAsjv2mNgRUjG3ttwa4d8GNFfaaBJcWRJRakkkRSxyplTS+qdj8A+AGhdMDCPTLSJ1Y3VB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4xdwfG3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4xdwfG3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE041F000E9;
	Tue, 21 Jul 2026 07:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784619771;
	bh=NDcgTdMq0JoKMVxZv3nEFG5lpBPksV8xALDOFhAml6s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f4xdwfG3rXELPHdLl7PoR+uMsUxuqaOoSldPDtdXVbqTd/sBRjFCK5ff8tb6ou4Lz
	 dtaKQkydho51rnxo1FeF2s6WOZ/OpXGgCTyXOsjoiI/LG6TaAOrh74m9WV5yfhfUVl
	 MNSGzvcsIxpTICg4DdtdNJSbYFvhfi3rmoplA5kRLF8XUsiVQIk7cPl4JSr5Ud27en
	 nkqRgqquVIxi5GeNUGzUqLXT/OxKeFvAvA4OAZYWgV+tkRO9TTI9jO3AMJ9H7VRO2k
	 BJ11QJz/A7F7j0HA3Ih8Z1FiP7Un+9lf6L/M0eMiDvFPceQPm3ysU5vjv9wfRtP97z
	 PKRWWVJKHFDCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] can: isotp: fix timer drain order, wakeup handling
 and tx_gen ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260721073156.10767-1-socketcan@hartkopp.net>
References: <20260721073156.10767-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:42:50 +0000
Message-Id: <20260721074251.4FE041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] A race condition in the timeout handler silently suppresses a vali=
d timeout error for a completed transfer.

Pre-existing issues:
- [High] Error code stealing between concurrent sendmsg calls leads to swap=
ped return values.
--

--- Patch [1]: [PATCH v5] can: isotp: fix timer drain order, wakeup handlin=
g and tx_gen ordering ---
commit 3fafdb07c28c3f6c6f73c64d5f303f8fe37e64b0
Author: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: can: isotp: fix timer drain order, wakeup handling and tx_gen orde=
ring

This commit addresses several findings related to timer drain order, wakeup
handling, and TX generation ordering in isotp_sendmsg(). It serializes state
transitions under the rx_lock and prevents stale callbacks from re-arming
timers.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 54becaf6898f1..4a5897cc21030 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -965,10 +1007,9 @@ static enum hrtimer_restart isotp_tx_timeout(struct=
 isotp_sock *so)
>  	if (cmpxchg(&so->tx.state, old_state, ISOTP_IDLE) !=3D old_state)
>  		return HRTIMER_NORESTART;
> =20
> -	/* we did not get any flow control or echo frame in time */
> -
> +	/* detected timeout: report 'communication error on send' */
>  	if (READ_ONCE(so->tx_gen) =3D=3D gen) {
> -		/* report 'communication error on send' */
> +		WRITE_ONCE(so->tx_result, isotp_pack_tx_result(gen, ECOMM));
>  		sk->sk_err =3D ECOMM;

[Severity: High]
Is there a race condition here that could silently suppress a valid timeout
error for a completed transfer?

In isotp_tx_timeout(), the socket state is locklessly transitioned to
ISOTP_IDLE via cmpxchg(). If a concurrent sendmsg() thread observes the
ISOTP_IDLE state at this exact moment, it could claim the socket and increm=
ent
so->tx_gen.

When the timeout handler resumes and evaluates:
    if (READ_ONCE(so->tx_gen) =3D=3D gen)

The condition would evaluate to false because the generation was bumped. Th=
is
aborts the handler without recording the error in tx_result or sk_err. The
original transferring thread then wakes up, finds no error recorded, and
returns success despite the timeout, leading to silent data loss.

The commit message mentions that the race that can suppress a valid ECOMM
entry is intentionally left for a later change, but since no subsequent pat=
ch
is included to fix this, is this safe to leave as-is?

[ ... ]

> @@ -1223,17 +1273,58 @@ static int isotp_sendmsg(struct socket *sock, str=
uct msghdr *msg, size_t size)
>  			       __func__, ERR_PTR(err));
> =20
>  		spin_lock_bh(&so->rx_lock);
> +
> +		/* new claimed transfer due to a stuck can_send() ? */
> +		if (READ_ONCE(so->tx_gen) !=3D my_gen) {
> +			/* don't touch timers and state of the new transfer */
> +			spin_unlock_bh(&so->rx_lock);
> +			return err;
> +		}
> +
>  		/* no transmission -> no timeout monitoring */
>  		hrtimer_cancel(tx_hrt);
>  		goto err_out_drop_locked;
>  	}
> =20
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
> +			/* drain sk_err and select return value */
> +			err =3D sock_error(sk);
> +			if (!tx_err && err)
> +				tx_err =3D -err;
> +
> +			return tx_err ? -tx_err : size;
> +		}
> +
> +		if (READ_ONCE(so->tx.state) =3D=3D ISOTP_SHUTDOWN) {
> +			/* isotp_release() has taken over the claim */
> +			err =3D -EADDRNOTAVAIL;
> +			goto err_event_drop;
> +		}
> +
>  		err =3D sock_error(sk);
>  		if (err)
>  			return err;

[Severity: High]
This is a pre-existing issue, but does this error checking path lead to
swapped return values between concurrent sendmsg() calls?

If Thread 1 completes a successful transfer but is delayed from waking up,
Thread 2 can claim the socket, start a new transfer, time out, and set
sk->sk_err =3D ECOMM.

When Thread 1 then wakes up, it sees its generation no longer matches
(so->tx_gen !=3D my_gen), and it calls sock_error(sk) in the fallback block:

    err =3D sock_error(sk);
    if (!tx_err && err)
        tx_err =3D -err;

Because sock_error() internally consumes the error via xchg(), Thread 1
effectively steals Thread 2's error and incorrectly returns -ECOMM.

Later, when Thread 2 wakes up and calls sock_error(sk) on the normal
error checking path:

    err =3D sock_error(sk);
    if (err)
        return err;

It gets 0, leading it to falsely return success for its failed transfer.
Could this corrupt the application's view of the network state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721073156.1076=
7-1-socketcan@hartkopp.net?part=3D1
