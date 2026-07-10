Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12D43AFD08
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717075; cv=none; b=bJk2qsrQEx2oQWRHkw6AU7K4Ei60isPZTy7Eunt+gYQ9EKs0ynDtIhWnhxiOZ9olHymfXi0yjMjlsMVM8p7sKsP5AF7xFazxfy380ZOHtjtRYOps6+F1/TZEV0LEWA59idRWD58IeY2one60ZT3Xm+XMBwRqACEbsn/8v0IC850=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717075; c=relaxed/simple;
	bh=ps6rXrtwpgYUXgNZhS2dLZbJX14LcwSgsHeN9GCAHcM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aB7D/hIPgtZ5anyXnNDE7jAKJmQg/YUH6X3WcgDJG3EfKzXDy8zC0zhwVw0oeY+GuGB7PlvTp8Nw2Cf0DbgOGnOBOWqDeDWIk1uOTA/wRCt4Lv0v0bEsq2ql3GOuXHXykZYfjmuazHXDVsyx+aMRR1VHRYRhh6wZ5PCbdj2wjmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq4FMST5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq4FMST5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C291F000E9;
	Fri, 10 Jul 2026 20:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717073;
	bh=X5ON+JYzDAd9qRWY+6MIEn6YtZwud3cTwyF7m9UfzTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lq4FMST5fkIHh+zHv7keMylCKElBFyUWgT7J7xEM9qYwPkFjT++yFI4Ghb1l6opSA
	 5OzfkvSFyu1rvhsMykHrTR33T8dqi+VPVclSwDfnJmtXGRzCXVupEFy02pCX0r7Vah
	 jQs1ERz3/svqOxV5OD7NKHXsaPfIKQsLPkK3jyP6J04mHB1HSi2A1HJ82Z4kfIokVg
	 fAtcd08parM2vYuvfPvooZkBjxOE29CQs2AOWpQ83UzQtajlGhfa6dcf39oB94A5Zt
	 eTCzKb9m9kPCBWMKoPU+p0v+Rgcqj0wU8qK2OdDrmV++PzvFAVePkViMJzfTvN9VsL
	 cfTetJJxj/D1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/5] can: isotp: fix lock-free state transition in tx
 timer handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260710-isotp-fixes-v6-4-a13c2539093d@hartkopp.net>
References: <20260710-isotp-fixes-v6-0-a13c2539093d@hartkopp.net>
 <20260710-isotp-fixes-v6-4-a13c2539093d@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 20:57:52 +0000
Message-Id: <20260710205752.A7C291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Early state transition to ISOTP_IDLE in the TX timer handler intro=
duces a race condition that can corrupt the error state of a concurrent tra=
nsmission.

Pre-existing issues:
- [High] A signal during the `isotp_sendmsg()` wait loop can abort another =
thread's active transmission on a shared socket.
--

--- Patch [4]: [PATCH v6 4/5] can: isotp: fix lock-free state transition in=
 tx timer handler ---
commit 3453d78776681a05466b1147a03618091e6287bc
Author: Oliver Hartkopp <socketcan@hartkopp.net>
can: isotp: fix lock-free state transition in tx timer handler

This commit introduces a cmpxchg to safely transition the state machine
to ISOTP_IDLE in the tx timer handler. It ensures the state is only updated
if it hasn't been changed concurrently.

Link: https://lore.kernel.org/linux-can/20260710142146.BDAE61F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 5ef2a610fc172..0826ae8372467 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -939,9 +939,16 @@ static enum hrtimer_restart isotp_tx_timer_handler(s=
truct hrtimer *hrtimer)

[ ... ]

> +	/* Only claim timeout if state is unchanged to avoid overwriting
> +	 * concurrent state updates from isotp_sendmsg/isotp_rcv_echo.
> +	 */
> +	if (cmpxchg(&so->tx.state, old_state, ISOTP_IDLE) !=3D old_state)
>  		return HRTIMER_NORESTART;
> =20
>  	/* we did not get any flow control or echo frame in time */
> @@ -951,8 +958,6 @@ static enum hrtimer_restart isotp_tx_timer_handler(st=
ruct hrtimer *hrtimer)
>  	if (!sock_flag(sk, SOCK_DEAD))
>  		sk_error_report(sk);

[Severity: High]
Does this early state transition to ISOTP_IDLE introduce a race condition?

If the cmpxchg successfully sets the state to ISOTP_IDLE, another thread=20
calling isotp_sendmsg() on a different CPU could see the IDLE state and
immediately start a new transmission before this timer handler completes.

If that happens, the timer thread would resume and execute sk->sk_err =3D E=
COMM
and sk_error_report(sk), which might incorrectly taint the new transmission
with a communication error.

> -	/* reset tx state */
> -	so->tx.state =3D ISOTP_IDLE;
>  	wake_up_interruptible(&so->wait);
> =20
>  	return HRTIMER_NORESTART;

[Severity: High]
This is a pre-existing issue, but can a signal during the wait loop in
isotp_sendmsg() abort another thread's active transmission?

Looking at isotp_sendmsg(), if a concurrent sender fails to acquire the
state and waits:

net/can/isotp.c:isotp_sendmsg()
        err =3D wait_event_interruptible(so->wait, so->tx.state =3D=3D ISOT=
P_IDLE);
        if (err)
                goto err_event_drop;

If a signal interrupts this wait, the thread jumps to err_event_drop where
it unconditionally cancels the timers and resets the state:

err_event_drop:
        hrtimer_cancel(&so->txfrtimer);
        hrtimer_cancel(&so->txtimer);
err_out_drop:
        so->tx.state =3D ISOTP_IDLE;

Since this thread was only waiting and never claimed the state machine, will
this forcefully cancel the active transmission of the thread that actually
owned it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-isotp-fixe=
s-v6-0-a13c2539093d@hartkopp.net?part=3D4
