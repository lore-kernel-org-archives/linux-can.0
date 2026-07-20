Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64A23AC0EF
	for <linux-can@vger.kernel.org>; Mon, 20 Jul 2026 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579345; cv=none; b=GrblpdnWRxY7ux8yrikR6qLtJtJQUILZdJ/PatmFOgjqC0nS6nrCNOiVJIxg8jXrnbk8vPGOyu8l87ShQ1U4p5rKziEvsLrKROHk+O2+4MjQxaaK2qMyuna108q86R+nwuSYPrMGBjz4Cwpp1f4UjI3uDAoXY8nC34hUSm2wYl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579345; c=relaxed/simple;
	bh=1izLxEwDQYVXNKwMfXoDEjEUXBMVY7ooz9yhxHjtRVg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ndYgHJu0xtSSTdZ0Xad9fUDrRQsTKgrXjSf+J8Q5KUesm8pzmEluvbP31isRufmtfAzYNStZ7eKYCkwVjLjzMnPkcMJhzLsVi8ugN3RW8Xclo1NeeSVv65WXaV6EPdhTuMJ9vEFm20KIh10j+s2tu8bwpPOuj7ziBP6xHzxqLys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kokrZqEI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kokrZqEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04D51F000E9;
	Mon, 20 Jul 2026 20:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784579343;
	bh=+5JybmAWjCGTtL8wPmWiC/ha0SoibW7hMxTgsUgPTcg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kokrZqEI4MK3WRwCj320nozrzdn7rMG+isHMkBxndLZM60Y+Xmxz+77exOX6wafZQ
	 B49DOAHV2JAsDiEdIm3XwD4VKThPmhhtwYWg7rJpPwb6yJhfdfGILS2UX+og5t23qn
	 OK3PDPZKupjUBhYlK8p1KzVhI4YFQ7mth5TZhcgmIwfB6jwdyiCcj3dkU8pzo7G4aG
	 bvxrIndoADTE9eFJ6vFUKieaOsiISE4TMeY7dIuVmt45GQhV+UugFgfC/kTUQqUP6f
	 0XE2khxhyYn+CTIhL2R4qw/uHjkQ6wJJXOhlb4ThwMbCoyAhBkqOyKxp03eliyDkcJ
	 sPqXskvQU244Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] can: isotp: fix timer drain order, wakeup handling
 and tx_gen ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260720201518.147685-1-socketcan@hartkopp.net>
References: <20260720201518.147685-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 20:29:02 +0000
Message-Id: <20260720202902.C04D51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The `tx_result` error reporting bypasses `sock_error(sk)`, causing=
 failed transfers to falsely report success and leaving pending errors to f=
alsely fail subsequent successful transfers.

Pre-existing issues:
- [High] The error path after `can_send()` in `isotp_sendmsg()` corrupts th=
e state of concurrent transfers because it unconditionally resets socket st=
ate variables without verifying transfer ownership.
--

--- Patch [1]: [PATCH v4] can: isotp: fix timer drain order, wakeup handlin=
g and tx_gen ordering ---
commit d4c65d9d8cb0a026b681f8438673c3e770b3a2b6
Author: Oliver Hartkopp <socketcan@hartkopp.net>

    can: isotp: fix timer drain order, wakeup handling and tx_gen ordering
   =20
    This patch is a follow-up to commit cf070fe33bfb ("can: isotp: serialize
    TX state transitions under so->rx_lock") which addresses following
    sashiko-bot findings:
   =20
    - isotp_sendmsg(): drain so->txfrtimer first so a stale callback can't
      re-arm echotimer after the claim

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 54becaf6898f1..12719b3afc0de 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c

[ ... ]

> @@ -1229,11 +1279,39 @@ static int isotp_sendmsg(struct socket *sock, str=
uct msghdr *msg, size_t size)
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
> +			return tx_err ? -tx_err : size;
> +		}

[Severity: High]
Does this early return bypass sock_error(sk) and leave sk->sk_err unconsume=
d?

If this thread's transfer times out, isotp_tx_timeout() will set sk->sk_err=
 to
ECOMM. If another thread claims the socket and completes a new transfer bef=
ore
this thread wakes up, tx_result is overwritten with 0 (success).

When this thread eventually wakes up, it sees tx_gen !=3D my_gen and the
generation in tx_result no longer matches my_gen. As a result, tx_err defau=
lts
to 0 and it returns size (success) without calling sock_error(sk), leaving
ECOMM pending in sk->sk_err.

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
Will a subsequent successful transfer falsely fail here?

If a previous transfer left sk->sk_err unconsumed as described above, a
subsequent successful transfer from another thread would hit this sock_erro=
r(sk)
call, consume the pending ECOMM, and falsely return a failure.

>  	}
> =20
>  	return size;

[ ... ]

> @@ -1246,15 +1324,26 @@ static int isotp_sendmsg(struct socket *sock, str=
uct msghdr *msg, size_t size)
>  	spin_lock_bh(&so->rx_lock);
>  	goto err_out_drop_locked;
>  err_event_drop:
> -	/* interrupted waiting on our own transfer - drain its timers */
> +	/* interrupted or shut down while waiting on our own transfer */
>  	spin_lock_bh(&so->rx_lock);
> +
> +	/* new transfer already started by concurrent sendmsg()? */
> +	if (READ_ONCE(so->tx_gen) !=3D my_gen) {
> +		/* don't touch timers and states of the new transfer */
> +		spin_unlock_bh(&so->rx_lock);
> +		return err;
> +	}
> +
>  	hrtimer_cancel(&so->txfrtimer);
>  	hrtimer_cancel(&so->txtimer);
>  	hrtimer_cancel(&so->echotimer);
>  err_out_drop_locked:
>  	/* release the claim; so->rx_lock still held from above */
> -	so->cfecho =3D 0;
> -	so->tx.state =3D ISOTP_IDLE;
> +	WRITE_ONCE(so->cfecho, 0);
> +
> +	/* only claim to IDLE if isotp_release() has not taken over */
> +	if (READ_ONCE(so->tx.state) !=3D ISOTP_SHUTDOWN)
> +		WRITE_ONCE(so->tx.state, ISOTP_IDLE);
>  	spin_unlock_bh(&so->rx_lock);
>  	wake_up_interruptible(&so->wait);
> =20

[Severity: High]
This is a pre-existing issue, but does this unconditionally clobber the sta=
te
of a concurrent transfer?

If a thread gets preempted or delayed for a long time during can_send() whi=
ch
happens earlier in isotp_sendmsg(), isotp_tx_timeout() could fire and reset
the state to ISOTP_IDLE, allowing another thread to claim the socket and be=
gin
a new transfer.

When the original thread resumes, if can_send() returns an error (e.g.,
-ENOBUFS), it will jump directly to err_out_drop_locked:

    err =3D can_send(skb, 1);
    if (err) {
        ...
        goto err_out_drop_locked;
    }

And then blindly clear so->cfecho and set tx.state to ISOTP_IDLE, destroying
the active transfer state of the other thread.

While this patch adds a tx_gen ownership check for err_event_drop, it seems=
 to
have missed adding the same verification for the err_out_drop_locked path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720201518.1476=
85-1-socketcan@hartkopp.net?part=3D1
